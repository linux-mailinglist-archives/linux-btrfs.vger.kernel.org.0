Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DF64F6846
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 19:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbiDFR45 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 13:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239703AbiDFR4n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 13:56:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08B83E8FD0
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 09:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B37F6125B
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 16:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB6BC385A1
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 16:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649261277;
        bh=QEdod27xsirH6UfghpbDBMdqdlqVKMqwYCtilE2kGm0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QHjaH891tfso1zQmw4vEh1t81l2teFXDPku3BC1l9LQq9dzSH5vsEbVmfooG1kLGF
         NO17cOjH74AyO2cVnuF1I1PYC8LqUgSMSWmCeeaHIYYiMZnQ3SymPKieFyqPHjqrWH
         DEbYJDXEyWholLdTuSLwro1dGyZLwIZbcUKPf1xD/eIGXZ7niHM5A2z4zSyRkQJPWW
         mf3Cqm6c39k+gnYUJO/EiIf02dMSq0SjOJQwxc5DJ9XxxhB/vyqBGPbc91rN/Opryv
         BiQ51IHf/Blb3dCUMq/zPUhNkW271h5y6lyBz5fc4lfPlcLPse89E3CRRX9/CjtpPi
         P4V37NsrHD//A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: fix leaked plug after failure syncing log on zoned filesystems
Date:   Wed,  6 Apr 2022 17:07:54 +0100
Message-Id: <7950a1a3db370ab5f38e8da4f43b002e11397b18.1649261167.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c766f439fa12967383d8e62c6f5883bd1f62c483.1649245880.git.fdmanana@suse.com>
References: <c766f439fa12967383d8e62c6f5883bd1f62c483.1649245880.git.fdmanana@suse.com>
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
allocation failure, which typically is either -ENOMEM or -ENOSPC, is not
fatal and the fsync can safely fallback to a full transaction commit.

So release the IO plug if we fail to allocate the extent buffer for the
root of the log root tree when syncing the log on a zoned filesystem.

Fixes: 3ddebf27fcd3a9 ("btrfs: zoned: reorder log node allocation on zoned filesystem")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Fixed typo in the subject, updated changelog.

 fs/btrfs/tree-log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 273998153fcc..1fa21cfe059d 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3188,6 +3188,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 			ret = btrfs_alloc_log_tree_node(trans, log_root_tree);
 			if (ret) {
 				mutex_unlock(&fs_info->tree_root->log_mutex);
+				blk_finish_plug(&plug);
 				goto out;
 			}
 		}
-- 
2.33.0

