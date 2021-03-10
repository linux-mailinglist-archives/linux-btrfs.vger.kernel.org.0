Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352383336B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 08:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhCJHzC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 02:55:02 -0500
Received: from smtp01.belwue.de ([129.143.71.86]:64475 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhCJHzC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 02:55:02 -0500
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Mar 2021 02:55:02 EST
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id ADB4AC6D2
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 08:46:20 +0100 (MET)
Date:   Wed, 10 Mar 2021 08:46:20 +0100
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: nfs subvolume access?
Message-ID: <20210310074620.GA2158@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When I try to access a btrfs filesystem via nfs, I get the error:

root@tsmsrvi:~# mount tsmsrvj:/data/fex /nfs/tsmsrvj/fex
root@tsmsrvi:~# time find /nfs/tsmsrvj/fex | wc -l
find: File system loop detected; '/nfs/tsmsrvj/fex/spool' is part of the same file system loop as '/nfs/tsmsrvj/fex'.
1
root@tsmsrvi:~# 



On tsmsrvj I have in /etc/exports:

/data/fex       tsmsrvi(rw,async,no_subtree_check,no_root_squash)

This is a btrfs subvolume with snapshots:

root@tsmsrvj:~# btrfs subvolume list /data
ID 257 gen 35 top level 5 path fex
ID 270 gen 36 top level 257 path fex/spool
ID 271 gen 21 top level 270 path fex/spool/.snapshot/2021-03-07_1453.test
ID 272 gen 23 top level 270 path fex/spool/.snapshot/2021-03-07_1531.test
ID 273 gen 25 top level 270 path fex/spool/.snapshot/2021-03-07_1532.test
ID 274 gen 27 top level 270 path fex/spool/.snapshot/2021-03-07_1718.test

root@tsmsrvj:~# find /data/fex | wc -l
489887
root@tsmsrvj:~# 

What must I add to /etc/exports to enable subvolume access for the nfs
client?

tsmsrvi and tsmsrvj (nfs client and server) both run Ubuntu 20.04 with
btrfs-progs v5.4.1 

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20210310074620.GA2158@tik.uni-stuttgart.de>
