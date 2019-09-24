Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC9ABCA96
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 16:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbfIXOtB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 10:49:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:54542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbfIXOtA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 10:49:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 783F8AC84;
        Tue, 24 Sep 2019 14:48:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 48C0ADA835; Tue, 24 Sep 2019 16:49:20 +0200 (CEST)
Date:   Tue, 24 Sep 2019 16:49:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Mark Fasheh <mfasheh@suse.com>, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: Re: [PATCH 2/3] btrfs: move ref finding machinery out of
 build_backref_tree()
Message-ID: <20190924144920.GX2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Mark Fasheh <mfasheh@suse.com>, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
References: <20190906171533.618-1-mfasheh@suse.com>
 <20190906171533.618-3-mfasheh@suse.com>
 <20190911160928.47qzqcj332k7bgw2@MacBook-Pro-91.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911160928.47qzqcj332k7bgw2@MacBook-Pro-91.local>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 11, 2019 at 12:09:29PM -0400, Josef Bacik wrote:
> On Fri, Sep 06, 2019 at 10:15:32AM -0700, Mark Fasheh wrote:
> > From: Mark Fasheh <mfasheh@suse.de>
> > 
> > build_backref_tree() is walking extent refs in what is an otherwise self
> > contained chunk of code.  We can shrink the total number of lines in
> > build_backref_tree() *and* make it more readable by moving that walk into
> > its own subroutine.
> > 
> > Signed-off-by: Mark Fasheh <mfasheh@suse.de>
> > ---
> >  fs/btrfs/backref-cache.c | 110 +++++++++++++++++++++++----------------
> >  1 file changed, 65 insertions(+), 45 deletions(-)
> > 
> > diff --git a/fs/btrfs/backref-cache.c b/fs/btrfs/backref-cache.c
> > index d0f6530f23b8..ff0d49ca6e26 100644
> > --- a/fs/btrfs/backref-cache.c
> > +++ b/fs/btrfs/backref-cache.c
> > @@ -336,6 +336,61 @@ int find_inline_backref(struct extent_buffer *leaf, int slot,
> >  	return 0;
> >  }
> >  
> > +#define SEARCH_COMPLETE	1
> > +#define SEARCH_NEXT	2
> > +static int find_next_ref(struct btrfs_root *extent_root, u64 cur_bytenr,
> > +			 struct btrfs_path *path, unsigned long *ptr,
> > +			 unsigned long *end, struct btrfs_key *key, bool exist)
> 
> I'd rather we do an enum here, so it's clear what we're expecting in the code
> context.  Thanks,

The function also returns errors (< 0), so do you mean enum for the
SEARCH_* values only for for the function as well?
