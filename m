Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EDB489822
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 12:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbiAJL5p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 06:57:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52054 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiAJL5p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 06:57:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 201FD61284;
        Mon, 10 Jan 2022 11:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E712CC36AE5;
        Mon, 10 Jan 2022 11:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641815863;
        bh=t1ZJAcYbJZcNHi3VBMTa3Ug1r9KU5zk0PTA/uQT4sR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EspiDqVMJ6EeAvuhsv8HGSoCqz6+Gc1vPNKGaYWPccdDAfNYT0mNzbBYfFsEJMqFQ
         ZmKVgDDo9gi5ew5YQuGHqCjH++FVeTCdiU6HN1KAlMyiMXYwdZWI4cVnlKcLxmATMR
         /i81t5FAqtr1QwbfJtxXE7pDhP7HrIgn5mvE2cPwPLes8IfT/eMa6bR/H4NPRCtJqU
         IZdtSPZzF7ufsVQHzf+xA1c46xaQR8imXI3Bcgtk57e+oi8NSRUNBmuXf6Li0wk0c+
         Yta/z1HguDh2OEoBqWkewc/UxY0pP3dOBSpDdA8pzUP1j6S9W8ELAL4bXcAUHn4GP2
         gR7uIXfi+3wyw==
Date:   Mon, 10 Jan 2022 11:57:40 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/011: handle finished replace properly
Message-ID: <YdwfNDsgEGmTL6bY@debian9.Home>
References: <20220110112848.37491-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110112848.37491-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 10, 2022 at 07:28:48PM +0800, Qu Wenruo wrote:
> [BUG]
> When running btrfs/011 inside VM which has unsafe cache set for its
> devices, and the host have enough memory to cache all the IO:

Btw, I use the same setup and the test never fails for me.
It's quite of a strech assuming that using unsafe caching and having
enough memory are the only reasons for the failure.

I use a debug kernel with plenty of heavy debug features enabled,
so that may be one reason why I can't trigger it.

> 
> btrfs/011 98s ... [failed, exit status 1]- output mismatch
>     --- tests/btrfs/011.out	2019-10-22 15:18:13.962298674 +0800
>     +++ /xfstests-dev/results//btrfs/011.out.bad	2022-01-10 19:12:14.683333251 +0800
>     @@ -1,3 +1,4 @@
>      QA output created by 011
>      *** test btrfs replace
>     -*** done
>     +failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
>     +(see /xfstests-dev/results//btrfs/011.full for details)
>     ...
> Ran: btrfs/011
> Failures: btrfs/011
> Failed 1 of 1 tests
> 
> [CAUSE]
> Although commit fa85aa64 ("btrfs/011: Fill the fs to ensure we
> have enough data for dev-replace") tries to address the problem by
> filling the fs with extra content, there is still no guarantee that 2
> seconds of IO still needs 2 seconds to finish.
> 
> Thus even we tried our best to make sure the replace will take 2
> seconds, it can still finish faster than 2 seconds.
> 
> And just to mention how fast the test finishes, after the fix, the test
> takes around 90~100 seconds to finish.
> While on real-hardware it can take over 1000 seconds.
> 
> [FIX]
> Instead of further enlarging the IO, here we just accept the fact that
> replace can finish faster than our expectation, and continue the test.

If I'm reading this, and the code, correctly this means we end up never
testing that the replace cancel feature ends up being exercised and
while a replace is in progress. That's far from ideal, losing test
coverage.

Josef sent a patch for this last month:

https://lore.kernel.org/linux-btrfs/01796d6bcec40ae80b5af3269e60a66cd4b89262.1638382763.git.josef@toxicpanda.com/

Don't know why it wasn't merged. I agree that changing timings in the
test is not ideal and always prone to still fail on some setups, but
seems more acceptable to me rather than losing test coverage.

Thanks.

> 
> One thing to notice is, since the replace finished, we need to replace
> back the device, or later fsck will be executed on blank device, and
> cause false alert.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/011 | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index b4673341..aae89696 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -171,13 +171,24 @@ btrfs_replace_test()
>  		# background the replace operation (no '-B' option given)
>  		_run_btrfs_util_prog replace start -f $replace_options $source_dev $target_dev $SCRATCH_MNT
>  		sleep $wait_time
> -		_run_btrfs_util_prog replace cancel $SCRATCH_MNT
> +		$BTRFS_UTIL_PROG replace cancel $SCRATCH_MNT 2>&1 >> $seqres.full
>  
>  		# 'replace status' waits for the replace operation to finish
>  		# before the status is printed
>  		$BTRFS_UTIL_PROG replace status $SCRATCH_MNT > $tmp.tmp 2>&1
>  		cat $tmp.tmp >> $seqres.full
> -		grep -q canceled $tmp.tmp || _fail "btrfs replace status (canceled) failed"
> +
> +		# There is no guarantee we canceled the replace, it can finish
> +		if grep -q 'finished' $tmp.tmp ; then
> +			# The replace finished, we need to replace it back or
> +			# later fsck will report error as $SCRATCH_DEV is now
> +			# blank
> +			$BTRFS_UTIL_PROG replace start -Bf $target_dev \
> +				$source_dev $SCRATCH_MNT > /dev/null
> +		else
> +			grep -q 'canceled' $tmp.tmp || _fail \
> +				"btrfs replace status (canceled ) failed"
> +		fi
>  	else
>  		if [ "${quick}Q" = "thoroughQ" ]; then
>  			# The thorough test runs around 2 * $wait_time seconds.
> -- 
> 2.34.1
> 
