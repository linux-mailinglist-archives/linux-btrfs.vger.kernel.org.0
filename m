Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6F73662DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Apr 2021 02:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhDUAIO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 20:08:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:34409 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233807AbhDUAIO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 20:08:14 -0400
IronPort-SDR: UHdmJbmp7pWiEPjJf5X88ritQWkg+IgPzJvMJInxApoXDXylDVr0pbs4KM6yaVYmb/ugz/z45T
 26/Xif7gPRGg==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="182746729"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="gz'50?scan'50,208,50";a="182746729"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 17:07:41 -0700
IronPort-SDR: J4Mr1Wdadcy/zvFA1cVziNkrPB7D5Ld8KRryjLoSQS3pjgTyVFS335XNW3g+xXnVZoQZswzSaf
 c+BZyV5QmP+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="gz'50?scan'50,208,50";a="534706536"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Apr 2021 17:07:38 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lZ0P3-0003Ac-M1; Wed, 21 Apr 2021 00:07:37 +0000
Date:   Wed, 21 Apr 2021 08:07:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Khaled ROMDHANI <khaledromdhani216@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Khaled ROMDHANI <khaledromdhani216@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] fs/btrfs: Fix uninitialized variable
Message-ID: <202104210846.uSRQtVt5-lkp@intel.com>
References: <20210420151626.6045-1-khaledromdhani216@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20210420151626.6045-1-khaledromdhani216@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Khaled,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on v5.12-rc8 next-20210420]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Khaled-ROMDHANI/fs-btrfs-Fix-uninitialized-variable/20210420-231754
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: s390-randconfig-r032-20210420 (attached as .config)
compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project ca8eef7e3da8f750d7c7aa004fe426d1d34787ea)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/0day-ci/linux/commit/c05b2a58c9ed11bd753f1e64695bd89da715fbaa
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Khaled-ROMDHANI/fs-btrfs-Fix-uninitialized-variable/20210420-231754
        git checkout c05b2a58c9ed11bd753f1e64695bd89da715fbaa
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
>> fs/btrfs/zoned.c:147:10: warning: variable 'zone' is uninitialized when used here [-Wuninitialized]
                   ASSERT(zone);
                          ^~~~
   fs/btrfs/ctree.h:3420:10: note: expanded from macro 'ASSERT'
           (likely(expr) ? (void)0 : assertfail(#expr, __FILE__, __LINE__))
                   ^~~~
   include/linux/compiler.h:45:39: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                             ^
   include/linux/compiler.h:33:34: note: expanded from macro '__branch_check__'
                           ______r = __builtin_expect(!!(x), expect);      \
                                                         ^
   fs/btrfs/zoned.c:139:10: note: initialize the variable 'zone' to silence this warning
           u64 zone;
                   ^
                    = 0
   13 warnings generated.


vim +/zone +147 fs/btrfs/zoned.c

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
 > 147			ASSERT(zone);
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

--h31gzZEtNLTqOjlF
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--h31gzZEtNLTqOjlF--
