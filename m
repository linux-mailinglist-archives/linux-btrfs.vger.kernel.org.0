Return-Path: <linux-btrfs+bounces-15076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 334A8AED3D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 07:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64FEA7A8B15
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 05:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF821B87F0;
	Mon, 30 Jun 2025 05:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gky442Mr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gky442Mr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA901A257D
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751261391; cv=none; b=saSNjSA/K1cPzty6ZnpE4mgf6laYth9cLu86ETfVDTV2eGbqX7tSW/aUT7VDflhEnoq+x5vC+/PrEe7tm/HOV4cnafA9vMpqkcXCvuwEly80JFgU4lmVm42L6vIj+n6TQQS7LL7XoNCAr4vMFZI2/ICF+mC4UmEjuGV5+WreBkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751261391; c=relaxed/simple;
	bh=Y43XTb5YxgAVMg0RbXN0oitKY914fyb2RNRWxuU9ItI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdxWwEgfDztFvEwUaubL6iLS+02tuKGqFEwd5VeOOwP4zAmhy50yAVQVG+xino+Ftt+xvCslOskvuXkXhsfTJhZJLawNMKrGSs4qrCSHF05CVMbR8KZzyia/De7O3Cy6IyNUDJF1vA4OwouqUekg4Pt2lv9kCFm0bwa108ywCZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gky442Mr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gky442Mr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C3DF21162
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751261375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJ3202Oa/y4QFDQa7b/mHHljPrQhkEkHP66rXetMa+A=;
	b=Gky442MreZdIku303MhRl6vkji/+Gn0bijImn8Mr/yORGzLihIRDYlncGLK+aooR+aP72U
	v29xJmbfVbsP2zYJKsIQlYyn6pekfLWSczNmalZxk5B+2ys4JaZtxA4gwbRCGb/pChV4wm
	4Ifl7bk13N7UqY9yrqYu85D8mxapkoE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751261375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJ3202Oa/y4QFDQa7b/mHHljPrQhkEkHP66rXetMa+A=;
	b=Gky442MreZdIku303MhRl6vkji/+Gn0bijImn8Mr/yORGzLihIRDYlncGLK+aooR+aP72U
	v29xJmbfVbsP2zYJKsIQlYyn6pekfLWSczNmalZxk5B+2ys4JaZtxA4gwbRCGb/pChV4wm
	4Ifl7bk13N7UqY9yrqYu85D8mxapkoE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EA88139D4
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MPtCFL4gYmi4SAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v6 2/8] btrfs: get rid of the re-entry of btrfs_get_tree()
Date: Mon, 30 Jun 2025 14:59:06 +0930
Message-ID: <e250300dc9024bb231b2bd5814b9a9c9143fdcd5.1751261286.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751261286.git.wqu@suse.com>
References: <cover.1751261286.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.967];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

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
2.50.0


