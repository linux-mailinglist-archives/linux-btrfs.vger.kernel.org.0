Return-Path: <linux-btrfs+bounces-3125-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC778769F5
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 18:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8251F2254A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 17:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8693B3C08E;
	Fri,  8 Mar 2024 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="gyidCQ/n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CzDq3YjC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB27817BDC;
	Fri,  8 Mar 2024 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919119; cv=none; b=kWYbUX+rlcGLprahG0LepUVrsEES6ksbSZak0Xa9E6LJM2SE21iOvCsVz1KnAfoQ2JBUF2TGWqPOymYq9XU99Yj+zqjSumI9GwErBPBImwxSJZXbrREalnpOFkQ9KSTCE6Pmv6VxCDqMd9NPamG2RJQ2iqGhuOPunUZfopH5aNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919119; c=relaxed/simple;
	bh=5D1VotMhATy9BX8uvvh7vsfBP8wOru/6EUcwqF0eLRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rl96GqAJ3kOEu/JlUwsSAb9vg+5Hid7k+bhriwqFv2mFYWTUYqEBO5vbwCytRuvQkSxlSiwVZAH1alynE5I2YTAQ2AoRGwocOZKn1uUDTVvJlynbBLK2WReHHDg447HEHEx98D+oj8iQo3GgejnrSR+1+2+C0/QrUiNZxb13hwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=gyidCQ/n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CzDq3YjC; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 24F4B3200922;
	Fri,  8 Mar 2024 12:31:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 08 Mar 2024 12:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1709919114; x=1710005514; bh=tnyEYXb7n6
	Kz1CiPL/SEeGhmuz2WakV6Qks71JHUloM=; b=gyidCQ/nGhqhyr4YD5UMyLRyyU
	kW6wLx8YnCyh3ZIEvomQi40LL6akZxv6vDjYV/nI3lCZvcVdu1015ffBeDolKIxP
	+x3X/mbf/oxERYb8ivy6XWnE6jxT4MW5V5jNc+CCgWPqKWlmJDSI1LjQFAn2Itmj
	NU0CsRPycseSklxMQtA/cW/w0EeeoQs5ptsrOZXY4x/YgipT/qJBvqYJFjtC3DjA
	u7nF7E6melwip7T0SONkfARpA74dvKYPnmtCEUcnY3SMrurR2MbbnNw0Gq7sakac
	/f+aSJltwCsmQ85AB2qg2gzuHtENyN+xwWGEgwm+0krBA21ObOOuCNWaQJDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709919114; x=1710005514; bh=tnyEYXb7n6Kz1CiPL/SEeGhmuz2W
	akV6Qks71JHUloM=; b=CzDq3YjCLfFjkIwdqRzRDjvgW8YGeuGoDGHUz+HU8UY7
	tlUo8Y3RukqIZ10jIji8cDFbzCLdE+2gAsOUKFw3NLIi3VvphEjbsVTHnhMz4nlC
	+MIzXFmz/dtL43Rm3277qzqWiJ7PQeTBwSsuuHy3vq/nNkVgJVGrc4UDP7SFYb16
	TkMm4KSlbgvCzlxiUEh2MG4oDrZv6idDPRQA+A8jPRJgchbbwmkpIlvcPyAGe8bv
	LoNdlUq1+Yym30xSObqr9WDyCZ73hhH1xr51iwWoM6lgb9QZfMj5C4pcgmZWzn/s
	T449zt603Xd/DPOeQQMrqUAqwPBL8NhSHoyE9mBp3Q==
X-ME-Sender: <xms:ikvrZZA90JVFNS4AV0FqoAX-i3QUoZj0OLBsaOl0RUP4e3ruSs_S1w>
    <xme:ikvrZXiyr8lk_xYfOfNa7KnNxHwAwhClmH9ebIrXNBSi__7tk-cqZyBWh2PigVvZv
    8rkLRGv-1ogvbYv7mg>
X-ME-Received: <xmr:ikvrZUklJ0hFYZUZMYxtM-ybLNm0thlc1ytocyYRjp2CoD0eLx6D6m0aCrDnWxe-LdZGTTFxfxRXpnkWtxMRrdeECBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieehgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehtdfhvefghfdtvefghfelhffgueeugedtveduieehieehteelgeehvdefgeefgeenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:ikvrZTziWdbWhWjW3Ul7JbKoRZgdSZPfvZJ-r260FDlIhOV6j1ICXg>
    <xmx:ikvrZeT_GtlEflYFjLmhY0f_nV-j-w9sSb_mQRVUavuMTwb9wb3wwA>
    <xmx:ikvrZWZofNEZrpb8uWcd4O0WbysrsTETtme0s6ne66fRrLTLR-bvJQ>
    <xmx:ikvrZcc0R5xa5TF_WL4cnQxr-G_scAnvHDHnOVGqzyHPrR4rfj6G9w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Mar 2024 12:31:53 -0500 (EST)
Date: Fri, 8 Mar 2024 09:32:54 -0800
From: Boris Burkov <boris@bur.io>
To: Christoph Hellwig <hch@infradead.org>
Cc: Anand Jain <anand.jain@oracle.com>, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: validate device maj:min during open
Message-ID: <20240308173254.GA2469063@zen.localdomain>
References: <845dfb4fbf36dae204020c6a0a0e027cab42bcf0.1709865032.git.anand.jain@oracle.com>
 <ZeszQwa8721XnZsY@infradead.org>
 <be3571d7-2bfe-4bad-b2c6-84a0bf121140@oracle.com>
 <Zes4i3qvFk2nWjyY@infradead.org>
 <9a59cfac-2ab4-4c6c-933a-70dcd3e3d80b@oracle.com>
 <ZetJqJH-K-fC-pC-@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZetJqJH-K-fC-pC-@infradead.org>

On Fri, Mar 08, 2024 at 09:23:52AM -0800, Christoph Hellwig wrote:
> On Fri, Mar 08, 2024 at 09:53:07PM +0530, Anand Jain wrote:
> > It's a bit complex, as Boris discovered and has provided a testcase
> > for here:
> > 
> > https://lore.kernel.org/fstests/f40e347d5a4b4b28201b1a088d38a3c75dd10ebd.1709251328.git.boris@bur.io/
> > 
> > In essence:
> > 
> >  - Create two devices, d1 and d2.
> >  - Both devices will be scanned into the kernel by Mfks.
> >  - Use an external method to alter the devt of the d2 device.
> >  - Mount using d1.
> >  - You end up with a 2 devices Btrfs with an incorrect device->devt.
> >  - Delete d1.
> >  - Now you have a single-device Btrfs on d2 with a stale device->devt.
> 
> But how do you get mismatching devices in this exact place?
> 
>   - bdev->bd_dev is immutable and never updated
>   - device->devt can be changed by device_list_add, but if that happens
>     underneath us here between btrfs_get_bdev_and_sb and the code a few
>     lines below the call to it in btrfs_open_one_device there is a huge
>     synchronization problem
> 

You remove/add the device in a way that results in a new bd_dev while
the filesystem is unmounted but btrfs is still caching the struct
btrfs_device. When we unmount a multi-device fs, we don't clear the
device cache, since we need it to remount with just one device name
later.

The mechanism I used for getting a different bd_dev was partitioning two
different devices in two different orders.

I sent the repro script as an fstest last week:
https://lore.kernel.org/linux-btrfs/f40e347d5a4b4b28201b1a088d38a3c75dd10ebd.1709251328.git.boris@bur.io/T/#u

Boris

