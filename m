Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00553C7F6D
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 09:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbhGNHg5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 03:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbhGNHg5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 03:36:57 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7DCC06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 00:34:05 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 21so1262579pfp.3
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 00:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MPz1fjOqz0txIzzJTqZt+Y+SrOdziovB7RbYKIdssgo=;
        b=tMkOGmEop4XyA62SiU+UzTXqgnqrchkNsOuLLHrmPq3EYXASahPOYrwnPRmznm8dVH
         IBQLr52mz3xEBYpT56yqq67IoYz6r7vU5NeFKJCCTeCUqePgQZj/yR+Lw0d3K8yToRsR
         PyoL1Jlc47ddIHCP15ks6k87P5RxbURNCWAzD6xiWhElKUN0LKBYQBSgn2RW6rLhz47J
         C6DRbNWuyha/eULBIivxQbBjHTILHhczn1omwt85YWaMGBvbbX26nJ7iWIsqPtUEe4Ev
         nBVAN3uPjE1m48jtIBGhWqaJ49iZSnecbdcINaTblVZf5Cq/DhdSyGxGZSeuxbEiOquh
         ZlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MPz1fjOqz0txIzzJTqZt+Y+SrOdziovB7RbYKIdssgo=;
        b=QpDwqzQ87qAMVDww2KqE2VH0gNfr88gnhQTXEh3+mEDMQghfgAHIBdKpXqHbSQ8FkF
         8U0MAEnLPxuLyia6NenM57gxZ5+6tSG9h1WObcP9QaCRv2qzD0pXQcBRBuA5Y6dw3kWJ
         Yuk2RMUBmjTwpHEqc9VbPiX9jnoSw7lunIWR0L1f628Jm7L4FR+wrPvjUnE3Q19bBCMN
         OrPdiczrdL/xAel1R7j/rU2kCNRUE92o/f/Q6UTwvBhd8F62sxIpZyB5ldci+kuFD/5P
         l+Km38/nvc8ddLIgD9uqJ7VGIQqaExBYQ127sworOTngGTEJbkRTXwlNIMfBppcSgVtU
         DTBA==
X-Gm-Message-State: AOAM531btgBNoEa2QifeoCVG4JHRGgIv4eFWcsQx1JqlUG8ccixvotKi
        Bb1g5e3O2/OKuhFBd9R81uE=
X-Google-Smtp-Source: ABdhPJzy0z4W6JIuSuLsrUFCT1a3dh+Xb1xWfcgmBQzIR5ATWYUTKtxIDekMEE3hy8775gf7NY4c0w==
X-Received: by 2002:a63:171e:: with SMTP id x30mr8409154pgl.368.1626248044683;
        Wed, 14 Jul 2021 00:34:04 -0700 (PDT)
Received: from [192.168.178.53] (14-203-78-180.tpgi.com.au. [14.203.78.180])
        by smtp.gmail.com with ESMTPSA id 73sm1422689pjz.24.2021.07.14.00.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 00:34:04 -0700 (PDT)
Subject: Re: Enhancement Idea - Optional PGO+LTO build for btrfs-progs
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <d0f8f74f-edd3-6591-c6e5-138daf6b25f5@gmail.com>
 <f68a2809-eb46-744f-7045-93eaeb4bb44f@gmx.com>
From:   DanglingPointer <danglingpointerexception@gmail.com>
Cc:     danglingpointerexception@gmail.com
Message-ID: <db80b801-9e7d-ce2b-15dd-84b30faf19cd@gmail.com>
Date:   Wed, 14 Jul 2021 17:34:01 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f68a2809-eb46-744f-7045-93eaeb4bb44f@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

"Why would you think btrfs-progs is the one needs to optimization?"

Perhaps I should have written more context.  When the data migration was 
taking a very long time (days); and the pauses due to "btrfs-transacti" 
blocking all IO including nfsd.  We thought, "should we '$ btrfs scrub 
<mount>' to make sure nothing had gone wrong?"

Problem is, scrubbing on the whole RAID5 takes ages!  If we did one disk 
of the array only it would at least sample a quarter of the array with a 
quarter chance of detecting if something/anything had gone wrong and 
hopefully won't massively slow down the on-going migration.

We tried it for a while on the single drive and it did indeed have 2x 
the scrubbing throughput but it was still very slow since we're talking 
multi-terrabytes on the single disk!  I believe the ETA forecast was ~3 
days.

Interestingly scrubbing the whole lot (whole RAID5 array) in one go by 
just scrubbing the mount point is a 4day ETA which we do regularly every 
3 months.  So even though it is slower on each disk, it finishes the 
whole lot faster than doing one disk at a time sequentially.

Anyways, thanks for informing us on what btrfs-progs does and how 'scrub 
speed' is independent of btrfs-progs and done by the kernel ioctls (on 
the other email thread).

regards,

DP

I thought btrfs scrub was part of btrfs-progs.  Pardon my ignorance if 
it isn't.


On 14/7/21 3:00 pm, Qu Wenruo wrote:
>
>
> On 2021/7/14 上午10:51, DanglingPointer wrote:
>> Recently we have been impacted by some performance issues with the
>> workstations in my lab with large multi-terabyte arrays in btrfs.  I
>> have detailed this on a separate thread.  It got me thinking however,
>> why not have an optional configure option for btrfs-progs to use PGO
>> against the entire suite of regression tests?
>>
>> Idea is:
>>
>> 1. configure with optional "-pgo" or "-fdo" option which will configure
>>     a relative path from source root where instrumentation files will go
>>     (let's start with gcc only for now, so *.gcda files into a folder).
>>     We then add the instrumentation compiler option
>> 2. build btrfs-progs
>> 3. run every single tests available ( make test &&  make test-fsck &&
>>     make test-convert)
>> 4. clean-up except for instrumentation files
>> 5. re-build without the instrumentation flag from point 1; and use the
>>     instrumentation files for feedback directed optimisation (FDO) (for
>>     gcc add additional partial-training flag); add LTO.
>
> Why would you think btrfs-progs is the one needs to optimization?
>
> From your original report, there is nothing btrfs-progs related at all.
>
> All your work, from scrub to IO, it's all handled by kernel btrfs module.
>
> Thus optimization of btrfs-progs would bring no impact.
>
> Thanks,
> Qu
>>
>> I know btrfs is primarily IO bound and not cpu.  But just thinking of
>> squeezing every last efficiency out of whatever is running in the cpu,
>> cache and memory.
>>
>> I suppose people can do the above on their own, but was thinking if it
>> was provided as a configuration optional option then it would make it
>> easier for people to do without more hacking.  Just need to add warnings
>> that it will take a long time, have a coffee.
>>
>> The python3 configure process has the process above as an optional
>> option but caters for gcc and clang (might even cater for icc).
>>
>> Anyways, that's my idea for an enhancement above.
>>
>> Would like to know your thoughts.  cheers...
>>
