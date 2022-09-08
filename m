Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AF25B10CE
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 02:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiIHAOo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 20:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIHAOm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 20:14:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB1C2253B
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 17:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662596081; x=1694132081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4XqZFeOz2EIPekahPLRfowofq8lVRFP2QuNl/K8SuII=;
  b=NIhT8URF86IugjeJ1UtYUpchA0noP+VGl2JYKI1Yk7S3Nn/AADh2uiFX
   9QxFc7AF8wpgCwmLZLBR3tgSx8q+nx1Rqy/lcPpRXCrItXcY1ZoiD9+8A
   AkN28/Vy+gX6sVpP63Sk3+LQTm4fFfiWU4y6JmZQ0K5qNUVFAW+119eM1
   ydPOLoKGHFAPKTnQTOp3feTASvtOMv6pAdmfpPGnhj0ia1fZyCGQQqTJl
   IY5rwPvEWDKZioZsKE/HH/LAVoFYmiIxHjltehlwAfIZfEIEJsGp9WjJn
   +VOX8lDwOwgP1nnDcZlDoEEB6LdIVAEL1NIHen+7gM9VJmnAcnKTfHFxY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="280058408"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="280058408"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 17:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="943115627"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 07 Sep 2022 17:14:39 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW5Bn-000781-0F;
        Thu, 08 Sep 2022 00:14:39 +0000
Date:   Thu, 8 Sep 2022 08:13:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: wait extent buffer IOs before finishing a
 zone
Message-ID: <202209080826.AuNlP9ys-lkp@intel.com>
References: <6ea8d3e9d0165f6ff37a1d12aad93ba279acfd93.1662561769.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ea8d3e9d0165f6ff37a1d12aad93ba279acfd93.1662561769.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Naohiro,

I love your patch! Perhaps something to improve:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master v6.0-rc4 next-20220907]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Naohiro-Aota/btrfs-zoned-wait-extent-buffer-IOs-before-finishing-a-zone/20220907-224702
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: s390-randconfig-s041-20220907 (https://download.01.org/0day-ci/archive/20220908/202209080826.AuNlP9ys-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/f858e96a8ad7eb5499e18501bfbcaad594eace1f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Naohiro-Aota/btrfs-zoned-wait-extent-buffer-IOs-before-finishing-a-zone/20220907-224702
        git checkout f858e96a8ad7eb5499e18501bfbcaad594eace1f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   fs/btrfs/zoned.c:137:29: sparse: sparse: restricted __le64 degrades to integer
   fs/btrfs/zoned.c:137:52: sparse: sparse: restricted __le64 degrades to integer
>> fs/btrfs/zoned.c:1932:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void **slot @@     got void [noderef] __rcu ** @@
   fs/btrfs/zoned.c:1932:9: sparse:     expected void **slot
   fs/btrfs/zoned.c:1932:9: sparse:     got void [noderef] __rcu **
>> fs/btrfs/zoned.c:1932:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void **slot @@     got void [noderef] __rcu ** @@
   fs/btrfs/zoned.c:1932:9: sparse:     expected void **slot
   fs/btrfs/zoned.c:1932:9: sparse:     got void [noderef] __rcu **
>> fs/btrfs/zoned.c:1934:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __rcu **slot @@     got void **slot @@
   fs/btrfs/zoned.c:1934:44: sparse:     expected void [noderef] __rcu **slot
   fs/btrfs/zoned.c:1934:44: sparse:     got void **slot
   fs/btrfs/zoned.c:1938:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void **slot @@     got void [noderef] __rcu ** @@
   fs/btrfs/zoned.c:1938:30: sparse:     expected void **slot
   fs/btrfs/zoned.c:1938:30: sparse:     got void [noderef] __rcu **
   fs/btrfs/zoned.c:1947:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __rcu **slot @@     got void **slot @@
   fs/btrfs/zoned.c:1947:47: sparse:     expected void [noderef] __rcu **slot
   fs/btrfs/zoned.c:1947:47: sparse:     got void **slot
   fs/btrfs/zoned.c:1947:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void **slot @@     got void [noderef] __rcu ** @@
   fs/btrfs/zoned.c:1947:22: sparse:     expected void **slot
   fs/btrfs/zoned.c:1947:22: sparse:     got void [noderef] __rcu **
   fs/btrfs/zoned.c:1932:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __rcu **slot @@     got void **slot @@
   fs/btrfs/zoned.c:1932:9: sparse:     expected void [noderef] __rcu **slot
   fs/btrfs/zoned.c:1932:9: sparse:     got void **slot
>> fs/btrfs/zoned.c:1932:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void **slot @@     got void [noderef] __rcu ** @@
   fs/btrfs/zoned.c:1932:9: sparse:     expected void **slot
   fs/btrfs/zoned.c:1932:9: sparse:     got void [noderef] __rcu **
   fs/btrfs/zoned.c:2303:25: sparse: sparse: context imbalance in 'btrfs_zoned_activate_one_bg' - different lock contexts for basic block

vim +1932 fs/btrfs/zoned.c

  1922	
  1923	static void wait_eb_writebacks(struct btrfs_block_group *block_group)
  1924	{
  1925		struct btrfs_fs_info *fs_info = block_group->fs_info;
  1926		const u64 end = block_group->start + block_group->length;
  1927		struct radix_tree_iter iter;
  1928		struct extent_buffer *eb;
  1929		void **slot;
  1930	
  1931		rcu_read_lock();
> 1932		radix_tree_for_each_slot(slot, &fs_info->buffer_radix, &iter,
  1933					 block_group->start >> fs_info->sectorsize_bits) {
> 1934			eb = radix_tree_deref_slot(slot);
  1935			if (!eb)
  1936				continue;
  1937			if (radix_tree_deref_retry(eb)) {
  1938				slot = radix_tree_iter_retry(&iter);
  1939				continue;
  1940			}
  1941	
  1942			if (eb->start < block_group->start)
  1943				continue;
  1944			if (eb->start >= end)
  1945				break;
  1946	
  1947			slot = radix_tree_iter_resume(slot, &iter);
  1948			rcu_read_unlock();
  1949			wait_on_extent_buffer_writeback(eb);
  1950			rcu_read_lock();
  1951		}
  1952		rcu_read_unlock();
  1953	}
  1954	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
