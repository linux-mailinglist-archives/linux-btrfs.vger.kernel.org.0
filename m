Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65234CA8F9
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 16:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbiCBPXU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 10:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiCBPXT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 10:23:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC18A35870;
        Wed,  2 Mar 2022 07:22:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A7EB616C2;
        Wed,  2 Mar 2022 15:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9250EC004E1;
        Wed,  2 Mar 2022 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646234555;
        bh=Xeuxs/BZ7NFTvHkkRwveR/uLBeGpkKIzubHFc6Xu+zI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPju/6YeNSSlOgnLOySxu53946jVcuOMsabBCKloO0RvpYIH5nN3QypujTHO/MITU
         LuH/ADO31Mfe3NUPZr/d71QB82H+BEDSSC8iQeDC7xFmXRwKV0Ad9pxBJsZrqngvXy
         q5fEYPTwjpRIkXcnt4Cm14j92eYQ4FR9IQYWZ9SoHO8yM0bKjU3sJOy5kdqzvd75qw
         OYKS34cYdO6pnLzEeUxjqGYh1xt8o7HuHkHbxj5cFSqwnUNU9dn8YrJU8UFyPKMvhW
         XMWvHNWlrhyHpKVqTMC0bGpxtuazgsfzD8IiMnqMMLT78qyHF969C/ccsb9vX0TYeC
         Twy1OzuSeM/Og==
Date:   Wed, 2 Mar 2022 15:22:31 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH v2] btrfs: add test for enable/disable quota and
 create/destroy qgroup repeatedly
Message-ID: <Yh+Lt4HfHBO18Ifh@debian9.Home>
References: <20220302140548.1150-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302140548.1150-1-realwakka@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 02, 2022 at 02:05:48PM +0000, Sidong Yang wrote:
> Test enable/disable quota and create/destroy qgroup repeatedly in
> parallel and confirm it does not cause kernel hang. It only happens
> in kernel staring with kernel 5.17-rc3. This is a regression test
> for the problem reported to linux-btrfs list [1].
> 
> The hang was recreated using the test case and fixed by kernel patch
> titled
> 
>   btrfs: qgroup: fix deadlock between rescan worker and remove qgroup
> 
> [1] https://lore.kernel.org/linux-btrfs/20220228014340.21309-1-realwakka@gmail.com/
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> v2 : fix changelog, comments, no wait pids argument
> ---
>  tests/btrfs/262     | 40 ++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/262.out |  2 ++
>  2 files changed, 42 insertions(+)
>  create mode 100755 tests/btrfs/262
>  create mode 100644 tests/btrfs/262.out
> 
> diff --git a/tests/btrfs/262 b/tests/btrfs/262
> new file mode 100755
> index 00000000..8953a28e
> --- /dev/null
> +++ b/tests/btrfs/262
> @@ -0,0 +1,40 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Sidong Yang.  All Rights Reserved.
> +#
> +# FS QA Test 262
> +#
> +# Test that running qgroup enable, create, destroy, and disable commands in
> +# parallel doesn't result in a deadlock, a crash or any filesystem
> +# inconsistency.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick qgroup
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +
> +_require_scratch
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +for ((i = 0; i < 200; i++)); do
> +	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT 2>> $seqres.full &
> +	$BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT 2>> $seqres.full &
> +	$BTRFS_UTIL_PROG qgroup destroy 1/0 $SCRATCH_MNT 2>> $seqres.full &
> +	$BTRFS_UTIL_PROG quota disable $SCRATCH_MNT 2>> $seqres.full &
> +done
> +
> +wait
> +
> +_scratch_unmount

The fstests framework will also do the unmount, so this can be removed.
You don't need to send a new patch version just to remove that, Eryu
can probably amend the patch when he picks it up.

Anyway, it looks good and it works as expected.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks for making the test case.

> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/262.out b/tests/btrfs/262.out
> new file mode 100644
> index 00000000..404badc3
> --- /dev/null
> +++ b/tests/btrfs/262.out
> @@ -0,0 +1,2 @@
> +QA output created by 262
> +Silence is golden
> -- 
> 2.25.1
> 
