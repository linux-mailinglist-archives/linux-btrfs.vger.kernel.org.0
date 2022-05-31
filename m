Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782CB53939D
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344879AbiEaPHC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 11:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345497AbiEaPG6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 11:06:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39D110D
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 08:06:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 801916132A
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67064C3411F
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654009616;
        bh=Kul8JZIfoT2xuD+DWxVbAsFOrY83Hi9Ndy+v7UrJCvw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YSC6KQiSEjYNjfA9PJfCxDZFQg9vdAdEMfS/7CSW8tcWFddpjn4yWaG76UddDGy7K
         Z+kD7lz3wUH0AuhLo2q9PRoUDdqPhgubfB/oT/TW36hKxSgF0vg+aKEPjuh7naw1xC
         CUDQAyCJ5x5MdpQF0aqUHnqlnP/9rWN2/heKTXyzmtHXcq+8hJ7Ks+1UahpJoXVuec
         u/gNp+tkMPIY8Hk3nI1s/OU8aDrob8fqqBJmwBDjwaN00e2uJpU+JhxNdIkjEKJY1O
         Ob4hGkASFoi9x9G3GEVDDmI3fmkksTstiSwlEzUBX6US/LLV2lwaDSBQTmGuw9qhcE
         v8EilObRl7rrA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/12] btrfs: do not BUG_ON() on failure to reserve metadata for delayed item
Date:   Tue, 31 May 2022 16:06:41 +0100
Message-Id: <31228088666135f5b52eb5cfbabf72b955d754ae.1654009356.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1654009356.git.fdmanana@suse.com>
References: <cover.1654009356.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_insert_delayed_dir_index(), we don't expect the metadata
reservation for the delayed dir index item insertion to fail, because the
caller is supposed to have reserved 1 unit of metadata space for that.
All callers are able to deal with an error in case that happens, so there
is no need for something so drastic as a BUG_ON() in case of failure.
Instead just emit a warning, so that's easily noticed during development
(fstests in particular), and return the error to the caller.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 2ad2a105244c..b6fee8f0f1cd 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1379,10 +1379,13 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_delayed_item_reserve_metadata(trans, dir->root, delayed_item);
 	/*
-	 * we have reserved enough space when we start a new transaction,
-	 * so reserving metadata failure is impossible
+	 * Space was reserved for a dir index item insertion when we started the
+	 * transaction, so getting a failure here should be impossible.
 	 */
-	BUG_ON(ret);
+	if (WARN_ON(ret)) {
+		btrfs_release_delayed_item(delayed_item);
+		goto release_node;
+	}
 
 	mutex_lock(&delayed_node->mutex);
 	ret = __btrfs_add_delayed_insertion_item(delayed_node, delayed_item);
-- 
2.35.1

