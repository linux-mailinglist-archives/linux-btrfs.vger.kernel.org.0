Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6F670D829
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 11:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjEWJAG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 05:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbjEWI7t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 04:59:49 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF291A7;
        Tue, 23 May 2023 01:59:45 -0700 (PDT)
X-UUID: 644fdf8724464f4c958947b0e0536717-20230523
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:4de3fa42-942b-489d-8bc4-4ba1faec6dfe,IP:15,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:10
X-CID-INFO: VERSION:1.1.22,REQID:4de3fa42-942b-489d-8bc4-4ba1faec6dfe,IP:15,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:10
X-CID-META: VersionHash:120426c,CLOUDID:b8a7143c-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230523165940UMKPRTAI,BulkQuantity:0,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 644fdf8724464f4c958947b0e0536717-20230523
X-User: pengfuyuan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <pengfuyuan@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 872247146; Tue, 23 May 2023 16:59:37 +0800
From:   pengfuyuan <pengfuyuan@kylinos.cn>
To:     Chris Mason <clm@fb.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, pengfuyuan <pengfuyuan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] btrfs: fix uninitialized variable warnings
Date:   Tue, 23 May 2023 16:59:35 +0800
Message-Id: <20230523085935.713859-1-pengfuyuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="Add_By_Label_Mail_Nextpart_001"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        PP_MIME_FAKE_ASCII_TEXT,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_TVD_MIME_NO_HEADERS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Add_By_Label_Mail_Nextpart_001
Content-Type: text/plain;
Content-Transfer-Encoding: 8bit


There are some warnings on older compilers (gcc 10, 7) or non-x86_64
architectures (mips64).  As btrfs wants to enable -Wmaybe-uninitialized
by default, fix the warnings even though it's not necessary on recent
compilers (gcc 12+).

    fs/btrfs/tree-log.c: In function ‘btrfs_log_inode’:
    fs/btrfs/tree-log.c:6211:9: error: ‘last_range_start’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     6211 |   ret = insert_dir_log_key(trans, log, path, key.objectid,
          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     6212 |       first_dir_index, last_dir_index);
          |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    fs/btrfs/tree-log.c:6161:6: note: ‘last_range_start’ was declared here
     6161 |  u64 last_range_start;
          |      ^~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9b212e8c70cc..d2755d5e338b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6158,7 +6158,7 @@ static int log_delayed_deletions_incremental(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *log = inode->root->log_root;
 	const struct btrfs_delayed_item *curr;
-	u64 last_range_start;
+	u64 last_range_start = 0;
 	u64 last_range_end = 0;
 	struct btrfs_key key;
 
-- 
2.25.1


--Add_By_Label_Mail_Nextpart_001

Content-type: Text/plain

No virus found
		Checked by Hillstone Network AntiVirus

--Add_By_Label_Mail_Nextpart_001--
