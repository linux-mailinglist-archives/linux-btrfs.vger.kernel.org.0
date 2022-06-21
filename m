Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036AD552B40
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 08:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345498AbiFUGoI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 02:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345836AbiFUGoH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 02:44:07 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDCF1B7B3
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 23:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655793846; x=1687329846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LKqaWlqTZiWZBdfoT4tAItaDYJo4IZ0507qTs4YTTSQ=;
  b=mlL48zgh28Szzq/rcYfsfajgMyuQn54epiMiIPFcnOEqd0ExjTfeid+6
   XiJKHt2gpXV+G8aWDu6FTt+qxW5mJmhjeWF0aRyNK+e6uVhdPDfnLA3D4
   kyePElXyYlzIDESZMNURt6p3dtDurMOkyowrPPvFbINUUutyUuiRmo1Fo
   Qb0iALK+yHax0XWr2G+j/Ab6Grbb/FYonb0g2UoUAtCEHMApYVcRGHXmS
   SY1TS9dM7G+cvDnDpTO6avNccna1Hd/a3ST0BFvvSvdKsgjZk08qs2JIZ
   a0k9QS3mJUeeXiZi5y04ej5SUJEueZIcdu3BGfXllkcQ4GZuwKnMolvWs
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,209,1650902400"; 
   d="scan'208";a="208550415"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 14:44:04 +0800
IronPort-SDR: 4SOPKNm2JE29Iw8x1E/ocvW1BMAejPfUMzzs37WHE7zU2wkK+nM6cFP6eX+LJr7UhVFT6XpLst
 PqqYAPu/086YHcqtoVKVwr+N5ZwscYRZdW8+Ej30btChJmjXlGM1FLfLV07WqwT8wBLyWP/GjD
 pyHJEd7lMtK+10jxvZNkX3d9fG4QCbxiERGjAL/z8JFP2x8RYvVk77mqoz5NzjX4mtDrlmPQV4
 jcYBIYm49MPuhAGKTa3FnnxGOwCh6WRIGVAP5DAZJskEgAnSPmxh9opPxROz1hpFdEbzAsKXq/
 mHWqniaXgIkvCIe58beghD4d
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 23:02:13 -0700
IronPort-SDR: /nYkH5hbUGNpVKaGbnm0Fi81YE4l5gf/Muc/zhGUIY9jfvNZ+aKxWF4J64PJKxijnCySvTjz2G
 ftpZp/atat/lK6Lp4JiV2CUmh8d7Q+3JO00y79uCgSygLlRKDDYc5HQphizW+cA3qLhwxOTeAL
 F4xO2T/W04HFFsx9XQsbaYX4C2wqElmyv5MfYrPrNgRdKiA4bnZ+IZrLwfxAuRXBo1PVabnN0L
 lKIBhEILCXsX1chmMjw7EqAEiWoAscH+whQYP/eZBlPWo7vVVAQmzaUMZMzYlo3xrf03xK0aj8
 8FQ=
WDCIronportException: Internal
Received: from dtjcyy2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Jun 2022 23:44:05 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     fdmanana@kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 3/4] btrfs: fix error handling of fallbacked uncompress write
Date:   Tue, 21 Jun 2022 15:41:01 +0900
Message-Id: <7347f1de449c3a3f36690b816c2ded133508c5c2.1655791781.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655791781.git.naohiro.aota@wdc.com>
References: <cover.1655791781.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When cow_file_range() fails in the middle of the allocation loop, it
unlocks the pages but leaves the ordered extents intact. Thus, we need to
call btrfs_cleanup_ordered_extents() to finish the created ordered extents.

Also, we need to call end_extent_writepage() if locked_page is available
because btrfs_cleanup_ordered_extents() never process the region on the
locked_page.

Furthermore, we need to set the mapping as error if locked_page is
unavailable before unlocking the pages, so that the errno is properly
propagated to the userland.

CC: stable@vger.kernel.org # 5.18+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
I choose 5.18+ as the target as they are after refactoring and we can apply
the series cleanly. Technically, older versions potentially have the same
issue, but it might not happen actually. So, let's choose easy targets to
apply.
---
 fs/btrfs/inode.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 326150552e57..38d8e6d78e77 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -933,8 +933,18 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
 		goto out;
 	}
 	if (ret < 0) {
-		if (locked_page)
+		btrfs_cleanup_ordered_extents(inode, locked_page, start, end - start + 1);
+		if (locked_page) {
+			u64 page_start = page_offset(locked_page);
+			u64 page_end = page_start + PAGE_SIZE - 1;
+
+			btrfs_page_set_error(inode->root->fs_info, locked_page,
+					     page_start, PAGE_SIZE);
+			set_page_writeback(locked_page);
+			end_page_writeback(locked_page);
+			end_extent_writepage(locked_page, ret, page_start, page_end);
 			unlock_page(locked_page);
+		}
 		goto out;
 	}
 
@@ -1383,9 +1393,12 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * However, in case of unlock == 0, we still need to unlock the pages
 	 * (except @locked_page) to ensure all the pages are unlocked.
 	 */
-	if (!unlock && orig_start < start)
+	if (!unlock && orig_start < start) {
+		if (!locked_page)
+			mapping_set_error(inode->vfs_inode.i_mapping, ret);
 		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
 					     locked_page, 0, page_ops);
+	}
 
 	/*
 	 * For the range (2). If we reserved an extent for our delalloc range
-- 
2.35.1

