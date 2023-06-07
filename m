Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BEA7269AD
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 21:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjFGTZA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 15:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjFGTYs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 15:24:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560FE1FDA
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 12:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 363C063C4E
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 19:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216B4C433D2
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 19:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686165887;
        bh=3DidI0i/RwWQuUG2o1GFYdZnklwi7zqjo1MjYCu98mA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Yn7FP7+n2WVf/NxwyAu0JA9cpcnhj6DfkADKMw1BQi7zcKWImhYoLmEyOq878dYgN
         cN7u+8hOEPFvEUCHnMQ9EV0VGqBWzM34oHUV3E6fQiI0DQSlacoADED5WvMO98ITJ6
         Gg0EwED7Mhp/ijooXjMRFnCTc8cMlFia6TXGucPAV1DC9l/FllVcsekPc80haXpSzC
         Lyk9CUHTCQmDNblu50D8hJRnwz393t3YG67CX3d+zP34RV2DxRw02+D/3Qk2Ox55QF
         62waQPmjzSE1PVGmyWrKD0tfHL1d96m7SqVKfWul2/QMTO1JD+KVBNe9Ykk/uTLQxc
         CctiB3J+zDiOw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/13] btrfs: avoid unnecessarily setting the fs to RO and error state at balance_level()
Date:   Wed,  7 Jun 2023 20:24:31 +0100
Message-Id: <eed7a234bcbf584a4199b9b84d0e3e8927e2f077.1686164814.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686164789.git.fdmanana@suse.com>
References: <cover.1686164789.git.fdmanana@suse.com>
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

At balance_level(), when trying to promote a child node to a root node, if
we fail to read the child we call btrfs_handle_fs_error(), which turns the
fs to RO mode and sets it to error state as well, causing any ongoing
transaction to abort. This however is not necessary because at that point
we have not made any change yet at balance_level(), so any error reading
the child node does not leaves us in any inconsistent state. Therefore we
can just return the error to the caller.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index e98f9e205e25..4dcdcf25c3fe 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1040,7 +1040,6 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		child = btrfs_read_node_slot(mid, 0);
 		if (IS_ERR(child)) {
 			ret = PTR_ERR(child);
-			btrfs_handle_fs_error(fs_info, ret, NULL);
 			goto out;
 		}
 
-- 
2.34.1

