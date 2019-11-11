Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B7EF6EBE
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 07:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfKKGxh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 01:53:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:52978 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbfKKGxh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 01:53:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E165DAD7F
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2019 06:53:35 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: mkfs: Make no-holes as default mkfs incompat features
Date:   Mon, 11 Nov 2019 14:53:28 +0800
Message-Id: <20191111065328.25027-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

No-holes feature could save 53 bytes for each hole we have, and it
provides a pretty good workaround to prevent btrfs check from reporting
non-contiguous file extent holes for mixed direct/buffered IO.

The latter feature is more helpful for developers for handle log-writes
based test cases.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/fsfeatures.c | 2 +-
 common/fsfeatures.h | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 50934bd161b0..2028be9ad312 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -84,7 +84,7 @@ static const struct btrfs_fs_feature {
 		"no_holes",
 		VERSION_TO_STRING2(3,14),
 		VERSION_TO_STRING2(4,0),
-		NULL, 0,
+		VERSION_TO_STRING2(5,4),
 		"no explicit hole extents for files" },
 	/* Keep this one last */
 	{ "list-all", BTRFS_FEATURE_LIST_ALL, NULL }
diff --git a/common/fsfeatures.h b/common/fsfeatures.h
index 3cc9452a3327..544daeeedf30 100644
--- a/common/fsfeatures.h
+++ b/common/fsfeatures.h
@@ -21,8 +21,9 @@
 
 #define BTRFS_MKFS_DEFAULT_NODE_SIZE SZ_16K
 #define BTRFS_MKFS_DEFAULT_FEATURES 				\
-		(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF		\
-		| BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
+		(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |		\
+		 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
+		 BTRFS_FEATURE_INCOMPAT_NO_HOLES)
 
 /*
  * Avoid multi-device features (RAID56) and mixed block groups
-- 
2.24.0

