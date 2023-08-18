Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C0B780A2F
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 12:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbjHRKcG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Aug 2023 06:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376312AbjHRKa6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Aug 2023 06:30:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EA1448D;
        Fri, 18 Aug 2023 03:30:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98C7F67B14;
        Fri, 18 Aug 2023 10:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5337C433C9;
        Fri, 18 Aug 2023 10:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692354607;
        bh=O0YhsI21wnl0Xsmj2mUVqonkcBY78JYHJsQJfsUKNn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fv9AamZ/LMEkPIrqjTXGYcEssxC7nO53Cu6iFJ9ao9crCFNgJsSQPzPpZFabwYCq5
         OgNAhveKOlCbvVmKWPvGUXafcg47vU6clngIY05lEmC70IL465/7B34RJSPXi1NHNs
         xGwJWlHFYFUkqWRXv8YmzbiGazphoFpk4D6pa+nuz3xgWopkdoyTGksou+xXuX1tAG
         ibX2PJJnv5Lz0gHfQUH7NG61Z25dWLRc94s9fC30WUvplXlJiQm77YjOX0EgCfUueE
         7YCeYLI1fMRGDWmgPJ6InfEm+1cOZ0CwOKweAvEM4pBAG5le2cVShhK+7gLxdJZ+aE
         jc9c+VTD9M3Yg==
Date:   Fri, 18 Aug 2023 11:30:01 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Lee Trager <lee@trager.us>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5] fstests: Verify dir permissions when creating a stub
 subvolume
Message-ID: <ZN9IKcJq1aYyd/dh@debian0.Home>
References: <20230818081156.3306384-1-lee@trager.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818081156.3306384-1-lee@trager.us>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 18, 2023 at 01:11:56AM -0700, Lee Trager wrote:
> btrfs supports creating nesting subvolumes however snapshots are not
> recurive. When a snapshot is taken of a volume which contains a subvolume
> the subvolume is replaced with a stub subvolume which has the same name and
> uses inode number 2. This test validates that the stub volume copies
> permissions of the original volume.
> Signed-off-by: Lee Trager <lee@trager.us>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, and it works as expected with and without the btrfs fix.
Thanks.

> ---
> v5:
> - Fixed typo in subject
> - Added _fixed_by_kernel_commit as this test requires a kernel fix to pass
> - Fixed copyright year
> v4:
> - Removed extra blank line in common/rc
> - Allowed caller to pass extra options to _require_unshare to check for
>   support. -f -r -m -p -U have been supported by util-linux and busybox
>   for awhile and are typical options.
> - Moved _registry_cleanup to right after _begin_fstest.
> - Added "cd /;rm -rf $tmp.*" from standard cleanup to 300 cleanup.
> - Added rm -rf $test_dir before running test to ensure its in a clean state.
> v3:
> - Fixed whitepsace in 300.out due to find command not using './' before %P
> v2:
> - Migrated _require_unshare from overlay/020 into common_rc. Updated the error
>   message as most Linux systems should have unshare from util-linux.
> - Added note about why the test must be done in one subshell process.
> - chown command now uses $qa_user:$qa_group instead of hard coded values.
>  common/rc           |  5 +++++
>  tests/btrfs/300     | 52 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/300.out | 18 ++++++++++++++++
>  tests/overlay/020   |  7 +-----
>  4 files changed, 76 insertions(+), 6 deletions(-)
>  create mode 100755 tests/btrfs/300
>  create mode 100644 tests/btrfs/300.out
> 
> diff --git a/common/rc b/common/rc
> index 5c4429ed..18ea0f02 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5224,6 +5224,11 @@ _soak_loop_running() {
>  	return 0
>  }
>  
> +_require_unshare() {
> +	unshare -f -r -m -p -U $@ true &>/dev/null || \
> +		_notrun "unshare: command not found, should be in util-linux"
> +}
> +
>  init_rc
>  
>  ################################################################################
> diff --git a/tests/btrfs/300 b/tests/btrfs/300
> new file mode 100755
> index 00000000..d3722503
> --- /dev/null
> +++ b/tests/btrfs/300
> @@ -0,0 +1,52 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 300
> +#
> +# Validate that snapshots taken while in a remapped namespace preserve
> +# the permissions of the user.
> +#
> +. ./common/preamble
> +
> +_begin_fstest auto quick subvol snapshot
> +_register_cleanup "cleanup"
> +
> +_supported_fs btrfs
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: copy dir permission and time when creating a stub subvolume"
> +
> +_require_test
> +_require_user
> +_require_group
> +_require_unix_perm_checking
> +_require_unshare
> +
> +test_dir="${TEST_DIR}/${seq}"
> +cleanup() {
> +	rm -rf $test_dir
> +	cd /
> +	rm -rf $tmp.*
> +}
> +
> +rm -rf $test_dir
> +mkdir $test_dir
> +chown $qa_user:$qa_group $test_dir
> +
> +# _user_do executes each command as $qa_user in its own subshell. unshare
> +# sets the namespace for the running shell. The test must run in one user
> +# subshell to preserve the namespace over multiple commands.
> +_user_do "
> +cd ${test_dir};
> +unshare --user --keep-caps --map-auto --map-root-user;
> +$BTRFS_UTIL_PROG subvolume create subvol;
> +touch subvol/{1,2,3};
> +$BTRFS_UTIL_PROG subvolume create subvol/subsubvol;
> +touch subvol/subsubvol/{4,5,6};
> +$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot;
> +"
> +
> +find $test_dir/. -printf "%M %u %g ./%P\n"
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/300.out b/tests/btrfs/300.out
> new file mode 100644
> index 00000000..6e94447e
> --- /dev/null
> +++ b/tests/btrfs/300.out
> @@ -0,0 +1,18 @@
> +QA output created by 300
> +Create subvolume './subvol'
> +Create subvolume 'subvol/subsubvol'
> +Create a snapshot of 'subvol' in './snapshot'
> +drwxr-xr-x fsgqa fsgqa ./
> +drwxr-xr-x fsgqa fsgqa ./subvol
> +-rw-r--r-- fsgqa fsgqa ./subvol/1
> +-rw-r--r-- fsgqa fsgqa ./subvol/2
> +-rw-r--r-- fsgqa fsgqa ./subvol/3
> +drwxr-xr-x fsgqa fsgqa ./subvol/subsubvol
> +-rw-r--r-- fsgqa fsgqa ./subvol/subsubvol/4
> +-rw-r--r-- fsgqa fsgqa ./subvol/subsubvol/5
> +-rw-r--r-- fsgqa fsgqa ./subvol/subsubvol/6
> +drwxr-xr-x fsgqa fsgqa ./snapshot
> +-rw-r--r-- fsgqa fsgqa ./snapshot/1
> +-rw-r--r-- fsgqa fsgqa ./snapshot/2
> +-rw-r--r-- fsgqa fsgqa ./snapshot/3
> +drwxr-xr-x fsgqa fsgqa ./snapshot/subsubvol
> diff --git a/tests/overlay/020 b/tests/overlay/020
> index 98a33aec..9f82da34 100755
> --- a/tests/overlay/020
> +++ b/tests/overlay/020
> @@ -16,18 +16,13 @@ _begin_fstest auto quick copyup perms
>  
>  # real QA test starts here
>  
> -require_unshare() {
> -	unshare -f -r "$@" true &>/dev/null || \
> -		_notrun "unshare $@: not supported"
> -}
> -
>  # Modify as appropriate.
>  _supported_fs overlay
>  _fixed_by_kernel_commit 3fe6e52f0626 \
>  	"ovl: override creds with the ones from the superblock mounter"
>  
>  _require_scratch
> -require_unshare -m -p -U
> +_require_unshare
>  
>  # Remove all files from previous tests
>  _scratch_mkfs
> -- 
> 2.34.1
> 
