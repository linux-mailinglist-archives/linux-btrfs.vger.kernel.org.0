Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3BF56B03F
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 03:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbiGHBzY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 21:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGHBzX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 21:55:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E8B73582
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 18:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657245319; x=1688781319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IS0wJtqY7VBP/xZO/4aIQYNAp3YYCsJpusT3Qs5x6Dw=;
  b=fO4Lsp1M/jURW+3wN2bSelx2Zi8/iXchHqUZDMG+YkatsSASqWTwSe1/
   FoVP5jPC+4y1uSCso6e6OvE1sL+9yKtMj8W9yweOUQrL6c5VbLTHocW0H
   Ntlap/0GbqclD1/6Pr9fJ9gz8rruT7NSWegDKDQ0t2dGjlusgDnkG5yq3
   ggOSY17zoRsMWTumTjWndpQJkA+DokfU0Mb2MZ7B9zCDD5ciOJzH4GGMs
   LQfrwvot38TzPJQc8MPOk6fxAS0B94EsXc0F0fgCj82G5FEpO/dLoJaPK
   s3OP4IQMcIwVFLApnpFPfUu7t0ydKyOhOKP/WfxbDcuTij7X2LIR+JR6i
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="370479429"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="370479429"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 18:55:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="626537798"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Jul 2022 18:55:18 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9dDB-000MkA-Bg;
        Fri, 08 Jul 2022 01:55:17 +0000
Date:   Fri, 8 Jul 2022 09:55:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 06/12] btrfs: write-intent: introduce an internal helper
 to set bits for a range.
Message-ID: <202207080925.VUcOcv89-lkp@intel.com>
References: <1574950e8caee003d1682ca6a9c6c85142cef5bd.1657171615.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574950e8caee003d1682ca6a9c6c85142cef5bd.1657171615.git.wqu@suse.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on next-20220707]
[cannot apply to linus/master v5.19-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-introduce-write-intent-bitmaps-for-RAID56/20220707-133435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220708/202207080925.VUcOcv89-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2b051857a66f0310589455c06f962908016b5f9b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qu-Wenruo/btrfs-introduce-write-intent-bitmaps-for-RAID56/20220707-133435
        git checkout 2b051857a66f0310589455c06f962908016b5f9b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/mips/kernel/head.o: in function `kernel_entry':
   (.ref.text+0xac): relocation truncated to fit: R_MIPS_26 against `start_kernel'
   init/main.o: in function `set_reset_devices':
   main.c:(.init.text+0x20): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x30): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `debug_kernel':
   main.c:(.init.text+0xa4): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0xb4): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `quiet_kernel':
   main.c:(.init.text+0x128): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x138): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `warn_bootconfig':
   main.c:(.init.text+0x1ac): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x1bc): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `init_setup':
   main.c:(.init.text+0x238): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x258): additional relocation overflows omitted from the output
   mips-linux-ld: fs/btrfs/write-intent.o: in function `set_bits_in_one_entry':
>> write-intent.c:(.text.set_bits_in_one_entry+0x1ec): undefined reference to `__udivdi3'
>> mips-linux-ld: write-intent.c:(.text.set_bits_in_one_entry+0x2b0): undefined reference to `__udivdi3'
   mips-linux-ld: fs/btrfs/write-intent.o: in function `insert_new_entries':
>> write-intent.c:(.text.insert_new_entries+0x294): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
