import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_ffb/data/datasource/firebase_remote_datasource.dart';
import 'package:flutter_chat_ffb/data/datasource/firebase_remote_datasource_impl.dart';
import 'package:flutter_chat_ffb/data/local_datasource/local_datasource.dart';
import 'package:flutter_chat_ffb/data/repositories/firebase_repository_impl.dart';
import 'package:flutter_chat_ffb/data/repositories/get_device_number_repository_impl.dart';
import 'package:flutter_chat_ffb/domain/repositories/firebase_repository.dart';
import 'package:flutter_chat_ffb/domain/repositories/get_device_number_repository.dart';
import 'package:flutter_chat_ffb/domain/usecases/add_to_my_chat_usecase.dart';
import 'package:flutter_chat_ffb/domain/usecases/create_one_to_one_chat_channel_usecase.dart';
import 'package:flutter_chat_ffb/domain/usecases/get_all_user_usecase.dart';

import 'package:flutter_chat_ffb/domain/usecases/get_create_current_user_usecase.dart';
import 'package:flutter_chat_ffb/domain/usecases/get_current_uid_usecase.dart';
import 'package:flutter_chat_ffb/domain/usecases/get_device_numbers_usecase.dart';
import 'package:flutter_chat_ffb/domain/usecases/get_my_chat_usecase.dart';
import 'package:flutter_chat_ffb/domain/usecases/get_one_to_one_single_user_chat_channel_usecase.dart';
import 'package:flutter_chat_ffb/domain/usecases/get_text_messages_usecase.dart';

import 'package:flutter_chat_ffb/domain/usecases/is_sign_in_usecase.dart';
import 'package:flutter_chat_ffb/domain/usecases/send_text_message_usecase.dart';

import 'package:flutter_chat_ffb/domain/usecases/sign_in_with_phone_number_usecase.dart';
import 'package:flutter_chat_ffb/domain/usecases/sign_out_usecase.dart';
import 'package:flutter_chat_ffb/domain/usecases/verify_phone_number_usecase.dart';
import 'package:flutter_chat_ffb/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_chat_ffb/presentation/cubit/get_device_number/get_device_numbers_cubit.dart';

import 'package:flutter_chat_ffb/presentation/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:flutter_chat_ffb/presentation/cubit/user/user_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //Futures bloc
  sl.registerFactory<AuthCubit>(() => AuthCubit(
        signOutUseCase: sl.call(),
        isSignInUseCase: sl.call(),
        getCurrentUidUseCase: sl.call(),
      ));
  sl.registerFactory<PhoneAuthCubit>(() => PhoneAuthCubit(
        getCreateCurrentUserUseCase: sl.call(),
        signInWithPhoneNumberUseCase: sl.call(),
        verifyPhoneNumberUseCase: sl.call(),
      ));

  sl.registerFactory<GetDeviceNumbersCubit>(
      () => GetDeviceNumbersCubit(getDeviceNumberUseCase: sl.call()));

  sl.registerFactory<UserCubit>(() => UserCubit(
        createOneToOneChatChannelUseCase: sl.call(),
        getAllUserUseCase: sl.call(),
      ));

  //useCase
  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInWithPhoneNumberUseCase>(
      () => SignInWithPhoneNumberUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<VerifyPhoneNumberUseCase>(
      () => VerifyPhoneNumberUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetAllUserUseCase>(
      () => GetAllUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetMyChatUseCase>(
      () => GetMyChatUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetTextMessagesUseCase>(
      () => GetTextMessagesUseCase(repository: sl.call()));
  sl.registerLazySingleton<SendTextMessageUseCase>(
      () => SendTextMessageUseCase(repository: sl.call()));
  sl.registerLazySingleton<AddToMyChatUseCase>(
      () => AddToMyChatUseCase(repository: sl.call()));
  sl.registerLazySingleton<CreateOneToOneChatChannelUseCase>(
      () => CreateOneToOneChatChannelUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetOneToOneSingleUserChatChannelUseCase>(
      () => GetOneToOneSingleUserChatChannelUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetDeviceNumberUseCase>(
      () => GetDeviceNumberUseCase(deviceNumberRepository: sl.call()));
  // repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));
  sl.registerLazySingleton<GetDeviceNumberRepository>(
      () => GetDeviceNumberRepositoryImpl(
            localDataSource: sl.call(),
          ));

  //remote data
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
      () => FirebaseRemoteDataSourceImpl(
            auth: sl.call(),
            fireStore: sl.call(),
          ));
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
  //External

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}
