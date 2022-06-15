Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62D154D321
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 22:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349601AbiFOU5a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 16:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348984AbiFOU53 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 16:57:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F85DD
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 13:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655326647; x=1686862647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qE0BgRTt7v1wey5s4kWmW69RmEncOVGsv+ZMhZUssJE=;
  b=Ik9fgS7P3jRPlUuv19/w8ixitH8+ZsAVHIVId1NvITug/5G3oCcAfKg2
   cB40kKYEDsdH100Fci1C7seaIfEcmZgKd1tv7NKbLEMUT4axu5BsD4dtw
   vwexAaM2rNMqqG4ozY3Y/ApY+SwNLc6U+vk/7z99K7HJvYh4cIMyfCMhG
   rQ8UOAEw3vSuQGR66LKLlVPZGgng6c/o9olWwuHdYp4CoSKmv4qkgqEI1
   QgPypO09H5if3bh9dEaKaWjay9jxJp+pfD0Ps1svlRszjBhhMhDXS1inv
   4X3A8jlPFt3MMOYQYTiIJ3q8AIsjvjP7EgzuM6yjL04KEuSXYfeX/7KNg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="280132991"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="280132991"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 13:57:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="618639416"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2022 13:57:24 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1a4p-000NNN-Db;
        Wed, 15 Jun 2022 20:57:23 +0000
Date:   Thu, 16 Jun 2022 04:57:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v2 2/2] btrfs: Expose the BTRFS commit stats through sysfs
Message-ID: <202206160408.sNjzgOSw-lkp@intel.com>
References: <20220614222231.2582876-3-iangelak@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614222231.2582876-3-iangelak@fb.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Ioannis,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on v5.19-rc2 next-20220615]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Ioannis-Angelakopoulos/btrfs-Expose-BTRFS-commit-stats-through-sysfs/20220615-062725
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: i386-debian-10.3-kselftests (https://download.01.org/0day-ci/archive/20220616/202206160408.sNjzgOSw-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/7fc5bb8a0de0b8d21313846a3eca99a70ca25da4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ioannis-Angelakopoulos/btrfs-Expose-BTRFS-commit-stats-through-sysfs/20220615-062725
        git checkout 7fc5bb8a0de0b8d21313846a3eca99a70ca25da4
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
