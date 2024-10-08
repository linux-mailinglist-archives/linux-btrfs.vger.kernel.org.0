Return-Path: <linux-btrfs+bounces-8645-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303B5995426
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 18:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18761F264A9
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 16:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17CE1E0DE5;
	Tue,  8 Oct 2024 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="oWfc76lA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lGG2H3J7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810DA1DF73A;
	Tue,  8 Oct 2024 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403963; cv=none; b=b4poEBX9d5GsMMkq6cN2keJ7w8hu4ogoZri/l0+WkjqoVF1EfUiNDccbjbmlt4cgzXOthbyOq/mujyzwFn0J5RLbfGIFBXyO34CezobX1ejCRW5esHo33K6mwrZx5bi9EtDHcHnojcmiUjmjlupUor22xJ2fPXFjGb6LsrVp7Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403963; c=relaxed/simple;
	bh=CZzxIEzsSBRkKYDnxi/RJ5cxMIFspJYW5g6U1vDUYIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJiN8kW2E8NImom4zHmuM53lSzueLUcDnQgr7WyOMXjopfL6HxjcpoFUoDN8vmvxv1jWRqPSwtPIihAMMFedjOVphtHKDLm9Gws8gxqK1QJKL4xLheQrCfX63Y4oUXgYfo+gE2Y/Yi8/Psjms5L/yuHZHt1CfZeMzIk/f0OaUxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=oWfc76lA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lGG2H3J7; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 909AD1140136;
	Tue,  8 Oct 2024 12:12:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 08 Oct 2024 12:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1728403960; x=1728490360; bh=VyC/b9rlj+
	/31o65lQgzesL2ybRFvnklpCPJrXTWWgE=; b=oWfc76lA4VinHe5zlPumOYkwZV
	H9VidyWRHDm3rEORTlmUPI9J2GLkOmWUDJF0PvOQaCELU6TW1mDy4rmDVnWQ/Tkb
	60HPfvlWTRysVYKSTkGgWAytlTXbmihDRHaJXj8cSW3o0L4a05+2BXYJx5fx3C4U
	bWS1DkgNhM24cXRrd+TinyON9+Fs3cRR10HeSlXvzRwqPayx90D5fIDgirAS/zjX
	/tZaRNMtJVSkDH/GOq9vt7xdrw/WpxLnjuzrryt2yVqAQPottg8X6Dj7K4a+rrjo
	6rcon7Gyw7BGb5RM4vAlTZ4D7lK4vnGTdqXTntRPlY/mUVEg0OC2tOJgi13w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728403960; x=1728490360; bh=VyC/b9rlj+/31o65lQgzesL2ybRF
	vnklpCPJrXTWWgE=; b=lGG2H3J71viquZR5+FSxtlzlcaEvP9eKaxu0w95ocYnu
	Clgvt6YkrBPxtRy8KEqtH15AEcf0VBz3FPdnBNsOttKRqtYx6TtksaC2eNJZa4Ut
	NNQHK/0iGrgza4/HDfEaH3T8sf7gCfHT3con4PBHx2VtD148mN4w9dL5zVETLWZ2
	xqo8sqMdIi6K9REeqdHhnSEqI/iWK7IDsMM3LlEy6LPCJbUOfVqYVoMuqj6SyoiN
	v32HS/Cfa6Q7sBuKijxsmxz8bfJ+CyDfQZbwaj6Gs41WDiidH6uC8/K0YieZ+Alj
	rzdR9DerTOy97yZVq/jwDS4Ef30CqMC3p675da0Q/w==
X-ME-Sender: <xms:91kFZzVhKpjUFhJ1bSPVx9xO-EDfqz73FOTfhQLs_FIBeCFChKCzoQ>
    <xme:91kFZ7kdM7jWNJfdW9HETac-jIrxQBzCb9bcfm_Fq454lg4NepcdUC7TxLW1fIjnU
    YTMOyv99mhSUUFcCPo>
X-ME-Received: <xmr:91kFZ_Y1ZCZDHklK0RxoURFJrTsqeSLe6_5CIrfrtOakn0Bx5SJlJ9X6HRmm0_6cZ4UAr5xQtkdmsuKRG9kFW9eTEbk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenuc
    ggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeu
    gfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepihgrmhhhshifrghnghesghhmrghilhdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghlmhesfhgsrdgtohhmpdhrtghpthhtohepjhhoshgvfhesthhogihitg
    hprghnuggrrdgtohhmpdhrtghpthhtohepughsthgvrhgsrgesshhushgvrdgtohhmpdhr
    tghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrihhsuhifrghn
    ghesthgvnhgtvghnthdrtghomh
X-ME-Proxy: <xmx:91kFZ-Vp0bgP1gT-t2tmq4Mox9VZ2oC3EevGAzDhmUeG8WYkE_g7Wg>
    <xmx:91kFZ9mYrUdyZ5KnSg_NumpLF3pvzdc-C5Azf_ll67M8_WIqH2x4AA>
    <xmx:91kFZ7emLxNOE_008YeJ8PnqtTweQv5TMn2k6NyxKJa3nCjWfxX8lg>
    <xmx:91kFZ3H3Y9AgoUaejc89ZXD6w_r53MA2gSrbm0hTLnwFM7AV_mBsxQ>
    <xmx:-FkFZ_6HBHP0ROWQWpYvI7Jp2YIke4dPJ8sjo1CGFEqtrm7MKQbN6yrd>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 12:12:39 -0400 (EDT)
Date: Tue, 8 Oct 2024 09:12:28 -0700
From: Boris Burkov <boris@bur.io>
To: iamhswang@gmail.com
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, wqu@suse.com, linux-kernel@vger.kernel.org,
	Haisu Wang <haisuwang@tencent.com>
Subject: Re: [PATCH] btrfs: fix the length of reserved qgroup to free
Message-ID: <20241008161228.GA796369@zen.localdomain>
References: <20241008064849.1814829-1-haisuwang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008064849.1814829-1-haisuwang@tencent.com>

On Tue, Oct 08, 2024 at 02:48:46PM +0800, iamhswang@gmail.com wrote:
> From: Haisu Wang <haisuwang@tencent.com>
> 
> The dealloc flag may be cleared and the extent won't reach the disk
> in cow_file_range when errors path. The reserved qgroup space is
> freed in commit 30479f31d44d ("btrfs: fix qgroup reserve leaks in
> cow_file_range"). However, the length of untouched region to free
> need to be adjusted with the region size.
> 
> Fixes: 30479f31d44d ("btrfs: fix qgroup reserve leaks in cow_file_range")
> Signed-off-by: Haisu Wang <haisuwang@tencent.com>

Good catch and fix, thank you!
Reviewed-by: Boris Burkov <boris@bur.io>

Can you please share more information about how you reproduced and
tested this issue for the fix? In one of the other emails in the chain,
you also mentioned a CVE, so explaining the specific impact of the bug
is helpful too.

As far as I can tell, we risk freeing too much space past the real
desired range if start gets bumped before this free, which could lead to
prematurely freeing some other rsv marked data past end. This naturally
leads to incorrect accounting, And I think would allow us to reserve
this same range again. Though perhaps delalloc extent range stuff would
prevent that. Between that, and the changesets gating most of the qgroup
freeing, it's hard to actually see what happens :)

Long ramble short: do you have a reproducer?

> ---
>  fs/btrfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b0ad46b734c3..5eefa2318fa8 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1592,7 +1592,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  		clear_bits |= EXTENT_CLEAR_DATA_RESV;
>  		extent_clear_unlock_delalloc(inode, start, end, locked_folio,
>  					     &cached, clear_bits, page_ops);
> -		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
> +		btrfs_qgroup_free_data(inode, NULL, start, end - start + 1, NULL);
>  	}
>  	return ret;
>  }
> -- 
> 2.39.3
> 

