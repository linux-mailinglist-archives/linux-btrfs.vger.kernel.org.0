Return-Path: <linux-btrfs+bounces-19497-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D48ECA1A71
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 22:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2C77301AF7B
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 21:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B234C29E0FD;
	Wed,  3 Dec 2025 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ZpRDg4+n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jsG3zAqi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A02158535
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 21:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796715; cv=none; b=KhGVH88BuBg3YE3wowoBzN0DbIm4X73BLWnTeWEaubnFa+4WxiTyBXrcM4CiWQOI9oeY4qKGurLT2kRU193pcd1eF+ywnF9kC/WDxe9MhzOhxqK2c6sCHhI0a45Ecz/KqyhDGSwiS2hY0KxPvQPlL6urOYbKZqJmBMtZp/dAT8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796715; c=relaxed/simple;
	bh=N/ugC4WVZZQBxxgYWiJse9nf2e3P9g1ZwnZilWbXtHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdFll1LYNz/fGYgc+aXIwYJB261iFXxCOvt2Gtyzk4zSO+anl1U+6gUBjW25eRdCne1/NU63pylTc36f4huOpeamI7AQw2lcAdN49RIvgXG5aFTsrM7l7nqaD5VGYPzAtZwtlfYg5Og3Y/nY6jGb2Q/0woNqoTPeWV9VZ4B84Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ZpRDg4+n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jsG3zAqi; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 457E87A0197;
	Wed,  3 Dec 2025 16:18:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 03 Dec 2025 16:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764796713; x=1764883113; bh=NND5Ww38pH
	gZvrpGfzG30qTZeVfpQqrxir/oN43qIrE=; b=ZpRDg4+n3hfPqL4GhGAhzml668
	N8CN1QKmPTObU/ZZh203II1A+aoD9gEpiZJm0RS+0MQU9+yhSGg0zakylPGyYlrY
	XCIRNVd7Li994fWrpu3sdZg4j98p914VSaVg7YeF51A9s9bfsIoh26Bzr6T6jdB8
	coiLgY7rDbUlfaOXpPteMZffbWUKE8CW/xsAN7TQ2d6iVjcynR6iGHRbe3CKWiJL
	VWvcSuQOdYi5jqa6+kWEglX2jt+TA+1DtCCLepz+uvdqAf1cFzTIXSen0gUFnrCi
	ceLi6k5QCsYg2ogDO5vpSLG2tVzCohU+DdLcbdnX676N8T8lX/UE6QG1M5ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764796713; x=1764883113; bh=NND5Ww38pHgZvrpGfzG30qTZeVfpQqrxir/
	oN43qIrE=; b=jsG3zAqiEgGiKAoG2CukRN1glGahVfEeBHTwssnIZsc6CegRlmj
	o1KeZW5HzPACHgObMYjchcm4/Zuuv93T5mwOyyDp3e/bhXySvYOEmAgSFQQD1Byz
	d2q36zd+3W2b/0hE96Tz6KiCJYpRcqRJGm/vXEkBN1xZ0k3k8EHDnqdWu7ttXys9
	V2ZF0WX6RPGXzegOhb1Uwx1S+JOLIriAaG+ReVmr9tTKdgY++hB+tmYxCDJ2IMfM
	l9ocn8d6H6FAU/6670yLd0vt/hTHDPkb+8xIn/NQ+DpKjeLZiD3ynpRJIi1TvQbv
	yO4//j30jpCNaDZcryBM3UAjy7WbxGiOOLQ==
X-ME-Sender: <xms:KakwaSUq7jU7vWhvzyfFrN_-YU61OE0nveCKD-IaXgogdUvs7QYuxQ>
    <xme:KakwaUnP9LhrwiOC2rYBBrewZzUH6Gf1OmkC2GH7ybWB-G6ZNi2BN6VTKRLQ4T5AZ
    DURq_kbL2vitaMYqDBN6wPyeD_ajNnozPwAscqWLbbXgNNI9zXxs8um>
X-ME-Received: <xmr:KakwaUDODEwQUFScMxh8YtVBO70Lp9PjEd0aIel2g_pFF0kvgcerIaNLjA9HNoaG35l_jLWz2b1gdir_P86JYSb0fU4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcuuehu
    rhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvdekff
    ejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrd
    hiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    fihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KakwaUeam60XR4Q613JMAv3xgcfXgh7FqkVZ19kTk34Bz_4tQOxnGA>
    <xmx:KakwafL3Fm0G_AZRcU6P3N2Jb5uglC7pr3K8Kd_NK9DAtcvsxGJXZw>
    <xmx:KakwaXfpOiJfEOOLumiH0H1q0BIvAGZITmGcjzvxTN-rLI4TaLXVtQ>
    <xmx:KakwaW0EH8j4R0Iu1NOrbmJji9Nr5rhCbXx_T9ZjuDLUdBzEVAzjQQ>
    <xmx:KakwabCQfM53LjDJdg81zNqM6APgPs3KpH5KcfmuplIybMH_2c-gSIcF>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 16:18:32 -0500 (EST)
Date: Wed, 3 Dec 2025 13:18:52 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: do not output extra lines about mismatching
 device numbers
Message-ID: <20251203211852.GB3589713@zen.localdomain>
References: <be9450a6d18fc29095db1145033f3805877f6143.1764237166.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be9450a6d18fc29095db1145033f3805877f6143.1764237166.git.wqu@suse.com>

On Thu, Nov 27, 2025 at 08:22:48PM +1030, Qu Wenruo wrote:
> [BUG]
> Fstests btrfs/218 fails with newer btrfs-progs:
> 
> btrfs/218 2s ... - output mismatch (see /home/adam/xfstests-dev/results//btrfs/218.out.bad)
>     --- tests/btrfs/218.out	2024-11-24 18:04:01.137258508 +1030
>     +++ /home/adam/xfstests-dev/results//btrfs/218.out.bad	2025-11-27 20:19:21.653781264 +1030
>     @@ -2,6 +2,7 @@
>      Label: none  uuid: <UUID>
>      	Total devices <NUM> FS bytes used <SIZE>
>      	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>     +found more devices than fs_info
>      [SCRATCH_DEV].write_io_errs    0
>      [SCRATCH_DEV].read_io_errs     0
>      [SCRATCH_DEV].flush_io_errs    0
>     ...
>     (Run 'diff -u /home/adam/xfstests-dev/tests/btrfs/218.out /home/adam/xfstests-dev/results//btrfs/218.out.bad'  to see the entire diff)
> 
> [CAUSE]
> Commit f1115bd7fd1c ("btrfs-progs: count devices without SEARCH_TREE
> ioctl in get_fs_info()") added a new message which will be triggered
> every time we're calling get_fs_info() on a fs with a seed device.
> 
> This message is not really necessary as we know this behavior already
> and is doing device number counting to handle such situation.
> 
> [FIX]
> Just remove the unnecessary message which is confusing and lead to the
> above golden output mismatch.
> 
> Fixes: f1115bd7fd1c ("btrfs-progs: count devices without SEARCH_TREE ioctl in get_fs_info()")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  common/utils.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/common/utils.c b/common/utils.c
> index 3f7bcc0d07f1..23dbd9d16781 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -208,10 +208,8 @@ int get_fs_info(const char *path, struct btrfs_ioctl_fs_info_args *fi_args,
>  			if (ret == 0)
>  				count++;
>  		}
> -		if (count > fi_args->num_devices) {
> -			printf("found more devices than fs_info\n");
> +		if (count > fi_args->num_devices)
>  			fi_args->num_devices = count;
> -		}
>  
>  		/* We did not count devid 0, do another probe. */
>  		ret = device_get_info(fd, 0, &tmp);
> -- 
> 2.52.0
> 

