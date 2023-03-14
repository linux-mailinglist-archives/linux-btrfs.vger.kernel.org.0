Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BEF6B8B0D
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 07:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjCNGRT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 02:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCNGRR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 02:17:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7397B102
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 23:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4nBjZgNGoWj4maPuFDDoW4odfJvOr7nrjyqed8+jGYk=; b=cEw1UjcYzIFUanenhDlIn7nXYS
        QBbvyIK2VLUpVcYGcXjnAWj4S0J90r9nIfyTNA8r+N+j5VWPRyTUCHWGgfS+5iRhO9eHodheyMD9u
        0BP+h0bxJi7bIZfTkvT426JaRVggIUQhZH0KGoFNDvAC0iU6nYC829WkxJ7m6sLLvjjIj6/pbosNz
        lnKEAxtefRFwjHtI60sjtsUKe3dkCr+++JY4C+6K73Z1HSRCxsWRnOt0iGsPkgVpDhLMrRqujN6pM
        Zf7pSMdv/cZf7VC4rNNlRyevbszLkoaYc6OabsGy/cRfgCnmcGuhd+K0yVjBE3sLlJBCOSg8pHst4
        wHju8Cgw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbxy7-009Agr-M2; Tue, 14 Mar 2023 06:17:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 03/21] btrfs: move setting the buffer uptodate out of validate_extent_buffer
Date:   Tue, 14 Mar 2023 07:16:37 +0100
Message-Id: <20230314061655.245340-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314061655.245340-1-hch@lst.de>
References: <20230314061655.245340-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Setting the buffer uptodate in a function that is named as a validation
helper is a it confusing.  Move the call from validate_extent_buffer to
the one of its two callers that didn't already have a duplicate call
to set_extent_buffer_uptodate.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index bb864cf2eed60f..7d766eaef4aee7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -590,9 +590,7 @@ static int validate_extent_buffer(struct extent_buffer *eb,
 	if (found_level > 0 && btrfs_check_node(eb))
 		ret = -EIO;
 
-	if (!ret)
-		set_extent_buffer_uptodate(eb);
-	else
+	if (ret)
 		btrfs_err(fs_info,
 		"read time tree block corruption detected on logical %llu mirror %u",
 			  eb->start, eb->read_mirror);
@@ -684,6 +682,8 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 		goto err;
 	}
 	ret = validate_extent_buffer(eb, &bbio->parent_check);
+	if (!ret)
+		set_extent_buffer_uptodate(eb);
 err:
 	if (ret) {
 		/*
-- 
2.39.2

