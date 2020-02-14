Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5704715D68A
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 12:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBNLac (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 06:30:32 -0500
Received: from mail.nethype.de ([5.9.56.24]:47609 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbgBNLac (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 06:30:32 -0500
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1j2ZAy-001nuY-8h
        for linux-btrfs@vger.kernel.org; Fri, 14 Feb 2020 11:30:28 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1j2ZAx-0006rp-SE
        for linux-btrfs@vger.kernel.org; Fri, 14 Feb 2020 11:30:27 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1j2ZAx-00024j-Qj
        for linux-btrfs@vger.kernel.org; Fri, 14 Feb 2020 12:30:27 +0100
Date:   Fri, 14 Feb 2020 12:30:27 +0100
From:   Marc Lehmann <schmorp@schmorp.de>
To:     linux-btrfs@vger.kernel.org
Subject: cpu bound I/O behaviour in linux 5.4 (possibly others)
Message-ID: <20200214113027.GA6855@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

I've upgraded a machine to linux 5.4.15 that runs a small netnews
system. It normally pulls news with about 20MB/s. After upgrading (it
seems) that this process is now CPU bound, and I get only about 10mb/s
throughput. Otherwise, everything seems fine - no obvious bugs, and no
obvious performance problems.

"CPU-bound" specifically means that the disk(s) seem pretty idle (it an
6x10TB raid5), I can do a lot of I/O without slowing down the transfer,
but there is always a single kworker which is constantly at 100% cpu (i.e.
one core) in top:

 8963 root      20   0       0      0      0 R 2 100.0   0.0   2:04 [kworker/u8:15+flush-btrfs-3]

When I cat /proc/8963/task/8963/stack regularly, I get either no output or
(most often) this single line:

   [<0>] tree_search_offset.isra.0+0x16a/0x1d0 [btrfs]

It is possible that this is _not_ new behaviour with 5.4, but I often use
top, and I can't remember having a kworker stuck at 100% cpu for days.
(The fs is about a year old and had no issues so far, the last scrub is about
a week old).

Another symptom is that Dirty in /proc/meminfo is typically at 7-8GB,
which is more or less the value of /proc/sys/vm/dirty_ratio, Writeback is
usually 0 or has small values, and running sync often takes 30m or more.

The 100% cpu is definitely caused by the news transfer - pausing it and
waiting a while makes it effectively disappear and everything goes back to
normal.

The news process effectively does this in multiple parallel loops:

   openat(AT_FDCWD, "/store/04267/26623~", O_WRONLY|O_CREAT|O_EXCL, 0600...
   write(75, "Path: ask005.abavia.com!"..., 656453...
   close(75)                   = 0
   renameat2(AT_FDCWD, "/store/04267/26623~", AT_FDCWD, "/store/04267/26623", 0 ...

The file layout is one layer of subdirectories with 100000 files inside
each, which has posed absolutely no probelms withe xt4/xfs in the past,
and also btrfs didn't seem to mind.

My question is, would this be expected behaviour? If yes, is it something
that can be influenced/improved on my side?

I can investigate and do some experiments, but I cannot easily update
kernels/do reboots on this system.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
