Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FA34E4B71
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 04:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiCWD2B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 23:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241531AbiCWD16 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 23:27:58 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B3CB6EB3D
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 20:26:29 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id C4E5F277F6A; Tue, 22 Mar 2022 23:26:28 -0400 (EDT)
Date:   Tue, 22 Mar 2022 23:26:28 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH 1/5] btrfs: add flags to give an hint to the chunk
 allocator
Message-ID: <YjqTZIxRm0wJ05Rx@hungrycats.org>
References: <cover.1646589622.git.kreijack@inwind.it>
 <b15072e61eac46aa9f61317c59219713a01ff897.1646589622.git.kreijack@inwind.it>
 <YjoNvoIy/WmulvEc@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjoNvoIy/WmulvEc@localhost.localdomain>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 22, 2022 at 01:56:14PM -0400, Josef Bacik wrote:
> On Sun, Mar 06, 2022 at 07:14:39PM +0100, Goffredo Baroncelli wrote:
> > From: Goffredo Baroncelli <kreijack@inwind.it>
> > 
> > Add the following flags to give an hint about which chunk should be
> > allocated in which disk:
> > 
> > - BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED
> >   preferred for data chunk, but metadata chunk allowed
> > - BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED
> >   preferred for metadata chunk, but data chunk allowed
> > - BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY
> >   only metadata chunk allowed
> > - BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY
> >   only data chunk allowed
> > 
> > Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> > ---
> >  include/uapi/linux/btrfs_tree.h | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> > index b069752a8ecf..e0d842c2e616 100644
> > --- a/include/uapi/linux/btrfs_tree.h
> > +++ b/include/uapi/linux/btrfs_tree.h
> > @@ -389,6 +389,22 @@ struct btrfs_key {
> >  	__u64 offset;
> >  } __attribute__ ((__packed__));
> >  
> > +/* dev_item.type */
> > +
> > +/* btrfs chunk allocation hint */
> > +#define BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT	2
> > +/* btrfs chunk allocation hint mask */
> > +#define BTRFS_DEV_ALLOCATION_HINT_MASK	\
> > +	((1 << BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT) - 1)
> > +/* preferred data chunk, but metadata chunk allowed */
> > +#define BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED	(0ULL)
> 
> Actually don't we have 0 set on type already?  So this will make all existing
> file systems have DATA_PREFERRED, when in reality they may not want that
> behavior.  So should we start at 1?  Thanks,

If all the disks in the filesystem have the same value, and it's one
of the two _PREFERRED values, then there is no change in behavior from
before:  all devices will be filled with no (difference in) preferences.
So if the default is either DATA_PREFERRED or METADATA_PREFERRED, then
nothing changes for existing filesystems until at least one device is
set to some other type.

Another problem is, what happens if we add a new device to a filesystem
where some devices have _ONLY set?  In that case, the new device has
type 0, and might get either data or metadata allocated on it that we
don't want.

Four possible solutions to choose from:

1.  Leave things as they are, sysadmins will have to set the type on
new devices immediately after add, and possibly balance to fix bad
allocations if they lose the race.

2.  Make device type a parameter to the add-device ioctl, so that
drives can be added with a non-default type already set.

3.  Define "0" as "get the preference value from a mount option, a
sysfs variable, or some on-disk item?" which is another way to do
#2 that doesn't mean having to change an existing ioctl's parameters
or roll a new one (I haven't checked to see if we have a spare u64
on device add).

4.  Define "0" as meaning "last resort", a new preference level where
the device is not preferred for any allocation unless there are no other
devices with a preference set.  Ecch I don't like this one because there's
a possible race where we're converting e.g. a 4-disk raid1 array into 2
data-only 2 metadata-only, and there's a point where we have 2x data-only
1x metadata-only and one type 0 device and it's possible to ENOSPC on
metadata at that moment if type 0 doesn't allow metadata allocation.
This plan would prevent the "data on the wrong drive" failure mode, so
it's in the list, but don't use it unless you can solve the new problem.


> Josef
> 
