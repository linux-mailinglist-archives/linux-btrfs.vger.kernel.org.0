Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C27614EF7
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 17:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKAQQH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 12:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKAQQF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 12:16:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D851C903
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 09:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F18C0B81D9F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F77C43470
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667319360;
        bh=sy8AWqXshzSDW/g0k8y2ZkyclJ8C551aRGLu3Z4hfYo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=f6+ZXZbCwM3Gs7d10CC/P5j4wowmK31tBClG7bzcjtYT9MG1tX4Z0pJWtFNmKGNja
         fyaQfVUcBh67SfhfSOeqIm2r3cfS6qliCqblieGBjfkNQklkfruACSO/AHnPCoMyGc
         sB6IpTPrwg6rggSeQP2sLNiuNgg1/OSecmDL5u2Komfnnhve+dJSLltuI4q4oRcBGu
         dTr9Y0CuqJp3LnuK2gHgYEyjDPFPMh2gbfkMJpv/WdgOx7U039SIRjDCxyNdi57WGx
         synyuzLyMplXMk83tTBmwEAzIWkdFDfUFmuIpGLjmU7EfBk3KWOHYxcgk/IMK9QVn+
         uSzxD/R12slrA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/18] btrfs: fix ulist leaks in error paths of qgroup self tests
Date:   Tue,  1 Nov 2022 16:15:39 +0000
Message-Id: <7716b3fb040152c7dcd4531a0ddc8c1abae31ac0.1667315100.git.fdmanana@suse.com>
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

In the test_no_shared_qgroup() and test_multiple_refs() qgroup self tests,
if we fail to add the tree ref, remove the extent item or remove the
extent ref, we are returning from the test function without freeing the
"old_roots" ulist that was allocated by the previous calls to
btrfs_find_all_roots(). Fix that by calling ulist_free() before returning.

Fixes: 442244c96332 ("btrfs: qgroup: Switch self test to extent-oriented qgroup mechanism.")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tests/qgroup-tests.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index 94b04f10f61c..96a70ce36f79 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -234,8 +234,10 @@ static int test_no_shared_qgroup(struct btrfs_root *root,
 
 	ret = insert_normal_tree_ref(root, nodesize, nodesize, 0,
 				BTRFS_FS_TREE_OBJECTID);
-	if (ret)
+	if (ret) {
+		ulist_free(old_roots);
 		return ret;
+	}
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
 	if (ret) {
@@ -268,8 +270,10 @@ static int test_no_shared_qgroup(struct btrfs_root *root,
 	}
 
 	ret = remove_extent_item(root, nodesize, nodesize);
-	if (ret)
+	if (ret) {
+		ulist_free(old_roots);
 		return -EINVAL;
+	}
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
 	if (ret) {
@@ -331,8 +335,10 @@ static int test_multiple_refs(struct btrfs_root *root,
 
 	ret = insert_normal_tree_ref(root, nodesize, nodesize, 0,
 				BTRFS_FS_TREE_OBJECTID);
-	if (ret)
+	if (ret) {
+		ulist_free(old_roots);
 		return ret;
+	}
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
 	if (ret) {
@@ -364,8 +370,10 @@ static int test_multiple_refs(struct btrfs_root *root,
 
 	ret = add_tree_ref(root, nodesize, nodesize, 0,
 			BTRFS_FIRST_FREE_OBJECTID);
-	if (ret)
+	if (ret) {
+		ulist_free(old_roots);
 		return ret;
+	}
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
 	if (ret) {
@@ -403,8 +411,10 @@ static int test_multiple_refs(struct btrfs_root *root,
 
 	ret = remove_extent_ref(root, nodesize, nodesize, 0,
 				BTRFS_FIRST_FREE_OBJECTID);
-	if (ret)
+	if (ret) {
+		ulist_free(old_roots);
 		return ret;
+	}
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
 	if (ret) {
-- 
2.35.1

