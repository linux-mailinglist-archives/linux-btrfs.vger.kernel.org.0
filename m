Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B20C2A2D20
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgKBOlF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:41:05 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:41802 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgKBOlE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Nov 2020 09:41:04 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id A1961884500; Mon,  2 Nov 2020 09:40:50 -0500 (EST)
Date:   Mon, 2 Nov 2020 09:40:50 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     A L <mail@lechevalier.se>
Cc:     waxhead <waxhead@dirtcellar.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Switching from spacecache v1 to v2
Message-ID: <20201102144048.GA28049@hungrycats.org>
References: <fc45b21c-d24e-641c-efab-e1544aa98071@dirtcellar.net>
 <20201101174902.GU5890@hungrycats.org>
 <04d57bc4-c406-0d54-8299-662883fd48da@lechevalier.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04d57bc4-c406-0d54-8299-662883fd48da@lechevalier.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 02, 2020 at 06:48:11AM +0100, A L wrote:
> 
> > > And
> > > How do I make the switch properly?
> > Unmount the filesystem, mount it once with -o clear_cache,space_cache=v2.
> > It will take some time to create the tree.  After that, no mount option
> > is needed.
> > 
> > With current kernels it is not possible to upgrade while the filesystem is
> > online, i.e. to upgrade "/" you have to set rootflags in the bootloader
> > or boot from external media.  That and the long mount time to do the
> > conversion (which offends systemd's default mount timeout parameters)
> > are the two major gotchas.
> > 
> > There are some patches for future kernels that will take care of details
> > like deleting the v1 space cache inodes and other inert parts of the
> > space_cache=v1 infrastructure.  I would not bother with these
> > now, and instead let future kernels clean up automatically.
> 
> There is also this option according to the man page of btrfs-check:
> https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs-check
> 
> --clear-space-cache v1|v2
>     completely wipe all free space cache of given type
>     For free space cache v1, the clear_cache kernel mount option only
> rebuilds the free space cache for block groups that are modified while the
> filesystem is mounted with that option. Thus, using this option with v1
> makes it possible to actually clear the entire free space cache.
>     For free space cache v2, the clear_cache kernel mount option destroys
> the entire free space cache. This option, with v2 provides an alternative
> method of clearing the free space cache that doesn’t require mounting the
> filesystem.
> 
> Is there any practical difference to clearing the space cache using mount
> options? 

It's easier, because mount requires only setting flags.  It doesn't
require the additional separate step of running btrfs check.

The kernel will currently recreate parts of the v1 structures when
space_cache=v2 is used, so it will partially cancel out the work btrfs
check does.  There is a patch out there to fix that, see "btrfs: skip
space_cache v1 setup when not using it").

> For example, would a lot of old space_cache=v1 data remain on-disk
> after mounting -o clear_cache,space_cache=v2 ? 

It does, but the space used is negligible.  Future kernels will clean
it up automatically, assuming the patch set lands.

> Would that affect performance in any way?

Unused space cache is inert.  It only takes up space, and not very much
of that.

> Thanks.
> 
