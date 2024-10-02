Return-Path: <linux-btrfs+bounces-8443-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFD298E241
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 20:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F7DDB20E57
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 18:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FEA212F0D;
	Wed,  2 Oct 2024 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="plFYqKSw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WMKUHc8/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48801D0BA2;
	Wed,  2 Oct 2024 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893329; cv=none; b=NL2078DnWoAS8AlA3G7Rir0yBf5a1OkQNuqYrTXPeBQStYo/YW6MhIkm4+xmHon1YqSiI1dKtC4n1kzFM6pyYUI/RJne7f5vLeaUtulNaTtHHnFgh/Su57T4SxsNjnxNeadv5H23qUsEIoxEe98k2qrwQwBwEz5y8vxrjadrasI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893329; c=relaxed/simple;
	bh=qW5XGJNWukWV2cu8q6blemjUI23kK8hdA3Qc6ivw+7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSaeL4ntZjy2F2unST1KvIqdF7i8d+ktHPZ1QR/ItXTbQSoBX/zaqzqexqgMNTsgTqFVxbdIlenzt33m85AQ47/abF/jaJ9z0Q7OPpAP6kLEq+/s7skTrieHRpViJe3WlyUSTL1QSoFdm1AO6gbx8lXMAvLc0xHZhLYkmgjgWh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=plFYqKSw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WMKUHc8/; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED6451140134;
	Wed,  2 Oct 2024 14:22:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 02 Oct 2024 14:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1727893326; x=1727979726; bh=bHJ+t0+t0X
	kq8wcHuMTyU6aFPL2QfGUL4rtBF/EsVKM=; b=plFYqKSwIxu74FZiOo9JT2gnBq
	gvGtHJVDpUIVL0pJWqvkUcua4cuWKWTXrietjxf9nxNMhu7BYWMYoixXWkOVYNua
	nCSgfu48VOXJ93EsFbpFv/s7tqjZbNN+PLxJ1npL6f3d+0wGWrvtZc8J6jE/ngVE
	zybcsyyy01lkz8foPkHBeCyKIQtT+Vyt2lgT5XUDzubvZu90Re3G1OL7T2uPN67z
	Qe+2skqPmwoZO6VKVBFKAH8AYnmyV4/jfr9CyHToNk+IgNkgx5GOkkTtlXppoi7Q
	oqtnmIKMoxiW6rOVl6yg97T+aCtiR01ab8CgwdppfUmIL3OVMU+yVSFKXr6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727893326; x=1727979726; bh=bHJ+t0+t0Xkq8wcHuMTyU6aFPL2Q
	fGUL4rtBF/EsVKM=; b=WMKUHc8/tRmOmgXV45BFCeHYb020wtSmMfzRhKcknk4m
	Tco5bQS67t02hcegxXsmgaY9faLTbCza+QZfpnkSV56tTaglWSmZeoLGhTi1AiT3
	4sHaQZG/yYp7QpE81pnizuDmAUsPIgTGCy5aPTarj00cc8bS+tzwFUbVhYF38GeO
	OlzFCpdaTNlC8oHG+VU/JUXZu1MLvGUxavV4xzhN9LSJwFHVO1fF13ZadbZhYjjE
	r2KN91SCYq4KQoH2bKWtmmjwK7X4J2B+jUYPQqBvBFZlH2gYJ/aB/NUK37yYt3mn
	rPkpondhjH55AdEFM9eoxBtBCuENFnoGJoJiEc5Ojg==
X-ME-Sender: <xms:To_9ZpPDPcUzMq-PIDL3leESOFpTlhQyIdu1ga4o5aAf4ujtc4nVbQ>
    <xme:To_9Zr9zfIZRKDdCIoAnf0qD5ZmFHMGT_ZD7CBKy0BgOajxFZ3BuasF4Sdafvdh1b
    G54EcwSSaMjItJNlHQ>
X-ME-Received: <xmr:To_9ZoQ6b2DM_uFYCKm8T22-PtC5KbmOr6xm27nI6_4iUDOqWx6faZLRfjR0otXqk3DEbF6G1Qe990d4x1rKoEK34OU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepudetjeeghfdvjeejfeejteelueettdehvdfhleefgeejudef
    jeektefgfeehteefnecuffhomhgrihhnpeduuddrshhonecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrg
    hnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhsthgvshhtshesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepfhgumhgrnhgrnhgrsehsuhhsvgdrtghomh
X-ME-Proxy: <xmx:To_9Zlvugaxyd9RaxCa3Y4kJTjPI_s6S-gNUNM8mQ22LaOJbQZx78w>
    <xmx:To_9ZhcDoBHu8MFtS3AxHcW56dA3_dVi232OcQ8VXWwTBQNlOA3DVg>
    <xmx:To_9Zh2XApCJl9H7ZLBfYd8kuihXDlgCTCbgzu07IaIZh9DRvOwi6g>
    <xmx:To_9Zt_2N4yAeNIVQdaH9DwTTHOrVk3UyfBUUUkJwZR_NYOS_JJtXA>
    <xmx:To_9Zo7it1m6cQ2Xyg59iSQ3m_b6wkNzcCGT5HLSTVjEa3yutdKjHGGB>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 14:22:06 -0400 (EDT)
Date: Wed, 2 Oct 2024 11:22:05 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: update some tests to be able to run with
 btrfs-progs v6.11
Message-ID: <20241002182205.GB3917419@zen.localdomain>
References: <7914963e2c04a864edc45d7510de515c59b4fc95.1727882758.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7914963e2c04a864edc45d7510de515c59b4fc95.1727882758.git.fdmanana@suse.com>

On Wed, Oct 02, 2024 at 04:28:49PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In btrfs-progs v6.11 the output of the "filesystem show" command changed
> so that it no longers prints blank lines. This happened with commit
> 4331bfb011bd ("btrfs-progs: fi show: remove stray newline in filesystem
> show").
> 
> We have some tests that expect the blank lines in their golden output,
> and therefore they fail with btrfs-progs v6.11.
> 
> So update the filter _filter_btrfs_filesystem_show to remove blank lines
> and change the golden output of the tests to not expect the blank lines,
> making the tests work with btrfs-progs v6.11 and older versions.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  common/filter.btrfs | 5 ++++-
>  tests/btrfs/100.out | 2 --
>  tests/btrfs/218.out | 1 -
>  tests/btrfs/254.out | 1 -
>  4 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/common/filter.btrfs b/common/filter.btrfs
> index 5a944aeb..6c53dffe 100644
> --- a/common/filter.btrfs
> +++ b/common/filter.btrfs
> @@ -30,11 +30,14 @@ _filter_btrfs_filesystem_show()
>  		UUID=$2
>  	fi
>  
> -	# the uniq collapses all device lines into 1
> +	# Before btrfs-progs v6.11 we had some blank lines in the output, so
> +	# delete them.
> +	# The uniq collapses all device lines into 1.
>  	_filter_uuid $UUID | _filter_scratch | _filter_scratch_pool | \
>  	_filter_size | _filter_btrfs_version | _filter_devid | \
>  	_filter_zero_size | \
>  	sed -e "s/\(Total devices\) $NUMDEVS/\1 $NUM_SUBST/g" | \
> +	sed -e "/^\s*$/d" | \
>  	uniq > $tmp.btrfs_filesystem_show
>  
>  	# The first two lines are Label/UUID and total devices
> diff --git a/tests/btrfs/100.out b/tests/btrfs/100.out
> index aa492919..1fe3c0de 100644
> --- a/tests/btrfs/100.out
> +++ b/tests/btrfs/100.out
> @@ -3,9 +3,7 @@ Label: none  uuid: <UUID>
>  	Total devices <NUM> FS bytes used <SIZE>
>  	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>  	devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test
> -
>  Label: none  uuid: <UUID>
>  	Total devices <NUM> FS bytes used <SIZE>
>  	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> -
>  === device replace completed
> diff --git a/tests/btrfs/218.out b/tests/btrfs/218.out
> index 7ccf13e9..be11074c 100644
> --- a/tests/btrfs/218.out
> +++ b/tests/btrfs/218.out
> @@ -2,7 +2,6 @@ QA output created by 218
>  Label: none  uuid: <UUID>
>  	Total devices <NUM> FS bytes used <SIZE>
>  	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> -
>  [SCRATCH_DEV].write_io_errs    0
>  [SCRATCH_DEV].read_io_errs     0
>  [SCRATCH_DEV].flush_io_errs    0
> diff --git a/tests/btrfs/254.out b/tests/btrfs/254.out
> index 20819cf5..86089ee3 100644
> --- a/tests/btrfs/254.out
> +++ b/tests/btrfs/254.out
> @@ -3,4 +3,3 @@ Label: none  uuid: <UUID>
>  	Total devices <NUM> FS bytes used <SIZE>
>  	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>  	*** Some devices missing
> -
> -- 
> 2.43.0
> 

