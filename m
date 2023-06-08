Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D404F727CC6
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 12:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbjFHK2J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 06:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbjFHK2D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 06:28:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BA8272D
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 03:28:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 676B660A13
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E06CC4339B
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686220079;
        bh=3DidI0i/RwWQuUG2o1GFYdZnklwi7zqjo1MjYCu98mA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=doelEIsUFe2BVRx83eF8jjdgP2I7unS0xAYxpo371CuHP+toBzKfR5cuYyCQxYA7r
         Zpmp+4MJuXtHSqb4RWC/FEXpet4O1x7k5B4SdsvfMjOxz+8Y8zNZXXsejI/mYWSJ0R
         tFSOJ4SecK7sPWGd8+I+JdoLReNxSG9kK4t+xpZz06RwlllpdZQL1FnfGQXx5VSiyv
         89R4HpX3i4wHeUYlKaEWfEMV/BHT3E+zhfRoiI4ImsL+DMvseDHciwx/hvbgsqZJ8K
         Z6hep0PCPcq2/RoqG9lxNrkoEom/5K5W7u11aNbUPUyoNu5IEqJopdnR1+OzKG5acX
         C9lRTrCnZkvkg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 07/13] btrfs: avoid unnecessarily setting the fs to RO and error state at balance_level()
Date:   Thu,  8 Jun 2023 11:27:43 +0100
Message-Id: <f566e1432b19f82d9c647b1c0e8e43743818bd7a.1686219923.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686219923.git.fdmanana@suse.com>
References: <cover.1686219923.git.fdmanana@suse.com>
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

