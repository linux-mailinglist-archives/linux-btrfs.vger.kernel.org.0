Return-Path: <linux-btrfs+bounces-20294-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F717D05DAB
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 20:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 723B93009223
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 19:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BFD32A3F0;
	Thu,  8 Jan 2026 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ZHyDZYa5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q+OKxaIP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6EC3148AC
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767900723; cv=none; b=BLHVbbjgfPkcTJ9JI6AJ70UWPO9PD8Psrb2MJmIKAuvx6lx2+jep5ak2MjfxFIZlOXLK4Nx5JIkQWqM6UL9TPe1MgZC9QvRQyHnE5HZR3QIJvd+rW8tKOD9P3ISt/LgPxfkise9/m3IQ9flZjscDVZqVsTTFEmNfTHgOllRqe70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767900723; c=relaxed/simple;
	bh=ASWnc675Bo62vDmd27ns35LBPO6kQuXWs70Mk+pO3a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m13ksIvHshFDAw3YfmknA0n00fFCOPturEZUSHftxPOr7V8TtQ1AawlzKTPiRDkhug8mRyc4yLTgumqL6T2RTEVixZCMO1IpqG0FbUTO0zz4/DSWFpdlWx3skLAKnus0QfQfycAVIQHtL8p+qLWfOQTECsNvUIPm9f1uzQeIM8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ZHyDZYa5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q+OKxaIP; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 730DA1D00085;
	Thu,  8 Jan 2026 14:32:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 08 Jan 2026 14:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767900720; x=1767987120; bh=ZXBMdkxsmO
	oIdv73fa6C0I6TV0LJgrUCJkdaaGAdWHA=; b=ZHyDZYa5Tsg0vynCg7QlbZzDvp
	BsEbV62uphsusNsQRWJY0cj6LckAnla3p0KyHzwVqpx4sNB8Q6vXCEq/oWCIWcgB
	i1uHYQne+COjXe8hHi9TyHN6GsDVPjfTmoykjDlB44U8e1neG3FGP5MfcScmCHAq
	VIK0qnS2n0rNVZ0hs+BxoFo8iVkcWqr5XUT17jig+frTrautBGSncLyVHE8QArI5
	CPaA43Xnsbmb5nDqwPfnXABRgNTIdkpJgLdJHWewAr/JP2c2kCNuwy/QmxJbpO97
	M5UMYz4+74ko9bjoi0RhoKgBeqMLS5u/F3WncdoRwsObKarDgJaMJCu/xMHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767900720; x=1767987120; bh=ZXBMdkxsmOoIdv73fa6C0I6TV0LJgrUCJkd
	aaGAdWHA=; b=q+OKxaIPKZQyEV2jVfvNW80dfR9aEnTKHxkhnk5bC1/ymCqewNC
	4Flou1HaAvixRaUulwaIbbRIuqvMX/hUZVrOLuUaxqJ/+wwuVTutRPCQLRfCcoWG
	6fTY2Eip/DDEKiTXrRSSM5ETMHuN2eezOAkeM0NHHrnI8Etsg3DLZADC6qdpd2hO
	SPrBU3N3asS0kE3l+cqemJudl19Q0EaVZsLyfcdz4dMcPT/Co/56vz30522kWBkV
	ztZnYLbQQqIhFyEqcLBOlIifCKeRKNEJcMcoAWWNk1xUS9OUftK3ReVY5otm91ua
	fxLBDp53yZR+45+XRu8G5+OouMNRCG0abcg==
X-ME-Sender: <xms:MAZgabPu1zez3YpLGMXh901HjL-UNI_mWSZ9J1TXp4QBWksokBS3sw>
    <xme:MAZgab8T_eanQRrpDVRVe3Q41nVaMPSAqcrFZKvOPrW253-1QdHqusq2_hyfYBZtM
    ARkaRWwwc6sLFcX7-S_ppejtZFPSBAaOXIsGzXvFO_-3Sw2WN7X4zM>
X-ME-Received: <xmr:MAZgaX7428O9hK2C0t1SsFAZ1_XQCdLHGqiqlNVBQIK7M0omeve-30PY-1HIDeIHg1rXY4fXx8nBheUywK1iJrKSkqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeikedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:MAZgaa1K7IXfh2f846Y3X683LTSCmLDFG1gMcs4CBNU1zUgDIbDIqw>
    <xmx:MAZgaWC39Rdrb2uCiti0qAri7E-I4Er6eNzgv3rswkIxqbVMrM4CAQ>
    <xmx:MAZgaU0_d-DNDBDioYFZKm0H6mPMDZqSGoLt1yRmdEXQij0ANlynKg>
    <xmx:MAZgaYvUNbKCf8TPON1CjZ61CRvHKi1qVf3PVgkvLdM5Rr42UOXDvg>
    <xmx:MAZgaShjZ5aPaAjxcDPiZTAnVgMR8CHnheQpvwERXRi9OyCc6c9DNn3s>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 14:31:59 -0500 (EST)
Date: Thu, 8 Jan 2026 11:32:09 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: invalidate pages instead of truncate after
 reflinking
Message-ID: <20260108193209.GA2553335@zen.localdomain>
References: <857d9448b17a3403e5c0bfa71f3defce4331f535.1767891836.git.fdmanana@suse.com>
 <20260108191733.GA2485498@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108191733.GA2485498@zen.localdomain>

On Thu, Jan 08, 2026 at 11:17:33AM -0800, Boris Burkov wrote:
> On Thu, Jan 08, 2026 at 05:10:04PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > Qu reported that generic/164 often fails because the read operations get
> > zeroes when it expects to either get all bytes with a value of 0x61 or
> > 0x62. The issue stems from truncating the pages from the page cache
> > instead of invalidating, as truncating can zero page contents.
> 
> Can you make it more clear if this is a subpage/large folios issue or a
> generic issue? Or maybe just explain the "can zero page contents" in a
> little more detail? I agree that it is the wrong "contract" so your
> change makes sense either way, this is just for future
> knowledge/archaeology.

I answered part of my own question. It reproduced in 10 tries on my x86
system :)

> 
> The documentation of truncate_inode_pages_range only mentions zeroing
> partial pages when "lstart or lend + 1 is not page aligned" but our call
> is
> 
> 	truncate_inode_pages_range(&inode->i_data,
> 				round_down(destoff, PAGE_SIZE),
> 				round_up(destoff + len, PAGE_SIZE) - 1);
> 
> which appears to align it?
> 
> Sorry if I am missing something obvious :)
> 
> > 
> > So instead of truncating, invalidate the page cache range with a call to
> > filemap_invalidate_inode(), which besides not doing any zeroing also
> > ensures that while it's invalidating folios, no new folios are added.
> > This helps ensure that buffered reads that happen while a reflink
> > operation is in progress always get either the whole old data (the one
> > before the reflink) or the whole new data, which is what generic/164
> > expects.
> > 
> > Reported-by: Qu Wenruo <wqu@suse.com>
> 
> Reviewed-by: Boris Burkov <boris@bur.io>
> 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/reflink.c | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> > index e746980567da..f7ddd3765249 100644
> > --- a/fs/btrfs/reflink.c
> > +++ b/fs/btrfs/reflink.c
> > @@ -705,7 +705,6 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
> >  	struct inode *src = file_inode(file_src);
> >  	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
> >  	int ret;
> > -	int wb_ret;
> >  	u64 len = olen;
> >  	u64 bs = fs_info->sectorsize;
> >  	u64 end;
> > @@ -750,25 +749,29 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
> >  	btrfs_lock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
> >  	ret = btrfs_clone(src, inode, off, olen, len, destoff, 0);
> >  	btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
> > +	if (ret < 0)
> > +		return ret;
> >  
> >  	/*
> >  	 * We may have copied an inline extent into a page of the destination
> >  	 * range, so wait for writeback to complete before truncating pages
> 
> s/truncating/invalidating/
> 
> >  	 * from the page cache. This is a rare case.
> >  	 */
> > -	wb_ret = btrfs_wait_ordered_range(BTRFS_I(inode), destoff, len);
> > -	ret = ret ? ret : wb_ret;
> > +	ret = btrfs_wait_ordered_range(BTRFS_I(inode), destoff, len);
> > +	if (ret < 0)
> > +		return ret;
> > +
> 
> Even if it's true, not worth doing in a fix like this, but a question:
> I think buffered reads will check for outstanding ordered_extents and
> wait for them. If we are invalidating the cache next, then how can we
> read the file without seeing this ordered_extent? Is this
> wait_ordered_range still necessary?
> 
> Again, not a blocker for this patch.
> 
> >  	/*
> > -	 * Truncate page cache pages so that future reads will see the cloned
> > -	 * data immediately and not the previous data.
> > +	 * Invalidate page cache so that future reads will see the cloned data
> > +	 * immediately and not the previous data.
> >  	 */
> > -	truncate_inode_pages_range(&inode->i_data,
> > -				round_down(destoff, PAGE_SIZE),
> > -				round_up(destoff + len, PAGE_SIZE) - 1);
> > +	ret = filemap_invalidate_inode(inode, false, destoff, end);
> > +	if (ret < 0)
> > +		return ret;
> >  
> >  	btrfs_btree_balance_dirty(fs_info);
> >  
> > -	return ret;
> > +	return 0;
> >  }
> >  
> >  static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > -- 
> > 2.47.2
> > 

