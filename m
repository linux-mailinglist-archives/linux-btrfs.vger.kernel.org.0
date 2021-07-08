Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910913C1B64
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 00:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhGHWUP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 18:20:15 -0400
Received: from smtp01.belwue.de ([129.143.71.86]:48426 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhGHWUP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Jul 2021 18:20:15 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id 9A3FB6097
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 00:17:31 +0200 (MEST)
Date:   Fri, 9 Jul 2021 00:17:31 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: cannot use btrfs for nfs server
Message-ID: <20210708221731.GB8249@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
 <20210311074636.GA28705@tik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311074636.GA28705@tik.uni-stuttgart.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


I have waited some time and some Ubuntu updates, but the bug is still there:

On Thu 2021-03-11 (08:46), Ulli Horlacher wrote:
> On Wed 2021-03-10 (08:46), Ulli Horlacher wrote:
> 
> > When I try to access a btrfs filesystem via nfs, I get the error:
> > 
> > root@tsmsrvi:~# mount tsmsrvj:/data/fex /nfs/tsmsrvj/fex
> > root@tsmsrvi:~# time find /nfs/tsmsrvj/fex | wc -l
> > find: File system loop detected; '/nfs/tsmsrvj/fex/spool' is part of the same file system loop as '/nfs/tsmsrvj/fex'.
> 
> It is even worse:
> 
> root@tsmsrvj:# grep localhost /etc/exports
> /data/fex       localhost(rw,async,no_subtree_check,no_root_squash)
> 
> root@tsmsrvj:# mount localhost:/data/fex /nfs/localhost/fex
> 
> root@tsmsrvj:# du -s /data/fex
> 64282240        /data/fex
> 
> root@tsmsrvj:# du -s /nfs/localhost/fex
> du: WARNING: Circular directory structure.
> This almost certainly means that you have a corrupted file system.
> NOTIFY YOUR SYSTEM MANAGER.
> The following directory is part of the cycle:
>   /nfs/localhost/fex/spool
> 
> 0       /nfs/localhost/fex
> 
> root@tsmsrvj:# btrfs subvolume list /data
> ID 257 gen 42 top level 5 path fex
> ID 270 gen 42 top level 257 path fex/spool
> ID 271 gen 21 top level 270 path fex/spool/.snapshot/2021-03-07_1453.test
> ID 272 gen 23 top level 270 path fex/spool/.snapshot/2021-03-07_1531.test
> ID 273 gen 25 top level 270 path fex/spool/.snapshot/2021-03-07_1532.test
> ID 274 gen 27 top level 270 path fex/spool/.snapshot/2021-03-07_1718.test

root@tsmsrvj:~# uname -a
Linux tsmsrvj 5.4.0-77-generic #86-Ubuntu SMP Thu Jun 17 02:35:03 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

root@tsmsrvj:~# btrfs version
btrfs-progs v5.4.1

root@tsmsrvj:~# dpkg -l | grep nfs-
ii  nfs-common                             1:1.3.4-2.5ubuntu3.4              amd64        NFS support files common to client and server
ii  nfs-kernel-server                      1:1.3.4-2.5ubuntu3.4              amd64        support for NFS kernel server

This makes btrfs with snapshots unusable as a nfs server :-(

How/where can I escalate it further?

My Ubuntu bug report has been ignored :-(

https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/1918599

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20210311074636.GA28705@tik.uni-stuttgart.de>
