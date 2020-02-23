Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2506B169AFB
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 00:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgBWXmv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Feb 2020 18:42:51 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46234 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726534AbgBWXmv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Feb 2020 18:42:51 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01NNgluE022917
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Feb 2020 18:42:48 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BACA54211EF; Sun, 23 Feb 2020 18:42:46 -0500 (EST)
Date:   Sun, 23 Feb 2020 18:42:46 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs: sleeping function called from invalid context
Message-ID: <20200223234246.GA1208467@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, I noticed this when I was doing some build tests; is this a known issue?

[   74.030154] BUG: sleeping function called from invalid context at mm/slab.h:565
[   74.037763] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 14425, name: dd
[   74.046849] 4 locks held by dd/14425:
[   74.052024]  #0: ffff91960e34f498 (sb_writers#14){.+.+}, at: mnt_want_write+0x20/0x50
[   74.060008]  #1: ffff9195fe328708 (&sb->s_type->i_mutex_key#18){+.+.}, at: do_truncate+0x69/0xd0
[   74.070311]  #2: ffff91960e34f6f8 (sb_internal#2){.+.+}, at: start_transaction+0x3cf/0x550
[   74.078721]  #3: ffff919602d6c740 (btrfs-tree-00){++++}, at: btrfs_tree_lock+0x77/0x270
[   74.088791] CPU: 0 PID: 14425 Comm: dd Not tainted 5.6.0-rc2-xfstests-00009-g9db176bceb5c #1518
[   74.097618] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[   74.106966] Call Trace:
[   74.110926]  dump_stack+0x71/0xa0
[   74.114369]  ___might_sleep.cold+0xa6/0xb6
[   74.118586]  kmem_cache_alloc+0x26f/0x350
[   74.122724]  alloc_extent_state+0x20/0x1a0
[   74.126989]  __clear_extent_bit+0x2f4/0x5c0
[   74.131290]  ? _raw_spin_unlock_irq+0x24/0x30
[   74.135771]  btrfs_truncate_inode_items+0x33e/0xd90
[   74.140769]  ? do_raw_spin_unlock+0x4b/0xc0
[   74.145076]  btrfs_setsize.isra.0+0x203/0x4d0
[   74.149554]  btrfs_setattr+0x5e/0xe0
[   74.153254]  notify_change+0x357/0x4e0
[   74.157120]  do_truncate+0x76/0xd0
[   74.160654]  do_last+0x404/0x860
[   74.164004]  path_openat+0x8f/0x240
[   74.167617]  do_filp_open+0x91/0x100
[   74.171327]  ? do_raw_spin_unlock+0x4b/0xc0
[   74.175650]  ? _raw_spin_unlock+0x1f/0x30
[   74.179778]  do_sys_openat2+0x1fc/0x2a0
[   74.183742]  do_sys_open+0x44/0x80
[   74.187323]  do_syscall_64+0x50/0x1f0
[   74.192500]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   74.197676] RIP: 0033:0x7fd0d67be1ae
[   74.201369] Code: 25 00 00 41 00 3d 00 00 41 00 74 48 48 8d 05 59 65 0d 00 8b 00 85 c0 75 69 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff 0f 87 a6 00 00 00 48 8b 4c 24 28 64 48 33 0c 25
[   74.221644] RSP: 002b:00007fff579e3000 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[   74.229331] RAX: ffffffffffffffda RBX: 000055cbdb1853e0 RCX: 00007fd0d67be1ae
[   74.236586] RDX: 0000000000000241 RSI: 00007fff579e4e2c RDI: 00000000ffffff9c
[   74.243835] RBP: 0000000000000001 R08: 000055cbdb17f2e6 R09: 0000000000000000
[   74.251092] R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000241
[   74.258452] R13: 00007fff579e4e2c R14: 0000000000000001 R15: 00007fff579e32f8

It's causing very large number of xfstests failures:

TESTRUNID: tytso-20200222194637
KERNEL:    kernel 5.6.0-rc2-xfstests-00009-g9db176bceb5c #1518 SMP Fri Feb 21 19:32:23 EST 2020 x86_64
CMDLINE:   -c btrfs -g auto
CPUS:      2
MEM:       7680

btrfs/default: 988 tests, 300 failures, 203 skipped, 8951 seconds
  Failures: btrfs/002 btrfs/004 btrfs/005 btrfs/007 btrfs/013 
    btrfs/014 btrfs/020 btrfs/022 btrfs/024 btrfs/026 btrfs/028 
    btrfs/034 btrfs/037 btrfs/041 btrfs/055 btrfs/056 btrfs/057 
    btrfs/076 btrfs/078 btrfs/080 btrfs/081 btrfs/094 btrfs/095 
    btrfs/096 btrfs/098 btrfs/108 btrfs/109 btrfs/119 btrfs/137 
    btrfs/138 btrfs/139 btrfs/153 btrfs/156 btrfs/159 btrfs/169 
    btrfs/173 btrfs/174 btrfs/177 btrfs/179 btrfs/183 btrfs/188 
    btrfs/191 btrfs/199 btrfs/200 btrfs/201 btrfs/204 generic/001 
    generic/005 generic/006 generic/007 generic/008 generic/009 
    generic/011 generic/013 generic/014 generic/018 generic/027 
    generic/030 generic/032 generic/033 generic/039 generic/040 
    generic/041 generic/056 generic/057 generic/062 generic/066 
    generic/068 generic/070 generic/074 generic/075 generic/076 
    generic/077 generic/078 generic/079 generic/080 generic/083 
    generic/086 generic/087 generic/089 generic/090 generic/091 
    generic/092 generic/093 generic/094 generic/095 generic/096 
    generic/097 generic/099 generic/101 generic/103 generic/104 
    generic/105 generic/107 generic/109 generic/110 generic/112 
    generic/113 generic/114 generic/116 generic/117 generic/118 
    generic/119 generic/121 generic/122 generic/123 generic/124 
    generic/126 generic/127 generic/129 generic/130 generic/131 
    generic/133 generic/134 generic/136 generic/137 generic/138 
    generic/139 generic/140 generic/142 generic/143 generic/144 
    generic/146 generic/149 generic/150 generic/151 generic/152 
    generic/154 generic/155 generic/157 generic/158 generic/159 
    generic/169 generic/175 generic/176 generic/177 generic/178 
    generic/179 generic/180 generic/181 generic/182 generic/193 
    generic/198 generic/199 generic/200 generic/204 generic/209 
    generic/213 generic/225 generic/239 generic/240 generic/241 
    generic/245 generic/248 generic/249 generic/254 generic/255 
    generic/256 generic/257 generic/259 generic/260 generic/263 
    generic/269 generic/277 generic/285 generic/286 generic/297 
    generic/298 generic/299 generic/300 generic/301 generic/302 
    generic/303 generic/304 generic/306 generic/307 generic/308 
    generic/309 generic/310 generic/311 generic/313 generic/315 
    generic/316 generic/318 generic/319 generic/320 generic/321 
    generic/322 generic/324 generic/325 generic/329 generic/336 
    generic/337 generic/339 generic/342 generic/343 generic/347 
    generic/348 generic/352 generic/353 generic/356 generic/357 
    generic/361 generic/375 generic/376 generic/377 generic/389 
    generic/390 generic/391 generic/393 generic/407 generic/408 
    generic/409 generic/410 generic/411 generic/414 generic/415 
    generic/416 generic/418 generic/420 generic/423 generic/426 
    generic/427 generic/434 generic/436 generic/438 generic/439 
    generic/444 generic/446 generic/447 generic/448 generic/450 
    generic/451 generic/454 generic/463 generic/464 generic/465 
    generic/467 generic/469 generic/472 generic/475 generic/476 
    generic/477 generic/479 generic/480 generic/481 generic/483 
    generic/488 generic/489 generic/490 generic/493 generic/494 
    generic/495 generic/496 generic/498 generic/501 generic/502 
    generic/509 generic/510 generic/511 generic/512 generic/515 
    generic/516 generic/520 generic/523 generic/524 generic/526 
    generic/527 generic/528 generic/531 generic/532 generic/534 
    generic/535 generic/538 generic/539 generic/541 generic/543 
    generic/545 generic/546 generic/547 generic/551 generic/552 
    generic/553 generic/555 generic/557 generic/560 generic/561 
    generic/562 generic/564 generic/567 generic/569 generic/571 
    generic/578 generic/585 generic/586 generic/588 generic/589 
    generic/591 shared/002 shared/298 
Totals: 785 tests, 203 skipped, 300 failures, 0 errors, 8909s

FSTESTIMG: gce-xfstests/xfstests-202002211357
FSTESTPRJ: gce-xfstests
FSTESTVER: blktests f7b47c5 (Tue, 11 Feb 2020 14:22:21 -0800)
FSTESTVER: e2fsprogs v1.45.4-15-g4b4f7b35 (Wed, 9 Oct 2019 20:25:01 -0400)
FSTESTVER: fio  fio-3.18 (Wed, 5 Feb 2020 07:59:58 -0700)
FSTESTVER: fsverity v1.0 (Wed, 6 Nov 2019 10:35:02 -0800)
FSTESTVER: ima-evm-utils v1.2 (Fri, 26 Jul 2019 07:42:17 -0400)
FSTESTVER: nvme-cli v1.10.1 (Tue, 7 Jan 2020 13:55:21 -0700)
FSTESTVER: quota  9a001cc (Tue, 5 Nov 2019 16:12:59 +0100)
FSTESTVER: util-linux v2.35 (Tue, 21 Jan 2020 11:15:21 +0100)
FSTESTVER: xfsprogs v5.4.0 (Fri, 20 Dec 2019 16:47:12 -0500)
FSTESTVER: xfstests-bld a7ae9ff (Tue, 18 Feb 2020 14:22:36 -0500)
FSTESTVER: xfstests linux-v3.8-2692-g3fe2fd0d (Fri, 21 Feb 2020 13:42:43 -0500)
FSTESTCFG: btrfs
FSTESTSET: -g auto
FSTESTOPT: aex
GCE ID:    8335279961640039838
