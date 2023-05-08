Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8126FB4D5
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 18:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjEHQJQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 12:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjEHQI7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 12:08:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BE46A63
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 09:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xta5Lb2860oItYhGC8MyezxwVln/x6CpnyEoF4ifLro=; b=ma2Euz8K6djNCvwWyUUzBX3M7+
        pAHcBd1/x9g9EdeeX9Xao0d0to/hsfZVmxOOuSkR0eSGZkAQh8++c2W83O0lGBKvrqGIfuPcihRdG
        WuNBm0HL7YcxSeT3wmQ4AAYotjEal3f1WhPlUJiqVLWNjzhexZYckRxSas1hJjhy06iGJNQBjnozF
        Krb+lgmbuasQ8YwTa3cs3Rbd9KPZx2egER7SUIx5exC8t7gNHzDlqFNKjjrPlPai2MY2mRZbLe0rE
        ezvUVsjSDsYhswc0F9j/lzeHJL8JTzVw8qmCdCxXMs46J5SR5FXSdYTvkMEhdMC4ZOe19bwhQerdN
        LrcsifeQ==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw3Q1-000w52-1i;
        Mon, 08 May 2023 16:08:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 21/21] btrfs: use btrfs_finish_ordered_extent to complete buffered writes
Date:   Mon,  8 May 2023 09:08:43 -0700
Message-Id: <20230508160843.133013-22-hch@lst.de>
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

Use the btrfs_finish_ordered_extent helper to complete compressed writes
using the bbio->ordered pointer instead of requiring an rbtree lookup
in the otherwise equivalent btrfs_mark_ordered_io_finished called from
btrfs_writepage_endio_finish_ordered.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f02564ad194050..7a3a40c2eb7ff5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -595,8 +595,8 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 		"incomplete page write with offset %u and length %u",
 				   bvec->bv_offset, bvec->bv_len);
 
-		btrfs_writepage_endio_finish_ordered(BTRFS_I(inode), page, start,
-						     start + len - 1, !error);
+		btrfs_finish_ordered_extent(bbio->ordered, page, start, len,
+					    !error);
 		if (error) {
 			btrfs_page_clear_uptodate(fs_info, page, start, len);
 			btrfs_page_set_error(fs_info, page, start, len);
-- 
2.39.2

