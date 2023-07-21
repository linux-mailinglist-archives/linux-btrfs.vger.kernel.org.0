Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBDC75C3AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 11:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjGUJvg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 05:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjGUJvK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 05:51:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF00D44A7
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 02:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 996CD60C66
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E04C433C8
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689932969;
        bh=nlcCIRRu/CDBbsa4CPZBOy4p+CdLWsq4kXcNRDqUo+I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Hzd3Ho/dBBtrf9bKJ7ps0ZFBggmvKguErNB2bprwlzF3TsUwU17KKubKJV545P9tt
         tLmBaoT2lsG7fvckWhCv1q1bvpkDFHj34nfoBOXnMYQewFUgfQVfMQfXIxcDeenYg8
         NkVNOgJ+QeTNHbfBVUcV7vdaDkzNTQtXLbMNVO7TMOfwgYM8k6cbmn9v3yFjgMfoqY
         esdojSg42OgXTUk/vDMhPfhaYz4TMl+IF50BaacuMDHsL+lfA4dtqcnE14a7zeCXuD
         nDCQ27nPJJ0LpdiGIMF2QRYh0dm1kbQFofrqJjT2Ih/URMS5Hg6tl/64u4RhRZxupx
         eWu0UriGojogg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: check if the transaction was aborted at btrfs_wait_for_commit()
Date:   Fri, 21 Jul 2023 10:49:20 +0100
Message-Id: <ef39d239a3d444a4a9788d5690c7f570ba6b8d52.1689932501.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689932501.git.fdmanana@suse.com>
References: <cover.1689932501.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_wait_for_commit() we wait for a transaction to finish and then
always return 0 (success) without checking if it was aborted, in which
case the transaction didn't happen due to some critical error. Fix this
by checking if the transaction was aborted.

Fixes: 462045928bda ("Btrfs: add START_SYNC, WAIT_SYNC ioctls")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 4743882fa94b..8ab85465cdaa 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -931,6 +931,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid)
 	}
 
 	wait_for_commit(cur_trans, TRANS_STATE_COMPLETED);
+	ret = cur_trans->aborted;
 	btrfs_put_transaction(cur_trans);
 out:
 	return ret;
-- 
2.34.1

