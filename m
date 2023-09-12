Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801BD79D0A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 14:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbjILMEy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 08:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbjILMEp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 08:04:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8227710D2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 05:04:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6343C433C7
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 12:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694520281;
        bh=3pNzE7A94CNt36pJ3NPac0NN6y3mTQgiIFBkPFYOGcs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=g3SzGNOkv/F2k0mMdudO+FGF0Gtfy28WZ93/ieAw4ZzFex325Mq3eRHBhDI0NDCpw
         ys60nribUmPAbmS8JssfCGFfg3MePwDhFAhe+lF1OA4TLl0xgvvhFJbiu7TidadDjj
         hhqbHBKpVD61h3AAGmdGXKyNcgi9W0FqlkwvOQMHvfL804XsopZxj+6O/71BnLiJZd
         y/iAJbesKD/CPgbKikamoz3a4EU1rTAoI6auqsDABHNg91wLi26nZC9/C8E4eRiB+q
         LbevgriQuWrr4pXh44E0JUXBZnoOb+98loohm7JBx93UXqz5pRLwRbgeQlHo+ugKgD
         9jD6SeOwQWfYg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: mark transaction id check as unlikely at btrfs_mark_buffer_dirty()
Date:   Tue, 12 Sep 2023 13:04:31 +0100
Message-Id: <fbe818ae8d68519e419b53ba847ab7ac70285f13.1694519544.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694519543.git.fdmanana@suse.com>
References: <cover.1694519543.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_mark_buffer_dirty(), having a transaction id mismatch is never
expected to happen and it usually means there's a bug or some memory
corruption due to a bitflip for example. So mark the condition as unlikely
to optimize code generation as well as to make it obvious for human
readers that it is a very unexpected condition.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d906368a2d3f..163f37ad1b27 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4403,7 +4403,7 @@ void btrfs_mark_buffer_dirty(struct btrfs_trans_handle *trans,
 	/* This is an active transaction (its state < TRANS_STATE_UNBLOCKED). */
 	ASSERT(trans->transid == fs_info->generation);
 	btrfs_assert_tree_write_locked(buf);
-	if (transid != fs_info->generation) {
+	if (unlikely(transid != fs_info->generation)) {
 		btrfs_abort_transaction(trans, -EUCLEAN);
 		btrfs_crit(fs_info,
 "dirty buffer transid mismatch, logical %llu found transid %llu running transid %llu",
-- 
2.40.1

