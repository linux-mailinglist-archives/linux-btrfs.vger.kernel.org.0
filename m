Return-Path: <linux-btrfs+bounces-4241-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FBF8A4256
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 14:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11B01C20AF0
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 12:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A4B2D61B;
	Sun, 14 Apr 2024 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="gCT4r0oV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED75514292
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Apr 2024 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713099293; cv=none; b=ZhVeYjvn7+FooU1hNPF/nu4DanR8G+tGfDTF/n+TO+hwPwiEjioY0y/QualXQ3zOf5zqVPjHCWj2kvnMt3AVJ8LK6O5AjXNAnLyYbDCBlgZg3j8PQySS9NzwGqjnE/GyzVjjCpcpubcsVVDvFPWgmhwdUw4b+L/fQxl889u7oKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713099293; c=relaxed/simple;
	bh=4SV6dP+RfU7JZans1NwqqxlwvgbgqpAIzfyeIFYgZHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rI3FjVJI9rORxb1iRKose8VJVpwDoqOq8AEodAuvrX3TF1Zi5dxqLt7QZCp7b0cCA+Qth5oWFiEUKuRxZUK8xFNMnse0d9/aqi3/fCqkA20DRTNXWCSm6QWgn5m7Fzlpamjj++RkfJnQo9hxan/7y/HE1sSfAVZf5+HlFk7aI/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=gCT4r0oV; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78d68c08df7so182135685a.2
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Apr 2024 05:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713099290; x=1713704090; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pk1vQI/RCPRq31JoBmlnJubUv+QJ3JwqzEPgEtxKVkg=;
        b=gCT4r0oVFyFrUTNAPd1NOwbsh71wwlPyPSl3fZVo/wQRrvDzROcTlmPD5ABD4R0gDW
         Iikr+8NDx7huyHLIZNojTGuepfOwHZ5WHxFdCYm6N0tSy9THxCF0zbzGX5t1ReidU5fk
         UFftUOrvEY0PZVeTZ+aNWqxpAIAfDnO91VUMzIn15OOo4o3s24JmFDNxVwgHbgrovA9L
         EHgbaoTjU8Hd/mk0MW6aY0nw8G92Swk9XCVXMj07YzKNsLjIfsiyrTeLUSJuMKLT9BPn
         6Rtz0K/JSOsrl8CgbeBBBpkaN7BQ3jS8ujFCg9W26TVy4q8r353exXXDFym6N/4xcckn
         4tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713099290; x=1713704090;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pk1vQI/RCPRq31JoBmlnJubUv+QJ3JwqzEPgEtxKVkg=;
        b=cWoHjM5WxvPB/qSMyMiPbg+FZMsxmhm6XEMIJalbpOoj7iR2PZJtJjKZvaP8OHxtVs
         6kBUzlZfkbAdCwwFYiCDPjaeroThdQLypBCW6gbFEM+VwoDYn8FRzv3+quBtBB+QqObR
         iLdVm1TVHejv6jK49+qnobI0kch9OI9RJLAkp/fpdaz5j/xhJam8lm9nNd3ReFe+ObaT
         sLuHxq0BijMFRVB21kp4j1+2nfm9pue04La099lqslZ6na1Q9G+J1NtRKIRLj6byk+oJ
         bHVKZBQ2daxGZMtr7BHFtiaaJwORfMN1aodS1TQsDB7jmk5LsYUuniTAvt4W6mOFveZY
         oCFA==
X-Gm-Message-State: AOJu0YysWvC95s/W7xxVjVyOt97QGNY4k2UZUTZznxqfZxfkBlZc9q2y
	y24x9EALUFwCnXrKCawRMPyixznG1G7pJ3JRHWH/H1ZLK+ax8cSjePwdhMkOVZIEB84rWLV4fb8
	2
X-Google-Smtp-Source: AGHT+IFEqqecCIkliQensDCQQAKb5cHEm9H+jobIQ0p5oqs/Nhn9CwLinFhNvz1cjaDd1pZNAu5Ytw==
X-Received: by 2002:a05:620a:136c:b0:78e:a0f0:a372 with SMTP id d12-20020a05620a136c00b0078ea0f0a372mr8096754qkl.35.1713099289704;
        Sun, 14 Apr 2024 05:54:49 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id b23-20020a05620a04f700b0078e9717109asm4975202qkh.105.2024.04.14.05.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 05:54:49 -0700 (PDT)
Date: Sun, 14 Apr 2024 08:54:48 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: set start on clone before calling
 copy_extent_buffer_full
Message-ID: <20240414125448.GA1930433@perftesting>
References: <5062a746cf151bfbc217c00e149740956e748abb.1713073723.git.josef@toxicpanda.com>
 <CAL3q7H4si0_KhB+iXMJr-CvH6etyKmxG3LBAHpoaHQdMM62PTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4si0_KhB+iXMJr-CvH6etyKmxG3LBAHpoaHQdMM62PTA@mail.gmail.com>

On Sun, Apr 14, 2024 at 11:22:17AM +0100, Filipe Manana wrote:
> On Sun, Apr 14, 2024 at 6:50 AM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > Our subpage testing started hanging on generic/560 and I bisected it
> > down to Fixes: 1cab1375ba6d ("btrfs: reuse cloned extent buffer during
> 
> The "Fixes:" should be here, seems like a copy paste mistake from the
> bottom of the change log.
> 
> > fiemap to avoid re-allocations").  This is subtle because we use
> > eb->start to figure out where in the folio we're copying to when we're
> > subpage, as our ->start may refer to an area inside of the folio.
> 
> Where is that exactly? Is it at get_eb_offset_in_folio()? If it's that
> I don't see why it's subpage specific.
> Can you mention where exactly in the change log?
> 
> >
> > We were copying with ->start set to the previous value, and then
> > re-setting ->start in order to be used later on by fiemap.  However this
> > changed the offset into the eb that we would read from, which would
> 
> I don't understand this part that says: "we would read from".
> We would read what and where? Are you saying we need to read from the
> destination eb during copy_full_extent_buffer()?
> Where is that?
> 
> Does this only affect copy_extent_buffer_full()? Doesn't it affect
> copy_extent_buffer() too? If not, why?
> Can you please give all these details in the changelog?
> 
> > cause us to not emit EOF sometimes for fiemap.  Thanks to a bug in the
> > duperemove that the CI vms are using this manifested as a hung test.
> >
> > Fix this by setting start before we co copy_extent_buffer_full to make
> > sure that we're copying into the same offset inside of the folio that we
> > will read from later.
> >
> > With this fix we now pass generic/560 on our subpage tests.
> >
> > Fixes: 1cab1375ba6d ("btrfs: reuse cloned extent buffer during fiemap toavoid re-allocations")
> 
> Missing a space at "toavoid", in the commit's subject there's actually a space.
> 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/extent_io.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 49f7161a6578..a3d0befaa461 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -2809,13 +2809,17 @@ static int fiemap_next_leaf_item(struct btrfs_inode *inode, struct btrfs_path *p
> >                 goto out;
> >         }
> >
> > -       /* See the comment at fiemap_search_slot() about why we clone. */
> > -       copy_extent_buffer_full(clone, path->nodes[0]);
> >         /*
> >          * Important to preserve the start field, for the optimizations when
> >          * checking if extents are shared (see extent_fiemap()).
> > +        *
> > +        * Additionally it needs to be set before we call
> > +        * copy_extent_buffer_full because for subpagesize we need to make sure
> 
> Can we get the () in front of the function name, so that it's
> consistent with the rest of the comment (paragraph above)?
> 
> > +        * we have the correctly calculated offset.
> >          */
> >         clone->start = path->nodes[0]->start;
> > +       /* See the comment at fiemap_search_slot() about why we clone. */
> > +       copy_extent_buffer_full(clone, path->nodes[0]);
> 
> Ok so this is a landmine and I doubt people will remember to do this
> when using copy_extent_buffer_full() in the future.
> If this is really needed, why not do that at copy_extent_buffer_full()
> itself? This would be more future proof.
> 
> Why wouldn't we need this in other places that use
> copy_extent_buffer_full() too?
> 
> For example in the tree log code where we use a dummy eb and we don't
> update the eb's ->start because we don't care about it. Why is it not
> a problem there? Or you missed it?
> 
> Or another example at btrfs_copy_root(). where we can't obviously set
> the destination eb's ->start to that of the source eb. Why don't we
> run into any problem there?
> 
> I'm puzzled at why we need to this ->start update only in this place,
> why the ->start of the destination eb of copy_extent_buffer_full() is
> used or why it causes a problem, why is it subpage specific

Sorry, 2am changelogs aren't great.

In __write_extent_buffer() we do

offset = get_eb_offset_in_folio(eb, start);

start is the logical offset into the eb we're copying to, in this case it's 0
because we're doing copy_extent_buffer_full().  get_eb_offset_in_folio() does
this

        return offset_in_folio(eb->folios[0], offset + eb->start);

and offset_in_folio() does this

        return start & (eb->folio_size - 1);

so in this case offset is 0, so we're just passing in eb->start.

With subpage ->start can be not folio_size aligned, so this would be some
arbitrary offset into the folio.

The other places aren't a problem because we don't change eb->start after we
do the copy.  This is a problem because we're re-using a cloned eb, so we do
this

// start is 4k on a 16k pagesize fs, so we're at the 4k offset into the folio
copy_extent_buffer_full();

// now start is at 8k offset into the folio
cloned->start = 8k;

Any subsequent reads from the eb, by which I mean things like
btrfs_item_key_to_cpu(), anything we read the members out of the leaf are going
to use the same get_eb_offset_in_folio() helper and now come up with a different
answer than where we copied into.

All other places are fine, because we don't change ->start after we've copied
data into it.  I'll update the changelog to include this information, thanks,

Josef

