Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F4E614F08
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 17:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiKAQQU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 12:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiKAQQS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 12:16:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCEA1C92F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 09:16:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F794B81E6C
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21E8C433C1
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667319374;
        bh=tCqVCr31IoLZDNDBYNZprNyEgJm3UyVqNWvFZBh4Uws=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ujH9fwRv1Ugsf1nMcgZgapG7MY2leOkQIgzn+99AD0Pv5gmmv+67GEbIBQkgUl3uo
         zXKVWuvFN7UgCywJCU5qycwCeeG5AVjLEOoKoEwMZRTn2gkRmCGp69vs46nfvn100G
         qmmd9paZdm+bL0o7uGN54MyJ4KV3+iPd7zQcDFe9Lmrm8xPl24OntLzeidvXkB/Oek
         wuRjMaTf6UmnyhR7Qw/8OLHNgsAvlwUOs8xLxc2TqNOnyS9NuSN0nUXgCYvpVTFCku
         c84s4Mgx5LIDavktbDoIGSlKxBBx+ZHyx5hFIZMAVs+MpjRBFwR9w3FDND7bC75Nh0
         Xh2TEur8ix1gA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 18/18] btrfs: send: bump the extent reference count limit for backref walking
Date:   Tue,  1 Nov 2022 16:15:54 +0000
Message-Id: <da7dff094eead7ccc0cb1cd186c767d48c8ae05d.1667315100.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667315100.git.fdmanana@suse.com>
References: <cover.1667315100.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

After the previous patchset which is comprised of the following patches:

  01/17 btrfs: fix inode list leak during backref walking at resolve_indirect_refs()
  02/17 btrfs: fix inode list leak during backref walking at find_parent_nodes()
  03/17 btrfs: fix ulist leaks in error paths of qgroup self tests
  04/17 btrfs: remove pointless and double ulist frees in error paths of qgroup tests
  05/17 btrfs: send: avoid unnecessary path allocations when finding extent clone
  06/17 btrfs: send: update comment at find_extent_clone()
  07/17 btrfs: send: drop unnecessary backref context field initializations
  08/17 btrfs: send: avoid unnecessary backref lookups when finding clone source
  09/17 btrfs: send: optimize clone detection to increase extent sharing
  10/17 btrfs: use a single argument for extent offset in backref walking functions
  11/17 btrfs: use a structure to pass arguments to backref walking functions
  12/17 btrfs: reuse roots ulist on each leaf iteration for iterate_extent_inodes()
  13/17 btrfs: constify ulist parameter of ulist_next()
  14/17 btrfs: send: cache leaf to roots mapping during backref walking
  15/17 btrfs: send: skip unnecessary backref iterations
  16/17 btrfs: send: avoid double extent tree search when finding clone source
  17/17 btrfs: send: skip resolution of our own backref when finding clone source

we have now much better performance when doing backref walking in the send
code, so we can increase the current limit from 64 to 1024 references.
This limit is still a bit conservative because there are still edge cases
where backref walking will be too slow and spend a lot of cpu time, some IO
reading b+tree nodes/leaves and memory. The goal is to eventually get rid
of any limit, but for now bump it as it benefits users with extents shared
more than 64 times and up to 1024 times, allowing for more deduplication
at the destination without having to run a dedupe tool after a receive.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 1bcbe386a24b..6950d3f9cbc1 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -39,7 +39,7 @@
  * avoid hitting limitations of the backreference walking code (taking a lot of
  * time and using too much memory for extents with large number of references).
  */
-#define SEND_MAX_EXTENT_REFS	64
+#define SEND_MAX_EXTENT_REFS	1024
 
 /*
  * A fs_path is a helper to dynamically build path names with unknown size.
-- 
2.35.1

