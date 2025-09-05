Return-Path: <linux-btrfs+bounces-16627-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72193B44B0D
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 03:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC221C81C87
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 01:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273B01AAE28;
	Fri,  5 Sep 2025 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njEdA7nW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589E6134AB;
	Fri,  5 Sep 2025 01:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757034108; cv=none; b=DfwRAo5b3yge9iwpvh9rHPUcGoie2ayIEShqgfsoakitrz3SXdmfqgRI0wdWvnZgRBZw1Pt/AKq4/HWaf1kct8UPm1k8OGGZRlAkYFqgPFhzHk8JLDCK1yT56h1Fd4HA71l+qBVlos7xTlQYaXZIXvguaZhYM+QkC7q4QoIUf8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757034108; c=relaxed/simple;
	bh=SXzlWF4/m7EeDjkLBYN/a1ThtT6r1o/qwwxwyxxTE1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qkm4r7pH5RwGgD26sNhLxctlM16rvMjX753QNH8sskOIdYV707nqeoxqar1zkTLB7V0/bxtjjHrbSqpftZLO643fy7DrhrsDO090F64UedB25Xye/CJjfopSITLROyuM/CXyt/jZEwjP2R5Op7rK2j6M2fTgH18hbPqq09vm5wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njEdA7nW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2115DC4CEF0;
	Fri,  5 Sep 2025 01:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757034108;
	bh=SXzlWF4/m7EeDjkLBYN/a1ThtT6r1o/qwwxwyxxTE1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=njEdA7nW2PCxOxIGrqVU3bJfD/HQdMvH6GpjbA1vS9N+nN1NAPHC2BQBOBXsz3fTy
	 HG6gekn7M2LjPJGWXhycZ9n6eH0vOP4up5c+lSFn0LlBilXnjmrapO/ML1EXfSRIns
	 +CPqRIAX75nCFwbV6V7Ssreqk35c0YOkIldRviZRmSIc3OjyRZsXtboDT33ol4SSiX
	 XABwrQD1bmT/AYkxbJzO5l5DE41mEqwTQhm2Q8FfYJZcRDI5kB+Vc9GYFVwiwzrL3N
	 7se3bmUfvVImHKvGbyamJw2yAC8gkV5183SKiNKMJgQVPvjqXvGjNBzG7+e4/rNuHQ
	 SJHnWyxmyrprA==
Date: Thu, 4 Sep 2025 18:01:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: generic/733: avoid output difference due to
 bash's version
Message-ID: <20250905010147.GF8092@frogsfrogsfrogs>
References: <20250904214415.10628-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904214415.10628-1-wqu@suse.com>

On Fri, Sep 05, 2025 at 07:14:15AM +0930, Qu Wenruo wrote:
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
> Run the command in a command group, which will be executed in a
> subshell.
> 
> By this we can redirect the output of the subshell, including the job
> control message, thus hide the different output pattern caused by
> different bash versions.
> 
> Thankfully this particular test case does extra checks on the outcome
> file to determine if the program is properly terminated, thus we are
> safe to move the "Terminated" line from the golden output to
> seqres.full.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> v2:
> - Use command grouping instead of background execution
>   Background execution requires extra cleanup to wait for the background
>   program.
>   Meanwhile command grouping will run in a subshell thus we can redirect
>   everything including the job control message.
> 
>   Thanks Darrick for pointing this solution out.
> ---
>  tests/generic/733     | 17 +++++++++++++++--
>  tests/generic/733.out |  1 -
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/generic/733 b/tests/generic/733
> index aa7ad994..21347d51 100755
> --- a/tests/generic/733
> +++ b/tests/generic/733
> @@ -70,8 +70,21 @@ done
>  echo "fnr=$fnr" >> $seqres.full
>  
>  echo "Reflink the big file"
> -$here/src/t_reflink_read_race "$testdir/file1" "$testdir/file2" \
> -	"$testdir/outcome" &>> $seqres.full
> +# Workaround the default job control by command grouping so that we can redirect
> +# the job control message of the subshell.
> +#
> +# Job control of bash v5.3.x will output the command which triggered the job
> +# control (terminated, core dump etc).
> +# And since it's handled by bash itself, redirection of the program won't work
> +# for the job control message.
> +#
> +# Running the command in a command group will make the program run in a subshell
> +# so that we can direct the job control message of the subshell.
> +#
> +# We will check the outcome file to determine if the program is properly
> +# terminated, thus no need to bother the job control message.
> +{ $here/src/t_reflink_read_race "$testdir/file1" "$testdir/file2" \
> +	"$testdir/outcome" ; } &>> $seqres.full

/me wonders how many more of these bash messages are lurking out there,
but in the meantime

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

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

