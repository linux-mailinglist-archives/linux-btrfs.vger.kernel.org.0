Return-Path: <linux-btrfs+bounces-4655-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7CD8B82A0
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 May 2024 00:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E159284B3B
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 22:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CE61BF6D1;
	Tue, 30 Apr 2024 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Kq8wNGgg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g1tkYUsS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE11802D8
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Apr 2024 22:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714515374; cv=none; b=dyTLfegwsikGTr9tUWSkE//1qLad20za1oo6nSXYUT1FQ6s4h29mZodWXM6ywPCdEd4NVyJWjyvpOG6TacXPC1723wIOzE6GBf+NhaNb3a4n6imTcwfaxbOKHR15xdm+mXnwJaM5M0TjsEcnRzb53ZWLjefaJblxpjrfJuMWUNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714515374; c=relaxed/simple;
	bh=e/CcXsNQn0vaQKHsOzEyZoj9i4a3iSlKxalTu2LNTkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxoa1Bly2HzxV4Qqub77UN4vxW1eNZMvZoN5bp6prl1eFntFxhmmwtggs/du4dz36JS9E5wQ1y2lzI+00O7mfxm696AhTodPIrG2qb4+UQTu6W/0Na/eai0OqLOeMovcQGHpyNquVzqUQE9Fpeu9UbEDeKDTLhJucvJQOczi6vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Kq8wNGgg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g1tkYUsS; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id C360E1800137;
	Tue, 30 Apr 2024 18:16:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 30 Apr 2024 18:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1714515369;
	 x=1714601769; bh=RPf9GFvcLK7k31/JtnUNmqbUYuSBKN+LwXrElZQl8q8=; b=
	Kq8wNGgg9FaQprWvCFMUUS6SmHUOMFgDHGeJu8TkemN9WOOaX/V4pI3YvWZGoZ46
	d9LR7HoQlT9Uj1gFjD0qzvCDeTjVDiek7yJJyPGYv20COXcwA50TFlGaqe9YBnHG
	53dCT4wS49JRVCyg03IJM+OICfdTZijUigcqu9a0/2BiTf+SIpk+kj4tW9YBNGHf
	jWBY39KNimhHjdMFTDTMeAw+aZfqNJeaRkCsbJ+OJL1TuKnNedPKJ6tvO0l2qZ/L
	RlDBGgtT0502TqmeY1m+A9ud8Mio8E4DCCEMNjKkTC1yWsvtNnPY0sfrAU26THp1
	f1bpQjf6QvqB0RoRPZREgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714515369; x=
	1714601769; bh=RPf9GFvcLK7k31/JtnUNmqbUYuSBKN+LwXrElZQl8q8=; b=g
	1tkYUsSzbWkkOHKDfQA4B1aYl0sJfpslHQYHU/00mLk9U4JtZ7Gruif3NC2SUfDE
	sD5vriXZ8v/9duFebSOLkUQYrJFpAyQUUUfnUYGsPPavc2ZrWmnkbK546rL8Jxe0
	r+WRFP1G2JFUTUorRV71Sb9jWBpN/F56D13axu1EkAy7bi9cPiw8Q2ZHyzOepkpF
	Jal0J52utIzi2TPoLKVHCXwnJFjcUqqEjk39SOVC6lMxZ7ceVZWMeclrFhsm5gb0
	JxHxqCvK9APKipWZf95QPNKLL/UqFyo5ymADcV98uDXHSFSkh+289qZ2005Bgt8Y
	LHCfeYhfw7kq0I6lJ42Eg==
X-ME-Sender: <xms:qG0xZrXDwEuDE6S6hYINunOtfoi995RzEIKLaY3QITiSPMb-qV2YSw>
    <xme:qG0xZjkOuhkVVwS5UQ0MVXtsHbiBCVh5m-F12TciBo-PquQWwjyXZwKIGFHghy2OW
    rHnU_8ymLTtg9jML78>
X-ME-Received: <xmr:qG0xZnac654J6RlyJntWDjDk8NiG0QFzGVqXgi06SmRkbE2Yfl5u3F-w9xrRZmAYftFDKEXdz2azN5m27pc_Sb2wDDo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddugedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epudelhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:qG0xZmUOjy4e9nigrksXl7wZMEOg2XpSDrLTDiRVFyhp9ixn52rd0A>
    <xmx:qG0xZlmjN3GArHhNd1lc4qZAs4l7YWKt_c3DW0wmCXy4MzOH80eX3w>
    <xmx:qG0xZjcfZXbkXw-DxxK0J246E58DLxSD0PpP8cou7jfcGMOucUKEcg>
    <xmx:qG0xZvFFay64GoXbCaUy7nCaZz8baCwvKGSvQZCtS66Bj6D0DQ9IoQ>
    <xmx:qW0xZuBBC7yXNJW90305rDoDkT_NYmK2PyC_Lyz7btc1gLFcXsziUKjv>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 18:16:08 -0400 (EDT)
Date: Tue, 30 Apr 2024 15:18:39 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
Message-ID: <20240430221839.GA51927@zen.localdomain>
References: <07e54de6747a5bf1e6a422cba80cbb06ba832cf4.1713519718.git.wqu@suse.com>
 <20240424124156.GO3492@twin.jikos.cz>
 <598907d6-77e0-4134-b709-51106dcfb2f8@gmx.com>
 <20240425123450.GP3492@twin.jikos.cz>
 <9df817bc-f3a8-4096-aabc-12044447a900@gmx.com>
 <20240429131333.GC21573@zen.localdomain>
 <20240429163136.GG2585@suse.cz>
 <f8d3bf56-0554-44ec-ac1a-2604aaf37972@gmx.com>
 <20240430105938.GM2585@suse.cz>
 <4a83b326-9cde-45f5-8a53-da7b62c45619@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a83b326-9cde-45f5-8a53-da7b62c45619@gmx.com>

On Wed, May 01, 2024 at 07:35:09AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/4/30 20:29, David Sterba 写道:
> > On Tue, Apr 30, 2024 at 07:35:11AM +0930, Qu Wenruo wrote:
> > > 
> > > 
> > > 在 2024/4/30 02:01, David Sterba 写道:
> > > > On Mon, Apr 29, 2024 at 06:13:33AM -0700, Boris Burkov wrote:
> > > > > I support the auto deletion in the kernel as you propose, I think it
> > > > > just makes sense. Who wants stale, empty qgroups around that aren't
> > > > > attached to any subvol? I suppose that with the drop_thresh thing, it is
> > > > > possible some parent qgroup still reflects the usage until the next full
> > > > > scan?
> > > > 
> > > > The stale qgroups have been out for a long time so removing them after
> > > > subvolume deletion is changing default behaviour, this always breaks
> > > > somebody's scripts or tools.
> > > 
> > > If needed I can introduce a compat bit (the first one), to tell the
> > > behavior difference.
> > > 
> > > And if we go the compat bit way, I believe it can be the first example
> > > on how to do a kernel behavior change correctly without breaking any
> > > user space assumption.
> > 
> > I don't see how a compat bit would work here, we use them for feature
> > compatibility and for general access to data (full or read-only). What
> > we do with individual behavioral changes are sysfs files. They're
> > detectable by scripts and can be also used for configuration. In this
> > case enabling/disabling autoclean of the qgroups.

This was my initial thought too, but your compat bit idea is interesting
since it persists? I vote sysfs since it has good
infrastructure/momentum already for similar config.

> > 
> 
> I mean the compat bit, which is fully empty now.
> 
> The new bit would be something like BTRFS_QGROUP_AUTO_REMOVAL, with that
> set, btrfs would auto remove any stale qgroups (for regular qgroups though).
> 
> Without that, it would be as usual (no auto removal).
> 
> Since this doesn't cause any on-disk change, it does not needs compat-ro
> nor incompat.
> 
> Thanks,
> Qu

