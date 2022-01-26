Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9582449CE8E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 16:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242875AbiAZPdh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 10:33:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41528 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbiAZPdg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 10:33:36 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 30EC1218D9;
        Wed, 26 Jan 2022 15:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643211215;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BZFu1dpXmMn5Ub9iIk6DuAfqUGNCwXvbBP/ZZMT0HHs=;
        b=RSPZtgdrPpQWKzdX7/eLGzD4tgy/+4OeoCzb9h9+wrOd4nPb901oBfPa1L8+l9K7s0ESdb
        atak7Js6c3GsWXsmhyH2TE7OE6kwRfkOwzOUEdcQIuSTSS/9z1WuPEAn0lNBNt0NTkIPzw
        9sMNwzvtTAOVsTCGePhFMfMicZ/syC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643211215;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BZFu1dpXmMn5Ub9iIk6DuAfqUGNCwXvbBP/ZZMT0HHs=;
        b=WZK93ZRBAsseZCwtsaQR+9gldGqVHODA1JaIgI9Cgi4BICJhTmHeFzGXqbqbAmgsTWGjxq
        7/dFVMVvlPIl6SCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1BE9FA3B84;
        Wed, 26 Jan 2022 15:33:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2B82EDA7A9; Wed, 26 Jan 2022 16:32:53 +0100 (CET)
Date:   Wed, 26 Jan 2022 16:32:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 09/11] btrfs: abstract out loading the tree root
Message-ID: <20220126153253.GX14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1639600719.git.josef@toxicpanda.com>
 <fc9f1e2aa167dfe0d1b9b806246eb55e098092c9.1639600719.git.josef@toxicpanda.com>
 <64a4fbdc-0a06-1c65-cd3c-5874a3ba6d4d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64a4fbdc-0a06-1c65-cd3c-5874a3ba6d4d@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 13, 2022 at 11:20:43AM +0200, Nikolay Borisov wrote:
> 
> 
> On 15.12.21 г. 22:40, Josef Bacik wrote:
> > We're going to be adding more roots that need to be loaded from the
> > super block, so abstract out the code to read the tree_root from the
> > super block, and use this helper for the chunk root as well.  This will
> > make it simpler to load the new trees in the future.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/disk-io.c | 82 ++++++++++++++++++++++++++--------------------
> >  1 file changed, 47 insertions(+), 35 deletions(-)
> > 
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 5c598e124c25..ddc3b9fcbabc 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -2934,6 +2934,46 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
> >  	return ret;
> >  }
> >  
> > +static int load_super_root(struct btrfs_root *root, u64 bytenr, u64 gen,
> > +			   int level)
> 
> nit: 'super' here sounds a bit off. Perhaps 'meta' (no pun intended!) or
> 'main' or 'core' or simply 'load_root' ?

Yeah as we have 'superblock' referred to as 'super', so this is
confusing. I don't have suggestion for final name and will leave as it
is. Looking to dictionary there are several terms we haven't used so
far, like pivotal, crucial, essential, principal, cardinal, major, or
maybe even central.

> > +{
> > +	int ret = 0;
> > +
> > +	root->node = read_tree_block(root->fs_info, bytenr,
> > +				     root->root_key.objectid, gen, level, NULL);
> > +	if (IS_ERR(root->node)) {
> > +		ret = PTR_ERR(root->node);
> > +		root->node = NULL;
> > +	} else if (!extent_buffer_uptodate(root->node)) {
> > +		free_extent_buffer(root->node);
> > +		root->node = NULL;
> > +		ret = -EIO;
> > +	}
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	btrfs_set_root_node(&root->root_item, root->node);
> > +	root->commit_root = btrfs_root_node(root);
> > +	btrfs_set_root_refs(&root->root_item, 1);
> > +	return ret;
> > +}
> > +
> > +static int load_important_roots(struct btrfs_fs_info *fs_info)
> 
> nit: This name is somewhat colloquial and naming something important
> doesn't really convey much useful information about what it is. So I'm
> wondering what a more becoming name might look like. I was thinking of
> load_main_roots - but I have a feeling it's not much better than
> 'important' or load_core_roots but this introduces 'core' as a new
> concept which we haven't had so far in the code.

Same here, naming changes in the future expected.
