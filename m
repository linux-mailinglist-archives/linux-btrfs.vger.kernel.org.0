Return-Path: <linux-btrfs+bounces-14406-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A6AACC2DB
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 11:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788DF3A4EF6
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 09:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0773283C9D;
	Tue,  3 Jun 2025 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="O3evAETB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="O3evAETB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13173283144
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942458; cv=none; b=FA/Xnjvsqj6fMWQ7SA94doNTq08CsBTUMWzzfA+CkoVeGM/yX8iy9pil/jGKurERSrRdc67YTlOt8NxPo5WWPBu6fPGibQ1vlkFxVAS/XjD7T+fmgdCJgvNvzOerziFtfatekQNYXynrUfidUBnK8Ui5yyiaMtcPZsyJGGxDSVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942458; c=relaxed/simple;
	bh=OjuFCe6wZIzFUG1UWJVq7AjjUnu6HaxRyuDEYHGTGUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J7VyTbrSWfTsVUvcWRbiCgUY3DfVNkhuc2BoUTzjRqFqIaiYt2SaanAcndAzhdfwF3H3KhH3QsOTFTxWfArDj2T5vBAHDoVwXw1pfCzxS5Ao9MNmp9FA/2uJxsLmTf4CTB8dWD7mZvfNR98dnNiO8VR7ZD+3wY2HZNx962Ececw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=O3evAETB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=O3evAETB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 291CC21240;
	Tue,  3 Jun 2025 09:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748942454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R7CcCKLGkfNjSkRgAxyQAL8DfqorlQUlB0CdvMobxkw=;
	b=O3evAETBqKRumYjSV4bogQPDVy4Hy1G7Pz1sORndnVxFrEzeXwCfI8hH+tFmIjd2MgDpRc
	2qbjIzpc5eIcBwfKoNF0x4B/bge9txyl+YtbQ8UDV3rfxa88AL+tsnM1UGGmfLOxgRj+Qc
	PGFIr9mLWLhQGuDxbqJPVEsLq0ZXX8c=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748942454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R7CcCKLGkfNjSkRgAxyQAL8DfqorlQUlB0CdvMobxkw=;
	b=O3evAETBqKRumYjSV4bogQPDVy4Hy1G7Pz1sORndnVxFrEzeXwCfI8hH+tFmIjd2MgDpRc
	2qbjIzpc5eIcBwfKoNF0x4B/bge9txyl+YtbQ8UDV3rfxa88AL+tsnM1UGGmfLOxgRj+Qc
	PGFIr9mLWLhQGuDxbqJPVEsLq0ZXX8c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2ED1413A92;
	Tue,  3 Jun 2025 09:20:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /w/YOHS+PmjlOQAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 03 Jun 2025 09:20:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v4] btrfs: open code fc_mount() to avoid releasing s_umount rw_sempahore
Date: Tue,  3 Jun 2025 18:50:50 +0930
Message-ID: <8b8e8fc9f3d18f29e1e87faa7fe0706a76ff8c4f.1748942375.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
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
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

From: Al Viro <viro@zeniv.linux.org.uk>

[CURRENT BEHAVIOR]
Currently inside btrfs_get_tree_subvol(), we call fc_mount() to grab a
tree, then re-lock s_umount inside btrfs_reconfigure_for_mount() to
avoid race with remount.

However fc_mount() itself is just doing two things:

1. Call vfs_get_tree()
2. Release s_umount then call vfs_create_mount()

[ENHANCEMENT]
Instead of calling fc_mount(), we can open-code it with vfs_get_tree()
first.
This provides a benefit that, since we have the full control of
s_umount, we do not need to re-lock that rw_sempahore when calling
btrfs_reconfigure_for_mount(), meaning less race between RO/RW remount.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Qu Wenruo <wqu@suse.com>
[ Rework the subject and commit message, refactor the error handling ]
Signed-off-by: Qu Wenruo <wqu@suse.com>
Tested-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 73c6c5b9b07a..283be8fec20b 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1996,17 +1996,13 @@ static int btrfs_get_tree_super(struct fs_context *fc)
  * btrfs or not, setting the whole super block RO.  To make per-subvolume mounting
  * work with different options work we need to keep backward compatibility.
  */
-static int btrfs_reconfigure_for_mount(struct fs_context *fc, struct vfsmount *mnt)
+static int btrfs_reconfigure_for_mount(struct fs_context *fc)
 {
 	int ret = 0;
 
-	if (fc->sb_flags & SB_RDONLY)
-		return ret;
-
-	down_write(&mnt->mnt_sb->s_umount);
-	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
+	if (!(fc->sb_flags & SB_RDONLY) && (fc->root->d_sb->s_flags & SB_RDONLY))
 		ret = btrfs_reconfigure(fc);
-	up_write(&mnt->mnt_sb->s_umount);
+
 	return ret;
 }
 
@@ -2059,17 +2055,18 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
 	security_free_mnt_opts(&fc->security);
 	fc->security = NULL;
 
-	mnt = fc_mount(dup_fc);
-	if (IS_ERR(mnt)) {
-		put_fs_context(dup_fc);
-		return PTR_ERR(mnt);
-	}
-	ret = btrfs_reconfigure_for_mount(dup_fc, mnt);
+	ret = vfs_get_tree(dup_fc);
+	if (ret)
+		goto error;
+
+	ret = btrfs_reconfigure_for_mount(dup_fc);
+	up_write(&dup_fc->root->d_sb->s_umount);
+	if (ret)
+		goto error;
+	mnt = vfs_create_mount(dup_fc);
 	put_fs_context(dup_fc);
-	if (ret) {
-		mntput(mnt);
-		return ret;
-	}
+	if (IS_ERR(mnt))
+		return PTR_ERR(mnt);
 
 	/*
 	 * This free's ->subvol_name, because if it isn't set we have to
@@ -2083,6 +2080,9 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
 
 	fc->root = dentry;
 	return 0;
+error:
+	put_fs_context(dup_fc);
+	return ret;
 }
 
 static int btrfs_get_tree(struct fs_context *fc)
-- 
2.49.0


