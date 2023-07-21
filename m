Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440A175C804
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 15:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjGUNj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 09:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjGUNjz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 09:39:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49126172A
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 06:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689946790; x=1721482790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6dTJFFl5OAbeoL/FZr8lFRGcbY2UDD7hZsRMzgouoIo=;
  b=JwVDMk3N2bkPzLoMadwMLPDd66nVas0KZzkwvwO1SvsbyDXKLc4s2hrP
   C4pHAXnslJ15jWvmQg+7pHuJ257WLgWNvTMEU+rzZLMeRKtFU+kwElt8T
   qC2IiVaKMEZ4nEPg4r8ix+XE1Z70ldcVgVYrkRmDxcDDutJq21bm8zu6d
   bS79VqBJdoCtuo20yoCgVwYIYcC9I6t+rQK9Cp1rnrUMmgotS3Ok0/pcu
   QyQO7gCuSgFkjEhVZtyQqh2UlJLNz8GqzjTpVVBAkzqfjbflbeXLH9JA2
   nEW5wFmT7akeim2IOA+taeuKCj3dUpUAuYKckYbJSqKbVENeJRWbYKsWb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="364487788"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="364487788"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 06:39:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="868248922"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2023 06:39:49 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMqMF-0007Kz-0w;
        Fri, 21 Jul 2023 13:39:47 +0000
Date:   Fri, 21 Jul 2023 21:38:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 13/20] btrfs: new inline ref storing owning subvol of
 data extents
Message-ID: <202307212108.x2NuMJJW-lkp@intel.com>
References: <cd13e27d24eb8c3d8162459e3f81c1ce772357a8.1689893021.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd13e27d24eb8c3d8162459e3f81c1ce772357a8.1689893021.git.boris@bur.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
config: i386-randconfig-i013-20230720 (https://download.01.org/0day-ci/archive/20230721/202307212108.x2NuMJJW-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230721/202307212108.x2NuMJJW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307212108.x2NuMJJW-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/btrfs_tree.h:785:2: error: unknown type name 'u64'
           u64 root_id;
           ^
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
