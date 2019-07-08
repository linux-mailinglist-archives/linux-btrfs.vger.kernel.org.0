Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE97A61BE9
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2019 10:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfGHIsq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jul 2019 04:48:46 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:44187 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbfGHIsp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jul 2019 04:48:45 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id E353E84C3
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2019 10:48:21 +0200 (MEST)
Date:   Mon, 8 Jul 2019 10:48:21 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: understanding SUSE / setup
Message-ID: <20190708084821.GB15143@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


I am still trying to understand the default / btrfs setup on SUSE:

root@trulla:/# lsb_release -d
Description:    SUSE Linux Enterprise Server 12 SP3

root@trulla:/# btrfs subvolume list -uq /
ID 257 gen 2273953 top level 5 parent_uuid - uuid 294f484f-7ac6-ac4d-8b8b-953b377a3880 path @
ID 258 gen 2273926 top level 257 parent_uuid - uuid 99be1ca4-d2af-2b47-b307-bf4c3f1be827 path @/home
ID 259 gen 2273951 top level 257 parent_uuid - uuid b46984a3-7cac-f240-b007-be36fd6db242 path @/opt
ID 260 gen 2273926 top level 257 parent_uuid - uuid 885fc07c-5590-184a-a4cf-85c6afb75412 path @/srv
ID 261 gen 2273961 top level 257 parent_uuid - uuid 1e6d55c2-0486-a742-a9d3-fc4f105d6508 path @/tmp
ID 262 gen 2273926 top level 257 parent_uuid - uuid 72ce86ca-eec5-e843-a25b-79a09a30ca2d path @/usr/local
ID 263 gen 2273953 top level 257 parent_uuid - uuid 8d20fda0-94bc-1442-9640-d12daac5c609 path @/var/crash
ID 264 gen 2273954 top level 257 parent_uuid - uuid d1d833fa-c4a1-994f-9db5-23a853a0573f path @/var/log
ID 265 gen 2273953 top level 257 parent_uuid - uuid b98cc10f-a0cc-f34a-9b25-921131c0388c path @/var/opt
ID 266 gen 2273960 top level 257 parent_uuid - uuid da8cc066-b3a3-3941-b6f8-7a29f73fd673 path @/var/spool
ID 267 gen 2273953 top level 257 parent_uuid - uuid 5d791fa4-0b5f-f748-aff2-0944cb58c51d path @/var/tmp
ID 270 gen 2272607 top level 257 parent_uuid - uuid bbef7f0f-1270-9a43-89ca-b4f909968f87 path @/.snapshots
ID 453 gen 2273960 top level 270 parent_uuid d2f6c896-ff9a-2f4c-b60f-7d0e20ab834c uuid c85dc50a-b126-1441-bddd-2832afac58d2 path @/.snapshots/128/snapshot
ID 12392 gen 2123118 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid aa3b38f3-e536-424d-ab58-b82fba646f9f path @/.snapshots/1065/snapshot
ID 12393 gen 2123120 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid 76cc605b-49a3-cc43-8557-8d0b2cb2d5ec path @/.snapshots/1066/snapshot
ID 13273 gen 2176640 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid fc4ef295-4566-084f-a570-ab918a134c4e path @/.snapshots/1089/snapshot
ID 13274 gen 2176651 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid b1cb09a9-8df6-2d41-9e97-564699e88029 path @/.snapshots/1090/snapshot
ID 13553 gen 2203681 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid 9d6607df-bb48-9e46-842d-cacc23fd74b5 path @/.snapshots/1103/snapshot
ID 13554 gen 2203681 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid 0fcc5335-3324-7144-84d4-a3cc0327be83 path @/.snapshots/1104/snapshot
ID 13581 gen 2203681 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid 212faa53-56ba-4343-83ae-3a4c35ee5620 path @/.snapshots/1107/snapshot
ID 13582 gen 2203681 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid 6be47a20-d8cf-cc48-81e3-c8b55c7e07bd path @/.snapshots/1108/snapshot
ID 14395 gen 2256089 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid b900b1f6-e8fc-444a-be5f-424fde9ed3a6 path @/.snapshots/1127/snapshot
ID 14396 gen 2256089 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid 3e9b136b-3b17-b04b-bbca-7f9220f6aafd path @/.snapshots/1128/snapshot
ID 14498 gen 2256089 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid 743746ec-2351-c54f-a242-07753b28a3bf path @/.snapshots/1131/snapshot
ID 14499 gen 2256089 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid 81c976f5-d809-6d43-b987-a6cdfca3858a path @/.snapshots/1132/snapshot
ID 14500 gen 2266578 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid 517a128f-45eb-f94e-8f74-09eb46c11d40 path @/.snapshots/1133/snapshot
ID 14501 gen 2266578 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid 68bcda1c-6443-2946-bde7-fc1e71a86b41 path @/.snapshots/1134/snapshot
ID 14525 gen 2266578 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid 7aa0cfc8-1537-8046-a623-57c19afad137 path @/.snapshots/1135/snapshot
ID 14526 gen 2266578 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid e82b77b9-5b26-de41-a146-6beb183b659f path @/.snapshots/1136/snapshot
ID 14772 gen 2266672 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid 8aa29fc4-9316-254a-9011-6d367bda2d1b path @/.snapshots/1137/snapshot
ID 14773 gen 2266674 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid 7b99efcb-86e2-344f-8342-88c94f29de2a path @/.snapshots/1138/snapshot
ID 14793 gen 2267857 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid ef9863a4-ff82-c947-8147-a9fa492335f8 path @/.snapshots/1139/snapshot
ID 14794 gen 2267862 top level 270 parent_uuid c85dc50a-b126-1441-bddd-2832afac58d2 uuid 3dc9f4b7-cd4c-3040-9733-da633abd37f6 path @/.snapshots/1140/snapshot

root@trulla:/# mount -o subvol=/ /dev/sda2 /mnt/_

root@trulla:/# btrfs subvolume show /mnt/_
/mnt/_ is toplevel subvolume

root@trulla:/# ll /mnt/_/
drwxr-xr-x  root     root     - 2019-07-08 09:53:23 /mnt/_/@

subvol=/ contains only one subdirectory named @ with everything inside:

root@trulla:/# du -s /mnt/_/@/*
5156    /mnt/_/@/bin
21056   /mnt/_/@/boot
3156    /mnt/_/@/busybox
0       /mnt/_/@/dev
14096   /mnt/_/@/etc
32      /mnt/_/@/home
188388  /mnt/_/@/lib
14828   /mnt/_/@/lib64
0       /mnt/_/@/mnt
1679808 /mnt/_/@/opt
0       /mnt/_/@/proc
464     /mnt/_/@/root
0       /mnt/_/@/run
10540   /mnt/_/@/sbin
0       /mnt/_/@/selinux
0       /mnt/_/@/srv
0       /mnt/_/@/sys
8       /mnt/_/@/tmp
1320328 /mnt/_/@/usr
572796  /mnt/_/@/var

root@trulla:/# btrfs subvolume get-default /
ID 453 gen 2273956 top level 270 path @/.snapshots/128/snapshot

root@trulla:/# btrfs subvolume show / | grep UUID
        UUID:                   c85dc50a-b126-1441-bddd-2832afac58d2
        Parent UUID:            d2f6c896-ff9a-2f4c-b60f-7d0e20ab834c


parent_uuid d2f6c896-ff9a-2f4c-b60f-7d0e20ab834c uuid c85dc50a-b126-1441-bddd-2832afac58d2 path @/.snapshots/128/snapshot

All (snapper) snapshots have @/.snapshots/128/snapshot as parent which is
the default / subvolme
But what/where is subvolume with UUID d2f6c896-ff9a-2f4c-b60f-7d0e20ab834c?
Was it the installation subvolume which has been deleted afterwards?

The subvolume @ is not default mounted - why?
It uses disk space (/lib /lib64 ...) but it does not get updated?

root@trulla:/# l -Rrt /mnt/_/@/lib/ | grep -v ^d|tail -3
-RW-             573,168 2015-09-24 12:16 /mnt/_/@/lib/modules/3.12.44-52.18-default/modules.alias.bin
-RW-             603,413 2015-09-24 12:16 /mnt/_/@/lib/modules/3.12.44-52.18-default/modules.alias
l---                   - 2015-09-24 12:16 /mnt/_/@/lib/modules/3.12.44-52.18-default/weak-updates/updates/crash.ko -> /lib/modules/3.12.28-4-default/updates/crash.ko

root@trulla:/# l -Rrt /lib/ | grep -v ^d|tail -3
-RW-             680,805 2019-06-18 11:42 /lib/modules/4.4.180-94.97-default/modules.alias.bin
-RW-             723,956 2019-06-18 11:42 /lib/modules/4.4.180-94.97-default/modules.alias
lRW-                   - 2019-06-18 11:42 /lib/modules/4.4.180-94.97-default/weak-updates/updates/crash.ko -> /lib/modules/4.4.175-94.79-default/updates/crash.ko

So, it uses disk space, which cannot be freed?


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20190708084821.GB15143@tik.uni-stuttgart.de>
