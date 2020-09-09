Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0440D2638A6
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 23:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIIVqu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 17:46:50 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48285 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbgIIVqs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 17:46:48 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5D2635C00C8;
        Wed,  9 Sep 2020 17:46:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 09 Sep 2020 17:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=P00fKPI9np4IK
        UXOyCpW3TjIYp/b8PG3mDDGIiKT+YE=; b=Ei+wblFpBgxgG74PosV29TdT5lbQJ
        ya53a/VT7Ze+tfzUZ8AbEU/owrfDv9CK5wC9zBqX7O/GH7Uh9dgraukvkjsSwdIl
        vAdpgKdzvpPirir+2ODBGp8vGe9Jlp2s4K57IgkJbtkK6GeXMwLzyShmkpQ3slRO
        Sw6OesXtIRsDaXSpV2U8vKSjkXFU8eAkq4TaLdnQSXvroW5vNZC2tq9J6y+S6Gpn
        fhS+cFYDSzlBQzgO4rwi2okPFG+4VtVv09dTOXyHZ6kElycjT7tPCC5sV4trrvc1
        uOyoMyTFP5rs3Li5//zI67XbWVqYpP+d71/fuuARr/vI7BNCTkJpC+iBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=P00fKPI9np4IKUXOyCpW3TjIYp/b8PG3mDDGIiKT+YE=; b=i+tuImKt
        Zocwq2c0HrsA7DwbxfJA87rULvdTdAqzSy/C8swvG5w7VVZXQZ/v9/5V61avH6Q6
        H8gx8po0R/pjeiIRZKua2I+nixfQemyNgy7xhyGkvc7JeuNn+iwx7M8P5BthwaUM
        Hep4I8eezrO9UrYVVXvVxm85vZ7Lr/vGgHsmy8gjL+rY4GbcKZMT+J2WGsDt7IDQ
        91uhmaEhPeGQKtxFMalK+aCSwO3b5AHg4XYEthcCTvemdb5jCGg0h45q821Hec9E
        GwEWjPyIruzBrqehPxBG4W5n+BSm0O1ALP6qIoWLqybbFHNeFb7mhoJxBheIZcXt
        mmkTKJs2ok0W4Q==
X-ME-Sender: <xms:Rk1ZX-uZu2ojo33qjDkSoEt-0UH1YNqQC9cs4baXhu662U8W1-OulA>
    <xme:Rk1ZXzfHw_Tb3auB9ZRd3RYWVmczjM6KVmrmV4Z_5XOk81FCO67uBzQa5p1U8pmc3
    XW1yyNVEaQctaWeHUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehiedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepte
    ehhedugfellefhheffteettdefledvgffhleekfeeggfdvveegffefvddtfeegnecuffho
    mhgrihhnpehgihhthhhusgdrtghomhenucfkphepudeifedruddugedrudefvddrfeenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhs
    segsuhhrrdhioh
X-ME-Proxy: <xmx:Rk1ZX5yUa2xKc4NbhKHf8OnyHJOPo7C0RMdDLQS9EZw3wZl7XmhDDQ>
    <xmx:Rk1ZX5PaBV4-3sMCz-16AYlrQn0j_LOoDt-XMZP46wsPdgQkA5kjZQ>
    <xmx:Rk1ZX-_mpYBlYu-isX-a1h7CPG5Z5Bn0NISM4uixD03gIaS_kHmL8Q>
    <xmx:R01ZX1Zdwn2QuTtHl20yIw2_KlKLoZ8EqOonezv_dser-ge6ABS6Ew>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 541443068C65;
        Wed,  9 Sep 2020 17:46:46 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Dave Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 1/3] btrfs: support remount of ro fs with free space tree
Date:   Wed,  9 Sep 2020 14:45:16 -0700
Message-Id: <9bca6fcf34bffc73c42323c9f79f5c1a9e6ef131.1599686801.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1599686801.git.boris@bur.io>
References: <cover.1599686801.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When a user attempts to remount a btrfs filesystem with
'mount -o remount,space_cache=v2', that operation succeeds.
Unfortunately, this is misleading, because the remount does not create
the free space tree. /proc/mounts will incorrectly show space_cache=v2,
but on the next mount, the file system will revert to the old
space_cache.

For now, we handle only the easier case, where the existing mount is
read only. In that case, we can create the free space tree without
contending with the block groups changing as we go. If it is not read
only, we fail more explicitly so the user knows that the remount was not
successful, and we don't end up in a state where /proc/mounts is giving
misleading information. We also fail if the remount is read-only, since
we would not be able to create the free space tree in that case.

References: https://github.com/btrfs/btrfs-todo/issues/5
Signed-off-by: Boris Burkov <boris@bur.io>
---
v2:
- move creation down to ro->rw case
- error on all other remount cases
- add a comment to help future remount modifiers

 fs/btrfs/super.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3ebe7240c63d..0a1b5f554c27 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -47,6 +47,7 @@
 #include "tests/btrfs-tests.h"
 #include "block-group.h"
 #include "discard.h"
+#include "free-space-tree.h"
 
 #include "qgroup.h"
 #define CREATE_TRACE_POINTS
@@ -1838,6 +1839,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	u64 old_max_inline = fs_info->max_inline;
 	u32 old_thread_pool_size = fs_info->thread_pool_size;
 	u32 old_metadata_ratio = fs_info->metadata_ratio;
+	bool create_fst = false;
 	int ret;
 
 	sync_filesystem(sb);
@@ -1862,6 +1864,17 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	btrfs_resize_thread_pool(fs_info,
 		fs_info->thread_pool_size, old_thread_pool_size);
 
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) &&
+	    !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
+		create_fst = true;
+		if(!sb_rdonly(sb) || *flags & SB_RDONLY) {
+			btrfs_warn(fs_info,
+				   "Remounting with free space tree only allowed from read-only to read-write");
+			ret = -EINVAL;
+			goto restore;
+		}
+	}
+
 	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
 		goto out;
 
@@ -1924,6 +1937,22 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 			goto restore;
 		}
 
+		/*
+		 * NOTE: when remounting with a change that does writes, don't
+		 * put it anywhere above this point, as we are not sure to be
+		 * safe to write until we pass the above checks.
+		 */
+		if (create_fst) {
+			btrfs_info(fs_info, "creating free space tree");
+			ret = btrfs_create_free_space_tree(fs_info);
+			if (ret) {
+				btrfs_warn(fs_info,
+					   "failed to create free space tree: %d", ret);
+				goto restore;
+			}
+		}
+
+
 		ret = btrfs_cleanup_fs_roots(fs_info);
 		if (ret)
 			goto restore;
-- 
2.24.1

