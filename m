Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEC2588323
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 22:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbiHBUah (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 16:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbiHBUaf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 16:30:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF68612D17
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 13:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659472234; x=1691008234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nIRhpTpA5XQopi5Sj/KK5SNSpqzS64Odt58zId2QWZg=;
  b=O729aZLIwL9WffoFmFeon1GUdsza3nusbS1MeLBBqc8lXTE8bvO57hJW
   Y4kTWBjgiyuTd+krR2wQ2sSWOCPkC1uiU5NBc8JsOuWYFdP4EPgGpT3KY
   ugi4aZVACgfIUkXSEq99w8+4ExS4bRVGQO2TAPqIZApwP8t5AyJl1AEb5
   UlvUM6sa+Shn06NKuxukvLlUjMqmwmlHPXC95LTXzE4eVnZoMj3UjMsgD
   eLco4+DbsXAtDvBZ1WUlBgTW6Z73/uW0+nvj0AeINAysTiD1Q9KcfAfWf
   7EJ99tcZxbwAyts+sJj3S0luTz3d4HDitnlbntx2GWFRxgsauEEkiIQMq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="315366703"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="315366703"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 13:30:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="553055165"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2022 13:30:32 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIyXA-000GPP-0s;
        Tue, 02 Aug 2022 20:30:32 +0000
Date:   Wed, 3 Aug 2022 04:30:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 2/4] btrfs: assign checksum shash slots on init
Message-ID: <202208030418.x0l9k9HX-lkp@intel.com>
References: <c637b01a1742d0841b71d67a91aab50ac22539f7.1659443199.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c637b01a1742d0841b71d67a91aab50ac22539f7.1659443199.git.dsterba@suse.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

I love your patch! Yet something to improve:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on next-20220728]
[cannot apply to linus/master v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Sterba/Selectable-checksum-implementation/20220802-203426
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: arm64-randconfig-r005-20220801 (https://download.01.org/0day-ci/archive/20220803/202208030418.x0l9k9HX-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/335830d3f7aa692840402c4813c125f96f510812
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Sterba/Selectable-checksum-implementation/20220802-203426
        git checkout 335830d3f7aa692840402c4813c125f96f510812
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/btrfs/disk-io.c:2438:49: error: too few arguments to function call, expected 2, have 1
           if (strstr(crypto_shash_driver_name(csum_shash)), "generic") != NULL) {
               ~~~~~~                                     ^
>> fs/btrfs/disk-io.c:2438:63: error: expected expression
           if (strstr(crypto_shash_driver_name(csum_shash)), "generic") != NULL) {
                                                                        ^
   2 errors generated.


vim +2438 fs/btrfs/disk-io.c

  2419	
  2420	static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
  2421	{
  2422		struct crypto_shash *csum_shash;
  2423		const char *csum_driver = btrfs_super_csum_driver(csum_type);
  2424	
  2425		csum_shash = crypto_alloc_shash(csum_driver, 0, 0);
  2426	
  2427		if (IS_ERR(csum_shash)) {
  2428			btrfs_err(fs_info, "error allocating %s hash for checksum",
  2429				  csum_driver);
  2430			return PTR_ERR(csum_shash);
  2431		}
  2432	
  2433		/*
  2434		 * Find the fastest implementation available, but keep the slots
  2435		 * matching the type.
  2436		 */
  2437		fs_info->csum_shash[CSUM_DEFAULT] = csum_shash;
> 2438		if (strstr(crypto_shash_driver_name(csum_shash)), "generic") != NULL) {
  2439			fs_info->csum_shash[CSUM_GENERIC] = csum_shash;
  2440			clear_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
  2441		} else {
  2442			fs_info->csum_shash[CSUM_ACCEL] = csum_shash;
  2443			set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
  2444		}
  2445	
  2446		btrfs_info(fs_info, "using %s (%s) checksum algorithm",
  2447				btrfs_super_csum_name(csum_type),
  2448				crypto_shash_driver_name(csum_shash));
  2449		return 0;
  2450	}
  2451	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
