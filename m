Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43466C75EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 03:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCXCcw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 22:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjCXCcv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 22:32:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE605276
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 19:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rCFfIWH+Qi83Jo6/mP5bhRVo96yxbcGJ484rdtN6uZA=; b=ou7I+1gNCLLy3/K0AJXx7YUImP
        sh6g2v5gmrwOfeKt8YBMQOhaay7syh3hIHZAxxW/zBw0It8kuUMCp231Y8QCmujrh/mtNg+IkbEh9
        x5bwPlKZTOT1QV+6zJSL1vEdDNRhLLzXt65xfMKDKkDOoUX4PfqC3rdtmuIKxr8NGnOYpV5qPUchK
        QEqhV0+5Bm0o3inQW398Ck2Sc+I4odhWz0GTUnMvVGM4d92v3jo4YiZqX++WymcwcqEEhNz4hHGA6
        PxsksoZbR5/iEOwjmjA7u2821olUe2YpXB0snCJSmAOhev2mhJwksNL32JDUYid5jiLSaOIIyFwQ/
        7WXjG+mg==;
Received: from [122.147.159.120] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pfXEV-003PKU-1Q;
        Fri, 24 Mar 2023 02:32:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 10/11] btrfs: don't split nocow extent_maps in btrfs_extract_ordered_extent
Date:   Fri, 24 Mar 2023 10:32:06 +0800
Message-Id: <20230324023207.544800-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324023207.544800-1-hch@lst.de>
References: <20230324023207.544800-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Boris Burkov <boris@bur.io>

Nocow writes just overwrite an existing extent map, which thus should
not be split in btrfs_extract_ordered_extent.  The nocow case can't
currently happen as btrfs_extract_ordered_extent is only used on zoned
devices that do not support nocow writes, but this will change soon.

Signed-off-by: Boris Burkov <boris@bur.io>
[hch: split from a larger patch, wrote a commit log]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2abbedfd31c2c2..f72ba14dcda55e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2622,6 +2622,14 @@ int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
 	ret = btrfs_split_ordered_extent(ordered, len);
 	if (ret)
 		return ret;
+
+	/*
+	 * Don't split the extent_map for nocow extents, as we're writing
+	 * into a pre-existing one.
+	 */
+	if (test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags))
+		return 0;
+
 	return split_extent_map(inode, bbio->file_offset, ordered_len, len);
 }
 
-- 
2.39.2

