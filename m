Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482086B1F50
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 10:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjCIJG4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 04:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjCIJGf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 04:06:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B161C329
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 01:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FbgbG1GUPW4twHXu9ju0oeFNwrGY94kbQPjrO+4tQ/4=; b=QG9nJUKVoyeRNWM5YIxh83wwxs
        TbNOeDI2isqefx6bvR3J9MPPzTSOBpoqiKIRDV9S+j9Rxy7+57IW4GMAZW1Ox3Xvhhg9HyQjXuFqi
        MByB6CP69p/Gy5w6QCXQ1pZ3ENLnLsVJI1uq+oLtTdekh84cWARjKcwyyUj8Lampa+koO3RHjjFWG
        UasmJBU5zxM51URTVTTcbwMfR8fbbJK9KvJ9EnqWwF0gSEE+Cifr5vbehiSBjmoMORxqTvZT5A79c
        SZxQMawwMpplHVan4zKShUwQs0qQAhy3k0XdgTK3cAbqFwWHSly6HR9tEjrgRDlL1K0LH0oRrBKX9
        GJ3hQkUQ==;
Received: from [2001:4bb8:190:782d:bc9d:fa49:9fec:5662] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paCDX-008hai-Hx; Thu, 09 Mar 2023 09:05:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/20] btrfs: move setting the buffer uptodate out of validate_extent_buffer
Date:   Thu,  9 Mar 2023 10:05:08 +0100
Message-Id: <20230309090526.332550-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309090526.332550-1-hch@lst.de>
References: <20230309090526.332550-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

