Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A6E1B5AA8
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Apr 2020 13:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgDWLmx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Apr 2020 07:42:53 -0400
Received: from lists.nic.cz ([217.31.204.67]:54704 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgDWLmw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Apr 2020 07:42:52 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id E3768140DC1;
        Thu, 23 Apr 2020 13:42:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587642170; bh=mnT1EHSqkWWATWSUB6QTzrFkKdUFrXATGK16/gdEvlw=;
        h=Date:From:To;
        b=NgkHT3o2OY9rQ1CZcgpm7n5BeXFeXNddq3WNX3EAQDia8Xkysxh+A3Sw2VyiBSkmK
         /jkG9uZszKcwjsqeM29sJep8+Ms5rsjla+X/8JXrW/uv0PRAsAPaUtEE9iFp1ENIK0
         eTj+Uz12BcgOkw/AtocuhtDD+vwgDllt3NK94ZnM=
Date:   Thu, 23 Apr 2020 13:42:48 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: when does btrfs create sparse extents?
Message-ID: <20200423134248.458cd87c@nic.cz>
In-Reply-To: <CAL3q7H7eE4wFi95JaTYRPOrTQiihOSEqV-W4hT1t-9-ptUHGrg@mail.gmail.com>
References: <20200422205209.0e2efd53@nic.cz>
        <CAJCQCtTDGb1hAAdp1-ph0wzFcfQNyAh-+hNMipdRmK0iTZA8Xw@mail.gmail.com>
        <CAJCQCtTEY347CwHGz3QKaBfxvPg0pTz_CF+OaiZNaCEGcnLfYA@mail.gmail.com>
        <20200422225851.3d031d88@nic.cz>
        <CAL3q7H7eE4wFi95JaTYRPOrTQiihOSEqV-W4hT1t-9-ptUHGrg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 23 Apr 2020 11:49:16 +0100
Filipe Manana <fdmanana@gmail.com> wrote:

> On Wed, Apr 22, 2020 at 10:00 PM Marek Behun <marek.behun@nic.cz> wrote:
> >
> > On Wed, 22 Apr 2020 14:44:46 -0600
> > Chris Murphy <lists@colorremedies.com> wrote:
> >  
> > > e.g. from a 10m file created with truncate on two Btrfs file systems
> > >
> > > original holes format (default)
> > >
> > >     item 6 key (257 EXTENT_DATA 0) itemoff 15768 itemsize 53
> > >         generation 7412 type 1 (regular)
> > >         extent data disk byte 0 nr 0
> > >         extent data offset 0 nr 10485760 ram 10485760
> > >         extent compression 0 (none)
> > >
> > > On a file system with no-holes feature set, this item simply doesn't
> > > exist. I think basically it works by inference. Both kinds of files
> > > have size in the INODE_ITEM, e.g.
> > >
> > >     item 4 key (257 INODE_ITEM 0) itemoff 32245 itemsize 160
> > >         generation 889509 transid 889509 size 10485760 nbytes 0
> > >
> > > Sparse extents are explicitly stated in the original format with disk
> > > byte 0 in an EXTENT_DATA item; whereas in the newer format, sparse
> > > extents exist whenever EXTENT_DATA items don't completely describe the
> > > file's size.  
> >
> > Ok this means that U-Boot currently gained support for the original
> > sparse extents.  
> 
> To clear any confusion, what you mean by sparse extents is actually holes.
> The concept of sparse files exists (files with holes, regions of a
> file for which there is no allocated extent), but not sparse extents.
> 
> >
> > I fear that current u-boot does not handle the new no-holes feature.  
> 
> The no-holes feature has been around since 2013, not exactly new, but
> it's not the default yet when creating a new filesystem.
> 
> As it has been mentioned earlier by Chris, it just removes the need
> for explicitly having metadata representing holes.
> When not using the no-holes feature, there is an explicit file extent
> item pointing to a disk location of 0 (disk_bytenr field has a value
> of 0) for each file hole.
> When using no-holes, there's no such file extent item - btrfs knows
> about the hole by checking that there is a gap between two consecutive
> file extent items (both having a disk_bytenr > 0).

This I already understand. My main question though is: does kernel or
btrfs do checking (at least sometimes) when writing a block of data onto
disk if this block is all zero, and if yes, then this block is written
as a hole (either by writing hole item or not writing anything)?

Or does this happen ONLY when requested by userspace?

Because for the love of god I cannot find why our kernel is being
written this way onto disk - the installer doesn't explicitly request
for PUNCH_HOLES nor anything, as far as I looked.

Marek

Marek
