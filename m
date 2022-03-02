Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783F44CA476
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 13:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241682AbiCBMK7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 07:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241678AbiCBMK5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 07:10:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F29DA9A69;
        Wed,  2 Mar 2022 04:10:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BB38B81FAD;
        Wed,  2 Mar 2022 12:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980D9C340F1;
        Wed,  2 Mar 2022 12:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646223011;
        bh=QLsOJeODj+q8W7S4HcQFcV5280qXF1sZAOj6kcgqeHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQBV0i9BejuzcrxIkxKIPEbU7O9tpBm0Ps7d7I5RpMvB2nAX/zgXkPGTIaklzLGBo
         5AuT0kpNrxDebIRlUH/fnjrR5DoCbVr6MAY04kk89efYjLRP64r8f5JicOhS/70lVB
         pLgMKcAB5RVenes1Xcfhdl2HoTi4O+kx+BO8nw+AT8EvK5G8af5gfkDMg6Yf1YIOQK
         5QbG89TsEgJLab0r7tVaDzhcMKrt7Ip5tA571cD/lArr9hHmK0FdYlD5HpxmoghJJQ
         irBMfsgDLv/2wxnEiM6QWsdt/7Ch26ajbFj4XmypFRQMC2rJGjnUDp506Im41bMGGe
         nJ13YMQLUubvw==
Date:   Wed, 2 Mar 2022 12:10:08 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: add test for enable/disable quota and
 create/destroy qgroup repeatedly
Message-ID: <Yh9eoC1FwfNK5kXn@debian9.Home>
References: <20220301151930.1315-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301151930.1315-1-realwakka@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 01, 2022 at 03:19:30PM +0000, Sidong Yang wrote:
> Test enabling/disable quota and creating/destroying qgroup repeatedly
> in asynchronous and confirm it does not cause kernel hang. This is a

in asynchronous -> in parallel

> regression test for the problem reported to linux-btrfs list [1].

It's worth mentioning the deadlock only happens starting with kernel 5.17-rc3.

> 
> The hang was recreated using the test case and fixed by kernel patch
> titled
> 
>   btrfs: qgroup: fix deadlock between rescan worker and remove qgroup
> 
> [1] https://lore.kernel.org/linux-btrfs/20220228014340.21309-1-realwakka@gmail.com/
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

In addition to Shinichiro's comments...

> ---
>  tests/btrfs/262     | 54 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/262.out |  2 ++
>  2 files changed, 56 insertions(+)
>  create mode 100755 tests/btrfs/262
>  create mode 100644 tests/btrfs/262.out
> 
> diff --git a/tests/btrfs/262 b/tests/btrfs/262
> new file mode 100755
> index 00000000..9be380f9
> --- /dev/null
> +++ b/tests/btrfs/262
> @@ -0,0 +1,54 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 YOUR NAME HERE.  All Rights Reserved.
> +#
> +# FS QA Test 262
> +#
> +# Test the deadlock between qgroup and quota commands

The test description should be a lot more clear.

"the deadlock" is vague a gives the wrong idea we only ever had a single
deadlock related to qgroups. "qgroup and quota commands" is confusing,
and "qgroup" and "quota" are pretty much synonyms, and it should mention
which commands.

Plus what we want to test is that we can run some qgroup operations in
parallel without triggering a deadlock, crash, etc.

Perhaps something like:

"""
Test that running qgroup enable, create, destroy and disable commands in
parallel does not result in a deadlock, a crash or any filesystem
inconsistency.
"""


> +#
> +. ./common/preamble
> +_begin_fstest auto qgroup

Can also be added to the "quick" group. It takes 1 second in my slowest vm.

> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +
> +_require_scratch
> +
> +# Run command that enable/disable quota and create/destroy qgroup asynchronously

With the more clear test description above, this can go away.

> +qgroup_deadlock_test()
> +{
> +	_scratch_mkfs > /dev/null 2>&1
> +	_scratch_mount
> +	echo "=== qgroup deadlock test ===" >> $seqres.full

There's no point in echoing this message to the .full file, it provides no
value at all, as testing that is all that this testcase does.

> +
> +	pids=()
> +	for ((i = 0; i < 200; i++)); do
> +		$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT 2>> $seqres.full &
> +		pids+=($!)
> +		$BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT 2>> $seqres.full &
> +		pids+=($!)
> +		$BTRFS_UTIL_PROG qgroup destroy 1/0 $SCRATCH_MNT 2>> $seqres.full &
> +		pids+=($!)
> +		$BTRFS_UTIL_PROG quota disable $SCRATCH_MNT 2>> $seqres.full &
> +		pids+=($!)		
> +	done
> +
> +	for pid in "${pids[@]}"; do
> +		wait $pid
> +	done

As pointed before by Shinichiro, a simple 'wait' here is enough, no need to
keep track of the PIDs.

> +
> +	_scratch_unmount
> +	_check_scratch_fs

Not needed, the fstests framework automatically runs 'btrfs check' when a test
finishes. Doing this explicitly is only necessary when we need to do several
mount/unmount operations and want to check the fs is fine after each unmount
and before the next mount.

> +}
> +
> +qgroup_deadlock_test

There's no point in putting all the test code in a function, as the function
is only called once.

Otherwise it looks good, and the test works as advertised, it triggers a
deadlock on 5.17-rc3+ kernel and passes on a patched kernel.

Thanks for converting the reproducer into a test case.

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
