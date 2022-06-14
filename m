Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F49754B26A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 15:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbiFNNmI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 09:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiFNNmH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 09:42:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB9A1E3DC;
        Tue, 14 Jun 2022 06:42:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9C5F21F96D;
        Tue, 14 Jun 2022 13:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655214123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2RynI9bveMfEuPgV6NPWSG+N+V9ocQzdvnmJTX6vFZ4=;
        b=fXJSI5N73XY/TsVtBo1pbPCeladhUNe0OuW0optUN+aU9DU1HrfsOlqAQxdHCLX0Ew2NTa
        y3ruaG/ezUKGV4An80QmY59I65Gxwj3x3EDnUWPMn120DIJZuesrMch21RVHmCLLE/HJd7
        wKV9TZKc6B+VxsG30ymxMBhs5NNUKPI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 93CA32C141;
        Tue, 14 Jun 2022 13:42:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 955F9DA864; Tue, 14 Jun 2022 15:37:31 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: [PATCH] docs: update btrfs list of features and link to readthedocs.io
Date:   Tue, 14 Jun 2022 15:37:28 +0200
Message-Id: <20220614133728.29320-1-dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfs documentation in kernel is only meant as a starting point, so
update the list of features and add link to readthedocs.io page that is
most up-to-date. The wiki is still used but information is migrated from
there.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 Documentation/filesystems/btrfs.rst | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/btrfs.rst b/Documentation/filesystems/btrfs.rst
index d0904f602819..8e6068448648 100644
--- a/Documentation/filesystems/btrfs.rst
+++ b/Documentation/filesystems/btrfs.rst
@@ -19,13 +19,23 @@ contribution from anyone.
     * Subvolumes (separate internal filesystem roots)
     * Object level mirroring and striping
     * Checksums on data and metadata (multiple algorithms available)
-    * Compression
+    * Compression (multiple algorithms available)
+    * Reflink, deduplication
+    * Scrub (on-line checksum verification)
+    * Hierachical quota groups (subvolume and snapshot support)
     * Integrated multiple device support, with several raid algorithms
     * Offline filesystem check
-    * Efficient incremental backup and FS mirroring
+    * Efficient incremental backup and FS mirroring (send/receive)
+    * Trim/discard
     * Online filesystem defragmentation
+    * Swapfile support
+    * Zoned mode
+    * Read/write metadata verification
+    * Online resize (shrink, grow)
 
-For more information please refer to the wiki
+For more information please refer to the documentation site or wiki
+
+  https://btrfs.readthedocs.io
 
   https://btrfs.wiki.kernel.org
 
-- 
2.36.1

