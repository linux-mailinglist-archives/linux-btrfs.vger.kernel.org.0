Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9644335B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 14:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhJSMSt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 08:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhJSMSs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 08:18:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2ADC06161C
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 05:16:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b189-20020a1c1bc6000000b0030da052dd4fso2833136wmb.3
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 05:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=WL7vLraaUPbTrYRdvniVhFsHZ6Jf+8K0M7mXj4CjYAA=;
        b=RyeEJm3zuLHQAGTNihfMcXzZMxptxuaj1kT7z99K9pKsiHFiLr1JLMmMkzOzNaVBaC
         SA7pvGCFmw3g8vhIjB6W7DlfMideGpM7s3jpOexWMmGZeNOsfr5eOJvMyMXL+2ePm2AJ
         BXXLz+YlQ8EWLXHiTlvsRcclVcIzcPxESJ+ggcoHTJtLEVYbB4O1WYL87sPOtPWKW3Vx
         /uYvr/7eqzSLN4AubDcb8ZNQmHtSeCNq1gxXHT6GZ/UPTILkgI69/jiBc+sTPxZEGeYR
         P1tkYYVrT92wknAti5U+odHcWCIVztHrjOogTxRM2WSROxEif15sA2UrGh691x81fd51
         VlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=WL7vLraaUPbTrYRdvniVhFsHZ6Jf+8K0M7mXj4CjYAA=;
        b=yj8KzR+sg7hJGxqwAtd/qH8r7EydU4QJvCNQfqiIy4fcXKx3ozyZLTWP+ETbNh7/72
         WmVc3p7T0UagE6kKCMJl/akwUq/Ihf/hlSf8ZGVnGVJ2zUattFlRm0KVqNfH2v/Z11NS
         fqZbhE/gIn9tbI5wcj3pHkj1hl33n1fUF6DueHnuKvXMuJvFGHtF422EYVq8qHv7uZEa
         M1ZPFkjYAkbVVJ+1/oEcxcgU7SOjseds7U9J3kvQcz/YeTgX+BMBdfujLuaMX5EUqYPr
         f8t3swyovJcQ/xNs8/x1yxC/oD/goh1767vfZ6dkALcco0oKCiTRrHPSzxxjifVYYIAx
         pnFQ==
X-Gm-Message-State: AOAM531NCBRAlCqzOvt6dCuhpAdCoydQrtGG258Q5OgG4ATXz8F+Dxd5
        44W6qCjekngIzT+koMo84CvOZmpTfDY=
X-Google-Smtp-Source: ABdhPJzwdH7FdVTaiHzRzAjdtHOg/wb34ku7tNZ+ZnAlDKnuM9VTALWcxRtzXYDlZqozxpeEWf4JAg==
X-Received: by 2002:a1c:ac03:: with SMTP id v3mr5783533wme.127.1634645793695;
        Tue, 19 Oct 2021 05:16:33 -0700 (PDT)
Received: from [127.0.0.1] (p5796730c.dip0.t-ipconnect.de. [87.150.115.12])
        by smtp.gmail.com with ESMTPSA id c17sm2323355wmk.23.2021.10.19.05.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 05:16:33 -0700 (PDT)
Date:   Tue, 19 Oct 2021 12:16:35 +0000 (UTC)
From:   Emil Heimpel <broetchenrackete@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <64e5b8aa-bc49-4596-b4ff-8cc780a6513d@gmail.com>
In-Reply-To: <28511d75-f76b-f587-3474-554e8bf2aa22@gmx.com>
References: <ed4a7a10-d5a4-4b62-8e67-0b971487a74a@gmail.com> <47f76535-12c3-996e-3306-0bf0f4eed57e@gmx.com> <297b21db-4a67-469d-9ae1-54b1043dac31@gmail.com> <28511d75-f76b-f587-3474-554e8bf2aa22@gmx.com>
Subject: Re: Errors after successful disk replace
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <64e5b8aa-bc49-4596-b4ff-8cc780a6513d@gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Color me suprised:


[74713.072745] BTRFS info (device sde1): flagging fs with big metadata feat=
ure
[74713.072755] BTRFS info (device sde1): allowing degraded mounts
[74713.072758] BTRFS info (device sde1): using free space tree
[74713.072760] BTRFS info (device sde1): has skinny extents
[74713.104297] BTRFS warning (device sde1): devid 1 uuid 51645efd-bf95-458d=
-b5ae-b31623533abb is missing
[74714.675001] BTRFS info (device sde1): bdev (efault) errs: wr 52950, rd 8=
161, flush 0, corrupt 1221, gen 0
[74714.675015] BTRFS info (device sde1): bdev /dev/sdb1 errs: wr 0, rd 0, f=
lush 0, corrupt 228, gen 0
[74714.675025] BTRFS info (device sde1): bdev /dev/sdc1 errs: wr 0, rd 0, f=
lush 0, corrupt 140, gen 0
[74751.033383] BTRFS info (device sde1): continuing dev_replace from <missi=
ng disk> (devid 1) to target /dev/sde1 @74%
[bluemond@BlueQ ~]$ sudo btrfs replace status=C2=A0 -1 /mnt/btrfsrepair/
74.9% done, 0 write errs, 0 uncorr. read errs

I guess I just wait?

Oct 19, 2021 13:37:09 Qu Wenruo <quwenruo.btrfs@gmx.com>:

>=20
>=20
> On 2021/10/19 18:49, Emil Heimpel wrote:
>>=20
>> Oct 19, 2021 07:35:54 Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>=20
>>>=20
>>>=20
>>> On 2021/10/19 11:54, Emil Heimpel wrote:
>>>> Hi all,
>>>>=20
>>>> One of my drives of a raid 5 btrfs array failed (was dead completely) =
so I installed an identical replacement drive. The dead drive was devid 1 a=
nd the new drive /dev/sde. I used the following to replace the missing driv=
e:
>>>>=20
>>>> sudo btrfs replace start -B 1 /dev/sde1 /mnt/btrfsrepair/
>>>>=20
>>>> and it completed successfully without any reported errors (took around=
 2 weeks though...).
>>>>=20
>>>> I then tried to see my array with filesystem show, but it hung (or too=
k longer than I wanted to wait), so I did a reboot.
>>>=20
>>> Any dmesg of that time?
>>>=20
>>=20
>> Nothing after the replace finished:
>>=20
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
>=20
> *failed*...
>=20
>> 1634475910.611261 BlueQ kernel: sd 9:0:2:0: attempting task abort!scmd(0=
x0000000046fead3f), outstanding for 7120 ms & timeout 7000 ms
>> 1634475910.615126 BlueQ kernel: sd 9:0:2:0: [sdd] tag#840 CDB: ATA comma=
nd pass through(16) 85 08 2e 00 00 00 01 00 00 00 00 00 00 00 ec 00
>> 1634475910.615429 BlueQ kernel: scsi target9:0:2: handle(0x000b), sas_ad=
dress(0x4433221105000000), phy(5)
>> 1634475910.615691 BlueQ kernel: scsi target9:0:2: enclosure logical id(0=
x590b11c022f3fb00), slot(6)
>=20
> And ATA commands failure.
>=20
> I don't believe the replace finished without problem, and the involved
> device is /dev/sdd.
>=20
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
>=20
> You won't want to see this message at all.
>=20
> This means, you're running RAID56, as btrfs has write-hole problem,
> which will degrade the robust of RAID56 byte by byte for each unclean
> shutdown.
>=20
> I guess the write hole problem has already make the repair failed for
> the replace.
>=20
> Thus after a successful mount, scrub and manually file checking is
> almost a must.
>=20
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
>>=20
>>=20
>>=20
>>=20
>>>>=20
>>>> It showed up after a reboot as followed:
>>>>=20
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
>>>>=20
>>>> I then tried to mount it, but it failed, so I run a readonly check and=
 it reported the following problem:
>>>=20
>>> And dmesg for the failed mount?
>>>=20
>>=20
>> Oops, I must have missed that it failed because of missing devid 1 too..=
.
>>=20
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
>=20
> This doesn't sound correct.
>=20
> If a device is properly replaced, it should have the same devid number.
>=20
> I guess you have tried to add a new device before, and then tried to
> replace the missing device, right?
>=20
>=20
> Anyway, have you tried to mount it degraded and then remove the missing
> device?
>=20
> Since you're using RAID56, I guess degrade mount should work.
>=20
> Thanks,
> Qu
>=20
>>=20
>>> Thanks,
>>> Qu
>>>>=20
>>>> [...]
>>>> [2/7] checking extents
>>>> ERROR: super total bytes 38007432437760 smaller than real device(s) si=
ze 46008994590720
>>>> ERROR: mounting this fs may fail for newer kernels
>>>> ERROR: this can be fixed by 'btrfs rescue fix-device-size'
>>>> [3/7] checking free space tree
>>>> [...]
>>>>=20
>>>> So I followed that advice but got the following error:
>>>>=20
>>>> sudo btrfs rescue fix-device-size /dev/sde1
>>>> ERROR: devid 1 is missing or not writeable
>>>> ERROR: fixing device size needs all device(s) to be present and writea=
ble
>>>>=20
>>>> So it seems something went wrong or didn't complete fully.
>>>> What can I do to fix this problem?
>>>>=20
>>>> uname -a
>>>> Linux BlueQ 5.14.12-arch1-1 #1 SMP PREEMPT Wed, 13 Oct 2021 16:58:16 +=
0000 x86_64 GNU/Linux
>>>>=20
>>>> btrfs --version
>>>> btrfs-progs v5.14.2
>>>>=20
>>>> Regards,
>>>> Emil
>>>>=20
>>>> P.S.: Yes, I know, raid5 isn't stable but it works good enough for me =
;)
>>>> Metadata is raid1 btw...
>>>>=20
>>=20
