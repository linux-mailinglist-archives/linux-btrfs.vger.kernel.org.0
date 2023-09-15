Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51187A20AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 16:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjIOOSP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 10:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjIOOSO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 10:18:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85668F3;
        Fri, 15 Sep 2023 07:18:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 354E7218B5;
        Fri, 15 Sep 2023 14:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694787488;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vCbzNRBSiNbcpATSiwwTAa7ZeVAspWv2qzOjCLb874I=;
        b=PDqPCLvZNABVAagFQiKTNot44blQfSZcmNzLG5mRwWPcmEzprKheChiTI5m4DWi2oA+gZ7
        sDOMTaePuhG035TH23bVfYWme1x4u7n0eXYQMj/TELPX93FqFh/e1NdDD+IK2kqnl4Gk3L
        lMaaEh8XcEQ9nb7kA88G7TKDERP6QaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694787488;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vCbzNRBSiNbcpATSiwwTAa7ZeVAspWv2qzOjCLb874I=;
        b=71RNcZfp06PhQoiJXlzA5TwIaYBxjcPCi3Jr9IRX6wVDpAfmESMhS0Hb+RPNAXOO/9orjs
        MHtr4quhGnIUJuBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D35CF13251;
        Fri, 15 Sep 2023 14:18:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EWDSMp9nBGXTeAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 15 Sep 2023 14:18:07 +0000
Date:   Fri, 15 Sep 2023 16:11:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 06/11] btrfs: implement RST version of scrub
Message-ID: <20230915141133.GA2747@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
 <20230914-raid-stripe-tree-v9-6-15d423829637@wdc.com>
 <33f4c547-65bc-4523-b1c0-bae0c7ad1e65@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33f4c547-65bc-4523-b1c0-bae0c7ad1e65@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 15, 2023 at 10:28:50AM +0930, Qu Wenruo wrote:
> 
> 
> On 2023/9/15 01:37, Johannes Thumshirn wrote:
> > A filesystem that uses the RAID stripe tree for logical to physical
> > address translation can't use the regular scrub path, that reads all
> > stripes and then checks if a sector is unused afterwards.
> >
> > When using the RAID stripe tree, this will result in lookup errors, as the
> > stripe tree doesn't know the requested logical addresses.
> >
> > Instead, look up stripes that are backed by the extent bitmap.
> >
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> >   fs/btrfs/bio.c              |  2 ++
> >   fs/btrfs/raid-stripe-tree.c |  8 ++++++-
> >   fs/btrfs/scrub.c            | 53 +++++++++++++++++++++++++++++++++++++++++++++
> >   fs/btrfs/volumes.h          |  1 +
> >   4 files changed, 63 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> > index ddbe6f8d4ea2..bdb6e3effdbb 100644
> > --- a/fs/btrfs/bio.c
> > +++ b/fs/btrfs/bio.c
> > @@ -663,6 +663,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
> >   	blk_status_t ret;
> >   	int error;
> >
> > +	smap.is_scrub = !bbio->inode;
> > +
> >   	btrfs_bio_counter_inc_blocked(fs_info);
> >   	error = btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
> >   				&bioc, &smap, &mirror_num, 1);
> > diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> > index 697a6e1fd255..63bf62c33436 100644
> > --- a/fs/btrfs/raid-stripe-tree.c
> > +++ b/fs/btrfs/raid-stripe-tree.c
> > @@ -334,6 +334,11 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
> >   	if (!path)
> >   		return -ENOMEM;
> >
> > +	if (stripe->is_scrub) {
> > +		path->skip_locking = 1;
> > +		path->search_commit_root = 1;
> > +	}
> > +
> >   	ret = btrfs_search_slot(NULL, stripe_root, &stripe_key, path, 0, 0);
> >   	if (ret < 0)
> >   		goto free_path;
> > @@ -420,7 +425,8 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
> >   out:
> >   	if (ret > 0)
> >   		ret = -ENOENT;
> > -	if (ret && ret != -EIO) {
> > +	if (ret && ret != -EIO && !stripe->is_scrub) {
> > +
> 
> One extra newline.

There were way more stray newlines, you don't have to point that out
in reviews, I fix them once we have version that would not change too
much.
