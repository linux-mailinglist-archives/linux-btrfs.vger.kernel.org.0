Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C503015D7F1
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 14:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgBNNIa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 08:08:30 -0500
Received: from mail.nethype.de ([5.9.56.24]:43633 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbgBNNIa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 08:08:30 -0500
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1j2aho-001scB-A1; Fri, 14 Feb 2020 13:08:28 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1j2aH1-0008U9-Qs; Fri, 14 Feb 2020 12:40:47 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1j2aH1-0002D7-Lg; Fri, 14 Feb 2020 13:40:47 +0100
Date:   Fri, 14 Feb 2020 13:40:47 +0100
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Nikolay Borisov <nborisov@suse.com>,
        Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: cpu bound I/O behaviour in linux 5.4 (possibly others)
Message-ID: <20200214124040.GA7686@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7SPyXB+5G6+XtgfviJdBQQSYD1YyJZPX6rbWxhes-+qw@mail.gmail.com>
 <7a472107-ab87-d787-9f4f-d0d0e148061a@suse.com>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

First of all, thanks for the response - and if my mails are somehow
off-topic for the list, also feelf ree to tell me :)

On Fri, Feb 14, 2020 at 01:57:33PM +0200, Nikolay Borisov <nborisov@suse.com> wrote:
> > one core) in top:
> 
> So this is a 50tb useful space, right?

Yup, pretty full, too. I also forgot to mention that the vast majority
of files are between 400kB and 2MB, and not, as one might expect from
textgroups, a few kilobytes.

> >    [<0>] tree_search_offset.isra.0+0x16a/0x1d0 [btrfs]
> 
> This points to freespace cache. One thing that I might suggest is try

Hmm, I did switch to the free space tree on all larger filesystems long
ago, or at least I thought so. I use these mount options on the fs in
question:

   rw,noatime,nossd,space_cache=v2,commit=120,subvolid=5,subvol=/

I assume this is the correct way to get it (and your space_cache=2 is a
typo, or an alternative?).

So either I am not switching on the free space tree properly, or it's not
the problem. I did notice major speedups form it in the past, though.

> So you can't deduce that the free space cache is being used, and
> despite being the default, it was not mentioned by Marc if he's not
> using already the free space tree (-o space_cache=v2).

Yes, sorry, it's alwayss hard to strike a balance between needed info and
too much.

> Switching from one to the other might make the problem go away, simply
> because it cause free space to be scanned and build a new cache or
> tree.

So clearing the free space tree might also help? Can I do this while its
mounted using remount or do I haver to umount/mount (or use btrfs check)?

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
