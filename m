Return-Path: <linux-btrfs+bounces-11981-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1262BA4C3E9
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 15:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB4C168D6E
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BD9213E94;
	Mon,  3 Mar 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HU4hzcl7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HU4hzcl7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1436202F9F
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013725; cv=none; b=jyvNzWUXXVw2m32b+ds08i+D6u6fbgWCXHF5Mly+FMA9phAhMUKpiAo5VWWULtzElVlMLsHaS2rC8TRCXFMj8WAXyoJ41jIixWo9cs8p4SobbaTaUMmvHyUIpM8f5cXesL9g+twWoWvsdUO++kd6wd9UTJ12n/l6krNVP8eBhf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013725; c=relaxed/simple;
	bh=QIgYqMdLjXjz5Bb6T1HpZ85NQ/Cn9qWlRU26Dnoo7i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DruMO+sGdnkef7JkQI/rXrxlOjqvRAV3JhQp/JVphkgCD94eUU0nsNS7mdoRXShlPdWQfWuC5zVXWssLHmk6sBHr8rABaEulClvz0sdAe+u3H7O+Gyfl7zJK2HzyS6NiLCj70CoBhyNL1tNnNjkh7r0HUzjUyAyOxLoKztWIOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HU4hzcl7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HU4hzcl7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C11271F383;
	Mon,  3 Mar 2025 14:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741013721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udvvqP2tsVueA8fepo3LzP2QWoKBs4JB8UI1JYD9lhE=;
	b=HU4hzcl70V0vwO6MtNlvVqY2sXdzkz2nIziTfS/w3JNedIwSQkSfO3pc9SV3I4YtfigKG5
	EYfqY1SUVPDgb3d+QyQyttA6oupW283el4/nCyXr6d//kUoOql3o6Lw9RWWXJdnA33jr9K
	x4NTWUCpYvaEEOZpgTJ27O2foi4X2d8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=HU4hzcl7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741013721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udvvqP2tsVueA8fepo3LzP2QWoKBs4JB8UI1JYD9lhE=;
	b=HU4hzcl70V0vwO6MtNlvVqY2sXdzkz2nIziTfS/w3JNedIwSQkSfO3pc9SV3I4YtfigKG5
	EYfqY1SUVPDgb3d+QyQyttA6oupW283el4/nCyXr6d//kUoOql3o6Lw9RWWXJdnA33jr9K
	x4NTWUCpYvaEEOZpgTJ27O2foi4X2d8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA84E13939;
	Mon,  3 Mar 2025 14:55:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9IKILdnCxWczAwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 03 Mar 2025 14:55:21 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/7] btrfs: pass btrfs_root pointers to send ioctl parameters
Date: Mon,  3 Mar 2025 15:55:17 +0100
Message-ID: <579fc676421c0c1995cfa20b6bb95253b9f239e2.1741012265.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1741012265.git.dsterba@suse.com>
References: <cover.1741012265.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C11271F383
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The ioctl switch btrfs_ioctl() provides several parameter types for
convenience so we don't have to do the conversion in the callbacks.
Pass root pointers to the send related functions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 8 ++++----
 fs/btrfs/send.c  | 3 +--
 fs/btrfs/send.h  | 4 ++--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5c26788f7e4f..124f104d31b1 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4385,7 +4385,7 @@ static int btrfs_ioctl_set_features(struct file *file, void __user *arg)
 	return ret;
 }
 
-static int _btrfs_ioctl_send(struct btrfs_inode *inode, void __user *argp, bool compat)
+static int _btrfs_ioctl_send(struct btrfs_root *root, void __user *argp, bool compat)
 {
 	struct btrfs_ioctl_send_args *arg;
 	int ret;
@@ -4416,7 +4416,7 @@ static int _btrfs_ioctl_send(struct btrfs_inode *inode, void __user *argp, bool
 		if (IS_ERR(arg))
 			return PTR_ERR(arg);
 	}
-	ret = btrfs_ioctl_send(inode, arg);
+	ret = btrfs_ioctl_send(root, arg);
 	kfree(arg);
 	return ret;
 }
@@ -5315,10 +5315,10 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_set_received_subvol_32(file, argp);
 #endif
 	case BTRFS_IOC_SEND:
-		return _btrfs_ioctl_send(BTRFS_I(inode), argp, false);
+		return _btrfs_ioctl_send(root, argp, false);
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
 	case BTRFS_IOC_SEND_32:
-		return _btrfs_ioctl_send(BTRFS_I(inode), argp, true);
+		return _btrfs_ioctl_send(root, argp, true);
 #endif
 	case BTRFS_IOC_GET_DEV_STATS:
 		return btrfs_ioctl_get_dev_stats(fs_info, argp);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 878b32331bc2..e225530d3ebb 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -8077,10 +8077,9 @@ static void dedupe_in_progress_warn(const struct btrfs_root *root)
 		      btrfs_root_id(root), root->dedupe_in_progress);
 }
 
-long btrfs_ioctl_send(struct btrfs_inode *inode, const struct btrfs_ioctl_send_args *arg)
+long btrfs_ioctl_send(struct btrfs_root *send_root, const struct btrfs_ioctl_send_args *arg)
 {
 	int ret = 0;
-	struct btrfs_root *send_root = inode->root;
 	struct btrfs_fs_info *fs_info = send_root->fs_info;
 	struct btrfs_root *clone_root;
 	struct send_ctx *sctx = NULL;
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index 9309886c5ea1..652bb28f63d4 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -11,7 +11,7 @@
 #include <linux/sizes.h>
 #include <linux/align.h>
 
-struct btrfs_inode;
+struct btrfs_root;
 struct btrfs_ioctl_send_args;
 
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
@@ -182,6 +182,6 @@ enum {
 	__BTRFS_SEND_A_MAX		= 35,
 };
 
-long btrfs_ioctl_send(struct btrfs_inode *inode, const struct btrfs_ioctl_send_args *arg);
+long btrfs_ioctl_send(struct btrfs_root *send_root, const struct btrfs_ioctl_send_args *arg);
 
 #endif
-- 
2.47.1


