Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9ED9315BE9
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 02:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhBJBI6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 9 Feb 2021 20:08:58 -0500
Received: from lists.nic.cz ([217.31.204.67]:36622 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233412AbhBJBGj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 20:06:39 -0500
Received: from localhost (unknown [IPv6:2a0e:b107:ae1:0:3e97:eff:fe61:c680])
        by mail.nic.cz (Postfix) with ESMTPSA id 3982F141160;
        Wed, 10 Feb 2021 02:05:50 +0100 (CET)
Date:   Wed, 10 Feb 2021 02:05:49 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH u-boot] fs: btrfs: do not fail when offset of a
 ROOT_ITEM is not -1
Message-ID: <20210210020549.6881d90a@nic.cz>
In-Reply-To: <40e38323-0013-6799-1527-02cbac8dc93e@gmx.com>
References: <20210209173337.16621-1-marek.behun@nic.cz>
        <40e38323-0013-6799-1527-02cbac8dc93e@gmx.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST shortcircuit=ham
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 10 Feb 2021 08:09:14 +0800
Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:

> On 2021/2/10 上午1:33, Marek Behún wrote:
> > When the btrfs_read_fs_root() function is searching a ROOT_ITEM with
> > location key offset other than -1, it currently fails via BUG_ON.
> >
> > The offset can have other value than -1, though. This can happen for
> > example if a subvolume is renamed:
> >
> >    $ btrfs subvolume create X && sync
> >    Create subvolume './X'
> >    $ btrfs inspect-internal dump-tree /dev/root | grep -B 2 'name: X$
> >          location key (270 ROOT_ITEM 18446744073709551615) type DIR
> >          transid 283 data_len 0 name_len 1
> >          name: X
> >    $ mv X Y && sync
> >    $ btrfs inspect-internal dump-tree /dev/root | grep -B 2 'name: Y$
> >          location key (270 ROOT_ITEM 0) type DIR
> >          transid 285 data_len 0 name_len 1
> >          name: Y
> >
> > As can be seen the offset changed from -1ULL to 0.  
> 
> 
> Offset for subvolume ROOT_ITEM can be other values, especially for
> snapshot that offset is the transid when it get created.
> 
> But the problem is, if we call btrfs_read_fs_root() for subvolume tree,
> the offset of the key really doesn't matter, the only important thing is
> the objectid.
> 
> Thus we use that BUG_ON() to catch careless callers.
> 
> Would you please provide a case where we wrongly call
> btrfs_read_fs_root() with incorrect offset inside btrfs-progs/uboot?
> 
> I believe that would be the proper way to fix.

Qu,

this can be triggered in U-Boot when listing a directory containing a
subvolume that was renamed:
  - create a subvolume && sync
  - rename subvolume && sync
  - umount, reboot, list the directory containing the subvolume in
    u-boot
It will also break when you want to read a file that has a subvolume in
it's path (e.g. `read mmc 0 0x10000000 /renamed-subvol/file`).

I found out this btrfs-progs commit:
  https://github.com/kdave/btrfs-progs/commit/10f1af0fe7de5a0310657993c7c21a1d78087e56
This commit ensures that while searching a directory recursively, when
a ROOT_ITEM is encountered, the offset of its location is changed to -1
before passing the location to btrfs_read_fs_root().

So maybe we could do this in u-boot as well, but why do this? Linux'
btrfs driver does not check whether the offset is -1. So why do it here?

BTW, Qu, I think we have to change the BUG_ON code in U-Boot's btrfs
driver. BUG_ON in U-Boot calls a complete SOC reset. We can't break
whole U-Boot simply because btrfs partition contains broken data.
U-Boot commands must fail in such a case, not reset the SOC.

Marek
