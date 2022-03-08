Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F8A4D1920
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 14:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347008AbiCHN1Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 08:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343672AbiCHN1X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 08:27:23 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631EE41FA1
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 05:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646745987; x=1678281987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=32avivksdeChqC6IS/cy7z0Z0H6XkO0PtHgEvGq/zGI=;
  b=D8cnLeEGR0Rnp/prAoCDzHHUgh5hKK2+1YhiZrOJOEy39w3yzAU1lH7A
   Keiv+4s7qzm6SmfJUk4Y2KUNLFhk8BAi7e7k3TkQen6v6gWUykJO6w1S9
   DWip8rySlYwymMIHYLmXtB/KKA7ZW/MWwFVN8lK4Em+ty96yMnbpfOMRA
   J33V3oWL/ht4uICbdC/7Q9FN4Uvf0CtwLmkIu0HGB/Y1hhoHZevRbfOzK
   J4k3LdpRbhzDQwlO4FtOEaQcNa7Zey5UiyKmITgaNJUt2R0qXeL74tIhI
   KyTm3j/6w4JtosJOtzld5Ha/tUNiFrVw4cH06j53N8VFEdQhpext5v4P2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="235289791"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="235289791"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 05:26:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="510095277"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 08 Mar 2022 05:26:24 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRZr5-0001S9-Ue; Tue, 08 Mar 2022 13:26:23 +0000
Date:   Tue, 8 Mar 2022 21:25:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Goffredo Baroncelli <kreijack@tiscali.it>,
        linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH 2/5] btrfs: export the device allocation_hint property in
 sysfs
Message-ID: <202203082127.TtxMcqDK-lkp@intel.com>
References: <aa62c61a0a9858d010d7d3ec67019332bd20d801.1646589622.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa62c61a0a9858d010d7d3ec67019332bd20d801.1646589622.git.kreijack@inwind.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Goffredo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on v5.17-rc7 next-20220308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Goffredo-Baroncelli/btrfs-allocation_hint/20220307-145335
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: microblaze-randconfig-s032-20220307 (https://download.01.org/0day-ci/archive/20220308/202203082127.TtxMcqDK-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/641cd29d0792eb2e702b6c6a226fce5b4a655e20
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Goffredo-Baroncelli/btrfs-allocation_hint/20220307-145335
        git checkout 641cd29d0792eb2e702b6c6a226fce5b4a655e20
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/btrfs/sysfs.c:1583:3: sparse: sparse: symbol 'allocation_hint_name' was not declared. Should it be static?
   fs/btrfs/sysfs.c:630:9: sparse: sparse: context imbalance in 'btrfs_show_u64' - different lock contexts for basic block

vim +/allocation_hint_name +1583 fs/btrfs/sysfs.c

  1578	
  1579	
  1580	struct allocation_hint_name_t {
  1581		const char *name;
  1582		const u64 value;
> 1583	} allocation_hint_name[] = {
  1584		{ "DATA_PREFERRED", BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED },
  1585		{ "METADATA_PREFERRED", BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED },
  1586		{ "DATA_ONLY", BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY },
  1587		{ "METADATA_ONLY", BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY },
  1588	};
  1589	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
