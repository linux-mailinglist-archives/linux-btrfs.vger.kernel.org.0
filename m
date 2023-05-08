Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6016FB4BF
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 18:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjEHQIz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 12:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjEHQIt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 12:08:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3AC65A0
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/PLqqKbsgVYr1zZtKyLe+QrK8uW+x5+T+F3GbGbZQO8=; b=FO3DPsTz03XDaINCO5tImsVlU7
        08l9clOtX+qEysLoPGuO+hongmqM6J0F4QBVe6/5DoD7hmRcCWH7bs4av2dm5aXmqj39/+ZhpLCK0
        C4VeHBWQHUsSd/IZ4t3Y+OcKAmdcZtWyXMuQn7Sczsyi+CAe6kX61vJLdXHz6GtWVECdeP5mHbKIY
        ku1WWsnRR7gIekWoVIi/OpAz9HW51O7rIwCKVhpNAppQ7wZzMF3zR3IQS9IC06utz+ZNxN5OzPLnF
        R2PN0VrOG2esZVdWKk/wJeQHps7MbAg/1iP1sQfmv0qy5FhG66FsOpNFH2JKaPhpO10Wj1ZQaH54l
        zD5JT/pw==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw3Pp-000vzB-0G;
        Mon, 08 May 2023 16:08:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/21] btrfs: fix file_offset for REQ_BTRFS_ONE_ORDERED bios that get split
Date:   Mon,  8 May 2023 09:08:24 -0700
Message-Id: <20230508160843.133013-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508160843.133013-1-hch@lst.de>
References: <20230508160843.133013-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 fs/btrfs/bio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 1ea7f4eebf01e6..ae30ef638716b0 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -95,8 +95,7 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
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

