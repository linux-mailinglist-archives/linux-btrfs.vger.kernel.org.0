Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC31614590
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 09:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiKAISc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 04:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKAISb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 04:18:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F275F13E38
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 01:18:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9350CB81A5E
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 08:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5A0C433C1;
        Tue,  1 Nov 2022 08:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667290707;
        bh=UsS/yphepWXQiGHU3UrFSv8dpA22Ol1YgsQ0wQNK/Ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WF2M2H7S9PQClLeK7YRYmMEtc6j16rCLt5ytYyZTirpJCnukV9KzGTYJeNwlixIXo
         pQng3G98m0n3NTeJA4g7OasQtzo9mfwR4KMrXxiTkL9kX8ho6mcRAwdnrkAjxN1/Wi
         HypCqd7tt4w2NgDO4PxL+BraaLWRUhaL+drAtchidJ9JGBYAMsD2p5Jwp6k7ANw1CJ
         zfxVpXNPcGnG0DXnxybVxTWcLH0t6CoIbe+a6MRcpjufdNArf1+HwLqWvSA1nQ0bQt
         +UHfCecTWMoPvysAaI4DG8QgGa1QtU9xYTOrZhuELhsuMDcJ4EmbanIx37Sxs8S0zC
         hwpmrEI6+sHFw==
Date:   Tue, 1 Nov 2022 08:18:24 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Subject: Re: [PATCH 2/3] btrfs: Fix uaf of the ulist in test_multiple_refs()
Message-ID: <20221101081824.GB3418818@falcondesktop>
References: <20221101025356.1643836-1-zhangxiaoxu5@huawei.com>
 <20221101025356.1643836-3-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101025356.1643836-3-zhangxiaoxu5@huawei.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 01, 2022 at 10:53:55AM +0800, Zhang Xiaoxu wrote:
> There is a use-after-free report when do sanity tests:
> 
>   BUG: KASAN: use-after-free in ulist_free+0x25/0xa0 [btrfs]
>   Read of size 8 at addr ffff888296ab4748 by task insmod/78078
> 
>   CPU: 7 PID: 78078 Comm: insmod Tainted: G        W          6.1.0-rc2+ #5
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x34/0x44
>    print_report+0x171/0x472
>    kasan_report+0xb7/0x140
>    ulist_free+0x25/0xa0 [btrfs]
>    test_multiple_refs.constprop.0+0x411/0x470 [btrfs]
>    btrfs_test_qgroups+0x2da/0x300 [btrfs]
>    btrfs_run_sanity_tests.cold+0x5c/0xd5 [btrfs]
>    init_btrfs_fs+0xec/0x154 [btrfs]
>    do_one_initcall+0x87/0x2a0
>    do_init_module+0xdf/0x320
>    load_module+0x3006/0x3390
>    __do_sys_finit_module+0x113/0x1b0
>    do_syscall_64+0x35/0x80
>    entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
>   Allocated by task 78078:
>    kasan_save_stack+0x1e/0x40
>    kasan_set_track+0x21/0x30
>    __kasan_kmalloc+0x7a/0x90
>    ulist_alloc+0x55/0xe0 [btrfs]
>    btrfs_find_all_roots_safe+0x9d/0x1c0 [btrfs]
>    test_multiple_refs.constprop.0+0x1e0/0x470 [btrfs]
>    btrfs_test_qgroups+0x2da/0x300 [btrfs]
>    btrfs_run_sanity_tests.cold+0x5c/0xd5 [btrfs]
>    init_btrfs_fs+0xec/0x154 [btrfs]
>    do_one_initcall+0x87/0x2a0
>    do_init_module+0xdf/0x320
>    load_module+0x3006/0x3390
>    __do_sys_finit_module+0x113/0x1b0
>    do_syscall_64+0x35/0x80
>    entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
>   Freed by task 78078:
>    kasan_save_stack+0x1e/0x40
>    kasan_set_track+0x21/0x30
>    kasan_save_free_info+0x2a/0x40
>    ____kasan_slab_free+0x143/0x1b0
>    __kmem_cache_free+0xc8/0x330
>    btrfs_qgroup_account_extent+0x402/0x770 [btrfs]
>    test_multiple_refs.constprop.0+0x243/0x470 [btrfs]
>    btrfs_test_qgroups+0x2da/0x300 [btrfs]
>    btrfs_run_sanity_tests.cold+0x5c/0xd5 [btrfs]
>    init_btrfs_fs+0xec/0x154 [btrfs]
>    do_one_initcall+0x87/0x2a0
>    do_init_module+0xdf/0x320
>    load_module+0x3006/0x3390
>    __do_sys_finit_module+0x113/0x1b0
>    do_syscall_64+0x35/0x80
>    entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> Since the ulist already freed after update the qgroup refcnt, the ulist
> should be set to NULL before the next reuse the variable.
> 
> Fixes: 442244c96332 ("btrfs: qgroup: Switch self test to extent-oriented qgroup mechanism.")
> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> ---
>  fs/btrfs/tests/qgroup-tests.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
> index eee1e4459541..4172bef5b4a1 100644
> --- a/fs/btrfs/tests/qgroup-tests.c
> +++ b/fs/btrfs/tests/qgroup-tests.c
> @@ -347,6 +347,9 @@ static int test_multiple_refs(struct btrfs_root *root,
>  		return ret;
>  	}
>  
> +	old_roots = NULL;
> +	new_roots = NULL;

This could be addressed by having error paths not doing unnecessary
free of the new_roots list.

> +
>  	if (btrfs_verify_qgroup_counts(fs_info, BTRFS_FS_TREE_OBJECTID,
>  				       nodesize, nodesize)) {
>  		test_err("qgroup counts didn't match expected values");
> @@ -380,6 +383,9 @@ static int test_multiple_refs(struct btrfs_root *root,
>  		return ret;
>  	}
>  
> +	old_roots = NULL;
> +	new_roots = NULL;

This one isn't needed.
As after the btrfs_verify_qgroup_counts() calls there's nothing using or freeing
the ulist variables.

The way I addressed it in my patchset:

From: Filipe Manana <fdmanana@suse.com>
Date: Fri, 14 Oct 2022 16:56:29 +0100
Subject: [PATCH 04/18] btrfs: remove pointless ulist frees in error paths of
 qgroup self tests

Several places in the qgroup self tests follow the pattern of freeing
the ulist pointer they passed to btrfs_find_all_roots() if the call to
that function returned an error. That is pointless because that function
always frees the ulist in case it returns an error. So remove those
calls to reduce the code size.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tests/qgroup-tests.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index 96a70ce36f79..65b65d55d1f6 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -227,7 +227,6 @@ static int test_no_shared_qgroup(struct btrfs_root *root,
 	 */
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots, false);
 	if (ret) {
-		ulist_free(old_roots);
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
@@ -242,7 +241,6 @@ static int test_no_shared_qgroup(struct btrfs_root *root,
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
 	if (ret) {
 		ulist_free(old_roots);
-		ulist_free(new_roots);
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
@@ -254,17 +252,18 @@ static int test_no_shared_qgroup(struct btrfs_root *root,
 		return ret;
 	}
 
+	/* btrfs_qgroup_account_extent() always frees the ulists passed to it. */
+	old_roots = NULL;
+	new_roots = NULL;
+
 	if (btrfs_verify_qgroup_counts(fs_info, BTRFS_FS_TREE_OBJECTID,
 				nodesize, nodesize)) {
 		test_err("qgroup counts didn't match expected values");
 		return -EINVAL;
 	}
-	old_roots = NULL;
-	new_roots = NULL;
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots, false);
 	if (ret) {
-		ulist_free(old_roots);
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
@@ -278,7 +277,6 @@ static int test_no_shared_qgroup(struct btrfs_root *root,
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
 	if (ret) {
 		ulist_free(old_roots);
-		ulist_free(new_roots);
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
@@ -328,7 +326,6 @@ static int test_multiple_refs(struct btrfs_root *root,
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots, false);
 	if (ret) {
-		ulist_free(old_roots);
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
@@ -343,7 +340,6 @@ static int test_multiple_refs(struct btrfs_root *root,
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
 	if (ret) {
 		ulist_free(old_roots);
-		ulist_free(new_roots);
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
@@ -363,7 +359,6 @@ static int test_multiple_refs(struct btrfs_root *root,
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots, false);
 	if (ret) {
-		ulist_free(old_roots);
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
@@ -378,7 +373,6 @@ static int test_multiple_refs(struct btrfs_root *root,
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
 	if (ret) {
 		ulist_free(old_roots);
-		ulist_free(new_roots);
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
@@ -404,7 +398,6 @@ static int test_multiple_refs(struct btrfs_root *root,
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots, false);
 	if (ret) {
-		ulist_free(old_roots);
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
@@ -419,7 +412,6 @@ static int test_multiple_refs(struct btrfs_root *root,
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
 	if (ret) {
 		ulist_free(old_roots);
-		ulist_free(new_roots);
 		test_err("couldn't find old roots: %d", ret);
 		return ret;
 	}
-- 
2.35.1



> +
>  	if (btrfs_verify_qgroup_counts(fs_info, BTRFS_FS_TREE_OBJECTID,
>  					nodesize, 0)) {
>  		test_err("qgroup counts didn't match expected values");
> -- 
> 2.31.1
> 
