/**
 * Copyright 2013-2021 the original author or authors from the JHipster project.
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

const { serverDefaultConfig } = require('../generator-defaults');

module.exports = {
  askPackageName,
};
 
async function askPackageName() {
  if (this.abort) return;
  const answer = await this.prompt({
    type: 'input',
    name: 'packageName',
    validate: input =>
      /^([a-z_]{1}[a-z0-9_]*(\.[a-z_]{1}[a-z0-9_]*)*)$/.test(input)
        ? true
        : 'The package name you have provided is not a valid Java package name.',
    message: 'What is your default Java package name?',
    default: serverDefaultConfig.packageName,
    store: true,
  });
  this.packageName = answer.packageName;
}