Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F6E73F444
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 08:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjF0GNg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 02:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjF0GNe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 02:13:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E601722
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jun 2023 23:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UQjv/CAi2gT4MpDNCNIx3Qe8M1aGoVtdodGOt4ykH0E=; b=AwADniww5QiN8Q52V7U3R8Aqnp
        pvrvG746Ov7m6ObD7KYpsmdWsfOZSCHXWUsP/fsAmsgjrrye35MPUZo0S9i+NwVcvk/Pi1Qe8wotq
        Ys+YDtIqanttF4gvnafVR3ePrjPBx0nEThfr1Juoc+TQhJ7OnBA8+q86w5++hIwNY9l5K0GHBSFYE
        9xnz21I2zrF1K/Z61HbeXeFusHoQwdSS0bwcX8eeU3M5kd958+x80TURZjlGLUW33gmlzhz31+6nb
        FXjQOJBdBNh5ol8O1qCFwGMLJbL1YNUa61mSb7Q/v7rKt/ICeNygnKGlc9PHKUVnjNg07KOn0gwvn
        GJNx+F1w==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qE1xC-00C5I3-31;
        Tue, 27 Jun 2023 06:13:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 1/2] btrfs: be a bit more careful when setting mirror_num_ret in btrfs_map_block
Date:   Tue, 27 Jun 2023 08:13:23 +0200
Message-Id: <20230627061324.85216-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627061324.85216-1-hch@lst.de>
References: <20230627061324.85216-1-hch@lst.de>
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

The mirror_num_ret is allowed to be NULL, although it has to be set when
smap is set.  Unfortunately that is not a well enough specifiable
invariant for static type checkers, so add a NULL check to make sure they
are fine.

Fixes: 03793cbbc80f ("btrfs: add fast path for single device io in __btrfs_map_block")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a536d0e0e05566..0d386ed44279ce 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6406,7 +6406,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	    (op == BTRFS_MAP_READ || !dev_replace_is_ongoing ||
 	     !dev_replace->tgtdev)) {
 		set_io_stripe(smap, map, stripe_index, stripe_offset, stripe_nr);
-		*mirror_num_ret = mirror_num;
+		if (mirror_num_ret)
+			*mirror_num_ret = mirror_num;
 		*bioc_ret = NULL;
 		ret = 0;
 		goto out;
-- 
2.39.2

