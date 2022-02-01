Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BFB4A6284
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 18:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240393AbiBARfC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 12:35:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41348 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiBARfB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 12:35:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C2E311F3A8;
        Tue,  1 Feb 2022 17:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643736900;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z3xHXzl1DOLoKwfZO/ancif/RBw/hpXfNIXc61c1k4M=;
        b=smH9/gL1So1vMxwjdvcenvo6zjNE7DZ9bf0PpfZaprHRujVEEoc0Y12Z6nXLywiYOvLW7T
        bpRsylQIJ0eHTHmKwm5/r3l909dtwGfor4yT8HU0CbeFXfJY2WNTw8sTjT9zBPLNTP3l2M
        o/jKqrkpff9zUZeGabgyEQXPOlfcpfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643736900;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z3xHXzl1DOLoKwfZO/ancif/RBw/hpXfNIXc61c1k4M=;
        b=sC7g7m9o8c7I2TgGjNCf/47nkTHD4Ax9k1Me9YhdGXaWeLoArVCnsBtCvxlD4vuJ2Iqw4p
        5qXQJMEpHjrmpQCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B8881A3B81;
        Tue,  1 Feb 2022 17:35:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A88FFDA7A9; Tue,  1 Feb 2022 18:34:16 +0100 (CET)
Date:   Tue, 1 Feb 2022 18:34:16 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Stickstoff <stickstoff@posteo.de>
Subject: Re: [PATCH 2/3] btrfs: check/original: reject bad metadata backref
 with invalid level
Message-ID: <20220201173416.GX14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Stickstoff <stickstoff@posteo.de>
References: <20220117023850.40337-1-wqu@suse.com>
 <20220117023850.40337-3-wqu@suse.com>
 <1r17vzxp.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1r17vzxp.fsf@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 17, 2022 at 10:48:29AM +0800, Su Yue wrote:
> 
> On Mon 17 Jan 2022 at 10:38, Qu Wenruo <wqu@suse.com> wrote:
> 
> > [BUG]
> > There is a bug report that kernel tree-checker rejected an 
> > invalid
> > metadata item:
> >
> >  corrupt leaf: block=934474399744 slot=68 extent 
> >  bytenr=425173254144 len=16384 invalid tree level, have 33554432 
> >  expect [0, 7]
> >
> > But original mode btrfs-check reports nothing wrong.
> > (BTW, lowmem mode will just crash, and fixed in previous patch).
> >
> > [CAUSE]
> > For original mode it doesn't really check tree level, thus 
> > didn't find
> > the problem.
> >
> > [FIX]
> > I don't have a good idea to completely make original mode to 
> > verify the
> > level in backref and in the tree block (while lowmem does that).
> >
> > But at least we can detect obviouly corrupted level just like 
> > kernel.
> >
> > Now original mode will detect such problem:
> >
> >  ...
> >  [2/7] checking extents
> >  ERROR: tree block 30457856 has bad backref level, has 256 
> >  expect [0, 7]
> >  ref mismatch on [30457856 16384] extent item 0, found 1
> >  tree backref 30457856 root 5 not found in extent tree
> >  backpointer mismatch on [30457856 16384]
> >  ERROR: errors found in extent allocation tree or chunk 
> >  allocation
> >  [3/7] checking free space tree
> >  ...
> >
> > Reported-by: Stickstoff <stickstoff@posteo.de>
> > Link: 
> > https://lore.kernel.org/linux-btrfs/6ed4cd5a-7430-f326-4056-25ae7eb44416@posteo.de/
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >  check/main.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/check/main.c b/check/main.c
> > index 540130b8e223..2dea2acf5104 100644
> > --- a/check/main.c
> > +++ b/check/main.c
> > @@ -5447,6 +5447,25 @@ static int process_extent_item(struct 
> > btrfs_root *root,
> >  	if (metadata)
> >  		btrfs_check_subpage_eb_alignment(gfs_info, 
> >  key.objectid, num_bytes);
> >
> > +	ptr = (unsigned long)(ei + 1);
> > +	if (metadata) {
> > +		u64 level;
> > +
> > +		if (key.type == BTRFS_EXTENT_ITEM_KEY) {
> > +			struct btrfs_tree_block_info *info;
> > +
> > +			info = (struct btrfs_tree_block_info 
> > *)ptr;
> > +			level = btrfs_tree_block_level(eb, info);
> > +		} else {
> > +			level = key.offset;
> > +		}
> > +		if (level >= BTRFS_MAX_LEVEL) {
> > +			error(
> > +	"tree block %llu has bad backref level, has %llu expect 
> > [0, %u]",
> > +			      key.objectid, level, BTRFS_MAX_LEVEL 
> > - 1);
> > +			return -EIO;
> >
> -EUCLEAN is better?

Yes, updated in patch, thanks.
