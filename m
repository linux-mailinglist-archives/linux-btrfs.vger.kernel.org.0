Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B0C6EF2CE
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 12:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbjDZKxF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 06:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240494AbjDZKxD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 06:53:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7585D59C1
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 03:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E136A63553
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 10:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE87FC4339C
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 10:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682506302;
        bh=3X/izDcmETL8JT+IcQDvivqG3Fym+01bNfen1qFVlew=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jXWzuwzt4yCSPAxRkBGFWJylPfqOEshOv3OBAXM2oQcG2mzkcixToLYbilDujHD1V
         ULImDLL0r7PQwJ2ZjWnLK0KlKfCCSZQMbS9L0WfRYgDt2zn0o9R9HwGXvOS1mm80nj
         CdgK0hy54VCta1Seq0h46fUo7zdC31RsPieXwprlQhduhA30oh20Q0xbJY+2Z9vE25
         0v/Zr6UJn36e1X3Q5xlFTbbc/SRojCyOHfM+2sekiP9kXSm/h6gBpN4XAEAYPuUQXf
         rOXElIVoRPO9MbtbRa/PnLHR6EKGn0p6hz7zGWhx8M7tDAaVjJj5Hyh1WTbxlJkuiB
         SzcCfqykZSLcA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: print extent buffers when sibling keys check fails
Date:   Wed, 26 Apr 2023 11:51:36 +0100
Message-Id: <14f4089a9d26606c7a15e398536ca75f9c484c9c.1682505780.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1682505780.git.fdmanana@suse.com>
References: <cover.1682505780.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When trying to move keys from one node/leaf to another sibling node/leaf,
if the sibling keys check fails we just print an error message with the
last key of the left sibling and the first key of the right sibling.
However it's also useful to print all the keys of each sibling, as it
may provide some clues to what went wrong, which code path may be
inserting keys in an incorrect order. So just do that, print the siblings
with btrfs_print_tree(), as it works for both leaves and nodes.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a0b97a6d075a..a061d7092369 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2708,6 +2708,10 @@ static bool check_sibling_keys(struct extent_buffer *left,
 	}
 
 	if (btrfs_comp_cpu_keys(&left_last, &right_first) >= 0) {
+		btrfs_crit(left->fs_info, "left extent buffer:");
+		btrfs_print_tree(left, false);
+		btrfs_crit(left->fs_info, "right extent buffer:");
+		btrfs_print_tree(right, false);
 		btrfs_crit(left->fs_info,
 "bad key order, sibling blocks, left last (%llu %u %llu) right first (%llu %u %llu)",
 			   left_last.objectid, left_last.type,
-- 
2.34.1

