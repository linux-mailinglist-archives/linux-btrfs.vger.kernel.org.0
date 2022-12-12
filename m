Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DAD64999B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 08:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiLLHhf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 02:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiLLHhe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 02:37:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098C664D2
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 23:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Me7RKZNCcECkhaNBjKn+o71sy9uj7DrAlf0KT6cZiYs=; b=zHZtbI9Ypt+kMQMIXvJTvwhB1U
        UNWvHkJVDAhH2TeWxel0TP4Pv3nTek6EydYme2RE4XXlnO7Q77q1flxDsXCEOVwwkw4fzJ+Ch3QBZ
        +63DDeQ7h5u08WaM9sEw34o6t9QuJ588Cpcbw4YFoyE5y8AfwRM+36ab7F7/SV9WLk56lUhvF1yk6
        N1tr8PZ9svuGtt0K3VgFMz6eTGakBMFUqFHNa8MtwZJZhsmHPCVNcvLDk7eTFnea6cts22Unw4HDl
        KEEruYDKrCJYHkhdBba/t3HRrXk4uopUiVwgcdOKMsVSYgAeNoEPJNZqaR8qNojaa5QB7PUXAfFAY
        yeyvVG4Q==;
Received: from [2001:4bb8:192:2f53:34e0:118:ce10:200c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4dNS-009WFc-19; Mon, 12 Dec 2022 07:37:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs: use file_offset to limit bios size in calc_bio_boundaries
Date:   Mon, 12 Dec 2022 08:37:18 +0100
Message-Id: <20221212073724.12637-2-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221212073724.12637-1-hch@lst.de>
References: <20221212073724.12637-1-hch@lst.de>
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

btrfs_ordered_extent->disk_bytenr can be rewritten by the zoned I/O
completion handler, and thus in general is not a good idea to limit I/O
size.  But the maximum bio size calculation can easily be done using the
file_offset fields in the btrfs_ordered_extent and btrfs_bio structures,
so switch to that instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a65a1629d3356d..1fcb55e549717f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -944,8 +944,8 @@ static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 		ordered = btrfs_lookup_ordered_extent(inode, file_offset);
 		if (ordered) {
 			bio_ctrl->len_to_oe_boundary = min_t(u32, U32_MAX,
-					ordered->disk_bytenr +
-					ordered->disk_num_bytes - logical);
+					ordered->file_offset +
+					ordered->disk_num_bytes - file_offset);
 			btrfs_put_ordered_extent(ordered);
 			return;
 		}
-- 
2.35.1

