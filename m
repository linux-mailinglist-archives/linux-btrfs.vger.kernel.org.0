Return-Path: <linux-btrfs+bounces-14337-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9700FAC9361
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DAF4E02FE
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0B21D5AB7;
	Fri, 30 May 2025 16:19:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2677B1A2C11
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621946; cv=none; b=h7ZEFXiYTvKyyw79OmDssZZWUyhuuZh4twMDeuYiJ6LJRBjm8WPwXXy2k3vKV6DDwrGF8ognray/dnT5LLndvSeANnstzQFfHwEVpfyCaheQ7pQdleJbKz0Ac45stz6fldm7tZCorCkHrSRokb5if1oqq/6/8H98yNmt08d8Ne0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621946; c=relaxed/simple;
	bh=aCxJnx4aoLuL29S7hG5cGwvOPof6iL0OLu1e4IDRH/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdAnHal31CVDqL7h53yCLsJXnCfjyLhqMpeayxwO5mHLAioqNoj64f8/F+RGXoYg0EfsLRVHan2k/oVW4WoxqIRDt/cCIvbqItredzimqjxETpwtwJFEJQav/FMpqyoOnMESTr29ylHby0VB+RX2DgjFSEchqDcPYB9zBImcW/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C26F021A53;
	Fri, 30 May 2025 16:18:46 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC0E913889;
	Fri, 30 May 2025 16:18:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BAfnLWbaOWj+ZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:18:46 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 17/22] btrfs: rename err to ret in btrfs_fill_super()
Date: Fri, 30 May 2025 18:18:46 +0200
Message-ID: <bccc62700beb56d6cfed28c8ec55464470c991ae.1748621715.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748621715.git.dsterba@suse.com>
References: <cover.1748621715.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C26F021A53
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/super.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a0c65adce1ab..c2b6d9449551 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -945,7 +945,7 @@ static int btrfs_fill_super(struct super_block *sb,
 {
 	struct btrfs_inode *inode;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
-	int err;
+	int ret;
 
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_magic = BTRFS_SUPER_MAGIC;
@@ -959,28 +959,28 @@ static int btrfs_fill_super(struct super_block *sb,
 	sb->s_time_gran = 1;
 	sb->s_iflags |= SB_I_CGROUPWB | SB_I_ALLOW_HSM;
 
-	err = super_setup_bdi(sb);
-	if (err) {
+	ret = super_setup_bdi(sb);
+	if (ret) {
 		btrfs_err(fs_info, "super_setup_bdi failed");
-		return err;
+		return ret;
 	}
 
-	err = open_ctree(sb, fs_devices);
-	if (err) {
-		btrfs_err(fs_info, "open_ctree failed: %d", err);
-		return err;
+	ret = open_ctree(sb, fs_devices);
+	if (ret) {
+		btrfs_err(fs_info, "open_ctree failed: %d", ret);
+		return ret;
 	}
 
 	inode = btrfs_iget(BTRFS_FIRST_FREE_OBJECTID, fs_info->fs_root);
 	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
-		btrfs_handle_fs_error(fs_info, err, NULL);
+		ret = PTR_ERR(inode);
+		btrfs_handle_fs_error(fs_info, ret, NULL);
 		goto fail_close;
 	}
 
 	sb->s_root = d_make_root(&inode->vfs_inode);
 	if (!sb->s_root) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto fail_close;
 	}
 
@@ -989,7 +989,7 @@ static int btrfs_fill_super(struct super_block *sb,
 
 fail_close:
 	close_ctree(fs_info);
-	return err;
+	return ret;
 }
 
 int btrfs_sync_fs(struct super_block *sb, int wait)
-- 
2.47.1


