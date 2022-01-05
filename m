Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F71485832
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 19:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242914AbiAES3L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 13:29:11 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40777 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242911AbiAES3I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 13:29:08 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9D4E65C00EB;
        Wed,  5 Jan 2022 13:29:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 05 Jan 2022 13:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=N0fTwRVS84bZnGPEDwesXjoPGBT
        xIOZHLfGYZTIzlhY=; b=wxhNB69ZMLBl+hyAafRgWGDQOTK+5U7NxjiZOK/i6hJ
        s4e2BYcO8TjRBMFGMjXX4d15T61YD2Il8AqMMGgO6AJsBl8ybCHGlTCpblBW96Qp
        P8TSHhk3Jg4ODnz0UQbAMKASAkaaAWRJZs2tC0JoWNkBHgi0s4bJmlf9hkMyYt5y
        tlQYdJV9IyDsw0wbtrj70hH8jgkCb5GpgC848bPcefO+cX1uiTSyMai5C7ePGP+g
        IWlj1DRDr6ERV1X+UqM8LbNz91YnhYjxo/22HzHzgdl3D6onuYV1Inuvu9f73D/4
        2MQSzSPMpL6mNJWuIP0pLbrPpTVZsbdgXoSfa5Y8iBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=N0fTwR
        VS84bZnGPEDwesXjoPGBTxIOZHLfGYZTIzlhY=; b=SMxCw8ik2ZRz5LeciE+RNb
        cp+g4utmLvWdC/emF25c9ZcbBax8wJjWHPnPyYOAIj/n+jD6YTJnZyuU42EU4Gbz
        MhT781nGEg1jzzRz1W3Gn9dqh6TDqSLaq2c0Sko029gUsD0vybix2o0VQ8MyzxNt
        lIvIyXsxrbsaPpFrDdfSF8IVkXr5qzN4kVXPc1xvpM7uxdKN8EuyJzhYFK3xCyTo
        YU51xm3Vi4oMihQAiFk5Wx+hhJqgPUiaWKoENzrm2zmW2o/rQYalfXV1VDOV/R3K
        MzV1cEPQzf37RJH+X9ZldPjV652lqRjwZ56EX+p9nhxe4yLiNNtfr3CgL+YWGo2g
        ==
X-ME-Sender: <xms:c-PVYVauZgH5Fp5PeWVewapF4aM58YWx4dQ42uigLW4hRQx86TwAkQ>
    <xme:c-PVYcaal2wrg7PCJzen7y1fO7Hz_20rDWCGyoGMSOvpsn8F2W2-L8K4n6gXWJ8MW
    hgh18Bn_Vvg2cRXEMU>
X-ME-Received: <xmr:c-PVYX8ig8txml9nWfQ_WyLD56RRSf8hyLUYGurOBLfCm1IjsSHV9u0vmCHAv2AvVqEp-xFidG5sv-HoLBipRZf6zWEZZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephe
    duveelkeeiteelveeiuefhudehtdeigfehkeeffeegledvueevgefgudeuveefnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:c-PVYTo2y6sAA5bCfa_AKXuZk4VNfvOFrceWCGoBNqFfsK-G6Y785w>
    <xmx:c-PVYQr3-T3acjt2HhwPvgUMMGRd3uw3xlnS0RB0WRtkYqIWAjjPAg>
    <xmx:c-PVYZTHf-FWLkp9LmJ-z5jYAY6h0GMbqW7_1SIfdNdsu1NGZFDYBw>
    <xmx:c-PVYVDyO4QeqlbWQzsoPSAraR0UuUi57xtfR9R3IFQmmGmn4Clbqg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 13:29:06 -0500 (EST)
Date:   Wed, 5 Jan 2022 10:29:04 -0800
From:   Boris Burkov <boris@bur.io>
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>
Subject: Re: [RFC][V9][PATCH 0/6] btrfs: allocation_hint mode
Message-ID: <YdXjcCf6jvHDhmZq@zen>
References: <cover.1639766364.git.kreijack@inwind.it>
 <YdUGAg1TB8FCfqnr@zen>
 <7377b63d-23a7-5efd-4ae2-cffe70463d0b@libero.it>
 <YdXeepXbRpbADrJf@hungrycats.org>
 <88a62f44-ae3f-f4b4-d2d7-6d82efd60933@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88a62f44-ae3f-f4b4-d2d7-6d82efd60933@inwind.it>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 05, 2022 at 07:16:04PM +0100, Goffredo Baroncelli wrote:
> On 05/01/2022 19.07, Zygo Blaxell wrote:
> > On Wed, Jan 05, 2022 at 10:16:08AM +0100, Goffredo Baroncelli wrote:
> > > Hi Boris,
> > > 
> > > 
> > > 
> > > On 1/5/22 03:44, Boris Burkov wrote:
> > > [...]
> > > > 
> > > > This is cool, thanks for building it!
> > > > 
> > > > I'm playing with setting this up for a test I'm working on where I want
> > > > to send data to a dm-zero device. To that end, I applied this patchset
> > > > on top of misc-next and ran:
> > > > 
> > > > $ mkfs.btrfs -f /dev/vg0/lv0 -dsingle -msingle
> > > > $ mount /dev/vg0/lv0 /mnt/lol
> > > 
> > > You should mount the filesystem with
> > > 
> > > $ mount -o allocation_hint=1 /dev/vg0/lv0 /mnt/lol
> > > 
> > > In the previous iteration I missed the patch #6, which activates this option. You can drop patch #6 and avoid to pass this option.
> > 
> > Can we drop the mount option from the series?  It isn't needed.
> > 
> > Or, if we must have it (and I am in no way conceding that we do),
> > at least make it default to enabled.  Or turn the mount option into a
> > disable flag under the 'rescue=' option to make it clear this option is
> > not intended to be used in normal operation.
> 
> Frankly speaking it was a my mistake to add this patch. It was in the
> queue, but in the last patches sets I dropped it. However in the last
> one I forgot to drop it manually so it reappeared :-)
> 
> However I like your suggestion to add as 'rescue' option, where the
> default is "enabled".

A mount option adds a lot of testing burden:
enabling it where it was disabled
disabling it where it was enabled
does the above work on remount
does it always print what's expected in /proc/mounts
etc..

So I think it should have a strong justification for adding it, and the
xfstests will need to reflect the above.

Unless it's the best way to support some otherwise impossible recovery
for a realistic failure mode, I would personally suggest just skipping
it. However, I only skimmed through the discussion about recovery in the
older thread, FWIW.

> 
> @Josef,
> do you started to play with this patch ? If not can I send an update
> where the main change is the renaming of the properties from
> 
> PREFERRED_<X> to <X>_PREFERRED
> 
> (e.g. PREFERRED_DATA to DATA_PREFERRED) which are more correct ?
> 
> BR
> G.Baroncelli
> > 
> > > Please give me a feedback if this resolve.
> > > 
> > > BR
> > > G.Baroncelli
> > > 
> > > > $ btrfs device add /dev/mapper/zero-data /mnt/lol
> > > > $ btrfs fi usage /mnt/lol
> > > > Overall:
> > > >       Device size:                  50.01TiB
> > > >       Device allocated:             20.00MiB
> > > >       Device unallocated:           50.01TiB
> > > >       Device missing:                  0.00B
> > > >       Used:                        128.00KiB
> > > >       Free (estimated):             50.01TiB      (min: 50.01TiB)
> > > >       Free (statfs, df):            50.01TiB
> > > >       Data ratio:                       1.00
> > > >       Metadata ratio:                   1.00
> > > >       Global reserve:                3.25MiB      (used: 0.00B)
> > > >       Multiple profiles:                  no
> > > > 
> > > > Data,single: Size:8.00MiB, Used:0.00B (0.00%)
> > > >      /dev/mapper/vg0-lv0     8.00MiB
> > > > 
> > > > Metadata,single: Size:8.00MiB, Used:112.00KiB (1.37%)
> > > >      /dev/mapper/vg0-lv0     8.00MiB
> > > > 
> > > > System,single: Size:4.00MiB, Used:16.00KiB (0.39%)
> > > >      /dev/mapper/vg0-lv0     4.00MiB
> > > > 
> > > > Unallocated:
> > > >      /dev/mapper/vg0-lv0     9.98GiB
> > > >      /dev/mapper/zero-data          50.00TiB
> > > > 
> > > > $ ./btrfs property set -t device /dev/mapper/zero-data allocation_hint DATA_ONLY
> > > > $ ./btrfs property set -t device /dev/vg0/lv0 allocation_hint METADATA_ONLY
> > > > 
> > > > $ btrfs balance start --full-balance /mnt/lol
> > > > Done, had to relocate 3 out of 3 chunks
> > > > 
> > > > $ btrfs fi usage /mnt/lol
> > > > Overall:
> > > >       Device size:                  50.01TiB
> > > >       Device allocated:              2.03GiB
> > > >       Device unallocated:           50.01TiB
> > > >       Device missing:                  0.00B
> > > >       Used:                        640.00KiB
> > > >       Free (estimated):             50.01TiB      (min: 50.01TiB)
> > > >       Free (statfs, df):            50.01TiB
> > > >       Data ratio:                       1.00
> > > >       Metadata ratio:                   1.00
> > > >       Global reserve:                3.25MiB      (used: 0.00B)
> > > >       Multiple profiles:                  no
> > > > 
> > > > Data,single: Size:1.00GiB, Used:512.00KiB (0.05%)
> > > >      /dev/mapper/zero-data           1.00GiB
> > > > 
> > > > Metadata,single: Size:1.00GiB, Used:112.00KiB (0.01%)
> > > >      /dev/mapper/zero-data           1.00GiB
> > > > 
> > > > System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
> > > >      /dev/mapper/zero-data          32.00MiB
> > > > 
> > > > Unallocated:
> > > >      /dev/mapper/vg0-lv0    10.00GiB
> > > >      /dev/mapper/zero-data          50.00TiB
> > > > 
> > > > 
> > > > I expected that I would have data on /dev/mapper/zero-data and metadata
> > > > on /dev/mapper/vg0-lv0, but it seems both of them were written to the zero
> > > > device. Attempting to actually use the file system eventually fails, since
> > > > the metadata is black-holed :)
> > > > 
> > > > Did I make some mistake in how I used it, or is this a bug?
> > > > 
> > > > Thanks,
> > > > Boris
> > > > 
> > > > > BR
> > > > > G.Baroncelli
> > > > > 
> > > > > Revision:
> > > > > V9:
> > > > > - rename dev_item->type to dev_item->flags
> > > > > - rename /sys/fs/btrfs/$UUID/devinfo/type -> allocation_hint
> > > > > 
> > > > > V8:
> > > > > - drop the ioctl API, instead use a sysfs one
> > > > > 
> > > > > V7:
> > > > > - make more room in the struct btrfs_ioctl_dev_properties up to 1K
> > > > > - leave in btrfs_tree.h only the costants
> > > > > - removed the mount option (sic)
> > > > > - correct an 'use before check' in the while loop (signaled
> > > > >     by Zygo)
> > > > > - add a 2nd sort to be sure that the device_info array is in the
> > > > >     expected order
> > > > > 
> > > > > V6:
> > > > > - add further values to the hints: add the possibility to
> > > > >     exclude a disk for a chunk type
> > > > > 
> > > > > 
> > > > > Goffredo Baroncelli (6):
> > > > >     btrfs: add flags to give an hint to the chunk allocator
> > > > >     btrfs: export the device allocation_hint property in sysfs
> > > > >     btrfs: change the device allocation_hint property via sysfs
> > > > >     btrfs: add allocation_hint mode
> > > > >     btrfs: rename dev_item->type to dev_item->flags
> > > > >     btrfs: add allocation_hint option.
> > > > > 
> > > > >    fs/btrfs/ctree.h                |  18 +++++-
> > > > >    fs/btrfs/disk-io.c              |   4 +-
> > > > >    fs/btrfs/super.c                |  17 ++++++
> > > > >    fs/btrfs/sysfs.c                |  73 ++++++++++++++++++++++
> > > > >    fs/btrfs/volumes.c              | 105 ++++++++++++++++++++++++++++++--
> > > > >    fs/btrfs/volumes.h              |   7 ++-
> > > > >    include/uapi/linux/btrfs_tree.h |  20 +++++-
> > > > >    7 files changed, 232 insertions(+), 12 deletions(-)
> > > > > 
> > > > > -- 
> > > > > 2.34.1
> > > > > 
> > > 
> > > 
> > > -- 
> > > gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> > > Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> 
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
