Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770A84E563D
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 17:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245449AbiCWQVR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 12:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240527AbiCWQVO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 12:21:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A1F70044
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 09:19:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6C4261849
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4319C340E8
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648052384;
        bh=5Qn0Q7fUWy3DBwbpO+1flITSAjTeP3Nw5rQ/Xy6lRkg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=by/NkpZCODOa8lmX17bA0Nl6VdbPnwW5TgsXtCyqBgf3NCMXEw+Wj4VA5OJonF4iV
         J9LMYhd1YW3ES9Ui8m9zE+wmaoNs7QyM9Da4awklYV47exXs4S1gCBhnVnP3GcJdCe
         pW/Kb317l3zMj/aHIimm/SuLgQaZxOYnHM4D18DvlREE6mrokQZBa5JSfN6P7atC3U
         e4XbKfsMFv/n1sKc74ylzMLDWl2YzZ4rWF/WDUkEsCkOh45y/BMg8bgliheH79ou3u
         eV/zLToPCYVbbQ4WDUBolrbpUCFZ8bejBVodGqf8wI1nUR4/ZIB5M3Ktdyjjygbjyh
         yS/zDqhHa5yZA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: free path at can_nocow_extent() before checking for checksum items
Date:   Wed, 23 Mar 2022 16:19:27 +0000
Message-Id: <c8662c2ad3f67c540050ef24aa2e670aaafeb2da.1648051583.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648051582.git.fdmanana@suse.com>
References: <cover.1648051582.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we look for checksum items, through csum_exist_in_range(), at
can_nocow_extent(), we no longer need the path that we have previously
allocated. Through csum_exist_in_range() -> btrfs_lookup_csums_range(),
we also end up allocating a path, so we are adding unnecessary extra
memory usage. So free the path before calling csum_exist_in_range().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f185d8f8b7fe..d7d7a28539a9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7234,6 +7234,14 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 		goto out;
 	}
 
+	/*
+	 * We don't need the path anymore, plus through the csum_exist_in_range()
+	 * call below we will end up allocating another path. So free the path
+	 * to avoid unnecessary extra memory usage.
+	 */
+	btrfs_free_path(path);
+	path = NULL;
+
 	/*
 	 * adjust disk_bytenr and num_bytes to cover just the bytes
 	 * in this extent we are about to write.  If there
-- 
2.33.0

