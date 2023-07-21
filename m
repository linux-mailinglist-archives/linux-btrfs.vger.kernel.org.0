Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFCC75C572
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 13:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjGULIt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 07:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjGULHs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 07:07:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E85546BA
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 04:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689937453; x=1721473453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+s+jHKhoqeCr4HOPis9ahrNrqhwyefbKhuoVLsPBADg=;
  b=V6eQMRf4H7jOJ8yXAAsDg2/7fRXoq7Qy/otqPMahP5Ucep0IE7Y2IHdA
   WmdNstyy81KiTo3LLpUi3/cV16B5SBFI//bBN+0rGFcmNlXIr9JKvHPdQ
   JZYrnjfyeiMmnN0wYMMwEf1FZWMDSncSN5dUeBXjDJJwtxTjbA6tcq9Ru
   Y7qH0btGASh4muQxe5/rYhIbC8QB2EfYAkbD2JvVCqSwBeBt/x6SJuLzN
   Rt4dRGuQudrnrcr9pWPSpbtazvAmew9GJN8UV9jJNSbCW8Xo9wHQVfn1c
   4IUON2c6C4NtCtHt5e9MTEITFVUme8fKOhI8fACa4967fMS8zEMjXRopq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346591163"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="346591163"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 04:03:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="838514931"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="838514931"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jul 2023 04:03:55 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMnvF-0007CV-2f;
        Fri, 21 Jul 2023 11:03:48 +0000
Date:   Fri, 21 Jul 2023 19:03:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 13/20] btrfs: new inline ref storing owning subvol of
 data extents
Message-ID: <202307211814.Iule8nnz-lkp@intel.com>
References: <cd13e27d24eb8c3d8162459e3f81c1ce772357a8.1689893021.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd13e27d24eb8c3d8162459e3f81c1ce772357a8.1689893021.git.boris@bur.io>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Boris,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.5-rc2 next-20230721]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Boris-Burkov/btrfs-free-qgroup-rsv-on-io-failure/20230721-065759
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/cd13e27d24eb8c3d8162459e3f81c1ce772357a8.1689893021.git.boris%40bur.io
patch subject: [PATCH v2 13/20] btrfs: new inline ref storing owning subvol of data extents
config: x86_64-randconfig-r032-20230720 (https://download.01.org/0day-ci/archive/20230721/202307211814.Iule8nnz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230721/202307211814.Iule8nnz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307211814.Iule8nnz-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/btrfs_tree.h:785:9: error: unknown type name 'u64'
     785 |         u64 root_id;
         |         ^~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
