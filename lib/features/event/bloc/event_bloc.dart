import 'dart:async';

import 'package:alumni_hub_ft_uh/features/event/domain/event_repository.dart';
import 'package:alumni_hub_ft_uh/features/event/domain/models/event_get_many_model.dart';
import 'package:alumni_hub_ft_uh/features/event/domain/models/event_get_one_model.dart';
import 'package:alumni_hub_ft_uh/features/event/domain/models/event_model.dart';
import 'package:alumni_hub_ft_uh/middleware/custom_exception.dart';
import 'package:bloc/bloc.dart';
import 'package:cached_query/cached_query.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'event_event.dart';
part 'event_state.dart';

@injectable
class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository _eventRepository;

  EventBloc(this._eventRepository) : super(EventState()) {
    on<EventFetched>(_onEventFetched);
    on<EventRefreshed>(_onEventRefreshed);
    on<EventNextPage>(_onEventNextPage);
    on<EventToggleRegister>(_onEventToggleRegister);
    on<EventGetOne>(_onEventGetOne);
  }

  FutureOr<void> _onEventFetched(EventFetched event, Emitter<EventState> emit) {
    return emit.forEach<InfiniteQueryState<EventGetManyModelResponse>>(
        _eventRepository
            .getEvents(
              EventGetManyParams(
                search: state.search,
              ),
            )
            .stream, onData: (queryState) {
      return state.copyWith(
        status: queryState.status == QueryStatus.loading
            ? EventStatus.loading
            : queryState.status == QueryStatus.error
                ? EventStatus.error
                : EventStatus.loaded,
        events:
            queryState.data?.expand((page) => page.data.data).toList() ?? [],
        error: CustomException(queryState.error?.message ?? 'Unknown error'),
      );
    });
  }

  FutureOr<void> _onEventRefreshed(
      EventRefreshed event, Emitter<EventState> emit) {
    if (event.isClear) {
      state.events.clear();
      state.search = null;
    }
    final query = _eventRepository.getEvents(
      EventGetManyParams(
        search: state.search,
      ),
    );
    query.refetch();
    return _onEventFetched(EventFetched(), emit);
  }

  FutureOr<void> _onEventNextPage(
      EventNextPage event, Emitter<EventState> emit) {
    _eventRepository
        .getEvents(
          EventGetManyParams(
            search: state.search,
          ),
        )
        .getNextPage();
  }

  FutureOr<void> _onEventGetOne(EventGetOne event, Emitter<EventState> emit) {
    return emit.forEach<QueryState<EventGetOneModelResponse>>(
        _eventRepository.getEvent(event.idEvent).stream, onData: (queryState) {
      return state.copyWith(
        selectedEventStatus: queryState.status == QueryStatus.loading
            ? EventStatus.loading
            : queryState.status == QueryStatus.error
                ? EventStatus.error
                : EventStatus.loaded,
        selectedEvent: queryState.data?.data,
        error: CustomException(queryState.error?.message ?? 'Unknown error'),
      );
    });
  }

  FutureOr<void> _onEventToggleRegister(
      EventToggleRegister event, Emitter<EventState> emit) async {
    final mutation = _eventRepository.toggleRegisterEvent();
    await mutation.mutate(event.idEvent);

    _eventRepository.getEvent(event.idEvent).refetch();

    add(EventGetOne(event.idEvent));
  }
}
