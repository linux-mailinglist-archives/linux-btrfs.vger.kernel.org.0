Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13238BF0D2
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 13:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfIZLHK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 07:07:10 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35835 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfIZLHK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 07:07:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id w2so1389874qkf.2
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2019 04:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lL+vwsDLOtnxVPit6G+a8XbG20+AO9Q0pA7Bn9KvSZA=;
        b=g1Hwnk/aIwNiRpwUw2boWKF7ZJ2BdA1NIlRfFiSf5fxlMLu097ap9L7ld+HxWUYgbb
         qN3I5YMmkq4NvLgBLR7ExeYNSXYP79PKNhxjjHZfBIJ64CLgznd/pugG3mCKzTXeZ6UU
         dKDA5F6LsVC1ZvpVfdCTXsWIv6lGDpn/74dMXNq74hXK0rlbR24ztg3wpwjqZVm9HaE9
         iNR5JNKAStVbvdOPRhzaPCq61fJd3+I7E7J0L/ClhvRKBb9bsZzhfpKBe7/ehMQhGseS
         l1t1lfQZ7bKLeVVk+VQ7n/ViDvDWd+j6mhKm+XmGSqnaY6Idr7glgwccjoP30f/DZEbz
         OwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lL+vwsDLOtnxVPit6G+a8XbG20+AO9Q0pA7Bn9KvSZA=;
        b=kmM+i1aB3vJpjjh44UfA9zBndtUGSps+YNxVrz8DjdXMZV1HB7A595MgtoYWxYPKsf
         SFufxs4uAfSdAXKr5EuBfHsAVaVWck6GCtOgA1HWPMKcZSQqFv/t/yZnBrsMyYxTWO+p
         V1BYUGco/dajZlG4XqxH1Qer7Xql+4tf0GQqBWbu9QdSof8TWrzi2Ak+gDFr7WT8B1rZ
         TPgazJYPb41Mf80NiYU/vK+vKD3hQh+J4ckp7ZGgidKigGXILHSJo+Wug2JwwdstIxVc
         zOQxWfWdifbvGjEhjjbPHUErCP0onw95FaYWMp5QtSnlIrLTaid8LMdROp4oO0+a12Or
         7YiQ==
X-Gm-Message-State: APjAAAVgJqjPnk4YFsBlOVOVa+7+XWp4KONpr+dsAEu/z3ePaiUabupc
        V/p7WJbZjXF2vHX+iKhY1f03OWkENjRuXA==
X-Google-Smtp-Source: APXvYqzD8DWLaw+0TuGiGJ1ut5s7lviHY491i+f6NBaoO2Tuq6AXvhptnT8yyI7Q6E7P3m5pvyC5bA==
X-Received: by 2002:a37:a503:: with SMTP id o3mr2553739qke.115.1569496027984;
        Thu, 26 Sep 2019 04:07:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::cafc])
        by smtp.gmail.com with ESMTPSA id b4sm846108qkd.121.2019.09.26.04.07.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 04:07:07 -0700 (PDT)
Date:   Thu, 26 Sep 2019 07:07:05 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, Mark Fasheh <mfasheh@suse.com>,
        linux-btrfs@vger.kernel.org, Mark Fasheh <mfasheh@suse.de>
Subject: Re: [PATCH 2/3] btrfs: move ref finding machinery out of
 build_backref_tree()
Message-ID: <20190926110703.ixjtybnmetuz4atu@macbook-pro-91.dhcp.thefacebook.com>
References: <20190906171533.618-1-mfasheh@suse.com>
 <20190906171533.618-3-mfasheh@suse.com>
 <20190911160928.47qzqcj332k7bgw2@MacBook-Pro-91.local>
 <20190924144920.GX2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924144920.GX2751@twin.jikos.cz>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 04:49:20PM +0200, David Sterba wrote:
> On Wed, Sep 11, 2019 at 12:09:29PM -0400, Josef Bacik wrote:
> > On Fri, Sep 06, 2019 at 10:15:32AM -0700, Mark Fasheh wrote:
> > > From: Mark Fasheh <mfasheh@suse.de>
> > > 
> > > build_backref_tree() is walking extent refs in what is an otherwise self
> > > contained chunk of code.  We can shrink the total number of lines in
> > > build_backref_tree() *and* make it more readable by moving that walk into
> > > its own subroutine.
> > > 
> > > Signed-off-by: Mark Fasheh <mfasheh@suse.de>
> > > ---
> > >  fs/btrfs/backref-cache.c | 110 +++++++++++++++++++++++----------------
> > >  1 file changed, 65 insertions(+), 45 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/backref-cache.c b/fs/btrfs/backref-cache.c
> > > index d0f6530f23b8..ff0d49ca6e26 100644
> > > --- a/fs/btrfs/backref-cache.c
> > > +++ b/fs/btrfs/backref-cache.c
> > > @@ -336,6 +336,61 @@ int find_inline_backref(struct extent_buffer *leaf, int slot,
> > >  	return 0;
> > >  }
> > >  
> > > +#define SEARCH_COMPLETE	1
> > > +#define SEARCH_NEXT	2
> > > +static int find_next_ref(struct btrfs_root *extent_root, u64 cur_bytenr,
> > > +			 struct btrfs_path *path, unsigned long *ptr,
> > > +			 unsigned long *end, struct btrfs_key *key, bool exist)
> > 
> > I'd rather we do an enum here, so it's clear what we're expecting in the code
> > context.  Thanks,
> 
> The function also returns errors (< 0), so do you mean enum for the
> SEARCH_* values only for for the function as well?

Blah I didn't notice that, in that case you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
