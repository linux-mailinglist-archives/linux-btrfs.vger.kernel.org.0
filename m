Return-Path: <linux-btrfs+bounces-14139-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DCDABDC1C
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 16:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3250E188404F
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 14:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B92265CAA;
	Tue, 20 May 2025 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2gaaa6G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644A025DAF0;
	Tue, 20 May 2025 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750511; cv=none; b=DdnQRvO9YWagy6Qgsx9YFGX+Jk677QB8R/icb0NLuBtZnA/MTjBT8BYeaC9MhbPK5b/B0WfrVVXEn1y3WWVCsno/bCu7gnG/XFW2Oxe5OAdIb5tthkpZesxjfchivOZR9LTKTcMuqldYrh6RvqaDazABrwXVQufqQgJQCfO4xqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750511; c=relaxed/simple;
	bh=RjBf74JuRzmh1pvAQ/y+H/wsm5WmpnJ1p4e7jMoz8hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d80++cIc6JnskkEUedepFFgr4SThXsbcRLX7vZ/PhQUz5CPCAEm4f9MJ3TfWZE1VSkIViac/q3VxdvZ4nHu1y2a9P6M87gRFDFuOEsthFIjejZSS1dEsfhJyvPLJBf6mA9qLWSSVeatwIg2DSz59ApChilEVBAoMj63co9e89KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2gaaa6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DDAC4CEE9;
	Tue, 20 May 2025 14:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747750511;
	bh=RjBf74JuRzmh1pvAQ/y+H/wsm5WmpnJ1p4e7jMoz8hY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f2gaaa6Gmzie0JsgT11a1WE0a8YsnE2AYWnSL37T5yn/q+7P0u1Aq2yKhMA93IIMj
	 4oumb+ltnKQU/EhaFAXMC5eFtpI+qZ3FUKK3wz3P48OQdeenpCx3DYyW7zn/2HJCnI
	 MTA1jfrA3NHm/cC2H5Di5lBhKPlBARbGF7uT2l/8enq87LzltjZriOzYVmpSDAqGur
	 CiB5jCUZZ6QirXUVvN+sTv0mAKnrsk6VQFgRiCSnR54fmST6qPjbe6c6WDI/7CFiQo
	 ++/d0ziIpH6VTQJb2yfzt6swZLVugUehT9DjOhaaND6q2inCSN+KFY+UtHN26ffXyP
	 dN0gnPVgbpjEA==
Date: Tue, 20 May 2025 10:15:09 -0400
From: Sasha Levin <sashal@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>, clm@fb.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 099/642] btrfs: prevent inline data extents
 read from touching blocks beyond its range
Message-ID: <aCyObd3OCtX9K-Jd@lappy>
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-99-sashal@kernel.org>
 <20250506131913.GD9140@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250506131913.GD9140@twin.jikos.cz>

On Tue, May 06, 2025 at 03:19:13PM +0200, David Sterba wrote:
>On Mon, May 05, 2025 at 06:05:15PM -0400, Sasha Levin wrote:
>> From: Qu Wenruo <wqu@suse.com>
>>
>> [ Upstream commit 1a5b5668d711d3d1ef447446beab920826decec3 ]
>>
>> Currently reading an inline data extent will zero out the remaining
>> range in the page.
>>
>> This is not yet causing problems even for block size < page size
>> (subpage) cases because:
>>
>> 1) An inline data extent always starts at file offset 0
>>    Meaning at page read, we always read the inline extent first, before
>>    any other blocks in the page. Then later blocks are properly read out
>>    and re-fill the zeroed out ranges.
>>
>> 2) Currently btrfs will read out the whole page if a buffered write is
>>    not page aligned
>>    So a page is either fully uptodate at buffered write time (covers the
>>    whole page), or we will read out the whole page first.
>>    Meaning there is nothing to lose for such an inline extent read.
>>
>> But it's still not ideal:
>>
>> - We're zeroing out the page twice
>>   Once done by read_inline_extent()/uncompress_inline(), once done by
>>   btrfs_do_readpage() for ranges beyond i_size.
>>
>> - We're touching blocks that don't belong to the inline extent
>>   In the incoming patches, we can have a partial uptodate folio, of
>>   which some dirty blocks can exist while the page is not fully uptodate:
>>
>>   The page size is 16K and block size is 4K:
>>
>>   0         4K        8K        12K        16K
>>   |         |         |/////////|          |
>>
>>   And range [8K, 12K) is dirtied by a buffered write, the remaining
>>   blocks are not uptodate.
>>
>>   If range [0, 4K) contains an inline data extent, and we try to read
>>   the whole page, the current behavior will overwrite range [8K, 12K)
>>   with zero and cause data loss.
>>
>> So to make the behavior more consistent and in preparation for future
>> changes, limit the inline data extents read to only zero out the range
>> inside the first block, not the whole page.
>>
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This is not a stable dependency and the patch is not fixing anything
>but a preparation so this does not make much sense for stable backports,
>please drop it. Thanks.

Will do, thanks!

-- 
Thanks,
Sasha

