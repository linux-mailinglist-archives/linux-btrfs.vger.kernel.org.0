Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E91162ADC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2019 06:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfE0Eqf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 May 2019 00:46:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:56146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725767AbfE0Eqf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 May 2019 00:46:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4CA98ABD0
        for <linux-btrfs@vger.kernel.org>; Mon, 27 May 2019 04:46:34 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: Enable crc32 optimization probe for convert and mkfs
Date:   Mon, 27 May 2019 12:46:27 +0800
Message-Id: <20190527044627.31588-1-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although moderm hardware is fast enough and crc32 calculation is not a
hotspot, doing such optimization won't hurt anyway.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/main.c | 2 ++
 mkfs/main.c    | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/convert/main.c b/convert/main.c
index 68f76f716be9..31e54a5c000e 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -101,6 +101,7 @@
 #include "mkfs/common.h"
 #include "convert/common.h"
 #include "convert/source-fs.h"
+#include "kernel-lib/crc32c.h"
 #include "fsfeatures.h"
 
 extern const struct btrfs_convert_operations ext2_convert_ops;
@@ -1845,6 +1846,7 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
+	crc32c_optimization_init();
 	if (rollback) {
 		ret = do_rollback(file);
 	} else {
diff --git a/mkfs/main.c b/mkfs/main.c
index 1d03ec52ddd6..5727d61df2d7 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -42,6 +42,7 @@
 #include "rbtree-utils.h"
 #include "mkfs/common.h"
 #include "mkfs/rootdir.h"
+#include "kernel-lib/crc32c.h"
 #include "fsfeatures.h"
 
 static int verbose = 1;
@@ -1121,6 +1122,8 @@ int main(int argc, char **argv)
 
 	dev_cnt--;
 
+	crc32c_optimization_init();
+
 	/*
 	 * Open without O_EXCL so that the problem should not occur by the
 	 * following operation in kernel:
-- 
2.21.0

