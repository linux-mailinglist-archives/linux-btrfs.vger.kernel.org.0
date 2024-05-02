Return-Path: <linux-btrfs+bounces-4680-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4048BA226
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 23:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5441C20EDF
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 21:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9576181D08;
	Thu,  2 May 2024 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="myov2r9M";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="myov2r9M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A77181BAF
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684733; cv=none; b=AhG7s/QVrgKJwyNpUebGXgcBkHHB1UB4mq+xgytoFYqezSC3MuFTCjVEwXxhQ0pXk5gu2WeL9o3vlNJDWLuKUrza45G7uqPGotiBdl2pvrBXPlznWMnZaeZyfBsZybfoE3CvzRdwCo1imG4xYqZ2sWPkccqMX0aeAtJ4PMLxl30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684733; c=relaxed/simple;
	bh=3y1A2+ZShAiAiEQ6p0EdJmZTeYAh1CFNzHtEfJTFXRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZpLE2juUbAVczpoNWPkhZsuXQIkfFc+wWWLJ2bSpHRVExVTU9Awku5Jx9REb6FUYmUcs3sCT/oFSXRp5UYXuFG+nvEXIQGIXQc9zOI7FQNCWXXbv2gxLSaRYXJSAkt/4sC50y4p/wJXgVVK1XRRtpJfEkXQAjgVLwCEkDGRHWS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=myov2r9M; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=myov2r9M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E96621A79;
	Thu,  2 May 2024 21:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714684729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QyBXqFLO11vQKi4BOUomJACnTvYjH1siG7/satE/IzU=;
	b=myov2r9Md92+hFsXOq8nAGpxitMV6fELLki8/eVzAs0q2GwF2NP1VhpKkVIFA0S8akVV0N
	iwiebQDL2GPDBh5v1iKiaqbNNPOHoONHJk41RHXaYVvl78DQlCuV02nI4OhNxk9MDuZJ7s
	sVFJXf4syqrD+ZaFVZdptb2yxoFidWc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714684729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QyBXqFLO11vQKi4BOUomJACnTvYjH1siG7/satE/IzU=;
	b=myov2r9Md92+hFsXOq8nAGpxitMV6fELLki8/eVzAs0q2GwF2NP1VhpKkVIFA0S8akVV0N
	iwiebQDL2GPDBh5v1iKiaqbNNPOHoONHJk41RHXaYVvl78DQlCuV02nI4OhNxk9MDuZJ7s
	sVFJXf4syqrD+ZaFVZdptb2yxoFidWc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A6711386E;
	Thu,  2 May 2024 21:18:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OF/MFTkDNGbPYAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 02 May 2024 21:18:49 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: qgroup: do quick checks if quotas are enabled before starting ioctls
Date: Thu,  2 May 2024 23:11:33 +0200
Message-ID: <20240502211133.20102-1-dsterba@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The ioctls that add relations, create qgroups or set limits start/join
transaction. When quotas are not enabled this is not necessary, there
will be errors reported back anyway but this could be also misleading
and we should really report that quotas are not enabled. For that use
-ENOTCONN.

The helper is meant to do a quick check before any other standard ioctl
checks are done. If quota is disabled meanwhile we still rely on proper
locking inside any active operation changing the qgroup structures.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index efd5d6e9589e..28df28e50ad9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3807,6 +3807,22 @@ static long btrfs_ioctl_quota_ctl(struct file *file, void __user *arg)
 	return ret;
 }
 
+/*
+ * Quick check for ioctl handlers if quotas are enabled. Proper locking must be
+ * done before any operations.
+ */
+static bool qgroup_enabled(struct btrfs_fs_info *fs_info)
+{
+	bool ret = true;
+
+	mutex_lock(&fs_info->qgroup_ioctl_lock);
+	if (!fs_info->quota_root)
+		ret = false;
+	mutex_unlock(&fs_info->qgroup_ioctl_lock);
+
+	return ret;
+}
+
 static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
@@ -3820,6 +3836,9 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (!qgroup_enabled(root->fs_info))
+		return -ENOTCONN;
+
 	ret = mnt_want_write_file(file);
 	if (ret)
 		return ret;
@@ -3872,6 +3891,9 @@ static long btrfs_ioctl_qgroup_create(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (!qgroup_enabled(root->fs_info))
+		return -ENOTCONN;
+
 	ret = mnt_want_write_file(file);
 	if (ret)
 		return ret;
@@ -3928,6 +3950,9 @@ static long btrfs_ioctl_qgroup_limit(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (!qgroup_enabled(root->fs_info))
+		return -ENOTCONN;
+
 	ret = mnt_want_write_file(file);
 	if (ret)
 		return ret;
@@ -3973,6 +3998,9 @@ static long btrfs_ioctl_quota_rescan(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (!qgroup_enabled(fs_info))
+		return -ENOTCONN;
+
 	ret = mnt_want_write_file(file);
 	if (ret)
 		return ret;
-- 
2.44.0


