Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C33AC1E00
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 11:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfI3Jbq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 05:31:46 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:45452 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbfI3Jbp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 05:31:45 -0400
Received: by mail-ed1-f54.google.com with SMTP id h33so7950403edh.12
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2019 02:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=FJzrmthDuQ2DU2JF2B3LKf8ISpaMjoB1n77RwZhaooE=;
        b=lIku9sov8sIMEUL2e9EJn+twbLFILPh/WTq+i2baQIuMrsKwlCsA/gyzRCdzNbmxBp
         gm0oQiUayF16kW6rjf4w+uK8u2eqX+mBK6SMFQ6Hqat0mCKoRJXYFQdyoSbtQ7El0vG7
         kPPMKaRk5qHo6NFzJjHJHniV9VPd5osYYkJBn/lIdtAy84/aa7oJNRuM2Li8MN6OsVrY
         EcbmDtq6+K8buj9lPYRkv3o+r0nhA04syaY5XXK7ECCWMC0IW44VrqccG54OIxsD7kvu
         qwcx/gE2gbWoS2KhGNkFg00gkTr0BzIEXe48T14yEpOujcyk5LFXNxLjYdkAmqvuE109
         IVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=FJzrmthDuQ2DU2JF2B3LKf8ISpaMjoB1n77RwZhaooE=;
        b=NcSXnPePlM0+6KEQCMpV3qmhKMoccTxfX2aphuRZEV7bFevDS2XXSKsaK2yhLPIjkB
         7zRlxOZc1LtX31qfd6QRkQoi01LFk4p2+1wo/yiMUi7z4UJRjimDc1uW1t1M0OVsiDxc
         PYWXHUjac/nGEh5uL6IQtQxUm8e7HegMIQRtER0JbkA2OjBWAMO8nU0fTbrtbxR8ANjC
         eNFUL1lZWzvjPLZbjDI89BW0bFOogFDOI1y7ys5841Lq+URBR+EiQKSLCBnwmG0xO1Ek
         hV1l4IJU18lsD3qTzoZ10KW5uXv/tGWkXUuHQW7V1etnF7WkyUxJStQH328epCPFQydt
         h4ew==
X-Gm-Message-State: APjAAAWVb0WpHdS7n3lwHg5wdQ4tJLaf3ron1vunhPGmOCqYxIjuTQ6/
        rGdukhIA6yl9h1zWQkMOmLlXYFkWx2A=
X-Google-Smtp-Source: APXvYqy0S5jmXDYIYT1+p/kvbu19nFe0vMxkRSytqtt+YPJ9UyFf5czpfwMWT0EUvI8why2RkV0VCQ==
X-Received: by 2002:a17:906:6b98:: with SMTP id l24mr18682093ejr.208.1569835903074;
        Mon, 30 Sep 2019 02:31:43 -0700 (PDT)
Received: from MHPlaptop ([87.104.5.4])
        by smtp.gmail.com with ESMTPSA id i23sm392346ejj.32.2019.09.30.02.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 02:31:42 -0700 (PDT)
From:   <hoegge@gmail.com>
To:     "'Chris Murphy'" <lists@colorremedies.com>
Cc:     "'Btrfs BTRFS'" <linux-btrfs@vger.kernel.org>
References: <000f01d5723b$6e3d0f70$4ab72e50$@gmail.com> <CAJCQCtSCJTsk1oFrWObUBpw-MXArQJHoJV3BeBk0Nfv_-AoS8g@mail.gmail.com> <003f01d5724c$f1adae30$d5090a90$@gmail.com> <CAJCQCtTwjUok145SqnbwfBYKipVhcV7J94HX9Lx4mgaFV3FaBA@mail.gmail.com> <005301d572dd$e378c7a0$aa6a56e0$@gmail.com> <CAJCQCtTTqQg68HP1qkNrVsH337SQmWqk8pnf4svApA5btTnTRA@mail.gmail.com>
In-Reply-To: <CAJCQCtTTqQg68HP1qkNrVsH337SQmWqk8pnf4svApA5btTnTRA@mail.gmail.com>
Subject: RE: BTRFS checksum mismatch - false positives
Date:   Mon, 30 Sep 2019 11:31:41 +0200
Message-ID: <00f401d57771$de7cd370$9b767a50$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQDC/7g4S9J6FUg0YRCQl8sHX15RDgIzZwHmAUBixXoBtxE1ZALrQgdzAbJsGgmpGp2PgA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Christ,

Thank you very much for your help and insight. Has helped me a lot =
understanding the setup with BTRFS on top of SHR. I will rebuild the =
whole thing from scratch, as you recommend, since it seems only to get =
worse. The file mapping tool from Synology (synodataverifier) used on =
the files with checksum errors indicate that the corrupted blocks are on =
two different discs (out of 8), one quite new (3 TB drive) and one older =
(500 GB drive). Having two partially defect drives on a RAID 5'ish =
system of course will create a lot of trouble. Only wonder why none of =
them have any errors on S.M.A.R.T. (also extended tests) at all - and =
that Synology did not report any read errors.

I'm halfway through my second full backup of all files in addition to my =
cloud backup, so then I'll toss the two suspicious drives and build a =
new system and RAID (RAID 6 / SHR 2) with two parity disks instead of =
just one.=20

BTW, Do you have any idea of when the fixed RAID 5/6 BTRFS functionality =
might become mainstream, so we can abandon MD and simplify the stack to =
purely BTRFS?

Thanks again

Hoegge



-----Original Message-----
From: Chris Murphy <lists@colorremedies.com>=20
Sent: 2019-09-26 22:28
To: hoegge@gmail.com
Cc: Chris Murphy <lists@colorremedies.com>; Btrfs BTRFS =
<linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS checksum mismatch - false positives

From the log offlist

2019-09-08T17:27:02+02:00 MHPNAS kernel: [   22.396165] md: invalid
raid superblock magic on sda5
2019-09-08T17:27:02+02:00 MHPNAS kernel: [   22.401816] md: sda5 does
not have a valid v0.90 superblock, not importing!

That doesn't sound good. It's not a Btrfs problem but a md/mdadm =
problem. You'll have to get support for this from Synology, only they =
understand the design of the storage stack layout and whether these =
error messages are important or not and how to fix them. Anyone else =
speculating could end up causing damage to the NAS and data to be lost.

--------
2019-09-08T17:27:02+02:00 MHPNAS kernel: [   22.913298] md: sda2 has
different UUID to sda1

There are several messages like this. I can't tell if they're just =
informational and benign or a problem. Also not related to Btrfs.

--------
2019-09-08T22:09:33+02:00 MHPNAS kernel: [16997.419199] BTRFS warning =
(device dm-1): BTRFS: dm-1 checksum verify failed on 375259512832 wanted =
EA1A10E3 found 3080B64F level 0
2019-09-08T22:09:33+02:00 MHPNAS kernel: [16997.419199]
2019-09-08T22:09:33+02:00 MHPNAS kernel: [16997.458453] BTRFS warning =
(device dm-1): BTRFS: dm-1 checksum verify failed on 375259512832 wanted =
EA1A10E3 found 3080B64F level 0
2019-09-08T22:09:33+02:00 MHPNAS kernel: [16997.458453]
2019-09-08T22:09:33+02:00 MHPNAS kernel: [16997.528385] BTRFS: read =
error corrected: ino 1 off 375259512832 (dev /dev/vg1/volume_1 sector
751819488)
2019-09-08T22:09:33+02:00 MHPNAS kernel: [16997.539631] BTRFS: read =
error corrected: ino 1 off 375259516928 (dev /dev/vg1/volume_1 sector
751819496)
2019-09-08T22:09:33+02:00 MHPNAS kernel: [16997.550785] BTRFS: read =
error corrected: ino 1 off 375259521024 (dev /dev/vg1/volume_1 sector
751819504)
2019-09-08T22:09:33+02:00 MHPNAS kernel: [16997.561990] BTRFS: read =
error corrected: ino 1 off 375259525120 (dev /dev/vg1/volume_1 sector
751819512)

There are a bunch of messages like this. Btrfs is finding metadata =
checksum errors, some kind of corruption has happened with one of the =
copies, and it's been fixed up. But why are things being corrupt in the =
first place? Ordinary bad sectors maybe? There's a lot of these  - like =
really a lot. Hundreds of affected sectors. There are too many for me to =
read through and see if all of them were corrected by DUP metadata.

--------

2019-09-22T21:24:27+02:00 MHPNAS kernel: [1224856.764098] md2:
syno_self_heal_is_valid_md_stat(496): md's current state is not suitable =
for data correction

What does that mean? Also not a Btrfs problem. There are quite a few of =
these.

--------

2019-09-23T11:49:20+02:00 MHPNAS kernel: [1276791.652946] BTRFS error =
(device dm-1): BTRFS: dm-1 failed to repair btree csum error on =
1353162506240, mirror =3D 1

OK and a few of these also. This means that some metadata could not be =
repaired, likely because both copies are corrupt.

My recommendation is to freshen your backups now while you still can, =
and prepare to rebuild the NAS. i.e. these are not likely repairable =
problems. Once both copies of Btrfs metadata are bad, it's usually not =
fixable you just have to recreate the file system from scratch.

You'll have to move everything off the NAS - and anything that's really =
important you will want at least two independent copies of, of course, =
and then you're going to obliterate the array and start from scratch. =
While you're at it, you might as well make sure you've got the latest =
supported version of the software for this product. Start with that. =
Then follow the Synology procedure to wipe the NAS totally and set it up =
again. You'll want to make sure the procedure you use writes out all new =
metadata for everything: mdadm, lvm, Btrfs. Nothing stale or old reused. =
And then you'll copy you data back over to the NAS.

There's nothing in the provided log that helps me understand why this is =
happening. I suspect hardware problems of some sort - maybe one of the =
drives is starting to slowly die, by spitting out bad sectors. To know =
more about that we'd need to see 'smartctl -x /dev/' for each drive in =
the NAS and see if smart gives a clue. Somewhere around 50/50 shot that =
smart will predict a drive failure in advance. So my suggestion again, =
without delay, is to make sure the NAS is backed up, and keep those =
backups fresh. You can recreate the NAS when you have free time - but =
these problems likely will get worse.



---
Chris Murphy

