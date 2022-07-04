Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DE6564F72
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 10:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiGDIKv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 04:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiGDIKg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 04:10:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72754B7F9
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 01:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bpR47VjAxXoU+c8MN5qG3amDjwiBlM7ZrG/UcpG0nuM=; b=NkptwGG8x+MbIyzUJEk0L3Jnu1
        bRBXuChriUMTyqG5p9i3k200sIWDCsBAchFWTUrN/nSKpZpTHXPZkmDqruQaNsjPbhO1R1JGzBJm9
        f041Rs5Ly2rzmiDPN5p9TEWvpaFvsAemzkrb2pzPMcd1pVk0yA+XzX5FC/sRZjl5WdadbCUUOGWEY
        hpGOQMYeHzoXpZmakO43Ed1/6vm1C4xwzjw/+5Dn6PSeAMo4EL4lMkEPwk7aIKXlbXv2ZIuGMeE1B
        rX0BHI8U3lihBkuLuRfv/oAlCpaz50RN0caLK10Djj08y5QQGjLtDI170X5j7eaQKb3Ujzl0NvJaL
        rJQWT5tA==;
Received: from [2001:4bb8:189:3c4a:9cc7:69df:e5dc:ef11] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8HA1-005xN6-9f; Mon, 04 Jul 2022 08:10:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        naohiro.aota@wdc.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix a memory leak in read_zone_info
Date:   Mon,  4 Jul 2022 10:10:22 +0200
Message-Id: <20220704081022.27512-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Don't leak the bioc on normal completion or when finding a parity
raid extent.

Fixes: 7db1c5d14dcd ("btrfs: zoned: support dev-replace in zoned filesystems")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/zoned.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 7a0f8fa448006..46e6c70217e08 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1735,12 +1735,14 @@ static int read_zone_info(struct btrfs_fs_info *fs_info, u64 logical,
 	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS, logical,
 			       &mapped_length, &bioc);
 	if (ret || !bioc || mapped_length < PAGE_SIZE) {
-		btrfs_put_bioc(bioc);
-		return -EIO;
+		ret = -EIO;
+		goto out_put_bioc;
 	}
 
-	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK)
-		return -EINVAL;
+	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		ret = -EINVAL;
+		goto out_put_bioc;
+	}
 
 	nofs_flag = memalloc_nofs_save();
 	nmirrors = (int)bioc->num_stripes;
@@ -1760,6 +1762,8 @@ static int read_zone_info(struct btrfs_fs_info *fs_info, u64 logical,
 	}
 	memalloc_nofs_restore(nofs_flag);
 
+out_put_bioc:
+	btrfs_put_bioc(bioc);
 	return ret;
 }
 
-- 
2.30.2

