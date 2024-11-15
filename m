Return-Path: <linux-btrfs+bounces-9732-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D139D9CF18B
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 17:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890EE1F21479
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116A71D5AB7;
	Fri, 15 Nov 2024 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOTpFpPA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D7318E047;
	Fri, 15 Nov 2024 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688447; cv=none; b=MUS0iy/zML3buYOO35sZJNZvkfRzsFH6gZ2hqajO9Lsntf4NHumnWRSqPSByGgaMJDq7HHKF4Qe4m06V4G3Jxtv+uz08wCn9c/rvzATAzl+/d/YxC5OM/XNuuU1xmQfhBqQsbFIAHBqJaiKtWiN2rsWf2C00Etd7LPXiwRjSg8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688447; c=relaxed/simple;
	bh=EfCiItxR74LnsIbYxtiA9HrwkYKGOBivEp0VvjCF/ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKOPV3xWvV8K9+HpiU/vpPGw982Jawj605MYIv19KfOgrmFrwlaO0S1tUdS1D//EVDrfTW4MH4WbBZEuBf7BohcvtOUEqpDIFotpMPTe+FNxW8Bis1HpzbpBLrRVOKAI51bEFqC/1xqhKB0cjy490RjOz3aGrqrK9Ig3PHnSv1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOTpFpPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8A3C4CED5;
	Fri, 15 Nov 2024 16:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731688446;
	bh=EfCiItxR74LnsIbYxtiA9HrwkYKGOBivEp0VvjCF/ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jOTpFpPAhF6d72GSE3QhTgRHMAILPS7esgeplOOw78lpbq3SnDviIfn3q1FI7zBti
	 tQb0vGYAXSMeLch3BJ3NxqyYcOFlz/ALya9e+UNoTXtRAOzNUCsuy3hN04EnKpUpWe
	 9ed9xNaVhetiX8NJM0AEVsC3+8a8UJ94fLEVzuMk5IAqAi6/bBIKSBGLkgMxm3qNV9
	 NcLbo4Q/Ie2bSl31k5AvmYmUff4hTO+Glk4Hv9GqLWS461AgdqzRGy4lZudqO3tvel
	 LwJRqp+7nodGyaKyXvcGq1L1g9Kt4WG//aXiHAfP0Cutsy0IU6QnaoUy2rGW8XrGG3
	 sraMc0Ux0poPA==
Date: Fri, 15 Nov 2024 08:34:05 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] fstests: FS_MODULE_RELOAD_OPTIONS to control
 filesystem module reload options
Message-ID: <20241115163405.GC9425@frogsfrogsfrogs>
References: <cover.1731683116.git.anand.jain@oracle.com>
 <2a9d4263abc83059fc911198dd2adfaee89ac8a9.1731683116.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a9d4263abc83059fc911198dd2adfaee89ac8a9.1731683116.git.anand.jain@oracle.com>

On Fri, Nov 15, 2024 at 11:20:52PM +0800, Anand Jain wrote:
> Extend module reload logic to allow passing additional options via
> `FS_MODULE_RELOAD_OPTIONS`. This enhancement enables more flexible
> configuration during module reloads, which can be useful for testing
> specific module parameters.

You might want to document the existence of this knob in the README.

> Maintains existing behavior for `TEST_FS_MODULE_RELOAD`.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  check | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/check b/check
> index d8ee73f48c77..ced86466a4bb 100755
> --- a/check
> +++ b/check
> @@ -937,11 +937,12 @@ function run_section()
>  
>  		# Reload the module after each test to check for leaks or
>  		# other problems.
> -		if [ -n "${TEST_FS_MODULE_RELOAD}" ]; then
> +		if [[ -n "${TEST_FS_MODULE_RELOAD}" ||
> +		      -n "${FS_MODULE_RELOAD_OPTIONS}" ]]; then
>  			_test_unmount 2> /dev/null
>  			_scratch_unmount 2> /dev/null
>  			modprobe -r fs-$FSTYP
> -			modprobe fs-$FSTYP
> +			modprobe fs-$FSTYP ${FS_MODULE_RELOAD_OPTIONS}

What happens if the test itself decides to reload the $FSTYP module?
Do you want these options to propagate to those reloadings as well?
AFAICT there are some btrfs/ group tests that do such things.

(Perhaps you'd be better off injecting FS_MODULE_RELOAD_OPTIONS into
/etc/modprobe.d/<somefile> to catch all these cases?)

--D

>  		fi
>  
>  		# record that we really tried to run this test.
> -- 
> 2.46.1
> 
> 

