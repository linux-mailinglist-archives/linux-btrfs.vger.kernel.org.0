Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBE8763BC1
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 17:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjGZP5W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 11:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjGZP5U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 11:57:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AC92109
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 08:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD4E861AFE
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6373C433C7
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387039;
        bh=SrGPtFDNjcbHCCbLbqOkljbaKbEWwqxh3HAo0VDtYZ4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uvlSMVVad+4TtQNJ58VjYFX9QPRhTWgfiAG6Egrd51Qp+eUuzv9piq2oSmz6ap59q
         2R4fbKgYgxcaKX0xJmWI8XU3noLc9J/3eh7mX6ovTlHn4Izr3UMgDRNFpyrRfgqdz4
         098F3nBxyeaQcZNQ3644o7kHHes0Gbh4jMGnIWZUqqDgy4dhPQKc7rrAjSrF8dGv0z
         89x9xYhkqlrXtN3JE83nznoOu3hz+x6/3a5t5A7IMSyL3yuBPi5R/HrjQo7is/YHO5
         6N1Nj01+eXKqX+9P5uv+3mw+a5FdChaA/CKUsqM9Ja8LKLgZdV0FDEWQ1HXqMUY5NK
         oqnU8vOX70Qbg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/17] btrfs: update comment for btrfs_join_transaction_nostart()
Date:   Wed, 26 Jul 2023 16:56:58 +0100
Message-Id: <cd80172993342862643d7f941a097c43902776b3.1690383587.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690383587.git.fdmanana@suse.com>
References: <cover.1690383587.git.fdmanana@suse.com>
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

Update the comment for btrfs_join_transaction_nostart() to be more clear
about how it works and how it's different from btrfs_attach_transaction().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 6a2a12593183..ab09542f2170 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -799,7 +799,10 @@ struct btrfs_trans_handle *btrfs_join_transaction_spacecache(struct btrfs_root *
 
 /*
  * Similar to regular join but it never starts a transaction when none is
- * running or after waiting for the current one to finish.
+ * running or when there's a running one at a state >= TRANS_STATE_UNBLOCKED.
+ * This is similar to btrfs_attach_transaction() but it allows the join to
+ * happen if the transaction commit already started but it's not yet in the
+ * "doing" phase (the state is < TRANS_STATE_COMMIT_DOING).
  */
 struct btrfs_trans_handle *btrfs_join_transaction_nostart(struct btrfs_root *root)
 {
-- 
2.34.1

