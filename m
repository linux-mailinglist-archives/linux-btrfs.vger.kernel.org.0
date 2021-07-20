Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3323CF14A
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 03:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347577AbhGTAoI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 20:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351730AbhGTAfr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 20:35:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE94E6108B;
        Tue, 20 Jul 2021 01:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626743760;
        bh=Yu6/Js4+nHeT7yEHxi8Y4jx0Y2d+CXydqKqvVSRmwMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WRkhJKsypTCzhosQFi7KUAYJE1+XC2R8pxEN/TKm+HjyQhDEuqAOi8J0S7XXqyFJT
         XMIzUUJC3K6yTo4kMhxlr+r+yCYoJeJHL2/tnbJjJITtvsOl+8iYrb3Et1K9bSCRO+
         awV37gvtW2f0aT07XypUFlni1byXkDNWiYLcVKmJlMsNGcg3qFMliEP87pBZcVx09b
         WXIHrG1ixCJvaLfCW8FAZmG6je0cRcdCi6y2UN4tD5bbZV4od4iq5legm32n0jYVTE
         AvRrKfOXPOH06MEoH/2DAQz0Brm61hO9UjABYvNCDzWs2qKHcnr17A9wfzV3rUoocB
         +VP7CP0RVVjqQ==
Date:   Mon, 19 Jul 2021 18:16:00 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
Message-ID: <20210720011600.GA22384@magnolia>
References: <20210719071337.217501-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719071337.217501-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 19, 2021 at 03:13:37PM +0800, Qu Wenruo wrote:
> This patch will allow fstests to run custom hooks before and after each
> test case.
> 
> These hooks will need to follow requirements:
> 
> - Both hook files needs to be executable
>   Or they will just be ignored
> 
> - Stderr and stdout will be redirected to "$seqres.full"
>   With extra separator to distinguish the hook output with real
>   test output
> 
>   Thus if any of the hook is specified, all tests will generate
>   "$seqres.full" which may increase the disk usage for results.
> 
> - Error in hooks script will be ignored completely
> 
> - Environment variable "$HOOK_TEMP" will be exported for both hooks
>   And the variable will be ensured not to change for both hooks.
> 
>   Thus it's possible to store temporary values between the two hooks,
>   like pid.
> 
> - Start hook has only one parameter passed in
>   $1 is "$seq" from "check" script. The content will the path of current
>   test case. E.g "tests/btrfs/001"
> 
> - End hook has two parameters passed in
>   $1 is the same as start hook.
>   $2 is the return value of the test case.
>   NOTE: $2 doesn't take later golden output mismatch check nor dmesg/kmemleak
>   check.
> 
> For more info, please refer to "README.hooks".
> 
> Also update .gitignore to ignore "hooks/start.hook" and "hooks/end.hook"
> so that one won't accidentally submit the debug hook.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Instead of previous attempt to manually utilize sysfs interface of
> ftrace, this time just add some hooks to allow one to do whatever they
> want.
> 
> RFC for how everything should be passed to hooks.
> Currently it's using a mixed method, $seq/$sts is passed as paramaters,
> while HOOK_TMP is passed as environmental variable.
> 
> Not sure what's the recommended way for hooks.
> ---
>  .gitignore      |  4 +++
>  README.hooks    | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
>  check           |  5 ++++
>  common/preamble |  4 ---
>  common/rc       | 43 +++++++++++++++++++++++++++++
>  5 files changed, 124 insertions(+), 4 deletions(-)
>  create mode 100644 README.hooks
> 
> diff --git a/.gitignore b/.gitignore
> index 2d72b064..99905ff9 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -201,3 +201,7 @@ tags
>  # cscope files
>  cscope.*
>  ncscope.*
> +
> +# hook scripts
> +/hooks/start.hook
> +/hooks/end.hook
> diff --git a/README.hooks b/README.hooks
> new file mode 100644
> index 00000000..be92a7d7
> --- /dev/null
> +++ b/README.hooks
> @@ -0,0 +1,72 @@
> +To run extra commands before and after each test case, there is the
> +'hooks/start.hook' and 'hooks/end.hook' files for such usage.
> +
> +Some notes for those two hooks:
> +
> +- Both hook files needs to be executable
> +  Or they will just be ignored
> +
> +- Stderr and stdout will be redirected to "$seqres.full"
> +  With extra separator to distinguish the hook output with real
> +  test output
> +
> +  Thus if any of the hook is specified, all tests will generate
> +  "$seqres.full" which may increase the disk usage for results.
> +
> +- Error in hooks script will be ignored completely
> +
> +- Environment variable "$HOOK_TEMP" will be exported for both hooks
> +  And the variable will be ensured not to change for both hooks.
> +
> +  Thus it's possible to store temporary values between the two hooks,
> +  like pid.
> +
> +- Start hook has only one parameter passed in
> +  $1 is "$seq" from "check" script. The content will the path of current
> +  test case. E.g "tests/btrfs/001"
> +
> +- End hook has two parameters passed in
> +  $1 is the same as start hook.
> +  $2 is the return value of the test case.
> +  NOTE: $2 doesn't take later golden output mismatch check nor dmesg/kmemleak
> +  check.
> +
> +The very basic test hooks would look like:
> +
> +hooks/start.hook:
> +  #!/bin/bash
> +  seq=$1
> +  echo "HOOK_TMP=$HOOK_TMP"
> +  echo "seq=$seq"
> +
> +hooks/end.hook:
> +  #!/bin/bash
> +  seq=$1
> +  sts=$2
> +  echo "HOOK_TMP=$HOOK_TMP"
> +  echo "seq=$seq"
> +  echo "sts=$sts"
> +
> +Then run test btrfs/001 and btrfs/002, their "$seqres.full" would look like:
> +
> +result/btrfs/001.full:
> +  === Running start hook ===
> +  HOOK_TMP=/tmp/78973.hook
> +  seq=tests/btrfs/001
> +  === Start hook finished ===
> +  === Running end hook ===
> +  HOOK_TMP=/tmp/78973.hook
> +  seq=tests/btrfs/001
> +  sts=0
> +  === End hook finished ===
> +
> +result/btrfs/002.full:
> +  === Running start hook ===
> +  HOOK_TMP=/tmp/78973.hook
> +  seq=tests/btrfs/002
> +  === Start hook finished ===
> +  === Running end hook ===
> +  HOOK_TMP=/tmp/78973.hook
> +  seq=tests/btrfs/002
> +  sts=0
> +  === End hook finished ===
> diff --git a/check b/check
> index bb7e030c..f24906f5 100755
> --- a/check
> +++ b/check
> @@ -846,6 +846,10 @@ function run_section()
>  		# to be reported for each test
>  		(echo 1 > $DEBUGFS_MNT/clear_warn_once) > /dev/null 2>&1
>  
> +		# Remove previous $seqres.full before start hook
> +		rm -f $seqres.full
> +
> +		_run_start_hook

Seeing as we now have standardized preamble and cleanup in every single
test, why don't you run this from _begin_fstest and modify
_register_cleanup to run _run_end_hook from the trap handler?

This way the start hooks run from within each test and therefore can
modify the test's environment (as opposed to ./check's environment; the
two are /not/ the same thing!) and/or _notrun the test like Ted wants.

(Granted I wonder why not use an exclude list, because I bet my 3.10
kernel has patches that yours doesn't, so kernel versions aren't all
that meaningful...)

--D

>  		if [ "$DUMP_OUTPUT" = true ]; then
>  			_run_seq 2>&1 | tee $tmp.out
>  			# Because $? would get tee's return code
> @@ -854,6 +858,7 @@ function run_section()
>  			_run_seq >$tmp.out 2>&1
>  			sts=$?
>  		fi
> +		_run_end_hook
>  
>  		if [ -f core ]; then
>  			_dump_err_cont "[dumped core]"
> diff --git a/common/preamble b/common/preamble
> index 66b0ed05..41a12060 100644
> --- a/common/preamble
> +++ b/common/preamble
> @@ -56,8 +56,4 @@ _begin_fstest()
>  	_register_cleanup _cleanup
>  
>  	. ./common/rc
> -
> -	# remove previous $seqres.full before test
> -	rm -f $seqres.full
> -
>  }
> diff --git a/common/rc b/common/rc
> index d4b1f21f..ec434aa5 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4612,6 +4612,49 @@ _require_names_are_bytes() {
>          esac
>  }
>  
> +_run_start_hook()
> +{
> +	if [[ ! -d "hooks" ]]; then
> +		return
> +	fi
> +
> +	if [[ ! -x "hooks/start.hook" ]]; then
> +		return
> +	fi
> +
> +	# Export $HOOK_TMP for hooks, here we add ".hook" suffix to "$tmp",
> +	# so we won't overwrite any existing $tmp.* files
> +	export HOOK_TMP=$tmp.hook
> +
> +	echo "=== Running start hook ===" >> $seqres.full
> +	# $1 is alwasy $seq
> +	./hooks/start.hook $seq >> $seqres.full 2>&1
> +	echo "=== Start hook finished ===" >> $seqres.full
> +	unset HOOK_TMP
> +}
> +
> +_run_end_hook()
> +{
> +	if [[ ! -d "hooks" ]]; then
> +		return
> +	fi
> +
> +	if [[ ! -x "hooks/end.hook" ]]; then
> +		return
> +	fi
> +
> +	# Export $HOOK_TMP for hooks, here we add ".hook" suffix to "$tmp",
> +	# so we won't overwrite any existing $tmp.* files
> +	export HOOK_TMP=$tmp.hook
> +
> +	echo "=== Running end hook ===" >> "$seqres.full"
> +	# $1 is alwasy $seq
> +	# $2 is alwasy $sts
> +	./hooks/end.hook $seq $sts >> "$seqres.full" 2>&1
> +	echo "=== End hook finished ===" >> "$seqres.full"
> +	unset HOOK_TMP
> +}
> +
>  init_rc
>  
>  ################################################################################
> -- 
> 2.31.1
> 
