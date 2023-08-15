Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54D777D1AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Aug 2023 20:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239039AbjHOSVx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Aug 2023 14:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239036AbjHOSVb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Aug 2023 14:21:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166C619AF
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 11:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692123691; x=1723659691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IYzys1H9GqbrI2H8fbGL8fITV8TfD/uJ2YqNmBru9Gw=;
  b=WWPJIdh2edllCcXgjlcMTDUsIH2YlKTFMme1uJ40viqSmXvxtqFD8w7E
   J8K+oIgL5kLwnqWLo5lBkJ7HMtxGb40I/5U1ZClqjPyrosqOILkW3ex/1
   ijgrsSFXwe+DYPBV7VwbDRUGhKScJqEWpx93KJZCObgifPcabE4X2zuzE
   cAzJu9k5FrasAVFxk8L+ewvG/aysrPH3mLID3mmPiaVYjONtlPI8ExkKp
   G0sb7s7z++7URRFMHLyN2UxLRqhlMeIC84oG18I/tLT91gWULBtorVRsq
   i4tj/+PrhrMeQtFrM/1Wn+EcVArmOwSEW9Nx6e9Za4xK5R71uMUm4FipJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372347008"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="372347008"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 11:21:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="907710994"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="907710994"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Aug 2023 11:21:29 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVyfY-00018T-2j;
        Tue, 15 Aug 2023 18:21:28 +0000
Date:   Wed, 16 Aug 2023 02:21:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] btrfs: scrub: avoid unnecessary extent tree search
 for striped profiles
Message-ID: <202308160248.ZzecEExL-lkp@intel.com>
References: <c21b78ee8bcf22f373beeefb8ee47ee92dfe8f03.1692097289.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c21b78ee8bcf22f373beeefb8ee47ee92dfe8f03.1692097289.git.wqu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on next-20230815]
[cannot apply to linus/master v6.5-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-scrub-avoid-unnecessary-extent-tree-search-for-striped-profiles/20230815-191040
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/c21b78ee8bcf22f373beeefb8ee47ee92dfe8f03.1692097289.git.wqu%40suse.com
patch subject: [PATCH v2] btrfs: scrub: avoid unnecessary extent tree search for striped profiles
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230816/202308160248.ZzecEExL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230816/202308160248.ZzecEExL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308160248.ZzecEExL-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: fs/btrfs/scrub.o: in function `scrub_stripe':
>> scrub.c:(.text+0x3d74): undefined reference to `__umoddi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
