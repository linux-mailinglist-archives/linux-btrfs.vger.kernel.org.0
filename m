Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E232A9BA6
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 19:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbgKFSNN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 13:13:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:38476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgKFSNN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 13:13:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F0A7AABA2;
        Fri,  6 Nov 2020 18:13:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 83983DA6E3; Fri,  6 Nov 2020 19:11:32 +0100 (CET)
Date:   Fri, 6 Nov 2020 19:11:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 04/32] btrfs: extent_io: extract the btree page
 submission code into its own helper function
Message-ID: <20201106181132.GR6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-5-wqu@suse.com>
 <ebd6ebca-f050-8cd2-baaf-303858b59d03@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebd6ebca-f050-8cd2-baaf-303858b59d03@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 05, 2020 at 12:47:32PM +0200, Nikolay Borisov wrote:
> 
> 
> On 3.11.20 г. 15:30 ч., Qu Wenruo wrote:
> > In btree_write_cache_pages() we have a btree page submission routine
> > buried deeply into a nested loop.
> > 
> > This patch will extract that part of code into a helper function,
> > submit_btree_page(), to do the same work.
> > 
> > Also, since submit_btree_page() now can return >0 for successfull extent
> > buffer submission, remove the "ASSERT(ret <= 0);" line.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  fs/btrfs/extent_io.c | 116 +++++++++++++++++++++++++------------------
> >  1 file changed, 69 insertions(+), 47 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 9cbce0b74db7..ac396d8937b9 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -3935,10 +3935,75 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
> >  	return ret;
> >  }
> >  
> > +/*
> > + * A helper to submit a btree page.
> > + *
> > + * This function is not always submitting the page, as we only submit the full
> > + * extent buffer in a batch.

This is confusing, it's submitting conditionally eb pages, so the main
object is eb not the pages, so it should be probably submit_eb_page.
