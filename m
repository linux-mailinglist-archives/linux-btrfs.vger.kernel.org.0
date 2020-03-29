Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72461196F2C
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Mar 2020 20:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgC2SSb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Mar 2020 14:18:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33893 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbgC2SSb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Mar 2020 14:18:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id 10so13252662qtp.1
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Mar 2020 11:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clarafamily.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vGGb5rhD/06arlGoQyIznm6sf8m8Z8bhaU27m+Z7N6A=;
        b=c2JdJvBHVar+ypMCGnMsFrOPp7CPKPwU+/EEPJa4A9Fnkl1HUYwRQoxqxr9fiPaajL
         E1gpTVSxa0SKu/u6KnVVRZOF9n8uT/VtFA6O04aYUH5OaSKiYDLFuhF0dtUoc8zxqYt7
         kceNnjc9nQKliHoThi81JW2z2yR+MYHA7LTWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vGGb5rhD/06arlGoQyIznm6sf8m8Z8bhaU27m+Z7N6A=;
        b=MVOwNWZioSfcNXRPfwSnIU91YmY/+V17vPrKICSs3IrAYlN4z5SPLylb/E1fl1Nj6t
         p523eI7SUHrW4u+voINzMlukqjktxGb2kpRwjrcz4Id1CJbo9VTFDZGJqYXullrf2KMp
         oA6hFg2SckJmsygT+Z9D75a3AMDHAxjscR4xh40I8oTsgO0hw6jVfZWWz/1ZTwHwOeXM
         CPe9XDq3Pv4OaOzxEpq6wAY8rmGkNloPenup/mZnhidmj3TLYuel/FgKf+YurRQlTly7
         RBpjpifl2zyVoT3FcXhXP6ery9uPTffh3WfYz8JF4Jf8onEUDoVU5SqAKVA+oJTyZzKW
         xjzQ==
X-Gm-Message-State: ANhLgQ17Lbw35Tl5v0JXozGZzQfRqLDUubTkqSlTnDSlQCel1rdACpLR
        EMWt/hlfA/yNBRjyYRen3mWVdg==
X-Google-Smtp-Source: ADFU+vvWn3sQK/+Gyse6KOhNsB5ozoyXJBnFN3WlM+hoKUOgYeqFR+MUK0Sjc/0TOMkleOB0iFx2KA==
X-Received: by 2002:ac8:1828:: with SMTP id q37mr8428014qtj.201.1585505907591;
        Sun, 29 Mar 2020 11:18:27 -0700 (PDT)
Received: from macbookpro.clara (CPE40623100049e-CM9050cac9ddf0.cpe.net.cable.rogers.com. [99.247.249.188])
        by smtp.gmail.com with ESMTPSA id t53sm9217338qth.70.2020.03.29.11.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2020 11:18:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: Device Delete Stuck
From:   Jason Clara <jason@clarafamily.com>
In-Reply-To: <CAG_8rEfmJrCtkgpBnUjnWwVuzJNkyM=u1vaBbX-3+UnvQ9Vizw@mail.gmail.com>
Date:   Sun, 29 Mar 2020 14:18:25 -0400
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2F26D7D1-7354-40C7-9512-634C5F0B41DD@clarafamily.com>
References: <B7A6E37C-C10A-49C3-B98A-0D659CA4E33B@clarafamily.com>
 <CAG_8rEfmJrCtkgpBnUjnWwVuzJNkyM=u1vaBbX-3+UnvQ9Vizw@mail.gmail.com>
To:     Steven Fosdick <stevenfosdick@gmail.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for the suggestion.  I added clear_cache to my fstab, rebooted =
and waited about 20-30 minutes to make sure everything had settled down.
I did see this in my log, so it appears to have worked "BTRFS info =
(device sdd1): force clearing of disk cache"

I attempted the delete again, and it did remove more data but looks like =
it is stuck again.

Here is the DMESG from when I started the delete.  The last line "found =
3 extents=E2=80=9D has been repeating for the last 20 or so minutes

[Sun Mar 29 13:42:06 2020] BTRFS info (device sdd1): relocating block =
group 145441210499072 flags data|raid6
[Sun Mar 29 13:43:17 2020] BTRFS info (device sdd1): found 3010 extents
[Sun Mar 29 13:43:23 2020] BTRFS info (device sdd1): found 3010 extents
[Sun Mar 29 13:43:25 2020] BTRFS info (device sdd1): relocating block =
group 145437989273600 flags data|raid6
[Sun Mar 29 13:44:14 2020] BTRFS info (device sdd1): found 972 extents
[Sun Mar 29 13:44:21 2020] BTRFS info (device sdd1): found 950 extents
[Sun Mar 29 13:44:31 2020] BTRFS info (device sdd1): relocating block =
group 120428453429248 flags data|raid6
[Sun Mar 29 13:45:23 2020] BTRFS info (device sdd1): found 3884 extents
[Sun Mar 29 13:45:49 2020] BTRFS info (device sdd1): found 3883 extents
[Sun Mar 29 13:46:14 2020] BTRFS info (device sdd1): relocating block =
group 132181611511808 flags data|raid6
[Sun Mar 29 13:46:19 2020] BTRFS info (device sdd1): found 60 extents
[Sun Mar 29 13:46:21 2020] BTRFS info (device sdd1): found 60 extents
[Sun Mar 29 13:46:23 2020] BTRFS info (device sdd1): relocating block =
group 132153520160768 flags data|raid6
[Sun Mar 29 13:46:33 2020] BTRFS info (device sdd1): found 42 extents
[Sun Mar 29 13:46:35 2020] BTRFS info (device sdd1): found 42 extents
[Sun Mar 29 13:46:37 2020] BTRFS info (device sdd1): relocating block =
group 120433822138368 flags data|raid6
[Sun Mar 29 13:47:37 2020] BTRFS info (device sdd1): found 3831 extents
[Sun Mar 29 13:47:59 2020] BTRFS info (device sdd1): found 3831 extents
[Sun Mar 29 13:48:15 2020] BTRFS info (device sdd1): relocating block =
group 132175346270208 flags data|raid6
[Sun Mar 29 13:48:19 2020] BTRFS info (device sdd1): found 29 extents
[Sun Mar 29 13:48:21 2020] BTRFS info (device sdd1): found 29 extents
[Sun Mar 29 13:48:23 2020] BTRFS info (device sdd1): found 29 extents
[Sun Mar 29 13:48:25 2020] BTRFS info (device sdd1): relocating block =
group 120439190847488 flags data|raid6
[Sun Mar 29 13:49:12 2020] BTRFS info (device sdd1): relocating block =
group 132182843588608 flags data|raid6
[Sun Mar 29 13:49:16 2020] BTRFS info (device sdd1): found 3 extents
[Sun Mar 29 13:49:17 2020] BTRFS info (device sdd1): found 3 extents
[Sun Mar 29 13:49:18 2020] BTRFS info (device sdd1): found 3 extents
[Sun Mar 29 13:49:18 2020] BTRFS info (device sdd1): found 3 extents
[Sun Mar 29 13:49:19 2020] BTRFS info (device sdd1): found 3 extents
[Sun Mar 29 13:49:19 2020] BTRFS info (device sdd1): found 3 extents
[Sun Mar 29 13:49:20 2020] BTRFS info (device sdd1): found 3 extents
[Sun Mar 29 13:49:20 2020] BTRFS info (device sdd1): found 3 extents


Updated FI USAGE
WARNING: RAID56 detected, not implemented
Overall:
    Device size:		  33.20TiB
    Device allocated:		  20.06GiB
    Device unallocated:		  33.18TiB
    Device missing:		     0.00B
    Used:			  19.38GiB
    Free (estimated):		     0.00B	(min: 8.00EiB)
    Data ratio:			      0.00
    Metadata ratio:		      2.00
    Global reserve:		 512.00MiB	(used: 144.00KiB)

Data,RAID6: Size:15.42TiB, Used:15.18TiB (98.47%)
   /dev/sdd1	   2.73TiB
   /dev/sdb1	 695.21GiB
   /dev/sdc1	   2.73TiB
   /dev/sdi1	   1.36TiB
   /dev/sdh1	   3.96TiB
   /dev/sda1	   3.96TiB
   /dev/sdf1	   3.96TiB
   /dev/sdj1	   3.96TiB

Metadata,RAID1: Size:10.00GiB, Used:9.69GiB (96.89%)
   /dev/sdh1	   2.00GiB
   /dev/sda1	   2.00GiB
   /dev/sdf1	   8.00GiB
   /dev/sdj1	   8.00GiB

System,RAID1: Size:32.00MiB, Used:1.19MiB (3.71%)
   /dev/sda1	  32.00MiB
   /dev/sdj1	  32.00MiB

Unallocated:
   /dev/sdd1	   1.00MiB
   /dev/sdb1	-695.21GiB
   /dev/sdc1	   1.00MiB
   /dev/sdi1	   1.00MiB
   /dev/sdh1	 601.01GiB
   /dev/sda1	   3.32TiB
   /dev/sdf1	   3.31TiB
   /dev/sdj1	   3.31TiB


> On Mar 29, 2020, at 12:40 PM, Steven Fosdick <stevenfosdick@gmail.com> =
wrote:
>=20
> Jason,
>=20
> I am not a btrfs developer but I had he same problem as you.  In my
> case the problem went away when I used the mount option to clear the
> free space cache.  =46rom my own experience, whatever is going wrong
> that causes the checksum error also corrupts this cache but that does
> no long term harm as, once it is cleared on mount, it gets rebuilt.
>=20
> Steve.
>=20
> On Sun, 29 Mar 2020 at 15:15, Jason Clara <jason@clarafamily.com> =
wrote:
>>=20
>> I had a previous post about when trying to do a device delete that it =
would cause my whole system to hang.  I seem to have got past that =
issue.
>>=20
>> For that, it seems like even though all the SCRUBs finished without =
any errors I still had a problem with some files.  By forcing a read of =
every single file I was able to detect the bad files in DMESG.  Not sure =
though why SCRUB didn=E2=80=99t detect this.
>> BTRFS warning (device sdd1): csum failed root 5 ino 14654354 off =
163852288 csum 0
>>=20
>>=20
>> But now when I attempt to delete a device from the array it seems to =
get stuck.  Normally it will show in the log that it has found some =
extents and then another message saying they were relocated.
>>=20
>> But for the last few days it has just been repeating the same found =
value and never relocating anything, and the usage of the device =
doesn=E2=80=99t change at all.
>>=20
>> This line has now been repeating for more then 24 hours, and the =
previous attempt was similar.
>> [Sun Mar 29 09:59:50 2020] BTRFS info (device sdd1): found 133 =
extents
>>=20
>> Prior to this run I had tried with an earlier kernel (5.5.10) and had =
the same results.  It starts with finding and then relocating, but then =
relocating.  So I upgraded my kernel to see if that would help, and it =
has not.
>>=20
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
>>    Device size:                  33.20TiB
>>    Device allocated:             20.06GiB
>>    Device unallocated:           33.18TiB
>>    Device missing:                  0.00B
>>    Used:                         19.38GiB
>>    Free (estimated):                0.00B      (min: 8.00EiB)
>>    Data ratio:                       0.00
>>    Metadata ratio:                   2.00
>>    Global reserve:              512.00MiB      (used: 0.00B)
>>=20
>> Data,RAID6: Size:15.42TiB, Used:15.18TiB (98.44%)
>>   /dev/sdd1       2.73TiB
>>   /dev/sdb1     699.50GiB
>>   /dev/sdc1       2.73TiB
>>   /dev/sdi1       1.36TiB
>>   /dev/sdh1       3.96TiB
>>   /dev/sda1       3.96TiB
>>   /dev/sdf1       3.96TiB
>>   /dev/sdj1       3.96TiB
>>=20
>> Metadata,RAID1: Size:10.00GiB, Used:9.69GiB (96.90%)
>>   /dev/sdh1       2.00GiB
>>   /dev/sda1       2.00GiB
>>   /dev/sdf1       8.00GiB
>>   /dev/sdj1       8.00GiB
>>=20
>> System,RAID1: Size:32.00MiB, Used:1.19MiB (3.71%)
>>   /dev/sda1      32.00MiB
>>   /dev/sdj1      32.00MiB
>>=20
>> Unallocated:
>>   /dev/sdd1       1.00MiB
>>   /dev/sdb1    -699.50GiB
>>   /dev/sdc1       1.00MiB
>>   /dev/sdi1       1.00MiB
>>   /dev/sdh1     601.01GiB
>>   /dev/sda1       3.32TiB
>>   /dev/sdf1       3.31TiB
>>   /dev/sdj1       3.31TiB
>>=20
>>=20
>> FI SHOW
>> Label: 'Pool1'  uuid: 99935e27-4922-4efa-bf76-5787536dd71f
>>        Total devices 8 FS bytes used 15.19TiB
>>        devid    1 size 2.73TiB used 2.73TiB path /dev/sdd1
>>        devid    2 size 0.00B used 699.50GiB path /dev/sdb1
>>        devid    3 size 2.73TiB used 2.73TiB path /dev/sdc1
>>        devid    5 size 1.36TiB used 1.36TiB path /dev/sdi1
>>        devid    6 size 4.55TiB used 3.96TiB path /dev/sdh1
>>        devid    7 size 7.28TiB used 3.96TiB path /dev/sda1
>>        devid    8 size 7.28TiB used 3.97TiB path /dev/sdf1
>>        devid    9 size 7.28TiB used 3.97TiB path /dev/sdj1
>>=20
>> FI DF
>> Data, RAID6: total=3D15.42TiB, used=3D15.18TiB
>> System, RAID1: total=3D32.00MiB, used=3D1.19MiB
>> Metadata, RAID1: total=3D10.00GiB, used=3D9.69GiB
>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

