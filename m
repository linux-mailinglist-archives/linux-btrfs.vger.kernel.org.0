Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6471D3705A9
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 May 2021 06:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhEAExe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 May 2021 00:53:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:52137 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhEAExc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 May 2021 00:53:32 -0400
IronPort-SDR: Cox5hQT26ixoNdzvdeuj1FmYLyXLZmJ4ND9C4xcBl/7ewJvY4Q+nSVpcd/nliVsQFR4GDCn3V8
 qt3CJ5QPFBYA==
X-IronPort-AV: E=McAfee;i="6200,9189,9970"; a="196989913"
X-IronPort-AV: E=Sophos;i="5.82,264,1613462400"; 
   d="gz'50?scan'50,208,50";a="196989913"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 21:52:43 -0700
IronPort-SDR: a2fYmptpa3Zoc2ztdRJ7Jqu2Y2K0OWCTz5QPBj5L0+NaFBCxOMT6HazbgAD5Z0C0r2yusqzAM5
 EIBVoirYZoag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,264,1613462400"; 
   d="gz'50?scan'50,208,50";a="456233259"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Apr 2021 21:52:40 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lchcN-0008RD-4h; Sat, 01 May 2021 04:52:39 +0000
Date:   Sat, 1 May 2021 12:51:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Khaled ROMDHANI <khaledromdhani216@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Khaled ROMDHANI <khaledromdhani216@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH-V3] fs/btrfs: Fix uninitialized variable
Message-ID: <202105011230.X3QmqQAz-lkp@intel.com>
References: <20210501011136.29240-1-khaledromdhani216@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20210501011136.29240-1-khaledromdhani216@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Khaled,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on c05b2a58c9ed11bd753f1e64695bd89da715fbaa]

url:    https://github.com/0day-ci/linux/commits/Khaled-ROMDHANI/fs-btrfs-Fix-uninitialized-variable/20210501-091409
base:   c05b2a58c9ed11bd753f1e64695bd89da715fbaa
config: s390-randconfig-r026-20210430 (attached as .config)
compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 8f5a2a5836cc8e4c1def2bdeb022e7b496623439)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/0day-ci/linux/commit/b5c294aac8a6164ddf38bfbdd1776091b4a1eeba
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Khaled-ROMDHANI/fs-btrfs-Fix-uninitialized-variable/20210501-091409
        git checkout b5c294aac8a6164ddf38bfbdd1776091b4a1eeba
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/btrfs/zoned.c:5:
   In file included from include/linux/blkdev.h:26:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:80:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:36:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from fs/btrfs/zoned.c:5:
   In file included from include/linux/blkdev.h:26:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:80:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from fs/btrfs/zoned.c:5:
   In file included from include/linux/blkdev.h:26:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:80:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> fs/btrfs/zoned.c:147:3: warning: variable 'zone' is used uninitialized whenever '?:' condition is true [-Wsometimes-uninitialized]
                   ASSERT((u32)mirror < 3);
                   ^~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/ctree.h:3420:3: note: expanded from macro 'ASSERT'
           (likely(expr) ? (void)0 : assertfail(#expr, __FILE__, __LINE__))
            ^~~~~~~~~~~~
   include/linux/compiler.h:77:20: note: expanded from macro 'likely'
   # define likely(x)      __builtin_expect(!!(x), 1)
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/zoned.c:151:9: note: uninitialized use occurs here
           ASSERT(zone <= U32_MAX);
                  ^~~~
   fs/btrfs/ctree.h:3420:10: note: expanded from macro 'ASSERT'
           (likely(expr) ? (void)0 : assertfail(#expr, __FILE__, __LINE__))
                   ^~~~
   include/linux/compiler.h:77:40: note: expanded from macro 'likely'
   # define likely(x)      __builtin_expect(!!(x), 1)
                                               ^
   fs/btrfs/zoned.c:147:3: note: remove the '?:' if its condition is always false
                   ASSERT((u32)mirror < 3);
                   ^
   fs/btrfs/ctree.h:3420:3: note: expanded from macro 'ASSERT'
           (likely(expr) ? (void)0 : assertfail(#expr, __FILE__, __LINE__))
            ^
   include/linux/compiler.h:77:20: note: expanded from macro 'likely'
   # define likely(x)      __builtin_expect(!!(x), 1)
                           ^
   fs/btrfs/zoned.c:139:10: note: initialize the variable 'zone' to silence this warning
           u64 zone;
                   ^
                    = 0
   13 warnings generated.


vim +147 fs/btrfs/zoned.c

   133	
   134	/*
   135	 * Get the first zone number of the superblock mirror
   136	 */
   137	static inline u32 sb_zone_number(int shift, int mirror)
   138	{
   139		u64 zone;
   140	
   141		ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);
   142		switch (mirror) {
   143		case 0: zone = 0; break;
   144		case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
   145		case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
   146		default:
 > 147			ASSERT((u32)mirror < 3);
   148			break;
   149		}
   150	
   151		ASSERT(zone <= U32_MAX);
   152	
   153		return (u32)zone;
   154	}
   155	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--n8g4imXOkfNTN/H1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
PA72s/wLmBrtwGzDAAA=

--n8g4imXOkfNTN/H1--
