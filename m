Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2453268AFB1
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Feb 2023 13:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjBEMUX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Feb 2023 07:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBEMUV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Feb 2023 07:20:21 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B55903F
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Feb 2023 04:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675599620; x=1707135620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gnKl44PdAIs/pCXwf6cpUOUvRV5pTLVO1Mr8khHtakg=;
  b=kbdCy7jL+o1hSa0N3F2vkbles79o99Crk2KaTA8f1oSf/dvA2Rrd4VPN
   t1EO8gWzR0ShPnqRlb4+cdqXKcIeNyAPqyvFu6c/4oxM/voRAKsYu2clR
   W9WPNhojwsbwNChHwgElpGT2+d/CCP2er2N5G4HAg5HVzNOe7A02jl1cu
   60kcUQIFHKsLdf3OoE0sALNEKr1N3CQUVhTV87JvYblbq+DPfXS6fQ0ju
   PBLNdvptTbUNw+5oF19wwpDr4yF0jfpc4t/5FlbP0aPVk6dqP/hEIePEG
   esYzxkOI/QvUe7sWktC9tMtc4BCn6mQYCWWblk2NDmxWJ0rzH9HvL6k7r
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="331174474"
X-IronPort-AV: E=Sophos;i="5.97,275,1669104000"; 
   d="scan'208";a="331174474"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 04:20:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="668154824"
X-IronPort-AV: E=Sophos;i="5.97,275,1669104000"; 
   d="scan'208";a="668154824"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 05 Feb 2023 04:20:19 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOe0I-0001zU-1c;
        Sun, 05 Feb 2023 12:20:18 +0000
Date:   Sun, 5 Feb 2023 20:20:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] btrfs: reduce div64 calls by limiting the number of
 stripes of a chunk to u32
Message-ID: <202302052002.9uoFbMlg-lkp@intel.com>
References: <275da997c70615256bed3cff8e74ab2b3fecbafc.1675586554.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <275da997c70615256bed3cff8e74ab2b3fecbafc.1675586554.git.wqu@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v6.2-rc6]
[also build test ERROR on linus/master]
[cannot apply to kdave/for-next next-20230203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-remove-map_lookup-stripe_len/20230205-165612
patch link:    https://lore.kernel.org/r/275da997c70615256bed3cff8e74ab2b3fecbafc.1675586554.git.wqu%40suse.com
patch subject: [PATCH 2/2] btrfs: reduce div64 calls by limiting the number of stripes of a chunk to u32
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230205/202302052002.9uoFbMlg-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dc356ab4c1f118e55634c17c1e086bfc0536198d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qu-Wenruo/btrfs-remove-map_lookup-stripe_len/20230205-165612
        git checkout dc356ab4c1f118e55634c17c1e086bfc0536198d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: fs/btrfs/block-group.o: in function `btrfs_rmap_block':
>> block-group.c:(.text+0x396c): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
