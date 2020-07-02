Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7C9211795
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 03:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgGBBLh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 21:11:37 -0400
Received: from mail.nethype.de ([5.9.56.24]:42351 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgGBBLg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 21:11:36 -0400
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jqnlG-002Crg-T7; Thu, 02 Jul 2020 01:11:35 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jqnlG-00057x-OZ; Thu, 02 Jul 2020 01:11:34 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1jqnlG-0001PF-OC; Thu, 02 Jul 2020 03:11:34 +0200
Date:   Thu, 2 Jul 2020 03:11:34 +0200
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: first mount(s) after unclean shutdown always fail
Message-ID: <20200702011134.GA5037@schmorp.de>
References: <20200701005116.GA5478@schmorp.de>
 <36fcfc97-ce4c-cce8-ee96-b723a1b68ec7@gmx.com>
 <20200701201419.GB1889@schmorp.de>
 <cc42d4dc-b46f-7868-6a05-187949136eae@gmx.com>
 <20200701235512.GA3231@schmorp.de>
 <25e94ec6-842c-310f-e105-6d8f1e6dfdce@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25e94ec6-842c-310f-e105-6d8f1e6dfdce@gmx.com>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 02, 2020 at 08:02:52AM +0800, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> Well, if you want to go this way, let me show the code here.
> 
> From fs/btrfs/volumes.c:btrfs_read_chunk_tree():
> 
>         if (btrfs_super_total_bytes(fs_info->super_copy) <
>             fs_info->fs_devices->total_rw_bytes) {
>                 btrfs_err(fs_info,
>         "super_total_bytes %llu mismatch with fs_devices total_rw_bytes
> %llu",
>                           btrfs_super_total_bytes(fs_info->super_copy),
>                           fs_info->fs_devices->total_rw_bytes);
>                 ret = -EINVAL;
>                 goto error;
>         }
> 
> Doesn't this explain why we abort the mount?

I wouldn't see how, especially if the code doesn't do anything _unless_ it
also prints the message.

When it doesn't produce the message, all it does is compare two numbers
(unless btrfs_super_total_bytes does something very funny) - how does this
explain that the mount fails, then succeeds, in the cases where the message
is _not_ logged, as reported?

> > Also, shouldn't btrfs be fixed instead? I was under the impression that
> > one of the goals of btrfs is to be safe w.r.t. crashes.
> 
> That's why we provide the btrfs rescue fix-device-size.

Not sure how that follows - there is a bug in the kernel filesystem and
you provide a userspace tool that should be run on every crash, to what
end?

Spurious mount failures are a bug in the btrfs kernel driver.

> > The bug I reported has very little or nothing to with strict checking.
> 
> I have provide the code to prove why it's related.

The code proves only that you are wrong - the code _always_ prints the
message. Unless btrfs_super_total_bytes does more than just read some
data, it cannot explain the bug I reported, simply because the message is
not always produced, and the mount is not always aborted.

> Whether you believe is your problem then.

No, it's not, simply because I don't have a problem...

btrfs has problems, and I reported one, that's all that has happened.

I slowly get the distinct feeling that reporting bugs in btrfs us a futile
exercise, though.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
