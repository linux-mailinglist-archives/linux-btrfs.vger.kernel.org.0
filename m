Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1456499A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 08:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiLLHhy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 02:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiLLHhx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 02:37:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569BA10CF
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 23:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AtXpPTW2mzQQt97Uub5ftGmYZ534LFYiAiluqPTOgBc=; b=JcsKw1taecunHyYf+aVlMqSXkD
        ZfUBzUB8Vhkz41TQkA8mEVroOgoRxO7wCYtZU6TnLvVzP9iydzNGT191uGJhAjzTr9wQFNORCqyrn
        +vxYhIS5avtW9S9tlfMIMkqZs9FeHsbnX5h5mUITeKF8/s8rreD4WpGB/Po3ZrNqLiV1W8x9IjgCr
        JFcm3MzXIe/sV8IV0p5dplMsob8xo2vvDtDyeIEdqV0Ad4D1TbCfzZroJ3couLmTyaK2AdI5dirok
        IIFSaRBpR+OM3Byc/gpLZLvPOBPaR+UxvVghPoBfwp2hIHaL0Byq3/JS5Vz0KzDi3F3yLQqZljEL4
        jw2hYsYA==;
Received: from [2001:4bb8:192:2f53:34e0:118:ce10:200c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4dNj-009WSY-Ed; Mon, 12 Dec 2022 07:37:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 5/7] btrfs: never return true for reads in btrfs_use_zone_append
Date:   Mon, 12 Dec 2022 08:37:22 +0100
Message-Id: <20221212073724.12637-6-hch@lst.de>
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

Using Zone Append only makes sense for writes to the device, so check
that in btrfs_use_zone_append.  This avoids the possibility of
artificially limited read size on zoned file systems.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 77f453005dc924..af063089ad3465 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1636,6 +1636,9 @@ bool btrfs_use_zone_append(struct btrfs_bio *bbio)
 	if (!is_data_inode(&inode->vfs_inode))
 		return false;
 
+	if (btrfs_op(&bbio->bio) != BTRFS_MAP_WRITE)
+		return false;
+
 	/*
 	 * Using REQ_OP_ZONE_APPNED for relocation can break assumptions on the
 	 * extent layout the relocation code has.
-- 
2.35.1

