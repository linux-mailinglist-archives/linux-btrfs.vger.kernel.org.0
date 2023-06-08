Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D904727535
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 04:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjFHCtT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 22:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjFHCtS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 22:49:18 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB80226AB;
        Wed,  7 Jun 2023 19:49:15 -0700 (PDT)
X-UUID: cbf73716e3e14009b0dcb230f6cd7ab6-20230608
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:44078dc0-e05f-4c25-959c-f1018cd46e55,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:0
X-CID-INFO: VERSION:1.1.22,REQID:44078dc0-e05f-4c25-959c-f1018cd46e55,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:0040ee3d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:2306081049069K200LWG,BulkQuantity:0,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: cbf73716e3e14009b0dcb230f6cd7ab6-20230608
X-User: oushixiong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <oushixiong@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 998334168; Thu, 08 Jun 2023 10:49:02 +0800
From:   Ou Shixiong <oushixiong@kylinos.cn>
To:     Chris Mason <clm@fb.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ou Shixiong <oushixiong@kylinos.cn>
Subject: [PATCH] btrfs: scrub: initialize variable explicitly
Date:   Thu,  8 Jun 2023 10:49:01 +0800
Message-Id: <20230608024901.221232-1-oushixiong@kylinos.cn>
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


Fix error of
error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]

Signed-off-by: Ou Shixiong <oushixiong@kylinos.cn>
---
 fs/btrfs/scrub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 28caad17ccc7..0d5c87c52c33 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1962,7 +1962,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 	/* An artificial limit, inherit from old scrub behavior */
 	struct btrfs_path path = { 0 };
 	u64 cur_logical = logical_start;
-	int ret;
+	int ret = 0;
 
 	/* The range must be inside the bg */
 	ASSERT(logical_start >= bg->start && logical_end <= bg->start + bg->length);
-- 
2.25.1


--Add_By_Label_Mail_Nextpart_001

Content-type: Text/plain

No virus found
		Checked by Hillstone Network AntiVirus

--Add_By_Label_Mail_Nextpart_001--
