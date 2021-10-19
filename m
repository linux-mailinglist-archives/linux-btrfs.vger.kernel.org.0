Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB73D43361A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 14:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhJSMk4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 08:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhJSMk4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 08:40:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E0BC06161C
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 05:38:43 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g2so11774197wme.4
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=SdOzr1T7zpHU63ABqUQEYCSJbswhoB4zJ0Yjfagw9Eo=;
        b=kCIULnAEiBnlTMyXpSdg/1YkTc6FnWjcBqgm2ivvllCAr8ANoQ3XjaVgOKAmrzSLQl
         GF2wWPXzdTOQREJd/af5dZT2NDXDPDkIojLu2TB04qmY6+SsFVtEpTKn7sjI0EkMxLyp
         pKeTWaPSZWgXNMGOTox2p4lGdxAV1H5A+EfW0E5+Kju0Rs7yNq8XtNaBwSKnoXnAZ34J
         C5UZ2blEsN4HTQw10uFu6sjVVXQ8OriFWOuIVjt5IGOAUCpc4xEkQCxgx8Z702Sp8ytp
         ZjWpS406+ckm+oHMDJBgYNWt+wE8UJqiJngG1Arb6XTwaUaGzz8PheQiX2wDW3AxMymZ
         uhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=SdOzr1T7zpHU63ABqUQEYCSJbswhoB4zJ0Yjfagw9Eo=;
        b=YB2lFUJa/iMxAz5uyMxvv4aWJZFJSnVGfPLRBiY84+EqZqS43wwxtawUJlMUac11VR
         Mby5eeIG7WWkPH01xhPwQAFhp+qf89k81Qd+Bd/cRSbF1JtsJZ+aouIzO++S8DFaDUCw
         NYIBxEp4tgKwALu6IFNZw9ynhcw+D5wXNc+eYmNRmNX/zf4vrezfbbo4R4WfrNdP+lNE
         58yoV8125MQhvdXzNGH8InqlX6+a90mSRmGg68uZy2NnRaL1RN8HwvowzRNOHcC1/V63
         KXjBZBD0gm/NtCxN+YC3XlI0kUdUBfjhAHfBdVNlQKiMGCnixsQSYvC6QnQeAizjUZZ1
         Mesg==
X-Gm-Message-State: AOAM533yD5loWhXz/WrpE2u3cit4CFCtPVl33SCtFAQJfKYKLxtOsLTC
        c3L7/KqYdlpz5Pt0Y60csZDx3DXI/hU=
X-Google-Smtp-Source: ABdhPJw6i5c/SRDupWGG8/Z2gzgTlENyN3hxNW2xMD6wEded7A8JisRdVSrK5J1KJBv6ytS1vRwooA==
X-Received: by 2002:a7b:c742:: with SMTP id w2mr5822685wmk.61.1634647121749;
        Tue, 19 Oct 2021 05:38:41 -0700 (PDT)
Received: from [127.0.0.1] (p5796730c.dip0.t-ipconnect.de. [87.150.115.12])
        by smtp.gmail.com with ESMTPSA id f184sm2116466wmf.22.2021.10.19.05.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 05:38:41 -0700 (PDT)
Date:   Tue, 19 Oct 2021 12:38:43 +0000 (UTC)
From:   Emil Heimpel <broetchenrackete@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <0e218606-5e07-4d7d-b81f-519895af2dfa@gmail.com>
In-Reply-To: <5d8df74b-6094-de7d-1b47-885126cf4bc6@gmx.com>
References: <ed4a7a10-d5a4-4b62-8e67-0b971487a74a@gmail.com> <47f76535-12c3-996e-3306-0bf0f4eed57e@gmx.com> <297b21db-4a67-469d-9ae1-54b1043dac31@gmail.com> <28511d75-f76b-f587-3474-554e8bf2aa22@gmx.com> <64e5b8aa-bc49-4596-b4ff-8cc780a6513d@gmail.com> <5d8df74b-6094-de7d-1b47-885126cf4bc6@gmx.com>
Subject: Re: Errors after successful disk replace
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <0e218606-5e07-4d7d-b81f-519895af2dfa@gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

So it finished after 2 minutes?

[Tue Oct 19 14:13:51 2021] BTRFS info (device sde1): continuing dev_replace=
 from <missing disk> (devid 1) to target /dev/sde1 @74%
[Tue Oct 19 14:15:39 2021] BTRFS info (device sde1): dev_replace from <miss=
ing disk> (devid 1) to /dev/sde1 finished


Now I at least have an expected filesystem show:

Label: 'BlueButter'=C2=A0 uuid: 7e3378e6-da46-4a60-b9b8-1bcc306986e3
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 6 FS bytes used 20=
.96TiB
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 7=
.28TiB used 5.46TiB path /dev/sde1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 size 7=
.28TiB used 5.46TiB path /dev/sdb1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 3 size 2=
.73TiB used 2.73TiB path /dev/sdg1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 4 size 2=
.73TiB used 2.73TiB path /dev/sdd1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 5 size 7=
.28TiB used 4.81TiB path /dev/sdf1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 6 size 7=
.28TiB used 5.33TiB path /dev/sdc1

And a nondegraded remount worked too.

Thanks,
Emil

Oct 19, 2021 14:20:21 Qu Wenruo <quwenruo.btrfs@gmx.com>:

>=20
>=20
> On 2021/10/19 20:16, Emil Heimpel wrote:
>> Color me suprised:
>>=20
>>=20
>> [74713.072745] BTRFS info (device sde1): flagging fs with big metadata f=
eature
>> [74713.072755] BTRFS info (device sde1): allowing degraded mounts
>> [74713.072758] BTRFS info (device sde1): using free space tree
>> [74713.072760] BTRFS info (device sde1): has skinny extents
>> [74713.104297] BTRFS warning (device sde1): devid 1 uuid 51645efd-bf95-4=
58d-b5ae-b31623533abb is missing
>> [74714.675001] BTRFS info (device sde1): bdev (efault) errs: wr 52950, r=
d 8161, flush 0, corrupt 1221, gen 0
>> [74714.675015] BTRFS info (device sde1): bdev /dev/sdb1 errs: wr 0, rd 0=
, flush 0, corrupt 228, gen 0
>> [74714.675025] BTRFS info (device sde1): bdev /dev/sdc1 errs: wr 0, rd 0=
, flush 0, corrupt 140, gen 0
>> [74751.033383] BTRFS info (device sde1): continuing dev_replace from <mi=
ssing disk> (devid 1) to target /dev/sde1 @74%
>> [bluemond@BlueQ ~]$ sudo btrfs replace status=C2=A0 -1 /mnt/btrfsrepair/
>> 74.9% done, 0 write errs, 0 uncorr. read errs
>>=20
>> I guess I just wait?
>=20
> Yep, wait and stay alert, better to also keep an eye on the dmesg.
>=20
> But this also means, previous replace didn't really finish, which may
> mean the replace ioctl is not reporting the proper status, and can be a
> possible bug.
>=20
> Thanks,
> Qu
>=20
>>=20
>> Oct 19, 2021 13:37:09 Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>=20
>>>=20
>>>=20
>>> On 2021/10/19 18:49, Emil Heimpel wrote:
>>>>=20
>>>> Oct 19, 2021 07:35:54 Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>>=20
>>>>>=20
>>>>>=20
>>>>> On 2021/10/19 11:54, Emil Heimpel wrote:
>>>>>> =E2=80=A6
>>>>>=20
>>>>> Any dmesg of that time?
>>>>>=20
>>>>=20
>>>> Nothing after the replace finished:
>>>>=20
>>>> 1634463961.245751 BlueQ kernel: BTRFS error (device sdb1): failed to r=
ebuild valid logical 17663044222976 for dev (efault)
>>>> 1634463961.255819 BlueQ kernel: BTRFS error (device sdb1): failed to r=
ebuild valid logical 17663045795840 for dev (efault)
>>>> 1634463961.275815 BlueQ kernel: BTRFS error (device sdb1): failed to r=
ebuild valid logical 17663046582272 for dev (efault)
>>>> 1634463961.275922 BlueQ kernel: BTRFS error (device sdb1): failed to r=
ebuild valid logical 17663047368704 for dev (efault)
>>>> 1634463961.339074 BlueQ kernel: BTRFS error (device sdb1): failed to r=
ebuild valid logical 17663048155136 for dev (efault)
>>>> 1634463961.339248 BlueQ kernel: BTRFS error (device sdb1): failed to r=
ebuild valid logical 17663048941568 for dev (efault)
>>>=20
>>> *failed*...
>>>=20
>>>> 1634475910.611261 BlueQ kernel: sd 9:0:2:0: attempting task abort!scmd=
(0x0000000046fead3f), outstanding for 7120 ms & timeout 7000 ms
>>>> 1634475910.615126 BlueQ kernel: sd 9:0:2:0: [sdd] tag#840 CDB: ATA com=
mand pass through(16) 85 08 2e 00 00 00 01 00 00 00 00 00 00 00 ec 00
>>>> 1634475910.615429 BlueQ kernel: scsi target9:0:2: handle(0x000b), sas_=
address(0x4433221105000000), phy(5)
>>>> 1634475910.615691 BlueQ kernel: scsi target9:0:2: enclosure logical id=
(0x590b11c022f3fb00), slot(6)
>>>=20
>>> And ATA commands failure.
>>>=20
>>> I don't believe the replace finished without problem, and the involved
>>> device is /dev/sdd.
>>>=20
>>>> 1634475910.787911 BlueQ kernel: sd 9:0:2:0: task abort: SUCCESS scmd(0=
x0000000046fead3f)
>>>> 1634475910.807083 BlueQ kernel: sd 9:0:2:0: Power-on or device reset o=
ccurred
>>>> 1634475949.877998 BlueQ kernel: sd 9:0:2:0: Power-on or device reset o=
ccurred
>>>> 1634525944.213931 BlueQ kernel: perf: interrupt took too long (3138 > =
3137), lowering kernel.perf_event_max_sample_rate to 63600
>>>> 1634533791.168760 BlueQ kernel: BTRFS error (device sdb1): failed to r=
ebuild valid logical 22996545634304 for dev (efault)
>>>> 1634552685.203559 BlueQ kernel: BTRFS error (device sdb1): failed to r=
ebuild valid logical 23816815706112 for dev (efault)
>>>=20
>>> You won't want to see this message at all.
>>>=20
>>> This means, you're running RAID56, as btrfs has write-hole problem,
>>> which will degrade the robust of RAID56 byte by byte for each unclean
>>> shutdown.
>>>=20
>>> I guess the write hole problem has already make the repair failed for
>>> the replace.
>>>=20
>>> Thus after a successful mount, scrub and manually file checking is
>>> almost a must.
>>>=20
>>>> 1634558977.979621 BlueQ kernel: BTRFS info (device sdb1): dev_replace =
from <missing disk> (devid 1) to /dev/sde1 finished
>>>> 1634560793.132731 BlueQ kernel: zram0: detected capacity change from 3=
2610864 to 0
>>>> 1634560793.169379 BlueQ kernel: zram: Removed device: zram0
>>>> 1634560883.549481 BlueQ kernel: watchdog: watchdog0: watchdog did not =
stop!
>>>> 1634560883.556038 BlueQ systemd-shutdown[1]: Syncing filesystems and b=
lock devices.
>>>> 1634560883.572840 BlueQ systemd-shutdown[1]: Sending SIGTERM to remain=
ing processes...
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>>>> =E2=80=A6
>>>>>=20
>>>>> And dmesg for the failed mount?
>>>>>=20
>>>>=20
>>>> Oops, I must have missed that it failed because of missing devid 1 too=
...
>>>>=20
>>>> 1634562944.145383 BlueQ kernel: BTRFS info (device sde1): flagging fs =
with big metadata feature
>>>> 1634562944.145529 BlueQ kernel: BTRFS info (device sde1): force zstd c=
ompression, level 2
>>>> 1634562944.145650 BlueQ kernel: BTRFS info (device sde1): using free s=
pace tree
>>>> 1634562944.145697 BlueQ kernel: BTRFS info (device sde1): has skinny e=
xtents
>>>> 1634562944.148709 BlueQ kernel: BTRFS error (device sde1): devid 1 uui=
d 51645efd-bf95-458d-b5ae-b31623533abb is missing
>>>> 1634562944.148764 BlueQ kernel: BTRFS error (device sde1): failed to r=
ead chunk tree: -2
>>>> 1634562944.185369 BlueQ kernel: BTRFS error (device sde1): open_ctree =
failed
>>>=20
>>> This doesn't sound correct.
>>>=20
>>> If a device is properly replaced, it should have the same devid number.
>>>=20
>>> I guess you have tried to add a new device before, and then tried to
>>> replace the missing device, right?
>>>=20
>>>=20
>>> Anyway, have you tried to mount it degraded and then remove the missing
>>> device?
>>>=20
>>> Since you're using RAID56, I guess degrade mount should work.
>>>=20
>>> Thanks,
>>> Qu
>>>=20
>>>>=20
>>>>> Thanks,
>>>>> Qu
>>>>>> =E2=80=A6
>>>>=20
