Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C37714CD4
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 17:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjE2PRV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 11:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjE2PRU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 11:17:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F29C4
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 08:17:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AFAE615E4
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85430C433D2
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685373439;
        bh=Dz36yvl1tm3i9aECWZ6I08lfiEyDbY+/qeaZccw5gYA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dXI+t4qPz3KH7wGKt3CTSBmnq6UzmagJi4qs1WUSAMORgufEn3Qjofa2neMET65DR
         7Igyt637GxfXiZj4w5DYhEnniY8FfHbizOHiOfNSdjExLuJf0dUGiYlX8hosnKDb05
         8uo1tNpJ+lWoYZyfxGN2YKTO/Y8sz8sUIMSLo8JwsiFB5Br/GyxoFVT7HsyNXvzYI6
         9a35i9+DZFg5dzcpiJCOwPXc7hbE5IuQyNKyCWUQtybfXDHRr8MZXt0+75lkPmQd6f
         pJWH8xtgbskJc6YAZa+2+GKp9rkg+kre9eX/RKlCCHT5UBiIw07qVGIdw3qqR5ubq9
         pqmcjP2NWTRiA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/11] btrfs: use a bool to track qgroup record insertion when adding ref head
Date:   Mon, 29 May 2023 16:17:00 +0100
Message-Id: <351306fd0efd24357c011e8d3d080953f9d63898.1685363099.git.fdmanana@suse.com>
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

We are using an integer as a boolean to track the qgroup record insertion
status when adding a delayed reference head. Since all we need is a
boolean, switch the type from int to bool to make it more obvious.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index d6dce5792c0f..0bcec428766c 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -762,11 +762,11 @@ static noinline struct btrfs_delayed_ref_head *
 add_delayed_ref_head(struct btrfs_trans_handle *trans,
 		     struct btrfs_delayed_ref_head *head_ref,
 		     struct btrfs_qgroup_extent_record *qrecord,
-		     int action, int *qrecord_inserted_ret)
+		     int action, bool *qrecord_inserted_ret)
 {
 	struct btrfs_delayed_ref_head *existing;
 	struct btrfs_delayed_ref_root *delayed_refs;
-	int qrecord_inserted = 0;
+	bool qrecord_inserted = false;
 
 	delayed_refs = &trans->transaction->delayed_refs;
 
@@ -776,7 +776,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 					delayed_refs, qrecord))
 			kfree(qrecord);
 		else
-			qrecord_inserted = 1;
+			qrecord_inserted = true;
 	}
 
 	trace_add_delayed_ref_head(trans->fs_info, head_ref, action);
@@ -872,7 +872,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	struct btrfs_delayed_ref_head *head_ref;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_qgroup_extent_record *record = NULL;
-	int qrecord_inserted;
+	bool qrecord_inserted;
 	bool is_system;
 	int action = generic_ref->action;
 	int level = generic_ref->tree_ref.level;
@@ -965,7 +965,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	struct btrfs_delayed_ref_head *head_ref;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_qgroup_extent_record *record = NULL;
-	int qrecord_inserted;
+	bool qrecord_inserted;
 	int action = generic_ref->action;
 	int ret;
 	u64 bytenr = generic_ref->bytenr;
-- 
2.34.1

