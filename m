Return-Path: <linux-btrfs+bounces-7554-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB61D96092A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 13:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995F8281F81
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 11:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF3C1A01AB;
	Tue, 27 Aug 2024 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCn4L+N3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0017519DF82;
	Tue, 27 Aug 2024 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759030; cv=none; b=M+7RgBZwERj8btpsfUwAWlloU7a+oJUATw3TrKBFd4Re28PYGLPKVooSDYNLca4GMkjwGmlfWDcxu89xCMpWfE7FRhpyoi1J3MJI2c1irkhDfnWQFMSVmuo9U2lSbQH0Icg2IdrkBSelT1G+kIMQt4uJEHQf/6YOrMLaLvOXIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759030; c=relaxed/simple;
	bh=3dpriN46tYdo3tjocvSkZm1gPpKCkXVEYGDbAABpZzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeGEdFNh55Tv7zcetazxlQ5pGc+gtKJw6OoKEQiQQTC1GWwTTS0OOqVOA6B+LLvYuOC4OeWJsrBbku9WF7mBmcavf3NEvvxG7D5pNAwKQY1yxgMDynxRzCfVsOOjvgw+3EPKd0ZVfxkgxnONlCJldW/Dcq4Co+6QSsbHAZL6k0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCn4L+N3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6A1C52F9A;
	Tue, 27 Aug 2024 11:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724759029;
	bh=3dpriN46tYdo3tjocvSkZm1gPpKCkXVEYGDbAABpZzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uCn4L+N3ItrAf07Xq9ALUNH+e1c1w0W7IryeHTV8hjwMCeGd4jwGBTfB70N3eqoZv
	 KZuJmuB6+3xEBA7EUvgopVwiayf4poZ5J/GFm9G48N/7bxuCmVn3yrF4RrInzL4IQU
	 VUcYeNkqmWgaZ5p7YrIhJu6jo7nF3tkATfU2tZvImjWUSSmKtd5l7MVMg8vrfu9tjS
	 TRq3e2nKsw4gd18eXOAisK3O34Ew5OA1AxNNBfmWs5MncguPros+MzcRtnsseg4Bn7
	 nKWhsZc3Oca8p+d6rZxtBqztAZaOJARG5PAqTWIRyCjy7V9z8c9A9dIRIxvFKMcUOj
	 P5xKMxHH8vJzw==
Date: Tue, 27 Aug 2024 13:43:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: fix unintentional splitting of zone append bios
Message-ID: <Zs278OxdBpn-i9ss@ryzen.lan>
References: <20240826173820.1690925-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826173820.1690925-1-hch@lst.de>

On Mon, Aug 26, 2024 at 07:37:53PM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series fixes code that incorrectly splits of zoned append bios due
> to checking for a wrong max_sectors limit.  A big part of the cause is
> that the bio splitting code is a bit of a mess and full of landmines, so
> I fixed this as well.

Hello Christoph,

You say that this series fixes code that could affect every submitter of
zone append bios, thus I am a bit surprised to not see any Fixes-tag(s)
in any of the patches in this series. Was that intentional?

Even for a theoretical fix, doesn't this sound serious enough to warrant
zone append splits to be fixed in stable kernels as well?

When was this bug introduced? Or has it been broken since the support for
zone append was first added?


Kind regards,
Niklas


> 
> To hit this bug a submitter needs to submit a bio larger than max_sectors
> of device, but smaller than max_hw_sectors.  So far the only thing that
> reproduces it is my not yet upstream zoned XFS code, but in theory this
> could affect every submitter of zone append bios.
> 
> Diffstat:
>  block/blk-merge.c      |  162 ++++++++++++++++++++++---------------------------
>  block/blk-mq.c         |   11 +--
>  block/blk.h            |   70 +++++++++++++++------
>  fs/btrfs/bio.c         |   30 +++++----
>  include/linux/bio.h    |    4 -
>  include/linux/blkdev.h |    3 
>  6 files changed, 153 insertions(+), 127 deletions(-)

