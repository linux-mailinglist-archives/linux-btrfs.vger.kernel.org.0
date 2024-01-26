Return-Path: <linux-btrfs+bounces-1822-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39FD83DB9B
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 15:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3183E1F2327E
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 14:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AF51C29B;
	Fri, 26 Jan 2024 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Fw+KGywE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135118626
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706278774; cv=none; b=dEwlg3pwgB0cuPMTw6vsO2UvDg419z/luHXM/RssCZ0tn1gscWfAb7AlR5EUyGMbzh0KIcBaUnD/do2/OOEp8SE0WI1egdV49u5ZjTtpK2gYx2pG3LiKW3uZRI0tXztl9pZJtW/sIUjIM1cx7QzbORVXrNd+NOtykrnYVfCU3NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706278774; c=relaxed/simple;
	bh=RKg8vJIu1oucfoD6T9YKzAJ6CL9K/kglXITcNmSFLMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYcZ+onKvWO0pFwKxveYILuh0qF35a/V+RyY49QaDk5qXVpvtk3qxp8/x50vtPjDpov1jWPqEvPp09ZXp6aoILyqPESoCiAc+9gmD+sTIEkn7ji+j0QdQf/yFY+YWLDQlmtQdNK+x1LYhKuqzT3jtyWSdcELsSKwGcUZb5+/fDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Fw+KGywE; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-602c91a76b1so4769257b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 06:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706278770; x=1706883570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jCugPRwUBbIgv1vX8cqIfvnliAd6dacQpZ9HDdx5qMs=;
        b=Fw+KGywEcpvZQAdGdSmbDsXVy7MHxxOwZjCWkfeIMLmRKKKQbfbwda1XqkkGEtsM6E
         qRZUxbGVShuVzUP35Y8vA8OKHPUFI3fCYgdtHQpWCdrmsClyyvc10hwd62xVukVBH/qg
         94IIODRRUq95vXrLLv6TUEI/lGx3w8iC52FGJ/eLckB4n4Tcltv8VD3VbqL5jt7s4+h1
         1QWfsKKKvOJ2axas5FfqiYpEHzgnjNh1W0wQb4kg5AkdYZUq/6CIYVaD1gAubKKI/ifp
         jGnooa+Fk+imOP0f4GV4QtC8MyM1O5eFN3oaPhHL+Z62RntdhrUL277I3Cf7iGSFNZEi
         yujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706278770; x=1706883570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCugPRwUBbIgv1vX8cqIfvnliAd6dacQpZ9HDdx5qMs=;
        b=K4EueqxNp07BSvDIIyFpKsN8mCwMwHGH13Y11m1lmwiNp0woxyfQulzT1xv+pP526R
         fNxXrgPFScy0GWnM8gIsi8tZyq/8uFjMtDsT3S3hNDUGqRCkJX/3zkdbVG4GbfnxRJuT
         5+hX5DzduqR4fhn2NhkEdc9SYcIeRkq4DXsOyPLn7T3pu0hyEyZNS5/5w6sHqd9UUH/w
         GR54rM6CAHtfcX5Y3Z0hinoYzgZKTG2netYQ5+zI7tc2oYZgcJlNv1andlSMXe4BL0Gv
         E+5xwDdV4QLQ99x8bt86J9q5DZnkTiAr/gZXylWlMYMxb5eU4B8XQ4jD9CPV+H6OcAbN
         Bzdg==
X-Gm-Message-State: AOJu0YzDEZCcbXWolZrid6fuJG243mYB76KtCBxW/mP4QN0VutsMRIkZ
	b7CvKf35tdS/AHUFNKZBhEpqzK2yT1qGQ+C/DDgGR5fJ95ClfyrN4uKZ12uK/As=
X-Google-Smtp-Source: AGHT+IE50Ttn2hHl3NO6w6RnkngaJbiGQ5gxk9JjMCOBtxhie5BxKq9WKTLYlY0MthKbyWmCI5Mvmg==
X-Received: by 2002:a81:a50f:0:b0:602:aaf7:aafe with SMTP id u15-20020a81a50f000000b00602aaf7aafemr1537757ywg.24.1706278770222;
        Fri, 26 Jan 2024 06:19:30 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ez9-20020a05690c308900b005ff9154001fsm394472ywb.140.2024.01.26.06.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 06:19:27 -0800 (PST)
Date: Fri, 26 Jan 2024 09:19:27 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/20] btrfs: handle invalid root reference found in
 btrfs_find_root()
Message-ID: <20240126141927.GA1612357@perftesting>
References: <cover.1706130791.git.dsterba@suse.com>
 <0011782bc0af988fc393ae8cee8b2d761def05d4.1706130791.git.dsterba@suse.com>
 <73f3c94a-7661-411a-8c86-f309d3acd329@gmx.com>
 <20240125162818.GP31555@twin.jikos.cz>
 <94ce38d7-9a02-4d7a-a5d3-2e703eef121e@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94ce38d7-9a02-4d7a-a5d3-2e703eef121e@gmx.com>

On Fri, Jan 26, 2024 at 09:44:52AM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/1/26 02:58, David Sterba wrote:
> > On Thu, Jan 25, 2024 at 02:33:53PM +1030, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2024/1/25 07:48, David Sterba wrote:
> > > > The btrfs_find_root() looks up a root by a key, allowing to do an
> > > > inexact search when key->offset is -1.  It's never expected to find such
> > > > item, as it would break allowed the range of a root id.
> > > > 
> > > > Signed-off-by: David Sterba <dsterba@suse.com>
> > > > ---
> > > >    fs/btrfs/root-tree.c | 9 ++++++++-
> > > >    1 file changed, 8 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> > > > index ba7e2181ff4e..326cd0d03287 100644
> > > > --- a/fs/btrfs/root-tree.c
> > > > +++ b/fs/btrfs/root-tree.c
> > > > @@ -82,7 +82,14 @@ int btrfs_find_root(struct btrfs_root *root, const struct btrfs_key *search_key,
> > > >    		if (ret > 0)
> > > >    			goto out;
> > > >    	} else {
> > > > -		BUG_ON(ret == 0);		/* Logical error */
> > > > +		/*
> > > > +		 * Key with offset -1 found, there would have to exist a root
> > > > +		 * with such id, but this is out of the valid range.
> > > > +		 */
> > > > +		if (ret == 0) {
> > > > +			ret = -EUCLEAN;
> > > > +			goto out;
> > > > +		}
> > > 
> > > Considering all root items would already be checked by tree-checker,
> > > I'd prefer to add an extra "key.offset == (u64)-1" check, and convert
> > > this to ASSERT(ret == 0), so that we won't need to bother the impossible
> > > case (nor its error messages).
> > 
> > I did not think about tree-checker in this context and it actually does
> > verify offsets of the item keys so it's already prevented, assuming such
> > corrupted issue would come from the outside.
> 
> If the root item is fine, but it's some runtime memory bitflip, then I'd
> say if hitting an ASSERT() is really the last time we need to consider.
> 
> Furthermore, we have further safenet at metadata write time, which would
> definitely lead to a transaction abort.
> 
> > 
> > Assertions are not very popular in release builds and distros turn them
> > off. A real error handling prevents propagating an error further to the
> > code, so this is for catching bugs that could happen after tree-checker
> > lets it pass with valid data but something sets wrong value to offset.
> > 
> > The reasoning I'm using is to have full coverage of the error values as
> > real handling with worst case throwing an EUCLEAN. Assertions are not
> > popular in release builds and distros turn them off so it's effectively
> > removing error handling and allowing silent errors.
> > 
> Yep, I know ASSERT() is not popular in release builds.
> 
> But in this case, if tree-checker didn't catch such corruption, but some
> runtime memory biflip (well, no single bitflip can result to -1) or
> memory corruption created such -1 key offset, and ASSERT() is ignoring it.
> 
> That would still be fine, as our final write time tree-checker would
> catch and abort current transaction.
> 
> So yes, I want to use ASSERT() intentionally here, because we're still
> fine even it's not properly caught.
> 
> And again back to the old discussion on EUCLEAN, I really want it to be
> noisy enough immediately, not waiting for the caller layers up the call
> chain to do their error handling.

We can have both.

This patch series is removing BUG_ON()'s, and this is the correct change for
that.

If we need followups to harden the tree checker that's valuable work too, but
that's a followup and doesn't mean this series needs changing.

With CONFIG_BTRFS_DEBUG on we're going to get a WARN_ON when this thing trips
and we'll see it in fstests.  Thanks,

Josef

