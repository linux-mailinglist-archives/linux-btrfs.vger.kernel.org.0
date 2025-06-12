Return-Path: <linux-btrfs+bounces-14622-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FD3AD6AE5
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 10:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C24B3A8EC7
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 08:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D1E22126E;
	Thu, 12 Jun 2025 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YmThgej+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B773020C031
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717274; cv=none; b=TfC0paREk57EpazKE/13bmfT4wS8gwSxaitadbw/SZNSilWM3t9C5D8wfMM6KE5vwQE8hDJrz5IXhXRfOCE55Kj9hg0DKKTbwzmdrQm8jEHzxTznuThhAuT64RJrteBNSwbfEdkrHs2pgdXuizYynugxRF3PjikYvH7g6JOtXiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717274; c=relaxed/simple;
	bh=KmseBCGkBltkQJB+bXiWrUlTYOiIhBbRpBapI2IUh0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igqWKDSq2TXfBSMukuiuNZQ3UZKFEUQJgdFS31b+zQ8wPAapqBrPoyCeWqx1///FoIVJsB99e/VzoDZ0NBRElQF1bI2Nx9JV/sf3Na0axdM64aSxbrVdYvl/KEwNcJxOUa9JWxReE7NjM9EFyQjtIIS8nl5tCH8Fr26YEuUC0Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YmThgej+; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad572ba1347so105662366b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 01:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749717271; x=1750322071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R7g8CYkJXGi+LouyxL2Tn5ZZ861hnviLISrxqX1kUus=;
        b=YmThgej+evWuaKj9jRAJaB/6T/nZicY1AvMwtE03QVTf+d05a4KlKLbepIyZlmcHyu
         pRBYbHfQY+jPxJMoznnfBG+0Ad1BuuNWAGJAgQLjf7ua8Poiw18HojHKtjBDcOKkhCk2
         3yY26Ourd6RZnnWJrC8lmSC8y99LKQdur8sj9ofx6YX+ioGmfjw7DB5rjW3fnPNiCeOt
         eDPrCtwTKkHx26omZwe2hirdMENj1uuetR1V90tcid1F8dotqOiKuiiobB+q3BO/wmZ4
         RCjXlGPSFTlntvlH9nXuZ6aRwpgA11z5wbdKDGwGi/jxPDtpHd2ZNAIuXukKml6R3qg8
         n1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717271; x=1750322071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7g8CYkJXGi+LouyxL2Tn5ZZ861hnviLISrxqX1kUus=;
        b=b1GWCoVyAF8vnP6rNtAEZyDsnL/00XUoKNYiwv0aIXubEbiHC5UoRWzkS28/Jd3zLM
         71SJoUeunR7YV71lpckgWtmwrJEogZNZzD5ymb32/TH+P3Br+u43zQHTV27LnCjxLqJW
         GdIa53WdgV2AQ+JypI9dC4qzt4AOKAOhvLuUIufe3kuCoiFLjK1tJGvOM78xkYLjrhgv
         iJydWVBnmyhgmo0HUcvtsrtBdnP4p0ZG644gQoFI3viT3VDsor4O4K0fCUr4L3ne5O7r
         bsKGaO1Ojk09LTZc0huR4Y9G1AbS0bjqOXDzSVFsadBS1i2fcHDW/Yy1sJJ5I/y3SitX
         yA/w==
X-Forwarded-Encrypted: i=1; AJvYcCXWYD0rduQbeouTqq4XuUIrlchrRYMCtvsXrp046sGOt8t9JjFetRq45k9xssU4sTXwsK/NDyzOxeJmnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YygL+TBC3cq8E3krCpJRHsu8ashwyiLZUsuY/8J7pWEl28ns2D1
	aUMKDMRj2UoxFCun1OmmfTbY6Tkbdcueoaqt1kRwAKzWPusT6NC6VVh1zt7Lo2YPfS1WTXlICYT
	ekwADbAFc/EkWGpJaTg07vAZ2DSRWYaLrKTyLvDojGw==
X-Gm-Gg: ASbGnctPA0Yg0Hw+ZXjXiGwx5zsPb9JLlJQmS3qOc3DFN1Ra9lXHxaNWYLuSv3iPHGI
	SjPUDotQQP4yioq0DVCemsaqpLbQOV8Fk+iqB2yqwST4llVZXYywowdvEjukONotQtvoFpFBy7F
	P4NUeJkAHY4nZIug2wjN9LoMAFNeTjeBaU47nVwMd5lA==
X-Google-Smtp-Source: AGHT+IFVugGpngvrzd5noKecu2O4BZGb+svn8vwAenX7BptOiMp6XK92yeX+JaMUqYjvqa9ZA798w5EpZZYsteYSr4c=
X-Received: by 2002:a17:907:25cb:b0:ade:3b84:8ef6 with SMTP id
 a640c23a62f3a-adea92898f9mr197761666b.23.1749717271081; Thu, 12 Jun 2025
 01:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512172321.3004779-1-neelx@suse.com> <20250606172811.GY4037@twin.jikos.cz>
In-Reply-To: <20250606172811.GY4037@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 12 Jun 2025 10:34:20 +0200
X-Gm-Features: AX0GCFs0W2NEeBrD98LqU3d1NgoxS3gwTh7DNtFowD5ncNr0sDzIgrfzpQTGXbc
Message-ID: <CAPjX3FdP0k8YRR7vA+g_deUqEt=1wnRZXV-9gaTHwur43HVJ6w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: index buffer_tree using node size
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Jun 2025 at 19:28, David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, May 12, 2025 at 07:23:20PM +0200, Daniel Vacek wrote:
> > So far we are deriving the buffer tree index using the sector size. But each
> > extent buffer covers multiple sectors. This makes the buffer tree rather sparse.
> >
> > For example the typical and quite common configuration uses sector size of 4KiB
> > and node size of 16KiB. In this case it means the buffer tree is using up to
> > the maximum of 25% of it's slots. Or in other words at least 75% of the tree
> > slots are wasted as never used.
> >
> > We can score significant memory savings on the required tree nodes by indexing
> > the tree using the node size instead. As a result far less slots are wasted
> > and the tree can now use up to all 100% of it's slots this way.
> >
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
>
> This is a useful improvement, so we should continue and merge it. The
> performance improvements should be done so we get some idea. Runtime and
> slab savings.

Performance-wise this fix is not that significant. With my testing I
did not notice any changes in runtime performance.
Slab usage is _relatively_ significant though - about 2/3 of the btrfs
radix_tree_node objects are saved. Though in _absolute_ numbers
system-wide it's still within the level of noise. Without this fix
btrfs uses a bit over 1% of the radix_tree_node slab cache while with
the fix it falls below half a percent from what I was able to pull
from the memory.

> One coding comment, please rename node_bits to nodesize_bits so it's
> consistent with sectorsize and sectorsize_bits.

Right.

> >  fs/btrfs/disk-io.c   |  1 +
> >  fs/btrfs/extent_io.c | 30 +++++++++++++++---------------
> >  fs/btrfs/fs.h        |  3 ++-
> >  3 files changed, 18 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 5bcf11246ba66..dcea5b0a2db50 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -4294,9 +4294,9 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
> >  {
> >       struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
> >       struct extent_buffer *eb;
> > -     unsigned long start = folio_pos(folio) >> fs_info->sectorsize_bits;
> > +     unsigned long start = folio_pos(folio) >> fs_info->node_bits;
> >       unsigned long index = start;
> > -     unsigned long end = index + (PAGE_SIZE >> fs_info->sectorsize_bits) - 1;
> > +     unsigned long end = index + (PAGE_SIZE >> fs_info->node_bits) - 1;
>
> This looks a bit suspicious, page size is 4k node size can be 4k .. 64k.
> It's in subpage code so sector < page, the shift it's always >= 0. Node
> can be larger so the shift result would be 0 but as a result of 4k
> shifted by "16k".

This comes from commit 19d7f65f032f ("btrfs: convert the buffer_radix
to an xarray").
You can still have 64 KiB page with 16 KiB node size. So this still
looks sound to me.

> >       int ret;
> >
> >       xa_lock_irq(&fs_info->buffer_tree);
> > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > index cf805b4032af3..8c9113304fabe 100644
> > --- a/fs/btrfs/fs.h
> > +++ b/fs/btrfs/fs.h
> > @@ -778,8 +778,9 @@ struct btrfs_fs_info {
> >
> >       struct btrfs_delayed_root *delayed_root;
> >
> > -     /* Entries are eb->start / sectorsize */
> > +     /* Entries are eb->start >> node_bits */
> >       struct xarray buffer_tree;
> > +     int node_bits;
>
> u32 and pleas move it to nodesize.

Sure.

