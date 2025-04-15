Return-Path: <linux-btrfs+bounces-13042-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB02A8A557
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 19:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72538189298C
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 17:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C1821C9EB;
	Tue, 15 Apr 2025 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KQvSj2f/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B3C1BC2A
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744737920; cv=none; b=srAeBFOvXpGO7LvV//+4DC8/oJN2KdYUNYSDQZ+STh+o2ES0WSSbSzCsyn3cbtMnnls6Eja6huNIloqjZ/vhQrdgbSd4lHV7LQzS2M/oZ2TRpYPq9hcMG6FJG8tzcqeRi7EdBNT5PAXxXBzgvcyZR6IgMZVT6tGRyvhroy9x+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744737920; c=relaxed/simple;
	bh=pseoooe/c5FtGXwgp3YzevtMj5lEfmwrBOgVetkCmns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsKEDcAmrfKFJExTdHzjAe3X6v5kL2r6R+U2gahyx6N4f7D7G230f2ZdDW/kOKeaBGIjcd0qBr0iHVKL/RxpNvnDzJWa/n4hkhsTjHThijMebwg4H4BuJ7AxVLFkWYTOTYt1fdr3TxJCrYtabGapTTvO3AWCmtCaPyn/OHTkyg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=KQvSj2f/; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ef60e500d7so52814087b3.0
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 10:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744737915; x=1745342715; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZhBuXZ1y8oDf7JH4IUVgwrE7wxDtPfiw6ySc0V3h7aU=;
        b=KQvSj2f/hBDXsLEUqqhLf0tJcLBrIA/7hIvuQoJZdGaSSPYkDUxxP5c/vEc6jfHlad
         7K3EvJrZ/G0k3RbdyPNBXYCL4DcxrK5E+Eg18FnIpRg+5gHd329bsjnmKGqNx+C99cju
         leeHePw6Q0hwWogqZKveJ56UOJ5eV6dBdjdEZsUJ4GBOfm9WOCLbh9h4tC62QX0b+cie
         sJy+bkxPI0YUTtFnIoDUZe7h8dUjBpTV9Dh23L8Dhd/eHzCAcnAEhhIyRjwaYrpTrVZO
         Gsi/1Wh6qcRc83ULvA3UTH3smIwXX4JB33784eAoqqNNhXHA8y/VLxoKCA7Z4m3GGrjJ
         exMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744737915; x=1745342715;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhBuXZ1y8oDf7JH4IUVgwrE7wxDtPfiw6ySc0V3h7aU=;
        b=qIB6tA/1h+Hy9+DziPatXIVDLIRWsaSFkjiHGihO9rxzCKanBTVSU6v4HMrWtxXMfC
         4bj7SXMCru66TIh0a89QzpomHymH2OhSZUlAPXfNTTSiH74HJGScsa8H84LMfLf3Nq+A
         hD2zCTlz9kWphJJRVj4011pvpR3yej7yC4ziWOFPB5nmC/5267MuyIIEBDXBFVDcYwcL
         lQlZGoRMypD3a8FT4GvG3GLVrTB4dX0iBvrlcxse2ru5qykD8L2JEvaK0azhpdjxwGqP
         1V8nbHPXHjnc5mmODH8Tlo1pl0lbKCx3a4dydyW7FvM070Rpnm2dNphx20upOSsb9R4S
         og2A==
X-Gm-Message-State: AOJu0YzoQU6lcHjb84bW47NXw0v6FSjDleZcQ9kGQL3MKPohE6vBFTWV
	/qfDId9e3wW52+UPu2E3Pi1U6Sc7xOn6SOJHM6ORhLiSMxNDnOzgI1jb71zboMA=
X-Gm-Gg: ASbGncub3Owk1qpoaERDziFUuU5zrUNLwIyjfRjvLAv+BehcQ6QaD9uUWr9C4NoFDeE
	CQNtKpWoD9cWpDZB4mfRYNvvN6p5MtzVer0xgztfo4p/Ac5/A2QAUGJaRExtl9rcZ9VAYeC+DcJ
	Ux1e/Gc9TjOwBitFs0N0Tyb8Y+Ag8Mv/J8Dtd+Iz2Q21zEBZyeQLBvtcan1TnMj/Q6pjaOiBnlP
	fQ5x41lQQQdbkYkwS52zI1QT9E4JhNUgc9bXio3/E5lx44DqoHVWMjdUMPzH6RTpLsAyCJtl8bO
	uH0xl4qj9Kxa7V1JcPBGC7kfrxEqR10G2XxJDFg5qSmkDoCohMWZqXXd0EzpZ3I8yIbNbUOGbRn
	+vA==
X-Google-Smtp-Source: AGHT+IFhB5kb2TYjeMpyG+OfFhgFBlrk2eskoTKk/3aJOwSBGGuKiWA3buk35GnN8foszQJ/nV3VgQ==
X-Received: by 2002:a05:690c:6f8d:b0:703:c6fa:2c30 with SMTP id 00721157ae682-706aced1ccbmr2380577b3.15.1744737914909;
        Tue, 15 Apr 2025 10:25:14 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e39cacbsm38062917b3.98.2025.04.15.10.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 10:25:14 -0700 (PDT)
Date: Tue, 15 Apr 2025 13:25:13 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: adjust subpage bit start based on sectorsize
Message-ID: <20250415172513.GC2701859@perftesting>
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
> > If we have an eb whose bytenr is only block aligned but not node size
> > aligned, this will lead to the same problem.
> > 
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

Again, I'm following up with a better solution for all of this.  The current
patch needs to be pulled back to a ton of kernels, so this is targeted at fixing
the problem, and then we can make it look better with a series that has a longer
bake time.  Thanks,

Josef

