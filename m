Return-Path: <linux-btrfs+bounces-8907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3339499D538
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 19:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABFC1F242B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 17:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E1C1C1746;
	Mon, 14 Oct 2024 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ThTJ0fEX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C2W6HYqV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0A91ABEC6
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925403; cv=none; b=N8iRIzqVFvINSE4CD8odX8m/aqzSoTBdEJy69R+CIr74GT0FktzhNsSyaTrfCOIDvnVn9jjWWpr17Vz+kRYyVIJDqXdZi5Yc2vdCSUN0LG25Jv5Pt+aPpKvKPoQCntyTXKJrmSU7kicu4tom0nVEGN3OEhoGKOoRlynh5dNst4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925403; c=relaxed/simple;
	bh=7w07Kp4YAjiEIedPOiFgq6I6GJEc7NXtAAdV/Di3kTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o17sel9v5W5skXH+MEmaJMrRvaldrZFU8fV8DkYIev+k0l4RGPfQ5xneSRYxSYUFWwTXcors50ck+Oz/gPjLUALRco866QKu+417ncH7bdp2GJAWbu+hYx4vCD5+SRfpsmkwvOI2M085mC8Ff5J8O2r2lrtFbU5M0gU7dtC3BKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ThTJ0fEX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C2W6HYqV; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A9DA71140150;
	Mon, 14 Oct 2024 13:03:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 14 Oct 2024 13:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1728925400; x=1729011800; bh=8fUTk3Xq/C
	OGNIDaWj/CA2cpfz/85RmjRoxYUZVKPd0=; b=ThTJ0fEXmVlERqcPfNH+3If4/J
	PHcsadVgDd7OrdRee0tAlBHfd+M2HkfUmbgDwABNfI5Vf/zQrlws+ZXfxn20tK4L
	jvx+4+BXHWHjzuWt/i+xsUX+qrufqgYHiNoYicAvelaewbnt8bCKLd6QH3CiWTKu
	Oat1WT+8m986QgosOMxoSiBwHF93kcgA7gVq9eOd9aXlgYOIjn5HuJZnKQuUGSlB
	k5M1PSi4vAwereVn9u0zV4uBU0vEyHIcRvmQAUMAgXTe5qVUS9myqfHY1b02wHTk
	9SSe/eSuR14CJkYyr+R9MsLvCuENc52NaDvM2hWWpSBU3B3R8qR3l432M1HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728925400; x=1729011800; bh=8fUTk3Xq/COGNIDaWj/CA2cpfz/8
	5RmjRoxYUZVKPd0=; b=C2W6HYqVYQtJzxwRklKG0/tt7IWGQo/MY9fEu3ie3XQB
	QoBO93tDOcWJ3eNVIFs1+S73AkbWXk3KcSgRbLDjtCqxZPuXjb0r9lk1Xm2oDXxw
	TufNz4iTk/IDH0Z385H272oY01iaERdaIgtTriDAJW2Ln7fkbdljRyXw/IntOgPp
	apem4OL/vUWpwsU3K/GOQqTU/r1SmDKtYa4cZ3DU8lUpsFwy1OWnHmpMyEnkMmu+
	+Vz00nipzHy/OTDgMV1+wzdWdc9LqOxhBa0CQxBP4FxhGSCL7Z2cod9ud68P5h3G
	gU7g7wupAOz88Ud37E4yUhD7pq1BCf3un7ecovbh0w==
X-ME-Sender: <xms:2E4NZ7mIygJZ6CI9am4JbT2_RNIbHcXL6pa2fvm4CuGOP3hXukJQEg>
    <xme:2E4NZ-2IlOc0donQcgS4bOzsmzitDfncbnT2TnBhDghQ4MlOMz9fT3HvNPdNpJ-lN
    YH8_Mbr67ElnBENTlk>
X-ME-Received: <xmr:2E4NZxqTH8Wf0M4VSiQYtNQTMM3PD2q6KwPUsTAruN8K1nWdM0eJ2hZEFUp2oF-Eifd3uLS5GqTrGmjvO6L6MGfpPHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfg
    uefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegushhtvghrsggrsehsuhhsvgdrtgiipdhrtghpth
    htoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:2E4NZzlqdrk1kya20ko0lCzWWqkgg9L1YNsWR2IwOu8VsqydoPZpzw>
    <xmx:2E4NZ500qvHYsYbA651sD89xoROK_itm6Z9FjHBn0flAe4cjWkrBcg>
    <xmx:2E4NZysRYPhiMOKX7nKuLRN5Y2YR_wLB0vpydpsceZl94NYD908lqQ>
    <xmx:2E4NZ9WClaB61_T-EqcmYWMqtWMvdpK0adJRH_VzBY-9IqAetwWK4w>
    <xmx:2E4NZyxR68Std3Cw7MuordDdz8qSYy0SSefl8GaRvBy2Txv06syFCk3m>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 13:03:20 -0400 (EDT)
Date: Mon, 14 Oct 2024 10:02:59 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: try to search for data csums in commit root
Message-ID: <20241014170259.GB845260@zen.localdomain>
References: <0a59693a70f542120a0302e9864e7f9b86e1cb4c.1728415983.git.boris@bur.io>
 <20241011174603.GA1609@twin.jikos.cz>
 <20241011194831.GA2832667@zen.localdomain>
 <20241014151603.GC1609@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014151603.GC1609@suse.cz>

On Mon, Oct 14, 2024 at 05:16:03PM +0200, David Sterba wrote:
> On Fri, Oct 11, 2024 at 12:48:31PM -0700, Boris Burkov wrote:
> > > Can you please find another way how to store this? Maybe the bio flags
> > > have some bits free. Otherwise this adds 8 bytes to btrfs_bio, while
> > > this structure should be optimized for size.  It's ok to use bool for
> > > simplicity in the first versions when you're testing the locking.
> > 
> > Ooh, good point!
> > 
> > I started looking into it some more and it's tricky but I have a few
> > ideas, curious what you think:
> > 
> > 1. Export the btrfs_bio_ctrl and optionally wire it through the
> >    callstack. For data reads it is still live on the stack, we just can't
> >    be sure that containerof will work in general. Or just wire the bool
> >    through the calls. This is pretty "trivial" but also ugly.
> > 2. We already allocate an io context in multi-device scenarios. we could
> >    allocate a smaller one for single. That doesn't seem that different
> >    than adding a flags to btrfs_bio.
> > 3. Figure out how to stuff it into struct btrfs_bio. For example, I
> >    think we aren't using btrfs_bio->private until later, so we could put
> >    a to-be-overwritten submit control struct in there.
> 
> Maybe this could work but seems fragile as the private pointer is used
> for other strucutres and purposes. All in a void pointer. We need to
> store only a single bit of information, so this can work with some stub
> pointer type that can be at least recognized when mistakenly
> dereference.
> 

Agreed, I tried this approach first and it was very ugly/fragile.

> > 4. Figure out how to stuff it into struct bio. This would be your
> >    bi_flags idea. However, I'm confused how to do that safely. Doesn't
> >    the block layer own those bits? It seems aggressive for me to try
> >    to use them. bio has a bi_private as well, which might be unset in
> >    the context we care about.
> 
> #define BTRFS_BIO_FLAG_SEARCH_COMMIT_ROOT	(1U << (BIO_FLAG_LAST + 1)
> 
> I don't see any code in block/* that would verify the bio bits. Also the
> REQ_ bits could be used, we already do that with REQ_BTRFS_CGROUP_PUNT
> and at some point the REQ_DRV was used (removed in a39da514eba81e687db).
> 

Oh duh, this isn't persisted. Thanks for the extra explanation, that was
helpful. Trying something along these lines now and it looks decent.

> > I'm leaning towards option 3: taking advantage of the yet unset
> > btrfs_bio->private

