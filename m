Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14167349FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 04:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjFSCPn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Jun 2023 22:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFSCPh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Jun 2023 22:15:37 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF46E47
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Jun 2023 19:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687140934; x=1718676934;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QYVLA4kKI7BEj6MWOPV5L0mr4XglOPx3Xpyv49vjBmA=;
  b=T/VebGtjHb8IqdJbtASZNcxRB1TWYXi7YSIn2Kd5vTaT4NFJwfsuohQ+
   iIno0nSuGU8DokZcT6k8RvRYYU/dSOf3bQxpykjZ8IEUiLyy60tJcxrsL
   8sgauJvSt7YdA4kUSZKUy6iMkGx2UFQxvNwnhr1ILR9ZDItXdwbiHRA33
   mpR2y+FcJRB/ColaAFAYNi26wFcXbmH80d+RLGyonMfPIWuX9CwvGf/2a
   h5jUEAi0wsGFOC5OVrdRi/iwJPkkiKmimwubWPwf2sTA1OyZ9cOaYJMM0
   12ujbbdZq+KbKwU+Z/30Ba/B3uqX6Z0J/QrRxVpfowX7xzNcP5NPnF6Oh
   g==;
X-IronPort-AV: E=Sophos;i="6.00,253,1681142400"; 
   d="scan'208";a="347751921"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2023 10:15:34 +0800
IronPort-SDR: JNRK18D4pLo/iw0Gky4jCuOeHHqtHeK6SgXipUcR61+F1PuaMB7iagR+3E1Dtpdesp/N/7FEFP
 C/N21mrteqCCCVzNwYOwc5Rnda6RCkOmAf7ylhtC90Tt/zr0mGrrEp1IYPV7a2PtuJ1fYAMiDl
 MV9ZkOkdnDUeFt1I3lVX9eZzfGgphuXQLUnBN+alSQXOfd2AKcNFW0vEdHr0Ey7HzH+KIlD4dw
 WmuRatUp9yQ2A6FBLSBTVt6zB1/qynvIRmPcJI9iiesQLBnM5P522Mhehn/jHsDD//W7+r2hNm
 3sI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jun 2023 18:24:24 -0700
IronPort-SDR: XiUEqltosgNV98P/FGRs0msfgaCe9LHAN6iNVrVe4L5XBHlgCxeuh6u7QZQVOK84rEAFEZjMX4
 U+PfL3qWX9T7HWWw6KkJXn8Qd7NicxtvsmCyW0+gXW2r6M8r/XMl+PYSYMuKny5uvakDdiK1eq
 kssH9ashrX0F2d/Nu1zwDc3DKmlKKByU5zPIK1zpciSML/kKB3oQK+2+wP4tR/kuTYVlBzfkUQ
 JEwdFa5jSF2lKfIFpsEYeYAT10aY7IhzTbECbQoLTMa/lQU4y461Zm5EIHsyXL0wCEWXiZ8Bjz
 smE=
WDCIronportException: Internal
Received: from us8v58cg2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.163.2])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Jun 2023 19:15:36 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: also show actual number of the outstanding extents
Date:   Mon, 19 Jun 2023 11:15:31 +0900
Message-ID: <2a166dcefbdc57e4ff6b4304e0bff1ead9b9cd8e.1687140789.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
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

The btrfs_inode_mod_outstanding_extents trace event only shows the modified
number to the number of outstanding extents. It would be helpful if we can
see the resulting extent number as well.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/btrfs_inode.h       |  2 +-
 include/trace/events/btrfs.h | 11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 8abf96cfea8f..d47a927b3504 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -332,7 +332,7 @@ static inline void btrfs_mod_outstanding_extents(struct btrfs_inode *inode,
 	if (btrfs_is_free_space_inode(inode))
 		return;
 	trace_btrfs_inode_mod_outstanding_extents(inode->root, btrfs_ino(inode),
-						  mod);
+						  mod, inode->outstanding_extents);
 }
 
 /*
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index c6eee9b414cf..1132dfcbc68c 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2011,25 +2011,28 @@ DEFINE_EVENT(btrfs__prelim_ref, btrfs_prelim_ref_insert,
 );
 
 TRACE_EVENT(btrfs_inode_mod_outstanding_extents,
-	TP_PROTO(const struct btrfs_root *root, u64 ino, int mod),
+	TP_PROTO(const struct btrfs_root *root, u64 ino, int mod,
+		 unsigned outstanding),
 
-	TP_ARGS(root, ino, mod),
+	TP_ARGS(root, ino, mod, outstanding),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64, root_objectid	)
 		__field(	u64, ino		)
 		__field(	int, mod		)
+		__field(	unsigned, outstanding	)
 	),
 
 	TP_fast_assign_btrfs(root->fs_info,
 		__entry->root_objectid	= root->root_key.objectid;
 		__entry->ino		= ino;
 		__entry->mod		= mod;
+		__entry->outstanding    = outstanding;
 	),
 
-	TP_printk_btrfs("root=%llu(%s) ino=%llu mod=%d",
+	TP_printk_btrfs("root=%llu(%s) ino=%llu mod=%d outstanding=%u",
 			show_root_type(__entry->root_objectid),
-			__entry->ino, __entry->mod)
+			__entry->ino, __entry->mod, __entry->outstanding)
 );
 
 DECLARE_EVENT_CLASS(btrfs__block_group,
-- 
2.41.0

