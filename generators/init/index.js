/**
 * Copyright 2013-2020 the original author or authors from the JHipster project.
 *
 * This file is part of the JHipster project, see https://www.jhipster.tech/
 * for more information.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
const chalk = require('chalk');
const _ = require('lodash');
const prompts = require('./prompts');
const BaseGenerator = require('../generator-base');
const packagejs = require('../../package.json');
const dependabotPackagejs = require('./templates/package.json');
const constants = require('../generator-constants');

module.exports = class extends BaseGenerator {
  constructor(args, opts) {
    super(args, opts);
  }

  get initializing() {
    return {
      validateFromCli() {
        this.checkInvocationFromCLI();
      },
      sayHello() {
        this.log(chalk.white('⬢ Welcome to the JHipster Hexagonal Architecture ⬢'));
      },
      getConfig() {
        this.jhipsterVersion = packagejs.version;
        const configuration = this.config;
        // this.packageName = configuration.get('packageName');
        this.baseName = configuration.get('baseName');
        this.dasherizedBaseName = _.kebabCase(this.baseName);
        this.humanizedBaseName = _.startCase(this.baseName);
        this.dependencies = packagejs.dependencies;
        this.dependabotDependencies = dependabotPackagejs.devDependencies;
      },
      initConstant() {
        this.NODE_VERSION = constants.NODE_VERSION;
      }
    };
  }

  // _loading() {
  //   return {
  //     loadPackageJson() {
  //       // The installed prettier version should be the same that the one used during JHipster generation to avoid formatting differences
  //       _.merge(this.dependabotPackageJson, {
  //         devDependencies: {
  //           prettier: packageJson.dependencies.prettier,
  //           'prettier-plugin-java': packageJson.dependencies['prettier-plugin-java'],
  //           'prettier-plugin-packagejson': packageJson.dependencies['prettier-plugin-packagejson'],
  //         },
  //       });

  //       // Load common package.json into packageJson
  //       _.merge(this.dependabotPackageJson, this.fs.readJSON(this.fetchFromInstalledJHipster('init', 'templates', 'package.json')));
  //     },
  //   };
  // }

  // get loading() {
  //   return this._loading();
  // }

  get prompting() {
    return {
      askPackageName: prompts.askPackageName,
      askBaseName: prompts.askBaseName,
    };
  }

  get configuring() {
    return {
      setup() {
        this.jhipsterConfig.jhipsterVersion = packagejs.version;
        this.jhipsterConfig.packageName = this.packageName;
        this.jhipsterConfig.baseName = this.baseName;
        this.dasherizedBaseName = _.kebabCase(this.baseName);
        this.humanizedBaseName = _.startCase(this.baseName);
      },
    };
  }

  writing() {
    // editor
    this.template('editorconfig.ejs', '.editorconfig');

    // git
    this.template('gitattributes.ejs', '.gitattributes');
    this.template('gitignore.ejs', '.gitignore');

    // husky / prettier
    this.template('.huskyrc.ejs', '.huskyrc');
    this.template('.lintstagedrc.js.ejs', '.lintstagedrc.js')
    this.template('.prettierignore.ejs', '.prettierignore');
    this.template('.prettierrc.ejs', '.prettierrc');

    // package.json
    this.template('package.json.ejs', 'package.json');

    // README.md
    this.template('README.md.ejs', 'README.md');
  }
};
