Return-Path: <linux-btrfs+bounces-15527-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DCCB07A69
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 17:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B141893A51
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 15:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0304C2F3C3E;
	Wed, 16 Jul 2025 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="vNJa3wtf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YhF3VMOv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245852EBDD9
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681311; cv=none; b=Tg7x/46gmLebINmjCWP/G/5GCUF+x3S0/9SwiCNT7moIsP4hUpXenYu2+UYyrbLnauCOyd3ra/9wbi5HQnL5uqqH1UXNmx2FlbCY63hw6D1wK53WjCmfEPP8Jegz0QpFTpCVSFMdLwy/ERxuojpYwlSEkyYR+we913brxWgrxmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681311; c=relaxed/simple;
	bh=+jq1TQOU0SHSX315dTNtLTPm+Z+7gjztk0AHwce+QOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDzmNvHzrPkjtvcR/lsCYiW2VBV0UCb/Db4Rx6y2DtZEpwxryc1d432zuH3Poy2DR2fcA8JqwiU+oAEePlKywZD5kCuiYwotwPnLuWUfC/kwqxTTRJ6d4PO4ghRQlqy+1oBAu5usL34T+/WHDO/preD2bz/CnpbaWPN5P8F1SSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=vNJa3wtf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YhF3VMOv; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 202A01D00073;
	Wed, 16 Jul 2025 11:55:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 16 Jul 2025 11:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1752681307; x=1752767707; bh=siarlnaF27
	3S3e7AzJt5dAAmftPETE4JiWgFgvJZOjE=; b=vNJa3wtfgTfrNXlSyJHSktFNgO
	rhQggDkZV4Erw5IKSPEPIgwDDZv6QmpphHZO9J2mNHyC7zfDsJOJ083wtzc9DtMB
	CHBn0nRxSIjTAFihn+0wLF0tCjpBSTkStYH22uB/6db5AvnPfqs2j1qI1fuDuv0f
	9z7aN+CpcpHb004BLol5GVHl84mg35VxJpwmTKPsRctgGHcHqYCQ4rYMyyfYU4ak
	2AcK953WVnUNmFFOPbU4xH4UHZ1ibThM5zTE2Sk1+R52ClYmJpZL8WZFhBkrv1DL
	0CCE1efl4vzUUkuOLqC5RYcrmrPyYO+MkGVMC9EnCXzLzn38nnXRed+EVN5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752681307; x=1752767707; bh=siarlnaF273S3e7AzJt5dAAmftPETE4JiWg
	FgvJZOjE=; b=YhF3VMOv0QBfIYHA5IxqQF/B6clGq0aZU/Cw9KyBYV7My2mIa9x
	U/oGwOeqWRMR5+i3n2tzZ6dXIrdvYoDTPvtLzS0NooVJ69PeVjNKfZs6VtQSdMUs
	2QibnQrJqOBMFOKyJYbNMbVyjrLyS2H2rUUZPkukNFKWp0Bl4OuV0xkMSihxsTrX
	OXlE0mhDen7PUbriNDk+8QveKVkr7AhhfD24QU7/8biBHxmmsKoJq9OsT9HdZ9Xq
	MXLO2yyGv3M72oSI7PPEPFF1xctbNz+Vw/bWKSSrQCja+4p+kSY3suOMGGVCGA79
	JCvPb5nmvVx+G+RV808KnAq42RR1nzhaCuA==
X-ME-Sender: <xms:W8t3aAirUIwkxfQjpqkreE06DIiHkRauXyuDI6ZILqhgu7MndmTHxw>
    <xme:W8t3aMQK4Ac_eJZA64FfPEerNA1QPm3WSGwilB_J4Avyn0xJOQxbElkw-C0L6HmMK
    pd1liKwtof5xBf6Z6U>
X-ME-Received: <xmr:W8t3aBgxi3GU6EbjxqAPjmrM_PlSjpoFKv1c6phdmwnzm830XvpC612e2G0bKVFnkBZh49h1wxzBLwRid-hkhq8w54Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephedthf
    evgffhtdevgffhlefhgfeuueegtdevudeiheeiheetleeghedvfeegfeegnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhthhhumhhshh
    hirhhnseifuggtrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtg
    homh
X-ME-Proxy: <xmx:W8t3aM7y4OL9fxJAQHHLvveQpo-FrDvWpX_WHyia6XZfgWWleM07YA>
    <xmx:W8t3aOD2ZTjd32SrDhI101OAKNDipKJ9QMiQc_McB5D82xh-qW4ZAg>
    <xmx:W8t3aDZniuPdr8HAwp0zQ27ohGSwM2NxD-s2mJPep-j4FDdKqOCBbw>
    <xmx:W8t3aJY2n5dPGniYdH0g5En8YMn77gSDCmlJFOWPCuc1NhidB2gmgA>
    <xmx:W8t3aAetiqtDXHM7dPWJ2KnlAQ9pWBHCiKP_VR7IHoy7LnVmWRMIVSuz>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 11:55:06 -0400 (EDT)
Date: Wed, 16 Jul 2025 08:56:40 -0700
From: Boris Burkov <boris@bur.io>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: make periodic dynamic reclaim the default for data
Message-ID: <20250716155640.GA2275999@zen.localdomain>
References: <52b863849f0dd63b3d25a29c8a830a09c748d86b.1752605888.git.boris@bur.io>
 <df3f4610-cd32-4897-8172-5fe8b6a9b281@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df3f4610-cd32-4897-8172-5fe8b6a9b281@wdc.com>

On Wed, Jul 16, 2025 at 06:24:05AM +0000, Johannes Thumshirn wrote:
> On 15.07.25 20:57, Boris Burkov wrote:
> > The explanation of the feature is linked via the original patches.
> > But tl;dr: dynamic periodic reclaim for data is a way to get a lot of
> > extra protection from block group mis-allocation ENOSPC without
> > incurring a lot of reclaims in the happy, steady state case.
> > 
> > We have tested it extensively in production at Meta and are quite
> > satisfied with its behavior as opposed to an edge triggered
> > bg_reclaim_threshold set to 25. The latter did well in reducing our
> > ENOSPCs but at the cost of a LOT of reclaiming. And often excessive
> > seemingly unbounded reclaiming.
> > 
> > With dynamic periodic reclaim, if the system is below 10G unallocated
> > space, then the cleaner thread will identify the best block groups to
> > reclaim to get us back to 10G. It will get progressively more aggressive
> > as unallocated trends towards 0. It will perform no reclaims when
> > unallocated is above 10G.
> > 
> > With its by-design conservative approach to reclaiming and good track
> > record in datacenter testing, I think it is time to introduce automatic
> > data block group reclaim to btrfs. This does not conflict with the use
> > of the tools in btrfs_maintenance. One thing to look out for is that the
> > bg_reclaim_threshold setting is no longer writeable once the dynamic
> > threshold is enabled, and instead is a read-only file representing the
> > current snapshot of the dynamic threshold.
> > 
> > To disable either of these features, simply write a 0 to
> > /sys/fs/btrfs/<uuid>/allocation/data/(dynamic_reclaim|periodic_reclaim)
> > 
> > Link: https://lore.kernel.org/linux-btrfs/cover.1718665689.git.boris@bur.io/#t
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >   fs/btrfs/space-info.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> > index 0481c693ac2e..8005483fbfe2 100644
> > --- a/fs/btrfs/space-info.c
> > +++ b/fs/btrfs/space-info.c
> > @@ -306,6 +306,12 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
> >   
> >   		if (ret)
> >   			return ret;
> > +	} else {
> 
> Why else? If I'm not completely blind I can't see a reason for it.
> I'm running it without 'else' part through our perf test because it's 
> stressing reclaim quite a bit. We'll know more in ~7h.
> 
> 
> 

Thank you for running your perf test on it, excited to hear the results!

The reason I didn't propose enabling it for zoned is that I assumed the
reclaim strategy was too conservative for zoned filesystems. I figured
you would be reclaiming block_groups more regularly and that the hard
coded 10G headroom wouldn't work in practice. Also, I'm not sure how the
flipped threshold works. AFAIK, currently zoned inverts the meaning of
bg_reclaim_threshold compared to non-zoned so I wonder if will use a
threshold of 90 at 9 unalloc down to 10 at 1 unalloc for dynamic...

While we're on the topic, what would the ideal auto reclaim for zoned
look like? Maybe we could track "finished" block_groups and trigger
reclaim on the smallest ones (perhaps with the full-ness threshold) as
that number goes up?

Another idea for an extension that I was kicking around that I think
would make sense for both zoned and non-zoned was to keep the current
logic for the "we're out of unallocated" side of things but to add a
slow burn of reclaims metered by reclaim_bytes / reclaim_extents at some
slow pace. This would try to reasonably keep up with general
fragmentation in the sub-critical condition without ever doing a large
amount of reclaim.

> > +		if ((flags & BTRFS_BLOCK_GROUP_DATA) &&
> > +		    !(flags & BTRFS_BLOCK_GROUP_METADATA)) {
> > +			space_info->dynamic_reclaim = 1;
> > +			space_info->periodic_reclaim = 1;
> > +		}
> >   	}
> >   
> >   	ret = btrfs_sysfs_add_space_info_type(info, space_info);
> 

