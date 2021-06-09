Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA11F3A1661
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 16:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbhFIODV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 10:03:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:49265 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237148AbhFIODS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Jun 2021 10:03:18 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G0TKt4K9TzBBZH;
        Wed,  9 Jun 2021 16:01:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a1uqyJtO2ulD; Wed,  9 Jun 2021 16:01:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G0TKt3M9JzBBTw;
        Wed,  9 Jun 2021 16:01:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3400D8B7E3;
        Wed,  9 Jun 2021 16:01:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 793nCcEw9Je0; Wed,  9 Jun 2021 16:01:22 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 96F388B7C3;
        Wed,  9 Jun 2021 16:01:21 +0200 (CEST)
Subject: Re: include/linux/compiler_types.h:326:38: error: call to
 '__compiletime_assert_791' declared with attribute error: BUILD_BUG_ON
 failed: (BTRFS_MAX_COMPRESSED % PAGE_SIZE) != 0
To:     kernel test robot <lkp@intel.com>, linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202106092159.05DloM1z-lkp@intel.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <6cc4b52b-48cd-45e2-67b5-289c4962fedb@csgroup.eu>
Date:   Wed, 9 Jun 2021 16:01:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202106092159.05DloM1z-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Le 09/06/2021 à 15:55, kernel test robot a écrit :
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   368094df48e680fa51cedb68537408cfa64b788e
> commit: 4eeef098b43242ed145c83fba9989d586d707589 powerpc/44x: Remove STDBINUTILS kconfig option
> date:   4 months ago
> config: powerpc-randconfig-r012-20210609 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0

That's a BTRFS issue, and not directly linked to the above mentioned commit. Before that commit the 
problem was already present.

Problem is that with 256k PAGE_SIZE, following BUILD_BUG() pops up:

BUILD_BUG_ON((BTRFS_MAX_COMPRESSED % PAGE_SIZE) != 0)


> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4eeef098b43242ed145c83fba9989d586d707589
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 4eeef098b43242ed145c83fba9989d586d707589
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>     fs/buffer.c: In function 'block_read_full_page':
>>> fs/buffer.c:2342:1: warning: the frame size of 2048 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>      2342 | }
>           | ^
> --
>     fs/ext4/move_extent.c: In function 'mext_page_mkuptodate':
>>> fs/ext4/move_extent.c:227:1: warning: the frame size of 2056 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       227 | }
>           | ^
> --
>     fs/fat/dir.c: In function 'fat_add_new_entries':
>>> fs/fat/dir.c:1279:1: warning: the frame size of 2088 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>      1279 | }
>           | ^
>     fs/fat/dir.c: In function 'fat_alloc_new_dir':
>     fs/fat/dir.c:1195:1: warning: the frame size of 2064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>      1195 | }
>           | ^
> --
>     fs/fat/fatent.c: In function 'fat_free_clusters':
>>> fs/fat/fatent.c:632:1: warning: the frame size of 2080 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       632 | }
>           | ^
>     fs/fat/fatent.c: In function 'fat_alloc_clusters':
>     fs/fat/fatent.c:550:1: warning: the frame size of 2112 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       550 | }
>           | ^
> --
>     fs/exfat/fatent.c: In function 'exfat_zeroed_cluster':
>>> fs/exfat/fatent.c:277:1: warning: the frame size of 2048 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       277 | }
>           | ^
> --
>     In file included from <command-line>:
>     fs/btrfs/inode.c: In function 'compress_file_range':
>>> include/linux/compiler_types.h:326:38: error: call to '__compiletime_assert_791' declared with attribute error: BUILD_BUG_ON failed: (BTRFS_MAX_COMPRESSED % PAGE_SIZE) != 0
>       326 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>           |                                      ^
>     include/linux/compiler_types.h:307:4: note: in definition of macro '__compiletime_assert'
>       307 |    prefix ## suffix();    \
>           |    ^~~~~~
>     include/linux/compiler_types.h:326:2: note: in expansion of macro '_compiletime_assert'
>       326 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>           |  ^~~~~~~~~~~~~~~~~~~
>     include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>        39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>           |                                     ^~~~~~~~~~~~~~~~~~
>     include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>        50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>           |  ^~~~~~~~~~~~~~~~
>     fs/btrfs/inode.c:563:2: note: in expansion of macro 'BUILD_BUG_ON'
>       563 |  BUILD_BUG_ON((BTRFS_MAX_COMPRESSED % PAGE_SIZE) != 0);
>           |  ^~~~~~~~~~~~
> 
> 
> vim +/__compiletime_assert_791 +326 include/linux/compiler_types.h
> 
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  312
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  313  #define _compiletime_assert(condition, msg, prefix, suffix) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  314  	__compiletime_assert(condition, msg, prefix, suffix)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  315
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  316  /**
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  317   * compiletime_assert - break build and emit msg if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  318   * @condition: a compile-time constant condition to check
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  319   * @msg:       a message to emit if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  320   *
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  321   * In tradition of POSIX assert, this macro will break the build if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  322   * supplied condition is *false*, emitting the supplied error message if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  323   * compiler has support to do so.
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  324   */
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  325  #define compiletime_assert(condition, msg) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21 @326  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  327
> 
> :::::: The code at line 326 was first introduced by commit
> :::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h
> 
> :::::: TO: Will Deacon <will@kernel.org>
> :::::: CC: Will Deacon <will@kernel.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
