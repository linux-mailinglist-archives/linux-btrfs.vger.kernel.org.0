Return-Path: <linux-btrfs+bounces-7523-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E352E95FBB7
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 23:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6E7283DF7
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 21:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274FF19AD8E;
	Mon, 26 Aug 2024 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Fgb2Aj6J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F027213DDCC
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707942; cv=none; b=trTnv6528pVOt/pTZrtQVI0ObJpblP05oQOkIS8lG68+mhAdmgx/Nh/jIr5rK5JY05N5v2eHntG3+mKHIX7NqaqomwsrJ48e2DW4mqNGLSxPJtplQgAMRbcu0RJcQGHvCadYhUGiExNFoRhX1Rk6J+AgWnpqWqeQNlfMQ4wMpbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707942; c=relaxed/simple;
	bh=2ek0yDKSB2gTN1Xpa9IujVjVQbR5N0mjF7EUovXUPmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMpsDfjPk95A/OPKjysqvZUK6uGc0fzm3SBU8AKC01fU/QNyaXOLap2ror/r5KMTI15UcjLSv/zTvkLHbbbsesQwtYlnUdZc/dvd9w/JYRBSqYpFQ+nZjqSdpl0523Ts0uspAl7SWTMpqykl+277hNIbMR18EFb/6qwJgqRMTlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Fgb2Aj6J; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d7bc07b7so313253685a.0
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 14:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724707939; x=1725312739; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=By8CKYnZaj8r7EpytON1Xz+eijJuZOFzFCGO6VJQjvk=;
        b=Fgb2Aj6JjxW+Ojzfpg09EC/xc6UbzfbDmUoPFwlD6D8aKRcXGzWaNQX0DkRVKwm5dB
         QFuQ6M6moZGiuxyVXYvEWNirCmev3K6RzpJ7uk26JRCvdYMWDvjIx3wHdVYv/ShhaM9j
         VUsY9ydgCGcNxCudsRdcXVvTiFG6OXOjc0FjFdkSN03KIhZayTPGSqDpQP99MCa6dnax
         L/YzjnopS4EzG4b3d5LSn7TgoeNcahWV5aWd0GztynY9LalzAxoLpx6KcAyIC5WItIiz
         36CjMYUiLFjD7iJU6CoQBl0cA52C9ZGvfNdG6qrLzuUdWFH3ufmzU0V7WJCwIUE1vlsL
         e8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724707939; x=1725312739;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=By8CKYnZaj8r7EpytON1Xz+eijJuZOFzFCGO6VJQjvk=;
        b=PXr61NFqqNODToJestuxI6ks7Zc7fA1QETgHVLdgjNCvIlDUue16zMQr+MppjLkjuY
         FEv7/wA3/ot9ZquzyiHJxB6B8ETaUwUasPXj4CxliBMgkFxjn/q7tb3Eb6F8OWEe2v8w
         wC3AfVuiRdHbywJlnSNzzsgDxfWMG98kHPx55TKcv3RmRBKCn6VVgWsqbsO3wbvLXBUz
         WdLeFAZ7Xt9g6svUFHFV4rsDEL2Z7Gwz/1CJIk+QSYsUjet2n69OSh0CMdC6Q9UcW1zG
         aKQYDmRREupx++uzfP2RLoWwLvaCYAIDStB3FCCi/JLpl+adgl0VB22EmUFo+Gr6tQRo
         yCNA==
X-Forwarded-Encrypted: i=1; AJvYcCVX0XmBTZMfN4ZCtm4IFpW+ifXirW412UMNDagmbgm2yrsVUN3890iIe5g9pybMRwIpMr7f8VnUdWWfdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVveqOw/SdTXJbkrobA8cBU2474V0QPf41NKBZWDjxiU2NgNah
	A0nSQ58fIJ6uI6tMOUZZK8SZNV7vDLSkXd/lMwSlTCqDy7T6xZnEI2sdkA0+I5I=
X-Google-Smtp-Source: AGHT+IGlUx4UI/v3b2oENqpUD3SWe5iXsSQ5zVHEi5EPQKaNatFrxKUMmpfzMaoDqDOnznbvgWPVyg==
X-Received: by 2002:a05:620a:4403:b0:7a2:db1:573d with SMTP id af79cd13be357-7a689719a8bmr1317699185a.36.1724707938647;
        Mon, 26 Aug 2024 14:32:18 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f41e276sm488523785a.136.2024.08.26.14.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 14:32:17 -0700 (PDT)
Date: Mon, 26 Aug 2024 17:32:16 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	linux-f2fs-devel@lists.sourceforge.net, clm@fb.com, terrelln@fb.com,
	dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH 02/14] btrfs: convert get_next_extent_buffer()
 to take a folio
Message-ID: <20240826213216.GA2420297@perftesting>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
 <20240822013714.3278193-3-lizetao1@huawei.com>
 <Zsaq_QkyQIhGsvTj@casper.infradead.org>
 <0f643b0f-f1c2-48b7-99d5-809b8b7f0aac@gmx.com>
 <ZscqGAMm1tofHSSG@casper.infradead.org>
 <38247c40-604b-443a-a600-0876b596a284@gmx.com>
 <7a04ac3b-e655-4a80-89dc-19962db50f05@gmx.com>
 <Zsis82IKSAq6Mgms@casper.infradead.org>
 <20240826141301.GB2393039@perftesting>
 <Zsyzoef1LlNacPkb@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zsyzoef1LlNacPkb@casper.infradead.org>

On Mon, Aug 26, 2024 at 05:56:01PM +0100, Matthew Wilcox wrote:
> On Mon, Aug 26, 2024 at 10:13:01AM -0400, Josef Bacik wrote:
> > On Fri, Aug 23, 2024 at 04:38:27PM +0100, Matthew Wilcox wrote:
> > > On Fri, Aug 23, 2024 at 11:43:41AM +0930, Qu Wenruo wrote:
> > > > 在 2024/8/23 07:55, Qu Wenruo 写道:
> > > > > 在 2024/8/22 21:37, Matthew Wilcox 写道:
> > > > > > On Thu, Aug 22, 2024 at 08:28:09PM +0930, Qu Wenruo wrote:
> > > > > > > But what will happen if some writes happened to that larger folio?
> > > > > > > Do MM layer detects that and split the folios? Or the fs has to go the
> > > > > > > subpage routine (with an extra structure recording all the subpage flags
> > > > > > > bitmap)?
> > > > > > 
> > > > > > Entirely up to the filesystem.  It would help if btrfs used the same
> > > > > > terminology as the rest of the filesystems instead of inventing its own
> > > > > > "subpage" thing.  As far as I can tell, "subpage" means "fs block size",
> > > > > > but maybe it has a different meaning that I haven't ascertained.
> > > > > 
> > > > > Then tell me the correct terminology to describe fs block size smaller
> > > > > than page size in the first place.
> > > > > 
> > > > > "fs block size" is not good enough, we want a terminology to describe
> > > > > "fs block size" smaller than page size.
> > > 
> > > Oh dear.  btrfs really has corrupted your brain.  Here's the terminology
> > > used in the rest of Linux:
> > 
> > This isn't necessary commentary, this gives the impression that we're
> > wrong/stupid/etc.  We're all in this community together, having public, negative
> > commentary like this is unnecessary, and frankly contributes to my growing
> > desire/priorities to shift most of my development outside of the kernel
> > community.  And if somebody with my experience and history in this community is
> > becoming more and more disillusioned with this work and making serious efforts
> > to extricate themselves from the project, then what does that say about our
> > ability to bring in new developers?  Thanks,
> 
> You know what?  I'm disillusioned too.  It's been over two and a half
> years since folios were added (v5.16 was the first release with folios).
> I knew it would be a long project (I was anticipating five years).
> I was expecting to have to slog through all the old unmaintained crap
> filesystems doing minimal conversions.  What I wasn't expecting was for
> all the allegedly maintained filesystems to sit on their fucking hands and
> ignore it as long as possible.  The biggest pains right now are btrfs,
> ceph and f2fs, all of which have people who are paid to work on them!
> I had to do ext4 largely myself.
> 
> Some filesystems have been great.  XFS worked with me as I did that
> filesystem first.  nfs took care of their own code.  Dave Howells has
> done most of the other network filesystems.  Many other people have
> also helped.
> 
> But we can't even talk to each other unless we agree on what words mean.
> And btrfs inventing its own terminology for things which already exist
> in other filesystems is extremely unhelpful.
> 
> We need to remove the temporary hack that is CONFIG_READ_ONLY_THP_FOR_FS.
> That went in with the understanding that filesystems that mattered would
> add large folio support.  When I see someone purporting to represent
> btrfs say "Oh, we're not going to do that", that's a breach of trust.
> 
> When I'm accused of not understanding things from the filesystem
> perspective, that's just a lie.  I have 192 commits in fs/ between 6.6
> and 6.10 versus 160 in mm/ (346 commits in both combined, so 6 commits
> are double-counted because they touch both).  This whole project has
> been filesystem-centric from the beginning.

I'm not talking about the pace of change, I'm talking about basic, professional
communication standards.  Being frustrated is one thing, taking it out on a
developer or a project in a public forum is another.  Thanks,

Josef

