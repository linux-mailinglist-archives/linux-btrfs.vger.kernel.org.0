Return-Path: <linux-btrfs+bounces-7513-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254BF95F73A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 18:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9CC282D5D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 16:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93983197A97;
	Mon, 26 Aug 2024 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P6L98cES"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8CE197A6C
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691368; cv=none; b=d9Wrq3leP8cmVjlMuwL3NjlM5V7XC8R63/F1Z7tvp9GBcFUF8g7FowUewBZy9OfOL1ht8dioI1uzv1M0BlGaueNxvO0YbUjXuxom10mfqk7u+OIabCmW9+fp3Z3Iz2AU2TXHswlmzmB7XdCLhP7JdSGrQe7PsC+zMiGLzfKTjDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691368; c=relaxed/simple;
	bh=mQqDw30mY7bI26HrKbunLq8dqcW8ccu+VgZ8iR6pZoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4Tybrj8nbipUiHhope7mDqFgCeT5ERSpSTmcPlAmAetff8PmOYJwTIRw1KosgEZwGQbf9Gr2KjyT13SFKnx5RX3lhfDqJoqr3kXM9UMzt3rn1Ew6zM/R4vnadYQeesgioRfVSCCXLvB7gAMIt+4NdneaCccDPvmc7EZJQVwIEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P6L98cES; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=9EWUv2HImFfX/N/60IfkTY1e4eWVBnEv8GezCD5Wv5M=; b=P6L98cESGD9Qh41ZcEq/xBG8SN
	hPI3io7GBvPSM8ZWU5rHhZsEpq709sHLf8UUFkdokoBlOFY4dx0eG59Xd7xEIHXlGZgYN+V0H8juj
	S5KIyXGS7/UIq2c2tCXrvKv56YvSN3AiSCA0nbGsUwSu6lPp+HVPEHwOUR2xYlvB7ubvPZkZq/bcf
	I30eFxO1PWroFdLaT+F9DYGt4kR/AN4AdLNMPWjqwGTUCvIwdX1MqdBu5AhV0+UYlfW4tAqIAB4eQ
	PoA1fV5hLGObyhqEbnFsoC3+iaNAkuOQjafYL5zBtMs4wQR3tPGk9QdxuDlFXxhRkdbYhO7drQ03j
	+fMYmZmA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sid0b-0000000Ff0f-3vrS;
	Mon, 26 Aug 2024 16:56:01 +0000
Date: Mon, 26 Aug 2024 17:56:01 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	linux-f2fs-devel@lists.sourceforge.net, clm@fb.com, terrelln@fb.com,
	dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH 02/14] btrfs: convert get_next_extent_buffer()
 to take a folio
Message-ID: <Zsyzoef1LlNacPkb@casper.infradead.org>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
 <20240822013714.3278193-3-lizetao1@huawei.com>
 <Zsaq_QkyQIhGsvTj@casper.infradead.org>
 <0f643b0f-f1c2-48b7-99d5-809b8b7f0aac@gmx.com>
 <ZscqGAMm1tofHSSG@casper.infradead.org>
 <38247c40-604b-443a-a600-0876b596a284@gmx.com>
 <7a04ac3b-e655-4a80-89dc-19962db50f05@gmx.com>
 <Zsis82IKSAq6Mgms@casper.infradead.org>
 <20240826141301.GB2393039@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240826141301.GB2393039@perftesting>

On Mon, Aug 26, 2024 at 10:13:01AM -0400, Josef Bacik wrote:
> On Fri, Aug 23, 2024 at 04:38:27PM +0100, Matthew Wilcox wrote:
> > On Fri, Aug 23, 2024 at 11:43:41AM +0930, Qu Wenruo wrote:
> > > 在 2024/8/23 07:55, Qu Wenruo 写道:
> > > > 在 2024/8/22 21:37, Matthew Wilcox 写道:
> > > > > On Thu, Aug 22, 2024 at 08:28:09PM +0930, Qu Wenruo wrote:
> > > > > > But what will happen if some writes happened to that larger folio?
> > > > > > Do MM layer detects that and split the folios? Or the fs has to go the
> > > > > > subpage routine (with an extra structure recording all the subpage flags
> > > > > > bitmap)?
> > > > > 
> > > > > Entirely up to the filesystem.  It would help if btrfs used the same
> > > > > terminology as the rest of the filesystems instead of inventing its own
> > > > > "subpage" thing.  As far as I can tell, "subpage" means "fs block size",
> > > > > but maybe it has a different meaning that I haven't ascertained.
> > > > 
> > > > Then tell me the correct terminology to describe fs block size smaller
> > > > than page size in the first place.
> > > > 
> > > > "fs block size" is not good enough, we want a terminology to describe
> > > > "fs block size" smaller than page size.
> > 
> > Oh dear.  btrfs really has corrupted your brain.  Here's the terminology
> > used in the rest of Linux:
> 
> This isn't necessary commentary, this gives the impression that we're
> wrong/stupid/etc.  We're all in this community together, having public, negative
> commentary like this is unnecessary, and frankly contributes to my growing
> desire/priorities to shift most of my development outside of the kernel
> community.  And if somebody with my experience and history in this community is
> becoming more and more disillusioned with this work and making serious efforts
> to extricate themselves from the project, then what does that say about our
> ability to bring in new developers?  Thanks,

You know what?  I'm disillusioned too.  It's been over two and a half
years since folios were added (v5.16 was the first release with folios).
I knew it would be a long project (I was anticipating five years).
I was expecting to have to slog through all the old unmaintained crap
filesystems doing minimal conversions.  What I wasn't expecting was for
all the allegedly maintained filesystems to sit on their fucking hands and
ignore it as long as possible.  The biggest pains right now are btrfs,
ceph and f2fs, all of which have people who are paid to work on them!
I had to do ext4 largely myself.

Some filesystems have been great.  XFS worked with me as I did that
filesystem first.  nfs took care of their own code.  Dave Howells has
done most of the other network filesystems.  Many other people have
also helped.

But we can't even talk to each other unless we agree on what words mean.
And btrfs inventing its own terminology for things which already exist
in other filesystems is extremely unhelpful.

We need to remove the temporary hack that is CONFIG_READ_ONLY_THP_FOR_FS.
That went in with the understanding that filesystems that mattered would
add large folio support.  When I see someone purporting to represent
btrfs say "Oh, we're not going to do that", that's a breach of trust.

When I'm accused of not understanding things from the filesystem
perspective, that's just a lie.  I have 192 commits in fs/ between 6.6
and 6.10 versus 160 in mm/ (346 commits in both combined, so 6 commits
are double-counted because they touch both).  This whole project has
been filesystem-centric from the beginning.

