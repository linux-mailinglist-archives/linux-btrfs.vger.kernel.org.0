Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D12D7196DD7
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Mar 2020 16:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgC2ONJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Mar 2020 10:13:09 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:36568 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbgC2ONJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Mar 2020 10:13:09 -0400
Received: by mail-qt1-f169.google.com with SMTP id m33so12883720qtb.3
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Mar 2020 07:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clarafamily.com; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=R0Fp7PQTXPdKm4ELa+ntm9yyAwC+pPccJyumUYx98Hs=;
        b=WTukTiM3V5sZBOXx0Y/sA+ORXjKvhml7xO1km6Phiih2DuNwsiktV1vMzNb5dVQbdC
         K5jzrH/QjP3DzJ0gNHiJFDbKEsUu9JM7M6b7/PYf5lA1A+3cV4ehNStXUIbQGOE7jiHn
         72uWAnt+n1Ld52rU7ufwfTHr60hAvXcLixceQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=R0Fp7PQTXPdKm4ELa+ntm9yyAwC+pPccJyumUYx98Hs=;
        b=K4xMc2j+G9ym6BZO1TmdOFg7m0ZkmmBMOghEmc6boImDhUC7Hc5fUaPtE3Drkqt5q+
         9qGMv8WAA//OI9crWm115gOR178EVoer1gBWdEzZNqk06aVlRcoX2XiBjOi83r3t9nlf
         sT3VoOdQf2FRs9ofp1yN55I3f+eOfBrGdTEAlLnomgwGeDe1ygtjO4jSjpEa0LZs+7sR
         X8jtcV43H/BtrVsGW1o1dlX+VE2AS7ORm0OMpCQun1sNzv9179G76mqjctaFFg7+Lyk9
         RmiF7iYy9ugcgE4DUxjg0/P/My4YZ/22bmzl+Jna6RVNedTV4tMQdR5YZPuvDg5Bghyi
         TLQg==
X-Gm-Message-State: ANhLgQ14XwgvAJI832nocfVCcFoYQGlfnSz4zxyQqT4eWm5heuYr4hJI
        hg3RFcUMdr5Raz4zxXYgHBcf+9N+uofDSA==
X-Google-Smtp-Source: ADFU+vtJ/yTRDxuP16gG96/wKs3vProQp9y4P/FhF+y5aOqP23jrEbZfWkAV5GUr9Grg0o69MwntUw==
X-Received: by 2002:ac8:310b:: with SMTP id g11mr7901930qtb.128.1585491186533;
        Sun, 29 Mar 2020 07:13:06 -0700 (PDT)
Received: from macbookpro.clara (CPE40623100049e-CM9050cac9ddf0.cpe.net.cable.rogers.com. [99.247.249.188])
        by smtp.gmail.com with ESMTPSA id 18sm7608737qkk.84.2020.03.29.07.13.05
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2020 07:13:06 -0700 (PDT)
From:   Jason Clara <jason@clarafamily.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Device Delete Stuck
Message-Id: <B7A6E37C-C10A-49C3-B98A-0D659CA4E33B@clarafamily.com>
Date:   Sun, 29 Mar 2020 10:13:05 -0400
To:     linux-btrfs@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I had a previous post about when trying to do a device delete that it =
would cause my whole system to hang.  I seem to have got past that =
issue. =20

For that, it seems like even though all the SCRUBs finished without any =
errors I still had a problem with some files.  By forcing a read of =
every single file I was able to detect the bad files in DMESG.  Not sure =
though why SCRUB didn=E2=80=99t detect this.
BTRFS warning (device sdd1): csum failed root 5 ino 14654354 off =
163852288 csum 0


But now when I attempt to delete a device from the array it seems to get =
stuck.  Normally it will show in the log that it has found some extents =
and then another message saying they were relocated.

But for the last few days it has just been repeating the same found =
value and never relocating anything, and the usage of the device =
doesn=E2=80=99t change at all.

This line has now been repeating for more then 24 hours, and the =
previous attempt was similar.
[Sun Mar 29 09:59:50 2020] BTRFS info (device sdd1): found 133 extents

Prior to this run I had tried with an earlier kernel (5.5.10) and had =
the same results.  It starts with finding and then relocating, but then =
relocating.  So I upgraded my kernel to see if that would help, and it =
has not.

System Info
Ubuntu 18.04
btrfs-progs v5.4.1
Linux FileServer 5.5.13-050513-generic #202003251631 SMP Wed Mar 25 =
16:35:59 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

DEVICE USAGE
/dev/sdd1, ID: 1
   Device size:             2.73TiB
   Device slack:              0.00B
   Data,RAID6:            188.67GiB
   Data,RAID6:              1.68TiB
   Data,RAID6:            888.43GiB
   Unallocated:             1.00MiB

/dev/sdb1, ID: 2
   Device size:             2.73TiB
   Device slack:            2.73TiB
   Data,RAID6:            188.67GiB
   Data,RAID6:            508.82GiB
   Data,RAID6:              2.00GiB
   Unallocated:          -699.50GiB

/dev/sdc1, ID: 3
   Device size:             2.73TiB
   Device slack:              0.00B
   Data,RAID6:            188.67GiB
   Data,RAID6:              1.68TiB
   Data,RAID6:            888.43GiB
   Unallocated:             1.00MiB

/dev/sdi1, ID: 5
   Device size:             2.73TiB
   Device slack:            1.36TiB
   Data,RAID6:            188.67GiB
   Data,RAID6:              1.18TiB
   Unallocated:             1.00MiB

/dev/sdh1, ID: 6
   Device size:             4.55TiB
   Device slack:              0.00B
   Data,RAID6:            188.67GiB
   Data,RAID6:              1.68TiB
   Data,RAID6:              1.23TiB
   Data,RAID6:            888.43GiB
   Data,RAID6:              2.00GiB
   Metadata,RAID1:          2.00GiB
   Unallocated:           601.01GiB

/dev/sda1, ID: 7
   Device size:             7.28TiB
   Device slack:              0.00B
   Data,RAID6:            188.67GiB
   Data,RAID6:              1.68TiB
   Data,RAID6:              1.23TiB
   Data,RAID6:            888.43GiB
   Data,RAID6:              2.00GiB
   Metadata,RAID1:          2.00GiB
   System,RAID1:           32.00MiB
   Unallocated:             3.32TiB

/dev/sdf1, ID: 8
   Device size:             7.28TiB
   Device slack:              0.00B
   Data,RAID6:            188.67GiB
   Data,RAID6:              1.68TiB
   Data,RAID6:              1.23TiB
   Data,RAID6:            888.43GiB
   Data,RAID6:              2.00GiB
   Metadata,RAID1:          8.00GiB
   Unallocated:             3.31TiB

/dev/sdj1, ID: 9
   Device size:             7.28TiB
   Device slack:              0.00B
   Data,RAID6:            188.67GiB
   Data,RAID6:              1.68TiB
   Data,RAID6:              1.23TiB
   Data,RAID6:            888.43GiB
   Data,RAID6:              2.00GiB
   Metadata,RAID1:          8.00GiB
   System,RAID1:           32.00MiB
   Unallocated:             3.31TiB


FI USAGE
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
    Global reserve:		 512.00MiB	(used: 0.00B)

Data,RAID6: Size:15.42TiB, Used:15.18TiB (98.44%)
   /dev/sdd1	   2.73TiB
   /dev/sdb1	 699.50GiB
   /dev/sdc1	   2.73TiB
   /dev/sdi1	   1.36TiB
   /dev/sdh1	   3.96TiB
   /dev/sda1	   3.96TiB
   /dev/sdf1	   3.96TiB
   /dev/sdj1	   3.96TiB

Metadata,RAID1: Size:10.00GiB, Used:9.69GiB (96.90%)
   /dev/sdh1	   2.00GiB
   /dev/sda1	   2.00GiB
   /dev/sdf1	   8.00GiB
   /dev/sdj1	   8.00GiB

System,RAID1: Size:32.00MiB, Used:1.19MiB (3.71%)
   /dev/sda1	  32.00MiB
   /dev/sdj1	  32.00MiB

Unallocated:
   /dev/sdd1	   1.00MiB
   /dev/sdb1	-699.50GiB
   /dev/sdc1	   1.00MiB
   /dev/sdi1	   1.00MiB
   /dev/sdh1	 601.01GiB
   /dev/sda1	   3.32TiB
   /dev/sdf1	   3.31TiB
   /dev/sdj1	   3.31TiB


FI SHOW
Label: 'Pool1'  uuid: 99935e27-4922-4efa-bf76-5787536dd71f
	Total devices 8 FS bytes used 15.19TiB
	devid    1 size 2.73TiB used 2.73TiB path /dev/sdd1
	devid    2 size 0.00B used 699.50GiB path /dev/sdb1
	devid    3 size 2.73TiB used 2.73TiB path /dev/sdc1
	devid    5 size 1.36TiB used 1.36TiB path /dev/sdi1
	devid    6 size 4.55TiB used 3.96TiB path /dev/sdh1
	devid    7 size 7.28TiB used 3.96TiB path /dev/sda1
	devid    8 size 7.28TiB used 3.97TiB path /dev/sdf1
	devid    9 size 7.28TiB used 3.97TiB path /dev/sdj1

FI DF
Data, RAID6: total=3D15.42TiB, used=3D15.18TiB
System, RAID1: total=3D32.00MiB, used=3D1.19MiB
Metadata, RAID1: total=3D10.00GiB, used=3D9.69GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B=
