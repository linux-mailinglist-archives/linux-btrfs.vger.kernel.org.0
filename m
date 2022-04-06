Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1B24F62A5
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 17:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbiDFPKG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 11:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbiDFPJ7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 11:09:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A84126C2CC
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 05:06:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AE0D61793
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 11:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F838C385A3
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 11:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649245978;
        bh=19HeUUw1fDQptAZu1OMgz9NQVCF8gKKE8KEnZpGv5qA=;
        h=From:To:Subject:Date:From;
        b=atZxBp/n+q689bgT5+i8geHhFVgHOoTaw/+p7cT5inqLsJzKumIFL3UmYd1GcFg82
         IIQf8qwi8hE4yIb4+hMDYGp0UL+gYI/eY5x0+dlEFkLoepCErZgalTaQFS6wfxMgeL
         wksIiTowJpWlmdpz/SiHScSkNph5G04e+wXkiHskTEhHL4/qglSZygmjoO7I6xLAmJ
         McOq/10HLt0J5Y+AwwhultB53fnIjw2hquZAyeEsQV2IFGHTeHc27bl3MG4EfyP9kB
         Yzbd4QXITV7SRxWd2n9+FwnGy5BGk1hiZXvIyIspbOwZol8l0S6bdzs8/ccLS5wAck
         BFO8rOnkh6oRQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix leaked plug after falilure syncing log on zoned filesystems
Date:   Wed,  6 Apr 2022 12:52:54 +0100
Message-Id: <c766f439fa12967383d8e62c6f5883bd1f62c483.1649245880.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

On a zoned filesystem, if we fail to allocate the root node for the log
root tree while syncing the log, we end up returning without finishing
the IO plug we started before, resulting in leaking resources as we
have started writeback for extent buffers of a log tree before. That
allocation failure is typically either -ENOMEM or -ENOSPC.

So release the IO plug if we fail to allocate the extent buffer for the
root of the log root tree when syncing the log on a zoned filesystem.

Fixes: 3ddebf27fcd3a9 ("btrfs: zoned: reorder log node allocation on zoned filesystem")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 273998153fcc..6533329e5fd7 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3187,6 +3187,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 		if (!log_root_tree->node) {
 			ret = btrfs_alloc_log_tree_node(trans, log_root_tree);
 			if (ret) {
+				blk_finish_plug(&plug);
 				mutex_unlock(&fs_info->tree_root->log_mutex);
 				goto out;
 			}
-- 
2.33.0

