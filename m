Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2104E4B27
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 03:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbiCWC6E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 22:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiCWC6B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 22:58:01 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65D7870865
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 19:56:31 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 0CA18277E72; Tue, 22 Mar 2022 22:56:30 -0400 (EDT)
Date:   Tue, 22 Mar 2022 22:56:30 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kreijack@inwind.it
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH 1/5] btrfs: add flags to give an hint to the chunk
 allocator
Message-ID: <YjqMXjn1wLAXVwKl@hungrycats.org>
References: <cover.1646589622.git.kreijack@inwind.it>
 <b15072e61eac46aa9f61317c59219713a01ff897.1646589622.git.kreijack@inwind.it>
 <Yjoo5TOlfGXgAUyk@localhost.localdomain>
 <42e2b1fd-809d-3370-e802-2a9b926d38c5@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e2b1fd-809d-3370-e802-2a9b926d38c5@libero.it>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 22, 2022 at 09:25:45PM +0100, Goffredo Baroncelli wrote:
> On 22/03/2022 20.52, Josef Bacik wrote:
> > On Sun, Mar 06, 2022 at 07:14:39PM +0100, Goffredo Baroncelli wrote:
> > > From: Goffredo Baroncelli <kreijack@inwind.it>
> > > 
> > > Add the following flags to give an hint about which chunk should be
> > > allocated in which disk:
> > > 
> > > - BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED
> > >    preferred for data chunk, but metadata chunk allowed
> > > - BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED
> > >    preferred for metadata chunk, but data chunk allowed
> > > - BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY
> > >    only metadata chunk allowed
> > > - BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY
> > >    only data chunk allowed
> > > 
> > > Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> > > ---
> > >   include/uapi/linux/btrfs_tree.h | 16 ++++++++++++++++
> > >   1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> > > index b069752a8ecf..e0d842c2e616 100644
> > > --- a/include/uapi/linux/btrfs_tree.h
> > > +++ b/include/uapi/linux/btrfs_tree.h
> > > @@ -389,6 +389,22 @@ struct btrfs_key {
> > >   	__u64 offset;
> > >   } __attribute__ ((__packed__));
> > > +/* dev_item.type */
> > > +
> > > +/* btrfs chunk allocation hint */
> > > +#define BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT	2
> > > +/* btrfs chunk allocation hint mask */
> > > +#define BTRFS_DEV_ALLOCATION_HINT_MASK	\
> > > +	((1 << BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT) - 1)
> > > +/* preferred data chunk, but metadata chunk allowed */
> > > +#define BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED	(0ULL)
> > > +/* preferred metadata chunk, but data chunk allowed */
> > > +#define BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED	(1ULL)
> > > +/* only metadata chunk are allowed */
> > > +#define BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY		(2ULL)
> > > +/* only data chunk allowed */
> > > +#define BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY		(3ULL)
> > > +
> > 
> > I also just realized you're using these as flags, so they need to be
> > 
> > (1ULL << 0)
> > (1ULL << 1)
> > (1ULL << 2)
> > (1ULL << 3)
> > 
> 
> Could you elaborate a bit ? These are mutual exclusive values...

One of the comments I had on earlier versions was that these should
be bit values.  Bit 0 is data (0) or metadata (1), bit 1 is preferred
(0) or only (2).  Thus "metadata only" is 3, "data preferred" is 0,
"data only" is 2, and "metadata preferred" is 1.  This maintained on-disk
compatibility with the earliest versions that only had the two "preferred"
options encoded as 0 and 1.

At some point this got lost.  Between one of the patch versions and
another I had to change the type numbers on all of my devices.

> > Thanks,
> > 
> > Josef
> 
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> 
