Return-Path: <linux-btrfs+bounces-13009-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE4FA88C7F
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 21:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D07E17A9E3F
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 19:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DE71C700B;
	Mon, 14 Apr 2025 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="icl6sY1y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rk2gOid0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFF81547E7
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660450; cv=none; b=rciFxABhTDuUb+qsf1rApWU1Kih6YgARrIpPEFvXKRsw4kATdzi9KRnAaSZ9FZJpMrA6B27i4GsTCMJAwZkyZi3bBUHCEMWHa7u7FpJuYSI4sDLZc4p1+5/5IXTUB3kwiDEwki+UPpUgXMjqLvJmyZMCdipXqaXOiuTZrxXBjP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660450; c=relaxed/simple;
	bh=3FHhpAI2fL6Zo6xJaQTZbzEqgQxsJcZ/AZJOVF2ECMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vf7D8mXvmWus/sdFKIrSuKna+n9XEgvm0pfSgx1WKwFIPLRbZjwhvfrtRgT5ar2GoWgbc4AYt3KT4PiDKtub2k7FweFJbnH25jGMSW0yx8fVEtBUdrM3R3g6uRx7xKFEoKkQ8gyQXS3W9TW8ypAl84yvG0s+Y5EiSHC0PkzLWME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=icl6sY1y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rk2gOid0; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 067A21380545;
	Mon, 14 Apr 2025 15:54:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 14 Apr 2025 15:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1744660447; x=1744746847; bh=eLYfTqDu5L
	+sF7IiUeiQ3lG3B/VSkHQQZyPolNRy0WI=; b=icl6sY1yS+PYIUd1fXfoJZRfot
	+zL2eHFMBhGa3NpU/o1ZjNa8Fin7l0oXN79AZy5hhfEF4vktdPO+76zWHy3QsdOt
	x1+3sRBiwkRaHYCnO1jf4r2LHewFugB57awlNm7U4xsorCBVbjpt32kuhG5deKYw
	98m6/hpqsbqGCTexNZCo9PzpsvUlqsJPJM1MWt9UHLPNaUjXGpncw0s9tY66hi+h
	VU7DAuXY3NMdAkZ/QSMYKcRqM4FvofbotfL4AiQD6r3U7yFfxnRLi+p4E0zyEnsp
	iSE8zC1g5s2X0XUHm+mMGJAJAPmdZAjeVrFA01OOjUBIXF52qm7PgjroP0OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744660447; x=1744746847; bh=eLYfTqDu5L+sF7IiUeiQ3lG3B/VSkHQQZyP
	olNRy0WI=; b=rk2gOid0QY3C4Y5IzK4uTrAcTPitJI5VoRJcbmJ9Gdmi3oTxcmq
	ntELakNWSKRxKetX3haJjVbXeXiBAeIQIL6OYTjb5SYk1wnh4GcqvbVHY5dMq9+p
	G11xyhhoyR6tLoMiqm1uisIzIxrT390QcygXGoQ58II/t7ipdjYaOYUp1R2AR7/K
	3PHf/9nmeD2yRrcucqh64FsLNCBCI3bd5Kxl6wAD2zEMRjXzkxaalFooprxbLKhL
	Wm+RV2wmdlyK9mP1wBA+Afks7QEjjPSV4d7j/HkjlONly/XmdAa9EUZe4NexvXRR
	1Aht5VYzX91sAsAfOZVrJ22jJFidUAFcRqQ==
X-ME-Sender: <xms:3mf9Z4_Y74RoV4l2Fnp-nDCzcqzMtvi7R5INbFj-keoTW7tSdz-zaQ>
    <xme:3mf9ZwvLeQTUngJLdF6AzXcCba91997V5CLg0ExajSGszLms5udCrQFdyqBErc9zg
    JLYZj3Pv-RvdpjStB4>
X-ME-Received: <xmr:3mf9Z-CtywMAFw0kJOSgD9UVqxdfWvZkQwiazt6CLmzuHQOVnX7Xs5QRUctPPm3sWhgAk2vgx-VvaValvdH_b8dinwI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqe
    enucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedu
    gfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:3mf9Z4e0U2sKTToP8Bc4gOkftZiXXCCJoGdOEbnO5rOx7Pbz-i3how>
    <xmx:3mf9Z9PrjKEEWxlDQKPI4moJAmIlr1O1tUIxS3rC_4T_1ODXQnFR1w>
    <xmx:3mf9ZymXSkZUCceFPrf3mhMmw-xyy5npiSEOsEpuhc3QAUDnGnTErA>
    <xmx:3mf9Z_vD-kso_6_7qiy4FQjENbpvRHqSEEci5_Z5ClKErC-O_E4Cgg>
    <xmx:3mf9Z3Ae7CiyeYKgFuV-F7TMmhcbz6lgSt-I7mHcugCatGquJZLp2NDB>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 15:54:06 -0400 (EDT)
Date: Mon, 14 Apr 2025 12:54:29 -0700
From: Boris Burkov <boris@bur.io>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: adjust subpage bit start based on sectorsize
Message-ID: <20250414195429.GB3218113@zen.localdomain>
References: <0914bad6138d2cfafc9cfe762bd06c1883ceb9d2.1744657692.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0914bad6138d2cfafc9cfe762bd06c1883ceb9d2.1744657692.git.josef@toxicpanda.com>

On Mon, Apr 14, 2025 at 03:08:16PM -0400, Josef Bacik wrote:
> When running machines with 64k page size and a 16k nodesize we started
> seeing tree log corruption in production.  This turned out to be because
> we were not writing out dirty blocks sometimes, so this in fact affects
> all metadata writes.
> 
> When writing out a subpage EB we scan the subpage bitmap for a dirty
> range.  If the range isn't dirty we do
> 
> bit_start++;
> 
> to move onto the next bit.  The problem is the bitmap is based on the
> number of sectors that an EB has.  So in this case, we have a 64k
> pagesize, 16k nodesize, but a 4k sectorsize.  This means our bitmap is 4
> bits for every node.  With a 64k page size we end up with 4 nodes per
> page.
> 
> To make this easier this is how everything looks
> 
> [0         16k       32k       48k     ] logical address
> [0         4         8         12      ] radix tree offset
> [               64k page               ] folio
> [ 16k eb ][ 16k eb ][ 16k eb ][ 16k eb ] extent buffers
> [ | | | |  | | | |   | | | |   | | | | ] bitmap
> 
> Now we use all of our addressing based on fs_info->sectorsize_bits, so
> as you can see the above our 16k eb->start turns into radix entry 4.
> 
> When we find a dirty range for our eb, we correctly do bit_start +=
> sectors_per_node, because if we start at bit 0, the next bit for the
> next eb is 4, to correspond to eb->start 16k.
> 
> However if our range is clean, we will do bit_start++, which will now
> put us offset from our radix tree entries.
> 
> In our case, assume that the first time we check the bitmap the block is
> not dirty, we increment bit_start so now it == 1, and then we loop
> around and check again.  This time it is dirty, and we go to find that
> start using the following equation
> 
> start = folio_start + bit_start * fs_info->sectorsize;
> 
> so in the case above, eb->start 0 is now dirty, and we calculate start
> as
> 
> 0 + 1 * fs_info->sectorsize = 4096
> 4096 >> 12 = 1
> 
> Now we're looking up the radix tree for 1, and we won't find an eb.
> What's worse is now we're using bit_start == 1, so we do bit_start +=
> sectors_per_node, which is now 5.  If that eb is dirty we will run into
> the same thing, we will look at an offset that is not populated in the
> radix tree, and now we're skipping the writeout of dirty extent buffers.
> 
> The best fix for this is to not use sectorsize_bits to address nodes,
> but that's a larger change.  Since this is a fs corruption problem fix
> it simply by always using sectors_per_node to increment the start bit.
> 
> Fixes: c4aec299fa8f ("btrfs: introduce submit_eb_subpage() to submit a subpage metadata page")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/extent_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 5f08615b334f..6cfd286b8bbc 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2034,7 +2034,7 @@ static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
>  			      subpage->bitmaps)) {
>  			spin_unlock_irqrestore(&subpage->lock, flags);
>  			spin_unlock(&folio->mapping->i_private_lock);
> -			bit_start++;
> +			bit_start += sectors_per_node;
>  			continue;
>  		}
>  
> -- 
> 2.48.1
> 

