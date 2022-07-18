Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907DD5780EA
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 13:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiGRLhg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 07:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiGRLhf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 07:37:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29DDE0B9
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 04:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=LJQhiHnZz2aCHItbo7c1nKd9oRnWpKA1FlorumekbZQ=; b=Rj1O8euoPqKKjE10LXM9yICWeg
        4tNXM1F2kGr9M4IcnraJ4+NtwdE1WL5Lr8bE1MwRPBpL9esnzC93Ntz2YFAmSC0EsEAEIp+R1ce8L
        1DeEjZK9yWfKb/BwfGtdaGV0VwnsWeyCM6+e2UAf0P1I2ehPZVf8xG9toqED5D06mZjLDAsdn9n8F
        z27Fa6OT9YMzYq6sTql4WPKYo+7Miyicd9y8EbAJnTY2rRHLUQ6CjTsx7VLbtLIVWm6NaPK4QGtpr
        Qp6QrZ01IMqfNTTbh1Lpif5TpiP9Fz0JfDDbZY9A5AsPX9IhMmVbVlLS71bq+ClkQrMdXUzBJkjH+
        7l0/vCvQ==;
Received: from [89.144.222.108] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDP45-00CtW9-1P; Mon, 18 Jul 2022 11:37:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btfs: remove btrfs_dev_stat_print_on_error
Date:   Mon, 18 Jul 2022 13:37:23 +0200
Message-Id: <20220718113723.558377-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just fold it into the only caller instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d98dc78f83af5..a02a6d0754906 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -256,7 +256,6 @@ out_overflow:;
 
 static int init_first_rw_device(struct btrfs_trans_handle *trans);
 static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info);
-static void btrfs_dev_stat_print_on_error(struct btrfs_device *dev);
 static void btrfs_dev_stat_print_on_load(struct btrfs_device *device);
 static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 			     enum btrfs_map_op op, u64 logical, u64 *length,
@@ -8287,11 +8286,7 @@ int btrfs_run_dev_stats(struct btrfs_trans_handle *trans)
 void btrfs_dev_stat_inc_and_print(struct btrfs_device *dev, int index)
 {
 	btrfs_dev_stat_inc(dev, index);
-	btrfs_dev_stat_print_on_error(dev);
-}
 
-static void btrfs_dev_stat_print_on_error(struct btrfs_device *dev)
-{
 	if (!dev->dev_stats_valid)
 		return;
 	btrfs_err_rl_in_rcu(dev->fs_info,
-- 
2.30.2

