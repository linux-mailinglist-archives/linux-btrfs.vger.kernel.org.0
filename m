Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDEB3D8197
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 23:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhG0VTg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 17:19:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45994 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbhG0VSG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 17:18:06 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D460220180;
        Tue, 27 Jul 2021 21:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627420684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5epPq6eJwcbufhqZJnqCSU1yA+81tlBeGHqrpDVK3xw=;
        b=kygNGorH6hORbc/C0iKLOM1PGKdjn5EoAGG0N/0GHO9pFj9nSwJCAAIIdD9teuUnWp1jmZ
        CLg15UM8TUuWfTrZy/LFDWlrtIEdEQlywZUQGurvsnTYvnm0hTeIpn1yggg3Dp/3ceDDjm
        4alFmz4jivnPO+32MwUFfI6y1mIPmhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627420684;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5epPq6eJwcbufhqZJnqCSU1yA+81tlBeGHqrpDVK3xw=;
        b=noat/vXRTOh6+3y+IjTTYCVuPo/pW35xs+7yrxCmx4PXgwIEXRpF8Tj8RsVs/1EStqC0C1
        yw6dI4TJk8q8QBAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4E55F133DE;
        Tue, 27 Jul 2021 21:18:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 2eTQCQx4AGGQdQAAGKfGzw
        (envelope-from <rgoldwyn@suse.de>); Tue, 27 Jul 2021 21:18:04 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 6/7] btrfs: Allocate btrfs_ioctl_defrag_range_args on stack
Date:   Tue, 27 Jul 2021 16:17:30 -0500
Message-Id: <4b5d49128b43de57f5abfa9c922eb6cef3be9cba.1627418762.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627418762.git.rgoldwyn@suse.com>
References: <cover.1627418762.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Instead of using kmalloc() to allocate btrfs_ioctl_defrag_range_args,
allocate btrfs_ioctl_defrag_range_args on stack.

sizeof(btrfs_ioctl_defrag_range_args) = 48

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ioctl.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 291c16d8576b..bc38a1af45c7 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3096,7 +3096,7 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 {
 	struct inode *inode = file_inode(file);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_ioctl_defrag_range_args *range;
+	struct btrfs_ioctl_defrag_range_args range = {0};
 	int ret;
 
 	ret = mnt_want_write_file(file);
@@ -3128,33 +3128,25 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 			goto out;
 		}
 
-		range = kzalloc(sizeof(*range), GFP_KERNEL);
-		if (!range) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
 		if (argp) {
-			if (copy_from_user(range, argp,
-					   sizeof(*range))) {
+			if (copy_from_user(&range, argp,
+					   sizeof(range))) {
 				ret = -EFAULT;
-				kfree(range);
 				goto out;
 			}
 			/* compression requires us to start the IO */
-			if ((range->flags & BTRFS_DEFRAG_RANGE_COMPRESS)) {
-				range->flags |= BTRFS_DEFRAG_RANGE_START_IO;
-				range->extent_thresh = (u32)-1;
+			if ((range.flags & BTRFS_DEFRAG_RANGE_COMPRESS)) {
+				range.flags |= BTRFS_DEFRAG_RANGE_START_IO;
+				range.extent_thresh = (u32)-1;
 			}
 		} else {
 			/* the rest are all set to zero by kzalloc */
-			range->len = (u64)-1;
+			range.len = (u64)-1;
 		}
 		ret = btrfs_defrag_file(file_inode(file), file,
-					range, BTRFS_OLDEST_GENERATION, 0);
+					&range, BTRFS_OLDEST_GENERATION, 0);
 		if (ret > 0)
 			ret = 0;
-		kfree(range);
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.32.0

