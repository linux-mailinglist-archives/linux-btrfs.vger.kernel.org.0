Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB4C17D631
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Mar 2020 22:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCHVFj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Mar 2020 17:05:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43119 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgCHVFj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Mar 2020 17:05:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id l13so555016qtv.10
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Mar 2020 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clarafamily.com; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=m1fm9ZvEhkvQ1zprGzOdgBsw+YFhJHJWw8RnWJ0G7Fw=;
        b=V4uP44jnW/ZLaRJ1lCZhSYbTXbsmOxW2ciwt1A7X/o7vN7HYUUPrUAGEzuoj/CxJIc
         7zCSHltiGtCWjqLV/Gl/rPh3k9ewguokm5/+m1L/JVWXYJVgarU/aBnldwUXOxCVunX+
         NI5b69V6+ikGjexlNN1fINC7Xfn1Pspf/lQKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=m1fm9ZvEhkvQ1zprGzOdgBsw+YFhJHJWw8RnWJ0G7Fw=;
        b=ZsgadX0XlcN6CT7bj2kkmgn3MHUYrpPuDpkYb4lMjVEJ1nCdiEMrGrheonvMow/yBv
         lo2Ed36xranaQDjle1N9bsWDRLsGTHo+b0A1DWDmMH4jMCnf0dWFJUEef5LWmLB6ND3d
         vJlpaSL3wJ9SK8tlRiGmwJQT9LU+7M7XHxpypE3xcI/QNEB8vl+9utBc51HUASpqWmZC
         WYdq5M1zu1ZFuLyEfYVVCahdN2jqZfXxMq/hpcsTM/mj9kKFTJZunbvWxyqMbtxa3vfr
         1aTscZA7/VN1nz1uKN2NKbIxLDyOvZKh1bHMVfAyaZZg704+SI91WVd0J00qYvjstF97
         uqSw==
X-Gm-Message-State: ANhLgQ3xJUNETWmEObiVNpBcV4zQ3TJ2qdiJAavFSspyoquctV1NIktQ
        uJpb5thMclrFpEVmRmznLBGjrqn4NyV8gIYB
X-Google-Smtp-Source: ADFU+vtGRifKUXy0gPrc+szQF7f7DO/o0x9ecTyPh4rcb9jzdYdBpTdktQ2/+KSpJ23k9D6tIit0Iw==
X-Received: by 2002:ac8:6f12:: with SMTP id g18mr12189923qtv.6.1583701537744;
        Sun, 08 Mar 2020 14:05:37 -0700 (PDT)
Received: from macbookpro.clara (CPE40623100049e-CM9050cac9ddf0.cpe.net.cable.rogers.com. [99.247.249.188])
        by smtp.gmail.com with ESMTPSA id z21sm20632284qka.122.2020.03.08.14.05.36
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2020 14:05:37 -0700 (PDT)
From:   Jason Clara <jason@clarafamily.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: BTRFS remove device crashing whole system  
Message-Id: <EDB94DB8-ECE6-44A0-8508-DFF49AB49721@clarafamily.com>
Date:   Sun, 8 Mar 2020 17:05:35 -0400
To:     linux-btrfs@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, hoping someone can help with this issue I am having.  I have a pool =
setup as D:RAID6/M:RAID1 which I converted to that from D/M:RAID1 about =
a month ago. =20

Since I did that I have been wanting to remove one of my drives from the =
pool. However, whenever I do it crashes the whole system after running =
for about 24 hours.  This is my third or fourth attempt with it =
happening and I have updated my kernel and btrfs-progs hoping it would =
solve the issue

Since the last time it happened I have run a full balance and a scrub =
and both complete without any issues.  I do this between every attempt. =
But when I try to do the remove it crashes the whole system and I have =
to reset.  Right now a scrub is running since this is RAID6 and =
suggested to be done after any unclean shutdown.  Should be done in 24 =
hours.

At the moment of the crash the system was being used as a plex server =
and had three streams going, and some other services.  So reads with =
some writes going on at the same time.  Remove had been going for maybe =
24 hours before it locked up.

Here is hopefully all the info you need, but please let me know if =
anything else is required

I am trying to remove one of the 3TB drives (sdb)

My device stats shows 1 corruption_errs for one drive that has been =
there for a while so no errors have come up with these delete attempts

Pool was created many years ago, and I have been keeping up to date on =
kernel versions and btrfs-progs manually.

System info
Ubuntu 18.04=20
Kernel: Linux FileServer 5.5.7-050507-generic #202002281805=20
btrfs-progs v5.4.1

device usage
/dev/sdd1, ID: 1
 Device size:             2.73TiB
 Device slack:              0.00B
 Data,RAID6:              1.16TiB
 Data,RAID6:            810.74GiB
 Data,RAID6:            791.52GiB
 Unallocated:             1.00MiB

/dev/sdb1, ID: 2
 Device size:             2.73TiB
 Device slack:              0.00B
 Data,RAID6:              1.16TiB
 Data,RAID6:            605.74GiB
 Data,RAID6:              6.00GiB
 Unallocated:           990.52GiB

/dev/sdc1, ID: 3
 Device size:             2.73TiB
 Device slack:              0.00B
 Data,RAID6:              1.16TiB
 Data,RAID6:            810.74GiB
 Data,RAID6:            791.52GiB
 Unallocated:             1.00MiB

/dev/sdi1, ID: 5
 Device size:             2.73TiB
 Device slack:            1.36TiB
 Data,RAID6:              1.16TiB
 Data,RAID6:            205.00GiB
 Unallocated:             1.00MiB

/dev/sdh1, ID: 6
 Device size:             4.55TiB
 Device slack:              0.00B
 Data,RAID6:              1.16TiB
 Data,RAID6:            810.74GiB
 Data,RAID6:            581.00GiB
 Data,RAID6:            791.52GiB
 Data,RAID6:              6.00GiB
 Metadata,RAID1:          3.00GiB
 System,RAID1:           32.00MiB
 Unallocated:             1.24TiB

/dev/sda1, ID: 7
 Device size:             7.28TiB
 Device slack:              0.00B
 Data,RAID6:              1.16TiB
 Data,RAID6:            810.74GiB
 Data,RAID6:            581.00GiB
 Data,RAID6:            791.52GiB
 Data,RAID6:              6.00GiB
 Unallocated:             3.97TiB

/dev/sdf1, ID: 8
 Device size:             7.28TiB
 Device slack:              0.00B
 Data,RAID6:              1.16TiB
 Data,RAID6:            810.74GiB
 Data,RAID6:            581.00GiB
 Data,RAID6:            791.52GiB
 Data,RAID6:              6.00GiB
 Metadata,RAID1:          9.00GiB
 System,RAID1:           32.00MiB
 Unallocated:             3.97TiB

/dev/sdj1, ID: 9
 Device size:             7.28TiB
 Device slack:              0.00B
 Data,RAID6:              1.16TiB
 Data,RAID6:            810.74GiB
 Data,RAID6:            581.00GiB
 Data,RAID6:            791.52GiB
 Data,RAID6:              6.00GiB
 Metadata,RAID1:         10.00GiB
 Unallocated:             3.96TiB

fi show
Label: 'Pool1'  uuid: 99935e27-4922-4efa-bf76-5787536dd71f
	Total devices 8 FS bytes used 14.91TiB
	devid    1 size 2.73TiB used 2.73TiB path /dev/sdd1
	devid    2 size 2.73TiB used 1.76TiB path /dev/sdb1
	devid    3 size 2.73TiB used 2.73TiB path /dev/sdc1
	devid    5 size 1.36TiB used 1.36TiB path /dev/sdi1
	devid    6 size 4.55TiB used 3.31TiB path /dev/sdh1
	devid    7 size 7.28TiB used 3.30TiB path /dev/sda1
	devid    8 size 7.28TiB used 3.31TiB path /dev/sdf1
	devid    9 size 7.28TiB used 3.31TiB path /dev/sdj1

fi df
Data, RAID6: total=3D15.20TiB, used=3D14.90TiB
System, RAID1: total=3D32.00MiB, used=3D1.09MiB
Metadata, RAID1: total=3D11.00GiB, used=3D9.58GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

fi usage
WARNING: RAID56 detected, not implemented
Overall:
   Device size:		  35.93TiB
   Device allocated:		  22.06GiB
   Device unallocated:		  35.91TiB
   Device missing:		     0.00B
   Used:			  19.17GiB
   Free (estimated):		     0.00B	(min: 8.00EiB)
   Data ratio:			      0.00
   Metadata ratio:		      2.00
   Global reserve:		 512.00MiB	(used: 0.00B)

Data,RAID6: Size:15.20TiB, Used:14.90TiB (98.06%)
  /dev/sdd1	   2.73TiB
  /dev/sdb1	   1.76TiB
  /dev/sdc1	   2.73TiB
  /dev/sdi1	   1.36TiB
  /dev/sdh1	   3.30TiB
  /dev/sda1	   3.30TiB
  /dev/sdf1	   3.30TiB
  /dev/sdj1	   3.30TiB

Metadata,RAID1: Size:11.00GiB, Used:9.58GiB (87.11%)
  /dev/sdh1	   3.00GiB
  /dev/sdf1	   9.00GiB
  /dev/sdj1	  10.00GiB

System,RAID1: Size:32.00MiB, Used:1.09MiB (3.42%)
  /dev/sdh1	  32.00MiB
  /dev/sdf1	  32.00MiB

Unallocated:
  /dev/sdd1	   1.00MiB
  /dev/sdb1	 987.52GiB
  /dev/sdc1	   1.00MiB
  /dev/sdi1	   1.00MiB
  /dev/sdh1	   1.24TiB
  /dev/sda1	   3.97TiB
  /dev/sdf1	   3.96TiB
  /dev/sdj1	   3.96TiB


DMESG Log: https://pastebin.com/w09F4nMr


PS.  I think my first message was blocked due to being over 100k, so I =
am resending with pastebin for DMESG.  Sorry if there is a duplicate.=
