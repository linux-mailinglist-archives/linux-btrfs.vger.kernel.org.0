Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B411614584
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 09:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiKAIP6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 04:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKAIP5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 04:15:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06578EE0D
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 01:15:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9185EB81BED
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 08:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E399FC433C1;
        Tue,  1 Nov 2022 08:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667290553;
        bh=3MeC3C26/0oUdO/2KnwfimEkW2nF08x3dve2Cw/PgGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fYpwVXmNCqs4sh4YaIB0CtLDbhNuvAnn7MtI7kT9RPdfKhx8MnOGn/H3Q59YghojF
         MnuNyPwR9GWDLsqAQG+NgVZ3nYjvB8vWoDwaGc10Zbi2z1CWHhi9Fr4Kg+R07ajQgu
         nfdjmAeTmZm2nX1HtlXauYn23N+VaYj43zdX1q6NnZFjvKi1DCmpN/Y3/dWSm+uGeg
         3Ukoe8YIZmfHTbswwFmhkP2tqdrAJloiPomcBAuVP3kKxSQKqSDeynnO1/8SqgV0p3
         O1vb8ZJbT3H5SD2+iACc3An6SY5oZiRrHM2M5Q/Y8l4v4xAAU6N5m0FFLX14VXXdXG
         NuQ/RUC+Q8VPQ==
Date:   Tue, 1 Nov 2022 08:15:50 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Subject: Re: [PATCH 3/3] btrfs: Fix ulist memory leak in test_multiple_refs()
Message-ID: <20221101081550.GA3418818@falcondesktop>
References: <20221101025356.1643836-1-zhangxiaoxu5@huawei.com>
 <20221101025356.1643836-4-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101025356.1643836-4-zhangxiaoxu5@huawei.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 01, 2022 at 10:53:56AM +0800, Zhang Xiaoxu wrote:
> There are some meory leak report when do sanity tests:
> 
>   unreferenced object 0xffff888296ab40c0 (size 32):
>     comm "insmod", pid 76176, jiffies 4307414230 (age 309.541s)
>     hex dump (first 32 bytes):
>       01 00 00 00 00 00 00 00 90 8a b1 30 81 88 ff ff  ...........0....
>       90 8a b1 30 81 88 ff ff a0 8a b1 30 81 88 ff ff  ...0.......0....
>     backtrace:
>       [<00000000e59989d0>] kmalloc_trace+0x27/0xa0
>       [<00000000836cc910>] ulist_alloc+0x55/0xe0 [btrfs]
>       [<00000000eb3781d2>] btrfs_find_all_roots_safe+0x9d/0x1c0 [btrfs]
>       [<00000000c7fe3cc7>] test_no_shared_qgroup.constprop.0+0x1f2/0x350 [btrfs]
>       [<00000000f6a6b761>] btrfs_test_qgroups+0x2c8/0x300 [btrfs]
>       [<0000000047d4f295>] btrfs_run_sanity_tests.cold+0x5c/0xd5 [btrfs]
>       [<00000000b09fac49>] init_btrfs_fs+0xec/0x154 [btrfs]
>       [<000000002925cdf3>] do_one_initcall+0x87/0x2a0
>       [<00000000c5ed267e>] do_init_module+0xdf/0x320
>       [<000000005f972694>] load_module+0x3006/0x3390
>       [<0000000070c88d9a>] __do_sys_finit_module+0x113/0x1b0
>       [<00000000e7029c2b>] do_syscall_64+0x35/0x80
>       [<000000008ffc1dab>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>   unreferenced object 0xffff888130b18a80 (size 64):
>     comm "insmod", pid 76176, jiffies 4307414230 (age 309.542s)
>     hex dump (first 32 bytes):
>       05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>       c8 40 ab 96 82 88 ff ff c8 40 ab 96 82 88 ff ff  .@.......@......
>     backtrace:
>       [<00000000e59989d0>] kmalloc_trace+0x27/0xa0
>       [<00000000de27bc34>] ulist_add_merge.part.0+0x67/0x1f0 [btrfs]
>       [<00000000fbdf3c21>] find_parent_nodes+0xd49/0x2880 [btrfs]
>       [<00000000ba4d2155>] btrfs_find_all_roots_safe+0x120/0x1c0 [btrfs]
>       [<00000000c7fe3cc7>] test_no_shared_qgroup.constprop.0+0x1f2/0x350 [btrfs]
>       [<00000000f6a6b761>] btrfs_test_qgroups+0x2c8/0x300 [btrfs]
>       [<0000000047d4f295>] btrfs_run_sanity_tests.cold+0x5c/0xd5 [btrfs]
>       [<00000000b09fac49>] init_btrfs_fs+0xec/0x154 [btrfs]
>       [<000000002925cdf3>] do_one_initcall+0x87/0x2a0
>       [<00000000c5ed267e>] do_init_module+0xdf/0x320
>       [<000000005f972694>] load_module+0x3006/0x3390
>       [<0000000070c88d9a>] __do_sys_finit_module+0x113/0x1b0
>       [<00000000e7029c2b>] do_syscall_64+0x35/0x80
>       [<000000008ffc1dab>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>   unreferenced object 0xffff88812ae83100 (size 32):
>     comm "insmod", pid 77664, jiffies 4307625383 (age 98.396s)
>     hex dump (first 32 bytes):
>       01 00 00 00 00 00 00 00 10 f7 7e 23 81 88 ff ff  ..........~#....
>       10 f7 7e 23 81 88 ff ff 20 f7 7e 23 81 88 ff ff  ..~#.... .~#....
>     backtrace:
>       [<00000000e59989d0>] kmalloc_trace+0x27/0xa0
>       [<00000000836cc910>] ulist_alloc+0x55/0xe0 [btrfs]
>       [<00000000eb3781d2>] btrfs_find_all_roots_safe+0x9d/0x1c0 [btrfs]
>       [<00000000cacfcca2>] test_multiple_refs.constprop.0+0x1e0/0x470 [btrfs]
>       [<000000008613167f>] btrfs_test_qgroups+0x2da/0x300 [btrfs]
>       [<0000000047d4f295>] btrfs_run_sanity_tests.cold+0x5c/0xd5 [btrfs]
>       [<00000000b09fac49>] init_btrfs_fs+0xec/0x154 [btrfs]
>       [<000000002925cdf3>] do_one_initcall+0x87/0x2a0
>       [<00000000c5ed267e>] do_init_module+0xdf/0x320
>       [<000000005f972694>] load_module+0x3006/0x3390
>       [<0000000070c88d9a>] __do_sys_finit_module+0x113/0x1b0
>       [<00000000e7029c2b>] do_syscall_64+0x35/0x80
>       [<000000008ffc1dab>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> Let's free the ulist memory when the no shared qgroup tests finish.
> 
> Fixes: 442244c96332 ("btrfs: qgroup: Switch self test to extent-oriented qgroup mechanism.")
> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>

There's still one ulist leak missing.
I actually had a similar patch here that is part of a much larger patchset
but I hadn't sent it yet. So find the difference:

From: Filipe Manana <fdmanana@suse.com>
Date: Fri, 14 Oct 2022 16:37:10 +0100
Subject: [PATCH 03/18] btrfs: fix ulist leaks in error paths of qgroup self
 tests

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



> ---
>  fs/btrfs/tests/qgroup-tests.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
> index 4172bef5b4a1..043b139cfb8c 100644
> --- a/fs/btrfs/tests/qgroup-tests.c
> +++ b/fs/btrfs/tests/qgroup-tests.c
> @@ -266,8 +266,10 @@ static int test_no_shared_qgroup(struct btrfs_root *root,
>  	}
>  
>  	ret = remove_extent_item(root, nodesize, nodesize);
> -	if (ret)
> +	if (ret) {
> +		ulist_free(old_roots);
>  		return -EINVAL;
> +	}
>  
>  	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
>  	if (ret) {
> @@ -329,8 +331,10 @@ static int test_multiple_refs(struct btrfs_root *root,
>  
>  	ret = insert_normal_tree_ref(root, nodesize, nodesize, 0,
>  				BTRFS_FS_TREE_OBJECTID);
> -	if (ret)
> +	if (ret) {
> +		ulist_free(old_roots);
>  		return ret;
> +	}
>  
>  	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
>  	if (ret) {
> @@ -365,8 +369,10 @@ static int test_multiple_refs(struct btrfs_root *root,
>  
>  	ret = add_tree_ref(root, nodesize, nodesize, 0,
>  			BTRFS_FIRST_FREE_OBJECTID);
> -	if (ret)
> +	if (ret) {
> +		ulist_free(old_roots);
>  		return ret;
> +	}
>  
>  	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
>  	if (ret) {
> @@ -407,8 +413,10 @@ static int test_multiple_refs(struct btrfs_root *root,
>  
>  	ret = remove_extent_ref(root, nodesize, nodesize, 0,
>  				BTRFS_FIRST_FREE_OBJECTID);
> -	if (ret)
> +	if (ret) {
> +		ulist_free(old_roots);
>  		return ret;
> +	}
>  
>  	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
>  	if (ret) {
> -- 
> 2.31.1
> 
