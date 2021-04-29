Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F09036E79D
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 11:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhD2JHz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 05:07:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:41374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240062AbhD2JHy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 05:07:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619687227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQ2ngzZaVaRwNLM06AwozGCjJj+HKkzIZX1xPnT9UBg=;
        b=MfMnqYcc5sEhpNIBmcDTicJgbi3mr7Xds+7waZTeWwxRIbGywh04eV47+oKnc9fffS7Ofx
        TGULoWz9D5Y8MAD8WBBA88zBEO+JeedKDZMawAAo9tGh1EoJcXGn/ihYNUMXMIA9QhAklv
        AFlFQbscUIkW6r6bM5YOso8ru8GTjn4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 736FEAE58;
        Thu, 29 Apr 2021 09:07:07 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>, Su Yue <l@damenly.su>
Subject: [PATCH v2 2/3] btrfs-progs: image: enlarge the output file if no tree modification is needed for restore
Date:   Thu, 29 Apr 2021 17:06:57 +0800
Message-Id: <20210429090658.245238-3-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210429090658.245238-1-wqu@suse.com>
References: <20210429090658.245238-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
If restoring dumpped image into a new file, under most cases kernel will
reject it:

 # mkfs.btrfs -f /dev/test/test
 # btrfs-image /dev/test/test /tmp/dump
 # btrfs-image -r /tmp/dump ~/test.img
 # mount ~/test.img /mnt/btrfs
 mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
 # dmesg -t | tail -n 7
 loop0: detected capacity change from 10592 to 0
 BTRFS info (device loop0): disk space caching is enabled
 BTRFS info (device loop0): has skinny extents
 BTRFS info (device loop0): flagging fs with big metadata feature
 BTRFS error (device loop0): device total_bytes should be at most 5423104 but found 10737418240
 BTRFS error (device loop0): failed to read chunk tree: -22
 BTRFS error (device loop0): open_ctree failed

[CAUSE]
When btrfs-image restores an image into a file, and the source image
contains only single device, then we don't need to modify the
chunk/device tree, as we can reuse the existing chunk/dev tree without
any problem.

This also means, for such restore, we also won't do any target file
enlarge. This behavior itself is fine, as at that time, kernel won't
check if the device is smaller than the device size recorded in device
tree.

But later kernel commit 3a160a933111 ("btrfs: drop never met disk total
bytes check in verify_one_dev_extent") introduces new check on device
size at mount time, rejecting any loop file which is smaller than the
original device size.

[FIX]
Do extra file enlarge for single device restore if the restored file is
smaller than the device size.

Reported-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Su Yue <l@damenly.su>
---
 image/main.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/image/main.c b/image/main.c
index 24393188e5e3..188f387b3354 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2706,6 +2706,49 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 		close_ctree(info->chunk_root);
 		if (ret)
 			goto out;
+	} else {
+		struct btrfs_root *root;
+		struct stat st;
+		u64 dev_size;
+
+		if (!info) {
+			root = open_ctree_fd(fileno(out), target, 0, 0);
+			if (!root) {
+				error("open ctree failed in %s", target);
+				ret = -EIO;
+				goto out;
+			}
+
+			info = root->fs_info;
+
+			dev_size = btrfs_stack_device_total_bytes(
+					&info->super_copy->dev_item);
+			close_ctree(root);
+			info = NULL;
+		} else {
+			dev_size = btrfs_stack_device_total_bytes(
+					&info->super_copy->dev_item);
+		}
+
+		/*
+		 * We don't need extra tree modification, but if the output is
+		 * a file, we need to enlarge the output file so that
+		 * newer kernel won't report error.
+		 */
+		ret = fstat(fileno(out), &st);
+		if (ret < 0) {
+			error("failed to stat result image: %m");
+			ret = -errno;
+			goto out;
+		}
+		if (S_ISREG(st.st_mode) && st.st_size < dev_size) {
+			ret = ftruncate64(fileno(out), dev_size);
+			if (ret < 0) {
+				error("failed to enlarge result image: %m");
+				ret = -errno;
+				goto out;
+			}
+		}
 	}
 out:
 	mdrestore_destroy(&mdrestore, num_threads);
-- 
2.31.1

