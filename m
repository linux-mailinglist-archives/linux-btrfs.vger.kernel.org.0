Return-Path: <linux-btrfs+bounces-4018-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD46E89B706
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 06:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DAB01F21E8A
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 04:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031607482;
	Mon,  8 Apr 2024 04:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uNE2CNH9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27B1FC8;
	Mon,  8 Apr 2024 04:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712552279; cv=none; b=KcgUAd2bks3cfj8E656pH93hNai2QFTBNtii0flyEj0/C4asCfl8555cW+uW9MMLEQiTOyuckOXgCofBvmoS/roXEfpaU/OayKDxLau+uyAd7GAEp16P8lJSYEICM1BuB4tYQB+O3mWsvPYxyO/qRrNNVTUsJEwy2gbDGlj3YUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712552279; c=relaxed/simple;
	bh=anUXvL392fO2+AfT73Jft+wzb/H/McYFkz8oCkEBIk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTkBPu9iGKvZCDpT7pEE4eEmv8WjeUKSIaZ1iqp1KixMC6ypjkn82cptQZEo8Eg5KJK7cQlj9pLbiSfd+Xq90+67tPyMGEbwkT7YTReUcVtLGLNo+9FY4I5qK3ysmZeJkIpQG8tJvfjHTnlmsSit9qbi7MXiCLDYnY9+ubfvGW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uNE2CNH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE15C433F1;
	Mon,  8 Apr 2024 04:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712552278;
	bh=anUXvL392fO2+AfT73Jft+wzb/H/McYFkz8oCkEBIk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uNE2CNH9FTFL0oHNz+X301D5F9RO25oTn8BzvyhVTKpGAr2pMGEi11x0QCj9f+Cgq
	 E/sy4kSY568kDzXlc80p+7F4ZSXiAGWy4a4TuVDHSXaZZk6FD8fP/AbarpYW5KCGjS
	 43fAG/SYkv+WRX4bJy1e54e9FeCfiiNw9jImlxQU=
Date: Mon, 8 Apr 2024 06:57:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wang Yugui <wangyugui@e16-tech.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix wrong block_start calculation for
 btrfs_drop_extent_map_range()
Message-ID: <2024040851-uptown-splashing-951c@gregkh>
References: <4240e179e2439dd1698798e2de79ec59990cbaa0.1712452660.git.wqu@suse.com>
 <20240408080014.74B2.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408080014.74B2.409509F4@e16-tech.com>

On Mon, Apr 08, 2024 at 08:00:15AM +0800, Wang Yugui wrote:
> Hi,
> 
> > [BUG]
> > During my extent_map cleanup/refactor, with more than too strict sanity
> > checks, extent-map-tests::test_case_7() would crash my extent_map sanity
> > checks.
> > 
> > The problem is, after btrfs_drop_extent_map_range(), the resulted
> > extent_map has a @block_start way too large.
> > Meanwhile my btrfs_file_extent_item based members are returning a
> > correct @disk_bytenr along with correct @offset.
> > 
> > The extent map layout looks like this:
> > 
> >      0        16K    32K       48K
> >      | PINNED |      | Regular |
> > 
> > The regular em at [32K, 48K) also has 32K @block_start.
> > 
> > Then drop range [0, 36K), which should shrink the regular one to be
> > [36K, 48K).
> > However the @block_start is incorrect, we expect 32K + 4K, but got 52K.
> > 
> > [CAUSE]
> > Inside btrfs_drop_extent_map_range() function, if we hit an extent_map
> > that covers the target range but is still beyond it, we need to split
> > that extent map into half:
> > 
> > 	|<-- drop range -->|
> > 		 |<----- existing extent_map --->|
> > 
> > And if the extent map is not compressed, we need to forward
> > extent_map::block_start by the difference between the end of drop range
> > and the extent map start.
> > 
> > However in that particular case, the difference is calculated using
> > (start + len - em->start).
> > 
> > The problem is @start can be modified if the drop range covers any
> > pinned extent.
> > 
> > This leads to wrong calculation, and would be caught by my later
> > extent_map sanity checks, which checks the em::block_start against
> > btrfs_file_extent_item::disk_bytenr + btrfs_file_extent_item::offset.
> > 
> > And unfortunately this is going to cause data corruption, as the
> > splitted em is pointing an incorrect location, can cause either
> > unexpected read error or wild writes.
> > 
> > [FIX]
> > Fix it by avoiding using @start completely, and use @end - em->start
> > instead, which @end is exclusive bytenr number.
> > 
> > And update the test case to verify the @block_start to prevent such
> > problem from happening.
> > 
> > CC: stable@vger.kernel.org # 6.7+
> > Fixes: c962098ca4af ("btrfs: fix incorrect splitting in btrfs_drop_extent_map_range")
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> $ git describe --contains c962098ca4af
> v6.5-rc7~4^2
> 
> so it should be
> CC: stable@vger.kernel.org # 6.5+

As the "Fixes:" commit was backported to the following kernel releases:
	6.1.47 6.4.12
it should go back to 6.1+ as well :)

But we can handle that when it hits Linus's tree.

thanks,

greg k-h

