Return-Path: <linux-btrfs+bounces-2393-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8C68552C8
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 19:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79284B2A174
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 18:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB5713B2A6;
	Wed, 14 Feb 2024 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="pP31KRHe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uXMXAOA6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFE813956E;
	Wed, 14 Feb 2024 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936930; cv=none; b=PJOdvQmstotut2tudkSBW9mZooEsgsTVGAroUGMBQXjrG69HNH5ZAXN6WinkCCDj3kmBjx+5s1cnHqJ+Ec2mO7yr50fldgTH+E8nwNnbokMYxdIyN3G7UEo10IokHwExjLEPkCzp26jGhrd+xKKbjD92xxYlhftyY6KMwvbH31s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936930; c=relaxed/simple;
	bh=7vp5CHnvSqeOdxryxPoZ/WU1TPKigoUo5tbw+O0fQKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwjylSb5RwKtfexhsI8FgiuYME/lL2fo58xdaZ7Zn93KnRXnwxK+2ytkhBYhWl1OY9Iv7Ss/PHq1z9ksLxU/LoKReJWFYD2zJZOOtreHCNB3oTTwo/3gFwARGAUHt34IcQYWPFNMwSP+P12A3nPwgMebf24u2e0iyRcmGDniJVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=pP31KRHe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uXMXAOA6; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 6C90D3200392;
	Wed, 14 Feb 2024 13:55:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 14 Feb 2024 13:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707936925; x=1708023325; bh=Iz9A2YUaE0
	K0HkN/CoVu8+W5KyNrpLnDnfP0QHxGTug=; b=pP31KRHeVck/ggVRk6BDO/VTdN
	dkDcQcwW9JCktPDMRjHSZ7Pi6LZRfz+/cWRgjn8J6tIG3+UpV9ejX68/+pzaRkDq
	bVcCSA2Iv1woAImh16IlIEYkKpsRix2pnAOl7hCuutj+OKxaeo7KlfASQBErY5NM
	UQAtDTwBXkCTvC9dUeGodh68HhFE0MyOiVPwQ9wsqKAMrEyHVZyTAeCuND3PHve0
	FpgnGkRFk/ccc2MwXvW6oIsd7tdLX82nWePqK8kAYacadKV9GjK8zOyDwCw2qNBY
	IPmRUI+f3by0CwT64OY0KQwzeZVankLTAlkhD4WBTzInPsA6cumbj12kYiXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707936925; x=1708023325; bh=Iz9A2YUaE0K0HkN/CoVu8+W5KyNr
	pLnDnfP0QHxGTug=; b=uXMXAOA6DNkrfPiLfMgaHJgrEFJlqiX6Kcl1VV90VwVR
	DMtElncw7JfcnsnAK2/RojZ1NasGGJKnNjhKNlu+sSlOhgeP7KPikjkoZ+iJNwAj
	QEtJvJX7VgXlarcfGLdNL4ewbuA7slTlI7wNEd70bOc5DH572qVK7vPjMHaxhTDY
	7fbbAqTRPnMh3hJACjRlnLDRd95CpVBjEhaCHVDclxbwUHQqOK4w8/Nrzhzaf514
	rSfYra2+/S8ZdMV52evFwRJAUV3N9ikxfwcwUssMKG+Ir5c+pHGfAOnPnyAo2lkj
	WMNWEYwph7kH4sTFv5aHbFT1u1SuUmEFwR/NAU4K9w==
X-ME-Sender: <xms:nQzNZZHC9Ttea8hhhPxZXz0cUukOr6NCfeLX_ZEX9A6g6Y-prZb8zw>
    <xme:nQzNZeU5FLi7BPndDx98jxICWTPK2enjn5ybfvVmjAw-Ecq2f-_hsrWP6jCCUF2I5
    0qawO58q1hbuXjAUvo>
X-ME-Received: <xmr:nQzNZbK8HHm3wulzYDUwJfu0YGGzCoivnQog8cI6cy6EnGWUHCVIrcVrjXT9fGxlAV8bUvkcT5WfbL_wDg17eBMYzvU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:nQzNZfGvv_cYFsMwKPWTu5FZ0L8ymWLzGMy4eiUxE7PZSWTdvYM44g>
    <xmx:nQzNZfUzICG62UUdsTXjDV8B0Md2cSDaC30BA3N--df4uPDl1qzsDQ>
    <xmx:nQzNZaPZJuZKxDWxCCWZ772sEirLQsT88te-EVyhfVTh1h5uzx8ZnQ>
    <xmx:nQzNZVfu81gL96JZmDNsTsIHC9xPIsqqdMiKpNAC01OkI-awk6fSLA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 13:55:25 -0500 (EST)
Date: Wed, 14 Feb 2024 10:57:01 -0800
From: Boris Burkov <boris@bur.io>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: use the super_block as bdev holder
Message-ID: <20240214185701.GB377066@zen.localdomain>
References: <20240214-hch-device-open-v1-0-b153428b4f72@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-hch-device-open-v1-0-b153428b4f72@wdc.com>

On Wed, Feb 14, 2024 at 08:42:11AM -0800, Johannes Thumshirn wrote:
> This is a series I've picked up from Christoph, it changes the
> block_device's bdev holder from fs_type to the super block.

Applies and builds on my for-next, and LGTM. A few non-urgent inline
comments in the patches, but assuming this has gone through CI again,

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Here's the original cover letter:
> Hi all,
> 
> this series contains the btrfs parts of the "remove get_super" from June
> that managed to get lost.
> 
> I've dropped all the reviews from back then as the rebase against the new
> mount API conversion led to a lot of non-trivial conflicts.
> 
> Josef kindly ran it through the CI farm and provided a fixup based on that.
> 
> ---
> Christoph Hellwig (5):
>       btrfs: always open the device read-only in btrfs_scan_one_device
>       btrfs: call btrfs_close_devices from ->kill_sb
>       btrfs: split btrfs_fs_devices.opened
>       btrfs: open block devices after superblock creation
>       btrfs: use the super_block as holder when mounting file systems
> 
>  fs/btrfs/disk-io.c |  4 +--
>  fs/btrfs/super.c   | 71 ++++++++++++++++++++++++++++++------------------------
>  fs/btrfs/volumes.c | 60 +++++++++++++++++++++++----------------------
>  fs/btrfs/volumes.h |  8 +++---
>  4 files changed, 78 insertions(+), 65 deletions(-)
> ---
> base-commit: a50d41606b333e4364844987deb1060e7ea6c038
> change-id: 20240214-hch-device-open-309ef9c98c62
> 
> Best regards,
> -- 
> Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 

