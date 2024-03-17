Return-Path: <linux-btrfs+bounces-3340-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BD287DF0A
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Mar 2024 18:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7568282035
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Mar 2024 17:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CA91CFA9;
	Sun, 17 Mar 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="rpBOhuMP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ED41CD3C
	for <linux-btrfs@vger.kernel.org>; Sun, 17 Mar 2024 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710697156; cv=none; b=moGhpzbT4cdzIgOrVe1xum+CfgElKnUYsxsTr5V4uy8uouB4wIWP21gZmKheba/VEgV0fF+NI6FcqjB0fwGIfy/FcKg4sYkyUHIIAYJiMBQD+0P0HM0BqOXoF/uikNMf0/9PwpKN+krjGOan1/vtz6qBUiHkdepLtSM7CH/EeRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710697156; c=relaxed/simple;
	bh=G3RQiO+3acfdPJN427qElDOQ/2GOwoTUN+RHF6OxiZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ln8dDOlmJ+wXN/FPSPsnnKp5h2zB9ts6ITZMkS6EaAHBfDk/X258//j5E344wihs3ieqbCAeYRkKwI43YOD3QQICliESILLCpd0b2iDE2ic9Wjz8lIxNGzp79cc/hk3ixcEYOlICDRRvZJxG5gI+vtyxo/YTSDrUq3CUWlNtuw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=rpBOhuMP; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1710697150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bfpAH3dklB+8yPR+B88b6qSEO7NSAg2AetVksH+Hr1o=;
	b=rpBOhuMPvNanpr3MzxZnyPkkxQyR9yi8wG1sGM3arC39qVmQbl1hiOM66YW8o4kWnpAK07
	FoqLz2LQIB4NqrEgo+2Gw/kdaGWGsvYl/KT2qNSUgYaVjRD/WscNDo2Uuykb1hBQUyY06b
	EX3TITJcthRKdf9+iOMTy6r3xmi3jwVIbsgQOVbPdYS71iaGKQdwIpAf6La67c9YeezD2n
	6RCRATMNmP2dXT0mPWSYU7us6BW5X7Fce3seirt+LEf9kK3UNofwq9JBLHL2oj1DQSfIc1
	8BbhYbD2T4bBcpdt++9af+bQXOX1qw3h6P4dwsCJcm/rexf3bdFUsJoeSP7pJw==
From: Diederik de Haas <didi.debian@cknow.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Adam Borowski <kilobyte@angband.pl>,
 Nicholas D Steeves <sten@debian.org>,
 Debian kernel ML <debian-kernel@lists.debian.org>
Subject: btrfs: Kernel warning when using/mount RAID 5/6
Date: Sun, 17 Mar 2024 18:38:55 +0100
Message-ID: <4105665.mVaztBssJx@bagend>
Organization: Connecting Knowledge
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7345321.1qzUUeqQFO";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart7345321.1qzUUeqQFO
Content-Type: multipart/mixed; boundary="nextPart131595361.pUuz4S08WX";
 protected-headers="v1"
Content-Transfer-Encoding: 7Bit
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
Subject: btrfs: Kernel warning when using/mount RAID 5/6
Date: Sun, 17 Mar 2024 18:38:55 +0100
Message-ID: <4105665.mVaztBssJx@bagend>
Organization: Connecting Knowledge
MIME-Version: 1.0

This is a multi-part message in MIME format.

--nextPart131595361.pUuz4S08WX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Since https://bugs.debian.org/863290 (2017) the Debian kernel has had a
patch to warn about the use of RAID 5/6 with BTRFS.
That bug mentions "It looks like there's a consensus that such a warning
should live in the kernel rather than userland"

Via [1] and [2] it seems userland did get a warning. It is mentioned in
the kernel documentation (``Documentation/btrfs-man5.rst``) (and [3]
and [4]), but AFAICT users are still not warned by the kernel when
using RAID 5/6.

I stumbled upon this issue when I was (locally) rebasing the Debian kernel
patch for kernel 6.8. I attached my rebased version of the original patch.
(I may have done it completely wrong as I know very little about BTRFS.)

But more importantly, IMO such a warning shouldn't be in a downstream
kernel (Debian), but in the upstream kernel source?

Cheers,
  Diederik

[1] https://lore.kernel.org/linux-btrfs/20161208153004.GA31795@angband.pl/
[2] https://lore.kernel.org/linux-btrfs/bf9594ea55ce40af80548888070427ad97daf78a.1598374255.git.josef@toxicpanda.com/
[3] https://btrfs.readthedocs.io/en/latest/btrfs-man5.html#raid56-status-and-recommended-practices
[4] https://lore.kernel.org/linux-btrfs/dbf47c42-932c-9cf0-0e50-75f1d779d024@cryptearth.de/
--nextPart131595361.pUuz4S08WX
Content-Disposition: attachment;
 filename="btrfs-warn-about-raid5-6-being-experimental-at-mount.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="x-UTF_8J";
 name="btrfs-warn-about-raid5-6-being-experimental-at-mount.patch"

From: Adam Borowski <kilobyte@angband.pl>
Date: Tue, 28 Mar 2017 16:55:05 +0200
Subject: btrfs: warn about RAID5/6 being experimental at mount time
Bug-Debian: https://bugs.debian.org/863290
Origin: https://bugs.debian.org/863290#5

Too many people come complaining about losing their data -- and indeed,
there's no warning outside a wiki and the mailing list tribal knowledge.
Message severity chosen for consistency with XFS -- "alert" makes dmesg
produce nice red background which should get the point across.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
[bwh: Also add_taint() so this is flagged in bug reports]
[2023-01-10: still accurate according to btrfs-progs own manpage:
https://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git/commit/?id=922797e15590b836e377d6dc47b828356cafc2a9]
[2024-03-17: still accurate; manpage is now in Documentation/btrfs-man5.rst
implementation went from disk-io.c to super.c]
---
 fs/btrfs/super.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 101f786963d4..2c409bce1bf5 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -731,6 +731,18 @@ static void set_device_specific_options(struct btrfs_fs_info *fs_info)
 	    !fs_info->fs_devices->rotating)
 		btrfs_set_opt(fs_info->mount_opt, SSD);
 
+	/*
+	 * Warn about RAID5/6 being experimental at mount time
+	 */
+	if ((fs_info->avail_data_alloc_bits |
+	     fs_info->avail_metadata_alloc_bits |
+	     fs_info->avail_system_alloc_bits) &
+	    BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		btrfs_alert(fs_info,
+		"btrfs RAID5/6 is EXPERIMENTAL and has known data-loss bugs");
+		add_taint(TAINT_AUX, LOCKDEP_STILL_OK);
+	}
+
 	/*
 	 * For devices supporting discard turn on discard=async automatically,
 	 * unless it's already set or disabled. This could be turned off by

--nextPart131595361.pUuz4S08WX--

--nextPart7345321.1qzUUeqQFO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZfcqsAAKCRDXblvOeH7b
bkXSAQC5e1VkqkVqrArlMCn14mAB/XeEFtjygQWGJFHAB8JfTAEAs8ZGJ8Z/ACLP
xyja5YrfwpHM6LY9gbae7CiscNUNfwE=
=Mjbm
-----END PGP SIGNATURE-----

--nextPart7345321.1qzUUeqQFO--




