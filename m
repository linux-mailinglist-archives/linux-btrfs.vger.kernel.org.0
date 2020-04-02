Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7553219B9B0
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 03:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733181AbgDBBCN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Apr 2020 21:02:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:51154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732667AbgDBBCM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Apr 2020 21:02:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 94B01AF0F;
        Thu,  2 Apr 2020 01:02:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7FEBEDA727; Thu,  2 Apr 2020 03:01:36 +0200 (CEST)
Date:   Thu, 2 Apr 2020 03:01:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 01/39] btrfs: backref: Introduce the skeleton of
 btrfs_backref_iter
Message-ID: <20200402010136.GB5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <20200326083316.48847-1-wqu@suse.com>
 <20200326083316.48847-2-wqu@suse.com>
 <20200401153720.GS5920@twin.jikos.cz>
 <43d55416-0ef7-89ba-109c-72c91a62d40d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43d55416-0ef7-89ba-109c-72c91a62d40d@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 02, 2020 at 07:31:28AM +0800, Qu Wenruo wrote:
> On 2020/4/1 下午11:37, David Sterba wrote:
> > On Thu, Mar 26, 2020 at 04:32:38PM +0800, Qu Wenruo wrote:
> >> --- a/fs/btrfs/backref.h
> >> +++ b/fs/btrfs/backref.h
> >> @@ -78,4 +78,43 @@ struct prelim_ref {
> >>  	u64 wanted_disk_byte;
> >>  };
> >>  
> >> +/*
> >> + * Helper structure to help iterate backrefs of one extent.
> >> + *
> >> + * Now it only supports iteration for tree block in commit root.
> >> + */
> >> +struct btrfs_backref_iter {
> >> +	u64 bytenr;
> >> +	struct btrfs_path *path;
> >> +	struct btrfs_fs_info *fs_info;
> >> +	struct btrfs_key cur_key;
> >> +	u32 item_ptr;
> >> +	u32 cur_ptr;
> >> +	u32 end_ptr;
> >> +};
> >> +
> >> +struct btrfs_backref_iter *btrfs_backref_iter_alloc(
> >> +		struct btrfs_fs_info *fs_info, gfp_t gfp_flag);
> >> +
> >> +static inline void btrfs_backref_iter_free(struct btrfs_backref_iter *iter)
> >> +{
> >> +	if (!iter)
> >> +		return;
> >> +	btrfs_free_path(iter->path);
> >> +	kfree(iter);
> >> +}
> > 
> > Why do you make so many functions static inline? It makes sense for some
> > of them but in the following patches there are functions that are either
> > too big (so when they're inlined it bloats the asm) or called
> > infrequently so the inlining does not bring much. Code in header files
> > should be kept to minimum.
> 
> As most of them meet the requirement for either too small, or too
> infrequently called.

So the rules or recommendations I use to decide if a function should be
static inline:

* it's like macro with type checking
* results into a few instructions (where few is like 3-6)
* the function is good for code readability, like for a helper that does
  some checks and returns a result, or derefernces a few pointers, and
  the function name is self explaining
* there should be some performance reason where the function call would
  be too costly, eg. if the function is on a hot path or in a loop

And all of that can be irrelevant if the compiler does some fancy
optimization, like function cloning where it keeps one copy intact
that's for the public interface and then inline other copies, possibly
applying more optimizations eg. based on parameters or some analysis
that splits function to hot and cold parts.

Unless we find some suboptimal result of compilation that could be fixed
by static inlines, I tend to not use them besides the trivial cases that
help code readability.

> > There are also functions not used anywhere else than in backref.c so
> > they don't need to be exported for now. For example
> > btrfs_backref_iter_is_inline_ref.
> 
> But it's used in later patches, thus I exported them to avoid re-export
> them later.

I grepped the whole branch with the backref cache and assumed that if
you introduce a function in the cleanup part, it would be used in the
other one. But btrfs_backref_iter_is_inline_ref wasn't.

> >> +int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr);
> >> +
> >> +static inline void
> >> +btrfs_backref_iter_release(struct btrfs_backref_iter *iter)
> > 
> > Please keep the function type and name on the same line, arguments can
> > go to the next line.
> 
> Forgot this one...
> 
> Do I need to resend?

I fix such things when applying the patches so for that only reason it's
not necessary to resend.
