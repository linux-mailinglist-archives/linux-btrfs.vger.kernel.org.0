Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441E2333721
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 09:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhCJIRL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 03:17:11 -0500
Received: from smtp01.belwue.de ([129.143.71.86]:35611 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231378AbhCJIRF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 03:17:05 -0500
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id 1AA2E6B19
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 09:17:04 +0100 (MET)
Date:   Wed, 10 Mar 2021 09:17:03 +0100
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: nfs subvolume access?
Message-ID: <20210310081703.GC2158@tik.uni-stuttgart.de>
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
> 1

> tsmsrvi and tsmsrvj (nfs client and server) both run Ubuntu 20.04 with
> btrfs-progs v5.4.1 

On Ubuntu 18.04 this setup works without errors:

root@mutter:/backup/rsync# grep tandem /etc/exports 
/backup/rsync/tandem            176.9.135.138(rw,async,no_subtree_check,no_root_squash)

root@mutter:/backup/rsync# btrfs subvolume list /backup/rsync | grep tandem
ID 257 gen 62652 top level 5 path tandem
ID 5898 gen 62284 top level 257 path tandem/.snapshot/2021-03-01_0300.rsync
ID 5906 gen 62284 top level 257 path tandem/.snapshot/2021-03-02_0300.rsync
ID 5914 gen 62284 top level 257 path tandem/.snapshot/2021-03-03_0300.rsync
ID 5924 gen 62284 top level 257 path tandem/.snapshot/2021-03-04_0300.rsync
ID 5932 gen 62284 top level 257 path tandem/.snapshot/2021-03-05_0300.rsync
ID 5941 gen 62284 top level 257 path tandem/.snapshot/2021-03-06_0300.rsync
ID 5950 gen 62284 top level 257 path tandem/.snapshot/2021-03-07_0300.rsync
ID 5962 gen 62413 top level 257 path tandem/.snapshot/2021-03-08_0300.rsync
ID 5970 gen 62522 top level 257 path tandem/.snapshot/2021-03-09_0300.rsync
ID 5978 gen 62626 top level 257 path tandem/.snapshot/2021-03-10_0300.rsync

root@mutter:/backup/rsync# btrfs version
btrfs-progs v4.15.1

root@tandem:/backup# mount | grep backup
mutter:/backup/rsync/tandem on /backup type nfs (ro,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,timeo=600,retrans=1,sec=sys,mountaddr=176.9.68.251,mountvers=3,mountport=52943,mountproto=tcp,local_lock=none,addr=176.9.68.251)

root@tandem:/backup# ls -l .snapshot/
total 0
drwxr-xr-x 1 root root 392 Mar  1 03:00 2021-03-01_0300.rsync
drwxr-xr-x 1 root root 392 Mar  2 03:00 2021-03-02_0300.rsync
drwxr-xr-x 1 root root 392 Mar  3 03:00 2021-03-03_0300.rsync
drwxr-xr-x 1 root root 392 Mar  4 03:00 2021-03-04_0300.rsync
drwxr-xr-x 1 root root 392 Mar  5 03:00 2021-03-05_0300.rsync
drwxr-xr-x 1 root root 392 Mar  6 03:00 2021-03-06_0300.rsync
drwxr-xr-x 1 root root 392 Mar  7 03:00 2021-03-07_0300.rsync
drwxr-xr-x 1 root root 392 Mar  8 03:00 2021-03-08_0300.rsync
drwxr-xr-x 1 root root 392 Mar  9 03:00 2021-03-09_0300.rsync
drwxr-xr-x 1 root root 392 Mar 10 03:00 2021-03-10_0300.rsync

So, it is an issue with the newer btrfs version on Ubuntu 20.04? 


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20210310074620.GA2158@tik.uni-stuttgart.de>
