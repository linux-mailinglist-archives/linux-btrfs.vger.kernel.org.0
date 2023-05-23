Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EAA70D491
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 09:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjEWHLN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 03:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjEWHLM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 03:11:12 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7FB109;
        Tue, 23 May 2023 00:11:10 -0700 (PDT)
X-UUID: 1ef662134f9740e6894da13dca1a8511-20230523
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:74ad7db4-aff1-443e-9589-f81ae3c5326c,IP:15,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:10
X-CID-INFO: VERSION:1.1.22,REQID:74ad7db4-aff1-443e-9589-f81ae3c5326c,IP:15,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:10
X-CID-META: VersionHash:120426c,CLOUDID:331fbdc1-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:230523151050N8F4QV29,BulkQuantity:0,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 1ef662134f9740e6894da13dca1a8511-20230523
X-User: pengfuyuan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <pengfuyuan@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 2067069638; Tue, 23 May 2023 15:10:47 +0800
From:   pengfuyuan <pengfuyuan@kylinos.cn>
To:     Chris Mason <clm@fb.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, pengfuyuan <pengfuyuan@kylinos.cn>
Subject: [PATCH] btrfs: Fix csum_tree_block to avoid tripping on -Werror=array-bounds
Date:   Tue, 23 May 2023 15:09:55 +0800
Message-Id: <20230523070956.674019-1-pengfuyuan@kylinos.cn>
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


When compiling on a mips 64-bit machine we get these warnings:

    In file included from ./arch/mips/include/asm/cacheflush.h:13,
	             from ./include/linux/cacheflush.h:5,
	             from ./include/linux/highmem.h:8,
		     from ./include/linux/bvec.h:10,
		     from ./include/linux/blk_types.h:10,
                     from ./include/linux/blkdev.h:9,
	             from fs/btrfs/disk-io.c:7:
    fs/btrfs/disk-io.c: In function ‘csum_tree_block’:
    fs/btrfs/disk-io.c:100:34: error: array subscript 1 is above array bounds of ‘struct page *[1]’ [-Werror=array-bounds]
      100 |   kaddr = page_address(buf->pages[i]);
          |                        ~~~~~~~~~~^~~
    ./include/linux/mm.h:2135:48: note: in definition of macro ‘page_address’
     2135 | #define page_address(page) lowmem_page_address(page)
          |                                                ^~~~
    cc1: all warnings being treated as errors

We can check if i overflows to solve the problem. However, this doesn't make
much sense, since i == 1 and num_pages == 1 doesn't execute the body of the loop.
In addition, i < num_pages can also ensure that buf->pages[i] will not cross
the boundary. Unfortunately, this doesn't help with the problem observed here:
gcc still complains.

To fix this, start the loop at index 0 instead of 1. Also, a conditional was
added to skip the case where the index is 0, so that the loop iterations follow
the desired logic, and it makes all versions of gcc happy.

Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
---
 fs/btrfs/disk-io.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index fbf9006c6234..8b05d556d747 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -96,9 +96,13 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
 			    first_page_part - BTRFS_CSUM_SIZE);
 
-	for (i = 1; i < num_pages; i++) {
-		kaddr = page_address(buf->pages[i]);
-		crypto_shash_update(shash, kaddr, PAGE_SIZE);
+	for (i = 0; i < num_pages; i++) {
+		struct page *p = buf->pages[i];
+
+		if (i != 0) {
+			kaddr = page_address(p);
+			crypto_shash_update(shash, kaddr, PAGE_SIZE);
+		}
 	}
 	memset(result, 0, BTRFS_CSUM_SIZE);
 	crypto_shash_final(shash, result);
-- 
2.25.1


--Add_By_Label_Mail_Nextpart_001

Content-type: Text/plain

No virus found
		Checked by Hillstone Network AntiVirus

--Add_By_Label_Mail_Nextpart_001--
