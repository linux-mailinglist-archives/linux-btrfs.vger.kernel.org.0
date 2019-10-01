Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8F83C2D86
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 08:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbfJAGhk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 02:37:40 -0400
Received: from birdy.pmhahn.de ([88.198.22.186]:58928 "EHLO birdy.pmhahn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfJAGhj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Oct 2019 02:37:39 -0400
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Oct 2019 02:37:37 EDT
Received: from [172.16.0.165] (82-198-197-172.briteline.de [82.198.197.172])
        by birdy.pmhahn.de (Postfix) with ESMTPSA id 7C32822018BA;
        Tue,  1 Oct 2019 08:28:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pmhahn.de; s=201711;
        t=1569911282; bh=3EXWvSaaXvG7oKtaQpnh1hc+qNmf5/9M55GfMVUbW3g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=u5LQ4Ysjj5fwSRcht/pL0swyBZbzKe1hRAc1YkEI3jfxODjkhLPq2T9HIbb8WlP8L
         7/LfvrNQw4QJmH015E+h0F6CVe1Au0P0j98t9DhjHTAzQlsyjBUQiy0Rpmgzk3jKfc
         CUN2BE7488XE6Ep+M1pL6XGY9bxNrRuZYjKZpB6Y=
Subject: Re: [PATCH] Setup GitLab-CI for btrfs-progs
To:     "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.com>,
        linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, thecybershadow@gmail.com, wqu@suse.com,
        lakshmipathi.g@giis.co.in
References: <20190930165622.GA25114@giis.co.in>
From:   Philipp Hahn <pmhahn+btrfs@pmhahn.de>
Openpgp: preference=signencrypt
Autocrypt: addr=pmhahn+btrfs@pmhahn.de; prefer-encrypt=mutual; keydata=
 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
 cxgvIR6zhbM=
Message-ID: <1ecbc32d-9f28-b0f5-bf2d-8ceee12d6404@pmhahn.de>
Date:   Tue, 1 Oct 2019 08:02:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190930165622.GA25114@giis.co.in>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'm not yet a GitLab expert myself, but AFAIK ...

Am 30.09.19 um 18:56 schrieb Lakshmipathi.G:
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> new file mode 100644
> index 0000000..2afde50
> --- /dev/null
> +++ b/.gitlab-ci.yml
> @@ -0,0 +1,181 @@
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public
> +# License v2 as published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +# General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public
> +# License along with this program; if not, write to the
> +# Free Software Foundation, Inc., 59 Temple Place - Suite 330,
> +# Boston, MA 021110-1307, USA.
> +#
> +
> +image: docker:18.09.7
> +
> +services:
> +    - docker:18.09.7-dind
> +
> +variables:
> +  DOCKER_DRIVER: overlay2
> +
> +stages:
> +  - build
> +  - btrfs-progs build
> +  - test
> +
> +variables:

You already have a "variables" section above - merge them?

> +  DOCKER_DRIVER: overlay2
> +  IMAGE_TAG: registry.gitlab.com/$CI_PROJECT_NAMESPACE/btrfs-progs:gitlab-ci
> +
> +before_script:
> +   - docker login --username $CI_REGISTRY_USER --password $CI_REGISTRY_PASSWORD $CI_REGISTRY
> +
> +docker build:
> +  stage: build
> +  script:
> +    - cd gitlab-ci
> +    - docker pull $IMAGE_TAG > /dev/null && echo "Downloaded image" || ( docker build -t $IMAGE_TAG . && docker push $IMAGE_TAG )
> +    - cd ..
> +
> +## To enable or disable Kernel Build set BUILD_KERNEL: "1" or BUILD_KERNEL: "0" 
> +## If you disable Kernel Build, make sure PREBUILT_KERNEL_ID points to previously built the kernel job id.
> +
> +kernel build:
> +  variables:
> +    BUILD_KERNEL: "1"
> +    PREBUILT_KERNEL_ID: "288159334"
> +  before_script:
> +    - apk add curl unzip 
> +  stage: build
> +  services:
> +    - docker:18.09.7-dind

You already have "services" defined globally - no need to repeat that
here again.

> +  script:
> +     - if [ "$BUILD_KERNEL" == "1" ]; then
> +         docker run --cap-add SYS_PTRACE --cap-add sys_admin --privileged --device=/dev/kvm -v $PWD:/repo $IMAGE_TAG /repo/gitlab-ci/kernel_build.sh;
> +       else
> +         curl -o bzImage.zip --location --header "JOB-TOKEN:$CI_JOB_TOKEN"  "https://gitlab.com/api/v4/projects/$CI_PROJECT_ID/jobs/$PREBUILT_KERNEL_ID/artifacts" && unzip bzImage.zip;
> +       fi;
> +  artifacts:
> +    when: always
> +    paths:
> +      - bzImage
> +
> +# To enable or disable image build update BUILD_IMAGE value to "1" or "0".
> +# If you disable Image Build, make sure PREBUILT_IMAGE_ID points to previously built rootfs job id.
> + 
> +image build:
> +  variables:
> +    BUILD_IMAGE: "1"
> +    PREBUILT_IMAGE_ID: "288506168"
> +  before_script:
> +    - apk add curl unzip 
> +  stage: build
> +  services:
> +    - docker:18.09.7-dind

dito

> +  script:
> +     - if [ "$BUILD_IMAGE" == "1" ]; then
> +          docker run --cap-add SYS_PTRACE --cap-add sys_admin --privileged --device=/dev/kvm -v $PWD:/repo $IMAGE_TAG /repo/gitlab-ci/setup_image.sh;
> +       else
> +          curl  -o qemu-image.img.zip --location --header "JOB-TOKEN:$CI_JOB_TOKEN" "https://gitlab.com/api/v4/projects/$CI_PROJECT_ID/jobs/$PREBUILT_IMAGE_ID/artifacts" && unzip qemu-image.img.zip;
> +       fi;
> +  artifacts:
> +    when: always
> +    paths:
> +      - qemu-image.img
> +
> +btrfs-progs build:
> +  stage: btrfs-progs build
> +  services:
> +    - docker:18.09.7-dind

dito

> +  script:
> +     - docker run --cap-add SYS_PTRACE --cap-add sys_admin --privileged --device=/dev/kvm -v $PWD:/repo $IMAGE_TAG /repo/gitlab-ci/run_tests.sh
> +  artifacts:
> +    expire_in: 1 week
> +    when: always
> +    paths:
> +      - qemu-image.img
> +
> +cli tests:
> +  stage: test
> +  services:
> +    - docker:18.09.7-dind

dito

> +  script:
> +     - echo "./cli-tests.sh" > $PWD/cmd
> +     - docker run --cap-add SYS_PTRACE --cap-add sys_admin --privileged --device=/dev/kvm -v $PWD:/repo $IMAGE_TAG /repo/gitlab-ci/run_tests.sh
> +     - test -e "result" || exit 1 # If result doesn't exists, job failed.
> +  artifacts:
> +    when: always
> +    paths:
> +      - "*tests-results.txt"
> +
> +convert tests:
> +  only: 
> +    - devel
> +  stage: test
> +  services:
> +    - docker:18.09.7-dind

dito

> +  script:
> +     - echo "./convert-tests.sh" > $PWD/cmd
> +     - docker run --cap-add SYS_PTRACE --cap-add sys_admin --privileged --device=/dev/kvm -v $PWD:/repo $IMAGE_TAG /repo/gitlab-ci/run_tests.sh
> +     - test -e "result" || exit 1
> +  artifacts:
> +    when: always
> +    paths:
> +      - "*tests-results.txt"
> +
> +fsck tests:
> +  stage: test
> +  services:
> +    - docker:18.09.7-dind

dito

> +  script:
> +     - echo "./fsck-tests.sh" > $PWD/cmd
> +     - docker run --cap-add SYS_PTRACE --cap-add sys_admin --privileged --device=/dev/kvm -v $PWD:/repo $IMAGE_TAG /repo/gitlab-ci/run_tests.sh
> +     - test -e "result" || exit 1
> +  artifacts:
> +    when: always
> +    paths:
> +      - "*tests-results.txt"
> +      - error.log
> +
> +fuzz tests:
> +  stage: test
> +  services:
> +    - docker:18.09.7-dind

dito

> +  script:
> +     - echo "./fuzz-tests.sh" > $PWD/cmd
> +     - docker run --cap-add SYS_PTRACE --cap-add sys_admin --privileged --device=/dev/kvm -v $PWD:/repo $IMAGE_TAG /repo/gitlab-ci/run_tests.sh
> +     - test -e "result" || exit 1
> +  artifacts:
> +    when: always
> +    paths:
> +      - "*tests-results.txt"
> +
> +misc tests:
> +  stage: test
> +  services:
> +    - docker:18.09.7-dind

dito

> +  script:
> +     - echo "./misc-tests.sh" > $PWD/cmd
> +     - docker run --cap-add SYS_PTRACE --cap-add sys_admin --privileged --device=/dev/kvm -v $PWD:/repo $IMAGE_TAG /repo/gitlab-ci/run_tests.sh
> +     - test -e "result" || exit 1
> +  artifacts:
> +    when: always
> +    paths:
> +      - "*tests-results.txt"
> +
> +mkfs tests:
> +  stage: test
> +  services:
> +    - docker:18.09.7-dind

dito

> +  script:
> +     - echo "./mkfs-tests.sh" > $PWD/cmd
> +     - docker run --cap-add SYS_PTRACE --cap-add sys_admin --privileged --device=/dev/kvm -v $PWD:/repo $IMAGE_TAG /repo/gitlab-ci/run_tests.sh
> +     - test -e "result" || exit 1
> +  artifacts:
> +    when: always
> +    paths:
> +      - "*tests-results.txt"
> +

Philipp
