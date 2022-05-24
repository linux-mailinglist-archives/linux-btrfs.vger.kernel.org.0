Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F53532886
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 13:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiEXLJl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 07:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiEXLJk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 07:09:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9D3E0CA
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 04:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653390578; x=1684926578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZhtyOzZIMn4QX41mbXGNbqzqAaDZ0c/quuepgySE6NU=;
  b=mLovZ9Noc3Cre1leihGOiunmKVoSz4aVKYGMFqF/GiThF0HzlfRsuDh2
   c3XwQuTjfpWBTchXdEpGxoysI+szzMKWA1dm2VCJ6rGjn+8N2HDrKN2rs
   A4LhcE8/TS1U2K+WoGT2qF639Rb+zTTCDNkCUUmIoJvhzWujOTPdz3ASd
   jY8pmRA929eG1aomjD+54kPLX5aGiQtNPt5xv1D7JFtA6i7phFj8c0u7Y
   WEPZhEXQKLWs/x94MgJGafZSCsqiVD/0JQ+vXSpqigj9pHjwaEeXcls8t
   AndyTBcHgPscddkzSNFv5mwTXy/8dVE7lbMKzXgAgu9QrnGgBfFJelC7k
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="253372968"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="253372968"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 04:09:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="548423599"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 May 2022 04:09:30 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntSPp-0001za-Kd;
        Tue, 24 May 2022 11:09:29 +0000
Date:   Tue, 24 May 2022 19:08:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Message-ID: <202205241800.sJRhtNfS-lkp@intel.com>
References: <f6679e0b681f9b1a74dfccbe05dcb5b6eb0878f6.1653372729.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6679e0b681f9b1a74dfccbe05dcb5b6eb0878f6.1653372729.git.wqu@suse.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on v5.18]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-RAID56J-journal-on-disk-format-draft/20220524-141549
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220524/202205241800.sJRhtNfS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/695dee41baee3a72c39396cb548088e91472d04d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qu-Wenruo/btrfs-RAID56J-journal-on-disk-format-draft/20220524-141549
        git checkout 695dee41baee3a72c39396cb548088e91472d04d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/btrfs_tree.h:1156:9: error: unknown type name 'u8'
    1156 |         u8 __reserved[4];
         |         ^~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
