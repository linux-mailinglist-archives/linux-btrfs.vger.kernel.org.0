Return-Path: <linux-btrfs+bounces-9690-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1722E9CE5AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55333B32966
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 14:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170791CF5CE;
	Fri, 15 Nov 2024 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="kS0EVcNh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062E31CEE88
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681762; cv=none; b=KGX4rowa53RfQFFfFwlQCtu79VWZbIQXkqjNSRzr7Am7thImsD1P7Ey94TdqGqkrZ3sPLNgugvDL2cADgdBQBNnlzUQzCvEghUAFReHugk8u9KoJ57dge9KvxEsYrTqad5/9UM7ve84IATFfi5XYptp2+LahzpVli7lzIJKy+c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681762; c=relaxed/simple;
	bh=K0km6bT0wyiLCF5uL/yH6Iu298KIl/jdx+Dvdjii+t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgOIPYZxSgOGn6puBkzAqSU021PdBles2xoPac+JCt+tZa02xHY4zUEsO/TJ25jMln3wEvT3dEp4Q0Fq8Mt3bWS8GJNXWieP3ObtdBnYxDBmgEGdYMMebXruNqUioeRvFcqjFLYVin1v2rrTiZPo+BBj/IGv9RptsTsUssaoLco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=kS0EVcNh; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ee3fc08d3cso14820307b3.0
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 06:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731681759; x=1732286559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1wV5y4Je25e6AbYOlLyXtoPhGB+QN6NloZ1nRQ6siTY=;
        b=kS0EVcNhDosbCiwFYKyQcCqoEAe9amVWn9z2pq69QLUpYax/JniHWWSVpRfp+qmCiP
         5dMvyJUHiKgeMUgnJQvrggv2WPil5b7WPNNKF/VAg0QNfNjrr+kKSHxF0RbX94idCc0R
         XS5q+vqsJkEvS4Qb9UIguzlZ1bNv68BIN51I7NY+hBozEwB+kwjyD5+vqC6d3fqBCIij
         LD2sSFWDFskw1CxWy9OnI4VJcFtqxm+p1YOStS+B1Tp9LuLYC8C8+cIu0EQocxatvmiF
         giY+K1c0onWwvkWZci+dhDAYCIVAfIeBzS9ALEEypPfdfVC9Gc5el9L1u5H3Cvesh9YC
         kLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731681759; x=1732286559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wV5y4Je25e6AbYOlLyXtoPhGB+QN6NloZ1nRQ6siTY=;
        b=rjpxUWJ72WUUKRgR4GBwciSrG8UbUIwZlMamrsWYp8FpJv3Bmvdf38Abxps1pbt49E
         4PwvitgCuEwDf/fonHt57YC91u2TZuY8iMTnD5lFHC1dwBt0ltDYJY+vl5+tWBJteSIO
         d1VuD/VGCDxxdh7HptVijqmjeU8D7KJInf7z3+ij2ZHjAcZhve29MBXRzI3uw4KZCpS+
         K3W8uc/VhHBKNmTyDP8NRvrjXMUqBE0mWmLZqK2EYqgFyn9/fCf7AbCuAe0iyFcOsJ/W
         jtjRxZ1/K7CuhuGRhQ07h1P0PKxWh+6GLrdbketxGdnkKulbEZG40Qe/tj8+XIPGjKNP
         EWkQ==
X-Gm-Message-State: AOJu0YwLIWpZbB6s+c3eOoMPTDIPbNTe8PbkzjbLqbjhmD6floV3+Vi7
	VCR02kw4Y/Odb+6gKlui9bMZBHNlApJF7kCecXI9/TJ8IMtaUOs0QhpmFqXaqNKNMHbtdKqlNUZ
	X
X-Google-Smtp-Source: AGHT+IFRzo+J8Z/olvTvJo4ox52BaUQOqEGLNkbtQzMTC5XrC9ZeaOpU0eGX7iPGF+UNnDn8j/fQDA==
X-Received: by 2002:a05:690c:316:b0:6e3:6a76:ce45 with SMTP id 00721157ae682-6ee3d4ce4ebmr62346877b3.13.1731681758741;
        Fri, 15 Nov 2024 06:42:38 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee4404555dsm7577517b3.35.2024.11.15.06.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 06:42:38 -0800 (PST)
Date: Fri, 15 Nov 2024 09:42:35 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: add delayed ref self tests
Message-ID: <20241115144235.GA1623939@perftesting>
References: <cover.1731614132.git.josef@toxicpanda.com>
 <78564483832375111f2d9541678cffa5d3c0c30a.1731614132.git.josef@toxicpanda.com>
 <20241114222353.GA3037257@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114222353.GA3037257@zen.localdomain>

On Thu, Nov 14, 2024 at 02:23:53PM -0800, Boris Burkov wrote:
> On Thu, Nov 14, 2024 at 02:57:49PM -0500, Josef Bacik wrote:
> > The recent fix for a stupid mistake I made uncovered the fact that we
> > don't have adequate testing in the delayed refs code, as it took a
> > pretty extensive and long running stress test to uncover something that
> > a unit test would have uncovered right away.
> > 
> > Fix this by adding a delayed refs self test suite.  This will validate
> > that the btrfs_ref transformation does the correct thing, that we do the
> > correct thing when merging delayed refs, and that we get the delayed
> > refs in the order that we expect.  These are all crucial to how the
> > delayed refs operate.
> > 
> > I introduced various bugs (including the original bug) into the delayed
> > refs code to validate that these tests caught all of the shenanigans
> > that I could think of.
> 
> These tests look reasonably exhaustive for us handling expected
> situations in the expected way.
> 
> I think it's also a good practice to try to test various error paths
> that are part of the intended behavior of the function.
> 
> Is that something we could feasibly do at this point? (i.e.,
> would it generally BUG_ON and do we have the vocabulary to assert the
> expected failures?)
> 
> OTOH, I don't see any too interesting (not enomem) failures in add/select
> ref anyway, so that might apply more to testing an aspect of delayed
> refs that actually cares about the extent tree, for example.

Funnily enough I did this at first to make sure it caught the wrong ref type,
and forgot we have ASSERT()'s to validate that.  So we could do this, but we'd
have to go through and remove all the ASSERT()'s we put into place to keep us
from doing obviously wrong things.  ENOMEM and other related errors that are
valid is good things to test for, but unfortunately outside our abilities with
the self test.  Maybe kunit test has a way to do this, so perhaps that's
something to put on the list to do in the future instead of doing our own hand
rolled unit testing.

> 
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/Makefile                   |    2 +-
> >  fs/btrfs/delayed-ref.c              |   14 +-
> >  fs/btrfs/tests/btrfs-tests.c        |   18 +
> >  fs/btrfs/tests/btrfs-tests.h        |    6 +
> >  fs/btrfs/tests/delayed-refs-tests.c | 1012 +++++++++++++++++++++++++++
> >  5 files changed, 1048 insertions(+), 4 deletions(-)
> >  create mode 100644 fs/btrfs/tests/delayed-refs-tests.c
> > 
> > diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> > index 3cfc440c636c..2d5f0482678b 100644
> > --- a/fs/btrfs/Makefile
> > +++ b/fs/btrfs/Makefile
> > @@ -44,4 +44,4 @@ btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) += tests/free-space-tests.o \
> >  	tests/extent-buffer-tests.o tests/btrfs-tests.o \
> >  	tests/extent-io-tests.o tests/inode-tests.o tests/qgroup-tests.o \
> >  	tests/free-space-tree-tests.o tests/extent-map-tests.o \
> > -	tests/raid-stripe-tree-tests.o
> > +	tests/raid-stripe-tree-tests.o tests/delayed-refs-tests.o
> > diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> > index 63e0a7f660da..3ec0468d1d94 100644
> > --- a/fs/btrfs/delayed-ref.c
> > +++ b/fs/btrfs/delayed-ref.c
> > @@ -93,6 +93,9 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
> >  	u64 num_bytes;
> >  	u64 reserved_bytes;
> >  
> > +	if (btrfs_is_testing(fs_info))
> > +		return;
> > +
> 
> Not new as of this patch or anything, but this is really gross. Is this
> really better than different modes and blocking off/replacing stuff with
> macros, for example? I guess that doesn't work with running the tests
> while loading the module.
> 
> Optimally, we'd have to refactor stuff to have a unit-testable core, but
> that is a much bigger lift that also leads to a bunch of bugs while we
> do it.

There's two things you'll see here, there's this style of "block this off for
testing", and then there's what I did in btrfs_alloc_dummy_fs_info() where I
stub out the fs_info->csum_size and ->csums_per_leaf.  Those tripped up some of
the random helpers, and I could have easily just slapped a "if
(btrfs_is_testing(fs_info)) return;" in there, but it's way more straightforward
to just stub out what we need for the test.

> 
> >  	num_bytes = btrfs_calc_delayed_ref_bytes(fs_info, trans->delayed_ref_updates);
> >  	num_bytes += btrfs_calc_delayed_ref_csum_bytes(fs_info,
> >  						       trans->delayed_ref_csum_deletions);
> > @@ -1261,6 +1264,7 @@ void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans)
> >  {
> >  	struct btrfs_delayed_ref_root *delayed_refs = &trans->delayed_refs;
> >  	struct btrfs_fs_info *fs_info = trans->fs_info;
> > +	bool testing = btrfs_is_testing(fs_info);
> >  
> >  	spin_lock(&delayed_refs->lock);
> >  	while (true) {
> > @@ -1290,7 +1294,7 @@ void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans)
> >  		spin_unlock(&delayed_refs->lock);
> >  		mutex_unlock(&head->mutex);
> >  
> > -		if (pin_bytes) {
> > +		if (!testing && pin_bytes) {
> >  			struct btrfs_block_group *bg;
> >  
> >  			bg = btrfs_lookup_block_group(fs_info, head->bytenr);
> > @@ -1322,12 +1326,16 @@ void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans)
> >  			btrfs_error_unpin_extent_range(fs_info, head->bytenr,
> >  				head->bytenr + head->num_bytes - 1);
> >  		}
> > -		btrfs_cleanup_ref_head_accounting(fs_info, delayed_refs, head);
> > +		if (!testing)
> > +			btrfs_cleanup_ref_head_accounting(fs_info, delayed_refs,
> > +							  head);
> >  		btrfs_put_delayed_ref_head(head);
> >  		cond_resched();
> >  		spin_lock(&delayed_refs->lock);
> >  	}
> > -	btrfs_qgroup_destroy_extent_records(trans);
> > +
> > +	if (!testing)
> 
> What is the principle that decides whether something is appropriate for
> testing mode?

The principle is "do I care about this right now for the test I'm writing" ;).

The reality is that our codebase isn't well suited for unit testing.  I added
the self tests over a decade ago, we didn't have kunit or any of the
infrastructure/experience to do proper unit testing.  We could prioritize
removing the btrfs_is_testing() stuff, we know where it's all used, and we could
rework the code to be more testable now that we know where the sore spots are.
Unfortunately right now it's more a balance between getting things tested and
making it as painless as possible.  Thanks,

Josef

