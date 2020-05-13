Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176201D069F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 07:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgEMFou convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 13 May 2020 01:44:50 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35744 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbgEMFou (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 01:44:50 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id A3AFE6BF314; Wed, 13 May 2020 01:44:48 -0400 (EDT)
Date:   Wed, 13 May 2020 01:44:48 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     rollojobs@partyheld.de
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: balance pause and resume seems not to work properly
Message-ID: <20200513054447.GZ10769@hungrycats.org>
References: <trinity-0c1fb57e-51b6-46ae-b8a3-b420c56db240-1588188494837@3c-app-gmx-bs35>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <trinity-0c1fb57e-51b6-46ae-b8a3-b420c56db240-1588188494837@3c-app-gmx-bs35>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 29, 2020 at 09:28:14PM +0200, rollojobs@partyheld.de wrote:
> Hi,
> I created a filesystem of two drives (6TB and 750GB) with both data and metadata raid 1. Then I put a couple of gigs on it and added a 2TB drive. After balancing, the small drive should be empty and the two large drives should have all the data. But this doesn't work if balance is paused and resumed.
> 
> I startet balance with:
> btrfs balance start --bg /srv/dev-disk-by-label-BTRFS1/
> 
> and then watched status:
> Balance on '/srv/dev-disk-by-label-BTRFS1/' is running
> 3 out of about 14 chunks balanced (4 considered),  79% left  
> 
> At this point I paused and then resumed.
> 
> btrfs balance pause /srv/dev-disk-by-label-BTRFS1/
> btrfs balance resume /srv/dev-disk-by-label-BTRFS1/
> 
> And then I get this balance status:
> 0 out of about 3 chunks balanced (1 considered), 100% left
> Balance on '/srv/dev-disk-by-label-BTRFS1/' is running
> 
> Why it's not 11 chunks but 3? It finished with:
> 
> Done, had to relocate 3 out of 14 chunks
> 
> and I've got this distribution:
> 
> Label: 'BTRFS1'  uuid: 61e5aba9-6811-46ae-9396-35a72d3b1117
>         Total devices 3 FS bytes used 11.13GiB
>         devid    1 size 5.46TiB used 13.03GiB path /dev/sdc1
>         devid    3 size 698.64GiB used 4.00GiB path /dev/sdf
>         devid    4 size 1.82TiB used 9.03GiB path /dev/sde
> 
> 
> As it's raid 1, device 3 should be empty after finishing balance. Running balance without pause comfirms that:
> 
> Label: 'BTRFS1'  uuid: 61e5aba9-6811-46ae-9396-35a72d3b1117
>         Total devices 3 FS bytes used 11.13GiB
>         devid    1 size 5.46TiB used 13.03GiB path /dev/sdc1
>         devid    3 size 698.64GiB used 0.00B path /dev/sdf
>         devid    4 size 1.82TiB used 13.03GiB path /dev/sde  
> 
> That means, balance doesn't work properly after pause and resume?

Yes, balance resume has been broken since the beginning.

The offending code is:

commit 596410151ed71819b9e8a8018c6c9992796b256d
Author: Ilya Dryomov <idryomov@gmail.com>
Date:   Mon Jan 16 22:04:48 2012 +0200

    Btrfs: recover balance on mount

+/*
+ * This is a heuristic used to reduce the number of chunks balanced on
+ * resume after balance was interrupted.
+ */
+static void update_balance_args(struct btrfs_balance_control *bctl)
+{
+       /*
+        * Turn on soft mode for chunk types that were being converted.
+        */
+       if (bctl->data.flags & BTRFS_BALANCE_ARGS_CONVERT)
+               bctl->data.flags |= BTRFS_BALANCE_ARGS_SOFT;
+       if (bctl->sys.flags & BTRFS_BALANCE_ARGS_CONVERT)
+               bctl->sys.flags |= BTRFS_BALANCE_ARGS_SOFT;
+       if (bctl->meta.flags & BTRFS_BALANCE_ARGS_CONVERT)
+               bctl->meta.flags |= BTRFS_BALANCE_ARGS_SOFT;
+
+       /*
+        * Turn on usage filter if is not already used.  The idea is
+        * that chunks that we have already balanced should be
+        * reasonably full.  Don't do it for chunks that are being
+        * converted - that will keep us from relocating unconverted
+        * (albeit full) chunks.
+        */
+       if (!(bctl->data.flags & BTRFS_BALANCE_ARGS_USAGE) &&
+           !(bctl->data.flags & BTRFS_BALANCE_ARGS_CONVERT)) {
+               bctl->data.flags |= BTRFS_BALANCE_ARGS_USAGE;
+               bctl->data.usage = 90;
+       }
+       if (!(bctl->sys.flags & BTRFS_BALANCE_ARGS_USAGE) &&
+           !(bctl->sys.flags & BTRFS_BALANCE_ARGS_CONVERT)) {
+               bctl->sys.flags |= BTRFS_BALANCE_ARGS_USAGE;
+               bctl->sys.usage = 90;
+       }
+       if (!(bctl->meta.flags & BTRFS_BALANCE_ARGS_USAGE) &&
+           !(bctl->meta.flags & BTRFS_BALANCE_ARGS_CONVERT)) {
+               bctl->meta.flags |= BTRFS_BALANCE_ARGS_USAGE;
+               bctl->meta.usage = 90;
+       }
+}
+

At this point I was going to say this code couldn't use the VRANGE filter
to resume balance because the commit predates the VRANGE filter but,
well, it doesn't.  VRANGE was added in this commit, which came after
the above:

commit ea67176ae8c024f64d85ec33873e5eadf1af7247
Author: Ilya Dryomov <idryomov@gmail.com>
Date:   Mon Jan 16 22:04:48 2012 +0200

    Btrfs: virtual address space subset filter

What balance _should_ do is update the upper limit of the vrange filter
(turning it on if not supplied) every time a block group is finished
(i.e. the balance filter would reset the upper limit of vrange every
time a block group was completed).  This is currently done with the
limit filter.  Then a resume would actually resume the balance, and
the above code can be removed.

What balance resume does now is start a completely new balance with the
wrong filter arguments.

> I'm running
> btrfs-progs v4.20.1
> 5.4.0-0.bpo.4-amd64
> 
> Best Regards
