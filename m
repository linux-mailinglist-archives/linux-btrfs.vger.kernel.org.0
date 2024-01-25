Return-Path: <linux-btrfs+bounces-1815-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C7983D066
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 00:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8961C1F28189
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 23:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C4B12B8A;
	Thu, 25 Jan 2024 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="K4HOit9z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W9rZr658"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FEF79D9
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 23:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706224307; cv=none; b=c+Jz7EOlFaelQ1EygIeoRjAacDsC2xhQLR950ypmncZ1ypVmue4esSpywRftIkreukn6kiblEtkcDcvoZ+i9KDBJdP0O04EwkvTIAw/h8hoaIO6md15Ak1uxlbL6IXuU98utk5EZoiz6uT5QfMqucEehHlCQvUeoXLo3/9aO0yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706224307; c=relaxed/simple;
	bh=XpSix238hIYWMiONayo2BK9+zb2of/SmcUU14GOGotQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMSrPIJdUqcAB740H2WQplIvhsUj8rAR5hhoattfHYb9o+2iZf28ltQmdzvbnu8m5UPslyKu1l/s+0rsFr8brdT2ecXNuHqQjf9zCBzMLNGGGyCdPTznWw7DwsyrP79jEPv22X24Gu8sIE5QE3ThDTXRzcinbh9d9HcryfYoRuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=K4HOit9z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W9rZr658; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 420625C00A5;
	Thu, 25 Jan 2024 18:11:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 25 Jan 2024 18:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706224304;
	 x=1706310704; bh=AVP6K+sHijDf9GbCNo7EoFyoXb2bPv99F4Yu/2Yc5xs=; b=
	K4HOit9zHfHWMbOHOTVERU5pHxQ/l356+BNlBwCEL4kc1iDqCI6Brt+jOT6VnxjN
	4Fn4qhzC39PNSav1/nSrbmDsNZ2KsOclmP9cWhdOKhNRLGUbiyDdiER6+ux0tkP8
	e3ybaFAWNXzG4NWgn005piz9yld+tVVwz8mFY5ICFQ7TjN/CYy2UjdA8XXVKJ9bv
	jZ851OB4SJGVW+ZS3bdDth6zdZ/+x+3R22JKKzFNMJznT7D7u1S9TRTxNr/nf/ft
	uW1LRB9Xe7WFeJOpHmJSo1Rs6ntFq+uxfVRUTKEPACrcj35+5xYZsku9ofn+WtkS
	sa1xe0RtHaG29MXpkejmbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706224304; x=
	1706310704; bh=AVP6K+sHijDf9GbCNo7EoFyoXb2bPv99F4Yu/2Yc5xs=; b=W
	9rZr658wszRiS9ShYufoYweNBr8NEF7rm0XT0lzT1WNVCWHmQfssSLRUpd1nTdbg
	+YUSE76aYWDsKwuRXDqY33YDsambWKnG0U7b6qFpMkgG6LLwJ/CH0qJONhDVbvqL
	0EqXtPBrAFU1n/iQO+xj7LrOqQZkhLT1Nw9y78OGQ08pB/ByXMqwgbU0fzrJXSX+
	Xff73vzR7630iWaskfOvTpwxZbxU3GJ7W2xKlSrB3fsSXGqaJe5Nwi/HvhNCcawg
	IaOJDrkEcfsalT56wylv5vuqtO557xYE5E3dN4g34feAEtmNK3TykCWj3RpOBCu5
	dXjljD4SueN9sMrXI2pjA==
X-ME-Sender: <xms:r-qyZQbtJu50XoGqyve8f2IECzJJdoYnca5-Zf-0E_wJ_OYYcXbapQ>
    <xme:r-qyZbZrBF3qrC64RZBDMcygq7nBxz3sdl8ejHdsh5CXtnaTsJ_nJxY0dgd1y08Cx
    KdaPLO59unNHkPzFkg>
X-ME-Received: <xmr:r-qyZa-4z6o7RiZpDcawPNXRVnuD0ZngzA9weguQAZvkMMfErIIpGAzbdMwu1vzKEVITGvb6PWj3jz9UPHZbCKHQ8W0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeliedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epudelhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:r-qyZapIlqLUPPa55Ag_i5pVjCT5vVC7YISbmdRUHfOwqjgF1rfxHg>
    <xmx:r-qyZbpwQeTPhZhS5lGGmiizWP_CFKIOSqkRfFVKXKb-WEsfsTGFyg>
    <xmx:r-qyZYS3grMi3u-yjIf53i3gNE-0Z5rmvrLdqVjle6XdbxChKWIAJA>
    <xmx:sOqyZS0bIJ8kb9VSwo3BJmOIxmvw3Uy60CsKA_WwJT9fbTwSQ2QEuw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jan 2024 18:11:43 -0500 (EST)
Date: Thu, 25 Jan 2024 15:12:42 -0800
From: Boris Burkov <boris@bur.io>
To: Neal Gompa <neal@gompa.dev>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: forbid creating subvol qgroups
Message-ID: <20240125231242.GB1851005@zen.localdomain>
References: <cover.1705711967.git.boris@bur.io>
 <eb79dcbe0cbfa7459b249f76818a5e5a08a42ea4.1705711967.git.boris@bur.io>
 <CAEg-Je_6RNUoFg-+btbBtrCZRE1uZ77g_1mdbCqtyGiSZ0vhMw@mail.gmail.com>
 <20240124163649.GL31555@twin.jikos.cz>
 <CAEg-Je8tyVCw5CnMiPfWC9td0FaOKTkRxVg4wQyk8TiLT2SPwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je8tyVCw5CnMiPfWC9td0FaOKTkRxVg4wQyk8TiLT2SPwA@mail.gmail.com>

On Wed, Jan 24, 2024 at 10:32:54PM -0500, Neal Gompa wrote:
> On Wed, Jan 24, 2024 at 11:37 AM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Wed, Jan 24, 2024 at 07:52:28AM -0500, Neal Gompa wrote:
> > > On Fri, Jan 19, 2024 at 7:55 PM Boris Burkov <boris@bur.io> wrote:
> > > >
> > > > This leads to various races and it isn't helpful, because you can't
> > > > specify a subvol id when creating a subvol, so you can't be sure it
> > > > will be the right one. Any requirements on the automatic subvol can
> > > > be gratified by using a higher level qgroup and the inheritance
> > > > parameters of subvol creation.
> > >
> > > Hold up, does this mean that qgroups can't be used *at all* on Fedora,
> > > where we use subvolumes for both the root and user home directory
> > > hierarchies?
> >
> > How do you imply that from the patch? This is about preventing creating
> > the subvolume qgroups, i.e. with the level 0 and referred to as 0/1234
> > where 1234 is a subvolume id. Such qgroups are supposed to be created
> > only at the time the subvolume is created.
> >
> 
> Because I don't really understand what the description of this patch
> implies. It is not clear to me what is actually changing here, that's
> why I'm asking.

Sorry for the unclear patch description!

If Fedora is creating/snapshotting subvolumes but not explicitly
creating subvolume qgroups (qg id of the form 0/X), that is fully
supported and there should be no issue.

More details, just to be extra thorough to make up for the bad initial
description:

In the qgroup hierarchy, level 0 is special, these are the so called
"subvolume qgroups". The qgroup with id 0/X is the qgroup for the
subvolume with id X. When that subvolume accumulates usage, it will
always be reported into that qgroup (in a hard-coded fashion in
fs/btrfs/qgroup.c).

This patch prevents users from explicitly creating subvolume qgroups
with BTRFS_IOC_QGROUP_CREATE.

This does not affect the existing behavior that creating a subvolume
also creates the corresponding subvolume qgroup.

examples using the btrfs cli to illustrate:
# create a subvol qgroup explicitly; EINVAL
btrfs qgroup create 0/1234 <mnt>
# create a higher level qgroup explicitly; OK
btrfs qgroup create 1/1234 <mnt>
# create sv with id X and qgroup with id 0/X
btrfs subvol create <mnt>/<sv>

The basic motivation for both of the patches in this series is that
qgroup lifetime is more complicated in simple quotas and these are
relatively unobtrusive changes that make it (a lot) easier to manage
without affecting any known useful classic qgroups use case.

Thanks,
Boris

> 
> 
> -- 
> 真実はいつも一つ！/ Always, there's only one truth!

