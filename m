Return-Path: <linux-btrfs+bounces-14620-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D20AAD6816
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 08:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98AF1BC0F3A
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 06:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F0F1F3BAE;
	Thu, 12 Jun 2025 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c7um7L3T";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c7um7L3T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802321F1313
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 06:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749710181; cv=none; b=FFPOiUPy/Tn0iOEYrkd8rVxvh1J2r1vn0D802bgLGN5SDEHX5L4j3y4ilsECs255ayv1zCWclNf6uTd6NnmBSXxQkP3K1ysFgt1qwaNHQUim63G2E/rU0zRjKCBB/0LyL0V5V6Fgh/kXdGCQRmplEG6yxoUJ+GcxZJX9nR0tWHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749710181; c=relaxed/simple;
	bh=kSLwrW0lLw73W6jZcXmvVzs6a2H6fCJOPAg6T7N2n08=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L3/m8cxwXWMatpB3xm+2xX2HsVWvls2uyywC/nWLrbglPhOihaHj077BnkJnVPpiHW4gMY7zJXxl+j05mMe/Mq7WRJBIoS6BhMXvJssDpxpFW/1oP18argTBlFdm12q6RI8rriEOPb2dFbdMWuokWbNt7QbXtyf9c+XJAXEwk60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c7um7L3T; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c7um7L3T; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D3AB21266
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 06:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749710175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9Nx+8A9JHD4Iph0nBWKKtphCXOvS1VkCYVAAiDyj1h4=;
	b=c7um7L3TdztfON2h69HZrvMuPVM8paEAVokm2DHLkENpSbYXqF2GxRYMpgiSDpfDw7mcNJ
	VTeg1rO0NDc/N176t2Edzh6KpY1eo7u3yp7e/3C0CSpN+/2j8hP/yyjdjtgc9j4kcFWD4w
	oOHr1724nNtW1exONVKLNXMDPn//kMU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=c7um7L3T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749710175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9Nx+8A9JHD4Iph0nBWKKtphCXOvS1VkCYVAAiDyj1h4=;
	b=c7um7L3TdztfON2h69HZrvMuPVM8paEAVokm2DHLkENpSbYXqF2GxRYMpgiSDpfDw7mcNJ
	VTeg1rO0NDc/N176t2Edzh6KpY1eo7u3yp7e/3C0CSpN+/2j8hP/yyjdjtgc9j4kcFWD4w
	oOHr1724nNtW1exONVKLNXMDPn//kMU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A93FD139E2
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 06:36:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fYi5Gl51SmhlCwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 06:36:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: get rid of the re-entry of btrfs_get_tree()
Date: Thu, 12 Jun 2025 16:05:52 +0930
Message-ID: <c661aec7eb4377d8775b034681ae502760952c97.1749710135.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6D3AB21266
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

[EXISTING PROBLEM]
Currently btrfs mount is split into two parts:

- btrfs_get_tree_subvol()
  Which setups the very basic fs_info, and eventually call
  mount_subvol() to mount the target subvolume.

- btrfs_get_tree_super()
  This is the part doing super block allocation and if there is no
  existing super block, do the real open_ctree() to open the fs.

However currently we're doing this in a complex re-entry fashion:

vfs_get_tree()
|- btrfs_get_tree()
   |- btrfs_get_tree_subvol()
      |- vfs_get_tree()
      |  |- btrfs_get_tree()
      |     |- btrfs_get_tree_super()
      |- mount_subvol()

This is definitely not that easy to grasp.

[ENHANCEMENT]
The function vfs_get_tree() is only doing the following works:

- Call get_tree() call back
- Call super_wake()
- Call security_sb_set_mnt_opts()

In our case, super_wake() can be skipped, as after
btrfs_get_tree_subvol() finished, vfs_get_tree() will call super_wake()
on the super block we got anyway.

The same applies to security_sb_set_mnt_opts(), as long as we do not
free the security from our original fc in btrfs_get_tree_subvol(), the
first vfs_get_tree() call will handle the security correctly.

So here we only need to:

- Replace vfs_get_tree() call with btrfs_get_tree_super()

- Keep the existing fc->security for vfs_get_tree() to handle the
  security

This will remove the re-entry behavior and make thing much easier to
follow.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Unfortunately I'm not yet able to remove the dup_fc, thus dup_fc will be
cleaned up in another patch in the future.
---
 fs/btrfs/super.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b9e08a59da4e..d977d2da985e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2046,15 +2046,7 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
 	 */
 	dup_fc->s_fs_info = fs_info;
 
-	/*
-	 * We'll do the security settings in our btrfs_get_tree_super() mount
-	 * loop, they were duplicated into dup_fc, we can drop the originals
-	 * here.
-	 */
-	security_free_mnt_opts(&fc->security);
-	fc->security = NULL;
-
-	ret = vfs_get_tree(dup_fc);
+	ret = btrfs_get_tree_super(dup_fc);
 	if (ret)
 		goto error;
 
@@ -2086,21 +2078,8 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
 
 static int btrfs_get_tree(struct fs_context *fc)
 {
-	/*
-	 * Since we use mount_subtree to mount the default/specified subvol, we
-	 * have to do mounts in two steps.
-	 *
-	 * First pass through we call btrfs_get_tree_subvol(), this is just a
-	 * wrapper around fc_mount() to call back into here again, and this time
-	 * we'll call btrfs_get_tree_super().  This will do the open_ctree() and
-	 * everything to open the devices and file system.  Then we return back
-	 * with a fully constructed vfsmount in btrfs_get_tree_subvol(), and
-	 * from there we can do our mount_subvol() call, which will lookup
-	 * whichever subvol we're mounting and setup this fc with the
-	 * appropriate dentry for the subvol.
-	 */
-	if (fc->s_fs_info)
-		return btrfs_get_tree_super(fc);
+	ASSERT(fc->s_fs_info == NULL);
+
 	return btrfs_get_tree_subvol(fc);
 }
 
-- 
2.49.0


