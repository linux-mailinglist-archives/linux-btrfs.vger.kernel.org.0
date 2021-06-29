Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F0E3B779C
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 20:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbhF2SJI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 14:09:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46153 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbhF2SJB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 14:09:01 -0400
Received: from mail-ej1-f72.google.com ([209.85.218.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lyI80-0005oK-5W
        for linux-btrfs@vger.kernel.org; Tue, 29 Jun 2021 18:06:32 +0000
Received: by mail-ej1-f72.google.com with SMTP id p20-20020a1709064994b02903cd421d7803so6041028eju.22
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jun 2021 11:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1sVQNHAiS/W2i5o2hr99eStOUpYVcSh7ZDin7Mpc0cU=;
        b=ViUm1T5YDmd8Nzn8GQVro3FvxzIrHiTaiNYvyY0RSHxT3yG6ruhWdAoJheJH2of71q
         KgSa4ceGe2LophawTeprhiPzM3AbT9ObHC3FtBXxQrzMfK8SDecPjE7J6RRtowz6xDlL
         a465jU/+r35bHQGOmajegVtRuQfgpee/VSSyXAlO9Y2E51qqXnPvuX3pXhIaTP7ws/gu
         8N4gZkER51sEupgI2c3RhhtcdoD0TZVJi8SYkTRD+row0E9I/I1/EyIDBNPcWBd58SVk
         BLArcDgdiUg0xraX0NSN26x7iwVSoklSJ9UBEL/5T2XP/5shMF9wOUFKqfGGdBkhfWPW
         kzKw==
X-Gm-Message-State: AOAM530DQoAQLipvKrQi7oSYe/h52M7FX87M3KMyGqaWA69b94Rjdl4f
        btUS2bnLM69j++kWuzg+G3vh+S8Ev5bmpei2rY0OS/cXx9FJ93ILylFrpXzIjJB2yzlr35zAlXU
        1CkeSgeR06atKmcqJMh+EBg0Q6eN5srJuMnmMFkQm
X-Received: by 2002:a50:935a:: with SMTP id n26mr42276820eda.8.1624989991236;
        Tue, 29 Jun 2021 11:06:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTuOakoVILBoO7OTyCnoSp6AApNCYVL4pAvYGfXG5VRBZx+0rJbjTvqZHj1Uvtttw8JTlYRw==
X-Received: by 2002:a50:935a:: with SMTP id n26mr42276796eda.8.1624989991101;
        Tue, 29 Jun 2021 11:06:31 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id e13sm6969604ejl.98.2021.06.29.11.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 11:06:30 -0700 (PDT)
Subject: Re: [BUG] btrfs potential failure on 32 core LTP test (fallocate05)
To:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kernel-team@lists.ubuntu.com" <kernel-team@lists.ubuntu.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>
References: <a3b42abc-6996-ab06-ea9f-238e7c6f08d7@canonical.com>
 <124d7ead-6600-f369-7af1-a1bc27df135c@toxicpanda.com>
 <667133e5-44cb-8d95-c40a-12ac82f186f0@canonical.com>
 <0b6a502a-8db8-ef27-f48e-5001f351ef24@toxicpanda.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <2576a472-1c99-889a-685c-a12bbfb08052@canonical.com>
Date:   Tue, 29 Jun 2021 20:06:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0b6a502a-8db8-ef27-f48e-5001f351ef24@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/06/2021 19:28, Josef Bacik wrote:
> On 6/29/21 1:26 PM, Krzysztof Kozlowski wrote:
>> On 29/06/2021 19:24, Josef Bacik wrote:
>>> On 6/29/21 1:00 PM, Krzysztof Kozlowski wrote:
>>>> Dear BTRFS folks,
>>>>
>>>> I am hitting a potential regression of btrfs, visible only with
>>>> fallocate05 test from LTP (Linux Test Project) only on 32+ core Azure
>>>> instances (x86_64).
>>>>
>>>> Tested:
>>>> v5.8 (Ubuntu with our stable patches): PASS
>>>> v5.11 (Ubuntu with our stable patches): FAIL
>>>> v5.13 mainline: FAIL
>>>>
>>>> PASS means test passes on all instances
>>>> FAIL means test passes on other instance types (e.g. 4 or 16 core) but
>>>> fails on 32 and 64 core instances (did not test higher),
>>>> e.g.: Standard_F32s_v2, Standard_F64s_v2, Standard_D32s_v3,
>>>> Standard_E32s_v3
>>>>
>>>> Reproduction steps:
>>>> git clone https://github.com/linux-test-project/ltp.git
>>>> cd ltp
>>>> ./build.sh && make install -j8
>>>> cd ../ltp-install
>>>> sudo ./runltp -f syscalls -s fallocate05
>>>>
>>>> Failure output:
>>>> tst_test.c:1379: TINFO: Testing on btrfs
>>>> tst_test.c:888: TINFO: Formatting /dev/loop4 with btrfs opts='' extra opts=''
>>>> tst_test.c:1311: TINFO: Timeout per run is 0h 05m 00s
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file0 size 21710183
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file1 size 8070086
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file2 size 3971177
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file3 size 36915315
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file4 size 70310993
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file5 size 4807935
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file6 size 90739786
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file7 size 76896492
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file8 size 72228649
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file9 size 36207821
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file10 size 81483962
>>>> tst_fill_fs.c:59: TINFO: write(): ENOSPC (28)
>>>> fallocate05.c:81: TPASS: write() wrote 65536 bytes
>>>> fallocate05.c:102: TINFO: fallocate()d 0 extra blocks on full FS
>>>> fallocate05.c:114: TPASS: fallocate() on full FS
>>>> fallocate05.c:130: TPASS: fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)
>>>> fallocate05.c:134: TFAIL: write(): ENOSPC (28)
>>>>
>>>> Test code:
>>>> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/fallocate/fallocate05.c#L134
>>>>
>>>> See also: https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/1933112
>>>>
>>>> Other FS tests succeed on that machines/kernels. Other file systems
>>>> also pass - only btrfs fails. The issue was not bisected. Full test
>>>> log attached.
>>>>
>>>
>>> Also it looks like you're using a loop device, the instructions you gave me
>>> aren't complete enough for me to reproduce.  What is the actual setup you are
>>> using?  How big is your loop device?  Is it a backing device?  I had to do -b
>>> <device> to get the test to even start to run, but I've got a 2tib ssd, am I
>>> supposed to be using something else?  Thanks,
>>
>> The test takes care about loop device, nothing is needed from your side.
>> Just run the test and wait till you see:
>> "tst_test.c:1379: TINFO: Testing on btrfs"
>>
>> That's where the interesting part starts :)
>>
> 
> *cough*
> # CONFIG_BLK_DEV_LOOP is not set
> *cough*
> 
> I think I found the problem, my bad,
> 

Minor update - it's not only Azure's. AWS m5.8xlarge and m5.16xlarge (32
and 64 cores) fail similarly. I'll try later also QEMU machines with
different amount of CPUs.

Best regards,
Krzysztof
