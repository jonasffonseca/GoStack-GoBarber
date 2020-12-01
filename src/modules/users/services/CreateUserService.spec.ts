import FakeUsersRepository from '@modules/users/repositories/fakes/FakeUsersRepository';
import FakeHashProvider from '@modules/users/providers/HashProvider/fakes/FakeHashProvider';
import AppError from '@shared/errors/AppError';
import CreateUserService from './CreateUserService';

describe('CreateUser', () => {
  it('should be able to create a new user', async () => {
    const fakeUsersRepository = new FakeUsersRepository();
    const fakeHashProvider = new FakeHashProvider();
    const createUser = new CreateUserService(
      fakeUsersRepository,
      fakeHashProvider,
    );
    const user = await createUser.execute({
      name: 'John Doe',
      email: 'john@doe.com',
      password: '12345678',
    });
    expect(user).toHaveProperty('id');
  });
  it('should not be able to create user with same email', async () => {
    const fakeUsersRepository = new FakeUsersRepository();
    const fakeHashProvider = new FakeHashProvider();

    const createUser = new CreateUserService(
      fakeUsersRepository,
      fakeHashProvider,
    );
    await createUser.execute({
      name: 'John Doe',
      email: 'john@doe.com',
      password: '12345678',
    });
    expect(
      createUser.execute({
        name: 'John Doe',
        email: 'john@doe.com',
        password: '12345678',
      }),
    ).rejects.toBeInstanceOf(AppError);
  });
});
