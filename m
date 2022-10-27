Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D8060F63F
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 13:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiJ0Lca (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 07:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiJ0Lc2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 07:32:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CAF1162C8
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 04:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666870344; x=1698406344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LdtsP+m8fqVaBl41D/CugeV3epglE1OpCgUSueh4fSY=;
  b=aq3fss0F2nHNcG1ebfGqwLQgpKfRLeqvoHVYYBPY1CvTMpJbsnCDDqF+
   2lyKCMlXqXAvGjuqZ5En3RWQl+MQ0idSBtSSOfXEpW/5guzjpvzE/AvGm
   HxboTyNO7J0TSVCeV/WwwGx3CDpGO5ht+byPVQ2kycQ3DkXDNEl0AOBFL
   ZzmHgKZ2K3NzDy+eC5fZThyIbnLLD+HY66Q/Z7839+glxf0tCLLPuMWOG
   xRTr0rlA5P1rcgj0IBj6mrSSS8ineeP3WE3C8zGTWuaNYLaVG4coRkT5z
   mt4/LatqAxCCgbZ7VDuCENunsBA7Z/cEq/Q6b7lr2dBy3/FUhgtkGr6DF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="372411217"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="372411217"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 04:32:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="701312412"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="701312412"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 27 Oct 2022 04:32:20 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oo17U-0008j5-0r;
        Thu, 27 Oct 2022 11:32:20 +0000
Date:   Thu, 27 Oct 2022 19:32:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 26/26] btrfs: move orphan prototypes into orphan.h
Message-ID: <202210271935.jGZBiyV4-lkp@intel.com>
References: <839fac08903cd0fea21bb8dacb2506332bae03c7.1666811039.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AtVS2kTAQfVwRkWS"
Content-Disposition: inline
In-Reply-To: <839fac08903cd0fea21bb8dacb2506332bae03c7.1666811039.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--AtVS2kTAQfVwRkWS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Josef,

I love your patch! Perhaps something to improve:

[auto build test WARNING on kdave/for-next]
[cannot apply to linus/master v6.1-rc2 next-20221027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Josef-Bacik/btrfs-final-ctree-h-cleanups/20221027-031432
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/839fac08903cd0fea21bb8dacb2506332bae03c7.1666811039.git.josef%40toxicpanda.com
patch subject: [PATCH 26/26] btrfs: move orphan prototypes into orphan.h
config: hexagon-randconfig-r011-20221026
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8e210fa72a0f44e7f379b689410a29db03151b2c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Josef-Bacik/btrfs-final-ctree-h-cleanups/20221027-031432
        git checkout 8e210fa72a0f44e7f379b689410a29db03151b2c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/btrfs/orphan.c:6:
   In file included from fs/btrfs/ctree.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from fs/btrfs/orphan.c:6:
   In file included from fs/btrfs/ctree.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from fs/btrfs/orphan.c:6:
   In file included from fs/btrfs/ctree.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> fs/btrfs/orphan.c:9:5: warning: no previous prototype for function 'btrfs_insert_orphan_item' [-Wmissing-prototypes]
   int btrfs_insert_orphan_item(struct btrfs_trans_handle *trans,
       ^
   fs/btrfs/orphan.c:9:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int btrfs_insert_orphan_item(struct btrfs_trans_handle *trans,
   ^
   static 
>> fs/btrfs/orphan.c:30:5: warning: no previous prototype for function 'btrfs_del_orphan_item' [-Wmissing-prototypes]
   int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,
       ^
   fs/btrfs/orphan.c:30:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,
   ^
   static 
   8 warnings generated.


vim +/btrfs_insert_orphan_item +9 fs/btrfs/orphan.c

7b1287662304c3 Josef Bacik  2008-07-24   8  
7b1287662304c3 Josef Bacik  2008-07-24  @9  int btrfs_insert_orphan_item(struct btrfs_trans_handle *trans,
7b1287662304c3 Josef Bacik  2008-07-24  10  			     struct btrfs_root *root, u64 offset)
7b1287662304c3 Josef Bacik  2008-07-24  11  {
7b1287662304c3 Josef Bacik  2008-07-24  12  	struct btrfs_path *path;
7b1287662304c3 Josef Bacik  2008-07-24  13  	struct btrfs_key key;
7b1287662304c3 Josef Bacik  2008-07-24  14  	int ret = 0;
7b1287662304c3 Josef Bacik  2008-07-24  15  
7b1287662304c3 Josef Bacik  2008-07-24  16  	key.objectid = BTRFS_ORPHAN_OBJECTID;
962a298f35110e David Sterba 2014-06-04  17  	key.type = BTRFS_ORPHAN_ITEM_KEY;
7b1287662304c3 Josef Bacik  2008-07-24  18  	key.offset = offset;
7b1287662304c3 Josef Bacik  2008-07-24  19  
7b1287662304c3 Josef Bacik  2008-07-24  20  	path = btrfs_alloc_path();
7b1287662304c3 Josef Bacik  2008-07-24  21  	if (!path)
7b1287662304c3 Josef Bacik  2008-07-24  22  		return -ENOMEM;
7b1287662304c3 Josef Bacik  2008-07-24  23  
7b1287662304c3 Josef Bacik  2008-07-24  24  	ret = btrfs_insert_empty_item(trans, root, path, &key, 0);
7b1287662304c3 Josef Bacik  2008-07-24  25  
7b1287662304c3 Josef Bacik  2008-07-24  26  	btrfs_free_path(path);
7b1287662304c3 Josef Bacik  2008-07-24  27  	return ret;
7b1287662304c3 Josef Bacik  2008-07-24  28  }
7b1287662304c3 Josef Bacik  2008-07-24  29  
7b1287662304c3 Josef Bacik  2008-07-24 @30  int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--AtVS2kTAQfVwRkWS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/hexagon 6.1.0-rc2 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="clang version 16.0.0 (git://gitmirror/llvm_project 791a7ae1ba3efd6bca96338e10ffde557ba83920)"
CONFIG_GCC_VERSION=0
CONFIG_CC_IS_CLANG=y
CONFIG_CLANG_VERSION=160000
CONFIG_AS_IS_LLVM=y
CONFIG_AS_VERSION=160000
CONFIG_LD_VERSION=0
CONFIG_LD_IS_LLD=y
CONFIG_LLD_VERSION=160000
CONFIG_RUST_IS_AVAILABLE=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_IRQ_WORK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_COMPILE_TEST=y
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_BUILD_SALT=""
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
CONFIG_AUDIT=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
# end of IRQ subsystem

CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_TIME_KUNIT_TEST=m
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

CONFIG_BPF=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
# end of BPF subsystem

CONFIG_PREEMPT_NONE_BUILD=y
CONFIG_PREEMPT_NONE=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
# CONFIG_FORCE_TASKS_RCU is not set
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_NOCB_CPU is not set
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

# CONFIG_IKCONFIG is not set
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13

#
# Scheduler features
#
# end of Scheduler features

CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
# CONFIG_CGROUPS is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_EMBED is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
# CONFIG_EXPERT is not set
CONFIG_MULTIUSER=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_KCMP=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# end of Kernel Performance Events And Counters

# CONFIG_PROFILING is not set
# end of General setup

#
# Linux Kernel Configuration for Hexagon
#
CONFIG_HEXAGON=y
CONFIG_HEXAGON_PHYS_OFFSET=y
CONFIG_FRAME_POINTER=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_EARLY_PRINTK=y
CONFIG_MMU=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_GENERIC_BUG=y

#
# Machine selection
#
CONFIG_HEXAGON_COMET=y
CONFIG_HEXAGON_ARCH_VERSION=2
CONFIG_CMDLINE=""
CONFIG_SMP=y
CONFIG_NR_CPUS=6
CONFIG_PAGE_SIZE_4KB=y
# CONFIG_PAGE_SIZE_16KB is not set
# CONFIG_PAGE_SIZE_64KB is not set
# CONFIG_PAGE_SIZE_256KB is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
# end of Machine selection

#
# General architecture-dependent options
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_LTO_NONE=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_ARCH_NO_PREEMPT=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y

#
# GCOV-based kernel profiling
#
# end of GCOV-based kernel profiling
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS_NONE is not set
# CONFIG_MODULE_COMPRESS_GZIP is not set
CONFIG_MODULE_COMPRESS_XZ=y
# CONFIG_MODULE_COMPRESS_ZSTD is not set
CONFIG_MODULE_DECOMPRESS=y
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_SED_OPAL is not set
CONFIG_BLK_INLINE_ENCRYPTION=y
# CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
# CONFIG_MQ_IOSCHED_KYBER is not set
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PADATA=y
CONFIG_ASN1=m
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
# CONFIG_SWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_STATS=y
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_FLATMEM=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_BALLOON_COMPACTION is not set
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_CMA is not set
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PERCPU_STATS=y

#
# GUP_TEST needs to have DEBUG_FS enabled
#
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set
CONFIG_LRU_GEN=y
# CONFIG_LRU_GEN_ENABLED is not set
CONFIG_LRU_GEN_STATS=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
# CONFIG_XDP_SOCKETS is not set
# CONFIG_INET is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_ADVANCED is not set
CONFIG_ATM=m
CONFIG_ATM_LANE=m
# CONFIG_BRIDGE is not set
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
# CONFIG_VLAN_8021Q_MVRP is not set
CONFIG_LLC=m
CONFIG_LLC2=m
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=m
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_X25=y
CONFIG_LAPB=m
CONFIG_PHONET=m
CONFIG_IEEE802154=y
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
CONFIG_IEEE802154_SOCKET=m
# CONFIG_MAC802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
# CONFIG_NET_SCH_HFSC is not set
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=y
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFB=m
# CONFIG_NET_SCH_SFQ is not set
# CONFIG_NET_SCH_TEQL is not set
# CONFIG_NET_SCH_TBF is not set
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=y
# CONFIG_NET_SCH_MQPRIO is not set
CONFIG_NET_SCH_SKBPRIO=y
# CONFIG_NET_SCH_CHOKE is not set
# CONFIG_NET_SCH_QFQ is not set
CONFIG_NET_SCH_CODEL=y
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_CAKE=m
# CONFIG_NET_SCH_FQ is not set
CONFIG_NET_SCH_HHF=m
# CONFIG_NET_SCH_PIE is not set
# CONFIG_NET_SCH_INGRESS is not set
CONFIG_NET_SCH_PLUG=y
CONFIG_NET_SCH_ETS=y
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
# CONFIG_NET_CLS_BASIC is not set
# CONFIG_NET_CLS_TCINDEX is not set
# CONFIG_NET_CLS_FW is not set
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
# CONFIG_CLS_U32_MARK is not set
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=y
# CONFIG_NET_CLS_FLOW is not set
CONFIG_NET_CLS_BPF=y
CONFIG_NET_CLS_FLOWER=m
# CONFIG_NET_CLS_MATCHALL is not set
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=y
# CONFIG_NET_EMATCH_NBYTE is not set
# CONFIG_NET_EMATCH_U32 is not set
# CONFIG_NET_EMATCH_META is not set
# CONFIG_NET_EMATCH_TEXT is not set
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_CLS_ACT=y
# CONFIG_NET_ACT_POLICE is not set
CONFIG_NET_ACT_GACT=m
# CONFIG_GACT_PROB is not set
# CONFIG_NET_ACT_MIRRED is not set
# CONFIG_NET_ACT_SAMPLE is not set
# CONFIG_NET_ACT_NAT is not set
# CONFIG_NET_ACT_PEDIT is not set
CONFIG_NET_ACT_SIMP=y
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_MPLS=y
CONFIG_NET_ACT_VLAN=y
# CONFIG_NET_ACT_BPF is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_GATE=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_BATMAN_ADV=y
CONFIG_BATMAN_ADV_BATMAN_V=y
# CONFIG_BATMAN_ADV_NC is not set
# CONFIG_BATMAN_ADV_DEBUG is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
# CONFIG_QRTR is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
# CONFIG_CAN_GW is not set
CONFIG_CAN_J1939=m
CONFIG_CAN_ISOTP=m
CONFIG_BT=m
# CONFIG_BT_BREDR is not set
# CONFIG_BT_LE is not set
CONFIG_BT_LEDS=y
# CONFIG_BT_MSFTEXT is not set
# CONFIG_BT_AOSPEXT is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_QCA=m
CONFIG_BT_MTK=m
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_SERDEV=y
CONFIG_BT_HCIUART_H4=y
# CONFIG_BT_HCIUART_BCSP is not set
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_LL is not set
CONFIG_BT_HCIUART_3WIRE=y
CONFIG_BT_HCIUART_INTEL=y
# CONFIG_BT_HCIUART_BCM is not set
# CONFIG_BT_HCIUART_RTL is not set
CONFIG_BT_HCIUART_QCA=y
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIUART_MRVL is not set
CONFIG_BT_HCIVHCI=m
# CONFIG_BT_MRVL is not set
CONFIG_BT_MTKSDIO=m
CONFIG_BT_MTKUART=m
# CONFIG_BT_QCOMSMD is not set
CONFIG_BT_VIRTIO=m
# end of Bluetooth device drivers

CONFIG_MCTP=y
CONFIG_MCTP_FLOWS=y
# CONFIG_WIRELESS is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=m
# CONFIG_NET_9P_FD is not set
CONFIG_NET_9P_VIRTIO=m
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
CONFIG_NFC_NCI_SPI=m
CONFIG_NFC_NCI_UART=m
CONFIG_NFC_HCI=m
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_VIRTUAL_NCI=m
CONFIG_NFC_FDP=m
# CONFIG_NFC_FDP_I2C is not set
CONFIG_NFC_PN544=m
CONFIG_NFC_PN544_I2C=m
CONFIG_NFC_PN533=m
CONFIG_NFC_PN533_I2C=m
# CONFIG_NFC_PN532_UART is not set
# CONFIG_NFC_MICROREAD_I2C is not set
CONFIG_NFC_MRVL=m
CONFIG_NFC_MRVL_UART=m
# CONFIG_NFC_MRVL_I2C is not set
CONFIG_NFC_MRVL_SPI=m
CONFIG_NFC_ST21NFCA=m
CONFIG_NFC_ST21NFCA_I2C=m
CONFIG_NFC_ST_NCI=m
CONFIG_NFC_ST_NCI_I2C=m
CONFIG_NFC_ST_NCI_SPI=m
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# CONFIG_NFC_S3FWRN82_UART is not set
# end of Near Field Communication (NFC) devices

# CONFIG_PSAMPLE is not set
CONFIG_NET_IFE=y
# CONFIG_LWTUNNEL is not set
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_PAGE_POOL_STATS=y
CONFIG_FAILOVER=y
# CONFIG_ETHTOOL_NETLINK is not set
# CONFIG_NETDEV_ADDR_LIST_TEST is not set

#
# Device Drivers
#
# CONFIG_PCCARD is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_GENERIC_CPU_DEVICES=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SPI_AVMM=m
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_ARM_INTEGRATOR_LM is not set
# CONFIG_BT1_APB is not set
CONFIG_BT1_AXI=y
# CONFIG_INTEL_IXP4XX_EB is not set
CONFIG_QCOM_EBI2=y
CONFIG_MHI_BUS=m
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=m

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
CONFIG_ARM_SCMI_PROTOCOL=y
CONFIG_ARM_SCMI_HAVE_TRANSPORT=y
CONFIG_ARM_SCMI_HAVE_SHMEM=y
CONFIG_ARM_SCMI_TRANSPORT_MAILBOX=y
# CONFIG_ARM_SCMI_TRANSPORT_VIRTIO is not set
CONFIG_ARM_SCMI_POWER_DOMAIN=m
# CONFIG_ARM_SCMI_POWER_CONTROL is not set
# end of ARM System Control and Management Interface Protocol

CONFIG_ARM_SCPI_PROTOCOL=y
CONFIG_ARM_SCPI_POWER_DOMAIN=y
CONFIG_BCM47XX_NVRAM=y
# CONFIG_BCM47XX_SPROM is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=m
CONFIG_GNSS_MTK_SERIAL=m
# CONFIG_GNSS_SIRF_SERIAL is not set
CONFIG_GNSS_UBX_SERIAL=m
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_PARPORT=y
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
# CONFIG_BLK_DEV is not set

#
# NVME Support
#
CONFIG_NVME_COMMON=m
CONFIG_NVME_CORE=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_FC is not set
CONFIG_NVME_TARGET_AUTH=y
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
CONFIG_AD525X_DPOT_SPI=m
# CONFIG_DUMMY_IRQ is not set
# CONFIG_ICS932S401 is not set
CONFIG_ATMEL_SSC=m
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_GEHC_ACHC is not set
CONFIG_QCOM_COINCELL=m
# CONFIG_QCOM_FASTRPC is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=m
CONFIG_DS1682=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
CONFIG_SRAM=y
CONFIG_XILINX_SDFEC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=m
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_SPI=y
# CONFIG_SENSORS_LIS3_I2C is not set

#
# Altera FPGA firmware download module (requires I2C)
#
CONFIG_ALTERA_STAPL=m
CONFIG_ECHO=m
CONFIG_UACCE=y
CONFIG_PVPANIC=y
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=m
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=m
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
# CONFIG_SCSI_ENCLOSURE is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_BOOT_SYSFS=m
# CONFIG_SCSI_HISI_SAS is not set
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_VIRTIO=m
CONFIG_SCSI_DH=y
# CONFIG_SCSI_DH_RDAC is not set
# CONFIG_SCSI_DH_HP_SW is not set
# CONFIG_SCSI_DH_EMC is not set
CONFIG_SCSI_DH_ALUA=m
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_FORCE=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_BRCM is not set
CONFIG_AHCI_DA850=m
CONFIG_AHCI_DM816=m
CONFIG_AHCI_DWC=m
CONFIG_AHCI_ST=m
# CONFIG_AHCI_IMX is not set
CONFIG_AHCI_MTK=m
# CONFIG_AHCI_MVEBU is not set
CONFIG_AHCI_SUNXI=m
CONFIG_AHCI_TEGRA=m
# CONFIG_AHCI_XGENE is not set
# CONFIG_SATA_FSL is not set
CONFIG_SATA_AHCI_SEATTLE=m
# CONFIG_ATA_SFF is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_AUTODETECT is not set
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID10 is not set
# CONFIG_MD_RAID456 is not set
CONFIG_MD_MULTIPATH=y
CONFIG_MD_FAULTY=y
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=y
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=y
CONFIG_DM_PERSISTENT_DATA=y
CONFIG_DM_UNSTRIPED=m
# CONFIG_DM_CRYPT is not set
CONFIG_DM_SNAPSHOT=y
CONFIG_DM_THIN_PROVISIONING=m
# CONFIG_DM_CACHE is not set
CONFIG_DM_WRITECACHE=y
CONFIG_DM_EBS=m
CONFIG_DM_ERA=y
CONFIG_DM_CLONE=m
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_RAID is not set
# CONFIG_DM_ZERO is not set
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
# CONFIG_DM_MULTIPATH_ST is not set
CONFIG_DM_MULTIPATH_HST=m
CONFIG_DM_MULTIPATH_IOA=m
CONFIG_DM_DELAY=y
CONFIG_DM_DUST=m
CONFIG_DM_INIT=y
CONFIG_DM_UEVENT=y
# CONFIG_DM_FLAKEY is not set
# CONFIG_DM_VERITY is not set
CONFIG_DM_SWITCH=m
# CONFIG_DM_LOG_WRITES is not set
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_AUDIT is not set
CONFIG_TARGET_CORE=y
# CONFIG_TCM_IBLOCK is not set
# CONFIG_TCM_FILEIO is not set
CONFIG_TCM_PSCSI=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_SBP_TARGET=m

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_SBP2=m
# end of IEEE 1394 (FireWire) support

CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
CONFIG_MACVLAN=y
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN_VNET_CROSS_LE=y
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
CONFIG_NLMON=m
# CONFIG_MHI_NET is not set
# CONFIG_ATM_DRIVERS is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_ACTIONS=y
# CONFIG_OWL_EMAC is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_ALTERA_TSE is not set
# CONFIG_NET_VENDOR_AMAZON is not set
CONFIG_NET_XGENE=m
CONFIG_NET_XGENE_V2=y
# CONFIG_NET_VENDOR_AQUANTIA is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
CONFIG_SPI_AX88796C=m
# CONFIG_SPI_AX88796C_COMPRESSION is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCM4908_ENET is not set
CONFIG_BCMGENET=y
# CONFIG_BGMAC_PLATFORM is not set
CONFIG_SYSTEMPORT=y
# CONFIG_NET_VENDOR_CADENCE is not set
# CONFIG_NET_CALXEDA_XGMAC is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
# CONFIG_NET_VENDOR_CIRRUS is not set
# CONFIG_NET_VENDOR_CORTINA is not set
CONFIG_NET_VENDOR_DAVICOM=y
CONFIG_DM9000=y
CONFIG_DM9000_FORCE_SIMPLE_PHY_POLL=y
# CONFIG_DM9051 is not set
CONFIG_DNET=m
# CONFIG_NET_VENDOR_ENGLEDER is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
CONFIG_NET_VENDOR_FARADAY=y
CONFIG_FTMAC100=m
# CONFIG_FTGMAC100 is not set
# CONFIG_NET_VENDOR_FREESCALE is not set
# CONFIG_NET_VENDOR_FUNGIBLE is not set
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_NET_VENDOR_INTEL is not set
# CONFIG_NET_VENDOR_WANGXUN is not set
CONFIG_KORINA=y
# CONFIG_NET_VENDOR_ADI is not set
# CONFIG_NET_VENDOR_LITEX is not set
# CONFIG_NET_VENDOR_MARVELL is not set
CONFIG_NET_VENDOR_MEDIATEK=y
# CONFIG_NET_MEDIATEK_SOC is not set
# CONFIG_NET_MEDIATEK_STAR_EMAC is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLXSW_CORE=y
# CONFIG_MLXSW_I2C is not set
CONFIG_MLXFW=y
CONFIG_MLXBF_GIGE=y
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
# CONFIG_NET_VENDOR_MICROSEMI is not set
# CONFIG_NET_VENDOR_MICROSOFT is not set
# CONFIG_NET_VENDOR_NI is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
CONFIG_LPC_ENET=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_NET_VENDOR_QUALCOMM is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_SH_ETH=m
# CONFIG_RAVB is not set
# CONFIG_NET_VENDOR_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
CONFIG_SXGBE_ETH=y
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_SMC91X=m
CONFIG_SMC911X=y
CONFIG_SMSC911X=m
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
CONFIG_NET_VENDOR_SUNPLUS=y
CONFIG_SP7021_EMAC=m
CONFIG_NET_VENDOR_SYNOPSYS=y
CONFIG_DWC_XLGMAC=y
# CONFIG_NET_VENDOR_VERTEXCOM is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_LED_TRIGGER_PHY=y
CONFIG_FIXED_PHY=y

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=y
# CONFIG_MESON_GXL_PHY is not set
# CONFIG_ADIN_PHY is not set
CONFIG_ADIN1100_PHY=m
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=m
CONFIG_BROADCOM_PHY=m
CONFIG_BCM54140_PHY=m
# CONFIG_BCM63XX_PHY is not set
CONFIG_BCM7XXX_PHY=y
# CONFIG_BCM84881_PHY is not set
CONFIG_BCM87XX_PHY=y
CONFIG_BCM_NET_PHYLIB=y
CONFIG_BCM_NET_PHYPTP=m
# CONFIG_CICADA_PHY is not set
CONFIG_CORTINA_PHY=y
# CONFIG_DAVICOM_PHY is not set
CONFIG_ICPLUS_PHY=m
# CONFIG_LXT_PHY is not set
CONFIG_INTEL_XWAY_PHY=y
CONFIG_LSI_ET1011C_PHY=m
CONFIG_MARVELL_PHY=y
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
CONFIG_MEDIATEK_GE_PHY=y
CONFIG_MICREL_PHY=y
# CONFIG_MICROCHIP_PHY is not set
CONFIG_MICROCHIP_T1_PHY=m
CONFIG_MICROSEMI_PHY=m
CONFIG_MOTORCOMM_PHY=m
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
CONFIG_NXP_TJA11XX_PHY=m
CONFIG_AT803X_PHY=y
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=y
CONFIG_ROCKCHIP_PHY=y
CONFIG_SMSC_PHY=y
CONFIG_STE10XP=m
CONFIG_TERANETICS_PHY=m
CONFIG_DP83822_PHY=y
CONFIG_DP83TC811_PHY=m
# CONFIG_DP83848_PHY is not set
CONFIG_DP83867_PHY=y
CONFIG_DP83869_PHY=m
# CONFIG_DP83TD510_PHY is not set
CONFIG_VITESSE_PHY=y
CONFIG_XILINX_GMII2RGMII=m
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_CAN_DEV is not set

#
# MCTP Device Drivers
#
CONFIG_MCTP_SERIAL=y
CONFIG_MCTP_TRANSPORT_I2C=m
# end of MCTP Device Drivers

CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_SUN4I is not set
CONFIG_MDIO_XGENE=m
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_BCM_UNIMAC=y
CONFIG_MDIO_CAVIUM=m
CONFIG_MDIO_GPIO=m
CONFIG_MDIO_MSCC_MIIM=m
CONFIG_MDIO_MOXART=y
CONFIG_MDIO_OCTEON=m

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

CONFIG_PLIP=y
# CONFIG_PPP is not set
CONFIG_SLIP=y
# CONFIG_SLIP_COMPRESSED is not set
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_WLAN is not set
CONFIG_WAN=y
# CONFIG_HDLC is not set
# CONFIG_SLIC_DS26522 is not set
# CONFIG_LAPBETHER is not set
# CONFIG_IEEE802154_DRIVERS is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=m
CONFIG_INPUT_VIVALDIFMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_SERIAL is not set
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=y
CONFIG_MOUSE_GPIO=y
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
CONFIG_TOUCHSCREEN_ADC=y
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
CONFIG_TOUCHSCREEN_BU21013=m
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=m
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP_SPI=m
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP4_SPI=m
# CONFIG_TOUCHSCREEN_DA9052 is not set
CONFIG_TOUCHSCREEN_DYNAPRO=m
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
# CONFIG_TOUCHSCREEN_EXC3000 is not set
CONFIG_TOUCHSCREEN_FUJITSU=m
# CONFIG_TOUCHSCREEN_GOODIX is not set
CONFIG_TOUCHSCREEN_HIDEEP=m
CONFIG_TOUCHSCREEN_HYCON_HY46XX=m
# CONFIG_TOUCHSCREEN_ILI210X is not set
CONFIG_TOUCHSCREEN_ILITEK=m
CONFIG_TOUCHSCREEN_IPROC=y
# CONFIG_TOUCHSCREEN_S6SY761 is not set
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_EKTF2127=m
CONFIG_TOUCHSCREEN_ELAN=m
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
CONFIG_TOUCHSCREEN_MAX11801=m
# CONFIG_TOUCHSCREEN_MCS5000 is not set
CONFIG_TOUCHSCREEN_MMS114=m
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MSG2638 is not set
CONFIG_TOUCHSCREEN_MTOUCH=y
CONFIG_TOUCHSCREEN_IMAGIS=m
CONFIG_TOUCHSCREEN_IMX6UL_TSC=m
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
CONFIG_TOUCHSCREEN_PENMOUNT=y
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_RASPBERRYPI_FW is not set
CONFIG_TOUCHSCREEN_MIGOR=m
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
CONFIG_TOUCHSCREEN_TOUCHWIN=y
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
CONFIG_TOUCHSCREEN_PIXCIR=m
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_MXS_LRADC is not set
# CONFIG_TOUCHSCREEN_MX25 is not set
# CONFIG_TOUCHSCREEN_MC13783 is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
CONFIG_TOUCHSCREEN_TSC2004=m
# CONFIG_TOUCHSCREEN_TSC2005 is not set
CONFIG_TOUCHSCREEN_TSC2007=m
# CONFIG_TOUCHSCREEN_TSC2007_IIO is not set
CONFIG_TOUCHSCREEN_RM_TS=m
CONFIG_TOUCHSCREEN_SILEAD=m
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
CONFIG_TOUCHSCREEN_ST1232=m
# CONFIG_TOUCHSCREEN_STMFTS is not set
CONFIG_TOUCHSCREEN_SUN4I=m
CONFIG_TOUCHSCREEN_SURFACE3_SPI=m
CONFIG_TOUCHSCREEN_SX8654=m
CONFIG_TOUCHSCREEN_TPS6507X=m
CONFIG_TOUCHSCREEN_ZET6223=m
CONFIG_TOUCHSCREEN_ZFORCE=m
CONFIG_TOUCHSCREEN_COLIBRI_VF50=m
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
CONFIG_TOUCHSCREEN_IQS5XX=m
CONFIG_TOUCHSCREEN_ZINITIX=m
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F3A=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=m
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_OLPC_APSP is not set
CONFIG_SERIO_SUN4I_PS2=y
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=m
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_16550A_VARIANTS=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=m
# CONFIG_SERIAL_8250_IOC3 is not set
# CONFIG_SERIAL_8250_RT288X is not set
# CONFIG_SERIAL_8250_OMAP is not set
CONFIG_SERIAL_8250_MT6577=m
CONFIG_SERIAL_8250_UNIPHIER=m
CONFIG_SERIAL_8250_PXA=m
CONFIG_SERIAL_8250_TEGRA=m
# CONFIG_SERIAL_8250_BCM7271 is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_AMBA_PL010=y
# CONFIG_SERIAL_AMBA_PL010_CONSOLE is not set
CONFIG_SERIAL_MESON=y
CONFIG_SERIAL_MESON_CONSOLE=y
CONFIG_SERIAL_CLPS711X=m
CONFIG_SERIAL_SAMSUNG=y
CONFIG_SERIAL_SAMSUNG_UARTS_4=y
CONFIG_SERIAL_SAMSUNG_UARTS=4
CONFIG_SERIAL_SAMSUNG_CONSOLE=y
# CONFIG_SERIAL_TEGRA is not set
CONFIG_SERIAL_TEGRA_TCU=m
CONFIG_SERIAL_MAX3100=y
CONFIG_SERIAL_MAX310X=m
CONFIG_SERIAL_IMX=m
CONFIG_SERIAL_IMX_CONSOLE=m
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_SH_SCI=m
CONFIG_SERIAL_SH_SCI_NR_UARTS=2
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_MSM=m
CONFIG_SERIAL_QCOM_GENI=y
# CONFIG_SERIAL_QCOM_GENI_CONSOLE is not set
# CONFIG_SERIAL_VT8500 is not set
CONFIG_SERIAL_OMAP=y
# CONFIG_SERIAL_OMAP_CONSOLE is not set
CONFIG_SERIAL_LANTIQ=m
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
CONFIG_SERIAL_SC16IS7XX_CORE=m
CONFIG_SERIAL_SC16IS7XX=m
CONFIG_SERIAL_SC16IS7XX_I2C=y
# CONFIG_SERIAL_SC16IS7XX_SPI is not set
# CONFIG_SERIAL_TIMBERDALE is not set
CONFIG_SERIAL_BCM63XX=y
CONFIG_SERIAL_BCM63XX_CONSOLE=y
CONFIG_SERIAL_ALTERA_JTAGUART=m
CONFIG_SERIAL_ALTERA_UART=m
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_MXS_AUART=m
CONFIG_SERIAL_MPS2_UART_CONSOLE=y
CONFIG_SERIAL_MPS2_UART=y
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_ST_ASC is not set
CONFIG_SERIAL_MEN_Z135=y
# CONFIG_SERIAL_STM32 is not set
CONFIG_SERIAL_OWL=m
CONFIG_SERIAL_RDA=y
# CONFIG_SERIAL_RDA_CONSOLE is not set
CONFIG_SERIAL_LITEUART=y
CONFIG_SERIAL_LITEUART_MAX_PORTS=1
CONFIG_SERIAL_LITEUART_CONSOLE=y
# CONFIG_SERIAL_SUNPLUS is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=m
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
CONFIG_N_GSM=y
CONFIG_NULL_TTY=m
CONFIG_HVC_DRIVER=y
# CONFIG_RPMSG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_IPMB=m
CONFIG_IPMI_WATCHDOG=m
# CONFIG_IPMI_POWEROFF is not set
CONFIG_IPMI_KCS_BMC=y
CONFIG_ASPEED_KCS_IPMI_BMC=y
CONFIG_NPCM7XX_KCS_IPMI_BMC=y
CONFIG_IPMI_KCS_BMC_CDEV_IPMI=y
CONFIG_IPMI_KCS_BMC_SERIO=m
CONFIG_ASPEED_BT_IPMI_BMC=m
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_BA431=m
# CONFIG_HW_RANDOM_BCM2835 is not set
CONFIG_HW_RANDOM_IPROC_RNG200=m
CONFIG_HW_RANDOM_IXP4XX=m
# CONFIG_HW_RANDOM_OMAP is not set
# CONFIG_HW_RANDOM_OMAP3_ROM is not set
CONFIG_HW_RANDOM_VIRTIO=m
# CONFIG_HW_RANDOM_NOMADIK is not set
CONFIG_HW_RANDOM_STM32=m
CONFIG_HW_RANDOM_MESON=m
CONFIG_HW_RANDOM_MTK=m
CONFIG_HW_RANDOM_EXYNOS=m
CONFIG_HW_RANDOM_NPCM=m
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_DEVMEM is not set
# CONFIG_TCG_TPM is not set
# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
# CONFIG_I2C_MUX is not set
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_ALGOPCA=m
# end of I2C Algorithms

#
# I2C Hardware Bus support
#
# CONFIG_I2C_HIX5HD2 is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_ASPEED=m
CONFIG_I2C_AT91=m
CONFIG_I2C_AT91_SLAVE_EXPERIMENTAL=m
CONFIG_I2C_AXXIA=m
# CONFIG_I2C_BCM_IPROC is not set
CONFIG_I2C_BCM_KONA=m
# CONFIG_I2C_BRCMSTB is not set
# CONFIG_I2C_CADENCE is not set
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DAVINCI=m
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DIGICOLOR=m
CONFIG_I2C_GPIO=m
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_HIGHLANDER=m
# CONFIG_I2C_HISI is not set
CONFIG_I2C_IMG=m
# CONFIG_I2C_IMX is not set
CONFIG_I2C_IMX_LPI2C=m
CONFIG_I2C_IOP3XX=m
CONFIG_I2C_JZ4780=m
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_MT65XX=m
CONFIG_I2C_MT7621=m
CONFIG_I2C_MV64XXX=m
# CONFIG_I2C_MXS is not set
CONFIG_I2C_NPCM=m
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_OMAP=m
CONFIG_I2C_OWL=m
CONFIG_I2C_APPLE=m
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_PNX is not set
CONFIG_I2C_PXA=m
CONFIG_I2C_PXA_SLAVE=y
CONFIG_I2C_QCOM_CCI=m
# CONFIG_I2C_QCOM_GENI is not set
CONFIG_I2C_QUP=m
CONFIG_I2C_RIIC=m
CONFIG_I2C_RZV2M=m
# CONFIG_I2C_S3C2410 is not set
CONFIG_I2C_SH_MOBILE=m
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_ST is not set
CONFIG_I2C_STM32F4=m
CONFIG_I2C_STM32F7=m
CONFIG_I2C_SUN6I_P2WI=m
# CONFIG_I2C_SYNQUACER is not set
CONFIG_I2C_TEGRA_BPMP=m
CONFIG_I2C_UNIPHIER=m
CONFIG_I2C_UNIPHIER_F=m
# CONFIG_I2C_VERSATILE is not set
CONFIG_I2C_WMT=m
CONFIG_I2C_XILINX=m
CONFIG_I2C_XLP9XX=m
CONFIG_I2C_RCAR=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=m
CONFIG_I2C_TAOS_EVM=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_VIRTIO=m
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_SLAVE_TESTUNIT is not set
CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_ALGO=y
CONFIG_I2C_DEBUG_BUS=y
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
CONFIG_SPI_ALTERA_CORE=m
CONFIG_SPI_AR934X=y
CONFIG_SPI_ATH79=m
CONFIG_SPI_ARMADA_3700=y
# CONFIG_SPI_AT91_USART is not set
CONFIG_SPI_AXI_SPI_ENGINE=y
# CONFIG_SPI_BCM2835 is not set
CONFIG_SPI_BCM2835AUX=m
# CONFIG_SPI_BCM63XX is not set
# CONFIG_SPI_BCM63XX_HSSPI is not set
CONFIG_SPI_BCM_QSPI=m
CONFIG_SPI_BITBANG=m
# CONFIG_SPI_BUTTERFLY is not set
CONFIG_SPI_CADENCE=y
CONFIG_SPI_CADENCE_XSPI=m
# CONFIG_SPI_CLPS711X is not set
CONFIG_SPI_DESIGNWARE=y
# CONFIG_SPI_DW_DMA is not set
CONFIG_SPI_DW_MMIO=m
CONFIG_SPI_DW_BT1=y
# CONFIG_SPI_DW_BT1_DIRMAP is not set
# CONFIG_SPI_EP93XX is not set
CONFIG_SPI_FSL_LPSPI=m
CONFIG_SPI_FSL_QUADSPI=y
# CONFIG_SPI_GXP is not set
CONFIG_SPI_HISI_KUNPENG=y
CONFIG_SPI_HISI_SFC_V3XX=m
CONFIG_SPI_NXP_FLEXSPI=y
CONFIG_SPI_GPIO=m
# CONFIG_SPI_IMG_SPFI is not set
CONFIG_SPI_IMX=y
CONFIG_SPI_INGENIC=y
CONFIG_SPI_INTEL=m
CONFIG_SPI_INTEL_PLATFORM=m
CONFIG_SPI_LM70_LLP=m
# CONFIG_SPI_LP8841_RTC is not set
CONFIG_SPI_FSL_DSPI=m
# CONFIG_SPI_MESON_SPIFC is not set
CONFIG_SPI_MICROCHIP_CORE=y
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
CONFIG_SPI_MT65XX=y
CONFIG_SPI_MT7621=y
CONFIG_SPI_MTK_NOR=y
# CONFIG_SPI_NPCM_PSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_OMAP24XX is not set
# CONFIG_SPI_TI_QSPI is not set
CONFIG_SPI_OMAP_100K=y
# CONFIG_SPI_ORION is not set
CONFIG_SPI_PIC32=y
# CONFIG_SPI_PIC32_SQI is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_ROCKCHIP_SFC=y
CONFIG_SPI_RPCIF=m
# CONFIG_SPI_RSPI is not set
CONFIG_SPI_QUP=m
CONFIG_SPI_QCOM_GENI=m
CONFIG_SPI_S3C64XX=y
CONFIG_SPI_SC18IS602=m
CONFIG_SPI_SH=m
CONFIG_SPI_SH_HSPI=m
CONFIG_SPI_SIFIVE=m
CONFIG_SPI_SLAVE_MT27XX=m
CONFIG_SPI_SPRD=m
CONFIG_SPI_SPRD_ADI=y
# CONFIG_SPI_STM32 is not set
CONFIG_SPI_ST_SSC4=m
CONFIG_SPI_SUN4I=y
CONFIG_SPI_SUN6I=m
CONFIG_SPI_SUNPLUS_SP7021=m
# CONFIG_SPI_SYNQUACER is not set
# CONFIG_SPI_MXIC is not set
CONFIG_SPI_TEGRA210_QUAD=m
CONFIG_SPI_TEGRA114=y
# CONFIG_SPI_TEGRA20_SFLASH is not set
# CONFIG_SPI_TEGRA20_SLINK is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_XLP is not set
CONFIG_SPI_XTENSA_XTFPGA=m
CONFIG_SPI_ZYNQ_QSPI=y
CONFIG_SPI_ZYNQMP_GQSPI=y
CONFIG_SPI_AMD=m

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
CONFIG_SPI_LOOPBACK_TEST=m
# CONFIG_SPI_TLE62X0 is not set
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=y
# CONFIG_SPI_SLAVE_SYSTEM_CONTROL is not set
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=m
CONFIG_SPMI_HISI3670=m
CONFIG_SPMI_MSM_PMIC_ARB=m
# CONFIG_SPMI_MTK_PMIF is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
CONFIG_PPS=y
CONFIG_PPS_DEBUG=y

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=y
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# end of PTP clock support

# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_ATH79=y
CONFIG_GPIO_CLPS711X=m
CONFIG_GPIO_DWAPB=m
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_HISI=m
# CONFIG_GPIO_IOP is not set
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MENZ127=m
CONFIG_GPIO_MPC8XXX=y
CONFIG_GPIO_MXC=m
CONFIG_GPIO_MXS=y
CONFIG_GPIO_PXA=y
CONFIG_GPIO_RCAR=y
CONFIG_GPIO_ROCKCHIP=m
# CONFIG_GPIO_SIOX is not set
# CONFIG_GPIO_XGENE_SB is not set
# CONFIG_GPIO_XLP is not set
CONFIG_GPIO_AMD_FCH=y
CONFIG_GPIO_IDT3243X=y
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCA9570=m
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=m
CONFIG_GPIO_TS4900=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_BD9571MWV=m
# CONFIG_GPIO_DA9052 is not set
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP3943=m
CONFIG_GPIO_SL28CPLD=y
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TQMX86=m
# end of MFD GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=y
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_PISOSR=m
CONFIG_GPIO_XRA1403=m
# end of SPI GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_MOCKUP=m
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=m
# end of Virtual GPIO drivers

CONFIG_W1=y
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_MXC=m
CONFIG_W1_MASTER_DS1WM=m
# CONFIG_W1_MASTER_GPIO is not set
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=m
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=m
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=m
CONFIG_GENERIC_ADC_BATTERY=y
CONFIG_IP5XXX_POWER=m
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=m
# CONFIG_BATTERY_ACT8945A is not set
# CONFIG_BATTERY_CPCAP is not set
# CONFIG_BATTERY_CW2015 is not set
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=m
# CONFIG_BATTERY_SAMSUNG_SDI is not set
CONFIG_BATTERY_INGENIC=m
CONFIG_BATTERY_SBS=m
CONFIG_CHARGER_SBS=m
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
# CONFIG_BATTERY_DA9052 is not set
CONFIG_CHARGER_DA9150=m
CONFIG_BATTERY_DA9150=m
CONFIG_AXP20X_POWER=m
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_PCF50633=m
# CONFIG_CHARGER_CPCAP is not set
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=m
CONFIG_CHARGER_LTC4162L=m
CONFIG_CHARGER_MAX77693=m
CONFIG_CHARGER_MAX77976=m
CONFIG_CHARGER_MP2629=m
CONFIG_CHARGER_MT6360=m
CONFIG_CHARGER_BQ2415X=m
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=m
CONFIG_CHARGER_BQ2515X=m
CONFIG_CHARGER_BQ25890=m
# CONFIG_CHARGER_BQ25980 is not set
CONFIG_CHARGER_BQ256XX=m
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=m
CONFIG_BATTERY_RT5033=m
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_SC2731 is not set
CONFIG_FUEL_GAUGE_SC27XX=y
CONFIG_CHARGER_BD99954=m
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_AD7314=m
CONFIG_SENSORS_AD7414=m
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM1177=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_AHT10=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_ARM_SCMI=m
CONFIG_SENSORS_ARM_SCPI=m
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ASPEED is not set
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_BT1_PVT=m
CONFIG_SENSORS_BT1_PVT_ALARMS=y
# CONFIG_SENSORS_CORSAIR_CPRO is not set
CONFIG_SENSORS_CORSAIR_PSU=m
CONFIG_SENSORS_DRIVETEMP=m
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DA9052_ADC=m
CONFIG_SENSORS_SPARX5=m
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_MC13783_ADC=m
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_IIO_HWMON=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
# CONFIG_SENSORS_LAN966X is not set
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
# CONFIG_SENSORS_LTC2947_SPI is not set
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC2992=m
CONFIG_SENSORS_LTC4151=m
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX1111=m
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
CONFIG_SENSORS_MAX31760=m
CONFIG_SENSORS_MAX6620=m
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_TPS23861=m
CONFIG_SENSORS_MENF21BMC_HWMON=m
CONFIG_SENSORS_MR75203=m
CONFIG_SENSORS_ADCXX=m
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM70=m
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=m
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=m
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT6775_I2C=m
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NPCM7XX=m
# CONFIG_SENSORS_OCC_P8_I2C is not set
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PWM_FAN=m
CONFIG_SENSORS_RASPBERRYPI_HWMON=m
# CONFIG_SENSORS_SL28CPLD is not set
CONFIG_SENSORS_SBTSI=m
CONFIG_SENSORS_SBRMI=m
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHT4x=m
CONFIG_SENSORS_SHTC1=m
CONFIG_SENSORS_SY7636A=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA238=m
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=m
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_TMP464=m
CONFIG_SENSORS_TMP513=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
CONFIG_SENSORS_INTEL_M10_BMC_HWMON=m
# CONFIG_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
# CONFIG_SSB_HOST_SOC is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_MIPS=y
CONFIG_BCMA_PFLASH=y
CONFIG_BCMA_NFLASH=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_SUN4I_GPADC=m
CONFIG_MFD_AT91_USART=y
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=m
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
# CONFIG_MFD_MADERA is not set
# CONFIG_MFD_ASIC3 is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=m
CONFIG_MFD_DA9150=m
# CONFIG_MFD_ENE_KB3930 is not set
CONFIG_MFD_EXYNOS_LPASS=m
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=m
CONFIG_MFD_MP2629=m
CONFIG_MFD_MXS_LRADC=m
CONFIG_MFD_MX25_TSADC=y
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_IQS62X is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=m
CONFIG_MFD_88PM805=m
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77650 is not set
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=m
# CONFIG_MFD_MAX77714 is not set
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MT6360=m
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=m
CONFIG_MFD_OCELOT=m
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_CPCAP=y
CONFIG_MFD_NTXEC=m
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
CONFIG_MFD_PM8XXX=m
CONFIG_MFD_SY7636A=m
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SIMPLE_MFD_I2C=m
CONFIG_MFD_SL28CPLD=m
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=m
# CONFIG_MFD_SC27XX_PMIC is not set
CONFIG_ABX500_CORE=y
# CONFIG_MFD_SUN6I_PRCM is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=m
CONFIG_MFD_TI_LMU=m
# CONFIG_TPS6105X is not set
CONFIG_TPS65010=m
CONFIG_TPS6507X=m
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=m
CONFIG_MFD_TPS65912_SPI=y
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_ARIZONA=m
CONFIG_MFD_ARIZONA_I2C=m
# CONFIG_MFD_ARIZONA_SPI is not set
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_STW481X=m
# CONFIG_MFD_STM32_LPTIMER is not set
CONFIG_MFD_STM32_TIMERS=m
CONFIG_MFD_STMFX=m
CONFIG_MFD_ATC260X=m
CONFIG_MFD_ATC260X_I2C=m
# CONFIG_MFD_KHADAS_MCU is not set
# CONFIG_MFD_ACER_A500_EC is not set
CONFIG_RAVE_SP_CORE=m
CONFIG_MFD_INTEL_M10_BMC=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_ANATOP=m
# CONFIG_REGULATOR_ATC260X is not set
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_BD9571MWV=m
# CONFIG_REGULATOR_CPCAP is not set
CONFIG_REGULATOR_DA9052=m
CONFIG_REGULATOR_DA9062=m
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=m
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_FAN53880=m
# CONFIG_REGULATOR_GPIO is not set
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=m
CONFIG_REGULATOR_LP8755=m
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX1586=m
# CONFIG_REGULATOR_MAX77620 is not set
CONFIG_REGULATOR_MAX77650=m
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8893=m
# CONFIG_REGULATOR_MAX8907 is not set
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX20086=m
# CONFIG_REGULATOR_MAX77686 is not set
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MAX77802=m
CONFIG_REGULATOR_MAX77826=m
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=m
CONFIG_REGULATOR_MP8859=m
# CONFIG_REGULATOR_MP886X is not set
CONFIG_REGULATOR_MT6311=m
CONFIG_REGULATOR_MT6315=m
CONFIG_REGULATOR_MT6360=m
# CONFIG_REGULATOR_PBIAS is not set
CONFIG_REGULATOR_PCA9450=m
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=m
CONFIG_REGULATOR_PV88090=m
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_QCOM_RPMH is not set
CONFIG_REGULATOR_QCOM_SPMI=m
CONFIG_REGULATOR_QCOM_USB_VBUS=y
CONFIG_REGULATOR_RT4801=m
CONFIG_REGULATOR_RT5190A=m
# CONFIG_REGULATOR_RT5759 is not set
CONFIG_REGULATOR_RT6160=m
CONFIG_REGULATOR_RT6245=m
CONFIG_REGULATOR_RTQ2134=m
# CONFIG_REGULATOR_RTMV20 is not set
CONFIG_REGULATOR_RTQ6752=m
CONFIG_REGULATOR_S2MPA01=m
CONFIG_REGULATOR_S2MPS11=m
# CONFIG_REGULATOR_S5M8767 is not set
CONFIG_REGULATOR_SC2731=y
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_SLG51000=m
CONFIG_REGULATOR_STM32_BOOSTER=y
# CONFIG_REGULATOR_STM32_VREFBUF is not set
CONFIG_REGULATOR_STM32_PWR=y
CONFIG_REGULATOR_TI_ABB=m
# CONFIG_REGULATOR_STW481X_VMMC is not set
CONFIG_REGULATOR_SY7636A=m
CONFIG_REGULATOR_SY8106A=m
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_SY8827N=m
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS62360=m
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=m
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_TPS68470=y
# CONFIG_REGULATOR_QCOM_LABIBB is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_CEC_PIN=y

#
# CEC support
#
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
CONFIG_CEC_MESON_AO=m
CONFIG_CEC_GPIO=y
CONFIG_CEC_SAMSUNG_S5P=y
CONFIG_CEC_STI=m
CONFIG_CEC_STM32=y
CONFIG_CEC_TEGRA=m
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_IMX_IPUV3_CORE is not set
# CONFIG_DRM is not set

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_MACMODES=y
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
CONFIG_FB_CLPS711X=m
# CONFIG_FB_ARC is not set
CONFIG_FB_CONTROL=y
CONFIG_FB_UVESA=m
CONFIG_FB_GBE=y
CONFIG_FB_GBE_MEM=4
CONFIG_FB_PVR2=m
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_WM8505=y
CONFIG_FB_WMT_GE_ROPS=y
CONFIG_FB_W100=y
CONFIG_FB_TMIO=m
# CONFIG_FB_TMIO_ACCELL is not set
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=m
CONFIG_FB_VIRTUAL=m
CONFIG_FB_METRONOME=m
CONFIG_FB_BROADSHEET=m
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=m
CONFIG_MMP_DISP=m
# CONFIG_MMP_PANEL_TPOHVGA is not set
# CONFIG_MMP_FB is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_L4F00242T03=m
CONFIG_LCD_LMS283GF05=m
CONFIG_LCD_LTV350QV=m
CONFIG_LCD_ILI922X=m
CONFIG_LCD_ILI9320=m
# CONFIG_LCD_TDO24M is not set
CONFIG_LCD_VGG2432A4=m
CONFIG_LCD_PLATFORM=m
CONFIG_LCD_AMS369FG06=m
CONFIG_LCD_LMS501KF03=m
CONFIG_LCD_HX8357=m
CONFIG_LCD_OTM3225A=m
CONFIG_BACKLIGHT_CLASS_DEVICE=m
CONFIG_BACKLIGHT_KTD253=m
CONFIG_BACKLIGHT_LM3533=m
CONFIG_BACKLIGHT_OMAP1=m
CONFIG_BACKLIGHT_PWM=m
CONFIG_BACKLIGHT_DA9052=m
CONFIG_BACKLIGHT_QCOM_WLED=m
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_PCF50633 is not set
CONFIG_BACKLIGHT_LM3630A=m
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_SKY81452 is not set
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=m
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=m
CONFIG_BACKLIGHT_RAVE_SP=m
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y

#
# Console display driver support
#
# CONFIG_VGA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
# CONFIG_FRAMEBUFFER_CONSOLE is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=m
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_COUGAR=m
CONFIG_HID_MACALLY=m
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=m
CONFIG_HID_ELECOM=m
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_VIVALDI_COMMON=m
CONFIG_HID_VIVALDI=m
CONFIG_HID_KEYTOUCH=m
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=m
CONFIG_HID_VIEWSONIC=m
CONFIG_HID_VRC2=m
CONFIG_HID_XIAOMI=m
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=m
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_MAGICMOUSE=m
CONFIG_HID_MALTRON=m
CONFIG_HID_MAYFLASH=m
CONFIG_HID_REDRAGON=m
# CONFIG_HID_MICROSOFT is not set
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NINTENDO=m
# CONFIG_NINTENDO_FF is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PLAYSTATION=m
CONFIG_PLAYSTATION_FF=y
CONFIG_HID_PXRC=m
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SEMITEK is not set
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEAM=m
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
CONFIG_GREENASIA_FF=y
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=m
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# I2C HID support
#
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
# CONFIG_USB_SUPPORT is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=m
# CONFIG_MMC_CRYPTO is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_MOXART=m
CONFIG_MMC_OMAP_HS=m
CONFIG_MMC_DAVINCI=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_S3C=m
# CONFIG_MMC_S3C_HW_SDIO_IRQ is not set
CONFIG_MMC_S3C_PIO=y
# CONFIG_MMC_S3C_DMA is not set
CONFIG_MMC_TMIO_CORE=m
CONFIG_MMC_TMIO=m
CONFIG_MMC_SDHI=m
CONFIG_MMC_SDHI_SYS_DMAC=m
CONFIG_MMC_SDHI_INTERNAL_DMAC=m
CONFIG_MMC_DW=m
CONFIG_MMC_DW_PLTFM=m
# CONFIG_MMC_DW_BLUEFIELD is not set
CONFIG_MMC_DW_EXYNOS=m
CONFIG_MMC_DW_HI3798CV200=m
CONFIG_MMC_DW_K3=m
# CONFIG_MMC_SH_MMCIF is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_CQHCI is not set
CONFIG_MMC_HSQ=m
CONFIG_MMC_BCM2835=m
CONFIG_MMC_OWL=m
# CONFIG_MMC_LITEX is not set
CONFIG_SCSI_UFSHCD=m
# CONFIG_SCSI_UFS_BSG is not set
# CONFIG_SCSI_UFS_CRYPTO is not set
CONFIG_SCSI_UFS_HPB=y
# CONFIG_SCSI_UFS_HWMON is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_CLASS_MULTICOLOR=m
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_ARIEL is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3533=m
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_S3C24XX=m
# CONFIG_LEDS_COBALT_QUBE is not set
# CONFIG_LEDS_COBALT_RAQ is not set
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP50XX=m
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=m
# CONFIG_LEDS_DA9052 is not set
CONFIG_LEDS_DAC124S085=m
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=m
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_MC13783=y
# CONFIG_LEDS_NS2 is not set
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=m
CONFIG_LEDS_IS31FL319X=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_PM8058=m
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=y
CONFIG_LEDS_TI_LMU_COMMON=y
# CONFIG_LEDS_LM36274 is not set
# CONFIG_LEDS_IP30 is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#
# CONFIG_LEDS_PWM_MULTICOLOR is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=m
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=y
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
CONFIG_LEDS_TRIGGER_TTY=y

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH=y
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_ALTERA_MSGDMA=m
CONFIG_APPLE_ADMAC=m
CONFIG_AXI_DMAC=y
CONFIG_BCM_SBA_RAID=m
CONFIG_DMA_JZ4780=m
CONFIG_DMA_SA11X0=m
# CONFIG_DMA_SUN6I is not set
# CONFIG_EP93XX_DMA is not set
CONFIG_IMG_MDC_DMA=m
CONFIG_INTEL_IDMA64=y
CONFIG_INTEL_IOP_ADMA=y
CONFIG_K3_DMA=y
CONFIG_MCF_EDMA=y
# CONFIG_MMP_PDMA is not set
# CONFIG_MMP_TDMA is not set
CONFIG_MV_XOR=y
CONFIG_MXS_DMA=y
CONFIG_NBPFAXI_DMA=m
# CONFIG_STM32_DMA is not set
# CONFIG_STM32_DMAMUX is not set
CONFIG_SPRD_DMA=m
# CONFIG_S3C24XX_DMAC is not set
CONFIG_TEGRA20_APB_DMA=y
CONFIG_TEGRA210_ADMA=m
CONFIG_TIMB_DMA=y
CONFIG_XGENE_DMA=m
CONFIG_XILINX_ZYNQMP_DMA=y
CONFIG_MTK_HSDMA=y
# CONFIG_MTK_CQDMA is not set
CONFIG_QCOM_ADM=m
# CONFIG_QCOM_HIDMA_MGMT is not set
CONFIG_QCOM_HIDMA=m
# CONFIG_DW_DMAC is not set
CONFIG_SF_PDMA=m
CONFIG_RENESAS_DMA=y
# CONFIG_SH_DMAE_BASE is not set
CONFIG_RCAR_DMAC=y
# CONFIG_RENESAS_USB_DMAC is not set
CONFIG_RZ_DMAC=y
# CONFIG_TI_EDMA is not set
# CONFIG_DMA_OMAP is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_UDMABUF is not set
CONFIG_DMABUF_MOVE_NOTIFY=y
CONFIG_DMABUF_DEBUG=y
CONFIG_DMABUF_SELFTESTS=m
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_SYSFS_STATS=y
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
# CONFIG_LINEDISP is not set
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_HT16K33 is not set
# CONFIG_LCD2S is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_PANEL_CHANGE_MESSAGE is not set
CONFIG_CHARLCD_BL_OFF=y
# CONFIG_CHARLCD_BL_ON is not set
# CONFIG_CHARLCD_BL_FLASH is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PLATFORM=y
CONFIG_VFIO_AMBA=m
CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET=m
# CONFIG_VFIO_PLATFORM_AMDXGBE_RESET is not set
# CONFIG_VFIO_PLATFORM_BCMFLEXRM_RESET is not set
CONFIG_VFIO_MDEV=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_VDPA=y
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_INPUT=m
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
CONFIG_VDPA=y
CONFIG_VDPA_USER=m
CONFIG_VHOST_IOTLB=m
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=y
CONFIG_COMEDI_PCL724=m
CONFIG_COMEDI_PCL726=m
# CONFIG_COMEDI_PCL730 is not set
CONFIG_COMEDI_PCL812=m
# CONFIG_COMEDI_PCL816 is not set
CONFIG_COMEDI_PCL818=m
CONFIG_COMEDI_PCM3724=y
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
CONFIG_COMEDI_AMPLC_PC236_ISA=m
CONFIG_COMEDI_AMPLC_PC263_ISA=y
# CONFIG_COMEDI_RTI800 is not set
CONFIG_COMEDI_RTI802=y
CONFIG_COMEDI_DAC02=y
CONFIG_COMEDI_DAS16M1=m
# CONFIG_COMEDI_DAS08_ISA is not set
CONFIG_COMEDI_DAS16=y
# CONFIG_COMEDI_DAS800 is not set
CONFIG_COMEDI_DAS1800=m
# CONFIG_COMEDI_DAS6402 is not set
# CONFIG_COMEDI_DT2801 is not set
CONFIG_COMEDI_DT2811=m
CONFIG_COMEDI_DT2814=y
CONFIG_COMEDI_DT2815=y
CONFIG_COMEDI_DT2817=y
CONFIG_COMEDI_DT282X=m
# CONFIG_COMEDI_DMM32AT is not set
CONFIG_COMEDI_FL512=y
CONFIG_COMEDI_AIO_AIO12_8=y
CONFIG_COMEDI_AIO_IIRO_16=m
CONFIG_COMEDI_II_PCI20KC=y
CONFIG_COMEDI_C6XDIGIO=m
CONFIG_COMEDI_MPC624=y
# CONFIG_COMEDI_ADQ12B is not set
CONFIG_COMEDI_NI_AT_A2150=m
CONFIG_COMEDI_NI_AT_AO=y
# CONFIG_COMEDI_NI_ATMIO is not set
CONFIG_COMEDI_NI_ATMIO16D=m
CONFIG_COMEDI_NI_LABPC_ISA=m
CONFIG_COMEDI_PCMAD=y
# CONFIG_COMEDI_PCMDA12 is not set
# CONFIG_COMEDI_PCMMIO is not set
CONFIG_COMEDI_PCMUIO=m
CONFIG_COMEDI_MULTIQ3=m
CONFIG_COMEDI_S526=y
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
# CONFIG_COMEDI_8255_SA is not set
# CONFIG_COMEDI_KCOMEDILIB is not set
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_AMPLC_PC236=m
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_ROUTING=m
CONFIG_COMEDI_TESTS=m
CONFIG_COMEDI_TESTS_EXAMPLE=m
CONFIG_COMEDI_TESTS_NI_ROUTES=m
# CONFIG_STAGING is not set
CONFIG_GOLDFISH=y
# CONFIG_GOLDFISH_PIPE is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_MLXREG_LC=m
CONFIG_NVSW_SN2201=m
# CONFIG_OLPC_XO175 is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_COMMON_CLK is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_MMIO=y
# CONFIG_BCM2835_TIMER is not set
CONFIG_BCM_KONA_TIMER=y
CONFIG_DAVINCI_TIMER=y
# CONFIG_DIGICOLOR_TIMER is not set
# CONFIG_OMAP_DM_TIMER is not set
CONFIG_DW_APB_TIMER=y
# CONFIG_FTTMR010_TIMER is not set
CONFIG_IXP4XX_TIMER=y
# CONFIG_MESON6_TIMER is not set
CONFIG_OWL_TIMER=y
# CONFIG_RDA_TIMER is not set
CONFIG_SUN4I_TIMER=y
# CONFIG_TEGRA_TIMER is not set
# CONFIG_VT8500_TIMER is not set
# CONFIG_NPCM7XX_TIMER is not set
# CONFIG_ASM9260_TIMER is not set
# CONFIG_CLKSRC_DBX500_PRCMU is not set
# CONFIG_CLPS711X_TIMER is not set
# CONFIG_MXS_TIMER is not set
# CONFIG_NSPIRE_TIMER is not set
# CONFIG_INTEGRATOR_AP_TIMER is not set
CONFIG_CLKSRC_PISTACHIO=y
CONFIG_CLKSRC_STM32_LP=y
CONFIG_ARMV7M_SYSTICK=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_ATMEL_ST is not set
CONFIG_CLKSRC_SAMSUNG_PWM=y
CONFIG_FSL_FTM_TIMER=y
CONFIG_OXNAS_RPS_TIMER=y
CONFIG_MTK_TIMER=y
CONFIG_SH_TIMER_CMT=y
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_RENESAS_OSTM is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
CONFIG_CLKSRC_PXA=y
CONFIG_TIMER_IMX_SYS_CTR=y
CONFIG_CLKSRC_ST_LPC=y
CONFIG_GXP_TIMER=y
# CONFIG_MSC313E_TIMER is not set
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_IMX_MBOX is not set
# CONFIG_ROCKCHIP_MBOX is not set
CONFIG_ALTERA_MBOX=m
# CONFIG_POLARFIRE_SOC_MAILBOX is not set
CONFIG_QCOM_APCS_IPC=m
# CONFIG_BCM_PDC_MBOX is not set
CONFIG_STM32_IPCC=y
# CONFIG_MTK_ADSP_MBOX is not set
CONFIG_MTK_CMDQ_MBOX=y
# CONFIG_SUN6I_MSGBOX is not set
# CONFIG_SPRD_MBOX is not set
# CONFIG_QCOM_IPCC is not set
CONFIG_IOMMU_IOVA=m
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
CONFIG_IOMMU_IO_PGTABLE_ARMV7S=y
# CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST is not set
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y
# CONFIG_OMAP_IOMMU is not set
CONFIG_ROCKCHIP_IOMMU=y
CONFIG_SUN50I_IOMMU=y
CONFIG_EXYNOS_IOMMU=y
CONFIG_EXYNOS_IOMMU_DEBUG=y
CONFIG_S390_CCW_IOMMU=y
CONFIG_S390_AP_IOMMU=y
CONFIG_MTK_IOMMU=y
CONFIG_SPRD_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
CONFIG_INGENIC_VPU_RPROC=m
# CONFIG_MTK_SCP is not set
CONFIG_MESON_MX_AO_ARC_REMOTEPROC=m
# CONFIG_RCAR_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=m
CONFIG_RPMSG_CTRL=m
# CONFIG_RPMSG_NS is not set
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# CONFIG_MESON_CANVAS is not set
CONFIG_MESON_CLK_MEASURE=y
# CONFIG_MESON_GX_SOCINFO is not set
CONFIG_MESON_MX_SOCINFO=y
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
# CONFIG_APPLE_RTKIT is not set
CONFIG_APPLE_SART=m
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
# CONFIG_ASPEED_LPC_CTRL is not set
CONFIG_ASPEED_LPC_SNOOP=m
CONFIG_ASPEED_UART_ROUTING=y
# CONFIG_ASPEED_P2A_CTRL is not set
# CONFIG_ASPEED_SOCINFO is not set
# end of ASPEED SoC drivers

CONFIG_AT91_SOC_ID=y
CONFIG_AT91_SOC_SFR=y

#
# Broadcom SoC drivers
#
CONFIG_SOC_BCM63XX=y
# CONFIG_SOC_BRCMSTB is not set
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
CONFIG_SOC_IMX8M=y
CONFIG_SOC_IMX9=m
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
CONFIG_IXP4XX_NPE=m
# end of IXP4xx SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=m
# end of Enable LiteX SoC Builder specific drivers

#
# MediaTek SoC drivers
#
CONFIG_MTK_CMDQ=m
# CONFIG_MTK_DEVAPC is not set
CONFIG_MTK_INFRACFG=y
CONFIG_MTK_MMSYS=y
# end of MediaTek SoC drivers

#
# Qualcomm SoC drivers
#
CONFIG_QCOM_GENI_SE=y
# CONFIG_QCOM_GSBI is not set
CONFIG_QCOM_LLCC=y
# CONFIG_QCOM_RPMH is not set
# CONFIG_QCOM_SMD_RPM is not set
# CONFIG_QCOM_SPM is not set
# CONFIG_QCOM_WCNSS_CTRL is not set
# CONFIG_QCOM_APR is not set
# CONFIG_QCOM_ICC_BWMON is not set
# end of Qualcomm SoC drivers

CONFIG_SOC_RENESAS=y
# CONFIG_RST_RCAR is not set
CONFIG_SYSC_RCAR=y
CONFIG_SYSC_RCAR_GEN4=y
CONFIG_SYSC_R8A77995=y
# CONFIG_SYSC_R8A7794 is not set
# CONFIG_SYSC_R8A77990 is not set
CONFIG_SYSC_R8A7779=y
# CONFIG_SYSC_R8A7790 is not set
# CONFIG_SYSC_R8A7795 is not set
CONFIG_SYSC_R8A7791=y
# CONFIG_SYSC_R8A77965 is not set
# CONFIG_SYSC_R8A77960 is not set
# CONFIG_SYSC_R8A77961 is not set
# CONFIG_SYSC_R8A779F0 is not set
# CONFIG_SYSC_R8A7792 is not set
# CONFIG_SYSC_R8A77980 is not set
# CONFIG_SYSC_R8A77970 is not set
# CONFIG_SYSC_R8A779A0 is not set
CONFIG_SYSC_R8A779G0=y
CONFIG_SYSC_RMOBILE=y
# CONFIG_SYSC_R8A77470 is not set
CONFIG_SYSC_R8A7745=y
CONFIG_SYSC_R8A7742=y
# CONFIG_SYSC_R8A7743 is not set
# CONFIG_SYSC_R8A774C0 is not set
# CONFIG_SYSC_R8A774E1 is not set
# CONFIG_SYSC_R8A774A1 is not set
CONFIG_SYSC_R8A774B1=y
CONFIG_ROCKCHIP_GRF=y
CONFIG_SOC_SAMSUNG=y
# CONFIG_EXYNOS_ASV_ARM is not set
CONFIG_EXYNOS_CHIPID=y
CONFIG_EXYNOS_USI=y
# CONFIG_EXYNOS_PM_DOMAINS is not set
# CONFIG_EXYNOS_REGULATOR_COUPLER is not set
CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER=y
CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER=y
# CONFIG_SOC_TI is not set
CONFIG_UX500_SOC_ID=y

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
# CONFIG_ARM_EXYNOS_BUS_DEVFREQ is not set
# CONFIG_ARM_IMX_BUS_DEVFREQ is not set
CONFIG_ARM_MEDIATEK_CCI_DEVFREQ=y
CONFIG_PM_DEVFREQ_EVENT=y
# CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP is not set
CONFIG_DEVFREQ_EVENT_EXYNOS_PPMU=m
CONFIG_DEVFREQ_EVENT_ROCKCHIP_DFI=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_MAX3355=m
# CONFIG_EXTCON_MAX77693 is not set
# CONFIG_EXTCON_PTN5150 is not set
# CONFIG_EXTCON_QCOM_SPMI_MISC is not set
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=m
CONFIG_MEMORY=y
CONFIG_DDR=y
CONFIG_BRCMSTB_DPFE=m
CONFIG_BRCMSTB_MEMC=m
# CONFIG_BT1_L2_CTL is not set
CONFIG_TI_EMIF=y
CONFIG_FSL_CORENET_CF=y
# CONFIG_FSL_IFC is not set
CONFIG_MTK_SMI=y
CONFIG_DA8XX_DDRCTL=y
CONFIG_RENESAS_RPCIF=m
CONFIG_STM32_FMC2_EBI=m
# CONFIG_SAMSUNG_MC is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
# CONFIG_IIO_SW_TRIGGER is not set
# CONFIG_IIO_TRIGGERED_EVENT is not set

#
# Accelerometers
#
CONFIG_ADIS16201=y
# CONFIG_ADIS16209 is not set
CONFIG_ADXL313=m
CONFIG_ADXL313_I2C=m
CONFIG_ADXL313_SPI=m
CONFIG_ADXL345=m
CONFIG_ADXL345_I2C=m
CONFIG_ADXL345_SPI=m
CONFIG_ADXL355=m
# CONFIG_ADXL355_I2C is not set
CONFIG_ADXL355_SPI=m
CONFIG_ADXL367=m
CONFIG_ADXL367_SPI=m
CONFIG_ADXL367_I2C=m
CONFIG_ADXL372=y
CONFIG_ADXL372_SPI=y
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA180=m
# CONFIG_BMA220 is not set
# CONFIG_BMA400 is not set
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_BMC150_ACCEL_SPI=y
CONFIG_BMI088_ACCEL=y
CONFIG_BMI088_ACCEL_SPI=y
CONFIG_DA280=m
# CONFIG_DA311 is not set
# CONFIG_DMARD06 is not set
CONFIG_DMARD09=m
# CONFIG_DMARD10 is not set
CONFIG_FXLS8962AF=m
CONFIG_FXLS8962AF_I2C=m
CONFIG_FXLS8962AF_SPI=m
CONFIG_KXSD9=y
# CONFIG_KXSD9_SPI is not set
CONFIG_KXSD9_I2C=m
CONFIG_KXCJK1013=m
CONFIG_MC3230=m
CONFIG_MMA7455=y
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7455_SPI=y
CONFIG_MMA7660=m
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
# CONFIG_MMA9553 is not set
# CONFIG_MSA311 is not set
CONFIG_MXC4005=m
CONFIG_MXC6255=m
CONFIG_SCA3000=m
# CONFIG_SCA3300 is not set
CONFIG_STK8312=m
CONFIG_STK8BA50=m
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7091R5=m
CONFIG_AD7124=y
CONFIG_AD7192=y
# CONFIG_AD7266 is not set
CONFIG_AD7280=m
# CONFIG_AD7291 is not set
# CONFIG_AD7292 is not set
# CONFIG_AD7298 is not set
CONFIG_AD7476=m
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
# CONFIG_AD7606_IFACE_SPI is not set
CONFIG_AD7766=m
CONFIG_AD7768_1=m
# CONFIG_AD7780 is not set
CONFIG_AD7791=m
CONFIG_AD7793=y
CONFIG_AD7887=y
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_AT91_SAMA5D2_ADC is not set
# CONFIG_AXP20X_ADC is not set
# CONFIG_AXP288_ADC is not set
CONFIG_BCM_IPROC_ADC=y
CONFIG_BERLIN2_ADC=m
CONFIG_CPCAP_ADC=m
CONFIG_DA9150_GPADC=m
CONFIG_ENVELOPE_DETECTOR=y
CONFIG_MXS_LRADC_ADC=m
# CONFIG_FSL_MX25_ADC is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
CONFIG_INGENIC_ADC=m
CONFIG_IMX7D_ADC=y
CONFIG_IMX8QXP_ADC=m
CONFIG_LPC18XX_ADC=y
# CONFIG_LPC32XX_ADC is not set
CONFIG_LTC2471=m
CONFIG_LTC2485=m
CONFIG_LTC2496=m
CONFIG_LTC2497=m
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
CONFIG_MAX1118=m
# CONFIG_MAX11205 is not set
# CONFIG_MAX1241 is not set
CONFIG_MAX1363=m
# CONFIG_MAX9611 is not set
CONFIG_MCP320X=m
CONFIG_MCP3422=m
CONFIG_MCP3911=y
CONFIG_MEDIATEK_MT6360_ADC=m
# CONFIG_MEDIATEK_MT6577_AUXADC is not set
CONFIG_MEN_Z188_ADC=y
CONFIG_MP2629_ADC=m
CONFIG_NAU7802=m
CONFIG_NPCM_ADC=m
CONFIG_QCOM_VADC_COMMON=m
CONFIG_QCOM_PM8XXX_XOADC=m
CONFIG_QCOM_SPMI_IADC=m
CONFIG_QCOM_SPMI_VADC=m
# CONFIG_QCOM_SPMI_ADC5 is not set
CONFIG_RCAR_GYRO_ADC=y
CONFIG_ROCKCHIP_SARADC=m
CONFIG_RICHTEK_RTQ6056=m
CONFIG_RZG2L_ADC=m
CONFIG_SC27XX_ADC=m
CONFIG_SPEAR_ADC=m
CONFIG_SD_ADC_MODULATOR=y
CONFIG_STM32_DFSDM_CORE=y
CONFIG_STM32_DFSDM_ADC=y
CONFIG_SUN4I_GPADC=m
CONFIG_TI_ADC081C=m
CONFIG_TI_ADC0832=m
# CONFIG_TI_ADC084S021 is not set
CONFIG_TI_ADC12138=m
# CONFIG_TI_ADC108S102 is not set
CONFIG_TI_ADC128S052=y
CONFIG_TI_ADC161S626=m
CONFIG_TI_ADS1015=m
CONFIG_TI_ADS7950=y
# CONFIG_TI_ADS8344 is not set
CONFIG_TI_ADS8688=m
CONFIG_TI_ADS124S08=y
CONFIG_TI_ADS131E08=m
CONFIG_TI_AM335X_ADC=m
CONFIG_TI_TLC4541=y
CONFIG_TI_TSC2046=y
CONFIG_VF610_ADC=m
CONFIG_XILINX_XADC=y
CONFIG_XILINX_AMS=m
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# CONFIG_AD74413R is not set
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=m
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=y
CONFIG_ADA4250=y
CONFIG_HMC425=y
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=m
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
# CONFIG_ATLAS_EZO_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=m
# CONFIG_PMS7003 is not set
CONFIG_SCD30_CORE=y
# CONFIG_SCD30_I2C is not set
# CONFIG_SCD30_SERIAL is not set
CONFIG_SCD4X=m
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SENSIRION_SGP40 is not set
CONFIG_SPS30=m
CONFIG_SPS30_I2C=m
# CONFIG_SPS30_SERIAL is not set
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=m

#
# IIO SCMI Sensors
#
CONFIG_IIO_SCMI=y
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=m
CONFIG_IIO_SSP_SENSORHUB=m
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_SPI=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Digital to analog converters
#
CONFIG_AD3552R=y
CONFIG_AD5064=m
# CONFIG_AD5360 is not set
CONFIG_AD5380=m
CONFIG_AD5421=y
CONFIG_AD5446=m
# CONFIG_AD5449 is not set
CONFIG_AD5592R_BASE=y
CONFIG_AD5592R=y
CONFIG_AD5593R=m
CONFIG_AD5504=m
# CONFIG_AD5624R_SPI is not set
CONFIG_LTC2688=y
CONFIG_AD5686=m
# CONFIG_AD5686_SPI is not set
CONFIG_AD5696_I2C=m
CONFIG_AD5755=m
# CONFIG_AD5758 is not set
CONFIG_AD5761=m
CONFIG_AD5764=m
# CONFIG_AD5766 is not set
CONFIG_AD5770R=y
CONFIG_AD5791=m
# CONFIG_AD7293 is not set
CONFIG_AD7303=y
CONFIG_AD8801=m
# CONFIG_DPOT_DAC is not set
CONFIG_DS4424=m
CONFIG_LPC18XX_DAC=y
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_M62332 is not set
CONFIG_MAX517=m
CONFIG_MAX5821=m
CONFIG_MCP4725=m
# CONFIG_MCP4922 is not set
# CONFIG_STM32_DAC is not set
CONFIG_TI_DAC082S085=m
CONFIG_TI_DAC5571=m
CONFIG_TI_DAC7311=y
CONFIG_TI_DAC7612=m
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_DUMMY_EVGEN=m
CONFIG_IIO_SIMPLE_DUMMY=m
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y
# end of IIO dummy driver

#
# Filters
#
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=m
CONFIG_ADF4371=y
CONFIG_ADMV4420=y
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=m
CONFIG_ADIS16130=m
CONFIG_ADIS16136=m
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS290 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=m
CONFIG_FXAS21002C_SPI=y
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=m
# CONFIG_IIO_ST_GYRO_I2C_3AXIS is not set
CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
CONFIG_AFE4404=m
# CONFIG_MAX30100 is not set
CONFIG_MAX30102=m
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=m
CONFIG_DHT11=m
CONFIG_HDC100X=m
CONFIG_HDC2010=m
# CONFIG_HTS221 is not set
CONFIG_HTU21=m
# CONFIG_SI7005 is not set
CONFIG_SI7020=m
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
CONFIG_ADIS16460=y
CONFIG_ADIS16475=m
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
CONFIG_BOSCH_BNO055=m
CONFIG_BOSCH_BNO055_SERIAL=m
# CONFIG_BOSCH_BNO055_I2C is not set
CONFIG_FXOS8700=m
CONFIG_FXOS8700_I2C=m
# CONFIG_FXOS8700_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_ICM42600_I2C is not set
# CONFIG_INV_ICM42600_SPI is not set
CONFIG_INV_MPU6050_IIO=m
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_INV_MPU6050_SPI=m
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ADJD_S311 is not set
CONFIG_ADUX1020=m
# CONFIG_AL3010 is not set
CONFIG_AL3320A=m
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=m
CONFIG_AS73211=m
CONFIG_BH1750=m
CONFIG_BH1780=m
# CONFIG_CM32181 is not set
CONFIG_CM3232=m
# CONFIG_CM3323 is not set
CONFIG_CM3605=m
CONFIG_CM36651=m
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=m
# CONFIG_IQS621_ALS is not set
CONFIG_SENSORS_ISL29018=m
CONFIG_SENSORS_ISL29028=m
# CONFIG_ISL29125 is not set
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
CONFIG_SENSORS_LM3533=m
# CONFIG_LTR501 is not set
CONFIG_LTRF216A=m
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
CONFIG_MAX44009=m
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=m
CONFIG_PA12203001=m
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
CONFIG_STK3310=m
# CONFIG_ST_UVIS25 is not set
CONFIG_TCS3414=m
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=m
# CONFIG_TSL2583 is not set
# CONFIG_TSL2591 is not set
CONFIG_TSL2772=m
# CONFIG_TSL4531 is not set
CONFIG_US5182D=m
# CONFIG_VCNL4000 is not set
CONFIG_VCNL4035=m
CONFIG_VEML6030=m
CONFIG_VEML6070=m
CONFIG_VL6180=m
CONFIG_ZOPT2201=m
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_BMC150_MAGN_SPI=m
CONFIG_MAG3110=m
CONFIG_MMC35240=m
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_HMC5843_SPI=m
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=m
CONFIG_SENSORS_RM3100_SPI=y
CONFIG_YAMAHA_YAS530=m
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

CONFIG_IIO_RESCALE_KUNIT_TEST=m
# CONFIG_IIO_FORMAT_KUNIT_TEST is not set

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_STM32_LPTIMER_TRIGGER=y
# CONFIG_IIO_STM32_TIMER_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=m
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=m
CONFIG_AD5272=m
# CONFIG_DS1803 is not set
CONFIG_MAX5432=m
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
CONFIG_MCP4018=m
CONFIG_MCP4131=m
# CONFIG_MCP4531 is not set
CONFIG_MCP41010=m
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=m
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=m
CONFIG_BMP280=y
CONFIG_BMP280_I2C=m
CONFIG_BMP280_SPI=y
CONFIG_DLHL60D=m
CONFIG_DPS310=m
CONFIG_HP03=m
CONFIG_ICP10100=m
CONFIG_MPL115=y
CONFIG_MPL115_I2C=m
CONFIG_MPL115_SPI=y
CONFIG_MPL3115=m
CONFIG_MS5611=y
CONFIG_MS5611_I2C=m
# CONFIG_MS5611_SPI is not set
CONFIG_MS5637=m
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=m
CONFIG_HP206C=m
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=m
CONFIG_ZPA2326_SPI=y
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=m
CONFIG_LIDAR_LITE_V2=m
CONFIG_MB1232=m
CONFIG_PING=y
CONFIG_RFD77402=m
CONFIG_SRF04=m
CONFIG_SX_COMMON=m
CONFIG_SX9310=m
CONFIG_SX9324=m
CONFIG_SX9360=m
CONFIG_SX9500=m
# CONFIG_SRF08 is not set
CONFIG_VCNL3020=m
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
CONFIG_AD2S90=y
CONFIG_AD2S1200=y
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=y
CONFIG_LTC2983=m
# CONFIG_MAXIM_THERMOCOUPLE is not set
CONFIG_MLX90614=m
CONFIG_MLX90632=m
CONFIG_TMP006=m
# CONFIG_TMP007 is not set
CONFIG_TMP117=m
CONFIG_TSYS01=m
CONFIG_TSYS02D=m
# CONFIG_MAX31856 is not set
CONFIG_MAX31865=m
# end of Temperature sensors

CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_BCM2835=y
CONFIG_PWM_BERLIN=m
CONFIG_PWM_BRCMSTB=m
CONFIG_PWM_CLK=m
# CONFIG_PWM_CLPS711X is not set
# CONFIG_PWM_EP93XX is not set
CONFIG_PWM_HIBVT=y
# CONFIG_PWM_IMX1 is not set
CONFIG_PWM_IMX27=m
CONFIG_PWM_INTEL_LGM=m
CONFIG_PWM_IQS620A=y
CONFIG_PWM_LP3943=m
# CONFIG_PWM_LPC18XX_SCT is not set
# CONFIG_PWM_LPC32XX is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_MTK_DISP is not set
CONFIG_PWM_MEDIATEK=y
CONFIG_PWM_NTXEC=m
CONFIG_PWM_PCA9685=m
# CONFIG_PWM_PXA is not set
CONFIG_PWM_RASPBERRYPI_POE=y
CONFIG_PWM_RCAR=y
# CONFIG_PWM_RENESAS_TPU is not set
CONFIG_PWM_ROCKCHIP=m
# CONFIG_PWM_SAMSUNG is not set
CONFIG_PWM_SL28CPLD=y
CONFIG_PWM_SPRD=y
CONFIG_PWM_STM32=m
CONFIG_PWM_STM32_LP=y
CONFIG_PWM_TEGRA=m
# CONFIG_PWM_TIECAP is not set
CONFIG_PWM_TIEHRPWM=m
CONFIG_PWM_VISCONTI=y
# CONFIG_PWM_VT8500 is not set

#
# IRQ chip support
#
# CONFIG_AL_FIC is not set
CONFIG_RENESAS_INTC_IRQPIN=y
CONFIG_RENESAS_IRQC=y
CONFIG_RENESAS_RZA1_IRQC=y
CONFIG_RENESAS_RZG2L_IRQC=y
# CONFIG_SL28CPLD_INTC is not set
CONFIG_TS4800_IRQ=m
CONFIG_INGENIC_TCU_IRQ=y
# CONFIG_IRQ_UNIPHIER_AIDET is not set
# CONFIG_MESON_IRQ_GPIO is not set
# CONFIG_IMX_IRQSTEER is not set
# CONFIG_IMX_INTMUX is not set
# CONFIG_EXYNOS_IRQ_COMBINER is not set
CONFIG_MST_IRQ=y
CONFIG_MCHP_EIC=y
CONFIG_SUNPLUS_SP7021_INTC=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_A10SR=m
CONFIG_RESET_ATH79=y
# CONFIG_RESET_AXS10X is not set
# CONFIG_RESET_BCM6345 is not set
CONFIG_RESET_BERLIN=y
CONFIG_RESET_BRCMSTB=y
CONFIG_RESET_BRCMSTB_RESCAL=m
# CONFIG_RESET_HSDK is not set
CONFIG_RESET_IMX7=m
CONFIG_RESET_LANTIQ=y
CONFIG_RESET_LPC18XX=y
CONFIG_RESET_MCHP_SPARX5=y
# CONFIG_RESET_MESON is not set
CONFIG_RESET_MESON_AUDIO_ARB=y
CONFIG_RESET_NPCM=y
CONFIG_RESET_PISTACHIO=y
CONFIG_RESET_QCOM_AOSS=y
# CONFIG_RESET_QCOM_PDC is not set
CONFIG_RESET_RASPBERRYPI=m
# CONFIG_RESET_RZG2L_USBPHY_CTRL is not set
CONFIG_RESET_SCMI=y
CONFIG_RESET_SIMPLE=y
CONFIG_RESET_SOCFPGA=y
CONFIG_RESET_STARFIVE_JH7100=y
# CONFIG_RESET_SUNPLUS is not set
# CONFIG_RESET_SUNXI is not set
# CONFIG_RESET_TI_SCI is not set
# CONFIG_RESET_TI_SYSCON is not set
CONFIG_RESET_TI_TPS380X=y
CONFIG_RESET_TN48M_CPLD=y
# CONFIG_RESET_ZYNQ is not set
CONFIG_COMMON_RESET_HI3660=y
CONFIG_COMMON_RESET_HI6220=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_PHY_PISTACHIO_USB=y
CONFIG_PHY_CAN_TRANSCEIVER=y

#
# PHY drivers for Broadcom platforms
#
CONFIG_PHY_BCM63XX_USBH=m
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_NS2_PCIE is not set
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_HI6220_USB=y
CONFIG_PHY_HI3660_USB=y
CONFIG_PHY_HI3670_USB=m
CONFIG_PHY_HI3670_PCIE=y
CONFIG_PHY_HISTB_COMBPHY=m
# CONFIG_PHY_HISI_INNO_USB2 is not set
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=m
# CONFIG_PHY_PXA_USB is not set
CONFIG_PHY_MMP3_USB=y
CONFIG_PHY_MMP3_HSIC=m
# CONFIG_PHY_MT7621_PCI is not set
CONFIG_PHY_RALINK_USB=y
CONFIG_PHY_RCAR_GEN3_USB3=m
# CONFIG_PHY_ROCKCHIP_DPHY_RX0 is not set
# CONFIG_PHY_ROCKCHIP_PCIE is not set
CONFIG_PHY_ROCKCHIP_SNPS_PCIE3=m
# CONFIG_PHY_EXYNOS_MIPI_VIDEO is not set
CONFIG_PHY_SAMSUNG_USB2=m
CONFIG_PHY_S5PV210_USB2=y
CONFIG_PHY_ST_SPEAR1310_MIPHY=m
CONFIG_PHY_ST_SPEAR1340_MIPHY=y
CONFIG_PHY_STIH407_USB=y
CONFIG_PHY_TEGRA194_P2U=m
# CONFIG_PHY_DA8XX_USB is not set
CONFIG_OMAP_CONTROL_PHY=y
CONFIG_TI_PIPE3=m
CONFIG_PHY_INTEL_KEEMBAY_EMMC=y
# CONFIG_PHY_INTEL_KEEMBAY_USB is not set
CONFIG_PHY_INTEL_LGM_EMMC=y
CONFIG_PHY_XILINX_ZYNQMP=m
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=y
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
CONFIG_ARM_CCN=y
CONFIG_ARM_CMN=m
CONFIG_FSL_IMX8_DDR_PMU=y
# CONFIG_ARM_DMC620_PMU is not set
# CONFIG_ALIBABA_UNCORE_DRW_PMU is not set
# end of Performance monitor support

CONFIG_RAS=y

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_APPLE_EFUSES is not set
CONFIG_NVMEM_BCM_OCOTP=m
CONFIG_NVMEM_BRCM_NVRAM=y
# CONFIG_NVMEM_IMX_IIM is not set
CONFIG_NVMEM_IMX_OCOTP=m
CONFIG_NVMEM_LAN9662_OTPC=y
CONFIG_NVMEM_LAYERSCAPE_SFP=y
CONFIG_NVMEM_LPC18XX_EEPROM=m
CONFIG_NVMEM_LPC18XX_OTP=m
CONFIG_NVMEM_MESON_MX_EFUSE=y
CONFIG_NVMEM_MICROCHIP_OTPC=m
# CONFIG_NVMEM_MTK_EFUSE is not set
# CONFIG_NVMEM_MXS_OCOTP is not set
# CONFIG_NVMEM_NINTENDO_OTP is not set
CONFIG_NVMEM_QCOM_QFPROM=m
CONFIG_NVMEM_RAVE_SP_EEPROM=m
CONFIG_NVMEM_RMEM=y
CONFIG_NVMEM_ROCKCHIP_EFUSE=m
CONFIG_NVMEM_ROCKCHIP_OTP=m
CONFIG_NVMEM_SC27XX_EFUSE=y
CONFIG_NVMEM_SNVS_LPGPR=m
CONFIG_NVMEM_SPMI_SDAM=m
CONFIG_NVMEM_SPRD_EFUSE=y
# CONFIG_NVMEM_STM32_ROMEM is not set
# CONFIG_NVMEM_SUNPLUS_OCOTP is not set
# CONFIG_NVMEM_UNIPHIER_EFUSE is not set
CONFIG_NVMEM_VF610_OCOTP=m

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
CONFIG_MUX_ADGS1408=m
# CONFIG_MUX_GPIO is not set
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=m
CONFIG_SIOX_BUS_GPIO=m
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=y
CONFIG_INTERCONNECT_IMX=y
# CONFIG_INTERCONNECT_IMX8MM is not set
CONFIG_INTERCONNECT_IMX8MN=y
CONFIG_INTERCONNECT_IMX8MQ=m
CONFIG_INTERCONNECT_IMX8MP=m
CONFIG_INTERCONNECT_QCOM_OSM_L3=m
CONFIG_INTERCONNECT_SAMSUNG=y
CONFIG_INTERCONNECT_EXYNOS=y
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=m
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_CHECK=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=m
# CONFIG_F2FS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
# CONFIG_DNOTIFY is not set
# CONFIG_INOTIFY_USER is not set
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_NFS_EXPORT=y
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_KUNIT_TEST=m
CONFIG_EXFAT_FS=m
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
# CONFIG_NTFS_FS is not set
CONFIG_NTFS3_FS=y
# CONFIG_NTFS3_LZX_XPRESS is not set
CONFIG_NTFS3_FS_POSIX_ACL=y
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
# CONFIG_TMPFS is not set
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=y
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=m
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=m
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=m
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
# CONFIG_KEYS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY is not set
# CONFIG_SECURITY_APPARMOR_PARANOID_LOAD is not set
CONFIG_SECURITY_LOADPIN=y
CONFIG_SECURITY_LOADPIN_ENFORCE=y
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
# CONFIG_INTEGRITY is not set
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_ENABLER=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_STACK_ALL_PATTERN is not set
# CONFIG_INIT_STACK_ALL_ZERO is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
# end of Memory initialization

CONFIG_CC_HAS_RANDSTRUCT=y
CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_TX_DISABLE_PQ_VAL_DMA=y
CONFIG_ASYNC_TX_DISABLE_XOR_VAL_DMA=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=m
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_ENGINE=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=m
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_ECDSA=m
# CONFIG_CRYPTO_ECRDSA is not set
CONFIG_CRYPTO_SM2=m
CONFIG_CRYPTO_CURVE25519=m
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_SM4_GENERIC=m
CONFIG_CRYPTO_TEA=y
# CONFIG_CRYPTO_TWOFISH is not set
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=y
# CONFIG_CRYPTO_ARC4 is not set
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CBC is not set
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=m
CONFIG_CRYPTO_HCTR2=y
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XCTR=y
# CONFIG_CRYPTO_XTS is not set
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=m
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_SEQIV is not set
CONFIG_CRYPTO_ECHAINIV=y
# CONFIG_CRYPTO_ESSIV is not set
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_POLYVAL=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_SM3_GENERIC=m
CONFIG_CRYPTO_STREEBOG=m
# CONFIG_CRYPTO_VMAC is not set
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_XXHASH=y
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=m
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_USER_API_RNG=y
CONFIG_CRYPTO_USER_API_RNG_CAVP=y
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_ALLWINNER is not set
CONFIG_CRYPTO_DEV_EXYNOS_RNG=y
CONFIG_CRYPTO_DEV_S5P=y
CONFIG_CRYPTO_DEV_ATMEL_AUTHENC=y
CONFIG_CRYPTO_DEV_ATMEL_AES=m
# CONFIG_CRYPTO_DEV_ATMEL_TDES is not set
CONFIG_CRYPTO_DEV_ATMEL_SHA=m
CONFIG_CRYPTO_DEV_ATMEL_I2C=m
CONFIG_CRYPTO_DEV_ATMEL_ECC=m
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=m
CONFIG_CRYPTO_DEV_QCE=y
CONFIG_CRYPTO_DEV_QCE_AEAD=y
# CONFIG_CRYPTO_DEV_QCE_ENABLE_ALL is not set
# CONFIG_CRYPTO_DEV_QCE_ENABLE_SKCIPHER is not set
# CONFIG_CRYPTO_DEV_QCE_ENABLE_SHA is not set
CONFIG_CRYPTO_DEV_QCE_ENABLE_AEAD=y
CONFIG_CRYPTO_DEV_QCOM_RNG=y
CONFIG_CRYPTO_DEV_IMGTEC_HASH=y
# CONFIG_CRYPTO_DEV_ZYNQMP_AES is not set
CONFIG_CRYPTO_DEV_ZYNQMP_SHA3=m
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_CRYPTO_DEV_SAFEXCEL=y
CONFIG_CRYPTO_DEV_HISI_SEC=m
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_CRYPTO_DEV_SA2UL=m
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4=y
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_ECB is not set
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CTS=y
CONFIG_CRYPTO_DEV_ASPEED=m
# CONFIG_CRYPTO_DEV_ASPEED_DEBUG is not set
CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH=y
# CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO is not set

#
# Certificates for signature checking
#
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=m
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_STMP_DEVICE=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=m
CONFIG_CRYPTO_LIB_CURVE25519=m
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=m
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
CONFIG_AUDIT_GENERIC=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE=y
CONFIG_DMA_GLOBAL_POOL=y
CONFIG_DMA_API_DEBUG=y
# CONFIG_DMA_API_DEBUG_SG is not set
CONFIG_SGL_ALLOC=y
CONFIG_FORCE_NR_CPUS=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_GENERIC_ATOMIC64=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_SG_SPLIT=y
CONFIG_SG_POOL=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_PARMAN=m
# CONFIG_OBJAGG is not set
# end of Library routines

CONFIG_POLYNOMIAL=m

#
# Kernel hacking
#

#
# printk and dmesg options
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_PRINTK_CALLER is not set
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
# CONFIG_SYMBOLIC_ERRNAME is not set
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

# CONFIG_DEBUG_KERNEL is not set

#
# Compile-time checks and compiler options
#
CONFIG_AS_HAS_NON_CONST_LEB128=y
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_DEBUG_FS is not set
CONFIG_HAVE_ARCH_KGDB=y
CONFIG_UBSAN=y
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_UNREACHABLE is not set
# CONFIG_UBSAN_BOOL is not set
CONFIG_UBSAN_ENUM=y
CONFIG_TEST_UBSAN=m
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_POISONING=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# end of Memory Debugging

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_WW_MUTEX_SELFTEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set

#
# Debug kernel data structures
#
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

#
# RCU Debugging
#
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# end of RCU Debugging

CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_SAMPLES is not set
# CONFIG_STRICT_DEVMEM is not set

#
# hexagon Debugging
#
# end of hexagon Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=m
# CONFIG_KUNIT_DEBUGFS is not set
# CONFIG_KUNIT_TEST is not set
CONFIG_KUNIT_EXAMPLE_TEST=m
CONFIG_KUNIT_ALL_TESTS=m
CONFIG_KUNIT_DEFAULT_ENABLED=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking

# CONFIG_WARN_MISSING_DOCUMENTS is not set
CONFIG_WARN_ABI_ERRORS=y
# end of Kernel hacking

--AtVS2kTAQfVwRkWS--
