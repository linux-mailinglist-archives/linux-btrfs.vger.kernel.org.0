Return-Path: <linux-btrfs+bounces-9013-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 727DF9A5371
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Oct 2024 12:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920011F22657
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Oct 2024 10:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381C9126BE6;
	Sun, 20 Oct 2024 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="pzUz46PV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA317485
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Oct 2024 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729419529; cv=none; b=BxanWBrKUjvWuBvaDe7FeIgNdb4FgBVQh6iEXY71Edg4sCngUVbjhG4X4nOaGPCl/fDH3yFN5NDk+QSPiDGhpfKL3hTdr7/0ikSYNpSSCJNDm3uDixZSIKLVb4PJDVMSvpDhvTbgbB4cnq6Fu/81jIaVFjygGQIHaCrSJWF8dw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729419529; c=relaxed/simple;
	bh=i8MdBK0bWdCWfW6iOSqWDjuPZ3eI3s/TCREhKQEdoqc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rjI1Oy7KDhOlunKuV8AAo3VZGRXdI0lAIwe2iKl4mRezkeix3PGBv7IV6yXKvXbN6IO65rmeY9dgk9PMK1ofvLHguwAxyPNv+vjwXl7jYIuhJ9SnV3Embe35fN+GH/EOMye1/Uf/gIIvVSb76bq0TEFVnCtX26C2UFYNIEIeR00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=pzUz46PV; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1729418996;
	bh=NysYr3zC6we4BGAwuobFoxTls4Trtrv3xMQCasUwkQc=; l=9768;
	h=From:To:Reply-To:Subject:Date:From;
	b=pzUz46PV5bUEq8BSXPzkPiLDOCfL1y2Dy7KFciypwF1FOpcirlu683SSQtmLJ+2Ip
	 VY0VZVTriPT1fbl8AurWUQLbVvfdtHo+XcxizQM8B1g9vHku4oNkc4GglRyBL60v4F
	 4+9rrTSyjn/vOSKSaK/GA1Ay2J6JW1QJ+QLhoWTM=
Received: from xev.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 17CDCEB84
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Oct 2024 21:09:56 +1100 (AEDT)
Received: by xev.coker.com.au (Postfix, from userid 1001)
	id 2E77B58E9E00; Sun, 20 Oct 2024 21:09:51 +1100 (AEDT)
From: Russell Coker <russell@coker.com.au>
To: linux-btrfs@vger.kernel.org
Reply-To: russell@coker.com.au
Subject: strangely uncorrectable errors with RAID-5
Date: Sun, 20 Oct 2024 21:09:50 +1100
Message-ID: <23840777.EfDdHjke4D@xev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

I've been testing out BTRFS RAID-5 with Debian kernels 6.10.9 and 6.11.2 from 
Unstable.

I know that RAID-5 is not expected to be good enough for real data but it 
still seemed interesting to test it as apparently there have been improvemnts 
recently.  I created some errors that SHOULD be recoverable (and are 
recoverable with RAID-1) which turned out to not be recoverable (according to 
BTRFS) even though the diff command reported that the data was intact.  Now I 
can't get the filesystem to an error-free status.

To test it I created a 4 device RAID-5 filesystem and ran the following script 
to stress it a bit:

#!/bin/bash
set -e
cd /mnt
while true ; do
  cp -r usr usr2
  cp -r usr usr3
  cp -r usr usr4
  cp -r usr usr5
  sync
  diff -ru usr usr2
  diff -ru usr usr3
  diff -ru usr usr4
  diff -ru usr usr5
  rm -rf usr?
done

Then I ran the following script to cause corruption and scrub it to see what 
happens:

#!/bin/bash
set -e
while true ; do
  for DEV in c d e f ; do
    dd if=/dev/zero of=/dev/vd$DEV oseek=$((20+$RANDOM%3*1000)) bs=1024k \ 
count=1000
    sync
    btrfs scrub start -B /mnt
    sync
  done
done

It didn't take very long before it reported problems scrubbing the filesystem 
even though the diff commands didn't report any errors.  According to diff 
that filesystem has not lost any data, but now even after rebooting I get the 
following when I run a scrub:

root@testing1:~# btrfs scrub start -B /mnt
Starting scrub on devid 1
Starting scrub on devid 2
Starting scrub on devid 3
Starting scrub on devid 4
ERROR: scrubbing /mnt failed for device id 1: ret=-1, errno=5 (Input/output 
error)
ERROR: scrubbing /mnt failed for device id 2: ret=-1, errno=5 (Input/output 
error)
ERROR: scrubbing /mnt failed for device id 3: ret=-1, errno=5 (Input/output 
error)
ERROR: scrubbing /mnt failed for device id 4: ret=-1, errno=5 (Input/output 
error)
scrub canceled for f8a30d07-f92e-4dfc-a62f-f49d35b70467
Scrub started:    Sun Oct 20 10:01:21 2024
Status:           aborted
Duration:         0:00:03
Total to scrub:   332.22MiB
Rate:             110.74MiB/s (some device limits set)
Error summary:    csum=4
  Corrected:      0
  Uncorrectable:  4
  Unverified:     0
root@testing1:~# btrfs scrub start -B /mnt
Starting scrub on devid 1
Starting scrub on devid 2
Starting scrub on devid 3
Starting scrub on devid 4
ERROR: scrubbing /mnt failed for device id 1: ret=-1, errno=5 (Input/output 
error)
ERROR: scrubbing /mnt failed for device id 2: ret=-1, errno=5 (Input/output 
error)
ERROR: scrubbing /mnt failed for device id 3: ret=-1, errno=5 (Input/output 
error)
ERROR: scrubbing /mnt failed for device id 4: ret=-1, errno=5 (Input/output 
error)
scrub canceled for f8a30d07-f92e-4dfc-a62f-f49d35b70467
Scrub started:    Sun Oct 20 10:01:27 2024
Status:           aborted
Duration:         0:00:03
Total to scrub:   332.22MiB
Rate:             110.74MiB/s (some device limits set)
Error summary:    csum=4
  Corrected:      0
  Uncorrectable:  4
  Unverified:     0

Below is some output from dmesg:

[   36.975742] BTRFS info (device vdc): bdev /dev/vdc errs: wr 0, rd 0, flush 
0, corrupt 5443, gen 0
[   36.976083] BTRFS info (device vdc): bdev /dev/vde errs: wr 0, rd 0, flush 
0, corrupt 13127, gen 0
[   36.976397] BTRFS info (device vdc): bdev /dev/vdf errs: wr 0, rd 0, flush 
0, corrupt 1412, gen 0
[   38.877364] BTRFS info (device vdc): scrub: started on devid 3
[   38.878607] BTRFS info (device vdc): scrub: started on devid 4
[   38.880468] BTRFS info (device vdc): scrub: started on devid 1
[   38.885000] BTRFS info (device vdc): scrub: started on devid 2
[   39.347569] BTRFS warning (device vdc): tree block 412024832 mirror 1 has 
bad bytenr, has 0 want 412024832
[   39.350325] BTRFS warning (device vdc): tree block 412024832 mirror 1 has 
bad bytenr, has 0 want 412024832
[   39.353158] BTRFS warning (device vdc): tree block 412024832 mirror 1 has 
bad bytenr, has 0 want 412024832
[   39.355091] BTRFS warning (device vdc): tree block 412024832 mirror 1 has 
bad bytenr, has 0 want 412024832
[   39.355786] BTRFS error (device vdc): unable to fixup (regular) error at 
logical 412024832 on dev /dev/vde physical 315555840
[   39.356293] BTRFS warning (device vdc): checksum error at logical 412024832 
on dev /dev/vde, physical 315555840: metadata leaf (level 0) in tree 2
[   39.357059] BTRFS error (device vdc): unable to fixup (regular) error at 
logical 412024832 on dev /dev/vde physical 315555840
[   39.357198] BTRFS warning (device vdc): tree block 412024832 mirror 1 has 
bad bytenr, has 0 want 412024832
[   39.357602] BTRFS warning (device vdc): checksum error at logical 412024832 
on dev /dev/vde, physical 315555840: metadata leaf (level 0) in tree 2
[   39.359539] BTRFS warning (device vdc): tree block 412024832 mirror 1 has 
bad bytenr, has 0 want 412024832
[   39.363175] BTRFS error (device vdc): unable to fixup (regular) error at 
logical 412024832 on dev /dev/vde physical 315555840
[   39.364156] BTRFS warning (device vdc): checksum error at logical 412024832 
on dev /dev/vde, physical 315555840: metadata leaf (level 0) in tree 2
[   39.364813] BTRFS error (device vdc): unable to fixup (regular) error at 
logical 412024832 on dev /dev/vde physical 315555840
[   39.365519] BTRFS warning (device vdc): checksum error at logical 412024832 
on dev /dev/vde, physical 315555840: metadata leaf (level 0) in tree 2
[   39.365838] BTRFS warning (device vdc): tree block 412024832 mirror 1 has 
bad bytenr, has 0 want 412024832
[   39.368456] BTRFS warning (device vdc): tree block 412024832 mirror 1 has 
bad bytenr, has 0 want 412024832
[   39.369461] BTRFS error (device vdc): unrepaired sectors detected, full 
stripe 411893760 data stripe 2 errors 0-3
[   39.370175] BTRFS info (device vdc): scrub: not finished on devid 4 with 
status: -5
[   41.231719] BTRFS error (device vdc): bad tree block start, mirror 1 want 
412024832 have 0
[   41.232326] BTRFS error (device vdc): bad tree block start, mirror 2 want 
412024832 have 0
[   41.232832] BTRFS error (device vdc): bad tree block start, mirror 1 want 
412024832 have 0
[   41.233470] BTRFS error (device vdc): bad tree block start, mirror 2 want 
412024832 have 0
[   41.234085] BTRFS info (device vdc): scrub: not finished on devid 1 with 
status: -5
[   41.234170] BTRFS info (device vdc): scrub: not finished on devid 2 with 
status: -5
[   41.234231] BTRFS info (device vdc): scrub: not finished on devid 3 with 
status: -5
[   44.243128] BTRFS info (device vdc): scrub: started on devid 1
[   44.243901] BTRFS info (device vdc): scrub: started on devid 2
[   44.243928] BTRFS info (device vdc): scrub: started on devid 4
[   44.244796] BTRFS info (device vdc): scrub: started on devid 3
[   44.774710] BTRFS warning (device vdc): tree block 412024832 mirror 1 has 
bad bytenr, has 0 want 412024832
[   44.793802] BTRFS warning (device vdc): tree block 412024832 mirror 1 has 
bad bytenr, has 0 want 412024832
[   44.797168] BTRFS warning (device vdc): tree block 412024832 mirror 1 has 
bad bytenr, has 0 want 412024832
[   44.803175] BTRFS warning (device vdc): tree block 412024832 mirror 1 has 
bad bytenr, has 0 want 412024832
[   44.807162] BTRFS error (device vdc): unable to fixup (regular) error at 
logical 412024832 on dev /dev/vde physical 315555840
[   44.810892] BTRFS warning (device vdc): checksum error at logical 412024832 
on dev /dev/vde, physical 315555840: metadata leaf (level 0) in tree 2
[   44.811443] BTRFS error (device vdc): unable to fixup (regular) error at 
logical 412024832 on dev /dev/vde physical 315555840
[   44.823205] BTRFS warning (device vdc): tree block 412024832 mirror 1 has 
bad bytenr, has 0 want 412024832
[   44.823540] BTRFS warning (device vdc): checksum error at logical 412024832 
on dev /dev/vde, physical 315555840: metadata leaf (level 0) in tree 2
[   44.823544] BTRFS error (device vdc): unable to fixup (regular) error at 
logical 412024832 on dev /dev/vde physical 315555840
[   44.823546] BTRFS warning (device vdc): checksum error at logical 412024832 
on dev /dev/vde, physical 315555840: metadata leaf (level 0) in tree 2
[   44.823547] BTRFS error (device vdc): unable to fixup (regular) error at 
logical 412024832 on dev /dev/vde physical 315555840
[   44.823549] BTRFS warning (device vdc): checksum error at logical 412024832 
on dev /dev/vde, physical 315555840: metadata leaf (level 0) in tree 2
[   44.832155] BTRFS warning (device vdc): tree block 412024832 mirror 1 has 
bad bytenr, has 0 want 412024832
[   44.838895] BTRFS warning (device vdc): tree block 412024832 mirror 1 has 
bad bytenr, has 0 want 412024832
[   44.844663] BTRFS warning (device vdc): tree block 412024832 mirror 1 has 
bad bytenr, has 0 want 412024832
[   44.845561] BTRFS error (device vdc): unrepaired sectors detected, full 
stripe 411893760 data stripe 2 errors 0-3
[   44.846842] BTRFS info (device vdc): scrub: not finished on devid 4 with 
status: -5
[   47.746767] BTRFS error (device vdc): bad tree block start, mirror 1 want 
412024832 have 0
[   47.748256] BTRFS error (device vdc): bad tree block start, mirror 2 want 
412024832 have 0
[   47.749069] BTRFS info (device vdc): scrub: not finished on devid 3 with 
status: -5
[   47.754752] BTRFS error (device vdc): bad tree block start, mirror 1 want 
412024832 have 0
[   47.755952] BTRFS error (device vdc): bad tree block start, mirror 2 want 
412024832 have 0
[   47.758766] BTRFS info (device vdc): scrub: not finished on devid 2 with 
status: -5
[   47.822683] BTRFS error (device vdc): bad tree block start, mirror 1 want 
412024832 have 0
[   47.826760] BTRFS error (device vdc): bad tree block start, mirror 2 want 
412024832 have 0
[   47.834688] BTRFS info (device vdc): scrub: not finished on devid 1 with 
status: -5

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/


