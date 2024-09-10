Return-Path: <linux-btrfs+bounces-7901-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEC6972905
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 07:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8981F24EE2
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 05:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9442716DC12;
	Tue, 10 Sep 2024 05:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MjQRKAR3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MjQRKAR3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52617BA42;
	Tue, 10 Sep 2024 05:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947507; cv=none; b=t9Dvx8OIg5lUBYwjLHFltuvMHkUpKNCSvjZhFws7Bqd2dkgds5v5gmx1AqqSEmyscB3VprTQN+b3FHwofvHMezRwubslmQwBD9wpV2fJ0dqgYvCS2FuJSePt1DdB4onaH3bDcrc5IYijlwi3WkMWaBAQr4KqqqBhUYvOKLQ156g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947507; c=relaxed/simple;
	bh=jg4yZ2t7HOOAxBRuP13nbwyGcqwPFl6GsdUWs8lKUlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P1sGyrjF7uef75Qa2JIx91zbx6jX+DGi/hEsesKTa07zMssERa475VGuLccFpYB4QRE4kSwRYwsfDSofOutXo4t9wPdNy4PEqCcbDhsrkBOjmLAyF5L91ZNBSMdndNCIJrJcAX9vxKTJ2NQFXVX2wyqpvJnqFB/gqGc0lDeQzsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MjQRKAR3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MjQRKAR3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1EC161F7FB;
	Tue, 10 Sep 2024 05:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725947498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hO8nqWpasQbNfWu5b5Ch2sNiwtLPhmu1QkKoX4syByw=;
	b=MjQRKAR3Ep2tRw3klBSaqtY57rR16ajf20DDRdb80V5y9JjBbhrv5Cm+AJK6lIjuTwJmB0
	PZJksE9iOmmez86+s2XPVbbS5FhoanF7FBekVTcjdWaSrC3LYF0Qt0oKLPI6xFgkWASp8C
	HyO5tCLSnfSbOvrPO5jTXuSFKk5WpvQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MjQRKAR3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725947498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hO8nqWpasQbNfWu5b5Ch2sNiwtLPhmu1QkKoX4syByw=;
	b=MjQRKAR3Ep2tRw3klBSaqtY57rR16ajf20DDRdb80V5y9JjBbhrv5Cm+AJK6lIjuTwJmB0
	PZJksE9iOmmez86+s2XPVbbS5FhoanF7FBekVTcjdWaSrC3LYF0Qt0oKLPI6xFgkWASp8C
	HyO5tCLSnfSbOvrPO5jTXuSFKk5WpvQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17DF413A3A;
	Tue, 10 Sep 2024 05:51:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yqQqMmje32a2CgAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 10 Sep 2024 05:51:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] btrfs: qgroup: set a more sane default value for subtree drop threshold
Date: Tue, 10 Sep 2024 15:21:04 +0930
Message-ID: <4ae3d5114b0fcffe9f95e614bb4fc8912b5f6573.1725947462.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1EC161F7FB
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Since commit 011b46c30476 ("btrfs: skip subtree scan if it's too high to
avoid low stall in btrfs_commit_transaction()"), btrfs qgroup can
automatically skip large subtree scan at the cost of marking qgroup
inconsistent.

It's designed to address the final performance problem of snapshot drop
with qgroup enabled, but to be safe the default value is
BTRFS_MAX_LEVEL, requiring a user space daemon to set a different value
to make it work.

I'd say it's not a good idea to rely on user space tool to set this
default value, especially when some operations (snapshot dropping) can
be triggered immediately after mount, leaving a very small window to
that that sysfs interface.

So instead of disabling this new feature by default, enable it with a
low threshold (3), so that large subvolume tree drop at mount time won't
cause huge qgroup workload.

Cc: stable@vger.kernel.org # 6.1
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 2 +-
 fs/btrfs/qgroup.c  | 2 +-
 fs/btrfs/qgroup.h  | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 25d768e67e37..a9bd54d1be1e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1959,7 +1959,7 @@ static void btrfs_init_qgroup(struct btrfs_fs_info *fs_info)
 	fs_info->qgroup_seq = 1;
 	fs_info->qgroup_ulist = NULL;
 	fs_info->qgroup_rescan_running = false;
-	fs_info->qgroup_drop_subtree_thres = BTRFS_MAX_LEVEL;
+	fs_info->qgroup_drop_subtree_thres = BTRFS_QGROUP_DROP_SUBTREE_THRES_DEFAULT;
 	mutex_init(&fs_info->qgroup_rescan_lock);
 }
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index c297909f1506..aec096dc8829 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1407,7 +1407,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	fs_info->quota_root = NULL;
 	fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_ON;
 	fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE;
-	fs_info->qgroup_drop_subtree_thres = BTRFS_MAX_LEVEL;
+	fs_info->qgroup_drop_subtree_thres = BTRFS_QGROUP_DROP_SUBTREE_THRES_DEFAULT;
 	spin_unlock(&fs_info->qgroup_lock);
 
 	btrfs_free_qgroup_config(fs_info);
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 98adf4ec7b01..c229256d6fd5 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -121,6 +121,8 @@ struct btrfs_inode;
 #define BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN		(1ULL << 63)
 #define BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING		(1ULL << 62)
 
+#define BTRFS_QGROUP_DROP_SUBTREE_THRES_DEFAULT		(3)
+
 /*
  * Record a dirty extent, and info qgroup to update quota on it
  */
-- 
2.46.0


