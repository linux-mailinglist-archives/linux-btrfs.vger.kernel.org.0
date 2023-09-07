Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7EC797F22
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 01:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbjIGXQM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 19:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjIGXQL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 19:16:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2158A1BD3
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 16:16:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D1B9B1F461;
        Thu,  7 Sep 2023 23:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694128566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jLurzgM5/9/ZijZ5HBLFOhzzITSk8pavZA3+PtcvJk=;
        b=QDVTdhWUPgempoX6YFtARaPVxV0LJGSbP/NH7nbFY1GbHe1I6ebiSfbO5/hFk/n/M47JrQ
        XpLi7ZdV144pnCb18F9MD+vcXBMlbXAiBzdkuouNFj//tbhNObAML644VnWas15D7HAVu1
        h8sus1KgCURu5dgGwp7mApYH+Evb2Ws=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C64522C142;
        Thu,  7 Sep 2023 23:16:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ED94FDA8C5; Fri,  8 Sep 2023 01:09:35 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 07/10] btrfs: reduce size of prelim_ref::level
Date:   Fri,  8 Sep 2023 01:09:35 +0200
Message-ID: <270b9ad9e44ece857f8ec5fa006a484459c1fddd.1694126893.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694126893.git.dsterba@suse.com>
References: <cover.1694126893.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The values of level are bounded and fit into a byte so let's use it for
the structure to reduce size from 88 to 80 bytes on a release build,
which increases number of objects in the default 8K slab from 93 to 102.

struct prelim_ref {
        struct rb_node             rbnode __attribute__((__aligned__(8))); /*     0    24 */
        u64                        root_id;              /*    24     8 */
        struct btrfs_key           key_for_search;       /*    32    17 */
        u8                         level;                /*    49     1 */

        /* XXX 2 bytes hole, try to pack */

        int                        count;                /*    52     4 */
        struct extent_inode_elem * inode_list;           /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        u64                        parent;               /*    64     8 */
        u64                        wanted_disk_byte;     /*    72     8 */

        /* size: 80, cachelines: 2, members: 8 */
        /* sum members: 78, holes: 1, sum holes: 2 */
        /* forced alignments: 1 */
        /* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 1616e3e3f1e4..79742935399f 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -247,7 +247,7 @@ struct prelim_ref {
 	struct rb_node rbnode;
 	u64 root_id;
 	struct btrfs_key key_for_search;
-	int level;
+	u8 level;
 	int count;
 	struct extent_inode_elem *inode_list;
 	u64 parent;
-- 
2.41.0

