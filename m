Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E4654E657
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 17:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377209AbiFPPp5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 11:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377022AbiFPPpy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 11:45:54 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A0B35AA9
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655394354; x=1686930354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HbQk+ZYhsapevLe1HE4dRj1zWMfDynqlpqm2w/70e24=;
  b=f+sDFZoSCmYt35qxcceXpg+5ciKKVuMWfvMOZ2Shp8voI6QeOHqDLKHt
   iWxCy/2ZOUguGyh0+caBTSEAc7o5YCI2l5ABVHkfg9ilBPBuvC8YntrxS
   gWl5wggRqdpoyOlpSXYYKj0OnPajjaWQ7HuJIwJUbqObQ7BqXuuNLMGrR
   bMhSaWVjQK9o6yi1h7kuPuvmht5X/Ei+zfR/f1OX+JZvT5YsMFkAtk3AQ
   LIbHehwiK5n2dcISoozINJ8k+fBEpMB/rsEYWURSU0MH3jVfRn+bc5xwW
   ME99GTM5kbukRdg+AXmpwnZqzuuS2XqF7WLacCy7e1jDddpW7UE4EKMdO
   A==;
X-IronPort-AV: E=Sophos;i="5.92,305,1650902400"; 
   d="scan'208";a="204103913"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 23:45:52 +0800
IronPort-SDR: ExeNa7ItRvvXFSdrjof69MfQbXH15bR/X2JhChPN0okiKN7j0rbPxBuBa8XXqgiIRrNN9dzxnX
 P7cCnnOSjkJK6yvz2sMG6juZcPRSCIfHdSWMfuY+4G8QNjbj74ajwE0Juf3sAVAvxvSX2XfUrK
 HQt5I94J2wzjuNtiiFwzmAenC2y+bmjetVktaijQAiBQW/JtTe9V5bkHTLbVlIyDs5R9IphykF
 6IRZCW+IbIyTI6gvoIbhoJGesIMIRMwa1MXkx4I5H3lW0XgFBEYPqSiXjNis8wGo+Wd4AN2v/y
 12/E94mBln/OKLTPGL9i+wag
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 08:04:04 -0700
IronPort-SDR: nD2ZMXks8vPJ0dm7rAwWwhu8vwLNXlq/1jCE19A9w41De40C1sOxyVte7TRda0Qkv+Hj6IX1Z2
 5FZfEJUV65k0tfMlPDchiTgnVP6LBk273h9/wl4DoR8f2E0q3bR3Ww7Yaw8l24Ppy1N63XS1PD
 TayTvayAJilQJlnxmg0S5YUcBJHRokbGG58Srp2koB/HJHUV3p1tyVCXcpAYPKeX4G7mgiF7Oq
 Q+yjHdOWt8+VlCTzh5+vPy3tE86sI/rIQbhuTA6CYccXWzFzXvULBNFiRApEdgGPCAGwe6qyr9
 gmA=
WDCIronportException: Internal
Received: from jpf010151.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.117])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Jun 2022 08:45:51 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/4] btrfs: fix error handling of fallbacked uncompress write
Date:   Fri, 17 Jun 2022 00:45:41 +0900
Message-Id: <f0ac3032fcd07344a84a9b1f7d05f8862aa60760.1655391633.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655391633.git.naohiro.aota@wdc.com>
References: <cover.1655391633.git.naohiro.aota@wdc.com>
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
unlocks the pages but remains the ordered extents intact. Thus, we need to
call btrfs_cleanup_ordered_extents() to finish the created ordered extents.

Also, we need to call end_extent_writepage() if locked_page is available
because btrfs_cleanup_ordered_extents() never process the region on the
locked_page.

Furthermore, we need to set the mapping as error if locked_page is
unavailable before unlocking the pages, so that the errno is properly
propagated to the userland.

CC: stable@vger.kernel.org
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4e1100f84a88..cae15924fc99 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -934,8 +934,18 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
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
 
@@ -1390,9 +1400,12 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
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

