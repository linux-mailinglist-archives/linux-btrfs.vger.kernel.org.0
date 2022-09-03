Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F9E5ABED1
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Sep 2022 13:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiICLse (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Sep 2022 07:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiICLsb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 07:48:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F6A3341F
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 04:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662205709; x=1693741709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zU4mumNwKhj0DrkTfMmVGuAb4d58rAGeK1QJBWuhCKw=;
  b=b12v+yd5a3575a5bybBRgDvClzBTO7cXXbtc5PJ/gaPgSi3cXB36SaJY
   EGc0MfbPMuAOvR94hoU+2juH4x6x5ylBeZ09HbPX1TjcBkbPMdgx0jFMs
   cF+QLTVY+sIZI0G2lUtulV1muq3n0GOt3ERYxCsVjSpEXdwMaVUphdFDe
   eGI0lOB5WJA/KqEfkjy+yROTHtKvF45X1hTnVkFxiM4ePZrGmfw0t3x8k
   CJWPGlfKvFTRp8wB4S6rMV2ApaFvf9tnwp8wWSc7JFuu87sgPfxZRi/NP
   OaHDiqwStlil4mh0qYoZvuEwvqBsEW36sKqH0D2/KhevubkhvMwkdgUu3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="296937117"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="296937117"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 04:48:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="681565878"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 03 Sep 2022 04:48:28 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oURdT-0001af-21;
        Sat, 03 Sep 2022 11:48:27 +0000
Date:   Sat, 3 Sep 2022 19:47:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH PoC 1/9] btrfs: introduce BTRFS_IOC_SCRUB_FS family of
 ioctls
Message-ID: <202209031916.ybFIwbdf-lkp@intel.com>
References: <e37ae2c85731ec307869e7c8f87c10d36d51846f.1662191784.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e37ae2c85731ec307869e7c8f87c10d36d51846f.1662191784.git.wqu@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.0-rc3 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-scrub-introduce-a-new-family-of-ioctl-scrub_fs/20220903-162128
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: x86_64-randconfig-a004 (https://download.01.org/0day-ci/archive/20220903/202209031916.ybFIwbdf-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/8f7e2c15c08dc87518d12529e5b5cba0a42b5eb1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qu-Wenruo/btrfs-scrub-introduce-a-new-family-of-ioctl-scrub_fs/20220903-162128
        git checkout 8f7e2c15c08dc87518d12529e5b5cba0a42b5eb1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/btrfs.h:329:15: error: expected declaration specifiers or '...' before 'sizeof'
     329 | static_assert(sizeof(struct btrfs_scrub_fs_progress) == 256);
         |               ^~~~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
