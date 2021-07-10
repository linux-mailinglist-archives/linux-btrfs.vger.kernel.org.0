Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486463C3353
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jul 2021 08:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhGJG66 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Jul 2021 02:58:58 -0400
Received: from smtp01.belwue.de ([129.143.71.86]:36590 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhGJG65 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Jul 2021 02:58:57 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id 5A78B6114
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Jul 2021 08:56:12 +0200 (MEST)
Date:   Sat, 10 Jul 2021 08:56:12 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: cannot use btrfs for nfs server
Message-ID: <20210710065612.GF1548@tik.uni-stuttgart.de>
Mail-Followup-To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
 <20210311074636.GA28705@tik.uni-stuttgart.de>
 <20210708221731.GB8249@tik.uni-stuttgart.de>
 <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
 <20210709065320.GC8249@tik.uni-stuttgart.de>
 <CAJCQCtQvak-28B7eUf5zRnAeGK27qZaF-1ZZt=OAHk+2KmfsWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtQvak-28B7eUf5zRnAeGK27qZaF-1ZZt=OAHk+2KmfsWQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri 2021-07-09 (10:35), Chris Murphy wrote:

> But I don't really understand your workflow, or what the fstab or
> subvolume setup looks like. Are you able to share the cron job script,
> the fstab, and the full subvolume listing? btrfs subvolume list -ta
> /nfs/localhost/fex ?

/nfs/localhost/fex is just a test setup on a test server.
The production server does not use nfs so far, but we plan to migrate from
local disks to nfs. But before we do it, btrfs via nfs MUST work without
problems and error messages.

/nfs/localhost/fex is not in /etc/fstab, I have mounted it manually, as I
wrote in my previous mails. It is just a test.


root@tsmsrvj:# grep local /etc/exports 
/data/fex       localhost(rw,async,no_subtree_check,no_root_squash,fsid=20000001)

root@tsmsrvj:# mount -v localhost:/data/fex /nfs/localhost/fex
mount.nfs: timeout set for Sat Jul 10 08:47:57 2021
mount.nfs: trying text-based options 'vers=4.2,addr=127.0.0.1,clientaddr=127.0.0.1'

root@tsmsrvj:# snaprotate -v test 5 /data/fex/spool
$ btrfs subvolume snapshot -r /data/fex/spool /data/fex/spool/.snapshot/2021-07-10_0849.test
Create a readonly snapshot of '/data/fex/spool' in '/data/fex/spool/.snapshot/2021-07-10_0849.test'

root@tsmsrvj:# snaprotate -l
/data/fex/spool/.snapshot/2021-03-07_1453.test
/data/fex/spool/.snapshot/2021-03-07_1531.test
/data/fex/spool/.snapshot/2021-03-07_1532.test
/data/fex/spool/.snapshot/2021-03-07_1718.test
/data/fex/spool/.snapshot/2021-07-10_0849.test

root@tsmsrvj:# btrfs subvolume list /data
ID 257 gen 1466 top level 5 path fex
ID 270 gen 1471 top level 257 path fex/spool
ID 271 gen 21 top level 270 path fex/spool/.snapshot/2021-03-07_1453.test
ID 272 gen 23 top level 270 path fex/spool/.snapshot/2021-03-07_1531.test
ID 273 gen 25 top level 270 path fex/spool/.snapshot/2021-03-07_1532.test
ID 274 gen 27 top level 270 path fex/spool/.snapshot/2021-03-07_1718.test
ID 394 gen 1470 top level 270 path fex/spool/.snapshot/2021-07-10_0849.test




We cannot move the snapshots to a different directory. Our workflow
depends on snaprotate:

http://fex.belwue.de/linuxtools/snaprotate.html



-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<CAJCQCtQvak-28B7eUf5zRnAeGK27qZaF-1ZZt=OAHk+2KmfsWQ@mail.gmail.com>
