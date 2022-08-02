Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FF7588350
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 23:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiHBVLi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 17:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiHBVLh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 17:11:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FEF46D86
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 14:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659474696; x=1691010696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4eGvQTYhYbmGxKRVGTyb9SEfWIwt/tyIhjOVmvn61QE=;
  b=EU71gKrLOggCuDoCJLRrGKIgmaZQAcULvVUJqhb2odRUkMjhM5/BP/In
   jBr8fjpV4qzoa7g+Q2unOY9B1vLGE7jRThYi/fmddnByzBGAugq0H0ZlU
   RGWu47gwNDQ9TX8Q6KVi6IuuBYG+FKtoaS6VDawe2KIXjgjm67tSzjJWf
   iZDturwzF9ZXOyN1mTCDp8f//fLt398QHEgzuhzbSWCX9zE/Kat6p1/WV
   of/L7WEfV1rXEY6r8SogPSSvaQuz+Eg/ZeBPOu1zu/xQw9nWE+fmNhExQ
   1etHmmNT2WhOvmAvDGvVAW5yXSrEGnCfND2cNWqKXVcMz/QKWgtBFhEXB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="272566483"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="272566483"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 14:11:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="691999104"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2022 14:11:34 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIzAr-000GRl-1a;
        Tue, 02 Aug 2022 21:11:33 +0000
Date:   Wed, 3 Aug 2022 05:10:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 2/4] btrfs: assign checksum shash slots on init
Message-ID: <202208030448.34fSi3hk-lkp@intel.com>
References: <c637b01a1742d0841b71d67a91aab50ac22539f7.1659443199.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c637b01a1742d0841b71d67a91aab50ac22539f7.1659443199.git.dsterba@suse.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

I love your patch! Perhaps something to improve:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on next-20220728]
[cannot apply to linus/master v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Sterba/Selectable-checksum-implementation/20220802-203426
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220803/202208030448.34fSi3hk-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/335830d3f7aa692840402c4813c125f96f510812
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Sterba/Selectable-checksum-implementation/20220802-203426
        git checkout 335830d3f7aa692840402c4813c125f96f510812
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/btrfs/disk-io.c: In function 'btrfs_init_csum_hash':
   fs/btrfs/disk-io.c:2438:13: error: too few arguments to function 'strstr'
    2438 |         if (strstr(crypto_shash_driver_name(csum_shash)), "generic") != NULL) {
         |             ^~~~~~
   In file included from arch/x86/include/asm/string.h:3,
                    from include/linux/string.h:20,
                    from arch/x86/include/asm/page_32.h:22,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from fs/btrfs/disk-io.c:6:
   arch/x86/include/asm/string_32.h:185:14: note: declared here
     185 | extern char *strstr(const char *cs, const char *ct);
         |              ^~~~~~
>> fs/btrfs/disk-io.c:2438:57: warning: left-hand operand of comma expression has no effect [-Wunused-value]
    2438 |         if (strstr(crypto_shash_driver_name(csum_shash)), "generic") != NULL) {
         |                                                         ^
   fs/btrfs/disk-io.c:2438:70: error: expected expression before '!=' token
    2438 |         if (strstr(crypto_shash_driver_name(csum_shash)), "generic") != NULL) {
         |                                                                      ^~
>> fs/btrfs/disk-io.c:2438:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    2438 |         if (strstr(crypto_shash_driver_name(csum_shash)), "generic") != NULL) {
         |         ^~
   fs/btrfs/disk-io.c:2438:77: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    2438 |         if (strstr(crypto_shash_driver_name(csum_shash)), "generic") != NULL) {
         |                                                                             ^
   fs/btrfs/disk-io.c:2438:77: error: expected statement before ')' token
   fs/btrfs/disk-io.c:2441:11: error: 'else' without a previous 'if'
    2441 |         } else {
         |           ^~~~


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
