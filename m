Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C2F4BF456
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 10:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiBVJGH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 04:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiBVJGG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 04:06:06 -0500
Received: from eu-shark1.inbox.eu (eu-shark1.inbox.eu [195.216.236.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD2B14866A
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 01:05:41 -0800 (PST)
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id C2CDB6C007F4;
        Tue, 22 Feb 2022 11:05:39 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1645520739; bh=uuGCUF3WSPyKRYWQAjezxIdb/rfFV6KSOEkjwxHAoKk=;
        h=From:To:Cc:Subject:Date:Message-Id:X-ESPOL:from:date:to:cc;
        b=gQYFHUy5qltQwR7hts7N8Tm7YwEdG5GVRrwDM2nuQ08yYYmadBqbr6TgxQABouPTO
         ADWT00DtIoMeMCLPv83Mya5eAU+Q+5AYOu3oiom3UnHgh5CiuJZyoX3TNVNsqslqEV
         mZOG+kqgYdY4zn8cc66jTypmvptRueGRT7DtBtRM=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id B408D6C007EF;
        Tue, 22 Feb 2022 11:05:39 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 4OgDl3krHa_R; Tue, 22 Feb 2022 11:05:39 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 611146C007EA;
        Tue, 22 Feb 2022 11:05:39 +0200 (EET)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <l@damenly.su>, Wenqing Liu <wenqingliu0120@gmail.com>
Subject: [PATCH] btrfs-progs: save item data end in u64 to avoid overflow in btrfs_check_leaf()
Date:   Tue, 22 Feb 2022 17:05:28 +0800
Message-Id: <20220222090528.1211-1-l@damenly.su>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: 6N1ml5Y9aTPe6kLSPXaeWkYrzV5EXevl+uWy0xxdmmeDUSOFfksTURS1g21yTGK6vjYX
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Similar to kernel check_leaf(), calling btrfs_item_end_nr() may get a
reasonable value even an item has invalid offset/size due to u32
overflow.

Fix it by use u64 variable to store item data end in btrfs_check_leaf()
to avoid u32 overflow.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215299
Reported-by: Wenqing Liu <wenqingliu0120@gmail.com>
Signed-off-by: Su Yue <l@damenly.su>
---
 kernel-shared/ctree.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 950923d03165..8440e55ee280 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -706,6 +706,7 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
 	 */
 	for (slot = 0; slot < nritems; slot++) {
 		u32 item_end_expected;
+		u64 item_data_end;
 
 		btrfs_item_key_to_cpu(leaf, &key, slot);
 
@@ -720,6 +721,8 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
 			goto fail;
 		}
 
+		item_data_end = (u64)btrfs_item_offset_nr(leaf, slot) +
+				btrfs_item_size_nr(leaf, slot);
 		/*
 		 * Make sure the offset and ends are right, remember that the
 		 * item data starts at the end of the leaf and grows towards the
@@ -730,11 +733,10 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
 		else
 			item_end_expected = btrfs_item_offset_nr(leaf,
 								 slot - 1);
-		if (btrfs_item_end_nr(leaf, slot) != item_end_expected) {
+		if (item_data_end != item_end_expected) {
 			generic_err(leaf, slot,
-				"unexpected item end, have %u expect %u",
-				btrfs_item_end_nr(leaf, slot),
-				item_end_expected);
+				"unexpected item end, have %llu expect %u",
+				item_data_end, item_end_expected);
 			ret = BTRFS_TREE_BLOCK_INVALID_OFFSETS;
 			goto fail;
 		}
@@ -744,12 +746,10 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
 		 * just in case all the items are consistent to each other, but
 		 * all point outside of the leaf.
 		 */
-		if (btrfs_item_end_nr(leaf, slot) >
-		    BTRFS_LEAF_DATA_SIZE(fs_info)) {
+		if (item_data_end > BTRFS_LEAF_DATA_SIZE(fs_info)) {
 			generic_err(leaf, slot,
-			"slot end outside of leaf, have %u expect range [0, %u]",
-				btrfs_item_end_nr(leaf, slot),
-				BTRFS_LEAF_DATA_SIZE(fs_info));
+			"slot end outside of leaf, have %llu expect range [0, %u]",
+				item_data_end, BTRFS_LEAF_DATA_SIZE(fs_info));
 			ret = BTRFS_TREE_BLOCK_INVALID_OFFSETS;
 			goto fail;
 		}
-- 
2.34.1

