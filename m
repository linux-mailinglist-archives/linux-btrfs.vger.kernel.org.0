Return-Path: <linux-btrfs+bounces-16623-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7871FB43FD1
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 17:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005DC5A5A63
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 15:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE08309DC5;
	Thu,  4 Sep 2025 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLwrk2j3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB154304BCE;
	Thu,  4 Sep 2025 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998024; cv=none; b=ueZheqT74n8EosGUR31HSsAl5bjKQW2F9UaZfDNAewDN5q/ZOi5ECGvcCb3ITm6Cd0cn0KYprvZUDRGQRjjiKAiccuV4ulMPrJZGhSD+1u1jvtDiUUjK8+QrkgRz0C/3WU0XT/rSFqobAJoiceZo/Xr+YTi5Byc7cRY+6Pg9EP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998024; c=relaxed/simple;
	bh=6haEVOJoZ/15vSBMmKp/Kvv3+tPPbDgux+p0zG6seos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knryIRvZiCYShnNG1F5ISUHeLmHp6lW9mDgL14Xm1YMsQxeN2mI8ZEI7BfUrZqDaG4CwYtdCRoMBeW0YJpeQyytYNFerFiXfIN/Pv4pG2aJC2DVd8dQbGVLXsIahilAIlHhOwUj8rR7DJsOjcEm44aRTboDoTbmqJsiyE6m698E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLwrk2j3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C96EC4CEF0;
	Thu,  4 Sep 2025 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756998023;
	bh=6haEVOJoZ/15vSBMmKp/Kvv3+tPPbDgux+p0zG6seos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLwrk2j3q2eyyDEQI9SThKZ7BfYgf+GZ2UY5Xeh9K4ueUMEKmicFQrHiGWNtTGHao
	 pE1kTCnjzHAvk70gmrSzsOgnyjSNjKueBnNqD0QuqYEqhh3Lvy0r18NNIRw7BOU8Zp
	 OFhjQHv3ctIoZaoUstBezjTYhlgMOvksISsHnio1Mh/7VC06RhE6Df0hsgwR3Nsb2a
	 mmF3zrRmTxAAXD0iyNPAPdDZYrnWXrh/oVzZ8Tjy2QomZpVzYXmgCOSoQlu0CgMGHY
	 0djsMsjSIGS8SNszC+Mx797nUQWdBunj5YnNwFawmt8DC8HneWVqGBKZeADuv4Xfkc
	 l4fbbVrzJjXKA==
Date: Thu, 4 Sep 2025 08:00:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/733: avoid output difference due to
 bash's version
Message-ID: <20250904150022.GE8092@frogsfrogsfrogs>
References: <20250904081429.114716-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904081429.114716-1-wqu@suse.com>

On Thu, Sep 04, 2025 at 05:44:29PM +0930, Qu Wenruo wrote:
> [FALSE ALERT]
> When running generic/733 with bash 5.3.3 (any thing newer than 5.3.0
> will reproduce the bug), the test case will fail like the following:
> 
> generic/733 19s ... - output mismatch (see /home/adam/xfstests/results//generic/733.out.bad)
>     --- tests/generic/733.out	2025-09-04 17:30:08.568000000 +0930
>     +++ /home/adam/xfstests/results//generic/733.out.bad	2025-09-04 17:30:32.898475103 +0930
>     @@ -2,5 +2,5 @@
>      Format and mount
>      Create a many-block file
>      Reflink the big file
>     -Terminated
>     +Terminated                 $here/src/t_reflink_read_race "$testdir/file1" "$testdir/file2" "$testdir/outcome" &>> $seqres.full
>      test completed successfully
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/generic/733.out /home/adam/xfstests/results//generic/733.out.bad'  to see the entire diff)
> 
> [CAUSE]
> The failure is fs independent, but bash version dependent.
> 
> In bash v5.3.x, the job control will output the command which triggered
> the job control (from termination to core dump etc).
> 
> The "Terminated" message is not from the program, but from bash's job
> control, thus redirection won't hide that message.
> 
> [FIX]
> Instead of relying on the job control behavior from bash, run the
> t_reflink_read_race tool in background, and wait for it to finish.
> 
> Background bash will be non-interactive, thus no job control and no
> "Terminated" message.
> 
> Thankfully this particular test case does extra checks on the outcome
> file to determine if the program is properly terminated, thus we are
> safe to delete the "Terminated" line from the golden output.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/generic/733     | 15 ++++++++++++++-
>  tests/generic/733.out |  1 -
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/733 b/tests/generic/733
> index aa7ad994..b8321abc 100755
> --- a/tests/generic/733
> +++ b/tests/generic/733
> @@ -70,8 +70,21 @@ done
>  echo "fnr=$fnr" >> $seqres.full
>  
>  echo "Reflink the big file"
> +# Workaround the default job control by running it at background.
> +#
> +# Job control of bash v5.3.x will output the command which triggered the job
> +# control (terminated, core dump etc).
> +# And since it's handled by bash itself, redirection won't work for the job
> +# control message.
> +#
> +# Running the command in background will disable the job control thus
> +# there will be no extra message like "Terminated".
> +#
> +# We will check the outcome file to determine if the program is properly
> +# terminated, thus no need to bother the job control message.
>  $here/src/t_reflink_read_race "$testdir/file1" "$testdir/file2" \
> -	"$testdir/outcome" &>> $seqres.full
> +	"$testdir/outcome" &>> $seqres.full &
> +wait

Hrmm, the only problem I can see is what happens if someone hits ^C to
terminate fstests while t_reflink_read_race is running?  Will anything
wait for it to terminate, or will the user be stuck with it running in
the background, pinning the mount, etc. ?

Or can we use shell command groups here:

{ $here/src/t_reflink_read_race <params> ; } 2>/dev/null

(the semicolon is significant)

to run t_reflink_read_race as a foreground job but redirect the
shell's helpful termination messages to /dev/null?

--D

>  
>  if [ ! -e "$testdir/outcome" ]; then
>  	echo "Could not set up program"
> diff --git a/tests/generic/733.out b/tests/generic/733.out
> index d4f5a7c7..2383cc8d 100644
> --- a/tests/generic/733.out
> +++ b/tests/generic/733.out
> @@ -2,5 +2,4 @@ QA output created by 733
>  Format and mount
>  Create a many-block file
>  Reflink the big file
> -Terminated
>  test completed successfully
> -- 
> 2.51.0
> 
> 

