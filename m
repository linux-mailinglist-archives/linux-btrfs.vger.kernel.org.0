Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE16E725355
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 07:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjFGFas (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 01:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjFGFar (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 01:30:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F53D1989
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 22:30:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A9C3568AA6; Wed,  7 Jun 2023 07:30:42 +0200 (CEST)
Date:   Wed, 7 Jun 2023 07:30:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: allocate dummy ordereded_sums objects for
 nocsum I/O on zoned file systems
Message-ID: <20230607053042.GA20278@lst.de>
References: <20230605084519.580346-1-hch@lst.de> <20230605084519.580346-3-hch@lst.de> <20230606171143.GM25292@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606171143.GM25292@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 06, 2023 at 07:11:43PM +0200, David Sterba wrote:
> > +	/*
> > +	 * If we are called for a nodatasum inode, this means we are on a zoned
> > +	 * file system.  In this case a ordered_csum structure needs to be
> > +	 * allocated to track the logical address actually written, but it does
> > +	 * notactually carry any checksums.
> > +	 */
> > +	if (btrfs_inode_is_nodatasum(inode))
> 
> So nodatasum in checksum bio implies zoned mode, this looks fragile. Why
> can't you check btrfs_is_zoned() instead? The comment is needed but I
> don't agree the condition should omit zoned mode itself.

We can't check that instead, as for zoned mode with checksums we should
not take this branch.  If we want to check btrfs_is_zoned() here it
would have to be an assert inside this branch to make things more clear.

Alternatively we could be a "bool skip_csum" argument, which is what
I did initially, but which felt more clumsy to me.

> >  
> >  	if (ordered->disk_bytenr != logical)
> >  		btrfs_rewrite_logical_zoned(ordered, logical);
> > +
> > +out:
> > +	if (btrfs_inode_is_nodatasum(BTRFS_I(ordered->inode))) {
> 
> The zoned mode here is implied by the calling function, open coding the
> condtions should not be a big deal, i.e. not needing the helper.

The zoned mode is implied.  But that's not what the helper checks for,
it checks for the per-inode or per-fs nodatasum bits.  But I can open
code it if you prefer that.
