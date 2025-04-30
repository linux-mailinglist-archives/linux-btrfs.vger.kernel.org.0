Return-Path: <linux-btrfs+bounces-13565-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F909AA5460
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 21:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFA74C729C
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 19:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3950B265CC8;
	Wed, 30 Apr 2025 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYbsV/7d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723CBC148;
	Wed, 30 Apr 2025 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746039753; cv=none; b=tNxJ8SHjVltEKD8i8MhJMzSo9nV96UD4ARhkqMMwlGkcUZhwcKowjzl5ydWAEMHPZTL+bJn5YN3xIpj5/6jCogSmWYYv6i7NLY1D7ew0KHEL8RV/CRZ9eOOqHJXzuXPu5GnamtLTEjJYEVlEGTBl3Y5LjPim/hX9tr5/cZIW/MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746039753; c=relaxed/simple;
	bh=v6OGLN/7JlkVPA3m/u0loXZ2gAuaERKROs8ylRl3wjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDIKgsWz4G4U3z7feozQCRURRRfOkZX4SiZ4x3niEp5qMvCe+aIVo7YPr731xYIDtuHuGUBLBCssX0lQnKFtfVyeISS5omJWisFKAMTQ7XoUMW93YJd9uJEbFk7cHbRs9yh+X/GliS2rKWKCM+vJBSbnB3xbiPd9Tld1pCs9GrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYbsV/7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F73C4CEE7;
	Wed, 30 Apr 2025 19:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746039751;
	bh=v6OGLN/7JlkVPA3m/u0loXZ2gAuaERKROs8ylRl3wjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZYbsV/7d9QLIUK4pfM2HYn+hr9xB1NgDiYHaUYb/43zeKkStR2udlqrEoM7h/7OWe
	 G+z7a3AXpNT5VpSsE7EtDn1hg9TH7u/F+Z/WsYJHUEqB2SN/NEPccXVvBv6Ywxy+A5
	 1HCgSr+YNcVHaZYPPqxR5DpktNwITESYdC+GKKEoKr5QTNnKY8ihrmxcV+N3Wof1T7
	 3+nZAPeb3WGAbrIlO0Dg/mcjFUWa/MaOfYAxIry4HHbCAXK1AIE1isEpsULs4sJCPQ
	 TSLcWXnJ7Lp8i9KHTZ35btlW9LeIMKV99hx5DVsWHhKbO++8xSmXjZwCSMPkKbE9WS
	 4guLofJKfqpHQ==
Date: Wed, 30 Apr 2025 12:02:29 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] btrfs: compression: Adjust cb->compressed_folios
 allocation type
Message-ID: <202504301201.824ADC93A@keescook>
References: <20250426062328.work.065-kees@kernel.org>
 <4dd1e595-21c2-4a6c-a7b9-e7c945d3a7a2@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dd1e595-21c2-4a6c-a7b9-e7c945d3a7a2@embeddedor.com>

On Sat, Apr 26, 2025 at 12:55:21AM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 26/04/25 00:23, Kees Cook wrote:
> > In preparation for making the kmalloc family of allocators type aware,
> > we need to make sure that the returned type from the allocation matches
> > the type of the variable being assigned. (Before, the allocator would
> > always return "void *", which can be implicitly cast to any pointer type.)
> > 
> > The assigned type is "struct folio **" but the returned type will be
> > "struct page **". These are the same allocation size (pointer size), but
> > the types don't match. Adjust the allocation type to match the assignment.
> > 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Chris Mason <clm@fb.com>
> > Cc: Josef Bacik <josef@toxicpanda.com>
> > Cc: David Sterba <dsterba@suse.com>
> > Cc: <linux-btrfs@vger.kernel.org>
> > ---
> >   fs/btrfs/compression.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> > index e7f8ee5d48a4..7f11ef559be6 100644
> > --- a/fs/btrfs/compression.c
> > +++ b/fs/btrfs/compression.c
> > @@ -606,7 +606,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
> >   	free_extent_map(em);
> >   	cb->nr_folios = DIV_ROUND_UP(compressed_len, PAGE_SIZE);
> > -	cb->compressed_folios = kcalloc(cb->nr_folios, sizeof(struct page *), GFP_NOFS);
> > +	cb->compressed_folios = kcalloc(cb->nr_folios, sizeof(struct folio *), GFP_NOFS);
> 
> Why not `sizeof(*cb->compressed_folios)` as in other patches? :)

I generally trying to match the coding style of each instance, though
sometimes it wasn't possible. Here, since a type is named for the
sizeof(), I followed that style.

-- 
Kees Cook

