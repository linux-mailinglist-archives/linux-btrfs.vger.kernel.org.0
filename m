Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97083C6049
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jul 2021 18:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhGLQTL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jul 2021 12:19:11 -0400
Received: from smtp01.belwue.de ([129.143.71.86]:49154 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhGLQTJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jul 2021 12:19:09 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id 32543CBBD
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jul 2021 18:16:19 +0200 (MEST)
Date:   Mon, 12 Jul 2021 18:16:18 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: cannot use btrfs for nfs server
Message-ID: <20210712161618.GA913@tik.uni-stuttgart.de>
Mail-Followup-To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
 <20210311074636.GA28705@tik.uni-stuttgart.de>
 <20210708221731.GB8249@tik.uni-stuttgart.de>
 <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
 <20210709065320.GC8249@tik.uni-stuttgart.de>
 <CAJCQCtQvak-28B7eUf5zRnAeGK27qZaF-1ZZt=OAHk+2KmfsWQ@mail.gmail.com>
 <20210710065612.GF1548@tik.uni-stuttgart.de>
 <CAJCQCtQn0=8KiB=2garN8k2NRd1PO3HBnrMNvmqssSfKT2-UXQ@mail.gmail.com>
 <20210712072525.GI1548@tik.uni-stuttgart.de>
 <294e8449-383f-1c90-62be-fb618332862e@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <294e8449-383f-1c90-62be-fb618332862e@cobb.uk.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon 2021-07-12 (14:06), Graham Cobb wrote:

> >>> root@tsmsrvj:# snaprotate -v test 5 /data/fex/spool
> >>> $ btrfs subvolume snapshot -r /data/fex/spool /data/fex/spool/.snapshot/2021-07-10_0849.test
> >>> Create a readonly snapshot of '/data/fex/spool' in '/data/fex/spool/.snapshot/2021-07-10_0849.test'
> >>
> >> I think this might be the source of the problem. Nested snapshots are
> >> not a good idea, it causes various kinds of confusion.
> > 
> > I do not have nested snapshots anywhere.
> > /data/fex/spool is not a snapshot.
> 
> But it is the subvolume which is being snapshotted. What happens if you
> put the snapshots somewhere that is not part of that subvolume? For
> example, create /data/fex/snapshots, snapshot /data/fex/spool into a
> snapshot in /data/fex/snapshots/spool/2021-07-10_0849.test, export
> /data/fex/snapshots using NFS and mount /data/fex/snapshots on the client?

Same problem:

root@tsmsrvj:/etc# mount | grep data
/dev/sdb1 on /data type btrfs (rw,relatime,space_cache,user_subvol_rm_allowed,subvolid=5,subvol=/)

root@tsmsrvj:/etc# mkdir /data/snapshots /nfs/localhost/snapshots

root@tsmsrvj:/etc# btrfs subvolume snapshot -r /data/fex/spool /data/snapshots/fex_1
Create a readonly snapshot of '/data/fex/spool' in '/data/snapshots/fex_1'

root@tsmsrvj:/etc# btrfs subvolume snapshot -r /data/fex/spool /data/snapshots/fex_2
Create a readonly snapshot of '/data/fex/spool' in '/data/snapshots/fex_2'

root@tsmsrvj:/etc# btrfs subvolume list /data
ID 257 gen 1558 top level 5 path fex
ID 270 gen 1557 top level 257 path fex/spool
ID 272 gen 23 top level 270 path fex/spool/.snapshot/2021-03-07_1531.test
ID 273 gen 25 top level 270 path fex/spool/.snapshot/2021-03-07_1532.test
ID 274 gen 27 top level 270 path fex/spool/.snapshot/2021-03-07_1718.test
ID 394 gen 1470 top level 270 path fex/spool/.snapshot/2021-07-10_0849.test
ID 399 gen 1554 top level 270 path fex/spool/.snapshot/2021-07-12_1747.test
ID 400 gen 1556 top level 5 path snapshots/fex_1
ID 401 gen 1557 top level 5 path snapshots/fex_2

root@tsmsrvj:/etc# grep localhost /etc/exports 
/data/fex       localhost(rw,async,no_subtree_check,no_root_squash,crossmnt)
/data/snapshots localhost(rw,async,no_subtree_check,no_root_squash,crossmnt)

## ==> no nested subvolumes! different nfs exports

root@tsmsrvj:/etc# mount -o vers=3 localhost:/data/fex /nfs/localhost/fex
root@tsmsrvj:/etc# mount | grep localhost
localhost:/data/fex on /nfs/localhost/fex type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=127.0.0.1,mountvers=3,mountport=37961,mountproto=udp,local_lock=none,addr=127.0.0.1)

root@tsmsrvj:/etc# mount -o vers=3 localhost:/data/snapshots /nfs/localhost/snapshots
root@tsmsrvj:/etc# mount | grep localhost
localhost:/data/fex on /nfs/localhost/fex type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=127.0.0.1,mountvers=3,mountport=37961,mountproto=udp,local_lock=none,addr=127.0.0.1)
localhost:/data/fex on /nfs/localhost/snapshots type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=127.0.0.1,mountvers=3,mountport=37961,mountproto=udp,local_lock=none,addr=127.0.0.1)

## why localhost:/data/fex twice??

root@tsmsrvj:/etc# du -Hs /nfs/localhost/snapshots
du: WARNING: Circular directory structure.
This almost certainly means that you have a corrupted file system.
NOTIFY YOUR SYSTEM MANAGER.
The following directory is part of the cycle:
  /nfs/localhost/snapshots/spool

51425792        /nfs/localhost/snapshots



> >>> We cannot move the snapshots to a different directory. Our workflow
> >>> depends on snaprotate:
> >>>
> >>> http://fex.belwue.de/linuxtools/snaprotate.html
> 
> Won't snaprotate follow softlinks? ln -s /data/fex/snapshots
> /data/fex/spool/.snapshot

Yes, it does, the snapshot storage place is just a simple directory, it
does not have to be a subvolume. So, a symbolic links is ok, but it does
not help, see above.


> My server snapshots data subvolumes into a different part of the tree
> (in my case I use btrbk) and exports them to clients and the clients can
> access all the snapshots over NFS perfectly well.

It does not work in my test evironment with Ubuntu 20.04 and btrfs 5.4.1 

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<294e8449-383f-1c90-62be-fb618332862e@cobb.uk.net>
