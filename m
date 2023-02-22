Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6136D69F0C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 09:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjBVI7O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 03:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjBVI7K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 03:59:10 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A18127995
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 00:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677056346; x=1708592346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TFhjm8pPDqFdv6pJf0eakrxhLL9j2XfzQbDsKKHZKlA=;
  b=Eye51isywAw+4Qbn8HALs1Ug6BBLEpZ2BlY/QwJbQnTa2pbneGtpzt0h
   voYZ8NhULk9xl+Zj1XvqP+yb96AIYOwqem+/iv24qYms3GPFAZcjUfqTr
   HxiF5k6WrqqNGxOS2y79wTfnBG8gZ8u1jw+Wefokxy5T101iUEreVwLfs
   bV+4A56WhD6OiMkhcBopob8ifuDt4yxSeYehgGWcFezriawl1FF24SMQY
   vUGWJx/X+W3c8ZMD/5eWuH7OzLgntSYy2HJL7OCCrP6lPWuPJy2Gj7RJn
   XJikuXPV5NmrfKLyPx38Gpvj1opm9BVfUDI7FJoYVbNlhxVcCzEOtYtu6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="360355334"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="360355334"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 00:59:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="917490797"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="917490797"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Feb 2023 00:59:05 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUkxs-0000Be-2e;
        Wed, 22 Feb 2023 08:59:04 +0000
Date:   Wed, 22 Feb 2023 16:58:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] btrfs: scrub: fix an error in stripe offset calculation
Message-ID: <202302221638.EMe7IGPV-lkp@intel.com>
References: <c8f91363ab2e7ca24edbddf1feeca6c9fcf34f6e.1677033010.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8f91363ab2e7ca24edbddf1feeca6c9fcf34f6e.1677033010.git.wqu@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20230221]
[cannot apply to kdave/for-next v6.2 v6.2-rc8 v6.2-rc7 linus/master v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-scrub-fix-an-error-in-stripe-offset-calculation/20230222-103158
patch link:    https://lore.kernel.org/r/c8f91363ab2e7ca24edbddf1feeca6c9fcf34f6e.1677033010.git.wqu%40suse.com
patch subject: [PATCH] btrfs: scrub: fix an error in stripe offset calculation
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20230222/202302221638.EMe7IGPV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/ede724f4f7127f86931756949269770a7197339c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qu-Wenruo/btrfs-scrub-fix-an-error-in-stripe-offset-calculation/20230222-103158
        git checkout ede724f4f7127f86931756949269770a7197339c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302221638.EMe7IGPV-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/btrfs/scrub.c: In function 'scrub_stripe_index_and_offset':
>> fs/btrfs/scrub.c:1456:34: error: 'BTRFS_STRIPE_LEN_MASK' undeclared (first use in this function); did you mean 'BTRFS_STRIPE_LEN'?
    1456 |                                  BTRFS_STRIPE_LEN_MASK;
         |                                  ^~~~~~~~~~~~~~~~~~~~~
         |                                  BTRFS_STRIPE_LEN
   fs/btrfs/scrub.c:1456:34: note: each undeclared identifier is reported only once for each function it appears in


vim +1456 fs/btrfs/scrub.c

  1431	
  1432	static inline void scrub_stripe_index_and_offset(u64 logical, u64 map_type,
  1433							 u64 full_stripe_logical,
  1434							 int nstripes, int mirror,
  1435							 int *stripe_index,
  1436							 u64 *stripe_offset)
  1437	{
  1438		int i;
  1439	
  1440		if (map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
  1441			const int nr_data_stripes = (map_type & BTRFS_BLOCK_GROUP_RAID5) ?
  1442						    nstripes - 1 : nstripes - 2;
  1443	
  1444			/* RAID5/6 */
  1445			for (i = 0; i < nr_data_stripes; i++) {
  1446				const u64 data_stripe_start = full_stripe_logical +
  1447							(i * BTRFS_STRIPE_LEN);
  1448	
  1449				if (logical >= data_stripe_start &&
  1450				    logical < data_stripe_start + BTRFS_STRIPE_LEN)
  1451					break;
  1452			}
  1453	
  1454			*stripe_index = i;
  1455			*stripe_offset = (logical - full_stripe_logical) &
> 1456					 BTRFS_STRIPE_LEN_MASK;
  1457		} else {
  1458			/* The other RAID type */
  1459			*stripe_index = mirror;
  1460			*stripe_offset = 0;
  1461		}
  1462	}
  1463	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
