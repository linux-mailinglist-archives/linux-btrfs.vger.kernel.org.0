Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EAA334582
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 18:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhCJRrC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 12:47:02 -0500
Received: from smtp02.belwue.de ([129.143.71.87]:40845 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233339AbhCJRqe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 12:46:34 -0500
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id 5DF925108
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 18:46:30 +0100 (MET)
Date:   Wed, 10 Mar 2021 18:46:30 +0100
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: nfs subvolume access?
Message-ID: <20210310174630.GB4408@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
 <20210310075957.GG22502@savella.carfax.org.uk>
 <20210310080940.GB2158@tik.uni-stuttgart.de>
 <5bded122-8adf-e5e7-dceb-37a3875f1a4b@cobb.uk.net>
 <20210310155538.GA4408@tik.uni-stuttgart.de>
 <55bb7f3.9ce44d1.1781d2fedd6@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55bb7f3.9ce44d1.1781d2fedd6@tnonline.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed 2021-03-10 (18:29), Forza wrote:

> Did you try the fsid on the export?

Yes:

root@tsmsrvj:/etc# grep tsm exports 
/data/fex       tsmsrvi(rw,async,no_subtree_check,no_root_squash,fsid=0x0011)

root@tsmsrvj:/etc# exportfs -va
exporting fex.rus.uni-stuttgart.de:/data/fex
exporting tsmsrvi.rus.uni-stuttgart.de:/data/fex


root@tsmsrvi:~# umount /nfs/tsmsrvj/fex

root@tsmsrvi:~# mount -o nfsvers=3,proto=tcp tsmsrvj:/data/fex /nfs/tsmsrvj/fex

root@tsmsrvi:~# find /nfs/tsmsrvj/fex
/nfs/tsmsrvj/fex
find: File system loop detected; '/nfs/tsmsrvj/fex/spool' is part of the same file system loop as '/nfs/tsmsrvj/fex'.



> You may want to enable debug logging on your server.
> https://wiki.tnonline.net/w/Blog/NFS_Server_Logging

root@tsmsrvj:/etc# rpcdebug -m nfsd all
nfsd       sock fh export svc proc fileop auth repcache xdr lockd

root@tsmsrvj:/var/log# tailf kern.log
2021-03-10 18:45:17 [106259.649850] nfsd_dispatch: vers 3 proc 1
2021-03-10 18:45:17 [106259.649854] nfsd: GETATTR(3)  8: 00010001 00000011 00000000 00000000 00000000 00000000
2021-03-10 18:45:17 [106259.649856] nfsd: fh_verify(8: 00010001 00000011 00000000 00000000 00000000 00000000)
2021-03-10 18:45:17 [106259.650306] nfsd_dispatch: vers 3 proc 4
2021-03-10 18:45:17 [106259.650310] nfsd: ACCESS(3)   8: 00010001 00000011 00000000 00000000 00000000 00000000 0x1f
2021-03-10 18:45:17 [106259.650313] nfsd: fh_verify(8: 00010001 00000011 00000000 00000000 00000000 00000000)
2021-03-10 18:45:17 [106259.650869] nfsd_dispatch: vers 3 proc 17
2021-03-10 18:45:17 [106259.650874] nfsd: READDIR+(3) 8: 00010001 00000011 00000000 00000000 00000000 00000000 32768 bytes at 0
2021-03-10 18:45:17 [106259.650877] nfsd: fh_verify(8: 00010001 00000011 00000000 00000000 00000000 00000000)
2021-03-10 18:45:17 [106259.650883] nfsd: fh_verify(8: 00010001 00000011 00000000 00000000 00000000 00000000)
2021-03-10 18:45:17 [106259.650903] nfsd: fh_compose(exp 00:31/256 /fex, ino=256)
2021-03-10 18:45:17 [106259.650907] nfsd: fh_compose(exp 00:31/256 /, ino=256)
2021-03-10 18:45:17 [106259.651454] nfsd_dispatch: vers 3 proc 3
2021-03-10 18:45:17 [106259.651459] nfsd: LOOKUP(3)   8: 00010001 00000011 00000000 00000000 00000000 00000000 spool
2021-03-10 18:45:17 [106259.651463] nfsd: fh_verify(8: 00010001 00000011 00000000 00000000 00000000 00000000)
2021-03-10 18:45:17 [106259.651471] nfsd: nfsd_lookup(fh 8: 00010001 00000011 00000000 00000000 00000000 00000000, spool)
2021-03-10 18:45:17 [106259.651477] nfsd: fh_compose(exp 00:31/256 fex/spool, ino=256)

Hmmm... and now?

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<55bb7f3.9ce44d1.1781d2fedd6@tnonline.net>
