Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350B8433583
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 14:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhJSMNL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 08:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbhJSMNK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 08:13:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C52C06161C
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 05:10:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g39so7536218wmp.3
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 05:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=jdgC7Bbz0ebOROlmkAt6O+vjzHs3frcCJ17AnaGHzas=;
        b=pjHh2sQXj0JBGTil3mA0a9zpxnO2s9c5kIktqcNeWDfXK5ak1tJPQ1vumR//RH/Is8
         u5+vcOmkdcGSkmag/ezEU3lqC8zzcaHh1QnviujbWwdBDuZJr7Ez74N3nq0U0NyuJw4a
         9WeDZiOqp60KKGbdGaIh3fBtrei4fc/8utQZHKCFCPL/o3QXgKUnwLHtGC3veQH8wUvv
         kqw6M/SlArBB2m2eReJm1WyAtaUWmOJ+4TonBV/5HRFgcvKQ/Zw+9ngdJwq7kLjBdDgd
         J/sMAbwwnc4b7Obta2Fglq0GKJ5h7xKKX7rr4aGnoV6INKjSP5YHfBl5tobCP4o/H2hf
         7siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=jdgC7Bbz0ebOROlmkAt6O+vjzHs3frcCJ17AnaGHzas=;
        b=CoV6ANlcmwO4vI8qnJDYjlKxySr09FZsNfe8cKCdyX1rHba9gsSs1kEpbWgvME88sZ
         NvfhWP4adMTdT/gRT6wbowip63Y4FJojluZVOUcD1mJrxsqMZOS6t9CXYUMuHbEWzalq
         3ZGzwB4yK4HgtPCDNeVYwM6kbkvMDHKMVa2nvhUpW04xPMeGiGRoy7LQOPLa04OI1Xzl
         fnnnAm5q3N9woUNPh6oiFSnw3wfh0GMieEGzxzAyhRRngLjBilsKcvdgkMILSjIJpFIg
         8OYytMqisiU3EKZksYRqTahLLRnWZS8DgSY12/TtjX+T61BswSqn6SxC3PeJpmsf51yV
         DBHw==
X-Gm-Message-State: AOAM5334cfoXjkUbV9s91sNn7roAa1xFcB/yRzEyOrO1IscknZ8RIuEL
        AZmleQBgxLxENognciMDdIsL8gdw5R0=
X-Google-Smtp-Source: ABdhPJw0eBkSkb1GWXAszS+94Ju4wDor9gW4keMGCmvVerUCG+oGARFXTzKg3iseVqLkhsc4+wYRbw==
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr5691656wmg.38.1634645455746;
        Tue, 19 Oct 2021 05:10:55 -0700 (PDT)
Received: from [127.0.0.1] (tmo-117-153.customers.d1-online.com. [80.187.117.153])
        by smtp.gmail.com with ESMTPSA id t11sm14981607wrz.65.2021.10.19.05.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 05:10:55 -0700 (PDT)
Date:   Tue, 19 Oct 2021 12:10:58 +0000 (UTC)
From:   Emil Heimpel <broetchenrackete@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <79fe7aed-4277-4679-8043-4e6f4a184568@gmail.com>
In-Reply-To: <28511d75-f76b-f587-3474-554e8bf2aa22@gmx.com>
References: <ed4a7a10-d5a4-4b62-8e67-0b971487a74a@gmail.com> <47f76535-12c3-996e-3306-0bf0f4eed57e@gmx.com> <297b21db-4a67-469d-9ae1-54b1043dac31@gmail.com> <28511d75-f76b-f587-3474-554e8bf2aa22@gmx.com>
Subject: Re: Errors after successful disk replace
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <79fe7aed-4277-4679-8043-4e6f4a184568@gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Oct 19, 2021 13:37:09 Qu Wenruo <quwenruo.btrfs@gmx.com>:

>
>
> On 2021/10/19 18:49, Emil Heimpel wrote:
>>
>> Oct 19, 2021 07:35:54 Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>
>>>
>>>
>>> On 2021/10/19 11:54, Emil Heimpel wrote:
>>>> Hi all,
>>>>
>>>> One of my drives of a raid 5 btrfs array failed (was dead completely) =
so I installed an identical replacement drive. The dead drive was devid 1 a=
nd the new drive /dev/sde. I used the following to replace the missing driv=
e:
>>>>
>>>> sudo btrfs replace start -B 1 /dev/sde1 /mnt/btrfsrepair/
>>>>
>>>> and it completed successfully without any reported errors (took around=
 2 weeks though...).
>>>>
>>>> I then tried to see my array with filesystem show, but it hung (or too=
k longer than I wanted to wait), so I did a reboot.
>>>
>>> Any dmesg of that time?
>>>
>>
>> Nothing after the replace finished:
>>
>> 1634463961.245751 BlueQ kernel: BTRFS error (device sdb1): failed to reb=
uild valid logical 17663044222976 for dev (efault)
>> 1634463961.255819 BlueQ kernel: BTRFS error (device sdb1): failed to reb=
uild valid logical 17663045795840 for dev (efault)
>> 1634463961.275815 BlueQ kernel: BTRFS error (device sdb1): failed to reb=
uild valid logical 17663046582272 for dev (efault)
>> 1634463961.275922 BlueQ kernel: BTRFS error (device sdb1): failed to reb=
uild valid logical 17663047368704 for dev (efault)
>> 1634463961.339074 BlueQ kernel: BTRFS error (device sdb1): failed to reb=
uild valid logical 17663048155136 for dev (efault)
>> 1634463961.339248 BlueQ kernel: BTRFS error (device sdb1): failed to reb=
uild valid logical 17663048941568 for dev (efault)
>
> *failed*...
>
>> 1634475910.611261 BlueQ kernel: sd 9:0:2:0: attempting task abort!scmd(0=
x0000000046fead3f), outstanding for 7120 ms & timeout 7000 ms
>> 1634475910.615126 BlueQ kernel: sd 9:0:2:0: [sdd] tag#840 CDB: ATA comma=
nd pass through(16) 85 08 2e 00 00 00 01 00 00 00 00 00 00 00 ec 00
>> 1634475910.615429 BlueQ kernel: scsi target9:0:2: handle(0x000b), sas_ad=
dress(0x4433221105000000), phy(5)
>> 1634475910.615691 BlueQ kernel: scsi target9:0:2: enclosure logical id(0=
x590b11c022f3fb00), slot(6)
>
> And ATA commands failure.
>
> I don't believe the replace finished without problem, and the involved
> device is /dev/sdd.
>
>> 1634475910.787911 BlueQ kernel: sd 9:0:2:0: task abort: SUCCESS scmd(0x0=
000000046fead3f)
>> 1634475910.807083 BlueQ kernel: sd 9:0:2:0: Power-on or device reset occ=
urred
>> 1634475949.877998 BlueQ kernel: sd 9:0:2:0: Power-on or device reset occ=
urred
>> 1634525944.213931 BlueQ kernel: perf: interrupt took too long (3138 > 31=
37), lowering kernel.perf_event_max_sample_rate to 63600
>> 1634533791.168760 BlueQ kernel: BTRFS error (device sdb1): failed to reb=
uild valid logical 22996545634304 for dev (efault)
>> 1634552685.203559 BlueQ kernel: BTRFS error (device sdb1): failed to reb=
uild valid logical 23816815706112 for dev (efault)
>
> You won't want to see this message at all.
>
> This means, you're running RAID56, as btrfs has write-hole problem,
> which will degrade the robust of RAID56 byte by byte for each unclean
> shutdown.
>
> I guess the write hole problem has already make the repair failed for
> the replace.
>

Hm, I never checked dmesg for the replace, because btrfs replace always sho=
wed 0 errors... I may have to check my sata-controller as I don't think it =
is a problem with sdd. I found these same errors for other drives as well..=
..


> Thus after a successful mount, scrub and manually file checking is
> almost a must.
>
>> 1634558977.979621 BlueQ kernel: BTRFS info (device sdb1): dev_replace fr=
om <missing disk> (devid 1) to /dev/sde1 finished
>> 1634560793.132731 BlueQ kernel: zram0: detected capacity change from 326=
10864 to 0
>> 1634560793.169379 BlueQ kernel: zram: Removed device: zram0
>> 1634560883.549481 BlueQ kernel: watchdog: watchdog0: watchdog did not st=
op!
>> 1634560883.556038 BlueQ systemd-shutdown[1]: Syncing filesystems and blo=
ck devices.
>> 1634560883.572840 BlueQ systemd-shutdown[1]: Sending SIGTERM to remainin=
g processes...
>>
>>
>>
>>
>>>>
>>>> It showed up after a reboot as followed:
>>>>
>>>> Label: 'BlueButter'=C2=A0 uuid: 7e3378e6-da46-4a60-b9b8-1bcc306986e3
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 6 FS bytes us=
ed 20.96TiB
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 0 s=
ize 7.28TiB used 5.46TiB path /dev/sde1
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 s=
ize 7.28TiB used 5.46TiB path /dev/sdb1
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 3 s=
ize 2.73TiB used 2.73TiB path /dev/sdg1
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 4 s=
ize 2.73TiB used 2.73TiB path /dev/sdd1
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 5 s=
ize 7.28TiB used 4.81TiB path /dev/sdf1
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 6 s=
ize 7.28TiB used 5.33TiB path /dev/sdc1
>>>>
>>>> I then tried to mount it, but it failed, so I run a readonly check and=
 it reported the following problem:
>>>
>>> And dmesg for the failed mount?
>>>
>>
>> Oops, I must have missed that it failed because of missing devid 1 too..=
.
>>
>> 1634562944.145383 BlueQ kernel: BTRFS info (device sde1): flagging fs wi=
th big metadata feature
>> 1634562944.145529 BlueQ kernel: BTRFS info (device sde1): force zstd com=
pression, level 2
>> 1634562944.145650 BlueQ kernel: BTRFS info (device sde1): using free spa=
ce tree
>> 1634562944.145697 BlueQ kernel: BTRFS info (device sde1): has skinny ext=
ents
>> 1634562944.148709 BlueQ kernel: BTRFS error (device sde1): devid 1 uuid =
51645efd-bf95-458d-b5ae-b31623533abb is missing
>> 1634562944.148764 BlueQ kernel: BTRFS error (device sde1): failed to rea=
d chunk tree: -2
>> 1634562944.185369 BlueQ kernel: BTRFS error (device sde1): open_ctree fa=
iled
>
> This doesn't sound correct.
>
> If a device is properly replaced, it should have the same devid number.
>
> I guess you have tried to add a new device before, and then tried to
> replace the missing device, right?
>

No. Never added a drive to that array, never tried to remove one. Only repl=
ace! This is the 3rd time I was replacing a drive, the first two times the =
faulty drive was readable and still in the system. This was the first time =
I had to do a replace without the source drive.

I did replace the first two drives with bigger ones though and did a resize=
 after the replace...
>
> Anyway, have you tried to mount it degraded and then remove the missing
> device?
>
> Since you're using RAID56, I guess degrade mount should work.
>

So, mount degraded and then remove devid 1? I'll try that and report back, =
thanks!

Emil

> Thanks,
> Qu
>
>>
>>> Thanks,
>>> Qu
>>>>
>>>> [...]
>>>> [2/7] checking extents
>>>> ERROR: super total bytes 38007432437760 smaller than real device(s) si=
ze 46008994590720
>>>> ERROR: mounting this fs may fail for newer kernels
>>>> ERROR: this can be fixed by 'btrfs rescue fix-device-size'
>>>> [3/7] checking free space tree
>>>> [...]
>>>>
>>>> So I followed that advice but got the following error:
>>>>
>>>> sudo btrfs rescue fix-device-size /dev/sde1
>>>> ERROR: devid 1 is missing or not writeable
>>>> ERROR: fixing device size needs all device(s) to be present and writea=
ble
>>>>
>>>> So it seems something went wrong or didn't complete fully.
>>>> What can I do to fix this problem?
>>>>
>>>> uname -a
>>>> Linux BlueQ 5.14.12-arch1-1 #1 SMP PREEMPT Wed, 13 Oct 2021 16:58:16 +=
0000 x86_64 GNU/Linux
>>>>
>>>> btrfs --version
>>>> btrfs-progs v5.14.2
>>>>
>>>> Regards,
>>>> Emil
>>>>
>>>> P.S.: Yes, I know, raid5 isn't stable but it works good enough for me =
;)
>>>> Metadata is raid1 btw...
>>>>
>>

