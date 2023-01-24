Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32640679DC7
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jan 2023 16:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbjAXPnF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Jan 2023 10:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjAXPnB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Jan 2023 10:43:01 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B92474F4
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jan 2023 07:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674574960; x=1706110960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jzNLut6RgoQgIztog/yyuwTtLyLBM173o7yKSUPhQ+U=;
  b=M6qK7D29BeaWWuWs8wvT6xXdkRK8xxXWD6t2dKHhY4MsXrlOUYVfqpvX
   178qYkqcHBkRPrAEOVPJUrG9gTwZIK2QFr7VeQc7MhV2q8aswxfL9YCmA
   Ei9Xbdv/hBreMsqKlcHV0WIR/FlKCqjQ2MgZwicgk029PrdF3JAzOf2UZ
   TdaygsMjrGoi/PVInYaTcE4R43yVTCvGo2n5uCQmC8V5fpELS0iTXNJ1l
   S+okWeuMX1LG6jqBonps0YKK9aYg9ZhcdW6sWuolv3zeoAYg2m9zY+lA4
   JPcVx/PCJCHr0PNWxjFNSQfVwv8nwKLZC0mpRgIco+/UR+0vBSaLCCBP5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="412551864"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="412551864"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 07:42:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="786122940"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="786122940"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2023 07:42:05 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKLQy-0006Zk-2f;
        Tue, 24 Jan 2023 15:42:04 +0000
Date:   Tue, 24 Jan 2023 23:41:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] btrfs: separate single stripe optimization into a
 dedicate branch
Message-ID: <202301242352.S4fATQpv-lkp@intel.com>
References: <4e4d6e0aab34ab40fd0ac69874141bb02a559f10.1674546545.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e4d6e0aab34ab40fd0ac69874141bb02a559f10.1674546545.git.wqu@suse.com>
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

[auto build test ERROR on v6.2-rc5]
[also build test ERROR on linus/master]
[cannot apply to kdave/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-separate-single-stripe-optimization-into-a-dedicate-branch/20230124-160136
patch link:    https://lore.kernel.org/r/4e4d6e0aab34ab40fd0ac69874141bb02a559f10.1674546545.git.wqu%40suse.com
patch subject: [PATCH] btrfs: separate single stripe optimization into a dedicate branch
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230124/202301242352.S4fATQpv-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4c14a1dcb2468592c33a708a821aeb30ce4a16db
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qu-Wenruo/btrfs-separate-single-stripe-optimization-into-a-dedicate-branch/20230124-160136
        git checkout 4c14a1dcb2468592c33a708a821aeb30ce4a16db
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: fs/btrfs/volumes.o: in function `map_single_stripe':
>> volumes.c:(.text+0x3482): undefined reference to `__umoddi3'
>> m68k-linux-ld: volumes.c:(.text+0x34b2): undefined reference to `__udivdi3'
   m68k-linux-ld: volumes.c:(.text+0x35b2): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
