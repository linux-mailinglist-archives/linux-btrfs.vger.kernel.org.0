Return-Path: <linux-btrfs+bounces-8565-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C93990C79
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 20:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492901C2074F
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 18:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E801B4F34;
	Fri,  4 Oct 2024 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="X1Bg27cT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="osyff4zq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB5C1F7074;
	Fri,  4 Oct 2024 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066200; cv=none; b=roUCiHd0L23WFRVUTMZpr8h4W3eayl4Tj0o3VBqf6ubZ2KjTb5NDcF4J1srGldvlZvKsmhRF+pqkLytEKdAnkE0sOxwWxV8Gj/KGC9RZ+nTBYeV96IrRO3dK9fBCa/+9Mb9eL0/hgG6vZatb6I9APar0g/hpNfFKdj1BUM9xnhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066200; c=relaxed/simple;
	bh=f9pwQPvx/rPwdHhmJ4Q58+vLobAox0Q7IvArZRqvKek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBksuaKdEIC0zaPvPuaM/chfTXbcDNZUHoozeRh3VLqcZPuBJdgtCuQ7z+3/gwtkLqNH3tDyTItdZsQH85UmxEMZY2My+1Cwdpx5zrNLbp9x4bPn2A9QmESgQ2v7gwRvNf8/XxhtBbUn1ZqGw3poVuUSZzxOiCSK9O5snfx9u4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=X1Bg27cT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=osyff4zq; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D1EC613800ED;
	Fri,  4 Oct 2024 14:23:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 04 Oct 2024 14:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1728066195; x=1728152595; bh=GAKeLZGwsJ
	M6MWwLz3hFhedwR8GEiSY6+IMds+Uzc8s=; b=X1Bg27cTEZsdW+ydB7RIRr+Gri
	SwoL10u8gsf+yDYSoLKLGhzmBQmTTDgroXbenjU0efOHUqVUl8Z3HM4Ghg2crL81
	DuumYR9XmziHR72t67jWbHqvEYfyxCpXbGs/GnbtLTUUdtAG4qKmmjsA80mc1Mpr
	dviauvJdK/Y8Ibiqufu8AGhLImpNiz75tYhMbhG42DMWfToJ9vlJDXz93ULWYqCY
	AUN74/uv5rhU9wl5Es29m4dJx9H1RKBRQtybvFRQujh95a0bGujxu3CTIcE9xBcE
	P+DVcg3jggS71Tp5fxYCvfldAE7utlQrc7Z20MK2JePiqdMrbtXY9cv/uFyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728066195; x=1728152595; bh=GAKeLZGwsJM6MWwLz3hFhedwR8GE
	iSY6+IMds+Uzc8s=; b=osyff4zq8hxagcbhtFSb5mSpVQfWlg1HHXn74J/GSEmX
	1aX64tVbews2F8vcYxPsLENdAj/yxMo5RLiE+8A5zJDRT2E9K1U9NP/QGznYbV3u
	NIe4sa76W7uu3TR44XgZ47dgjL2bezOZZtYY7D2MIuoJdd6DXhs86CpnrnR40cYG
	+g0USIY0bpATZcG60KHgvV9gB7jdgGubKoOTxWm9PHSUZVgfwkAkd2mqC0mMqao9
	gWJA0WFW49psB7gbf9Lfirs0TNw8hmq5fpm9Rz9gix2DjHoY0oMO7EpXoTudNr0L
	Ty6aKUpp1pL58VgvvQ8t1G7LC/ejuXe9oS03wPU0AA==
X-ME-Sender: <xms:kzIAZ3DA8ZYo6NFaiP9_8nLETlwkDH96J2hQQKwzdxz3TqJ_zCaM8w>
    <xme:kzIAZ9irCUeN-FDjw0tFTyfmH5ti5mzbWKW8cjeEUH8Ga-GNdkBeI4_DFN1lCnGou
    N_OxVpobUblEmnfv_w>
X-ME-Received: <xmr:kzIAZymTAqLRPdzXRDXyXH5NRqOutJsz2rIp2Jcq4666Axr50bcaAg54jwOsm8lixtGsHPWfK0sLi2IfnVUfCkpHRLo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedguddvfecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:kzIAZ5zq_sdq8xuccp4Xpmf5Pjha_jxrKiES1i7MpHsr7hyTfxCNIg>
    <xmx:kzIAZ8TQZfp6CsM2ySm-KNy6THQjtgzswVhHNol0xyS2gwlrYvHUFg>
    <xmx:kzIAZ8aXgASKl72i33rdHmAwxeUUqucrpKpz_S86lTnQx58SBRxa5w>
    <xmx:kzIAZ9QUQoReJHojf_T7N5fwp5dKJyUA7nVxiabBw8gGEe9e2dKxrQ>
    <xmx:kzIAZyPqCRu7CGiFFDK3SVokjQCz2DNNq6dpX-FxkO7lce5MUTRHxGJq>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 14:23:15 -0400 (EDT)
Date: Fri, 4 Oct 2024 11:23:10 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: update some tests to be able to run with
 btrfs-progs v6.11
Message-ID: <20241004182310.GA1779439@zen.localdomain>
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

I got around to updating my test boxes to include this and did a full
re-run and I believe you may have missed removing the newline from the
golden outputs of btrfs/006 and btrfs/101. Sorry if I missed an updated
version or something.

I don't yet see this patch in the various branches I look at, so I
assume it's not to late to fold in those two changes as well. If not,
lmk, and I'm happy to send a follow up later.

Thanks,
Boris

> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
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

