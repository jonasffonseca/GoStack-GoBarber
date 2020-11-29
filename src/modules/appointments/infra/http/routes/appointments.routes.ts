import { Router } from 'express';
import AppointmentsController from '../controllers/AppointmentsController';
import ensureAuthenticated from '@modules/users/infra/http/middlewares/ensureAuthenticated';
const appointmentsRouter = Router();
const appointmentsController = new AppointmentsController();

appointmentsRouter.use(ensureAuthenticated);
// appointmentsRouter.get('/', async (request, response) => {
//   console.log(request.user);
// const appointmentsRepository = container.resolve(AppointmentsRepository);

//   const appointments = await appointmentsRepository.find();
//   return response.json(appointments);
// });

appointmentsRouter.post('/', appointmentsController.create);
export default appointmentsRouter;
