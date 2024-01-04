Return-Path: <linux-btrfs+bounces-1249-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E467F82493D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 20:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64E06B2340C
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 19:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC012C69B;
	Thu,  4 Jan 2024 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="ttrQcyTI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF092C1B5
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jan 2024 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28bec6ae0ffso609967a91.3
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Jan 2024 11:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1704397734; x=1705002534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LI3CcEGC+c03glOk3zIu9Fwj+YgfZfBtc/M+MkavCyo=;
        b=ttrQcyTI92As2AAoSMDvjvlTlKTuc8hvztIRuqnPcB0g2APqIdGFDei+RuoS8RtgZ+
         n7DOH3d8nXEOK/vZS0Z38SKXxjxDICMu/8zXJ4eMyElAHH/TZmVNXM8AUNfAskC+36mw
         ksHb9j9fdUCiWwaXJTIMtq7tSR5M5i4ds5yfImxyg3hhBDOjwS1BYN5B3OAFFDFw10g2
         Wu2R6lUL0T9ybVjifYwkW7VQQ97b+9N6YhwbjtIZbMLhbhLaQF+H69+A08h3fZ+bBy2y
         EX+c4vPRfOEyCmHZY7hPTCPeeQfuyT12u6AGTpOrH1s6AN4MDZwZztVPuWMQ0FS5c+o4
         VyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704397734; x=1705002534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LI3CcEGC+c03glOk3zIu9Fwj+YgfZfBtc/M+MkavCyo=;
        b=vHmK+jDMjEs2ljfs+O1BNDDcFqd6/lvqBfxUxhQ9P/PbYTO9XCzimoi08XJ7TPE4NA
         eMndvQEtmvq++cQw+tDtyw/Jna4VgPOqdQ4/Qr8IOSS2E8kVnyo8OBbz0AD49DL3BIZM
         Tj1pwvIIIe2rOicntWFaAyv94bI89BHufcYiu5kXclVh3jFEHPFhIVgLWX1SwHjwD33l
         nl06j2eaHbQlaC3DTz1ec+dzhR4h5BnhBDXyDlbd2D47jB1O+vyTqZ7b3Zzx2g5iRS8a
         +Nj9CrOP3D4l9w1W205vD4RKnGa+Rm1Giky0B/qfIPwBSlj9te/DMr0mnT17WlyGFGGZ
         UD8w==
X-Gm-Message-State: AOJu0YxprgH2wayedJ/eUWPONg+tJmDY6cC07VRAquJQQhaGhOqJjKCL
	eK6HwJcj+Ijkd3wELS6iWYO7vzYBo7Te8mhHN7qmyH0e3JY=
X-Google-Smtp-Source: AGHT+IHZidQhAveur2y7CgNS7XOWgYd+982U17pB2NlJggVzgKYxikGlnaiJvY1/JyNL4VSzWU7ZpQ==
X-Received: by 2002:a17:90a:fe18:b0:28c:9080:bd06 with SMTP id ck24-20020a17090afe1800b0028c9080bd06mr944283pjb.55.1704397734616;
        Thu, 04 Jan 2024 11:48:54 -0800 (PST)
Received: from telecaster.hsd1.wa.comcast.net ([2620:10d:c090:400::4:ff66])
        by smtp.gmail.com with ESMTPSA id gf23-20020a17090ac7d700b0028c89298d36sm98431pjb.27.2024.01.04.11.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:48:54 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2 2/2] btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot of subvolume being deleted
Date: Thu,  4 Jan 2024 11:48:47 -0800
Message-ID: <eb4387abc3e524b054bce9e3ce318f26838b9179.1704397423.git.osandov@fb.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1704397423.git.osandov@fb.com>
References: <cover.1704397423.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

Sweet Tea spotted a race between subvolume deletion and snapshotting
that can result in the root item for the snapshot having the
BTRFS_ROOT_SUBVOL_DEAD flag set. The race is:

Thread 1                                      | Thread 2
----------------------------------------------|----------
btrfs_delete_subvolume                        |
  btrfs_set_root_flags(BTRFS_ROOT_SUBVOL_DEAD)|
                                              |btrfs_mksubvol
                                              |  down_read(subvol_sem)
                                              |  create_snapshot
                                              |    ...
                                              |    create_pending_snapshot
                                              |      copy root item from source
  down_write(subvol_sem)                      |

This flag is only checked in send and swap activate, which this would
cause to fail mysteriously.

create_snapshot() now checks the root refs to reject a deleted
subvolume, so we can fix this by locking subvol_sem earlier so that the
BTRFS_ROOT_SUBVOL_DEAD flag and the root refs are updated atomically.

Reported-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b3e39610cc95..7bcc1c03437a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4458,6 +4458,8 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 	u64 root_flags;
 	int ret;
 
+	down_write(&fs_info->subvol_sem);
+
 	/*
 	 * Don't allow to delete a subvolume with send in progress. This is
 	 * inside the inode lock so the error handling that has to drop the bit
@@ -4469,25 +4471,25 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 		btrfs_warn(fs_info,
 			   "attempt to delete subvolume %llu during send",
 			   dest->root_key.objectid);
-		return -EPERM;
+		ret = -EPERM;
+		goto out_up_write;
 	}
 	if (atomic_read(&dest->nr_swapfiles)) {
 		spin_unlock(&dest->root_item_lock);
 		btrfs_warn(fs_info,
 			   "attempt to delete subvolume %llu with active swapfile",
 			   root->root_key.objectid);
-		return -EPERM;
+		ret = -EPERM;
+		goto out_up_write;
 	}
 	root_flags = btrfs_root_flags(&dest->root_item);
 	btrfs_set_root_flags(&dest->root_item,
 			     root_flags | BTRFS_ROOT_SUBVOL_DEAD);
 	spin_unlock(&dest->root_item_lock);
 
-	down_write(&fs_info->subvol_sem);
-
 	ret = may_destroy_subvol(dest);
 	if (ret)
-		goto out_up_write;
+		goto out_undead;
 
 	btrfs_init_block_rsv(&block_rsv, BTRFS_BLOCK_RSV_TEMP);
 	/*
@@ -4497,7 +4499,7 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 	 */
 	ret = btrfs_subvolume_reserve_metadata(root, &block_rsv, 5, true);
 	if (ret)
-		goto out_up_write;
+		goto out_undead;
 
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
@@ -4563,15 +4565,17 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 	inode->i_flags |= S_DEAD;
 out_release:
 	btrfs_subvolume_release_metadata(root, &block_rsv);
-out_up_write:
-	up_write(&fs_info->subvol_sem);
+out_undead:
 	if (ret) {
 		spin_lock(&dest->root_item_lock);
 		root_flags = btrfs_root_flags(&dest->root_item);
 		btrfs_set_root_flags(&dest->root_item,
 				root_flags & ~BTRFS_ROOT_SUBVOL_DEAD);
 		spin_unlock(&dest->root_item_lock);
-	} else {
+	}
+out_up_write:
+	up_write(&fs_info->subvol_sem);
+	if (!ret) {
 		d_invalidate(dentry);
 		btrfs_prune_dentries(dest);
 		ASSERT(dest->send_in_progress == 0);
-- 
2.43.0


