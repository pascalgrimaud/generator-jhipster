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
const statistics = require('../statistics');
const packagejs = require('../../package.json');
const constants = require('../generator-constants');

module.exports = class extends BaseGenerator {
    constructor(args, opts) {
        super(args, opts);
        this.registerPrettierTransform();
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
                this.baseName = configuration.get('baseName');
                this.dasherizedBaseName = _.kebabCase(this.baseName);
                this.humanizedBaseName = _.startCase(this.baseName);
                this.packageName = this.config.get('packageName');
            }
        };
    }
    get prompting() {
        return {
            askPackage: prompts.askPackage,
            askModuleName: prompts.askForModuleName,
        };
    }

    get configuring() {
        return {
            setup() {
                // Update jhipsterVersion.
                this.jhipsterConfig.jhipsterVersion = packagejs.version;
            },
        };
    }

    writing() {
        this.template('pom.xml.ejs', 'pom.xml');
    }
};