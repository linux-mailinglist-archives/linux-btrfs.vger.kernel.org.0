Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8D24D8EF5
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 22:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244409AbiCNVmL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 17:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243834AbiCNVmL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 17:42:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729D31DA54
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647294060; x=1678830060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=duz+74g0FHVD9ZCC3FyZ5cJrURG4rWVLDfZjXqxt3QM=;
  b=YgO7YW7pkj/iTSh3QuMPFOFGvmHz6uR4k1JPnZ/+452Cp3FgnNKZvUcP
   21ThVk2FFOZ1hpUG/L4h5IciMWWsHxk5k0HcU50LejzNeIfYGmTQfWvFi
   hrB7MvoVnAH9DCp4F59iJ4X3lBwNtAFpLtaqkl3kOfWoWnSeOUEWgQIDE
   GjArwdw6lhLViJHu0gR3QItI7nzKAmPjzRNnTtwTy5A+WyHY0z89Oej/Q
   AzBX2bX778YMgSHeF43BUrO7oXy4/JdC4WcJS49+4XKat+WAE+WWjj9jk
   w4nDynZ1MZONlbEiypttSvTrtB0RUXUVXdG2sqtHea4UEIHudNu5bbHWI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="319373464"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="319373464"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 14:41:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="540158450"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 14 Mar 2022 14:40:58 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTsQz-000AFt-P0; Mon, 14 Mar 2022 21:40:57 +0000
Date:   Tue, 15 Mar 2022 05:40:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: zoned: make auto-reclaim less aggressive
Message-ID: <202203150504.VbCtEy3b-lkp@intel.com>
References: <d4e31fe56800bdc3bd8ed9230c6a5629ee555cd5.1647268601.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4e31fe56800bdc3bd8ed9230c6a5629ee555cd5.1647268601.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Johannes,

I love your patch! Yet something to improve:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on next-20220310]
[cannot apply to v5.17-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Johannes-Thumshirn/btrfs-zoned-make-auto-reclaim-less-aggressive/20220314-231037
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: hexagon-randconfig-r041-20220313 (https://download.01.org/0day-ci/archive/20220315/202203150504.VbCtEy3b-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 3e4950d7fa78ac83f33bbf1658e2f49a73719236)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e742bf2051b5066cae517342b8bbe81eb44809a4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Johannes-Thumshirn/btrfs-zoned-make-auto-reclaim-less-aggressive/20220314-231037
        git checkout e742bf2051b5066cae517342b8bbe81eb44809a4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __hexagon_udivdi3
   >>> referenced by zoned.c
   >>>               btrfs/zoned.o:(btrfs_zoned_should_reclaim) in archive fs/built-in.a
   >>> referenced by zoned.c
   >>>               btrfs/zoned.o:(btrfs_zoned_should_reclaim) in archive fs/built-in.a
   >>> did you mean: __hexagon_udivsi3
   >>> defined in: arch/hexagon/built-in.a(lib/udivsi3.o)

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
