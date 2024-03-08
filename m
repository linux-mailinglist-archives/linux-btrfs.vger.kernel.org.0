Return-Path: <linux-btrfs+bounces-3129-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7B9876A31
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 18:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D9928425F
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 17:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BC940873;
	Fri,  8 Mar 2024 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="fWfzQ1mm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DCcxJW/u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D5536D;
	Fri,  8 Mar 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709920236; cv=none; b=Geo/wqQMARAqAYGjKHNjbtU6CriWD3m6ez0nuJBGIOuu1Nv8bloSO409M82xKvBH9cBBMFIlPuO9GHH9IKMOb5bfMo73VKcXU+mTbq/YzygAwFF3aHxcyRHPzswolGUvK3Jo/DPGJj8kAPkK+Ci9h8lKnyI/XbFxAN0R79XXat4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709920236; c=relaxed/simple;
	bh=aYXoxvwXoUsxi6I7vgRzh91vMh9HuctcWj0j38Bq/zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQPvhHaT+NGy2m2untr/cEYRdoEPJH9BVHtdMiTnLZJm3XoDPbU8mBnWdmCupgKgBaIbqDiRorrZzHR320qdNPc7//O8cMhtihMs1X2vQmvAZ4z4Dsoii+AhjrIFS4ybGr3Ar1aWrR3r5AtdL5vCZKhMssj48+FYvmXkm5KHNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=fWfzQ1mm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DCcxJW/u; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 4FBBE32000D9;
	Fri,  8 Mar 2024 12:50:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 08 Mar 2024 12:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1709920232; x=1710006632; bh=7sGeJhFAFJ
	8YQ/zgmxNLJ814/abg8l/UGPrscT28aeA=; b=fWfzQ1mm2BYSCIQwFOHHlGDYTK
	EOLWrruOjYhUd8Y2b3HHPKwtcBFn+9GHmsLKPey3ZIYiM/yj1DJ4HDAWjrU/7sjM
	tsr1bLfioIuyrVo9DogUuMxV8MXNvOd2Le9loONjle3CmM/sr2mpkL96WJFByaiH
	7aSS6fyu40nrKqimPhAOf6ScZclRlP0amJ3fWlh1Qf19bqPvOBu74oD1K9+xEa1g
	dcc5T9GBe0dUghFgGf6t//sIXrxxfou8Pzzkpa8bpabLH8E5LDKInLiSut6k9bhb
	WtkB8EtYsTF7omULFor/isWZEN+OoaciON8utg7quVV8J+kxQZezs2fC6T1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709920232; x=1710006632; bh=7sGeJhFAFJ8YQ/zgmxNLJ814/abg
	8l/UGPrscT28aeA=; b=DCcxJW/u3haCziJ/WSCqupTNfc8IRro2kSamHoH9cUW5
	F8jvf3JlpfxzUGNBnNgNBTDUWll7ROq4oUF9v7YixTrWRLjEViH6YFDEWUs8Opbt
	zeaxmWR+IttrFcIjGESm59wZ4N3Lf6+tfx52Ady0qgaM33zs7yHCXcxkB+henX0o
	aIzrf7rCx1UjDzQTQmi0fSQB4dpuzk3hrM4Sj5xDhpE2pYDAhUELDt+UGq+EIi27
	QdSyJsfGwVLt2DIqDQhlf+ZBEBBRxGW+c//lqnpIzb8nnZdwxR/EnmxLXlOJO9jc
	28Fii4viILCNiXVwvnTvpspkJ/U0g0pvVGRyjb/iHQ==
X-ME-Sender: <xms:6E_rZWQ4GHsqKeuZvOOG1LS4CR_mIKLjnvveAzDVzL8ZkR9EqmjkPg>
    <xme:6E_rZbz2HyirO9-iUXhMg3Q98kr7blWeCjpEka5emK5Oy_XXgbesqHyq6H1052H33
    NNFiIcPp5mluw0wgV0>
X-ME-Received: <xmr:6E_rZT1O-UHWfHK5pX3Cylv1T-YYbTPbiI_Q1OfHPEjjZtHL24iAMA4aiF1t40OeyAM5xMSSkD1vBF8aKh2JWHhGFJM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieehgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:6E_rZSCKkF6AtDjK3cFWbQpqarBUN_Tuuzot4fFK_yijV0xfpywQYA>
    <xmx:6E_rZfhTZ3H6UWmhS8Il8TIvmlwWPFfnDZEGbt01UwPDU84xwc6MjQ>
    <xmx:6E_rZeos9hczaK4rEXRjkLViDB4tM-cFScrWgdVBDmj0bumDtrO9Bw>
    <xmx:6E_rZcuFG7bj4B34B4z1j_yCO1pUA2z7mKedjBuKw6YdWxwHIua1Hw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Mar 2024 12:50:32 -0500 (EST)
Date: Fri, 8 Mar 2024 09:51:33 -0800
From: Boris Burkov <boris@bur.io>
To: Christoph Hellwig <hch@infradead.org>
Cc: Anand Jain <anand.jain@oracle.com>, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: validate device maj:min during open
Message-ID: <20240308175133.GA2470614@zen.localdomain>
References: <845dfb4fbf36dae204020c6a0a0e027cab42bcf0.1709865032.git.anand.jain@oracle.com>
 <ZeszQwa8721XnZsY@infradead.org>
 <be3571d7-2bfe-4bad-b2c6-84a0bf121140@oracle.com>
 <Zes4i3qvFk2nWjyY@infradead.org>
 <9a59cfac-2ab4-4c6c-933a-70dcd3e3d80b@oracle.com>
 <ZetJqJH-K-fC-pC-@infradead.org>
 <20240308173254.GA2469063@zen.localdomain>
 <ZetOIKNJRsdFNJ3A@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZetOIKNJRsdFNJ3A@infradead.org>

On Fri, Mar 08, 2024 at 09:42:56AM -0800, Christoph Hellwig wrote:
> On Fri, Mar 08, 2024 at 09:32:54AM -0800, Boris Burkov wrote:
> > You remove/add the device in a way that results in a new bd_dev while
> > the filesystem is unmounted but btrfs is still caching the struct
> > btrfs_device. When we unmount a multi-device fs, we don't clear the
> > device cache, since we need it to remount with just one device name
> > later.
> > 
> > The mechanism I used for getting a different bd_dev was partitioning two
> > different devices in two different orders.
> 
> Ok, so we have a btrfs_device without a bdev around, which seems a bit
> dangerous.  Also relying on the dev_t for any kind of device identify
> seems very dangerous.  Aren't there per-device UUIDs or similar
> identifiers that are actually reliabe and can be used instead of the
> dev_t?
> 

I was led to believe this wasn't possible while still actually
implementing temp_fsid. But now that I think of it again, I am less sure.
You could imagine them having identical images except a device uuid and the
code being smart enough to handle that.

Maybe Anand can explain why that wouldn't work :)

