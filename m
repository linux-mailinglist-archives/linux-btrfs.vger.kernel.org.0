Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F67714CD8
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 17:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjE2PRi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 11:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjE2PRX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 11:17:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9517BC9
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 08:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 755FE615E4
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608F3C4339C
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685373441;
        bh=ZeYnw0hLiYn/FPymdlt6NnvBUqWGXjwIVP/K7IEhrzI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VTYuCzuXAQEsHlv5YDxdJLYKtPuirgZ+cryV+NAa5Z07wF1lyziyIaA4dSwDi3qZ+
         7CE2GloKQv0VqonaSILgSTc5Sdg8Og+bICE3MZlKlhNfg53zNZXS/mpBHpIfyd0men
         4JaopRjBqA5fe4s8Tdjn0KfKCnAmLmQJgDKiNSAALlrjvUaXpXatAJthZANFuYW5K8
         bqAlOzorBE+svU7xqm2WD9ON5XO/k03k9XE9AwDtQybm6iIeiZkf7Kv6ffjI3BWzfD
         a9KnrLCHhyHaXxTWB4wA/atsCXMAltXCxQiuCnaOS14PK0C+EpaYQFtauiYGl4Lizb
         xK2Goi6YtSGtw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/11] btrfs: assert correct lock is held at btrfs_select_ref_head()
Date:   Mon, 29 May 2023 16:17:03 +0100
Message-Id: <83affb7dc94093940cba2485afedb9d661191335.1685363099.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685363099.git.fdmanana@suse.com>
References: <cover.1685363099.git.fdmanana@suse.com>
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

The function btrfs_select_ref_head() iterates over the red black tree of
delayed reference heads, which is protected by the spinlock in the delayed
refs root. The function doesn't take the lock, it's taken by its single
caller, btrfs_obtain_ref_head(), because it needs to call that function
and btrfs_delayed_ref_lock() in the same critical section (delimited by
that spinlock). So assert at btrfs_select_ref_head() that we are holding
the expected lock.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index e4579e66a57a..c61af9012a82 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -506,6 +506,7 @@ struct btrfs_delayed_ref_head *btrfs_select_ref_head(
 {
 	struct btrfs_delayed_ref_head *head;
 
+	lockdep_assert_held(&delayed_refs->lock);
 again:
 	head = find_ref_head(delayed_refs, delayed_refs->run_delayed_start,
 			     true);
-- 
2.34.1

