Return-Path: <linux-btrfs+bounces-4750-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114CF8BC19A
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 May 2024 17:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24430B20D0E
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 May 2024 15:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBBB364A4;
	Sun,  5 May 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTiPlV0h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3E22CCA0
	for <linux-btrfs@vger.kernel.org>; Sun,  5 May 2024 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714921563; cv=none; b=p4RCZhERDvnriSdjUevkE6aRYc0LtjYe2LWRE3twVvn9pJiSOwGH781vWxJvleoPTi88I6a/miX8baA0/73nfTfA5VS/SwmGZkt4MEFF76ojcWDmwhL34NhyP8iiGlZzM8KpLcOypjo3NrU3Xt5NVJ82XTArjlZ+SWnaFjdWXsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714921563; c=relaxed/simple;
	bh=AIl0Xb++g8qWiyWj7rgCPglubLPPgukGT0vW2rNN0F0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QSj7Lvqz3n3KbDacdzrq89uF+sZtrBipebVKvmLNXm4QZuZ3MMoYYvbUrdRiw4xG4yjEv/16SeCl5dZqBsQAYteQ/MkShzGAgw8/bPicd3py4sUcwfKm4Lqj5tHWKO3WhnoVjU025YQjiij76vckLzSWo6SnajAt91pfPdrJAoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTiPlV0h; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c8317d1f25so782491b6e.3
        for <linux-btrfs@vger.kernel.org>; Sun, 05 May 2024 08:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714921561; x=1715526361; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AIl0Xb++g8qWiyWj7rgCPglubLPPgukGT0vW2rNN0F0=;
        b=mTiPlV0hS6yB43kz9abzTgJcBnyHCUHWtkKeEruwxAUOOEgigzqs5nVizYKSe4iRFD
         CIVIKyltxOnMQBF+VKrxUG9msS2KPpMs/BEDkEUeL6Vcz9TxgIYTvBS/obW/lrsCYyZU
         wwY7I7kDdHPIkxoKLal5iA3VROfhXc1fQAZ5IsyJiWbFSLH/AxARWmMj2FpMwGushYED
         fVIIhT7IlV+voTJzA4TpFEDssxvJFnd/rre5Q3LehKqI6VPVOO3yNABbjwua/jtQCUtP
         qabwzNca1kNl7jkwxIQ9jaPLiHAxH7VaHB5NMyb1X4CzuO7YhkyIQkMGbBgqHvr6OvL4
         zLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714921561; x=1715526361;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AIl0Xb++g8qWiyWj7rgCPglubLPPgukGT0vW2rNN0F0=;
        b=Esw4AzN5J2RArbVf20abHocmiNe554JcqoEvEYWhm2DHLBEFPIi5k4pyr7mM8q67nb
         PY8LW6GpUPkiABC7dbGuryWwXSObln3VR6o9qx/MURsXAZXYHpHspeXvZhLHGIC3PDOw
         GD/v5lbc2qlUTLwJ00BsruA6HIJmj7lLiaKD7P6AcBmbWRf84hDfKkGDEo1HXz+yTZ41
         p82B5wh9Vpoqwoo4LL4NQq0rl9UwgoRx9YIAopWZfs7v7AsWx2yiYdQsv/5QCY+xB9wg
         ick9VFNUhyzGqTIpG8I/Iw6ANrtVUgD4q8UZbPr7aw1fUPuXl3xeo53TChmou63w8DMw
         JH7g==
X-Forwarded-Encrypted: i=1; AJvYcCVt4oYN0XQj37REJxVeLzAyQqgQNoEd4PVtbn/Sh98NuyfgE1SCMTUWTWi7m6hBite8jx+igQx6touoOJ4dTuIysl5YkQpXdXa8s2w=
X-Gm-Message-State: AOJu0YxXI/fXPSZKrkP5rMmPwZAJD8ATrgSp3OQA/DywLbvjtAXlXuKI
	cJGRG0XiUgoc6AdHrMV7CrDJ1NrPeOu/K4Uk34VT7d/EQ020QgenTfAiXbgxWxaKN5FCyhv19K/
	w7/ft1GiRaSvc9azT3lycu2mVAZnzxJpMbi3lRg==
X-Google-Smtp-Source: AGHT+IH0aNVCz3BABAGQYtq2e69CYVF6NLiwQx6JrQcz2cb10gTJr5/9PhsUPxo4Zco7Wm6IBejLBEY0dK6M4lJXNK4=
X-Received: by 2002:a05:6808:2a86:b0:3c8:6422:fb4b with SMTP id
 fc6-20020a0568082a8600b003c86422fb4bmr8561607oib.45.1714921561089; Sun, 05
 May 2024 08:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yordan <y16267966@gmail.com>
Date: Sun, 5 May 2024 18:05:28 +0300
Message-ID: <CAE0VrXL99p1ra6aRyqZgEbHKJ2LBKU0Yn+sPd4WoHxq0pONjGg@mail.gmail.com>
Subject: Re: btrfs-convert on 24Gb image corrupts files.
To: quwenruo.btrfs@gmx.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, it's Jordan - the reporter, I'm switching the email server as the
first one presumably did dirty things and was rejected by the "mlmmj
program managing the mailing list".

>Mind to provide the "filefrag -v" output after conversion using Anand's
fixes?

>Mind to provide the "filefrag -v" output after conversion using Anand's

fixes?

After applying the 4 patches and compiling:

(chroot) livecd / # B/btrfs-progs/btrfs-convert sda3.img
btrfs-convert from btrfs-progs v6.8.1

Source filesystem:
Type: ext2
Label:
Blocksize: 4096
UUID: b3a78a9f-37e7-4ccb-bedb-1f800a6a5a19
Target filesystem:
Label:
Blocksize: 4096
Nodesize: 16384
UUID: 981d2a1c-c1a9-47b7-acf2-9724ebc96ed0
Checksum: crc32c
Features: extref, skinny-metadata, no-holes, free-space-tree (default)
Data csum: yes
Inline data: yes
Copy xattr: yes
Reported stats:
Total space: 25769803776
Free space: 8862961664 (34.39%)
Inode count: 1572864
Free inodes: 1326275
Block count: 6291456
Create initial btrfs filesystem
Create ext2 image file
Create btrfs metadata
Copy inodes [o] [ 388838/ 246589]
Free space cache cleared
Conversion complete

(chroot) livecd / # mount -o ro sda3.img k
(chroot) livecd / # cd k
(chroot) livecd /k # md5sum -c ../files.md5 | grep -v OK
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/3561288849sdhlie.sqlite:
FAILED
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/1657114595AmcateirvtiSty.sqlite:
FAILED
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/2823318777ntouromlalnodry--naod.sqlite:
FAILED
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/2918063365piupsah.sqlite:
FAILED
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/1451318868ntouromlalnodry--epcr.sqlite:
FAILED
./root/.mozilla/firefox/s554srh9.default-release/favicons.sqlite: FAILED
./root/.mozilla/firefox/s554srh9.default-release/places.sqlite: FAILED
md5sum: WARNING: 7 computed checksums did NOT match

(chroot) livecd /k # filefrag -v
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/3561288849sdhlie.sqlite
Filesystem type is: 9123683e
File size of ./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/3561288849sdhlie.sqlite
is 49152 (12 blocks of 4096 bytes)
ext: logical_offset: physical_offset: length: expected: flags:
0: 0.. 1: 2217003.. 2217004: 2: shared
1: 2.. 11: 2217019.. 2217028: 10: 2217005: last,shared,eof
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/3561288849sdhlie.sqlite:
2 extents found
(chroot) livecd /k # filefrag -v
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/1657114595AmcateirvtiSty.sqlite
Filesystem type is: 9123683e
File size of ./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/1657114595AmcateirvtiSty.sqlite
is 49152 (12 blocks of 4096 bytes)
ext: logical_offset: physical_offset: length: expected: flags:
0: 0.. 1: 2217085.. 2217086: 2: shared
1: 2.. 11: 2217101.. 2217110: 10: 2217087: last,shared,eof
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/1657114595AmcateirvtiSty.sqlite:
2 extents found
(chroot) livecd /k # filefrag -v
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/2823318777ntouromlalnodry--naod.sqlite
Filesystem type is: 9123683e
File size of ./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/2823318777ntouromlalnodry--naod.sqlite
is 49152 (12 blocks of 4096 bytes)
ext: logical_offset: physical_offset: length: expected: flags:
0: 0.. 1: 2222643.. 2222644: 2: shared
1: 2.. 11: 2244137.. 2244146: 10: 2222645: last,shared,eof
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/2823318777ntouromlalnodry--naod.sqlite:
2 extents found
(chroot) livecd /k # filefrag -v
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/2918063365piupsah.sqlite
Filesystem type is: 9123683e
File size of ./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/2918063365piupsah.sqlite
is 49152 (12 blocks of 4096 bytes)
ext: logical_offset: physical_offset: length: expected: flags:
0: 0.. 1: 2244148.. 2244149: 2: shared
1: 2.. 11: 2244164.. 2244173: 10: 2244150: last,shared,eof
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/2918063365piupsah.sqlite:
2 extents found
(chroot) livecd /k # filefrag -v
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/1451318868ntouromlalnodry--epcr.sqlite
Filesystem type is: 9123683e
File size of ./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/1451318868ntouromlalnodry--epcr.sqlite
is 49152 (12 blocks of 4096 bytes)
ext: logical_offset: physical_offset: length: expected: flags:
0: 0.. 1: 2217030.. 2217031: 2: shared
1: 2.. 11: 2217046.. 2217055: 10: 2217032: last,shared,eof
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/1451318868ntouromlalnodry--epcr.sqlite:
2 extents found
(chroot) livecd /k # filefrag -v
./root/.mozilla/firefox/s554srh9.default-release/favicons.sqlite
Filesystem type is: 9123683e
File size of ./root/.mozilla/firefox/s554srh9.default-release/favicons.sqlite
is 5242880 (1280 blocks of 4096 bytes)
ext: logical_offset: physical_offset: length: expected: flags:
0: 0.. 7: 2244106.. 2244113: 8: shared
1: 8.. 1279: 1449984.. 1451255: 1272: 2244114: last,shared,eof
./root/.mozilla/firefox/s554srh9.default-release/favicons.sqlite: 2
extents found
(chroot) livecd /k # filefrag -v
./root/.mozilla/firefox/s554srh9.default-release/places.sqlite
Filesystem type is: 9123683e
File size of ./root/.mozilla/firefox/s554srh9.default-release/places.sqlite
is 5242880 (1280 blocks of 4096 bytes)
ext: logical_offset: physical_offset: length: expected: flags:
0: 0.. 7: 2244097.. 2244104: 8: shared
1: 8.. 1279: 1485312.. 1486583: 1272: 2244105: last,shared,eof
./root/.mozilla/firefox/s554srh9.default-release/places.sqlite: 2 extents found
(chroot) livecd /k # cd ..
(chroot) livecd / # umount k
(chroot) livecd / # B/btrfs-progs/btrfs-convert -r sda3.img
btrfs-convert from btrfs-progs v6.8.1

Open filesystem for rollback:
Label:
UUID: 981d2a1c-c1a9-47b7-acf2-9724ebc96ed0
Restoring from: ext2_saved/image
Rollback succeeded

(chroot) livecd / # mount -o ro sda3.img k
(chroot) livecd / # cd k
(chroot) livecd /k # filefrag -v
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/3561288849sdhlie.sqlite
Filesystem type is: ef53
File size of ./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/3561288849sdhlie.sqlite
is 49152 (12 blocks of 4096 bytes)
ext: logical_offset: physical_offset: length: expected: flags:
0: 0.. 1: 2217003.. 2217004: 2:
1: 2.. 10: 2217019.. 2217027: 9: 2217005:
2: 11.. 11: 2217028.. 2217028: 1: last,unwritten,eof
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/3561288849sdhlie.sqlite:
2 extents found
(chroot) livecd /k # filefrag -v
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/1657114595AmcateirvtiSty.sqlite
Filesystem type is: ef53
File size of ./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/1657114595AmcateirvtiSty.sqlite
is 49152 (12 blocks of 4096 bytes)
ext: logical_offset: physical_offset: length: expected: flags:
0: 0.. 1: 2217085.. 2217086: 2:
1: 2.. 10: 2217101.. 2217109: 9: 2217087:
2: 11.. 11: 2217110.. 2217110: 1: last,unwritten,eof
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/1657114595AmcateirvtiSty.sqlite:
2 extents found
(chroot) livecd /k # filefrag -v
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/2823318777ntouromlalnodry--naod.sqlite
Filesystem type is: ef53
File size of ./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/2823318777ntouromlalnodry--naod.sqlite
is 49152 (12 blocks of 4096 bytes)
ext: logical_offset: physical_offset: length: expected: flags:
0: 0.. 1: 2222643.. 2222644: 2:
1: 2.. 10: 2244137.. 2244145: 9: 2222645:
2: 11.. 11: 2244146.. 2244146: 1: last,unwritten,eof
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/2823318777ntouromlalnodry--naod.sqlite:
2 extents found
(chroot) livecd /k # filefrag -v
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/2918063365piupsah.sqlite
Filesystem type is: ef53
File size of ./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/2918063365piupsah.sqlite
is 49152 (12 blocks of 4096 bytes)
ext: logical_offset: physical_offset: length: expected: flags:
0: 0.. 1: 2244148.. 2244149: 2:
1: 2.. 10: 2244164.. 2244172: 9: 2244150:
2: 11.. 11: 2244173.. 2244173: 1: last,unwritten,eof
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/2918063365piupsah.sqlite:
2 extents found
(chroot) livecd /k # filefrag -v
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/1451318868ntouromlalnodry--epcr.sqlite
Filesystem type is: ef53
File size of ./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/1451318868ntouromlalnodry--epcr.sqlite
is 49152 (12 blocks of 4096 bytes)
ext: logical_offset: physical_offset: length: expected: flags:
0: 0.. 1: 2217030.. 2217031: 2:
1: 2.. 10: 2217046.. 2217054: 9: 2217032:
2: 11.. 11: 2217055.. 2217055: 1: last,unwritten,eof
./root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/1451318868ntouromlalnodry--epcr.sqlite:
2 extents found
(chroot) livecd /k # filefrag -v
./root/.mozilla/firefox/s554srh9.default-release/favicons.sqlite
Filesystem type is: ef53
File size of ./root/.mozilla/firefox/s554srh9.default-release/favicons.sqlite
is 5242880 (1280 blocks of 4096 bytes)
ext: logical_offset: physical_offset: length: expected: flags:
0: 0.. 7: 2244106.. 2244113: 8:
1: 8.. 79: 1449984.. 1450055: 72: 2244114:
2: 80.. 1279: 1450056.. 1451255: 1200: last,unwritten,eof
./root/.mozilla/firefox/s554srh9.default-release/favicons.sqlite: 2
extents found
(chroot) livecd /k # filefrag -v
./root/.mozilla/firefox/s554srh9.default-release/places.sqlite
Filesystem type is: ef53
File size of ./root/.mozilla/firefox/s554srh9.default-release/places.sqlite
is 5242880 (1280 blocks of 4096 bytes)
ext: logical_offset: physical_offset: length: expected: flags:
0: 0.. 7: 2244097.. 2244104: 8:
1: 8.. 415: 1485312.. 1485719: 408: 2244105:
2: 416.. 1279: 1485720.. 1486583: 864: last,unwritten,eof
./root/.mozilla/firefox/s554srh9.default-release/places.sqlite: 2 extents found
(chroot) livecd /k #

Regards, Jordan.

