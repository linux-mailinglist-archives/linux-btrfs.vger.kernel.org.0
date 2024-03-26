Return-Path: <linux-btrfs+bounces-3625-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D450988CF07
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 21:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF59AB2B443
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 20:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA46A13D8AA;
	Tue, 26 Mar 2024 20:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="JbXYCHC4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HUdFQHLR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1B913D26D
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485159; cv=none; b=jr+qtA3488W5sBEnH5GLmhWLlTFnsWbrBUE8zfqYj5Fa6wZw4VoqdSegIbEGjpA7YSUOQ/eyUdb7koP6myLL2qHvtY/zdzYwo7nd8vzlU/cqr+WIbpCUxYhCQursPmjxxCLEeMnobP9/2GRGsJccfO+d3N9VsBalr8sYn3kcQGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485159; c=relaxed/simple;
	bh=YaG0lZrTwUBh/IUsA0Jg13PuOjjvAoLbYjmU/YLEKM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dm/8NdwE32oeebsvmz1btQtnwW2cR2KeC6JsJngbxMzIuUHEWVU/to4deKXYp5GGvt2RGvL07Knkal9MYAnq87OWaH4qjgBu/hs0DIGu9B7fOc4JTzIbLhREFZfE1VT8Rx+Ca32vXWWY0TDdqR/hdAA4i7CsvNVcx9YG02+xDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=JbXYCHC4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HUdFQHLR; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 797C5320077A;
	Tue, 26 Mar 2024 16:32:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 26 Mar 2024 16:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711485156;
	 x=1711571556; bh=CWDwrzO079q5ByfCThnDdRPLTngUIvgcrg57QkIzPns=; b=
	JbXYCHC47+X+vkmKceVscqdjSQFFXGjGq/51l8PZYwGnTheKdFumrEy+SQwuQ16h
	pv1339Tsp+RpqIRG23GNgDXanY6bFAeV60b8AG4On1XXIWDCSpQ7fR1casnRcVb8
	Z9wN5sq9oTu4oCP4akgREWfFl6q4AheJ/npYFUGODK543OHs4TRhiHzIr7BJbIA4
	OS9a+MfZGAUO7ibMsfC902LNIhih7e1r3djUupjk6GHSjKMosZ9V0t5SCqClrw/O
	LvuVYL58ggnAXMsfkFjYwrzfu5yQLP2pkTuLaOvWtUpgoD5D5IW+kOZOBMbHvZfM
	Hld6W//zeEQeGdK5AyxGxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711485156; x=
	1711571556; bh=CWDwrzO079q5ByfCThnDdRPLTngUIvgcrg57QkIzPns=; b=H
	UdFQHLRHaZ2j+t67JYdAuWbNL0ARjZaJmwhSBLOBJC/lvVL5NkhnvE+tE7Uir5w0
	3chtgLfF/GQtSGkze7HwvIjzIr2APGW4oCKTI28IuOpS/LrRT/6cDQpD0Pa7ciL8
	12R8O6gPTvctb+6WRIyutm1f8MsWDwtA/Ijlv5wfSrFPg628sZfH+EP/Nd4/OSRv
	mcZH2voziohU2mKoDqUrbQsapY6KQM6QzDfE7pgjjthq33+oWpWDL3wPz2Pdfpna
	8df73jcZwaD3IVVcaK6EzY0k0GH1Kd2hA+18AKDUFzn8MISooDOIg3UdhlXLJe9M
	sAzrCV4bbJbBy6A4pCJHw==
X-ME-Sender: <xms:4zADZm7UvBc9uI_6bacwDpPgLeLrDFUxKu8qL4gHPxtQOmCheTh_OQ>
    <xme:4zADZv5in0MIHMAVIZpqA8JlAN7gqV_Dw0tOm4UjrXkST-Fa7tFrVW_UTBv_Voebp
    9wM4cWGej6qN31jqxI>
X-ME-Received: <xmr:4zADZleyVXuhTKfgza9yN_YjA7hlJ1dxR1yHDC9U2XnryrY4LWEDdhSPeP5NxM2qICOxZpHBYVON9KJLX2DQRWawWQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    rhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrh
    hnpedulefhtdfhteduvdethfeftdeitdethedvtdekvdeltddvveegtdeuuddtiedtieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrih
    hssegsuhhrrdhioh
X-ME-Proxy: <xmx:4zADZjKFzqAaGkaFym3qwzKjFMfwfyWCzTeSA3xVivoCwrkLow1Vqw>
    <xmx:4zADZqJm9WWAoCe6ZkvQBdtagg4CRIdpxPXKGiS1isU5jHs_JM7yQw>
    <xmx:4zADZkzb8H1Uth83HlnmU8WwfNZBhooZvj0gVJA2UWTt1UujHs7Vxw>
    <xmx:4zADZuI4QYmG7vcNon-bdhl2Yb4vz7iRhTlTcqIQPKXzeCJB_mt_bw>
    <xmx:5DADZhXmlb9LrYwTbyI7nb1uX1f7otE9tLtUVUPt41ZxQmAOJD3VYQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 16:32:35 -0400 (EDT)
Date: Tue, 26 Mar 2024 13:34:43 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: subvolume: output the prompt line only when
 the ioctl succeeded
Message-ID: <20240326203443.GA3206298@zen.localdomain>
References: <7d1ce9fe71dac086bb0037b517e2d932bb2a5b04.1709007014.git.wqu@suse.com>
 <20240301125631.GK2604@twin.jikos.cz>
 <20240326202349.GA1575630@zen.localdomain>
 <bafb239d-5c78-451d-b981-8d79aa3c1200@suse.com>
 <32c3c2fc-3f76-40e2-b876-36370f4aed85@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32c3c2fc-3f76-40e2-b876-36370f4aed85@suse.com>

On Wed, Mar 27, 2024 at 07:00:29AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/3/27 06:57, Qu Wenruo 写道:
> > 
> > 
> > 在 2024/3/27 06:53, Boris Burkov 写道:
> > > On Fri, Mar 01, 2024 at 01:56:31PM +0100, David Sterba wrote:
> > > > On Tue, Feb 27, 2024 at 02:41:16PM +1030, Qu Wenruo wrote:
> > > > > [BUG]
> > > > > With the latest kernel patch to reject invalid qgroupids in
> > > > > btrfs_qgroup_inherit structure, "btrfs subvolume create" or "btrfs
> > > > > subvolume snapshot" can lead to the following output:
> > > > > 
> > > > >   # mkfs.btrfs -O quota -f $dev
> > > > >   # mount $dev $mnt
> > > > >   # btrfs subvolume create -i 2/0 $mnt/subv1
> > > > >   Create subvolume '/mnt/btrfs/subv1'
> > > > >   ERROR: cannot create subvolume: No such file or directory
> > > > > 
> > > > > The "btrfs subvolume" command output the first line, seemingly to
> > > > > indicate a successful subvolume creation, then followed by an error
> > > > > message.
> > > > > 
> > > > > This can be a little confusing on whether if the subvolume
> > > > > is created or
> > > > > not.
> > > > > 
> > > > > [FIX]
> > > > > Fix the output by only outputting the regular line if the ioctl
> > > > > succeeded.
> > > > > 
> > > > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > > 
> > > > Added to devel, thanks.
> > > 
> > > This patch breaks every test that creates snapshots or subvolumes and
> > > expects the output in the outfile.
> > > 
> > > That's because it did:
> > > s/Create a snapshot/Create snapshot/
> > > 
> > > Please run the tests when making changes! This failed on btrfs/001, so
> > > it would have taken 1 second to see.
> > 
> > Wrong patch to blame?
> > 
> > The message is kept the same in the patch:
> > 
> > -        pr_verbose(LOG_DEFAULT,
> > -               "Create a readonly snapshot of '%s' in '%s/%s'\n",
> > -               subvol, dstdir, newname);
> > -        pr_verbose(LOG_DEFAULT,
> > -               "Create a snapshot of '%s' in '%s/%s'\n",
> > -               subvol, dstdir, newname);
> > 
> > +        pr_verbose(LOG_DEFAULT,
> > +               "Create a readonly snapshot of '%s' in '%s/%s'\n",
> > +               subvol, dstdir, newname);
> > +        pr_verbose(LOG_DEFAULT,
> > +               "Create a snapshot of '%s' in '%s/%s'\n",
> > +               subvol, dstdir, newname);
> > 
> > Thanks,
> > Qu
> 
> OK, David seems to changed the output line when merging the patch...
> 
> That's something out of my reach.

Agreed. Sorry about the test rant.

> 
> Thanks,
> Qu

