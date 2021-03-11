Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4725B336D3F
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 08:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhCKHrP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 02:47:15 -0500
Received: from smtp02.belwue.de ([129.143.71.87]:62206 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229830AbhCKHqn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 02:46:43 -0500
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id 12FA841D3
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 08:46:37 +0100 (MET)
Date:   Thu, 11 Mar 2021 08:46:36 +0100
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: nfs subvolume access?
Message-ID: <20210311074636.GA28705@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310074620.GA2158@tik.uni-stuttgart.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed 2021-03-10 (08:46), Ulli Horlacher wrote:
> When I try to access a btrfs filesystem via nfs, I get the error:
> 
> root@tsmsrvi:~# mount tsmsrvj:/data/fex /nfs/tsmsrvj/fex
> root@tsmsrvi:~# time find /nfs/tsmsrvj/fex | wc -l
> find: File system loop detected; '/nfs/tsmsrvj/fex/spool' is part of the same file system loop as '/nfs/tsmsrvj/fex'.

It is even worse:

root@tsmsrvj:# grep localhost /etc/exports
/data/fex       localhost(rw,async,no_subtree_check,no_root_squash)

root@tsmsrvj:# mount localhost:/data/fex /nfs/localhost/fex

root@tsmsrvj:# du -s /data/fex
64282240        /data/fex

root@tsmsrvj:# du -s /nfs/localhost/fex
du: WARNING: Circular directory structure.
This almost certainly means that you have a corrupted file system.
NOTIFY YOUR SYSTEM MANAGER.
The following directory is part of the cycle:
  /nfs/localhost/fex/spool

0       /nfs/localhost/fex

root@tsmsrvj:# btrfs subvolume list /data
ID 257 gen 42 top level 5 path fex
ID 270 gen 42 top level 257 path fex/spool
ID 271 gen 21 top level 270 path fex/spool/.snapshot/2021-03-07_1453.test
ID 272 gen 23 top level 270 path fex/spool/.snapshot/2021-03-07_1531.test
ID 273 gen 25 top level 270 path fex/spool/.snapshot/2021-03-07_1532.test
ID 274 gen 27 top level 270 path fex/spool/.snapshot/2021-03-07_1718.test

root@tsmsrvj:# uname -a
Linux tsmsrvj 5.4.0-66-generic #74-Ubuntu SMP Wed Jan 27 22:54:38 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

root@tsmsrvj:# btrfs version
btrfs-progs v5.4.1

root@tsmsrvj:# dpkg -l | grep nfs-
ii  nfs-common                             1:1.3.4-2.5ubuntu3.3              amd64        NFS support files common to client and server
ii  nfs-kernel-server                      1:1.3.4-2.5ubuntu3.3              amd64        support for NFS kernel server

The same bug appears if nfs server and client are different hosts or the
client is an older Ubuntu 18.04 system.


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20210310074620.GA2158@tik.uni-stuttgart.de>
