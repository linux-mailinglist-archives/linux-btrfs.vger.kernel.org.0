Return-Path: <linux-btrfs+bounces-11351-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0645BA2DEB0
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Feb 2025 16:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F171887168
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Feb 2025 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8973C1DF733;
	Sun,  9 Feb 2025 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzLvtVfM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C511D7992
	for <linux-btrfs@vger.kernel.org>; Sun,  9 Feb 2025 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739113702; cv=none; b=Pl0PGICSe46B7ECqfF2uTQBvdl0vxLSCOeRrJuGFtVQapQlXwW9Qm5DjfIu+wqNFzHiHEu8dc+bD63VpunW4/bRDUMpyADSTiL9Cpn5sk4+8rAWFztaEP6e3VuInExDCvy2tE5/oTs2GxVcWJpI2zSama11M73HABVVgI0fv9WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739113702; c=relaxed/simple;
	bh=NW3BpMt9q8PkUeliwiOQMBu0sWSwv/2t7W7Ml/EsZc0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YE0bZ8+W4wqjTIokDKunzkW1CGhaRBm1fJW8eCPiHPZjZlqiGXdPOlrzQHZSjjvnQkvKz9iniFcJFgWSIt034otC4RGjtl5fDZWBu1f7BVydo2KYzDikk1dXyQwudQSAmtam33BR9Mw7RYo2LgnTjzeFktYObueUgMBCeNK0mZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzLvtVfM; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de7531434fso642063a12.0
        for <linux-btrfs@vger.kernel.org>; Sun, 09 Feb 2025 07:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739113698; x=1739718498; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DQKahBUur5ceNDWc3dIP/MYM1jKQUsoZVMxThfVvjvY=;
        b=WzLvtVfMLGa+flGHePP1kBR1C0iYnK4pFawXA/st6WUK0tPZDqsjNC5ryh1PZCCBRm
         tMEv5qK2snFURkcjnFrqjQqQdECH77scsyIXmFYg4GCRykX4JBqnUDiUDz/vgEJfgNHb
         wzK6XSTV79YHpIzCf0aorqjm4PiRJeEkQfGRQc6eEB3wIuOJnsBLr+hBHDrcr7+y9yiD
         iSjooTC/CqBrCHLWwvV86o8wIbYGCgbNcAeAQySflfl6poeFpT8Sz/62qqJDk8wiUZM8
         f0WddUEDCm9LbdeUYu4KXNAVlLyFGx9PuO0G9KcMA5nDmeyhGF4wwQnO5nT8wDFRXUUZ
         RJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739113698; x=1739718498;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQKahBUur5ceNDWc3dIP/MYM1jKQUsoZVMxThfVvjvY=;
        b=cieykldMTg/b6DYFtERUt01yTy4QKgbLdJ19krw0gHYqI9pjFnvRZLnG5z9pSq/468
         IPh9swMn2C47guuB+ChhQn+OzYYYjeyVF27qIYRq3FioiT0FECwJpeh/FqERHEqAWZ+G
         rLrlaRV4NmuZ+dPjodg8WZ2e3cuUQwBHp9SDc0sC49fONz0QjFIFnICwgP8hZJu00s2k
         F2qGLhM/6yk4s4EBqLWZ6aEoDXz+SLsohQGkgvpQSbkXybyuWtIn+FG1WtSLMg0JNf8s
         osDN7sgt9hNhwVQQlDM9YitwDMKj82r+nNA92GgTCWMRQmhtsljwg9976XF6BKFInd3k
         SFaA==
X-Gm-Message-State: AOJu0YzGX1Y3Txd0ccfzSoKeWItxZxAdMGIpUUgqKT92Xb7jLVK8lCye
	cSa6ttypIkcAX40Mhh9ETrGTm4nW4EjLKrPFwLvVDDpoiOkR1ZPRTKbBatv7FYyKoOJls8rxH5U
	BlBkHUjax4WxYq/Sn3d85adOHc9TIgLh5HEwj8g==
X-Gm-Gg: ASbGnctCdPL8Nh+3S7wrlZ6ldhsBkoSLlsgzJyFOrhKsu47bmbI9KDttmBze5AqY9JD
	iJ5DrgSBgBZUEUZYXza8S7UJF/oU7polDdUoGXGokFQxG4zwhiwUbM48OGeF1Bmp80iETte7tdF
	DaTq6JV35POrs=
X-Google-Smtp-Source: AGHT+IF4Fhwhpvh/WDDxPMASopj5RDVSVHRjzXF/QYC67t0SUMZop2QuUFit0DDhUTgMl58AFKBgfdJuNe7yp1dBZFM=
X-Received: by 2002:a05:6402:4606:b0:5dc:7538:3d3 with SMTP id
 4fb4d7f45d1cf-5de4503febcmr11608510a12.5.1739113697625; Sun, 09 Feb 2025
 07:08:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Abdulla Bubshait <darkstego@gmail.com>
Date: Sun, 9 Feb 2025 10:08:05 -0500
X-Gm-Features: AWEUYZmtPEMbPgro8389jyYagFu_J_R2hwiktSQ40EkO74o6R9ddmm4akvXu5iY
Message-ID: <CADOXG6GukpR3DPPT808+MMCtMo8B8HW43VwAqVyd5iP9xoH5GA@mail.gmail.com>
Subject: Deleted or Orphaned extent not being cleaned up
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have a problem with my btrfs system that is causing a few issues.
Issues were in kernel 6.12 and still persist in kernel 6.13.0

Mounting at boot has this problem:
[    8.457699] Btrfs loaded, zoned=yes, fsverity=yes
[    8.463544] BTRFS: device label horde devid 2 transid 2428513
/dev/sdd (8:48) scanned by (udev-worker) (741)
[    8.463645] BTRFS: device label horde devid 5 transid 2428513
/dev/sdf (8:80) scanned by (udev-worker) (761)
[    8.463928] BTRFS: device label horde devid 3 transid 2428513
/dev/sdb1 (8:17) scanned by (udev-worker) (810)
[    8.463946] BTRFS: device label horde devid 4 transid 2428513
/dev/sdc (8:32) scanned by (udev-worker) (721)
[    8.463966] BTRFS: device label horde devid 1 transid 2428513
/dev/sde (8:64) scanned by (udev-worker) (751)
[    9.145058] BTRFS info (device sde): first mount of filesystem
26debbc1-fdd0-4c3a-8581-8445b99c067c
[    9.145064] BTRFS info (device sde): using crc32c (crc32c-intel)
checksum algorithm
[    9.145067] BTRFS info (device sde): using free-space-tree
[   74.766650] BTRFS error (device sde): parent transid verify failed
on logical 118776413634560 mirror 2 wanted 1840596 found 1740357
[   74.782064] BTRFS error (device sde): parent transid verify failed
on logical 118776413634560 mirror 1 wanted 1840596 found 1740357
[   74.782093] BTRFS error (device sde): Error removing orphan entry,
stopping orphan cleanup
[   74.782097] BTRFS error (device sde): could not do orphan cleanup -22
[   79.968610] BTRFS error (device sde): open_ctree failed

I can still mount the filesystem as ro, then remount it as rw which
gives me access to my system without any issues.

Running a logical-resolve on the offending address (118776413634560) give:
ERROR: logical ino ioctl: No such file or directory

running btrfs check (btrfs-progs 6.12-2) gives the following (using
ellipses to cut off repeated messsage):
[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
parent transid verify failed on 118776413634560 wanted 1840596 found 1740357
parent transid verify failed on 118776413634560 wanted 1840596 found 1740357
parent transid verify failed on 118776413634560 wanted 1840596 found 1740357
Ignoring transid failure
ref mismatch on [101299707011072 172032] extent item 1, found 0
data extent[101299707011072, 172032] bytenr mimsmatch, extent item
bytenr 101299707011072 file item bytenr 0
data extent[101299707011072, 172032] referencer count mismatch (parent
118776413634560) wanted 1 have 0
backpointer mismatch on [101299707011072 172032]
owner ref check failed [101299707011072 172032]
ref mismatch on [101303265419264 172032] extent item 1, found 0
data extent[101303265419264, 172032] bytenr mimsmatch, extent item
bytenr 101303265419264 file item bytenr 0
data extent[101303265419264, 172032] referencer count mismatch (parent
118776413634560) wanted 1 have 0
backpointer mismatch on [101303265419264 172032]
owner ref check failed [101303265419264 172032]
.......1000 lines
ERROR: errors found in extent allocation tree or chunk allocation
[4/8] checking free space tree
[5/8] checking fs roots
parent transid verify failed on 118776413634560 wanted 1840596 found 1740357
Ignoring transid failure
parent transid verify failed on 118776413634560 wanted 1840596 found 1740357
Ignoring transid failure
....... 400 lines
Wrong key of child node/leaf, wanted: (4750734, 108, 918990848), have:
(18446744073709551606, 128, 95879105421312)
Wrong generation of child node/leaf, wanted: 1740357, have: 1840596
root 5 inode 305253 errors 2000, link count wrong
unresolved ref dir 5226045 index 26 namelen 9 name Foo D filetype 0
errors 3, no dir item, no dir index
root 5 inode 305498 errors 2000, link count wrong
unresolved ref dir 5227053 index 38 namelen 84 name foo.bar filetype 0
errors 3, no dir item, no dir index
root 5 inode 305613 errors 2000, link count wrong
unresolved ref dir 5230734 index 147 namelen 88 name foo2.bar filetype
0 errors 3, no dir item, no dir index
root 5 inode 305630 errors 2000, link count wrong
.......100,000 lines
ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/sde
UUID: 26debbc1-fdd0-4c3a-8581-8445b99c067c
found 63923737210880 bytes used, error(s) found
total csum bytes: 62318397744
total tree bytes: 71287357440
total fs tree bytes: 1053753344
total extent tree bytes: 661929984
btree space waste bytes: 6740509258
file data blocks allocated: 64021126631424
 referenced 63814394556416


Running a logical-resolve on the data extents listed that have the
offending extent (118776413634560) as a parent returns nothing (no
errors).
Checking a sample of the file names mentioned with link count wrong
and they appear to be fine in the filesystem.

What would be the steps to clean up these issues from the filesystem?

