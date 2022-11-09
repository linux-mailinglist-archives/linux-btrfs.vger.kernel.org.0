Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB05962298F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 12:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiKILGS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 06:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiKILGQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 06:06:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C4C1B792;
        Wed,  9 Nov 2022 03:06:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96FAA619E8;
        Wed,  9 Nov 2022 11:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4AEC433D6;
        Wed,  9 Nov 2022 11:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667991974;
        bh=h4NUwLVWfY0UgGv3HqFnh9ySdu2fwC/gWAEq/vch/l0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m5BmoRVPWzQeWcARPLtmRy7eJIiRcUUUzqxCSWT8bLymb1/ufOGAhsSOVGqDh0G6q
         8Zidj2kTrW9HHq+xH1NrmdAa8su2EXKCMYqsdCH6G2q6rQLSTZIBuBL6U1+ZoY6myn
         b0hEIVwKWQ7RW64WGHBGf2K6oIYdelrNzx0fKm2VNIUOcZtMO/k3VVE9VWFJABBQYt
         /M4f+ncjZhTT54J+bOckm2RpH38zRORHPTveBMv3rhpUFiKh1iWu7+r3lFfgFPv02y
         mhekLUbKUZo/2iCO9l3TRzs+c0JtF8q0CrMRJ+d2C6JkRXsY0RhfiwZjO5cestXGbU
         q3/VYWilNNclw==
Date:   Wed, 9 Nov 2022 11:06:12 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: btrfs: add a regression test case to make
 sure scrub can detect errors
Message-ID: <20221109110612.GB3904993@falcondesktop>
References: <20221109054723.38635-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109054723.38635-1-wqu@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 09, 2022 at 01:47:23PM +0800, Qu Wenruo wrote:
> There is a regression in v6.1-rc kernel, which will prevent btrfs scrub
> from detecting corruption (thus no repair either).
> 
> The regression is caused by commit 786672e9e1a3 ("btrfs: scrub: use
> larger block size for data extent scrub").
> 
> The new test case will:
> 
> - Create a data extent with 2 sectors
> - Corrupt the second sector of above data extent
> - Scrub to make sure we detect the corruption
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Remove include for common/btrfs
>   Which is included by default.
> 
> - Add comment for why including common/filter
>   Needed by _btrfs_get_*() helpers.
> 
> - Migrated to btrfs/278
>   Which is the latest result by "./new btrfs" on for-next branch.
> 
> - Add "-s 4k" for _scratch_mkfs
>   To support systems with larger page sizes.
> 
> - Remove comments from the template
> ---
>  tests/btrfs/281     | 62 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/281.out |  2 ++
>  2 files changed, 64 insertions(+)
>  create mode 100755 tests/btrfs/281
>  create mode 100644 tests/btrfs/281.out
> 
> diff --git a/tests/btrfs/281 b/tests/btrfs/281
> new file mode 100755
> index 00000000..69b5ac02
> --- /dev/null
> +++ b/tests/btrfs/281
> @@ -0,0 +1,62 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# A regression test for offending commit 786672e9e1a3 ("btrfs: scrub: use
> +# larger block size for data extent scrub"), which makes btrfs scrub unable
> +# to detect corruption if it's not the first sector of an data extent.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick scrub
> +
> +# For _btrfs_get_*() helpers which needs filtering.
> +. ./common/filter
> +
> +_supported_fs btrfs
> +_require_scratch
> +
> +# Need to use 4K as sector size
> +_require_btrfs_support_sectorsize 4096
> +_require_scratch

Nit: duplicated, already called before.

> +
> +_scratch_mkfs -s 4k >> $seqres.full

Btw, older btrfs-progs versions had mkfs print messages to stderr when
they do a discard, like this:

   "Performing full device TRIM (100.00GiB) ..."

So it's better to redirect stderr as well, to avoid golden output mismatch.
That's why all (or almost all) test cases also redirect stderr when calling
_scratch_mkfs.

> +_scratch_mount
> +
> +# Create a data extent with 2 sectors
> +$XFS_IO_PROG -fc "pwrite -S 0xff 0 8k" $SCRATCH_MNT/foobar >> $seqres.full

Instead of redirecting stdout, in situations like this I prefer to filter
xfs_io's output (| _fitler_xfs_io) and then place it in the golden output.

That's just to make it easier to debug if we somehow get a short write
(can happen during development), as that doesn't print anything to stderr.
Otherwise failing below at _btrfs_get_physical will probably give a more
cryptic failure, not immediately obvious.

Otherwise it looks good to me, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> +sync
> +
> +first_logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
> +echo "logical of the first sector: $first_logical" >> $seqres.full
> +
> +second_logical=$(( $first_logical + 4096 ))
> +echo "logical of the second sector: $second_logical" >> $seqres.full
> +
> +second_physical=$(_btrfs_get_physical $second_logical 1)
> +echo "physical of the second sector: $second_physical" >> $seqres.full
> +
> +second_dev=$(_btrfs_get_device_path $second_logical 1)
> +echo "device of the second sector: $second_dev" >> $seqres.full
> +
> +_scratch_unmount
> +
> +# Corrupt the second sector of the data extent.
> +$XFS_IO_PROG -c "pwrite -S 0x00 $second_physical 4k" $second_dev >> $seqres.full
> +_scratch_mount
> +
> +# Redirect stderr and stdout, as if btrfs detected the unrepairable corruption,
> +# it will output an error message.
> +$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT &> $tmp.output
> +cat $tmp.output >> $seqres.full
> +_scratch_unmount
> +
> +if ! grep -q "csum=1" $tmp.output; then
> +	echo "Scrub failed to detect corruption"
> +fi
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/281.out b/tests/btrfs/281.out
> new file mode 100644
> index 00000000..3678e27f
> --- /dev/null
> +++ b/tests/btrfs/281.out
> @@ -0,0 +1,2 @@
> +QA output created by 281
> +Silence is golden
> -- 
> 2.38.0
> 
