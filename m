Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC320196FB1
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Mar 2020 21:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgC2TY7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Mar 2020 15:24:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39348 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbgC2TY7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Mar 2020 15:24:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id b62so16839633qkf.6
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Mar 2020 12:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clarafamily.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2Pz/4zY/75/n1Xuvp8lgvt1vWftmDrdgv1iju2bcBpo=;
        b=nHNP255L3E5syWEphSZo2xgk11nsO7qxgRDOZ1/kLj+CZ5gMljDuLKjbQRNIOftiXv
         qOo6eNsO+X1AszIdBOdHFLPFUsqLJRCxkGHtfBx5lL1eCnfe1hvPR1prcRnM6p9+qVCo
         GmXwiDA5R5s9ZRAQCnncvHsz/ULFxwsP2kcBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2Pz/4zY/75/n1Xuvp8lgvt1vWftmDrdgv1iju2bcBpo=;
        b=HPbpCmTirdl6/1Szogv76BP0i9sjF0inDVRQHvLG26xkW0gWVLJ4QTwT16/zUrOwET
         sxCfIPGFTg0MULxO0pF/40Ux+QwRZQy1P8mBmbv521bkf7p4pTARS3K/qgTsITkdYE7Y
         KxUHLlc8gJ3wd25mJ6Ny5352NcidiemhzS0PLkGUPCRD1JYtlJMcVS0E9TirZc/BOEo2
         0b9TbDqMz/si9sigltu85eSsQr9RjO9L44oJJDsX3Td9CZmSTKMuY8aZxBBhYWxnsTpB
         f5Li126rILYPMcLCynDmFuPWVLL/cAHyuXulUV2TJEfoZDFk0GlVScx12wi6ub3S8NVM
         khGg==
X-Gm-Message-State: ANhLgQ21z9BWYW3pdakXZG0u446zH0TQ1ntOgxxCAX3EsqAJzlCsLPsf
        qoq2aDAocm6MU5dAcZIhKdiEcA3P0QIvQw==
X-Google-Smtp-Source: ADFU+vttYuuSNjqegpmFNwkN+jVb3OOT/WWxTswNjx1C2DIJ31Ca4tB18VRdmpxnUYfCgQvpFfwUTw==
X-Received: by 2002:a37:8d42:: with SMTP id p63mr8752841qkd.182.1585509897292;
        Sun, 29 Mar 2020 12:24:57 -0700 (PDT)
Received: from mbp-retina-13.clara (CPE40623100049e-CM9050cac9ddf0.cpe.net.cable.rogers.com. [99.247.249.188])
        by smtp.gmail.com with ESMTPSA id 69sm8595236qki.131.2020.03.29.12.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2020 12:24:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Device Delete Stuck
From:   Jason Clara <jason@clarafamily.com>
In-Reply-To: <20200329185513.GD13306@hungrycats.org>
Date:   Sun, 29 Mar 2020 15:24:52 -0400
Cc:     linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <31FC1C90-AA7A-4FC1-8058-A45D76D5A029@clarafamily.com>
References: <B7A6E37C-C10A-49C3-B98A-0D659CA4E33B@clarafamily.com>
 <20200329185513.GD13306@hungrycats.org>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks, I will give it a try.   Your step 1 is actually what I used to =
detect the errors the first time when the delete would cause the system =
to hang completely.  I then deleted all bad files and restored from a =
backup.  I did do a scrub after that, but didn=E2=80=99t repeat step 1 =
again.

I will try your suggestion and repeat the steps till I see no errors.

Also, I understand the state of RAID 5/6.  This pool has all important =
data backed up to another RAID1 pool daily.  I am actually trying to =
reduce the size of this pool to add to the RAID1 pool.

It was previously a RAID1 pool I converted to RAID6 and since then I =
have not been able to remove that device.

> On Mar 29, 2020, at 2:55 PM, Zygo Blaxell =
<ce3g8jdj@umail.furryterror.org> wrote:
>=20
> On Sun, Mar 29, 2020 at 10:13:05AM -0400, Jason Clara wrote:
>> I had a previous post about when trying to do a device delete that
>> it would cause my whole system to hang.  I seem to have got past
>> that issue.
>>=20
>> For that, it seems like even though all the SCRUBs finished without
>> any errors I still had a problem with some files.  By forcing a read
>> of every single file I was able to detect the bad files in DMESG.
>> Not sure though why SCRUB didn=E2=80=99t detect this.  BTRFS warning =
(device
>> sdd1): csum failed root 5 ino 14654354 off 163852288 csum 0
>=20
> That sounds like it could be the raid5/6 bug I reported
>=20
> 	https://www.spinics.net/lists/linux-btrfs/msg94594.html
>=20
> To trigger that bug you need pre-existing corruption on the disk.
>=20
> You can work around by:
>=20
> 	1.  Read every file, e.g. 'find -type f -exec cat {} + =
>/dev/null'
> 	This avoids dmesg ratelimiting which will hide some errors.
>=20
> 	2.  If there are read errors in step 1, remove any that have
> 	failures.
>=20
> 	3.  Run full scrub to fix parity or inject new errors.
>=20
> 	4.  Repeat until there are no errors at step 1.
>=20
> The bug will introduce new errors in a small fraction (<0.1%) of =
corrupted
> raid stripes as you do this.  Each pass through the loop will remove
> existing errors, but may add a few more new errors at the same time.
> The rate of removal is much faster than the rate of addition, so the
> loop will eventually terminate at zero errors.  You'll be able to use
> the filesystem normally again after that.
>=20
> This bug is not a regression--there has not been a kernel release with
> working btrfs raid5/6 yet.  All releases from 4.15 to 5.5.3 fail my =
test
> case, and versions before 4.15 have worse bugs.  At the moment, btrfs
> raid5/6 should only be used by developers who intend to test, debug,
> and fix btrfs raid5/6.
>=20
>> But now when I attempt to delete a device from the array it seems to
>> get stuck.  Normally it will show in the log that it has found some
>> extents and then another message saying they were relocated.
>>=20
>> But for the last few days it has just been repeating the same found
>> value and never relocating anything, and the usage of the device
>> doesn=E2=80=99t change at all.
>>=20
>> This line has now been repeating for more then 24 hours, and the
>> previous attempt was similar.  [Sun Mar 29 09:59:50 2020] BTRFS info
>> (device sdd1): found 133 extents
>=20
> Kernels starting with 5.1 have a known regression where block group
> relocation gets stuck in loops.  Everything in the block group gets
> relocated except for shared data backref items, then the relocation =
can't
> seem to move those and no further progress is made.  This has not been
> fixed yet.
>=20
>> Prior to this run I had tried with an earlier kernel (5.5.10) and had
>> the same results.  It starts with finding and then relocating, but
>> then relocating.  So I upgraded my kernel to see if that would help,
>> and it has not.
>=20
> Use kernel 4.19 for device deletes or other big relocation operations.
> (5.0 and 4.20 are OK too, but 4.19 is still maintained and has fixes
> for non-btrfs issues).
>=20
>> System Info
>> Ubuntu 18.04
>> btrfs-progs v5.4.1
>> Linux FileServer 5.5.13-050513-generic #202003251631 SMP Wed Mar 25 =
16:35:59 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
>>=20
>> DEVICE USAGE
>> /dev/sdd1, ID: 1
>>   Device size:             2.73TiB
>>   Device slack:              0.00B
>>   Data,RAID6:            188.67GiB
>>   Data,RAID6:              1.68TiB
>>   Data,RAID6:            888.43GiB
>>   Unallocated:             1.00MiB
>>=20
>> /dev/sdb1, ID: 2
>>   Device size:             2.73TiB
>>   Device slack:            2.73TiB
>>   Data,RAID6:            188.67GiB
>>   Data,RAID6:            508.82GiB
>>   Data,RAID6:              2.00GiB
>>   Unallocated:          -699.50GiB
>>=20
>> /dev/sdc1, ID: 3
>>   Device size:             2.73TiB
>>   Device slack:              0.00B
>>   Data,RAID6:            188.67GiB
>>   Data,RAID6:              1.68TiB
>>   Data,RAID6:            888.43GiB
>>   Unallocated:             1.00MiB
>>=20
>> /dev/sdi1, ID: 5
>>   Device size:             2.73TiB
>>   Device slack:            1.36TiB
>>   Data,RAID6:            188.67GiB
>>   Data,RAID6:              1.18TiB
>>   Unallocated:             1.00MiB
>>=20
>> /dev/sdh1, ID: 6
>>   Device size:             4.55TiB
>>   Device slack:              0.00B
>>   Data,RAID6:            188.67GiB
>>   Data,RAID6:              1.68TiB
>>   Data,RAID6:              1.23TiB
>>   Data,RAID6:            888.43GiB
>>   Data,RAID6:              2.00GiB
>>   Metadata,RAID1:          2.00GiB
>>   Unallocated:           601.01GiB
>>=20
>> /dev/sda1, ID: 7
>>   Device size:             7.28TiB
>>   Device slack:              0.00B
>>   Data,RAID6:            188.67GiB
>>   Data,RAID6:              1.68TiB
>>   Data,RAID6:              1.23TiB
>>   Data,RAID6:            888.43GiB
>>   Data,RAID6:              2.00GiB
>>   Metadata,RAID1:          2.00GiB
>>   System,RAID1:           32.00MiB
>>   Unallocated:             3.32TiB
>>=20
>> /dev/sdf1, ID: 8
>>   Device size:             7.28TiB
>>   Device slack:              0.00B
>>   Data,RAID6:            188.67GiB
>>   Data,RAID6:              1.68TiB
>>   Data,RAID6:              1.23TiB
>>   Data,RAID6:            888.43GiB
>>   Data,RAID6:              2.00GiB
>>   Metadata,RAID1:          8.00GiB
>>   Unallocated:             3.31TiB
>>=20
>> /dev/sdj1, ID: 9
>>   Device size:             7.28TiB
>>   Device slack:              0.00B
>>   Data,RAID6:            188.67GiB
>>   Data,RAID6:              1.68TiB
>>   Data,RAID6:              1.23TiB
>>   Data,RAID6:            888.43GiB
>>   Data,RAID6:              2.00GiB
>>   Metadata,RAID1:          8.00GiB
>>   System,RAID1:           32.00MiB
>>   Unallocated:             3.31TiB
>>=20
>>=20
>> FI USAGE
>> WARNING: RAID56 detected, not implemented
>> Overall:
>>    Device size:		  33.20TiB
>>    Device allocated:		  20.06GiB
>>    Device unallocated:		  33.18TiB
>>    Device missing:		     0.00B
>>    Used:			  19.38GiB
>>    Free (estimated):		     0.00B	(min: 8.00EiB)
>>    Data ratio:			      0.00
>>    Metadata ratio:		      2.00
>>    Global reserve:		 512.00MiB	(used: 0.00B)
>>=20
>> Data,RAID6: Size:15.42TiB, Used:15.18TiB (98.44%)
>>   /dev/sdd1	   2.73TiB
>>   /dev/sdb1	 699.50GiB
>>   /dev/sdc1	   2.73TiB
>>   /dev/sdi1	   1.36TiB
>>   /dev/sdh1	   3.96TiB
>>   /dev/sda1	   3.96TiB
>>   /dev/sdf1	   3.96TiB
>>   /dev/sdj1	   3.96TiB
>>=20
>> Metadata,RAID1: Size:10.00GiB, Used:9.69GiB (96.90%)
>>   /dev/sdh1	   2.00GiB
>>   /dev/sda1	   2.00GiB
>>   /dev/sdf1	   8.00GiB
>>   /dev/sdj1	   8.00GiB
>>=20
>> System,RAID1: Size:32.00MiB, Used:1.19MiB (3.71%)
>>   /dev/sda1	  32.00MiB
>>   /dev/sdj1	  32.00MiB
>>=20
>> Unallocated:
>>   /dev/sdd1	   1.00MiB
>>   /dev/sdb1	-699.50GiB
>>   /dev/sdc1	   1.00MiB
>>   /dev/sdi1	   1.00MiB
>>   /dev/sdh1	 601.01GiB
>>   /dev/sda1	   3.32TiB
>>   /dev/sdf1	   3.31TiB
>>   /dev/sdj1	   3.31TiB
>>=20
>>=20
>> FI SHOW
>> Label: 'Pool1'  uuid: 99935e27-4922-4efa-bf76-5787536dd71f
>> 	Total devices 8 FS bytes used 15.19TiB
>> 	devid    1 size 2.73TiB used 2.73TiB path /dev/sdd1
>> 	devid    2 size 0.00B used 699.50GiB path /dev/sdb1
>> 	devid    3 size 2.73TiB used 2.73TiB path /dev/sdc1
>> 	devid    5 size 1.36TiB used 1.36TiB path /dev/sdi1
>> 	devid    6 size 4.55TiB used 3.96TiB path /dev/sdh1
>> 	devid    7 size 7.28TiB used 3.96TiB path /dev/sda1
>> 	devid    8 size 7.28TiB used 3.97TiB path /dev/sdf1
>> 	devid    9 size 7.28TiB used 3.97TiB path /dev/sdj1
>>=20
>> FI DF
>> Data, RAID6: total=3D15.42TiB, used=3D15.18TiB
>> System, RAID1: total=3D32.00MiB, used=3D1.19MiB
>> Metadata, RAID1: total=3D10.00GiB, used=3D9.69GiB
>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

