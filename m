Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1217A4857F3
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 19:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242741AbiAESIK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 13:08:10 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:36940 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242736AbiAESIG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 13:08:06 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id C134A13D59A; Wed,  5 Jan 2022 13:07:54 -0500 (EST)
Date:   Wed, 5 Jan 2022 13:07:54 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kreijack@inwind.it
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>
Subject: Re: [RFC][V9][PATCH 0/6] btrfs: allocation_hint mode
Message-ID: <YdXeepXbRpbADrJf@hungrycats.org>
References: <cover.1639766364.git.kreijack@inwind.it>
 <YdUGAg1TB8FCfqnr@zen>
 <7377b63d-23a7-5efd-4ae2-cffe70463d0b@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7377b63d-23a7-5efd-4ae2-cffe70463d0b@libero.it>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 05, 2022 at 10:16:08AM +0100, Goffredo Baroncelli wrote:
> Hi Boris,
> 
> 
> 
> On 1/5/22 03:44, Boris Burkov wrote:
> [...]
> > 
> > This is cool, thanks for building it!
> > 
> > I'm playing with setting this up for a test I'm working on where I want
> > to send data to a dm-zero device. To that end, I applied this patchset
> > on top of misc-next and ran:
> > 
> > $ mkfs.btrfs -f /dev/vg0/lv0 -dsingle -msingle
> > $ mount /dev/vg0/lv0 /mnt/lol
> 
> You should mount the filesystem with
> 
> $ mount -o allocation_hint=1 /dev/vg0/lv0 /mnt/lol
> 
> In the previous iteration I missed the patch #6, which activates this option. You can drop patch #6 and avoid to pass this option.

Can we drop the mount option from the series?  It isn't needed.

Or, if we must have it (and I am in no way conceding that we do),
at least make it default to enabled.  Or turn the mount option into a
disable flag under the 'rescue=' option to make it clear this option is
not intended to be used in normal operation.

> Please give me a feedback if this resolve.
> 
> BR
> G.Baroncelli
> 
> > $ btrfs device add /dev/mapper/zero-data /mnt/lol
> > $ btrfs fi usage /mnt/lol
> > Overall:
> >      Device size:                  50.01TiB
> >      Device allocated:             20.00MiB
> >      Device unallocated:           50.01TiB
> >      Device missing:                  0.00B
> >      Used:                        128.00KiB
> >      Free (estimated):             50.01TiB      (min: 50.01TiB)
> >      Free (statfs, df):            50.01TiB
> >      Data ratio:                       1.00
> >      Metadata ratio:                   1.00
> >      Global reserve:                3.25MiB      (used: 0.00B)
> >      Multiple profiles:                  no
> > 
> > Data,single: Size:8.00MiB, Used:0.00B (0.00%)
> >     /dev/mapper/vg0-lv0     8.00MiB
> > 
> > Metadata,single: Size:8.00MiB, Used:112.00KiB (1.37%)
> >     /dev/mapper/vg0-lv0     8.00MiB
> > 
> > System,single: Size:4.00MiB, Used:16.00KiB (0.39%)
> >     /dev/mapper/vg0-lv0     4.00MiB
> > 
> > Unallocated:
> >     /dev/mapper/vg0-lv0     9.98GiB
> >     /dev/mapper/zero-data          50.00TiB
> > 
> > $ ./btrfs property set -t device /dev/mapper/zero-data allocation_hint DATA_ONLY
> > $ ./btrfs property set -t device /dev/vg0/lv0 allocation_hint METADATA_ONLY
> > 
> > $ btrfs balance start --full-balance /mnt/lol
> > Done, had to relocate 3 out of 3 chunks
> > 
> > $ btrfs fi usage /mnt/lol
> > Overall:
> >      Device size:                  50.01TiB
> >      Device allocated:              2.03GiB
> >      Device unallocated:           50.01TiB
> >      Device missing:                  0.00B
> >      Used:                        640.00KiB
> >      Free (estimated):             50.01TiB      (min: 50.01TiB)
> >      Free (statfs, df):            50.01TiB
> >      Data ratio:                       1.00
> >      Metadata ratio:                   1.00
> >      Global reserve:                3.25MiB      (used: 0.00B)
> >      Multiple profiles:                  no
> > 
> > Data,single: Size:1.00GiB, Used:512.00KiB (0.05%)
> >     /dev/mapper/zero-data           1.00GiB
> > 
> > Metadata,single: Size:1.00GiB, Used:112.00KiB (0.01%)
> >     /dev/mapper/zero-data           1.00GiB
> > 
> > System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
> >     /dev/mapper/zero-data          32.00MiB
> > 
> > Unallocated:
> >     /dev/mapper/vg0-lv0    10.00GiB
> >     /dev/mapper/zero-data          50.00TiB
> > 
> > 
> > I expected that I would have data on /dev/mapper/zero-data and metadata
> > on /dev/mapper/vg0-lv0, but it seems both of them were written to the zero
> > device. Attempting to actually use the file system eventually fails, since
> > the metadata is black-holed :)
> > 
> > Did I make some mistake in how I used it, or is this a bug?
> > 
> > Thanks,
> > Boris
> > 
> > > BR
> > > G.Baroncelli
> > > 
> > > Revision:
> > > V9:
> > > - rename dev_item->type to dev_item->flags
> > > - rename /sys/fs/btrfs/$UUID/devinfo/type -> allocation_hint
> > > 
> > > V8:
> > > - drop the ioctl API, instead use a sysfs one
> > > 
> > > V7:
> > > - make more room in the struct btrfs_ioctl_dev_properties up to 1K
> > > - leave in btrfs_tree.h only the costants
> > > - removed the mount option (sic)
> > > - correct an 'use before check' in the while loop (signaled
> > >    by Zygo)
> > > - add a 2nd sort to be sure that the device_info array is in the
> > >    expected order
> > > 
> > > V6:
> > > - add further values to the hints: add the possibility to
> > >    exclude a disk for a chunk type
> > > 
> > > 
> > > Goffredo Baroncelli (6):
> > >    btrfs: add flags to give an hint to the chunk allocator
> > >    btrfs: export the device allocation_hint property in sysfs
> > >    btrfs: change the device allocation_hint property via sysfs
> > >    btrfs: add allocation_hint mode
> > >    btrfs: rename dev_item->type to dev_item->flags
> > >    btrfs: add allocation_hint option.
> > > 
> > >   fs/btrfs/ctree.h                |  18 +++++-
> > >   fs/btrfs/disk-io.c              |   4 +-
> > >   fs/btrfs/super.c                |  17 ++++++
> > >   fs/btrfs/sysfs.c                |  73 ++++++++++++++++++++++
> > >   fs/btrfs/volumes.c              | 105 ++++++++++++++++++++++++++++++--
> > >   fs/btrfs/volumes.h              |   7 ++-
> > >   include/uapi/linux/btrfs_tree.h |  20 +++++-
> > >   7 files changed, 232 insertions(+), 12 deletions(-)
> > > 
> > > -- 
> > > 2.34.1
> > > 
> 
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
