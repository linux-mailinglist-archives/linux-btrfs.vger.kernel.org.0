Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013DA26A2C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 12:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgIOKIO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 06:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIOKIM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 06:08:12 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F49DC06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Sep 2020 03:08:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m6so2701526wrn.0
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Sep 2020 03:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fxBrDx4XfLsp3yuN08csFWjZoucQqZzox9AAtnmfKWo=;
        b=AVFE6Cq0W4LfXSb0BWxYgxof/IULIQMdMArnFO3FwD4Hibdh8taX+fxj4hP6iS5Cqw
         4liYSL5qocVihK1CXUjTrlOFEJ843FkrDnI91W7l+lDyCCIcwSu3OmMsSeCw4QQw3bgt
         pixBnxKOSZtdH+6EXivkReVNYpUafTtBH/F7nenRObApGJaPqBoS49VUrGq+ULF8LpgV
         3N67PH/gpWVGju75aNOs3LeCrC51VjDcZwd3k8/Brt5zzPIhdDRZbuPn3SqvAaTjpl3e
         AhA6zh6MmlYUppC4UxqK7tumIllVOsTXdx0chEcGOthTVbCUS4hsfcO3QqY62jGm6YBb
         oPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fxBrDx4XfLsp3yuN08csFWjZoucQqZzox9AAtnmfKWo=;
        b=YLFZCFRhjDprFUu9m4qMIiBTAfdH3GkQ2WDmWBgI8RQ5WJdRnvuzRT0de22kG9AQ+K
         /K/Adhyye1WgovxBoyZAXq69nJQLE3m0ConMA5tQC9yc/cwPJ0db5SnKs4BNqpGc7t7e
         wKFtKSp1GCj2yPUeTioNBP/fVd/iMYg5hR/0nStwgnSIdFdoyEnCMDjnIKv7z1kc7xz7
         wHwwrtwP9ilSX1oKvVVUovjkNNY7AsDG9WxAZ02ZqHqMQGrNvJnNaBUMzzRREvN+lQ7c
         PxRcWwClsRRn/zBiYlStinSiqa3sYf5yEFtLaBPGcU5SylvBP97rVTz2Y2fPvOmaxTtl
         u8nA==
X-Gm-Message-State: AOAM531wcwwgO15OfNDZ/F4DZVXoWCfkNx4nKrYZH0a22rq+g5f0Fg0H
        FLSX1gufeIjg5aZCqS/R2ZVc/f2c6BWycQ==
X-Google-Smtp-Source: ABdhPJwwhOsZeaTRfR6lfABywJZ2AscmZpsxqj7dhEfSkyA6ladPx1AQylE/M4yhOs8Gc+j6MFGSWw==
X-Received: by 2002:adf:ec90:: with SMTP id z16mr19813246wrn.145.1600164490336;
        Tue, 15 Sep 2020 03:08:10 -0700 (PDT)
Received: from ?IPv6:2001:718:2:119a:147:32:132:32? ([2001:718:2:119a:147:32:132:32])
        by smtp.gmail.com with ESMTPSA id d23sm6843989wmb.6.2020.09.15.03.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 03:08:08 -0700 (PDT)
Subject: Re: No space left after add device and balance
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <9224b373-82ee-60c4-4bd1-be359db75ea1@gmail.com>
 <CAJCQCtQYSPO6Wd2u=WK-mia0WTjU0BybhhhhbT5VZUczUfx+JQ@mail.gmail.com>
 <d1339a91-0a04-538c-59ca-30bc05b636a5@gmail.com>
 <20200911153320.GE5890@hungrycats.org>
From:   =?UTF-8?Q?Miloslav_H=c5=afla?= <miloslav.hula@gmail.com>
Message-ID: <6689657b-e999-f025-d9b4-e324128bb5ae@gmail.com>
Date:   Tue, 15 Sep 2020 12:08:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911153320.GE5890@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: cs
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dne 11.09.2020 v 17:33 Zygo Blaxell napsal(a):
> On Fri, Sep 11, 2020 at 12:29:32PM +0200, Miloslav Hůla wrote:
>> Dne 10.09.2020 v 21:18 Chris Murphy napsal(a):
>>> On Wed, Sep 9, 2020 at 2:15 AM Miloslav Hůla <miloslav.hula@gmail.com> wrote:
>>>
>>>> After ~15.5 hours finished successfully. Unfortunetally, I have no exact
>>>> free space report before first balance, but it looked roughly like:
>>>>
>>>> Label: 'DATA'  uuid: 5b285a46-e55d-4191-924f-0884fa06edd8
>>>>            Total devices 16 FS bytes used 3.49TiB
>>>>            devid    1 size 558.41GiB used 448.66GiB path /dev/sda
>>>>            devid    2 size 558.41GiB used 448.66GiB path /dev/sdb
>>>>            devid    4 size 558.41GiB used 448.66GiB path /dev/sdd
>>>>            devid    5 size 558.41GiB used 448.66GiB path /dev/sde
>>>>            devid    7 size 558.41GiB used 448.66GiB path /dev/sdg
>>>>            devid    8 size 558.41GiB used 448.66GiB path /dev/sdh
>>>>            devid    9 size 558.41GiB used 448.66GiB path /dev/sdf
>>>>            devid   10 size 558.41GiB used 448.66GiB path /dev/sdi
>>>>            devid   11 size 558.41GiB used 448.66GiB path /dev/sdj
>>>>            devid   13 size 558.41GiB used 448.66GiB path /dev/sdk
>>>>            devid   14 size 558.41GiB used 448.66GiB path /dev/sdc
>>>>            devid   15 size 558.41GiB used 448.66GiB path /dev/sdl
>>>>            devid   16 size 558.41GiB used 448.66GiB path /dev/sdm
>>>>            devid   17 size 558.41GiB used 448.66GiB path /dev/sdn
>>>>            devid   18 size 837.84GiB used 448.66GiB path /dev/sdr
>>>>            devid   19 size 837.84GiB used 448.66GiB path /dev/sdq
>>>>            devid   20 size 837.84GiB used   0.00GiB path /dev/sds
>>>>            devid   21 size 837.84GiB used   0.00GiB path /dev/sdt
>>>>
>>>>
>>>> Are we doing something wrong? I found posts, where problems with balace
>>>> of full filesystem are described. And as a recommendation is "add empty
>>>> device, run balance, remove device".
>>>
>>> It's raid10, so in this case, you probably need to add 4 devices. It's
>>> not required they be equal sizes but it's ideal.
> 
> Something is wrong there.  Each new balanced chunk will free space
> on the first 16 drives (each new chunk is 9GB, each old one is 8GB,
> so the number of chunks on each of the old disks required to hold the
> same data decreases by 1/8th each time a chunk is relocated in balance).
> Every drive had at least 100GB of unallocated space at the start, so the
> first 9GB chunk should have been allocated without issue.  Assuming nobody
> was aggressively writing to the disk during the balance to consume all
> available space, it should not have run out of space in a full balance.
> 
> You might have hit a metadata space reservation bug, especially on an
> older kernel.  It's hard to know what happened without a log of the
> 'btrfs fi usage' data over time and a stack trace of the ENOSPC event,
> but whatever it was, it was probably fixed some time in the last 4
> years.

It happend with 4.9.210-1 (it's ~4 years old), now running 4.19.132-1 
after Debian Buster upgrade.

> There's a bug (up to at least 5.4) where scrub locks chunks and triggers
> aggressive metadata overallocations, which can lead to this result.
> It forms a feedback loop where scrub keeps locking the metadata chunk that
> balance is using, so balance allocates another metadata chunk, then scrub
> moves on and locks that new metadata chunk, repeat until out of space,
> abort transaction, all the allocations get rolled back and disappear.
> Only relevant if you were running a scrub at the same time as balance.

We were not running scrub in time of crash. But we were running rsync of 
whole btrfs to NetApp via NFS at the same sime.

>>>> Are there some requirements on free space for balance even if you add
>>>> new device?
>>>
>>> The free space is reported upon adding the two devices; but the raid10
>>> profile requires more than just free space, it needs free space on
>>> four devices.
>>
>> I didn't realize that. It makes me sense now. So we are probably "wrong"
>> with 18 devices. Multiple of 4 would be better I guess.
> 
> Not really.  btrfs profile "raid10" distribute stripes over pairs of
> mirrored drives.  It will allocate raid10 chunks on 4 + N * 2 drives at a
> time, but each chunk can use different drives so all the space is filled.
> Any number of disks above 4 is OK (including odd numbers), but sequential
> read performance will only increase when the number of drives increases
> to the next even number so the next highest stripe width can be used.
> 
> i.e. 5 drives will provide more space than 4, but 5 drives will not be
> significantly faster than 4.  6 is faster and larger than 4 or 5.
> 7 will be larger, 8 will be larger and faster, 9 will be larger, etc.
> (assuming all the drives are identical)

Thanks for the clarification. I used to think that. It was one of pros 
to make a decision for btrfs RAID-10 few years before. I'm glad that's 
right.
