Return-Path: <linux-btrfs+bounces-11520-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DC6A38F0D
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 23:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5E0168E53
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 22:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA96E1A9B4C;
	Mon, 17 Feb 2025 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="T6rvjhCH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n9u+Qwet"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25B619E999
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739831147; cv=none; b=L2RnJxK0ntSdncsVEXT9UheB3xN4Rfm01wDb1zNNQmnCeIyx0j9XBuqN5z1lduRUHZ5UdjV3ZC6zW8EpH/Pxpw0sMynTBA5hJvsRAkrVSN/s9hpEY3fKfwDPVPVepQAOyuZlujyHGqN7LpshmfRNdywz/rKl3ESPcuTplFiaS2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739831147; c=relaxed/simple;
	bh=J8Si7hCopcRQG9Pah1vqGlB8MjJe8GDErckcKHg5mGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g9E0vcXLwYWBNU0IB/a9S/db6fn8cg8znfLNMPVjQbBmoPwE0zNe6dQeFVic//adn/IKxj/Gw+UfWsllrNHlAlKPQ8PtyNws3ZtrBaZzuZRmPc6TJ15eoFOje3O/KZdm490Dpnrutk3MD4tfrEu5jgqbomSES9/xRVLHn4f+TXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=T6rvjhCH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n9u+Qwet; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0F4821172;
	Mon, 17 Feb 2025 22:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739831136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wRqmFfBS5c/P/rRHKCAnpwelCAmo29mZxtSIrZe1mgE=;
	b=T6rvjhCHMXV8Uy2AmVxBoOg4VW8ZspfHVViiu5lXZWAWjcZ/cmNJbTCKaRI2zKRccTxfxl
	YI/pLRzntjfkmcm4r5hnUZJR4pplwqXXXo9m8KZpHpwG3/DgSGDIK2eV6n2q5aM3EplXR9
	dFLRjKexFvV4Su/Imywm/EbctonCgdw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739831135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wRqmFfBS5c/P/rRHKCAnpwelCAmo29mZxtSIrZe1mgE=;
	b=n9u+QwetBdTFtQl2bRQ55sDnbJrh8p1fkSJdTNHVkzjbdkjTLQ2T2QwgiqUcMZBByvHb+3
	hlkCI0tK1kXRhBNvO0FZaA406cyHrySY5StGEuVWHhkN9UCXkeSeFQfCJGTunm4tIwsfz5
	AvLPg0pnMO3HV6NDmQRFZGQonqff/bs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD2BD133F9;
	Mon, 17 Feb 2025 22:25:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X3JKH163s2d3LwAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 17 Feb 2025 22:25:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2] btrfs: output an error message if btrfs failed to find the seed fsid
Date: Tue, 18 Feb 2025 08:55:09 +1030
Message-ID: <82088d8a206ac6187b994a4f9f21876773cf036b.1739831055.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,oracle.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
If btrfs failed to locate the seed device for whatever reason, mounting
the sprouted device will fail without any meaningful error message:

 # mkfs.btrfs -f /dev/test/scratch1
 # btrfstune -S1 /dev/test/scratch1
 # mount /dev/test/scratch1 /mnt/btrfs
 # btrfs dev add -f /dev/test/scratch2 /mnt/btrfs
 # umount /mnt/btrfs
 # btrfs dev scan -u
 # btrfs mount /dev/test/scratch2 /mnt/btrfs
 mount: /mnt/btrfs: fsconfig system call failed: No such file or directory.
       dmesg(1) may have more information after failed mount system call.
 # dmesg -t | tail -n6
 BTRFS info (device dm-5): first mount of filesystem 64252ded-5953-4868-b962-cea48f7ac4ea
 BTRFS info (device dm-5): using crc32c (crc32c-generic) checksum algorithm
 BTRFS info (device dm-5): using free-space-tree
 BTRFS error (device dm-5): failed to read chunk tree: -2
 BTRFS error (device dm-5): open_ctree failed: -2

[CAUSE]
The failure to mount is pretty straight forward, just unable to find the
seed device and its fsid, caused by `btrfs dev scan -u`.

But the lack of any useful info is a problem.

[FIX]
Just add an extra error message in open_seed_devices() to indicate the
error.

Now the error message would look like this:

 BTRFS info (device dm-4): first mount of filesystem 7769223d-4db1-4e4c-ac29-0a96f53576ab
 BTRFS info (device dm-4): using crc32c (crc32c-generic) checksum algorithm
 BTRFS info (device dm-4): using free-space-tree
 BTRFS error (device dm-4): failed to find fsid e87c12e6-584b-4e98-8b88-962c33a619ff when attempting to open seed devices
 BTRFS error (device dm-4): failed to read chunk tree: -2
 BTRFS error (device dm-4): open_ctree failed: -2

Link: https://github.com/kdave/btrfs-progs/issues/959
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Enhance the error message to show a little more details
- Remove the dmesg timestamp from commit message
---
 fs/btrfs/volumes.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0a0776489055..fb22d4425cb0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7200,8 +7200,12 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 
 	fs_devices = find_fsid(fsid, NULL);
 	if (!fs_devices) {
-		if (!btrfs_test_opt(fs_info, DEGRADED))
+		if (!btrfs_test_opt(fs_info, DEGRADED)) {
+			btrfs_err(fs_info,
+		"failed to find fsid %pU when attempting to open seed devices",
+				  fsid);
 			return ERR_PTR(-ENOENT);
+		}
 
 		fs_devices = alloc_fs_devices(fsid);
 		if (IS_ERR(fs_devices))
-- 
2.48.1


