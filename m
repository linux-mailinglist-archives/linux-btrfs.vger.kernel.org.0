Return-Path: <linux-btrfs+bounces-14082-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 097ECABA0CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 18:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7AE1B632CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 16:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822F11B6D06;
	Fri, 16 May 2025 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="lJ6zUDTD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gbIvd1Ol"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA9623CB
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413147; cv=none; b=dLzkltoLqdk9y51pIaehWElCAQSdYfOHcScEjWVxlZr7nLWrmIfg5jAM4Q++NiZutkStAZqMw2M3ZxQQ+jZC2MghONGEB/C4Z6LJ5UbQZCPMqrUvyXQwkb7yv3BUkHALp7QrQW5uv1NjgCj+lvY1I8YiAVo3KjmWcEt4AeoCBMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413147; c=relaxed/simple;
	bh=/E742Hm37+1QnxhX4K8kwuB2UGDHpsvBqK5yXWVE6VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gltL2ySMS32ipaof3xPyPgpOpW4AkYMVMY8bx8R32pyFGJEM1jb5DLutl80i5NRVj79O9rp5K26LZWW/BK0fsshpohbIUtdUWgwu2oSkQjnbrSYQ209Siac8m/xinvxWXO03SA1Nf7lm6A5vIwQXPl+GukuqCbwB7fMpZ9lG9pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=lJ6zUDTD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gbIvd1Ol; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0E53413800D6;
	Fri, 16 May 2025 12:32:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 16 May 2025 12:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1747413144; x=1747499544; bh=zFqirxbFyS
	17vs8eGA01z8FhF54GmylNjzoK3vpPrX0=; b=lJ6zUDTDChWJWeRwHujyy5kXiE
	wHNDFRo0u+j1GCIa6vSvIQuJ4prj8PKZXC7dK8bJFFcbufgFHwQ9qLgbnVd9ijJW
	lYyEkckhiwFxRCtfYvbBbowuF/qH8T/noHFpqxc9dYJA3slT8anpvyg8LR+yBQsv
	R9Y7d5pTPjvakFMMHXGbYlhglv1brLANON+xPqZtx02UQiuQUxGGToE6t3oNby4C
	q88DVKEqcuVWZGFHcA0wPWUp3MK1U7mmJtPxUoa30+sZIbH3au9cBfqtm4Gqm90y
	3sLtI5Nw2LAAGLCOMmEePrLa2be82UssnSACv97bZPunJCLjZrPPgIG4hh6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747413144; x=1747499544; bh=zFqirxbFyS17vs8eGA01z8FhF54GmylNjzo
	K3vpPrX0=; b=gbIvd1OlYrdGIYG2tmA/uDJ3+yC5LO1BpLpL6wNjFoeddm+6Y6M
	CaRjePGq++Iz7wzqSJe2NWk2bXbVpC0h5IXZNRHT6ZUnk3UhxWxdMXInw+deBT4Q
	wiQ6ztzWpx0wIYnJxO+dqo9sdPOF4JK6qP6PSEspndaBvsIx5oE3DMsCuwxMbfGU
	yzxeMI2PWBABDwNypWglKR4zFCkELZiNlg/TBazX4wrFD0p10Ja1pmwn58DXdEme
	A3IgLoInZoFsoN9YiqW4z5SFtCI6Nd/HgK6ms2Pv1jiYeSbRc2eXzDxZzgBQXYGL
	qgEO+kCSkqMObhnI3sdfTB2HE6FJUhen/5g==
X-ME-Sender: <xms:l2gnaE9n2PLuC-5Zmn6CJ-ksmxeAM8MEASPyq0fB9F4_jwid2XU-7Q>
    <xme:l2gnaMsSv9njdjEipxdD5d-LLSAJh-2f7TQpKnYt5OmXtiP3Ou8WtpzCANyz3jyaJ
    tXOvhO0N7FHuLvTsDY>
X-ME-Received: <xmr:l2gnaKC6wbVxIb6S8TWnS41QBMnRqX5j1wlmYnauPzA1QymMcN43_C7RFmVXOBh6pbcXmcJjjezZPy7mtA_PiNj2xdk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhho
    vhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeelle
    fhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfughm
    rghnrghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:l2gnaEeii4HS-KDpjL4NTkgRk6HfXOpDHLP88Ss45axfNYAxcw8yUg>
    <xmx:l2gnaJOm9wN991gOghnTwS5QfiuPcNfKYiMqQYrbFs4gIlHBOZFbrQ>
    <xmx:l2gnaOmahLpVVXnhLOutX67mviVjnFoFAduL0BXvYjfBRq9pVJEk5Q>
    <xmx:l2gnaLvcDN1XOMOo5d-iAvFrk7m0AkhJq2_3uD-ElMmMZztHHSBEeA>
    <xmx:mGgnaGY_5ujSOvmK6Iv8zynny-Moh4Ln-kajGSvtlW6TL6rinHtwSn-m>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 12:32:23 -0400 (EDT)
Date: Fri, 16 May 2025 09:32:50 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: unfold transaction aborts at
 btrfs_create_new_inode()
Message-ID: <20250516163201.GA3549475@zen.localdomain>
References: <32127d7f66702d0b80132bea776e214077b42872.1747412285.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32127d7f66702d0b80132bea776e214077b42872.1747412285.git.fdmanana@suse.com>

On Fri, May 16, 2025 at 05:19:15PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Instead of having a common btrfs_transaction_abort() call for when either
> btrfs_orphan_add() failed or when btrfs_add_link() failed, move the
> btrfs_transaction_abort() to happen immediately after each one of those
> calls, so that when analysing a stack trace with a transaction abort we
> know which call failed.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/inode.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index c0c778243bf1..7d27875600d6 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6610,13 +6610,17 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
>  
>  	if (args->orphan) {
>  		ret = btrfs_orphan_add(trans, BTRFS_I(inode));
> +		if (ret) {
> +			btrfs_abort_transaction(trans, ret);
> +			goto discard;
> +		}
>  	} else {
>  		ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode), name,
>  				     0, BTRFS_I(inode)->dir_index);
> -	}
> -	if (ret) {
> -		btrfs_abort_transaction(trans, ret);
> -		goto discard;
> +		if (ret) {
> +			btrfs_abort_transaction(trans, ret);
> +			goto discard;
> +		}
>  	}
>  
>  	return 0;
> -- 
> 2.47.2
> 

