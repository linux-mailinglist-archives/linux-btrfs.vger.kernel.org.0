Return-Path: <linux-btrfs+bounces-14421-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FE0ACCD6B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 20:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DDA3A5609
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 18:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C163020371F;
	Tue,  3 Jun 2025 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="TKK08O9r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o37oHaMb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546A2C327E
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748977058; cv=none; b=J4bUpvGdCUFSAgIVW7XgD+DaA5DzfEbX4i06Q4mGB/oGAnLDEXBSQw5+2l5g1uh+B2rRdBw58gO1Ln3Qfzr7YU9kgNkcB9NMu6ubncvIfRTFJv5I9FeUdbHWxw3nI9CILBd8SNWZRNsY604Udv/aR7uTETqvs7K4t8d/MLkEv40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748977058; c=relaxed/simple;
	bh=wZCH9olUUvpy2HNPlV3P2JnQvbuK/LWjlanrnITJXZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+T0yfmKwL1DKWYuseDFtC4PATRZK5w81ptdO/tkapuNgq000fbTV4fiKVT+MRo0uMbyZjBX5DdmfWdfVQ7ZcXHi4pFNAFalrUiOyp3QPgXnaX25dSjNrdrGdAO2y4hxWSmS100yykubnCclQAb/2T8sKCsfeaR/Z4UFpw01wzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=TKK08O9r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o37oHaMb; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 778A32540109;
	Tue,  3 Jun 2025 14:57:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 03 Jun 2025 14:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1748977055;
	 x=1749063455; bh=srfWsUIb87R9BXdjso3S8pbEId78+sk+Ryq22hMgCbw=; b=
	TKK08O9rZ8ckf/qlApSsaZLz597yop+iVGfxFbtUUZ/Yx9ijtVjgF9RpXkU2S456
	APMgPpCAzDoOgBeUoIgXsiJ0JoX1/rWVvOc6FXt6IWxOFZ3gdZAzpDUB2Kdz5Y2x
	aZM6wc8cZ+NoEi5Od3Sv15k7QRNtz1O2kSDkk8sGSOk36XauYHNHVzTBhAkwEOc3
	DrDM6d4xphKULXHJUqfLUVQ5oxfuAeMq2BTIn/zBngRekYuKYMNsfLFDMnj+lez9
	XMV+3iu//+7gKkhoI4xHyOpmlVZ/n9bQbYyqD4z21k/WnQ6GdQS59GV21Flpfmfd
	ZaWMvt8HzVyLH/3N5VaW2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748977055; x=
	1749063455; bh=srfWsUIb87R9BXdjso3S8pbEId78+sk+Ryq22hMgCbw=; b=o
	37oHaMbSP+f98O5MVlpuf4HAOu4rsiAlR0if7CHON5VJxykREjKPwqvinpJESXOb
	jD+HNVRo7hRs0HFsnqvi/DyrrzX2MjRp0AHGoupksxChEC6h/jorOd4gHD+Zq9TC
	+yy5u375VPApfa4shHj+/vy0aHNZ3ItFRa86LYvWnp3r2pYmGjxHdUI+2253Do5/
	glQH2M266uIzF99Tx3EEMmvo0YEzUkREZ4M1+4Q9YMlCz1MUn86MNX+W3SEgh5OX
	u+pLQ2rFAVAuM4esI5PtxFdlyWkEH7Mg86jIYb2YMCLOpByPexzGOeslYBaA1mR9
	hC88Du1MTuoKjygBZCV/g==
X-ME-Sender: <xms:n0U_aIUAJlD0y1TqGpWrpY5RSYeGKZGCL_X0zd1sJEwsbMtA2WFz-g>
    <xme:n0U_aMnSN10Obvaq5RnXzGABIu0KrjP64x8HTw0am-hm6PWy1WPmfgFb54ZDCbiQF
    2DpV6MLFSLj806pl6Y>
X-ME-Received: <xmr:n0U_aMat0W6VZQtWyNtxL5g_2IlQZwrW1q3m0JsXMXdwCiSOM6uAGsuxa-IznJbdLfCHMKNoMFq8kTewUnmKtJHETgk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenuc
    ggtffrrghtthgvrhhnpedulefhtdfhteduvdethfeftdeitdethedvtdekvdeltddvveeg
    tdeuuddtiedtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtohepoh
    hhrhgsohhtvgeshigrhhhoohdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhs
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:n0U_aHVN0rz-_Whksed0e0oymVGGKqUrA8Ma2Gu9GTKmgTBGh6rvkQ>
    <xmx:n0U_aCndQXENeYFYtOAbYoPHWsUJ-l--Sqpu7iGXb8PAs--98GX2xg>
    <xmx:n0U_aMeccFYufTlVK0ltX5UK8FmqAKT-112gTyTYKIqcfeI9_bJWgA>
    <xmx:n0U_aEEc34ZDtBnv-GYyEqViBBxZvZIcY--csfHWxj2bC0p0Nf2AaA>
    <xmx:n0U_aJU-N40o0nqAR_9_T4Pa27Sz-rhaFUvlfml5D1AaU4lUjEmVY902>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 14:57:34 -0400 (EDT)
Date: Tue, 3 Jun 2025 11:57:32 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: "ohrbote@yahoo.com" <ohrbote@yahoo.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Problems mounting btrfs
Message-ID: <20250603185732.GB2633115@zen.localdomain>
References: <1272487245.3927281.1748871755247.ref@mail.yahoo.com>
 <1272487245.3927281.1748871755247@mail.yahoo.com>
 <62d4ff91-d65f-4105-8915-3ede238d33ee@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62d4ff91-d65f-4105-8915-3ede238d33ee@suse.com>

On Tue, Jun 03, 2025 at 08:34:59AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/6/2 23:12, ohrbote@yahoo.com 写道:
> > Hi there, two days ago my computer had a kernel panic and I needed to switch it off the hard way. Since then, when I boot, I'm greeted directly with Busybox initramfs shell. I tried to boot into a Live Recovery disk, opened my Luks container and tried to mount the btrfs filesystem. But to no avail. I attached some information and hope to find some help here. Thanks in advance.
> > 
> > recovery@recovery:~$ sudo mount /dev/mapper/data-root /mnt
> > mount: /mnt: mount(2) system call failed: File exists.
> > 
> > recovery@recovery:~$ sudo btrfs --version
> > btrfs-progs v5.16.2
> 
> Your progs is too old, please update.
> 

Interestingly btrfs-progs/Documentation/Feature-by-version.rst
advertises fs-verity support in 5.15. I guess it must have been added to
progs later than that... Can't find where it's documented which version
of progs supports verity.

> > 
> > recovery@recovery:~$ sudo btrfs rescue zero-log /dev/mapper/data-root
> > couldn't open RDWR because of unsupported option features (0x7)
> > ERROR: could not open ctree
> 
> According to the dmesg, the log-replay failed with some existing delayed
> refs.
> 
> Normally zero-log should clear the log and at least the initial mount should
> success.
> 
> But I still recommend a full "btrfs check --readonly" on the fs with latest
> progs. (after the zero-log run)
> 
> 
> 
> > 
> > recovery@recovery:~$ sudo btrfs check --clear-space-cache v2 /dev/mapper/data-root
> > Opening filesystem to check...
> > couldn't open RDWR because of unsupported option features (0x4)
> > ERROR: cannot open file system
> > 
> > recovery@recovery:~$ sudo btrfstune -u /dev/mapper/data-root
> > couldn't open RDWR because of unsupported option features (0x7)
> > ERROR: open ctree failed
> 
> All above tries are very dangerous if the fs is already corrupted.
> Thank god the older progs prevented them.
> 
> > 
> > 
> > recovery@recovery:~$ sudo btrfs inspect-internal dump-super /dev/mapper/data-root
> > superblock: bytenr=65536, device=/dev/mapper/data-root
> > ---------------------------------------------------------
> > csum_type        0 (crc32c)
> > csum_size        4
> > csum            0x0b234e5d [match]
> > bytenr            65536
> > flags            0x1
> >              ( WRITTEN )
> > magic            _BHRfS_M [match]
> > fsid            8e14c534-278c-471e-a714-37fcc6cb6e10
> > metadata_uuid        8e14c534-278c-471e-a714-37fcc6cb6e10
> > label
> > generation        3079573
> > root            2046672715776
> > sys_array_size        129
> > chunk_root_generation    3027625
> > root_level        0
> > chunk_root        2120474771456
> > chunk_root_level    1
> > log_root        2046734286848
> > log_root_transid    0
> > log_root_level        0
> > total_bytes        246373416960
> > bytes_used        224159674368
> > sectorsize        4096
> > nodesize        16384
> > leafsize (deprecated)    16384
> > stripesize        4096
> > root_dir        6
> > num_devices        1
> > compat_flags        0x0
> > compat_ro_flags        0x7
> >              ( FREE_SPACE_TREE |
> >                FREE_SPACE_TREE_VALID |
> >                unknown flag: 0x4 )
> 
> Your fs have VERITY feature?
> Did you intentionally enabled this feature?
> 
> If you have no clue what that feature is and have never enabled that, it may
> be a sign of hardware memory bitflip.
> 
> A full memtest is also recommended.
> 
> Thanks,
> Qu
> 
> > incompat_flags        0x371
> >              ( MIXED_BACKREF |
> >                COMPRESS_ZSTD |
> >                BIG_METADATA |
> >                EXTENDED_IREF |
> >                SKINNY_METADATA |
> >                NO_HOLES )
> > cache_generation    0
> > uuid_tree_generation    3079573
> > dev_item.uuid        114a9f2b-08e3-4f13-a660-31933f335bbd
> > dev_item.fsid        8e14c534-278c-471e-a714-37fcc6cb6e10 [match]
> > dev_item.type        0
> > dev_item.total_bytes    246373416960
> > dev_item.bytes_used    246372368384
> > dev_item.io_align    4096
> > dev_item.io_width    4096
> > dev_item.sector_size    4096
> > dev_item.devid        1
> > dev_item.dev_group    0
> > dev_item.seek_speed    0
> > dev_item.bandwidth    0
> > dev_item.generation    0
> 

