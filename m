Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6866CB5E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 07:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjC1FUb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 01:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjC1FU3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 01:20:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54ED211F
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 22:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6Ylr6w2t07ku0X5pX8I8Gr6hWRhaigyc66RGqOroY5o=; b=elMmR8I82xKSluw4YV7sJHBjgl
        yeIR0rIu9xv0eCeFf+EMGzjSX139ER6hqYB9RWeLxG5qJTVkCQqRkpJfc+uFDEs7NX7Qq/yZj1sp+
        m/OCoXTuMaQMY6dsU4H1fuw05QZEcKiC8z2Ln7Kcxy2VUBbpR6JP0YaYCGZZknVe29lIIrlWUQ+ys
        EVFJWkFoe33I8ZjbEyvuroUd6R7WOdZwpC7ccjOgRQbSIsQ8aWg3hpHw+qvlGKbys7jrOwOfmG8g9
        ENZm5bJdQiCtfrFVjJuph4o+mjIK0eeOwy08tz0jlqRet3PSpex1JAwdC17pLXjgcf0Abs1Ee720a
        rIkqRpCQ==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ph1ku-00DAZK-1a;
        Tue, 28 Mar 2023 05:20:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 10/11] btrfs: don't split nocow extent_maps in btrfs_extract_ordered_extent
Date:   Tue, 28 Mar 2023 14:19:56 +0900
Message-Id: <20230328051957.1161316-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328051957.1161316-1-hch@lst.de>
References: <20230328051957.1161316-1-hch@lst.de>
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
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 042018271baa37..a791faabb2ec87 100644
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

