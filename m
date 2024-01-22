Return-Path: <linux-btrfs+bounces-1604-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B109C836849
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 16:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C31D4B2C599
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA105C61C;
	Mon, 22 Jan 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grandmasfridge.org header.i=@grandmasfridge.org header.b="JzBvod2n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from serenity.grandmasfridge.org (grandmasfridge.org [45.56.116.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3531C5C5FB
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.56.116.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935620; cv=none; b=HjY5EYfYgWEGhiz+7GuAyMEieoKiEgrndLz8JneAj5FUrYRgv2jT0TssIszwQcuaNeSD+bxeEDeWeRv69il+fuvtW8J85mRq0457uE56+00qEPl96+PSQj5+Eb5P1NYDn7UQEQ7v7u+gEeop4HAnCK/zuXn+Ap8y20Y4Ns0JAQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935620; c=relaxed/simple;
	bh=F1wcgAJ/vE6K4ew1pCU9BmlCCxVeOw20ex6DLurFQss=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FJRYuzhcaR9loRo7rvJq82qbTu6LSd2+/LZ4MS3v8iT5zHC+9I++YpC8jrNDEf2SQwN2LiAQTO33550Pvze0eyhrzy0REmX9qg5H5YVqpz3jSJklTA1PxWd13zdZGf8bJjNIRZRqZOdg1hkc7jKNZ4u5Mn8ROG++7pY86xavrNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grandmasfridge.org; spf=pass smtp.mailfrom=grandmasfridge.org; dkim=pass (1024-bit key) header.d=grandmasfridge.org header.i=@grandmasfridge.org header.b=JzBvod2n; arc=none smtp.client-ip=45.56.116.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grandmasfridge.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grandmasfridge.org
Received: from Gilman (2603-6080-2500-7075-7eca-0212-c345-fe14.res6.spectrum.com [IPv6:2603:6080:2500:7075:7eca:212:c345:fe14])
	(Authenticated sender: aaron@grandmasfridge.org)
	by serenity.grandmasfridge.org (Postfix) with ESMTPSA id E6AFD7FDC8
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 14:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grandmasfridge.org;
	s=serenity; t=1705935287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=7k9WWbaI8JkxQ6qlgOklsza5ZMbHBB45nGJnjTT7eEs=;
	b=JzBvod2npkWVOQQpweQRJJhRxzzyiV9W9dnv7ygcoQ75FpAGZoTwYKuxKUSsfnuFd8jsE1
	5VEx4USTOdibHEYmkar4H0LXuTFyZvtydIaBCEe06gl6mQzR4W+8bJWG950x6A8mmBgqFY
	11tal6RRdPa65QGxHpJSgQx0tiOJu50=
User-agent: mu4e 1.10.6; emacs 29.1
From: "Aaron W. Swenson" <aaron@grandmasfridge.org>
To: linux-btrfs@vger.kernel.org
Subject: RAID1 array failed to read chunk root
Date: Mon, 22 Jan 2024 09:53:04 -0500
Message-ID: <87zfwxe7vf.fsf@grandmasfridge.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; format=flowed

After moving residences, I've finally got my computer setup to 
find the array failed to mount. When trying to mount the RAID 
array, I get:

	root # mount -o compress=lzo,noatime,degraded /dev/sdc 
	/srv
	mount: /srv: wrong fs type, bad option, bad superblock on 
	/dev/sdc, missing codepage or helper program, or other 
	error.
       	dmesg(1) may have more information after failed mount 
       system call.

And in dmesg I see:

	[394680.895543] BTRFS info (device sdd): using crc32c 
	(crc32c-generic) checksum algorithm
	[394680.895555] BTRFS info (device sdd): use lzo 
	compression, level 0
	[394680.895557] BTRFS info (device sdd): allowing degraded 
	mounts
	[394680.895558] BTRFS info (device sdd): disk space 
	caching is enabled
	[394680.895802] BTRFS error (device sdd): failed to read 
	chunk root
	[394680.895903] BTRFS error (device sdd): open_ctree 
	failed

Running the command:

	root # btrfs rescue chunk-recover -v /dev/sdd

Takes a few hours (there are eight 4 TB drives in the array). It 
selected three devices from the RAID1 array (I think it was sdc, 
sdd, and sde...but that bit got purged from the scrollback 
buffer), and ultimately resulted in:

	Invalid mapping for 17983143280640-17983143297024, got 
	23995541880832-23996615622656
	Couldn't map the block 17983143280640
	Couldn't read tree root
	open with broken chunk error
	Chunk tree recovery failed

Here's some stats about my machine:

# uname -a
Gentoo Linux martineau 6.1.28-gentoo #1 SMP Sat May 27 19:30:38 
EDT 2023 x86_64 Intel(R) Core(TM) i3-4160 CPU @ 3.60GHz 
GenuineIntel GNU/Linux
# btrfs version
btrfs-progs v6.6.3

Here's a table of my drives (excludes new Seagate Ironwolf 4TB 
that's still in the packaging). All drives in Bay 1 and Bay 2 are 
a part of the same RAID1 array. The Crucial drive is an SSD that's 
setup in the boring typical fashion for a root drive. A couple 
have failed in the past, but I had been able to mount degraded and 
replace the failed drive. I should note, a couple of days ago it 
reported that /dev/sdg was missing (same experience I've had twice 
before), which is why I have the spare drive. Now, it isn't 
reporting anything about the drive.

| ID | Path 	| Bay | Slot | Make	| Model 
  | Size  |
|----+----------+-----+------+---------+---------------------------------------+-------|
|  1 | /dev/sda |   0 |	0 | Crucial | BX100 (CT250BX100SSD1) 
   | 250GB |
| 10 | /dev/sdc |   1 |	1 | Seagate | Constellation ES.3 
  (ST4000NM0033-9ZM) | 4TB   |
|  9 | /dev/sdb |   1 |	2 | Seagate | Constellation ES.3 
   (ST4000NM0033-9ZM) | 4TB   |
|  7 | /dev/sdi |   1 |	3 | Seagate | Constellation ES.3 
   (ST4000NM0033-9ZM) | 4TB   |
|  8 | /dev/sdh |   1 |	4 | Seagate | Ironwolf (ST4000VN008-2DR1) 
   | 4TB   |
|  5 | /dev/sdf |   2 |	1 | Seagate | Constellation ES.3 
   (ST4000NM0033-9ZM) | 4TB   |
|  6 | /dev/sdd |   2 |	2 | Seagate | Ironwolf (ST4000VN008-2DR1) 
   | 4TB   |
|  4 | /dev/sdg |   2 |	3 | Seagate | Constellation ES.3 
   (ST4000NM0033-9ZM) | 4TB   |
|  3 | /dev/sde |   2 |	4 | Seagate | Constellation ES.3 
   (ST4000NM0033-9ZM) | 4TB   |

It isn't the end of the world if I lose the data, but some of the 
videos and photos are sentimental. There's no time crunch for me, 
so if it takes a long time to work through, I have the time to do 
so.

WKR,
Aaron

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iO8EARYKAJcWIQQEC6Ot+QKFRWIXfOT/l1wNKJSl0QUCZa6BpF8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MDQw
QkEzQURGOTAyODU0NTYyMTc3Q0U0RkY5NzVDMEQyODk0QTVEMRkcYWFyb25AZ3Jh
bmRtYXNmcmlkZ2Uub3JnAAoJEP+XXA0olKXRtE4BAKtxM2RUaxwollyb13BdvyI2
Njol73Q1HEvFWFZ/Jru8AP0bFlumDSZmp4F5eKnio1W9Udo2vALbSzh1BRk8XaoL
CA==
=GYDQ
-----END PGP SIGNATURE-----
--=-=-=--

