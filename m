Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBDE56B364
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 09:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbiGHHXi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 03:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbiGHHXe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 03:23:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926EDE0F1
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 00:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657265013; x=1688801013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IR2Tr+DpvEWtSdz6yHVmBXdt2rYVOao/UkQoschYRfo=;
  b=Ui5EmRVdB6GopE+4f447u/CEjFGCVpE+a84bmnGlV/DZRvV9+eZeCQWg
   DL+0cVqrhZhPT7bQRlk1aV+Tge/d0zP5/BiHahPzRdBJ3JTu0jPNxo4MJ
   RO8mzHRdaimtBtgTpIkRVEuN9MDBClX0FwI+Gomkj6u5cPrXqdqzyVoCO
   P9UZS+M078/XfUiVqyFCwcibK5uXyNb1CIS/H2mDZRN4r/H4n/MT2kRwJ
   WVC8t2Nf84IM2WQCWeCZdS3Fetz06yav+V9dDxj6iUrfb9yJyMHxrHSMi
   FQ8Twzmz6eJFRGk+pZxAkZDrzyiQi+DvIWjJGJ9ticAtHmHD0FaAEJ1v3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="284957767"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="284957767"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 00:23:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="568843907"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Jul 2022 00:23:32 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9iKp-000N5w-Bf;
        Fri, 08 Jul 2022 07:23:31 +0000
Date:   Fri, 8 Jul 2022 15:23:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 06/12] btrfs: write-intent: introduce an internal helper
 to set bits for a range.
Message-ID: <202207081504.knAOU6FY-lkp@intel.com>
References: <1574950e8caee003d1682ca6a9c6c85142cef5bd.1657171615.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574950e8caee003d1682ca6a9c6c85142cef5bd.1657171615.git.wqu@suse.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
[also build test ERROR on next-20220707]
[cannot apply to linus/master v5.19-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-introduce-write-intent-bitmaps-for-RAID56/20220707-133435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220708/202207081504.knAOU6FY-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/2b051857a66f0310589455c06f962908016b5f9b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qu-Wenruo/btrfs-introduce-write-intent-bitmaps-for-RAID56/20220707-133435
        git checkout 2b051857a66f0310589455c06f962908016b5f9b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
