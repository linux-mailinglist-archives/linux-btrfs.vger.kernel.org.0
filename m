Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BFD763BBD
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 17:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjGZP5U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 11:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjGZP5U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 11:57:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42472212B
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 08:57:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CABD161A21
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F5EC433C9
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387038;
        bh=eOt4UOjAKikqABXmdlpsoRa/3r7NrEXpHWtjIynBjTw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gPMV/EjgdQrBF/aOUlWWkmGx/x41VM6SE/fF5wy0v/YfUVgWTAzFU4b1EAyOgDFyi
         7ZMAFMArbb7ZAKFEVi2bM1FJyDOwT8xL8yXrgUtNmPsMBiqJpiaeqkgblNZaAq583Z
         UODEO1lfr7+e904HcghE9p0jYHG3hwGYO6TGIbjEW5Ra6k5cn2sLCsfS7wOgkhzyli
         /BWU/kd3i/zyjipggWuGRg+Wmo4Rw5bwJrUJUm5wq1/9HJlBqUpvT95hA5NDtO+xxi
         Hn8hMtKqeue3+LlpbofRhtr+pu8QNZ7k5jAx5AvsmqDnAa3kbBT9ClnLgw1nJoubbk
         5Mk308hIw3kPg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/17] btrfs: don't start transaction when joining with TRANS_JOIN_NOSTART
Date:   Wed, 26 Jul 2023 16:56:57 +0100
Message-Id: <5abf5077aa70cc94346cc56b98fcd89ffde38efd.1690383587.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690383587.git.fdmanana@suse.com>
References: <cover.1690383587.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When joining a transaction with TRANS_JOIN_NOSTART, if we don't find a
running transaction we end up creating one. This goes against the purpose
of TRANS_JOIN_NOSTART which is to join a running transaction if its state
is at or below the state TRANS_STATE_COMMIT_START, otherwise return an
-ENOENT error and don't start a new transaction. So fix this to not create
a new transaction if there's no running transaction at or below that
state.

Fixes: a6d155d2e363 ("Btrfs: fix deadlock between fiemap and transaction commits")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 815f61d6b506..6a2a12593183 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -292,10 +292,11 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	spin_unlock(&fs_info->trans_lock);
 
 	/*
-	 * If we are ATTACH, we just want to catch the current transaction,
-	 * and commit it. If there is no transaction, just return ENOENT.
+	 * If we are ATTACH or TRANS_JOIN_NOSTART, we just want to catch the
+	 * current transaction, and commit it. If there is no transaction, just
+	 * return ENOENT.
 	 */
-	if (type == TRANS_ATTACH)
+	if (type == TRANS_ATTACH || type == TRANS_JOIN_NOSTART)
 		return -ENOENT;
 
 	/*
-- 
2.34.1

