Return-Path: <linux-btrfs+bounces-4501-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B46108AF49C
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 18:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD2A1C23D67
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 16:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5187F13D8A6;
	Tue, 23 Apr 2024 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="2eTgWFlh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C6C13D606
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Apr 2024 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890958; cv=none; b=m8UjUU7THXiFXTH8+BCSY6/KfqjjXbbFUtpndFoKfT2o8/F72f9q83QalGG7fFc9gX6jn07UriCFKdvRk3oK6Cnv2gghC54Fe5ejW136UH7Mr/hwQb4N3ATKjerrgTXEqpxaaBUNynXfQwPR5ghoUP/H6WU0HhBcotgavCgD/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890958; c=relaxed/simple;
	bh=ZPzp9LD6qTKsGWhlV4UxsXgnForDZzTMX6xxKyTYtUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXD4OCsOIH27XO4HOtRQ5hKCd3q0ss2FMkueIoomxqR1pOlo7CFdGzGQPrbkiJ9rZlljv/9BS0Q61TRXT1p1mwDQ/cdeojh4LoyWEj4Me0gWfIPkIGdg5wMaaHM3pph2JMMQp9uw4tDOLndoTQ7q2hURotDjeAqNo4cfoN8di70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=2eTgWFlh; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-de46b113a5dso5518637276.3
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Apr 2024 09:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713890955; x=1714495755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=27zQqgEtMMu+Y/tN4IIT8sDhgjNw0jSCTN3IG6Yi1v0=;
        b=2eTgWFlho6jQT5PZ4YRONT+44UGIEUJlI7SPdkQriAceDSbfitOsQWQgLTIF2/L5/X
         sQsNpYRgCuKztlp77tlO5XzTqp+eTYjXnMilFuX3e0Bgf5XJ1kk29AEddKZnjoS+zHZ7
         MVb5dEcJnBysQGLnjkz8tD8sWI2JlqMo4TfTAP0+8yu3FzFBajtZ7yJ16PgTCxetim0E
         6BFAWJ/9zxXa7d7jTPc3p+EjpboufrDkuZr9X7I0GL8NJhnCeVGJW20mWRpbb2e2Vmaf
         Av2smpTBr0x+HZIKwcP9M6ylK70PKdCdlUaALT5DMINpQ/GJlwsHRSPkk1V9kvt7prGR
         dC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713890955; x=1714495755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27zQqgEtMMu+Y/tN4IIT8sDhgjNw0jSCTN3IG6Yi1v0=;
        b=nnfQJ39WPSFQAHEq0ovxe5kuTn3W3+RLhNT8RdWwGO28MoMEdd0d9/0BSu19KeuISI
         6sxtP2BPaoF4HHfD23SRAV4ACsORGNF8qflF4iUwJiZFlcBFnapXEeFXjPsPtpz01fF3
         +mgI3CAPlGobyi+r3J4blipFX3UozJpNR7QqY7LaJP8Lq5zL27GerEnWvTwA8GBrEWyk
         hV0GJd7r/QtFR1JnlpgnBT0DKMZWb9AaERQhGa6mCp2zslzbAoKMk5/cA97tL2Y5toQu
         qUs20ASwfkoVYlMZfGLpqx7lmCSuHbSSl5riEp5w6UID22kihlX3FBaSlhYT0tEpA7nl
         gQDA==
X-Gm-Message-State: AOJu0YwcqMzGN1PKRS71Am2h3kNtfrXpgmBMiYuNStldsAWVrL+f14Cn
	if9KlW2fMrIfX934IMbmbSPzzqUXGP64diyyhjMZDNgJmG3LcMRumcd2y3u9FYc=
X-Google-Smtp-Source: AGHT+IHhQV62lYD+ubDAKYJH2PoHfOU60KaFE0rflb7uhuHS+k+57H8clicjJfa+6mwYLXesC1F95w==
X-Received: by 2002:a5b:9d0:0:b0:de5:5825:5133 with SMTP id y16-20020a5b09d0000000b00de558255133mr130512ybq.22.1713890955499;
        Tue, 23 Apr 2024 09:49:15 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w15-20020a25ac0f000000b00de5503cc6a8sm472673ybi.15.2024.04.23.09.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 09:49:14 -0700 (PDT)
Date: Tue, 23 Apr 2024 12:49:14 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 07/17] btrfs: push extent lock into run_delalloc_nocow
Message-ID: <20240423164914.GA3019378@perftesting>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <60f8e6362e50086d796d8cdd44031d9496398b08.1713363472.git.josef@toxicpanda.com>
 <2dqiyvawsd6g3zxtfhgcmyv7i257l2hhgrd2zcpl3yumugbcnz@twvnaux5ahe6>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dqiyvawsd6g3zxtfhgcmyv7i257l2hhgrd2zcpl3yumugbcnz@twvnaux5ahe6>

On Tue, Apr 23, 2024 at 06:33:25AM -0500, Goldwyn Rodrigues wrote:
> On 10:35 17/04, Josef Bacik wrote:
> > run_delalloc_nocow is a bit special as it walks through the file extents
> > for the inode and determines what it can nocow and what it can't.  This
> > is the more complicated area for extent locking, so start with this
> > function.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> 
> > ---
> >  fs/btrfs/inode.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 2083005f2828..f14b3cecce47 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -1977,6 +1977,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
> >  	 */
> >  	ASSERT(!btrfs_is_zoned(fs_info) || btrfs_is_data_reloc_root(root));
> >  
> > +	lock_extent(&inode->io_tree, start, end, NULL);
> > +
> >  	path = btrfs_alloc_path();
> >  	if (!path) {
> >  		ret = -ENOMEM;
> > @@ -2249,11 +2251,6 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
> >  	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
> >  	int ret;
> >  
> > -	/*
> > -	 * We're unlocked by the different fill functions below.
> > -	 */
> > -	lock_extent(&inode->io_tree, start, end, NULL);
> > -
> 
> So, you are adding this hunk in the previous patch and (re)moving it here.
> Do you think it would be better to merge this with the previous patch?

It depends?  I did it like this so people could follow closely as I pushed the
locking down.  Most of these "push extent lock into.." patches do a variation of
this, where I push it down into a function and move the lock down in the set of
things.  I'm happy to merge them together, but I split it this way so my logic
could be followed.  Thanks,

Josef

