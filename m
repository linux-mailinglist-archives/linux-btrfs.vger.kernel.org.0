Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0A7717920
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 09:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjEaH4D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 03:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbjEaHzf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 03:55:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D062EE54
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 00:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0DsSmdQxV9I1c7ri+g1bPN3CHuAbjhAdNusqmLCn3nQ=; b=roG0xDcz0G+JqIBfZL+J7W7YBK
        AAO4rE3HjWbECnNOTsonrfhsoStcKCnrIM2pPeoYoUN2YVH9ski3ApaGNIV8bYzNgPLERDcndFgzt
        yhODsJXIreneUdpZhy+EwPfXa9Qvc82GWmb7qNPTg5LE6lFx12gLiwMm+Bdro45wu5aGREWWMga9e
        uFxMmJQX6R6MYygqPve7ovq4OCJJ4agE6nagilmX+CRBFcgJQRktYhbDefnGObiL0Mo118dSZos6b
        NwMGHrdCGvHkCKgcKs64Jd10HEA8Mz0l+KuMsNaz9wDuQZdwYRnhGhajJ/+KVFqW0I01KdzRkqNhP
        MDN52p4Q==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4Get-00GWpP-2y;
        Wed, 31 May 2023 07:54:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 01/17] btrfs: fix file_offset for REQ_BTRFS_ONE_ORDERED bios that get split
Date:   Wed, 31 May 2023 09:53:54 +0200
Message-Id: <20230531075410.480499-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531075410.480499-1-hch@lst.de>
References: <20230531075410.480499-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If a bio gets split, it needs to have a proper file_offset for checksum
validation and repair to work properly.

Based on feedback from Josef, commit 852eee62d31a ("btrfs: allow
btrfs_submit_bio to split bios") skipped this adjustment for ONE_ORDERED
bios.  But if we actually ever need to split a ONE_ORDERED read bio, this
will lead to a wrong file offset in the repair code.  Right now the only
user of the file_offset is logging of an error message so this is mostly
harmless, but the wrong offset might be more problematic for additional
users in the future.

Fixes: 852eee62d31a ("btrfs: allow btrfs_submit_bio to split bios")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index ae6345668d2d01..42c0ded42fafe5 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -81,8 +81,7 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 	btrfs_bio_init(bbio, fs_info, NULL, orig_bbio);
 	bbio->inode = orig_bbio->inode;
 	bbio->file_offset = orig_bbio->file_offset;
-	if (!(orig_bbio->bio.bi_opf & REQ_BTRFS_ONE_ORDERED))
-		orig_bbio->file_offset += map_length;
+	orig_bbio->file_offset += map_length;
 
 	atomic_inc(&orig_bbio->pending_ios);
 	return bbio;
-- 
2.39.2

