Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A2F365F1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 20:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhDTSU0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 14:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbhDTSUZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 14:20:25 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC80C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Apr 2021 11:19:52 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id l22so37308033ljc.9
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Apr 2021 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ZfYwKyceb1ZRYGZ+Qb1gcmZyjQyqMAPuxxN5kv/F21E=;
        b=rFDCtmPxzf/icM0xfVJo02sTAoIvnoTH/XnfrWCiSHO0x/CLa0Q0t6kanl4MYFUJO1
         5VlUJky0V7obrj0KcDnMM2/pxolalssv7NgYQjV3iq1Bh5xMjdSIOAK+S6V7/b02Quy3
         SBuQKnJz8KIyR4Uhp6xNclxlfPmjPwA3IVSQT4d9MY7VrRmfo64RD8DP+kbm/0PE2DK6
         pTwIkR4bqFBVbW8+PBhLf3VqU56TqFcB0T7x1GlG8369B1YpO+laMawYII46TovJEBrb
         8gUbPgYzdjcuh3ArgRauUVTIOeqf/Y9+LKvyodviSwFRxKefhLAZCMdAJOzdMiw6TU31
         Yndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZfYwKyceb1ZRYGZ+Qb1gcmZyjQyqMAPuxxN5kv/F21E=;
        b=E7mcfL8bwx6a4ktoZxwSe9WmGv6qlygDGkVEYMZe76Mkb+xAjgzFLM4lHZdgAVv6WL
         6ujZlwGHf+F5qcmdHrjE+ZelMTBJgfki+JmpV4/LuahwcuOGto5WNAJTbqZNrE6ClUqe
         FiyUGqut/bwFfoLZ03WExPFPr6TqTUQ+FJsZKwoqAKk+zEu0a6Z6BZVX6Opj3DacXyNg
         kmbNot7PzsXyHIW8LdD7Cmzup3z0yF90xLMT6FjYNdIqkq3x0HRgTvdoGnmXDipouTpz
         9lf4SW0z+NOqG2gYbUaiUK2P1nkCQcdeBZTRsGVfUVXG1CWRtjbDPTu8ok7g8Chym21z
         gnPw==
X-Gm-Message-State: AOAM532+XwMQ2PNfBidMs5Rlvqmf9ur7jeoT2XBqW8iPgxxwoj6N8AM2
        9kSKNlZZKkbiGAjqzkht6tieWYn/QxaWa64J
X-Google-Smtp-Source: ABdhPJwQJd7HLn24uc/7CQWlMCpxYAuQTS9ZHWP+g795MK7AaTV/OaA/PTYIUkvbVeqy0uU0aOuhyg==
X-Received: by 2002:a2e:8095:: with SMTP id i21mr11512992ljg.395.1618942790720;
        Tue, 20 Apr 2021 11:19:50 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:be19:6dbd:a91:f761:1766? ([2a00:1370:812d:be19:6dbd:a91:f761:1766])
        by smtp.gmail.com with ESMTPSA id e11sm2268235ljk.128.2021.04.20.11.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 11:19:50 -0700 (PDT)
Subject: Re: Replacing disk strange (buggy?) behaviour - RAID1
To:     me@jse.io, linux-btrfs@vger.kernel.org
References: <CAFMvigdvAjY60Tc0_bMB-QMQhrSJFxdv2iJ6jXbju+b5_kPKrA@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <9bdb8872-3394-534f-a9e3-11dcc5ea2819@gmail.com>
Date:   Tue, 20 Apr 2021 21:19:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAFMvigdvAjY60Tc0_bMB-QMQhrSJFxdv2iJ6jXbju+b5_kPKrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19.04.2021 18:22, Jonah Sabean wrote:
> I'm running Ubuntu 21.04 (technically not a stable "release" yet, but
> it will be in a few days, so if this is an ubuntu specific issue I'd
> like to report it before it is!).
> 
> The btrfs volume in question is two 8TB hard disks that were in RAID1
> at the time the filesystem was created. Kernel version is Ubuntu's
> 5.11.0-14-generic with btrfs-progs version 5.10.1-1build1 in the
> hirsute repos currently. This array is mostly non-changing archived
> data, if that even matters.
> 
> I replaced a missing disk (sda is the replacement disk) last night
> while in a degraded mount (left it all night to complete) with `btrfs
> replace start 1 /dev/sda1 /mnt/btrfs` (1 was the missing disk in btrfs
> fi show) and it appears to have worked fine. However, when I ran
> `btrfs fi usage` it returned:
> 
> Overall:
>     Device size:                  14.55TiB
>     Device allocated:              2.41TiB
>     Device unallocated:           12.14TiB
>     Device missing:                  0.00B
>     Used:                          1.60TiB
>     Free (estimated):              8.63TiB      (min: 6.61TiB)
>     Free (statfs, df):            12.14TiB
>     Data ratio:                       1.50
>     Metadata ratio:                   1.43
>     Global reserve:              512.00MiB      (used: 0.00B)
>     Multiple profiles:                 yes      (data, metadata, system)
> 
> Data,single: Size:820.00GiB, Used:3.25MiB (0.00%)
>    /dev/sdb1     820.00GiB
> 
> Data,RAID1: Size:819.00GiB, Used:818.64GiB (99.96%)
>    /dev/sda1     819.00GiB
>    /dev/sdb1     819.00GiB
> 
> Metadata,single: Size:4.00GiB, Used:864.00KiB (0.02%)
>    /dev/sdb1       4.00GiB
> 
> Metadata,RAID1: Size:3.00GiB, Used:1.69GiB (56.23%)
>    /dev/sda1       3.00GiB
>    /dev/sdb1       3.00GiB
> 
> System,single: Size:32.00MiB, Used:144.00KiB (0.44%)
>    /dev/sdb1      32.00MiB
> 
> System,RAID1: Size:8.00MiB, Used:80.00KiB (0.98%)
>    /dev/sda1       8.00MiB
>    /dev/sdb1       8.00MiB
> 
> Unallocated:
>    /dev/sda1       6.47TiB
>    /dev/sdb1       5.67TiB
> 
> So a small amount of actual data and metadata was still single on the
> disk I was rebuilding from (sdb), but it had massively allocated
> "single" chunks in the process (relatively equal to what I had in
> actual data), and to a lesser extent, metadata too. 

Mounting raid1 btrfs writable in degraded mode creates chunks with
single profile. This is long standing issue. What is rather surprising
that you apparently have chunk size 819GiB which is suspiciously close
to 10% of 8TiB. btrfs indeed limits chunk size to 10% of total space,
but it should not exceed 10GiB. Could it be specific Ubuntu issue?

So when you wrote data in degraded mode it had to allocate new chunk
with "single" profile.

> Why didn't it free
> those up as it replaced the missing disk and duplicated the data in
> RAID1? 

Device replacement restored mirrored data (chunks with "raid1" profile)
on the new device. It had no reasons to touch chunks with "single"
profile because from btrfs point of view these chunks never had any data
on replaced device so there is nothing to write there.

> Shouldn't it all be RAID1 once it's complete,

No. btrfs replace restores content of missing device. It is not
replacement for profile conversion.

> why even have
> such small amounts remain single? Easy fix I thought, as at first
> glance I didn't realize 800GiB was allocated single, only paying
> attention to the small amounts used, so I did a soft convert to fix
> this.
> sudo btrfs balance start -dconvert=raid1,soft -mconvert=raid1,soft /mnt/btrfs
> 
> Convert was pretty quick... took just a few minutes, but of course now
> it's all allocated just as raid1 now (with presumably 0 actual data in
> most of them):

Correct. To convert profile btrfs must allocate new chunks in new
profile and copy data over.
...
> 
> My questions are:
> 1. Why did it have so much 'single' allocated chunks to begin with?

It does not look like "chunks", rather it really looks like "chunk".
Output of

btrfs inspect-internal dump-tree -d /dev/xxx

may be interesting.

> Everything was RAID1 all up until the disk replacement, so it clearly
> did this during the `btrfs replace` process. 

No, it did it during degraded writable mount.

> Did I do this wrong, or
> is there a bug?

There is misfeature that btrfs creates "single" chunks during degraded
mount. Ideally it should create degraded raid1 chunks.

> 2. Would the btrfs replace have failed if the filesystem was more full
> and those chunks were not possible to allocate (it basically allocated
> double the amount of data I have after all, so if the fs was 50%+
> full...)?

btrfs replace duplicates data that was on missing device. If you were
able to write this data while device was present, btrfs replace cannot
fail due to missing space (of course if device is at least as large).

> 3. How do I prevent this from happening in the future, should I need
> to replace a disk?

Do not write anything in degraded mode.

> Is this possibly an Ubuntu related issue (perhaps
> how the btrfs progs is older relative to the kernel?).
> 
> The 7GiB metadata isn't so bad, however I did proceed to run
> btrfs balance start -dusage=0 /mnt/btrfs
> 
> Is it possible to run balance with `-dusage=0` along with the convert
> to do that all in one balance? Obviously, that doesn't solve the
> actual issue to begin with, I'm just curious as I did it in two steps.
> 
> FWIW: The `dusage=0` filter freed up pretty much everything as I
> expected it to, and it looks pretty much identical to how it did
> before the disk replacement:
> Data,RAID1: Size:819.00GiB, Used:818.64GiB (99.96%)
>   /dev/sda1     819.00GiB
>   /dev/sdb1     819.00GiB
> 
> I'm willing to do the process all over again as all this data is on
> another system, I just would like assurance I don't run into this same
> issue twice.
> 
> Thanks,
> -Jonah
> 

