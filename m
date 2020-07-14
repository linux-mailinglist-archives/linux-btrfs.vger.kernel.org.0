Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51E621F156
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jul 2020 14:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgGNMc7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jul 2020 08:32:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:49530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728047AbgGNMc7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jul 2020 08:32:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4494AD3A;
        Tue, 14 Jul 2020 12:32:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 06280DA790; Tue, 14 Jul 2020 14:32:34 +0200 (CEST)
Date:   Tue, 14 Jul 2020 14:32:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: assert sizes of ioctl structures
Message-ID: <20200714123234.GP3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20200714093236.6107-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200714093236.6107-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 14, 2020 at 06:32:36PM +0900, Johannes Thumshirn wrote:
> When expanding ioctl interfaces we want to make sure we're not changing
> the size of the structures, otherwise it can lead to incorrect transfers
> between kernel and user-space.
> 
> Build time assert the size of each structure so we're not running into any
> incompatibilities.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

I've tried 32bit build and the assertion fails for many structures, but
I was expecting only the send one because it contains the pointer.

  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  CC [M]  fs/btrfs/super.o
In file included from ./include/linux/bits.h:22,
                 from ./include/linux/bitops.h:5,
                 from ./include/linux/kernel.h:12,
                 from ./arch/x86/include/asm/percpu.h:45,
                 from ./arch/x86/include/asm/current.h:6,
                 from ./include/linux/sched.h:12,
                 from ./include/linux/blkdev.h:5,
                 from fs/btrfs/super.c:6:
./include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct btrfs_ioctl_dev_replace_start_params) == 2072"
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                         ^~~~~~~~~~~~~~
./include/linux/build_bug.h:77:34: note: in expansion of macro ‘__static_assert’
   77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
      |                                  ^~~~~~~~~~~~~~~
./include/uapi/linux/btrfs.h:213:1: note: in expansion of macro ‘static_assert’
  213 | static_assert(sizeof(struct btrfs_ioctl_dev_replace_start_params) == 2072);
      | ^~~~~~~~~~~~~
./include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct btrfs_ioctl_dev_replace_args) == 2600"
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                         ^~~~~~~~~~~~~~
./include/linux/build_bug.h:77:34: note: in expansion of macro ‘__static_assert’
   77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
      |                                  ^~~~~~~~~~~~~~~
./include/uapi/linux/btrfs.h:248:1: note: in expansion of macro ‘static_assert’
  248 | static_assert(sizeof(struct btrfs_ioctl_dev_replace_args) == 2600);
      | ^~~~~~~~~~~~~
./include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct btrfs_ioctl_received_subvol_args) == 200"
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                         ^~~~~~~~~~~~~~
./include/linux/build_bug.h:77:34: note: in expansion of macro ‘__static_assert’
   77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
      |                                  ^~~~~~~~~~~~~~~
./include/uapi/linux/btrfs.h:781:1: note: in expansion of macro ‘static_assert’
  781 | static_assert(sizeof(struct btrfs_ioctl_received_subvol_args) == 200);
      | ^~~~~~~~~~~~~
./include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct btrfs_ioctl_send_args) == 72"
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                         ^~~~~~~~~~~~~~
./include/linux/build_bug.h:77:34: note: in expansion of macro ‘__static_assert’
   77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
      |                                  ^~~~~~~~~~~~~~~
./include/uapi/linux/btrfs.h:816:1: note: in expansion of macro ‘static_assert’
  816 | static_assert(sizeof(struct btrfs_ioctl_send_args) == 72);
      | ^~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:281: fs/btrfs/super.o] Error 1
make[1]: *** [scripts/Makefile.build:497: fs/btrfs] Error 2
make: *** [Makefile:1756: fs] Error 2
