import { container } from 'tsyringe';
import mailConfig from '@config/mail';

import IStorageProvider from '../providers/StorageProvider/models/IStorageProvider';
import DiskStorageProvider from '../providers/StorageProvider/implementations/DiskStorageProvider';
import IMailProvider from '../providers/MailProvider/models/IMailProvider';
import EtherealMailProvider from '../providers/MailProvider/implementations/EtherealMailProvider';
import SESMailProvider from '../providers/MailProvider/implementations/SESMailProvider';
import IMailTemplateProvider from '../providers/MailTemplateProvider/models/IMailTemplateProvider';
import HandlebarsMailTemplateProvider from '../providers/MailTemplateProvider/implementations/HandlebarsMailTemplateProvider';

container.registerSingleton<IStorageProvider>(
  'StorageProvider',
  DiskStorageProvider,
);
container.registerSingleton<IMailTemplateProvider>(
  'MailTemplateProvider',
  HandlebarsMailTemplateProvider,
);

container.registerInstance<IMailProvider>(
  'MailProvider',
  mailConfig.driver === 'ethereal'
    ? container.resolve(EtherealMailProvider)
    : container.resolve(SESMailProvider),
);
