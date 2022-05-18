Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0985852B563
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 11:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiERIqJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 04:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiERIqE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 04:46:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B95E205C2
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 01:46:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 964AD68AFE; Wed, 18 May 2022 10:46:00 +0200 (CEST)
Date:   Wed, 18 May 2022 10:46:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/15] btrfs: add a helper to iterate through a
 btrfs_bio with sector sized chunks
Message-ID: <20220518084600.GD6933@lst.de>
References: <20220517145039.3202184-1-hch@lst.de> <20220517145039.3202184-6-hch@lst.de> <PH0PR04MB7416A9EFBE86253DD0DB4DDE9BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416A9EFBE86253DD0DB4DDE9BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 17, 2022 at 03:27:35PM +0000, Johannes Thumshirn wrote:
> On 17/05/2022 16:51, Christoph Hellwig wrote:
> > +/*
> > + * Iterate through a btrfs_bio (@bbio) on a per-sector basis.
> > + */
> > +#define btrfs_bio_for_each_sector(fs_info, bvl, bbio, iter, bio_offset)	\
> > +	for ((iter) = (bbio)->iter, (bio_offset) = 0;			\
> > +	     (iter).bi_size &&					\
> > +	     (((bvl) = bio_iter_iovec((&(bbio)->bio), (iter))), 1);	\
> > +	     (bio_offset) += fs_info->sectorsize,			\
> > +	     bio_advance_iter_single(&(bbio)->bio, &(iter),		\
> > +	     (fs_info)->sectorsize))
> > +
> > +
> 
> This is first used in patch 12 why not move there?

Because it is a logically separate change that doesn't really have
anything to do with the repair code, except that it happens to be the
first user?
