Return-Path: <linux-btrfs+bounces-5930-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F87691538F
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 18:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C651C231E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 16:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC46A19FA70;
	Mon, 24 Jun 2024 16:23:17 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26C719FA68
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246197; cv=none; b=J1B4nY8IPDi55j19Cx7dWkG8UgztROUzwO2ujln9RvX4pT4S35J8PgU5mqeqRLXu7U56825dGqK1XrHJxnEGTdRLHsbavhEi39GwMb2mlmzZy/QN/pnTeRUooLmDzoTqaZ5TAB6Dm9LK5AncOfuTBCxt3YwhA+Q+oEhzOlJkSx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246197; c=relaxed/simple;
	bh=mQXFP3PC7JSUdDFJZck05INUoN0paAGa526/Cajyl7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ff8TYw+tgsATQMKcc9O0POuTHOICZFCv7NKNASXPD1EgVw64+v0eDvg4Lo6LwmRgwfJdayIvCqoIkj3oQOdQ80UPi7fRcsPHn1FordMziuRY0mDFuIXKVbQYsYs7wFT78UsaNR4T6lCkCISmkn6TJpzT+rcIWDYJr9SqRbcco1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F63E2122D;
	Mon, 24 Jun 2024 16:23:13 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D2DD1384C;
	Mon, 24 Jun 2024 16:23:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eiM1A3GdeWbmLQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 24 Jun 2024 16:23:13 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 05/11] btrfs: pass a btrfs_inode to btrfs_ioctl_send()
Date: Mon, 24 Jun 2024 18:23:12 +0200
Message-ID: <384cbab78b400421de47ead8098333f859e720cd.1719246104.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1719246104.git.dsterba@suse.com>
References: <cover.1719246104.git.dsterba@suse.com>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 1F63E2122D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

Pass a struct btrfs_inode to btrfs_ioctl_send() and _btrfs_ioctl_send()
as it's an internal interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 6 +++---
 fs/btrfs/send.c  | 4 ++--
 fs/btrfs/send.h  | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 1c31df88f19a..d4f0445c4230 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4473,7 +4473,7 @@ static int btrfs_ioctl_set_features(struct file *file, void __user *arg)
 	return ret;
 }
 
-static int _btrfs_ioctl_send(struct inode *inode, void __user *argp, bool compat)
+static int _btrfs_ioctl_send(struct btrfs_inode *inode, void __user *argp, bool compat)
 {
 	struct btrfs_ioctl_send_args *arg;
 	int ret;
@@ -4795,10 +4795,10 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_set_received_subvol_32(file, argp);
 #endif
 	case BTRFS_IOC_SEND:
-		return _btrfs_ioctl_send(inode, argp, false);
+		return _btrfs_ioctl_send(BTRFS_I(inode), argp, false);
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
 	case BTRFS_IOC_SEND_32:
-		return _btrfs_ioctl_send(inode, argp, true);
+		return _btrfs_ioctl_send(BTRFS_I(inode), argp, true);
 #endif
 	case BTRFS_IOC_GET_DEV_STATS:
 		return btrfs_ioctl_get_dev_stats(fs_info, argp);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index bc2acda1d1bb..fb3675f5bf50 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -8065,10 +8065,10 @@ static void dedupe_in_progress_warn(const struct btrfs_root *root)
 		      btrfs_root_id(root), root->dedupe_in_progress);
 }
 
-long btrfs_ioctl_send(struct inode *inode, const struct btrfs_ioctl_send_args *arg)
+long btrfs_ioctl_send(struct btrfs_inode *inode, const struct btrfs_ioctl_send_args *arg)
 {
 	int ret = 0;
-	struct btrfs_root *send_root = BTRFS_I(inode)->root;
+	struct btrfs_root *send_root = inode->root;
 	struct btrfs_fs_info *fs_info = send_root->fs_info;
 	struct btrfs_root *clone_root;
 	struct send_ctx *sctx = NULL;
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index 8bd5aeafb6f5..b07f4aa66878 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -11,7 +11,7 @@
 #include <linux/sizes.h>
 #include <linux/align.h>
 
-struct inode;
+struct btrfs_inode;
 struct btrfs_ioctl_send_args;
 
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
@@ -182,6 +182,6 @@ enum {
 	__BTRFS_SEND_A_MAX		= 35,
 };
 
-long btrfs_ioctl_send(struct inode *inode, const struct btrfs_ioctl_send_args *arg);
+long btrfs_ioctl_send(struct btrfs_inode *inode, const struct btrfs_ioctl_send_args *arg);
 
 #endif
-- 
2.45.0


