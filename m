Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8D0231B61
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 10:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgG2Ikr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 04:40:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:43104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbgG2Ikr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 04:40:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58432AFE8
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 08:40:57 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: convert: update error message to reflect original fs unmodified cases
Date:   Wed, 29 Jul 2020 16:40:37 +0800
Message-Id: <20200729084038.78151-3-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200729084038.78151-1-wqu@suse.com>
References: <20200729084038.78151-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The original fs is not touched until we migrate the super blocks.

Under most error cases, we fail before that thus the original fs is
still safe.

So change the error message according the stages we failed to reflect
that.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/convert/main.c b/convert/main.c
index df6a2ae32722..451e4f158689 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1123,6 +1123,7 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 	struct task_ctx ctx;
 	char features_buf[64];
 	struct btrfs_mkfs_config mkfs_cfg;
+	bool btrfs_sb_commited = false;
 
 	init_convert_context(&cctx);
 	ret = convert_open_fs(devname, &cctx);
@@ -1270,6 +1271,7 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 		error("unable to migrate super block: %d", ret);
 		goto fail;
 	}
+	btrfs_sb_commited = true;
 
 	root = open_ctree_fd(fd, devname, 0,
 			     OPEN_CTREE_WRITES | OPEN_CTREE_TEMPORARY_SUPER);
@@ -1287,8 +1289,12 @@ fail:
 	clean_convert_context(&cctx);
 	if (fd != -1)
 		close(fd);
-	warning(
+	if (btrfs_sb_commited)
+		warning(
 "an error occurred during conversion, filesystem is partially created but not finalized and not mountable");
+	else
+		warning(
+"an error occurred during conversion, the original filesystem is not modified");
 	return -1;
 }
 
-- 
2.27.0

