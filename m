Return-Path: <linux-btrfs+bounces-772-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF2A80B06A
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 00:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57ED61F21409
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 23:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742D05ABA8;
	Fri,  8 Dec 2023 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8ZuUfoN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9F590;
	Fri,  8 Dec 2023 15:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702077159; x=1733613159;
  h=date:from:to:cc:subject:message-id;
  bh=EZ8Nd2SEoqsCXHP4OYwqtiOfRlnLleCpd54fW+Zs5CU=;
  b=k8ZuUfoNaSmiNhlBoZjapdrOZ1G1K41RuFHqIEOh0Ygi7QzodozGBEPy
   IZf/92rBV5yTgGvlLwOZvVkrh8QX17WXYjIArTWL8PqEu3YWHNo3el+5O
   c/uIsKhKchnq9JBq5RujXg++kqm4BfFmEt/G5iLklprVv72/aGbknguBQ
   YFFwlQO0hH/Ckw3NdYStg8PQtwgBjMNxAhdqg0cnI9Wb2w3bwkwX4nZsJ
   LRL4d8yC38c7JmSJz/+/7NNeMeyZPIH5FYPfX+wKzBfHZiSlmLsCeRPDX
   RFEj3sVCl3IAWix7cDf6jqBeeJt7Ik7pJnzD9OySmE378G64MlVo+2crj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="393344285"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="393344285"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 15:12:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="748498798"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="748498798"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 08 Dec 2023 15:12:36 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBk1K-000EWX-00;
	Fri, 08 Dec 2023 23:12:34 +0000
Date: Sat, 09 Dec 2023 07:11:38 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 iommu@lists.linux.dev, linux-btrfs@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [linux-next:pending-fixes] BUILD REGRESSION
 e142e0e4b174b269d1fd400aa676c5f0483b608c
Message-ID: <202312090734.Ent2gD13-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git pending-fixes
branch HEAD: e142e0e4b174b269d1fd400aa676c5f0483b608c  Merge branch 'for-linux-next-fixes' of git://anongit.freedesktop.org/drm/drm-misc

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-randconfig-r063-20231208
|   `-- drivers-power-supply-cw2015_battery.c:WARNING-opportunity-for-max()
|-- sh-randconfig-r053-20231208
|   |-- fs-btrfs-extent_io.c:WARNING:atomic_dec_and_test-variation-before-object-free-at-line-.
|   |-- fs-btrfs-extent_io.c:preceding-lock-on-line
|   `-- fs-btrfs-ordered-data.c:WARNING:atomic_dec_and_test-variation-before-object-free-at-line-.
|-- sh-randconfig-r062-20231208
|   `-- drivers-power-supply-cw2015_battery.c:WARNING-opportunity-for-max()
`-- sparc-randconfig-r054-20231208
    `-- drivers-power-supply-cw2015_battery.c:WARNING-opportunity-for-max()
clang_recent_errors
|-- i386-randconfig-051-20231208
|   |-- drivers-power-supply-cw2015_battery.c:WARNING-opportunity-for-max()
|   |-- fs-btrfs-extent_io.c:WARNING:atomic_dec_and_test-variation-before-object-free-at-line-.
|   |-- fs-btrfs-extent_io.c:preceding-lock-on-line
|   `-- fs-btrfs-ordered-data.c:WARNING:atomic_dec_and_test-variation-before-object-free-at-line-.
|-- i386-randconfig-053-20231208
|   |-- drivers-scsi-be2iscsi-be_main.c:ERROR:mem_descr-mem_array-is-NULL-but-dereferenced.
|   |-- fs-btrfs-extent_io.c:WARNING:atomic_dec_and_test-variation-before-object-free-at-line-.
|   |-- fs-btrfs-extent_io.c:preceding-lock-on-line
|   `-- fs-btrfs-ordered-data.c:WARNING:atomic_dec_and_test-variation-before-object-free-at-line-.
|-- i386-randconfig-054-20231208
|   |-- drivers-power-supply-cw2015_battery.c:WARNING-opportunity-for-max()
|   |-- fs-btrfs-extent_io.c:WARNING:atomic_dec_and_test-variation-before-object-free-at-line-.
|   |-- fs-btrfs-extent_io.c:preceding-lock-on-line
|   `-- fs-btrfs-ordered-data.c:WARNING:atomic_dec_and_test-variation-before-object-free-at-line-.
|-- i386-randconfig-r051-20231208
|   |-- drivers-power-supply-cw2015_battery.c:WARNING-opportunity-for-max()
|   |-- fs-btrfs-extent_io.c:WARNING:atomic_dec_and_test-variation-before-object-free-at-line-.
|   |-- fs-btrfs-extent_io.c:preceding-lock-on-line
|   `-- fs-btrfs-ordered-data.c:WARNING:atomic_dec_and_test-variation-before-object-free-at-line-.
|-- x86_64-randconfig-101-20231208
|   |-- drivers-iommu-iommufd-hw_pagetable.c:preceding-lock-on-line
|   |-- fs-btrfs-extent_io.c:WARNING:atomic_dec_and_test-variation-before-object-free-at-line-.
|   `-- fs-btrfs-extent_io.c:preceding-lock-on-line
|-- x86_64-randconfig-102-20231208
|   `-- drivers-power-supply-cw2015_battery.c:WARNING-opportunity-for-max()
`-- x86_64-randconfig-103-20231208
    |-- drivers-iommu-iommufd-hw_pagetable.c:preceding-lock-on-line
    |-- drivers-power-supply-cw2015_battery.c:WARNING-opportunity-for-max()
    |-- fs-btrfs-extent_io.c:WARNING:atomic_dec_and_test-variation-before-object-free-at-line-.
    |-- fs-btrfs-extent_io.c:preceding-lock-on-line
    `-- fs-btrfs-ordered-data.c:WARNING:atomic_dec_and_test-variation-before-object-free-at-line-.

elapsed time: 1475m

configs tested: 61
configs skipped: 0

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231209   gcc  
arc                   randconfig-002-20231209   gcc  
arm                               allnoconfig   gcc  
arm                   randconfig-001-20231209   gcc  
arm                   randconfig-002-20231209   gcc  
arm                   randconfig-003-20231209   gcc  
arm                   randconfig-004-20231209   gcc  
arm64                             allnoconfig   gcc  
arm64                 randconfig-001-20231209   gcc  
arm64                 randconfig-002-20231209   gcc  
arm64                 randconfig-003-20231209   gcc  
arm64                 randconfig-004-20231209   gcc  
csky                              allnoconfig   gcc  
csky                  randconfig-001-20231209   gcc  
csky                  randconfig-002-20231209   gcc  
hexagon               randconfig-001-20231209   clang
hexagon               randconfig-002-20231209   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231208   clang
i386         buildonly-randconfig-002-20231208   clang
i386         buildonly-randconfig-003-20231208   clang
i386         buildonly-randconfig-004-20231208   clang
i386         buildonly-randconfig-005-20231208   clang
i386         buildonly-randconfig-006-20231208   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231208   clang
i386                  randconfig-002-20231208   clang
i386                  randconfig-003-20231208   clang
i386                  randconfig-004-20231208   clang
i386                  randconfig-005-20231208   clang
i386                  randconfig-006-20231208   clang
i386                  randconfig-011-20231208   gcc  
i386                  randconfig-012-20231208   gcc  
i386                  randconfig-013-20231208   gcc  
i386                  randconfig-014-20231208   gcc  
i386                  randconfig-015-20231208   gcc  
i386                  randconfig-016-20231208   gcc  
loongarch             randconfig-001-20231209   gcc  
loongarch             randconfig-002-20231209   gcc  
nios2                 randconfig-001-20231209   gcc  
nios2                 randconfig-002-20231209   gcc  
parisc                randconfig-001-20231209   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

