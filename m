Return-Path: <linux-btrfs+bounces-14892-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8742AE58A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 02:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AEF67A4E8F
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 00:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEC870823;
	Tue, 24 Jun 2025 00:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Nv2+Su5B";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Nv2+Su5B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768F138384
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 00:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750725243; cv=none; b=eSr39TTdFGynmbFR5UdOizi1XRPU88mtqnxUsXC4rpNttE0pr0r5XlYpg9Nj5Qc0ILnVzbwamJRpQEhnGzSOm0cERiwEQ4h7orfbYJU1kHDWnDhSPO/DNoHyL3i+0uS7v66mhSp6ueBtc39+jv1zXnKVCXXbsaB7N1ENr/CBZpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750725243; c=relaxed/simple;
	bh=h9kJCTBaUGlLLolvHWQYN3Ppn3tFQSJW0lK9KKpBBAw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCf51rgxsR4vb2fT/ZdOZ5eixLpyl6RL6brgC6btrDlPW2UFzC6SpGRL1HUxwfpYXcJ6O+AkUEcRcWymCYSGcKGgtTij34zZPnG0Z1iDDzqk7gbtSSHpVDHhwpml0X1ylFZheXDfkYY7J4smD+QNvqRxU/HsGA3oAGN2PThPtx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Nv2+Su5B; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Nv2+Su5B; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 280621F455
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 00:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750725210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0QrLdNo61KqdLAthInq80xSS8kbJIAbvI7tL26RQVto=;
	b=Nv2+Su5BM5LTm21po1c8ax9FDTaoUNP34EVyg0dZkMyy1hyCmsgMdiJagvKVz0aLtOeZBH
	WeBuT0XusUy5OU5y8U53Cjm1QpQNKKPV0E625qrSxvysODzUpCu59xndovVFUgYDy+zdnN
	BMrp1WG45Ti48RItTQdi9qQdCjm6YEM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750725210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0QrLdNo61KqdLAthInq80xSS8kbJIAbvI7tL26RQVto=;
	b=Nv2+Su5BM5LTm21po1c8ax9FDTaoUNP34EVyg0dZkMyy1hyCmsgMdiJagvKVz0aLtOeZBH
	WeBuT0XusUy5OU5y8U53Cjm1QpQNKKPV0E625qrSxvysODzUpCu59xndovVFUgYDy+zdnN
	BMrp1WG45Ti48RItTQdi9qQdCjm6YEM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64C1213485
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 00:33:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AA4VClnyWWiCCAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 00:33:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v5 8/8] btrfs: use fs_holder_ops for all opened devices
Date: Tue, 24 Jun 2025 10:02:45 +0930
Message-ID: <9140693f210d78ef453ad527e38bfb0b0770d6f5.1750724841.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750724841.git.wqu@suse.com>
References: <cover.1750724841.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.938];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.79

Since we have btrfs_fs_info::sb (struct super_block) as our block device
holder, we can safely use fs_holder_ops for all of our block devices.

This enables freezing/thawing the btrfs from the underlying block
devices.

This may enhance hibernation/suspension support since previously
freezing/thawing a block device managed by btrfs won't do anything btrfs
specific, but only syncing the block device.

Thus before this change, freezing the underlying block devices won't
prevent future writes into the btrfs, thus may cause problems for
hibernation/suspension when btrfs is involved.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/dev-replace.c | 2 +-
 fs/btrfs/volumes.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index c23847de4e99..79529c36ca6c 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -250,7 +250,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	}
 
 	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
-					   fs_info->sb, NULL);
+					   fs_info->sb, &fs_holder_ops);
 	if (IS_ERR(bdev_file)) {
 		btrfs_err(fs_info, "target device %s is invalid!", device_path);
 		return PTR_ERR(bdev_file);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8c91511ed433..083b0041cb3c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -474,7 +474,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 	struct block_device *bdev;
 	int ret;
 
-	*bdev_file = bdev_file_open_by_path(device_path, flags, holder, NULL);
+	*bdev_file = bdev_file_open_by_path(device_path, flags, holder, &fs_holder_ops);
 
 	if (IS_ERR(*bdev_file)) {
 		ret = PTR_ERR(*bdev_file);
@@ -2706,7 +2706,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		return -EROFS;
 
 	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
-					   fs_info->sb, NULL);
+					   fs_info->sb, &fs_holder_ops);
 	if (IS_ERR(bdev_file))
 		return PTR_ERR(bdev_file);
 
-- 
2.49.0


