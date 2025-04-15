Return-Path: <linux-btrfs+bounces-13037-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39149A8A3E5
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 18:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729921887390
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 16:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B5715F306;
	Tue, 15 Apr 2025 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="jZTQyj/9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ELIM7uKc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C1C946F
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733789; cv=none; b=tAkXIVI4k7947ZsJvrthA5cxjBpPq+wWj6L8m+TPjvEbtS9U+T+qHvZ/BZEEZXQVYeJGiCK+z+qhYIrvaiHphSB8jUNha+USChPuEt+ShT9HNyUc26Oavt03EJeAVHGznR9SB3qoQj/rbvEEIp5KvSqwUJujSkcFQiTAZpMj698=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733789; c=relaxed/simple;
	bh=tBQOkuuFAret7oRIoEm9hLSquXbVVI6yjoFT6on5iGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clF8rxkQQf32ok4yKbOTGCk03l2Vjyf8BE6sAIhy4MUYe4xA5Y1FbIqfJ73aNQ8ZMwH4nX5Lha7596l53uUzyebLVjwBp+7kjRg4d4WEXgmtpYWwCOtsExYbqKY66JDfKeTJ8H1LnMpX1+xgctRMnxJDY5FhRxudPEzSq/PNJM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=jZTQyj/9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ELIM7uKc; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B4F01140144;
	Tue, 15 Apr 2025 12:16:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 15 Apr 2025 12:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1744733785;
	 x=1744820185; bh=9KIumYf47vC4U/n2Conh4DMTrpzVQedmqswyK+x8In0=; b=
	jZTQyj/9TG6O/lqdIRLnkcZRov51kROo1eYIkD4Pzdv2ENMzCmn1/uo2QtkRpEI7
	pdqXdFMVXvs2/SSCRfvigau1QrUd0f9YfbFsD5h3toej8ZW8g/Lf00+JLL3N8HLz
	RiPFVpWnmi2DhyMJYeAultFqTs+PpwfrCD1qQ2jqXTpmDt6pCbErRpATvqCa9abh
	T8mVNd5Pwrb61c8/HRvX+t1Snti5z/QQobo2S6F0evhk40WdGNQllXJ4eCLho2nQ
	ZdWUFwQ8rYybVC3oZgUdjSUEwFLWPR62QLl8E/5qqLA2tVFNCmKxTpVLOLgaNYYj
	yQAHUVO0wbZEP0Q5hcU2Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744733785; x=
	1744820185; bh=9KIumYf47vC4U/n2Conh4DMTrpzVQedmqswyK+x8In0=; b=E
	LIM7uKchxGdM5DEFLLcIeNLxQ04h7L7fPppyV3SKllncTBH4Sw8oQJo2BbZfG93g
	JsbQhlYLFwZnAVQJcfpDDEPFVxOCwhtnfs1PX+1WBgTchLV1JeoXa+F3ihoUkWXf
	bjWfe6wa0cTI3EopMuTBc3G16LxAxmxEPYsZkgUvpsRo6iqMfhvNv25IPHq3bxSs
	3f2CBB7imFrenljBFJzE6P2cR19Vg+efD9V3wG2jYiiqQrex1wDstIPMifbO0QTN
	3ELLujx9XgSJPgfGvyIsErH/pti42hBHNkASD9GO+8P7fd5hnMUoSU7WNdPknNjc
	DoHPdbV+dG+hrS9pbklaA==
X-ME-Sender: <xms:WYb-Z_wEW55_A3NcT49OJ032CyhYum8YhilSa7kuvbwX_YtVDl2tpQ>
    <xme:WYb-Z3SjgZsDtSUGZxBK6uukfKoV3OC6RSRTjqKnmu3qtKGSHXiB4PtkAqtjIC5dy
    5FKQ6R3QQlxsoDn2FQ>
X-ME-Received: <xmr:WYb-Z5UoXe35ISyG5jZNQvk8lVB9y3NvD1JVqaqg8030od5kUMERGeKs-fPSRJ3JFa2ek96jHjEgovLyUfoKtjqF0vY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioh
    eqnecuggftrfgrthhtvghrnhepudelhfdthfetuddvtefhfedtiedtteehvddtkedvledt
    vdevgedtuedutdeitdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehquhifvghnrhhuohdrsghtrhhfshesghhmgi
    drtghomhdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprhgt
    phhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:WYb-Z5iRX6ePYF6nPAKw4TxR-_38hoY-QKZ380Xs3ie-8p_2caerIg>
    <xmx:WYb-ZxBS42TNZWzdMoGirZzkczae-jybAqcWTe-k16ssaQreT9GpHA>
    <xmx:WYb-ZyLtKjhsOF2FJxgrAatHWK73ecqK_rMUyeQQjweu58rG5C_JyA>
    <xmx:WYb-ZwAVSQVVkmwuAr9SmF8iJtni8NPwJbrn-SyNswEPtNtHnxq7pg>
    <xmx:WYb-Z34cE2pbsFXikxhmo0F90uLEDPA5tlARv_6QysTi1jbY7hQi7y05>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 12:16:25 -0400 (EDT)
Date: Tue, 15 Apr 2025 09:16:47 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: adjust subpage bit start based on sectorsize
Message-ID: <20250415161647.GA2164022@zen.localdomain>
References: <0914bad6138d2cfafc9cfe762bd06c1883ceb9d2.1744657692.git.josef@toxicpanda.com>
 <7e863b3c-6efc-459b-ae25-cf87734dc38f@gmx.com>
 <27440332-2afb-4fb8-9ebe-d36c8c33a89a@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27440332-2afb-4fb8-9ebe-d36c8c33a89a@gmx.com>

On Tue, Apr 15, 2025 at 08:07:08AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/4/15 07:38, Qu Wenruo 写道:
> > 
> > 
> > 在 2025/4/15 04:38, Josef Bacik 写道:
> > > When running machines with 64k page size and a 16k nodesize we started
> > > seeing tree log corruption in production.  This turned out to be because
> > > we were not writing out dirty blocks sometimes, so this in fact affects
> > > all metadata writes.
> > > 
> > > When writing out a subpage EB we scan the subpage bitmap for a dirty
> > > range.  If the range isn't dirty we do
> > > 
> > > bit_start++;
> > > 
> > > to move onto the next bit.  The problem is the bitmap is based on the
> > > number of sectors that an EB has.  So in this case, we have a 64k
> > > pagesize, 16k nodesize, but a 4k sectorsize.  This means our bitmap is 4
> > > bits for every node.  With a 64k page size we end up with 4 nodes per
> > > page.
> > > 
> > > To make this easier this is how everything looks
> > > 
> > > [0         16k       32k       48k     ] logical address
> > > [0         4         8         12      ] radix tree offset
> > > [               64k page               ] folio
> > > [ 16k eb ][ 16k eb ][ 16k eb ][ 16k eb ] extent buffers
> > > [ | | | |  | | | |   | | | |   | | | | ] bitmap
> > > 
> > > Now we use all of our addressing based on fs_info->sectorsize_bits, so
> > > as you can see the above our 16k eb->start turns into radix entry 4.
> > > 
> > > When we find a dirty range for our eb, we correctly do bit_start +=
> > > sectors_per_node, because if we start at bit 0, the next bit for the
> > > next eb is 4, to correspond to eb->start 16k.
> > > 
> > > However if our range is clean, we will do bit_start++, which will now
> > > put us offset from our radix tree entries.
> > > 
> > > In our case, assume that the first time we check the bitmap the block is
> > > not dirty, we increment bit_start so now it == 1, and then we loop
> > > around and check again.  This time it is dirty, and we go to find that
> > > start using the following equation
> > > 
> > > start = folio_start + bit_start * fs_info->sectorsize;
> > > 
> > > so in the case above, eb->start 0 is now dirty, and we calculate start
> > > as
> > > 
> > > 0 + 1 * fs_info->sectorsize = 4096
> > > 4096 >> 12 = 1
> > > 
> > > Now we're looking up the radix tree for 1, and we won't find an eb.
> > > What's worse is now we're using bit_start == 1, so we do bit_start +=
> > > sectors_per_node, which is now 5.  If that eb is dirty we will run into
> > > the same thing, we will look at an offset that is not populated in the
> > > radix tree, and now we're skipping the writeout of dirty extent buffers.
> > > 
> > > The best fix for this is to not use sectorsize_bits to address nodes,
> > > but that's a larger change.  Since this is a fs corruption problem fix
> > > it simply by always using sectors_per_node to increment the start bit.
> > > 
> > > Fixes: c4aec299fa8f ("btrfs: introduce submit_eb_subpage() to submit a
> > > subpage metadata page")
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > >   fs/btrfs/extent_io.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > index 5f08615b334f..6cfd286b8bbc 100644
> > > --- a/fs/btrfs/extent_io.c
> > > +++ b/fs/btrfs/extent_io.c
> > > @@ -2034,7 +2034,7 @@ static int submit_eb_subpage(struct folio
> > > *folio, struct writeback_control *wbc)
> > >                     subpage->bitmaps)) {
> > >               spin_unlock_irqrestore(&subpage->lock, flags);
> > >               spin_unlock(&folio->mapping->i_private_lock);
> > > -            bit_start++;
> > > +            bit_start += sectors_per_node;
> > 
> > The problem is, we can not ensure all extent buffers are nodesize aligned.
> > 

In theory because the allocator can do whatever it wants, or in practice
because of mixed block groups? It seems to me that in practice without
mixed block groups they ought to always be aligned.

> > If we have an eb whose bytenr is only block aligned but not node size
> > aligned, this will lead to the same problem.
> > 

But then the existing code for the non error path is broken, right?
How was this intended to work? Is there any correct way to loop over the
ebs in a folio when nodesize < pagesize? Your proposed gang lookup?

I guess to put my question a different way, was it intentional to mix
the increment size in the two codepaths in this function?

> > We need an extra check to reject tree blocks which are not node size
> > aligned, which is another big change and not suitable for a quick fix.
> > 
> > 
> > Can we do a gang radix tree lookup for the involved ranges that can
> > cover the block, then increase bit_start to the end of the found eb
> > instead?
> 
> In fact, I think it's better to fix both this and the missing eb write
> bugs together in one go.
> 
> With something like this:
> 
> static int find_subpage_dirty_subpage(struct folio *folio)
> {
> 	struct extent_buffer *gang[BTRFS_MAX_EB_SIZE/MIN_BLOCKSIZE];
> 	struct extent_buffer *ret = NULL;
> 
> 	rcu_read_lock()
> 	ret = radix_tree_gang_lookup();
> 	for (int i = 0; i < ret; i++) {
> 		if (eb && atomic_inc_not_zero(&eb->refs)) {
> 			if (!test_bit(EXTENT_BUFFER_DIRTY) {
> 				atomic_dec(&eb->refs);
> 				continue;
> 			}
> 			ret = eb;
> 			break;
> 		}
> 	}
> 	rcu_read_unlock()
> 	return ret;
> }
> 
> And make submit_eb_subpage() no longer relies on subpage dirty bitmap,
> but above helper to grab any dirty ebs.
> 
> By this, we fix both bugs by:
> 
> - No more bitmap search
>   So no increment mismatch, and can still handle unaligned one (as long
>   as they don't cross page boundary).
> 
> - No more missing writeback
>   As the gang lookup is always for the whole folio, and we always test
>   eb dirty flags, we should always catch dirty ebs in the folio.

I don't see why this is the case. The race Josef fixed is quite narrow
but is fundamentally based on the TOWRITE mark getting cleared mid
subpage iteration.

If all we do is change subpage bitmap to this gang lookup, but still
clear the TOWRITE tag whenever the folio has the first eb call
meta_folio_set_writeback(), then it is possible for other threads to
come in and dirty a different eb, write it back, tag it TOWRITE, then
lose the tag before doing the tagged lookup for TOWRITE folios.

Thanks,
Boris

> 
> Thanks,
> Qu
> 
> > 
> > Thanks,
> > Qu
> > 
> > >               continue;
> > >           }
> > 
> 

