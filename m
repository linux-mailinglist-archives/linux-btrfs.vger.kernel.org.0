Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2D54857C6
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 18:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242649AbiAER4g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 12:56:36 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53907 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242654AbiAERzn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 12:55:43 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id AE2E45C017F;
        Wed,  5 Jan 2022 12:55:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 05 Jan 2022 12:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=J7/2kaBRNMViNGNj/h5HC3jBb03
        rM7FS1dQjfVO8H2Q=; b=SQV8cgpRPZZlIct1IIVQ5yr1yPePlCbEbE1br67GQ6d
        zB8ZNgTENvJeJyPKv1RQwoZWOTAqmWf8y98m/x1OdkV3tBUmQYxakjlSQco1ucY0
        +WDEdh4aj/o39DLoYy/Kjotrq4VLjttC5yjMN18FZCY6sOMijY+1GN16zQG1CykA
        0WzgV5vDYoxbytEBAYweMu//m77vFum0iyYP4+hBJAdyLXqnS9Nm3tNJln1S9yBu
        uCY0c9zhYiWVZNwKekWcvH1F5DbQkuk2545USMd2PzUzoSU6XkGOpd8HHDNovHOi
        UgK+2HIKED6DjHELPTSvllL9YRrV+P9Xc5VFC6EGmeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=J7/2ka
        BRNMViNGNj/h5HC3jBb03rM7FS1dQjfVO8H2Q=; b=WawhrT0q0Z4hGzwvpTx+dN
        WoJyV1GTND4h9evbJ3X/o3629vkVsktaJGQKQWKPYkaSWP3YiSIdzXIKdjPrJgCv
        djEqgwko/oY1NpCU3glfWrj2z06FkTD1TRz9NKBox+xyCXltSCTo7acd2mSqmiEs
        R7+nKFTplVik1GM1ryq4ge1cc5hEjds43Z3bV5uOvYissDRWSDvUJnaoOf+IbdAV
        I/9diSCYJfT8x5TRCyghEcSYipnL+D8YGNQKIlMA9U3De5trawRm3luxE2VvFg2W
        b3wvmDyTMjPnvn+WE1Ic0Kf3VtIziI0nYqJ30DJHHUUvTy0NRdoUr/1HZTppcuAQ
        ==
X-ME-Sender: <xms:ndvVYVnCfRdTMgt3G02BOdQ7vispYkkO2tWRUoiK1hAJQiPh0HGsjA>
    <xme:ndvVYQ3SKZ2Epec_rsMYwLIukJiatxL8O7rXGZbP6Bw6RTeagQ1f2WM3SEG1tMy_E
    Ic5xDX9yRmGSsWggqw>
X-ME-Received: <xmr:ndvVYbp14l4W6NM94eA81PMQiHgZQlJAiVRudy87GM0UQGH4lfJMDtcv3UzkuldHcbgKtA8BMfIx_cJPQTxaVaFPgldddA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephe
    ffvddugfevfefgjeeivdfhkeeigffhueejteejgeffudfftdehveeuueevtdeknecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:ndvVYVmojPSV3r5fhVSk7kpBPznZVXbfEGHLmMIKt9wuxOJBim9YKQ>
    <xmx:ndvVYT1ocxtIh-EmmDsAsrZEw4lYIsDTIpK30D5Xkb5gkQrhMXiW3g>
    <xmx:ndvVYUvM7N4lUvqpSiiauIYqf3kU5hU9tCPbn1H-p5d089aBnR5c_Q>
    <xmx:ntvVYT_6w1zetKzKp_6IJXIJO-5VAA-I25o3OnETQ5dtlXFcDR0CFg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 12:55:41 -0500 (EST)
Date:   Wed, 5 Jan 2022 09:55:39 -0800
From:   Boris Burkov <boris@bur.io>
To:     kreijack@inwind.it
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>
Subject: Re: [RFC][V9][PATCH 0/6] btrfs: allocation_hint mode
Message-ID: <YdXbmwHZneMdxcly@zen>
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

With this option, I got the expected usage output:

Data,single: Size:1.00GiB, Used:512.00KiB (0.05%)
   /dev/mapper/zero-data           1.00GiB

Metadata,single: Size:1.00GiB, Used:112.00KiB (0.01%)
   /dev/mapper/vg0-lv0     1.00GiB

Sorry I missed that, and thanks for the quick reply.

> 
> In the previous iteration I missed the patch #6, which activates this option. You can drop patch #6 and avoid to pass this option.
> 
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
