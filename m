Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90EEDA7B82
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 08:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfIDGSO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 02:18:14 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:34242 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfIDGSN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 02:18:13 -0400
Received: by mail-wm1-f54.google.com with SMTP id y135so1675748wmc.1
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2019 23:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liland-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+N70KB0cAF8uvY64bZ55A8GRbGop9ImHUEvC1McGbIc=;
        b=VVeLVFD5IPlsmKvmw4lQJXpt6w9hng1e1ahbcIgkwEKNm2uEkcMl2hNzImudub/99u
         MooC1x8ObiluLcMaoxtc/8cOjWYa5jLBlgADxJdbceWkgp8YGAX12B9y5YHP4GpD6yZN
         E5Fzjksq6EdfqdI3H6BxzQoKwci6U0dSiv8nDuiGBzgOfXgBtcwIz2A6zw257fmIa9aR
         CipDcU16jw4PTi3+kl5JH5SPBhbvIlRUeI2SwMjQJqmrEeXgZtVYsZ/AlS6iRIOwlK5B
         YSgvTycWBm10bGSiiaueZWAr8SBJ3R58W8hrUKP2yc+GfqPnIuk3uppj/Y4zN7LOtuSN
         bIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+N70KB0cAF8uvY64bZ55A8GRbGop9ImHUEvC1McGbIc=;
        b=DFmegb5wHxRyeQwr2vewgCIhaUJ+jWvknPhMViaCn3PwyXKD9GTZy3y7YPt68xHQJ2
         TyOD+dxwfHVWWy8INg2QCsxtVzthofho0fu4FHTGbGf1NNtC7FsLPeU8mN3uDwz+V31z
         Vw6T4COxGdAQPGpzhIK3fNKhl61pD6dZPdvHUhP58iUAmKaANSpGpW7QonPPV4bhMRnJ
         06YPoC/SzMDORgtfJ0kcP3RKR9EjK31+Tz/BqhBdu15873DDooQrQPO/JWLVuQeF5xxM
         CmFWJYZisfrQ4zCxeJWiHV1bW8UF6ZeaaUxal4pB+TVjbMGJdWmBYGT0g2UV3HqAguSG
         ZRAQ==
X-Gm-Message-State: APjAAAWyyWj9WB8EfSqSuQXTlNjYB25ZDfhp8atJuUYMa8suFIEOOPxS
        ab8sPLgf2H0gXE/UQbM6vRwtBuZntrsdIeUC7Ui2rc5Iv9CUUdNZA0pzLAWs3dPBtAVHGo1OgZV
        VL3agKLvHpTaUWUjCFldxXw==
X-Google-Smtp-Source: APXvYqyCZlwXa6MykZnM8zDvH4p5vDcwXTp48gPgkUYjag1eULhhVLEoOmj2B2HeJGX++jjU2wgh1Q==
X-Received: by 2002:a05:600c:204d:: with SMTP id p13mr2986435wmg.114.1567577890704;
        Tue, 03 Sep 2019 23:18:10 -0700 (PDT)
Received: from [192.168.42.1] (84-112-118-202.cable.dynamic.surfer.at. [84.112.118.202])
        by smtp.gmail.com with ESMTPSA id 207sm3635857wme.17.2019.09.03.23.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 23:18:10 -0700 (PDT)
Subject: Re: Unmountable degraded BTRFS RAID6 filesystem
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <f58d5ec1-4b38-ad8b-068d-d3bb1f616ec2@liland.com>
 <CAJCQCtTqetLF1sMmgoPyN=2FOHu+MSSW-MGsN6NairLPdNmK+g@mail.gmail.com>
 <c57b8314-4914-628c-f62b-c5291a6be53c@liland.com>
 <CAJCQCtT5WecG26YXE6EVwhv52xSY_sm8GqgLDoQbZBUom4Pw7Q@mail.gmail.com>
From:   Edmund Urbani <edmund.urbani@liland.com>
Message-ID: <3d683d4c-375a-e5ed-ebd7-188c2b10f925@liland.com>
Date:   Wed, 4 Sep 2019 08:18:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtT5WecG26YXE6EVwhv52xSY_sm8GqgLDoQbZBUom4Pw7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 09/04/2019 07:36 AM, Chris Murphy wrote:
> On Tue, Sep 3, 2019 at 10:41 PM Edmund Urbani <edmund.urbani@liland.com> =
wrote:
>> Also there are a few of these:
>> Sep  1 21:10:17 phoenix kernel: ata6.00: exception Emask 0x0 SAct
>> 0x10000020 SErr 0x0 action 0x0
>> Sep  1 21:10:17 phoenix kernel: ata6.00: irq_stat 0x40000008
>> Sep  1 21:10:17 phoenix kernel: ata6.00: failed command: READ FPDMA QUEU=
ED
>> Sep  1 21:10:17 phoenix kernel: ata6.00: cmd
>> 60/20:28:80:66:09/00:00:50:01:00/40 tag 5 ncq dma 16384 in\x0a
>> res 41/40:00:88:66:09/00:00:50:01:00/40 Emask 0x409 (media error) <F>
>> Sep  1 21:10:17 phoenix kernel: ata6.00: status: { DRDY ERR }
>> Sep  1 21:10:17 phoenix kernel: ata6.00: error: { UNC }
>> Sep  1 21:10:17 phoenix kernel: ata6.00: configured for UDMA/133
>> Sep  1 21:10:17 phoenix kernel: sd 5:0:0:0: [sdf] tag#5 UNKNOWN(0x2003)
>> Result: hostbyte=3D0x00 driverbyte=3D0x08
>> Sep  1 21:10:17 phoenix kernel: sd 5:0:0:0: [sdf] tag#5 Sense Key : 0x3
>> [current]
>> Sep  1 21:10:17 phoenix kernel: sd 5:0:0:0: [sdf] tag#5 ASC=3D0x11 ASCQ=
=3D0x4
>> Sep  1 21:10:17 phoenix kernel: sd 5:0:0:0: [sdf] tag#5 CDB: opcode=3D0x=
88
>> 88 00 00 00 00 01 50 09 66 80 00 00 00 20 00 00
>> Sep  1 21:10:17 phoenix kernel: print_req_error: I/O error, dev sdf,
>> sector 5637760640
>> Sep  1 21:10:17 phoenix kernel: BTRFS error (device sdb1): bdev
>> /dev/sdf1 errs: wr 0, rd 289, flush 0, corrupt 0, gen 0
>> Sep  1 21:10:17 phoenix kernel: ata6: EH complete
>> Sep  1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
>> checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
>> level 0
>> Sep  1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
>> checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
>> level 0
>> Sep  1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
>> checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
>> level 0
>> Sep  1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
>> checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
>> level 0
>> Sep  1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
>> checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
>> level 0
>> Sep  1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
>> checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
>> level 0
>> Sep  1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
>> checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
>> level 0
>> Sep  1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
>> checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
>> level 0
>> Sep  1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
>> checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
>> level 0
> OK so the file system is not degraded, but sdb1 is giving you
> problems, so you've deleted it and its in the process of being removed
> (fs shrink, move chunks, and restripe).
I am about to install the old sdb in another system to try ddrescue on
it and see what I can salvage.
>
> Here /dev/sdf has  issued an uncorrectable read error. Classic case of
> bad sector. And btrfs is trying to get data off sdb1 to try and fix
> it, but this fails with checksum errors multiple times. So basically
> it is a two device failure for the stripe currently being read. It
> should still be possible to recover the stripe unless there is one
> more error from another drive - but the included dmesg doesn't go on
> far enough to tell us how this event turned out.
I suspect that whatever is in sector 5637760640 on sdf is metadata. I
grepped the log for it and that bad sector pops up 10000+ times.


>
>
>> I am still looking for log entries related to the filesystem going
>> read-only. Not sure when exactly that happened and the logs are spammed
>> with plenty of the above...
> They're relevant because if there's a third failure at the same time,
> and if it affects metadata, reconstruction isn't possible, the
> metadata is missing. So then it's, what's missing and can it be
> manually reconstructed. It's super tedious.
>
apparently, this is where it went read-only:

Sep=C2=A0 3 00:31:31 phoenix kernel: ata1.01: exception Emask 0x0 SAct 0x0
SErr 0x0 action 0x0
Sep=C2=A0 3 00:31:31 phoenix kernel: ata1.01: BMDMA stat 0x64
Sep=C2=A0 3 00:31:31 phoenix kernel: ata1.01: failed command: READ DMA EXT
Sep=C2=A0 3 00:31:31 phoenix kernel: ata1.01: cmd
25/00:20:80:72:5a/00:00:a9:00:00/f0 tag 0 dma 16384 in\x0a=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res
51/40:20:80:72:5a/40:00:a9:00:00/f0 Emask 0x9 (media error)
Sep=C2=A0 3 00:31:31 phoenix kernel: ata1.01: status: { DRDY ERR }
Sep=C2=A0 3 00:31:31 phoenix kernel: ata1.01: error: { UNC }
Sep=C2=A0 3 00:31:31 phoenix kernel: ata1.00: configured for UDMA/100
Sep=C2=A0 3 00:31:31 phoenix kernel: ata1.01: configured for UDMA/100
Sep=C2=A0 3 00:31:31 phoenix kernel: sd 0:0:1:0: [sdb] tag#0 UNKNOWN(0x2003=
)
Result: hostbyte=3D0x00 driverbyte=3D0x08
Sep=C2=A0 3 00:31:31 phoenix kernel: sd 0:0:1:0: [sdb] tag#0 Sense Key : 0x=
3
[current]
Sep=C2=A0 3 00:31:31 phoenix kernel: sd 0:0:1:0: [sdb] tag#0 ASC=3D0x11 ASC=
Q=3D0x4
Sep=C2=A0 3 00:31:31 phoenix kernel: sd 0:0:1:0: [sdb] tag#0 CDB: opcode=3D=
0x88
88 00 00 00 00 00 a9 5a 72 80 00 00 00 20 00 00
Sep=C2=A0 3 00:31:31 phoenix kernel: print_req_error: I/O error, dev sdb,
sector 2841277056
Sep=C2=A0 3 00:31:31 phoenix kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 14786, flush 0, corrupt 0, gen 0
Sep=C2=A0 3 00:31:31 phoenix kernel: ata1: EH complete
Sep=C2=A0 3 00:31:31 phoenix kernel: BTRFS info (device sdb1): read error
corrected: ino 0 off 34958490861568 (dev /dev/sdb1 sector 2841275008)
Sep=C2=A0 3 00:31:31 phoenix kernel: BTRFS info (device sdb1): read error
corrected: ino 0 off 34958490865664 (dev /dev/sdb1 sector 2841275016)
Sep=C2=A0 3 00:31:31 phoenix kernel: BTRFS info (device sdb1): read error
corrected: ino 0 off 34958490869760 (dev /dev/sdb1 sector 2841275024)
Sep=C2=A0 3 00:31:31 phoenix kernel: BTRFS info (device sdb1): read error
corrected: ino 0 off 34958490873856 (dev /dev/sdb1 sector 2841275032)
Sep=C2=A0 3 00:31:39 phoenix kernel: ata1.01: exception Emask 0x0 SAct 0x0
SErr 0x0 action 0x0
Sep=C2=A0 3 00:31:39 phoenix kernel: ata1.01: BMDMA stat 0x64
Sep=C2=A0 3 00:31:39 phoenix kernel: ata1.01: failed command: READ DMA EXT
Sep=C2=A0 3 00:31:39 phoenix kernel: ata1.01: cmd
25/00:20:60:74:5b/00:00:a9:00:00/f0 tag 0 dma 16384 in\x0a=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res
51/40:20:60:74:5b/40:00:a9:00:00/f0 Emask 0x9 (media error)
Sep=C2=A0 3 00:31:39 phoenix kernel: ata1.01: status: { DRDY ERR }
Sep=C2=A0 3 00:31:39 phoenix kernel: ata1.01: error: { UNC }
Sep=C2=A0 3 00:31:39 phoenix kernel: ata1.00: configured for UDMA/100
Sep=C2=A0 3 00:31:39 phoenix kernel: ata1.01: configured for UDMA/100
Sep=C2=A0 3 00:31:39 phoenix kernel: sd 0:0:1:0: [sdb] tag#0 UNKNOWN(0x2003=
)
Result: hostbyte=3D0x00 driverbyte=3D0x08
Sep=C2=A0 3 00:31:39 phoenix kernel: sd 0:0:1:0: [sdb] tag#0 Sense Key : 0x=
3
[current]
Sep=C2=A0 3 00:31:39 phoenix kernel: sd 0:0:1:0: [sdb] tag#0 ASC=3D0x11 ASC=
Q=3D0x4
Sep=C2=A0 3 00:31:39 phoenix kernel: sd 0:0:1:0: [sdb] tag#0 CDB: opcode=3D=
0x88
88 00 00 00 00 00 a9 5b 74 60 00 00 00 20 00 00
Sep=C2=A0 3 00:31:39 phoenix kernel: print_req_error: I/O error, dev sdb,
sector 2841343072
Sep=C2=A0 3 00:31:39 phoenix kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 14787, flush 0, corrupt 0, gen 0
Sep=C2=A0 3 00:31:39 phoenix kernel: ata1: EH complete
Sep=C2=A0 3 00:31:39 phoenix kernel: btree_readpage_end_io_hook: 8 callback=
s
suppressed
Sep=C2=A0 3 00:31:39 phoenix kernel: BTRFS error (device sdb1): bad tree
block start 3417494780583899951 34958760591360
Sep=C2=A0 3 00:31:39 phoenix kernel: BTRFS error (device sdb1): bad tree
block start 3417494780583899951 34958760591360
Sep=C2=A0 3 00:31:39 phoenix kernel: BTRFS error (device sdb1): bad tree
block start 3417494780583899951 34958760591360
Sep=C2=A0 3 00:31:39 phoenix kernel: BTRFS error (device sdb1): bad tree
block start 3417494780583899951 34958760591360
Sep=C2=A0 3 00:31:39 phoenix kernel: BTRFS error (device sdb1): bad tree
block start 3417494780583899951 34958760591360
Sep=C2=A0 3 00:31:39 phoenix kernel: BTRFS error (device sdb1): bad tree
block start 3417494780583899951 34958760591360
Sep=C2=A0 3 00:31:39 phoenix kernel: BTRFS error (device sdb1): bad tree
block start 3417494780583899951 34958760591360
Sep=C2=A0 3 00:31:39 phoenix kernel: BTRFS error (device sdb1): bad tree
block start 3417494780583899951 34958760591360
Sep=C2=A0 3 00:31:39 phoenix kernel: BTRFS error (device sdb1): bad tree
block start 3417494780583899951 34958760591360
Sep=C2=A0 3 00:31:39 phoenix kernel: BTRFS: error (device sdb1) in
__btrfs_free_extent:7084: errno=3D-5 IO failure
Sep=C2=A0 3 00:31:39 phoenix kernel: BTRFS info (device sdb1): forced reado=
nly
Sep=C2=A0 3 00:31:39 phoenix kernel: BTRFS: error (device sdb1) in
btrfs_run_delayed_refs:3089: errno=3D-5 IO failure
Sep=C2=A0 3 00:31:39 phoenix kernel: BTRFS error (device sdb1): pending csu=
ms
is 24776704
>
>
>
>>>> [ 8904.358088] BTRFS info (device sda1): allowing degraded mounts
>>>> [ 8904.358089] BTRFS info (device sda1): disk space caching is enabled
>>>> [ 8904.358091] BTRFS info (device sda1): has skinny extents
>>>> [ 8904.361743] BTRFS warning (device sda1): devid 8 uuid
>>>> 0e8b4aff-6d64-4d31-a135-705421928f94 is missing
>>>> [ 8905.705036] BTRFS info (device sda1): bdev (null) errs: wr 0, rd
>>>> 14809, flush 0, corrupt 4, gen 0
>>>> [ 8905.705041] BTRFS info (device sda1): bdev /dev/sda1 errs: wr 0, rd
>>>> 4, flush 0, corrupt 0, gen 0
>>>> [ 8905.705052] BTRFS info (device sda1): bdev /dev/sdf1 errs: wr 0, rd
>>>> 10543, flush 0, corrupt 0, gen 0
>>>> [ 8905.705062] BTRFS info (device sda1): bdev /dev/sdc1 errs: wr 0, rd
>>>> 8, flush 0, corrupt 0, gen 0
>>> four devices with read errors
>>>
>>> When was the last time the volume was scrubbed? Do you know for sure
>>> these errors have not gone up at all since the last successful scrub?
>>> And were any errors reported for that last scrub?
>> Oh, that must have been quite a while ago. Sometime in 2018? Maybe? All
>> these drives have been up and running for several years now. sda and sdc
>> should still be fine, the replaced drive is sdb and sdf is next in line.
> There's evidence of four drives with problems at some point in time.
> And there's evidence in the kernel messages above of at least two
> problems at the same time with the same stripe. So, all it takes is
> one more problem with that stripe, and then that stripe can't be
> recovered - and if it's a metadata stripe? That's 512KiB of metadata
> lost, which is quite a lot, it probably kills the file system,
> depending on where it happens. If it's data - no big deal. Btrfs won't
> even care, it will just report EIO and the path to the bad file, and
> continue on.
>
> The whole point of regular scrubs is to prevent single sector
> corruptions and failures. If you don't do that, they can accumulate
> over time and then it's a huge problem when just one drive dies. So
> when did you last do a scrub? Are they all the same make model drive?
> Do they all have the same SCT ERC value? And is that value, for all
> drives, less than the value found at /sys/block/sdN/device/timeout ?
I'll make sure to setup a cron job for monthly scrubbing once this is
over. I really can't remember exactly when I last did a manual scrub.

They are all WD Red 3TB, though not all the same generation.

smartctl reports these models:
Device Model:=C2=A0=C2=A0=C2=A0=C2=A0 WDC WD30EFRX-68AX9N0
Device Model:=C2=A0=C2=A0=C2=A0=C2=A0 WDC WD30EFRX-68EUZN0

The timeout under /sys is 30 for all of them.

I am not sure what you mean by SCT ERC value and where to look for that.
Here's all the info smartctl gives me about sda:

smartctl 6.6 2017-11-05 r4594 [x86_64-linux-5.2.9-gentoo] (local build)
Copyright (C) 2002-17, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:=C2=A0=C2=A0=C2=A0=C2=A0 Western Digital Red
Device Model:=C2=A0=C2=A0=C2=A0=C2=A0 WDC WD30EFRX-68AX9N0
Serial Number:=C2=A0=C2=A0=C2=A0 WD-WMC1T1311633
LU WWN Device Id: 5 0014ee 602ee2554
Firmware Version: 80.00A80
User Capacity:=C2=A0=C2=A0=C2=A0 3,000,592,982,016 bytes [3.00 TB]
Sector Sizes:=C2=A0=C2=A0=C2=A0=C2=A0 512 bytes logical, 4096 bytes physica=
l
Device is:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 In smartctl database [=
for details use: -P show]
ATA Version is:=C2=A0=C2=A0 ACS-2 (minor revision not indicated)
SATA Version is:=C2=A0 SATA 3.0, 6.0 Gb/s (current: 3.0 Gb/s)
Local Time is:=C2=A0=C2=A0=C2=A0 Wed Sep=C2=A0 4 06:04:20 2019 -00
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:=C2=A0 (0x00) Offline data collection activi=
ty
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 was never started.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Auto Offline Data Collection:
Disabled.
Self-test execution status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (=C2=A0=C2=A0 0) =
The previous self-test routine
completed
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 without error or no self-test
has ever
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 been run.
Total time to complete Offline
data collection:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (40320) seconds.
Offline data collection
capabilities:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x7b) SMART execute=
 Offline immediate.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Auto Offline data collection
on/off support.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Suspend Offline collection upon new
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 command.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Offline surface scan supported.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Self-test supported.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Conveyance Self-test supported.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Selective Self-test supported.
SMART capabilities:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 (0x0003) Saves SMART data before entering
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 power-saving mode.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Supports SMART auto save timer.
Error logging capability:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x01) =
Error logging supported.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 General Purpose Logging supported.
Short self-test routine
recommended polling time:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (=C2=A0=
=C2=A0 2) minutes.
Extended self-test routine
recommended polling time:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ( 404) =
minutes.
Conveyance self-test routine
recommended polling time:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (=C2=A0=
=C2=A0 5) minutes.
SCT capabilities:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (0x70bd) SCT Status supported.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 SCT Error Recovery Control
supported.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 SCT Feature Control supported.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FL=
AG=C2=A0=C2=A0=C2=A0=C2=A0 VALUE WORST THRESH TYPE=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
UPDATED=C2=A0 WHEN_FAILED RAW_VALUE
=C2=A0 1 Raw_Read_Error_Rate=C2=A0=C2=A0=C2=A0=C2=A0 0x002f=C2=A0=C2=A0 200=
=C2=A0=C2=A0 200=C2=A0=C2=A0 051=C2=A0=C2=A0=C2=A0 Pre-fail=C2=A0
Always=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0
=C2=A0 3 Spin_Up_Time=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x0027=C2=A0=C2=A0 178=C2=A0=C2=A0 177=C2=A0=C2=A0 021=C2=A0=
=C2=A0=C2=A0 Pre-fail=C2=A0
Always=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 6058
=C2=A0 4 Start_Stop_Count=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0032=
=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=A0 Old_age=
=C2=A0=C2=A0
Always=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 61
=C2=A0 5 Reallocated_Sector_Ct=C2=A0=C2=A0 0x0033=C2=A0=C2=A0 200=C2=A0=C2=
=A0 200=C2=A0=C2=A0 140=C2=A0=C2=A0=C2=A0 Pre-fail=C2=A0
Always=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0
=C2=A0 7 Seek_Error_Rate=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
002e=C2=A0=C2=A0 100=C2=A0=C2=A0 253=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=A0 Old_=
age=C2=A0=C2=A0
Always=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0
=C2=A0 9 Power_On_Hours=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x0032=C2=A0=C2=A0 020=C2=A0=C2=A0 020=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=
=A0 Old_age=C2=A0=C2=A0
Always=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 58487
=C2=A010 Spin_Retry_Count=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0032=
=C2=A0=C2=A0 100=C2=A0=C2=A0 253=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=A0 Old_age=
=C2=A0=C2=A0
Always=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0
=C2=A011 Calibration_Retry_Count 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 253=C2=
=A0=C2=A0 000=C2=A0=C2=A0=C2=A0 Old_age=C2=A0=C2=A0
Always=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0
=C2=A012 Power_Cycle_Count=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0032=C2=A0=
=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=A0 Old_age=C2=A0=
=C2=A0
Always=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 61
192 Power-Off_Retract_Count 0x0032=C2=A0=C2=A0 200=C2=A0=C2=A0 200=C2=A0=C2=
=A0 000=C2=A0=C2=A0=C2=A0 Old_age=C2=A0=C2=A0
Always=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 43
193 Load_Cycle_Count=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0032=C2=A0=
=C2=A0 200=C2=A0=C2=A0 200=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=A0 Old_age=C2=A0=
=C2=A0
Always=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 17
194 Temperature_Celsius=C2=A0=C2=A0=C2=A0=C2=A0 0x0022=C2=A0=C2=A0 110=C2=
=A0=C2=A0 098=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=A0 Old_age=C2=A0=C2=A0
Always=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 40
196 Reallocated_Event_Count 0x0032=C2=A0=C2=A0 200=C2=A0=C2=A0 200=C2=A0=C2=
=A0 000=C2=A0=C2=A0=C2=A0 Old_age=C2=A0=C2=A0
Always=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0
197 Current_Pending_Sector=C2=A0 0x0032=C2=A0=C2=A0 200=C2=A0=C2=A0 200=C2=
=A0=C2=A0 000=C2=A0=C2=A0=C2=A0 Old_age=C2=A0=C2=A0
Always=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0
198 Offline_Uncorrectable=C2=A0=C2=A0 0x0030=C2=A0=C2=A0 100=C2=A0=C2=A0 25=
3=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=A0 Old_age=C2=A0=C2=A0
Offline=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0
199 UDMA_CRC_Error_Count=C2=A0=C2=A0=C2=A0 0x0032=C2=A0=C2=A0 200=C2=A0=C2=
=A0 200=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=A0 Old_age=C2=A0=C2=A0
Always=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0
200 Multi_Zone_Error_Rate=C2=A0=C2=A0 0x0008=C2=A0=C2=A0 200=C2=A0=C2=A0 20=
0=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=A0 Old_age=C2=A0=C2=A0
Offline=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num=C2=A0 Test_Description=C2=A0=C2=A0=C2=A0 Status=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Remaining=C2=A0
LifeTime(hours)=C2=A0 LBA_of_first_error
# 1=C2=A0 Extended offline=C2=A0=C2=A0=C2=A0 Completed without error=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
13=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -

SMART Selective self-test log data structure revision number 1
=C2=A0SPAN=C2=A0 MIN_LBA=C2=A0 MAX_LBA=C2=A0 CURRENT_TEST_STATUS
=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 Not_testing
=C2=A0=C2=A0=C2=A0 2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 Not_testing
=C2=A0=C2=A0=C2=A0 3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 Not_testing
=C2=A0=C2=A0=C2=A0 4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 Not_testing
=C2=A0=C2=A0=C2=A0 5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 Not_testing
Selective self-test flags (0x0):
=C2=A0 After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.



>
>
>
>>>
>>>> I have tried all the mount / restore options listed here:
>>>> https://forums.unraid.net/topic/46802-faq-for-unraid-v6/page/2/?tab=3D=
comments#comment-543490
>>> Good. Stick with ro attempts for now. Including if you want to try a
>>> newer kernel. If it succeeds to mount ro, my advice is to update
>>> backups so at least critical information isn't lost. Back up while you
>>> can. Any repair attempt makes changes that will risk the data being
>>> permanently lost. So it's important to be really deliberate about any
>>> changes.
>> I'll let you know, when I have the new kernel up and running.
> I think you should have all the original drives installed, and try to
> mount -o ro first. And if that doesn't work, try -o ro,degraded, and
> then we'll just have to see which drive it doesn't like.
>
>
>
> --
> Chris Murphy
Well, I already tried mounting with 5.2.9 in the meantime without
success (without the original sdb drive). It still does not mount (mount
-o ro,degraded /dev/sda1 /mnt/shared/):

[=C2=A0 209.459309] BTRFS info (device sdg1): allowing degraded mounts
[=C2=A0 209.459313] BTRFS info (device sdg1): disk space caching is enabled
[=C2=A0 209.459314] BTRFS info (device sdg1): has skinny extents
[=C2=A0 209.461246] BTRFS warning (device sdg1): devid 8 uuid
0e8b4aff-6d64-4d31-a135-705421928f94 is missing
[=C2=A0 209.544603] BTRFS warning (device sdg1): devid 8 uuid
0e8b4aff-6d64-4d31-a135-705421928f94 is missing
[=C2=A0 211.401375] BTRFS info (device sdg1): bdev (efault) errs: wr 0, rd
14809, flush 0, corrupt 4, gen 0
[=C2=A0 211.401388] BTRFS info (device sdg1): bdev /dev/sdf1 errs: wr 0, rd
10543, flush 0, corrupt 0, gen 0
[=C2=A0 211.401391] BTRFS info (device sdg1): bdev /dev/sda1 errs: wr 0, rd
4, flush 0, corrupt 0, gen 0
[=C2=A0 211.401394] BTRFS info (device sdg1): bdev /dev/sdc1 errs: wr 0, rd
8, flush 0, corrupt 0, gen 0
[=C2=A0 215.381805] BTRFS error (device sdg1): bad tree block start, want
34958581399552 have 12170572967447269873
[=C2=A0 215.382603] BTRFS error (device sdg1): bad tree block start, want
34958581399552 have 12170572967447269873
[=C2=A0 215.386155] BTRFS error (device sdg1): bad tree block start, want
34958581399552 have 12170572967447269873
[=C2=A0 215.389539] BTRFS error (device sdg1): bad tree block start, want
34958581399552 have 12170572967447269873
[=C2=A0 215.393053] BTRFS error (device sdg1): bad tree block start, want
34958581399552 have 12170572967447269873
[=C2=A0 215.395223] BTRFS error (device sdg1): bad tree block start, want
34958581399552 have 12170572967447269873
[=C2=A0 215.397188] BTRFS error (device sdg1): bad tree block start, want
34958581399552 have 12170572967447269873
[=C2=A0 215.399307] BTRFS error (device sdg1): bad tree block start, want
34958581399552 have 12170572967447269873
[=C2=A0 215.402410] BTRFS error (device sdg1): bad tree block start, want
34958581399552 have 12170572967447269873
[=C2=A0 215.402447] BTRFS error (device sdg1): failed to read block groups:=
 -5
[=C2=A0 215.844527] BTRFS error (device sdg1): open_ctree failed


I'm planning to install the copy of sdb once ddrescue is done.

Regards,
=C2=A0Edmund

--=20
*Liland IT GmbH*


Ferlach =E2=97=8F Wien =E2=97=8F M=C3=BCnchen
Tel: +43 463 220111
Tel: +49 89=20
458 15 940
office@Liland.com
https://Liland.com <https://Liland.com>=C2=A0



Copyright =C2=A9 2019 Liland IT GmbH=C2=A0

Diese Mail enthaelt vertrauliche und/oder=20
rechtlich geschuetzte=C2=A0Informationen.=C2=A0
Wenn Sie nicht der richtige Adressat=20
sind oder diese Email irrtuemlich=C2=A0erhalten haben, informieren Sie bitt=
e=20
sofort den Absender und vernichten=C2=A0Sie diese Mail. Das unerlaubte Kopi=
eren=20
sowie die unbefugte Weitergabe=C2=A0dieser Mail ist nicht gestattet.=C2=A0

This=20
email may contain confidential and/or privileged information.=C2=A0
If you are=20
not the intended recipient (or have received this email in=C2=A0error) plea=
se=20
notify the sender immediately and destroy this email. Any=C2=A0unauthorised=
=20
copying, disclosure or distribution of the material in this=C2=A0email is=
=20
strictly forbidden.

