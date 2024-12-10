Return-Path: <linux-btrfs+bounces-10181-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C219EA794
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 06:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4861888DD0
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 05:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D684D2248A1;
	Tue, 10 Dec 2024 05:12:10 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE91168BE
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 05:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=174.142.148.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733807530; cv=none; b=m33GQJvqR6UxpNwU+zRcV7BJF5bd9uKKhFVK9IArmxASLC1/V8HmPupaFxHsAAUs427EAbVhmB/Bfzo+RKSO6hAxU2qYC+YOdN2bZ5VLX3dXT6Mkwg9C1oe7XT/V6Hyeg4EPH0g/Zi3N768XcHTtTaTrThkXr8ZNC6uFbuczu4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733807530; c=relaxed/simple;
	bh=k8uLYYY2G5t/DN4Ea/Ot1ruwyYga+bZQeUx/wPFuuhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pqi/jJNVNo8hIwXOo7U3L9uwF7WP2e2KIl/m89y2Hf18ElD4fbJ1HfUcNH3GsPZY6Bgn6KF6ySXEvDxZYtbLEzRu/EW0jpMnz3Nxw+i5SqhfPLG2gtASYRqPo/NnJRvYNHmPxA5bjrQW16+OGeWHqelyNwotZs/dm/aIi6f+008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org; spf=pass smtp.mailfrom=drax.hungrycats.org; arc=none smtp.client-ip=174.142.148.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drax.hungrycats.org
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
	id 4FEE41129227; Tue, 10 Dec 2024 00:12:06 -0500 (EST)
Date: Tue, 10 Dec 2024 00:12:06 -0500
From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To: Scoopta <mlist@scoopta.email>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Safety of raid1 vs raid10
Message-ID: <Z1fNpnKlKgE2gh69@hungrycats.org>
References: <a7f1781b-6ae8-4e71-ba00-6c1c11c4901d@scoopta.email>
 <Z1eqhWVodaL8rnzu@hungrycats.org>
 <c86d8af9-4b26-4917-9ef3-de38003ee365@scoopta.email>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c86d8af9-4b26-4917-9ef3-de38003ee365@scoopta.email>

On Mon, Dec 09, 2024 at 06:44:14PM -0800, Scoopta wrote:
> Ok, this is what I thought but I have seen so many articles that imply
> raid10 groups drives and I have found no evidence for that. I was always
> under the impression that neither raid 1 nor 10 grouped drives together
> intentionally and any grouping was circumstantial.

In traditional, non-btrfs raid1/raid10 setups, this can easily be the
case, and people might be assuming this is also true on btrfs without
checking.

Traditional setups are much less flexible on space--you can't have
different sizes of drives--but you can organize the drives such that
each of them is entirely mirroring one other drive.  This can tolerate
up to N/2 failures, as long as each failure only removes one drive from
each pair--but it can also fail completely with only 2 drive failures,
if they're both mirrors of the same stripe.

> On 12/9/24 6:42 PM, Zygo Blaxell wrote:
> > On Mon, Dec 09, 2024 at 06:26:24PM -0800, Scoopta wrote:
> > > I've read online that btrfs raid10 is theoretically safer than raid1 because
> > > raid10 groups drives together into mirrored pairs making the filesystem more
> > > likely to successfully survive a multi-drive failure event. I can't find any
> > > documentation that says this to be the case. Is it true that btrfs pairs
> > > drives together for raid10 but not raid1, if this is the case what's the
> > > reasoning for it?
> > It is _possible_ for raid10 and raid1 to be arranged such that multiple drive
> > losses are possible.  e.g. if all odd numbered devices are paired with all
> > even numbered devices, then any odd numbered device can be lost and the
> > filesystem still survives.
> > 
> > This is not _guaranteed_, it is only _possible_.
> > 
> > In a filesystem with an odd number of drives, or with drives of varying
> > sizes, the block groups will only guarantee that one drive loss can be
> > tolerated in each block group, in order to have the flexibility needed
> > to fill all available space.  In such cases it is common that block
> > groups are arranged in such a way that loss of any two drives will break
> > the filesystem.
> 

