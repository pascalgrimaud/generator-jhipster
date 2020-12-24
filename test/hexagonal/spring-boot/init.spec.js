const path = require('path');
const assert = require('yeoman-assert');
const helpers = require('yeoman-test');
const fse = require('fs-extra');
const getFilesForOptions = require('./utils/utils').getFilesForOptions;
const expectedFiles = require('./utils/expected-files');
const shouldBeV3DockerfileCompatible = require('./utils/utils').shouldBeV3DockerfileCompatible;
const constants = require('../generators/generator-constants');
const angularFiles = require('../generators/client/files-angular').files;
const reactFiles = require('../generators/client/files-react').files;

const ANGULAR = constants.SUPPORTED_CLIENT_FRAMEWORKS.ANGULAR;
const REACT = constants.SUPPORTED_CLIENT_FRAMEWORKS.REACT;
const CLIENT_MAIN_SRC_DIR = constants.CLIENT_MAIN_SRC_DIR;
const SERVER_MAIN_SRC_DIR = constants.SERVER_MAIN_SRC_DIR;
const SERVER_MAIN_RES_DIR = constants.SERVER_MAIN_RES_DIR;
const TEST_DIR = constants.TEST_DIR;

describe('JHipster Hexagonal Spring Boot', () => {
  context('Init', () => {
    describe('Default application', () => {
      before(() => {
        return helpers
          .create(path.join(__dirname, '../generators/hegaxonal-spring-boot-init'))
          .withOptions({ fromCli: true, skipInstall: true, skipChecks: true, jhiPrefix: 'test', withGeneratedFlag: true })
          .withPrompts({
            baseName: 'jhipster',
            packageName: 'com.mycompany.myapp',
            packageFolder: 'com/mycompany/myapp',
          })
          .run();
      });

      it('creates expected default files for angularX', () => {
        assert.file('pom.xml');
      });
    });
  });
});
