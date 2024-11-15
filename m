Return-Path: <linux-btrfs+bounces-9733-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E259CF1D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 17:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9333F1F21B2C
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6411D61A5;
	Fri, 15 Nov 2024 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpU6pynn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530A51D5CF5;
	Fri, 15 Nov 2024 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688796; cv=none; b=D8jvpFzORaaYalAN6pkxZgzp3UpLs+KyPRN6WH9/RNLWbQ7NqduLwPQYJjyiFQyYFiibBQhTKnhcwNaos6ta/dPImFOrUrhaR/AlJ8dk5hL1D+cL+XRVTKv+MujPHqwdshseMcuIHI9sj9cMQdkRvkU79KZMXoBxrMuLD9z0Iao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688796; c=relaxed/simple;
	bh=ExA2h335FvPGLt3dw+d/zHDFcD2t8d9ORdjzl3mc8Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCubsUc1HbwZkcIdo7uYvfV5Jq8ScHmbXHOSVdGQlKuLiUnMweFZI6YaiE14w1eQzaOaQ0t/r5BM7/k0R/MHnqy4PC/HKBmMpzd6krqtVQqsIzCWfDeNSdN2MAoqc7YnhXv063eVoACY0KPOFxtNbtYlCQEORgHKZlaie+IHxOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpU6pynn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FC2C4CECF;
	Fri, 15 Nov 2024 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731688796;
	bh=ExA2h335FvPGLt3dw+d/zHDFcD2t8d9ORdjzl3mc8Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jpU6pynnF+0uPAvkhdKrtDKgNYSeCgdKMlGwB4nKyMB/odq47cE7QrseghiX4G7u5
	 DAdp6ANAMlBTgglr/olFBPLmm14EwjQSGHQP7IfCuGbBcTbTZWJub8KvaabyHwbL+g
	 T+9/kmO5mSa9o9PceIlDbyfvPH/xLP9I8kdYjzu3R84z+C3xhAaFf1qMyKqetmhJyv
	 STY2pC2xoCBgTwBRzp13WuoKpg5reP+2GRzRZLY+uDzVOXPZMUC6KbfsmmvtCb0FRW
	 +LOM+r2OebK1AJbEcmk00VDMtlVmGyjrz88CAx5jLjYlmted1F2PKkAByVI+rN8d4D
	 sJVcT111VE11w==
Date: Fri, 15 Nov 2024 08:39:55 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] fstests: move fs-module reload to earlier in the
 run_section function
Message-ID: <20241115163955.GD9425@frogsfrogsfrogs>
References: <cover.1731683116.git.anand.jain@oracle.com>
 <7af8f80173fab5408da86f5b3393e787659a81d6.1731683116.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7af8f80173fab5408da86f5b3393e787659a81d6.1731683116.git.anand.jain@oracle.com>

On Fri, Nov 15, 2024 at 11:20:51PM +0800, Anand Jain wrote:
> Reload the module before each test, instead of later in run_section.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  check | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/check b/check
> index 9222cd7e4f81..d8ee73f48c77 100755
> --- a/check
> +++ b/check
> @@ -935,6 +935,15 @@ function run_section()
>  			continue
>  		fi
>  
> +		# Reload the module after each test to check for leaks or
> +		# other problems.

Hrmm.  The nice thing about doing the reload /after/ each test is that
unloading the module will purge any per-fs slab caches that the module
creates.  The slab teardown logs any forgotten objects while $seq still
points to the test that leaked those objects.  Granted it's not a 100%
solution (that job falls to kmemcheck) but it's a cheap check.

This change makes it so that if test N leaks something, fstests reports
them for test N+1.

--D

> +		if [ -n "${TEST_FS_MODULE_RELOAD}" ]; then
> +			_test_unmount 2> /dev/null
> +			_scratch_unmount 2> /dev/null
> +			modprobe -r fs-$FSTYP
> +			modprobe fs-$FSTYP
> +		fi
> +
>  		# record that we really tried to run this test.
>  		if ((!${#loop_status[*]})); then
>  			try+=("$seqnum")
> @@ -1033,15 +1042,6 @@ function run_section()
>  			done
>  		fi
>  
> -		# Reload the module after each test to check for leaks or
> -		# other problems.
> -		if [ -n "${TEST_FS_MODULE_RELOAD}" ]; then
> -			_test_unmount 2> /dev/null
> -			_scratch_unmount 2> /dev/null
> -			modprobe -r fs-$FSTYP
> -			modprobe fs-$FSTYP
> -		fi
> -
>  		# Scan for memory leaks after every test so that associating
>  		# a leak to a particular test will be as accurate as possible.
>  		_check_kmemleak || tc_status="fail"
> -- 
> 2.46.1
> 
> 

