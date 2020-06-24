Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1737B20784D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404833AbgFXQDy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:03:54 -0400
Received: from mail.nic.cz ([217.31.204.67]:48130 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404752AbgFXQD1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:03:27 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 2F4121409E5;
        Wed, 24 Jun 2020 18:03:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1593014605; bh=AapOGgBQ7fnDzrATd4tl0bUbbbk7nghQbf4nY6twS4Y=;
        h=From:To:Date;
        b=cV8QrnD2jrbyFeu2gmcDS0b+mTgEmyI3HcJI5Z5LSMR+JqbmnUAOiKn7RKbiQrXO8
         jZenzhFoTlNDQAwaxPaeAI7aO+oS0wymqSt+5JPOWxFISrzNPpK7JP0NwMUx+CY390
         WwDTH4Vkp7UWc6fB77A+8WQ+8x024ieOcmWX5IMY=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     =?UTF-8?q?Alberto=20S=C3=A1nchez=20Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v3 22/30] fs: btrfs: Rename btrfs_file_read() and its callees to avoid name conflicts
Date:   Wed, 24 Jun 2020 18:03:08 +0200
Message-Id: <20200624160316.5001-23-marek.behun@nic.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624160316.5001-1-marek.behun@nic.cz>
References: <20200624160316.5001-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Spam-Status: No, score=0.00
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

Rename btrfs_file_read() and its callees to avoid name conflicts with
the incoming new code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 fs/btrfs/btrfs.c     | 2 +-
 fs/btrfs/btrfs.h     | 6 +++---
 fs/btrfs/extent-io.c | 4 ++--
 fs/btrfs/inode.c     | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index aec91a57ec..7eb01c4ff9 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -277,7 +277,7 @@ int btrfs_read(const char *file, void *buf, loff_t offset, loff_t len,
 	if (len > inode.size - offset)
 		len = inode.size - offset;
 
-	rd = btrfs_file_read(&root, inr, offset, len, buf);
+	rd = __btrfs_file_read(&root, inr, offset, len, buf);
 	if (rd == -1ULL) {
 		printf("An error occured while reading file %s\n", file);
 		return -1;
diff --git a/fs/btrfs/btrfs.h b/fs/btrfs/btrfs.h
index e36bd89827..32ea2fc53a 100644
--- a/fs/btrfs/btrfs.h
+++ b/fs/btrfs/btrfs.h
@@ -58,16 +58,16 @@ int __btrfs_readlink(const struct __btrfs_root *, u64, char *);
 int btrfs_readlink(struct btrfs_root *root, u64 ino, char *target);
 u64 __btrfs_lookup_path(struct __btrfs_root *, u64, const char *, u8 *,
 		       struct btrfs_inode_item *, int);
-u64 btrfs_file_read(const struct __btrfs_root *, u64, u64, u64, char *);
+u64 __btrfs_file_read(const struct __btrfs_root *, u64, u64, u64, char *);
 
 /* subvolume.c */
 u64 btrfs_get_default_subvol_objectid(void);
 
 /* extent-io.c */
-u64 btrfs_read_extent_inline(struct __btrfs_path *,
+u64 __btrfs_read_extent_inline(struct __btrfs_path *,
 			      struct btrfs_file_extent_item *, u64, u64,
 			      char *);
-u64 btrfs_read_extent_reg(struct __btrfs_path *, struct btrfs_file_extent_item *,
+u64 __btrfs_read_extent_reg(struct __btrfs_path *, struct btrfs_file_extent_item *,
 			   u64, u64, char *);
 
 #endif /* !__BTRFS_BTRFS_H__ */
diff --git a/fs/btrfs/extent-io.c b/fs/btrfs/extent-io.c
index a524145a66..ccf4da3177 100644
--- a/fs/btrfs/extent-io.c
+++ b/fs/btrfs/extent-io.c
@@ -14,7 +14,7 @@
 #include "extent-io.h"
 #include "disk-io.h"
 
-u64 btrfs_read_extent_inline(struct __btrfs_path *path,
+u64 __btrfs_read_extent_inline(struct __btrfs_path *path,
 			     struct btrfs_file_extent_item *extent, u64 offset,
 			     u64 size, char *out)
 {
@@ -66,7 +66,7 @@ err:
 	return -1ULL;
 }
 
-u64 btrfs_read_extent_reg(struct __btrfs_path *path,
+u64 __btrfs_read_extent_reg(struct __btrfs_path *path,
 			  struct btrfs_file_extent_item *extent, u64 offset,
 			  u64 size, char *out)
 {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2e3fcad5a8..83d21467d9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -598,7 +598,7 @@ u64 __btrfs_lookup_path(struct __btrfs_root *root, u64 inr, const char *path,
 	return inr;
 }
 
-u64 btrfs_file_read(const struct __btrfs_root *root, u64 inr, u64 offset,
+u64 __btrfs_file_read(const struct __btrfs_root *root, u64 inr, u64 offset,
 		    u64 size, char *buf)
 {
 	struct __btrfs_path path;
@@ -633,11 +633,11 @@ u64 btrfs_file_read(const struct __btrfs_root *root, u64 inr, u64 offset,
 
 		if (extent->type == BTRFS_FILE_EXTENT_INLINE) {
 			btrfs_file_extent_item_to_cpu_inl(extent);
-			rd = btrfs_read_extent_inline(&path, extent, offset,
+			rd = __btrfs_read_extent_inline(&path, extent, offset,
 						      size, buf);
 		} else {
 			btrfs_file_extent_item_to_cpu(extent);
-			rd = btrfs_read_extent_reg(&path, extent, offset, size,
+			rd = __btrfs_read_extent_reg(&path, extent, offset, size,
 						   buf);
 		}
 
-- 
2.26.2

