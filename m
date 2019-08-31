Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5FA1A424F
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Aug 2019 06:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfHaEuo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Aug 2019 00:50:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:43325 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfHaEuo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Aug 2019 00:50:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 21:50:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,449,1559545200"; 
   d="gz'50?scan'50,208,50";a="186501535"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 Aug 2019 21:50:41 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i3vLU-000HVT-Qg; Sat, 31 Aug 2019 12:50:40 +0800
Date:   Sat, 31 Aug 2019 12:50:27 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     kbuild-all@01.org, David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v5 4/4] btrfs: sysfs: export supported checksums
Message-ID: <201908311214.mlzW0MCf%lkp@intel.com>
References: <20190830113611.16865-5-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rgdlqbq57eku7omu"
Content-Disposition: inline
In-Reply-To: <20190830113611.16865-5-jthumshirn@suse.de>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--rgdlqbq57eku7omu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Johannes,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[cannot apply to v5.3-rc6 next-20190830]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Johannes-Thumshirn/btrfs-turn-checksum-type-define-into-a-enum/20190831-103832
config: i386-randconfig-a003-201934 (attached as .config)
compiler: gcc-6 (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/percpu.h:45:0,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from fs/btrfs/sysfs.c:6:
   fs/btrfs/sysfs.c: In function 'btrfs_supported_checksums_show':
>> fs/btrfs/sysfs.c:192:29: error: 'btrfs_csums' undeclared (first use in this function)
     for (i = 0; i < ARRAY_SIZE(btrfs_csums); i++) {
                                ^
   include/linux/kernel.h:47:33: note: in definition of macro 'ARRAY_SIZE'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                    ^~~
   fs/btrfs/sysfs.c:192:29: note: each undeclared identifier is reported only once for each function it appears in
     for (i = 0; i < ARRAY_SIZE(btrfs_csums); i++) {
                                ^
   include/linux/kernel.h:47:33: note: in definition of macro 'ARRAY_SIZE'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                    ^~~
   In file included from include/linux/kernel.h:16:0,
                    from arch/x86/include/asm/percpu.h:45,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from fs/btrfs/sysfs.c:6:
   include/linux/build_bug.h:16:45: error: bit-field '<anonymous>' width not an integer constant
    #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
                                                ^
   include/linux/compiler.h:357:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
    #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                               ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:47:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^~~~~~~~~~~~~~~
   fs/btrfs/sysfs.c:192:18: note: in expansion of macro 'ARRAY_SIZE'
     for (i = 0; i < ARRAY_SIZE(btrfs_csums); i++) {
                     ^~~~~~~~~~

vim +/btrfs_csums +192 fs/btrfs/sysfs.c

   > 6	#include <linux/sched.h>
     7	#include <linux/slab.h>
     8	#include <linux/spinlock.h>
     9	#include <linux/completion.h>
    10	#include <linux/kobject.h>
    11	#include <linux/bug.h>
    12	#include <linux/debugfs.h>
    13	
    14	#include "ctree.h"
    15	#include "disk-io.h"
    16	#include "transaction.h"
    17	#include "sysfs.h"
    18	#include "volumes.h"
    19	#include "space-info.h"
    20	
    21	static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj);
    22	static inline struct btrfs_fs_devices *to_fs_devs(struct kobject *kobj);
    23	
    24	static u64 get_features(struct btrfs_fs_info *fs_info,
    25				enum btrfs_feature_set set)
    26	{
    27		struct btrfs_super_block *disk_super = fs_info->super_copy;
    28		if (set == FEAT_COMPAT)
    29			return btrfs_super_compat_flags(disk_super);
    30		else if (set == FEAT_COMPAT_RO)
    31			return btrfs_super_compat_ro_flags(disk_super);
    32		else
    33			return btrfs_super_incompat_flags(disk_super);
    34	}
    35	
    36	static void set_features(struct btrfs_fs_info *fs_info,
    37				 enum btrfs_feature_set set, u64 features)
    38	{
    39		struct btrfs_super_block *disk_super = fs_info->super_copy;
    40		if (set == FEAT_COMPAT)
    41			btrfs_set_super_compat_flags(disk_super, features);
    42		else if (set == FEAT_COMPAT_RO)
    43			btrfs_set_super_compat_ro_flags(disk_super, features);
    44		else
    45			btrfs_set_super_incompat_flags(disk_super, features);
    46	}
    47	
    48	static int can_modify_feature(struct btrfs_feature_attr *fa)
    49	{
    50		int val = 0;
    51		u64 set, clear;
    52		switch (fa->feature_set) {
    53		case FEAT_COMPAT:
    54			set = BTRFS_FEATURE_COMPAT_SAFE_SET;
    55			clear = BTRFS_FEATURE_COMPAT_SAFE_CLEAR;
    56			break;
    57		case FEAT_COMPAT_RO:
    58			set = BTRFS_FEATURE_COMPAT_RO_SAFE_SET;
    59			clear = BTRFS_FEATURE_COMPAT_RO_SAFE_CLEAR;
    60			break;
    61		case FEAT_INCOMPAT:
    62			set = BTRFS_FEATURE_INCOMPAT_SAFE_SET;
    63			clear = BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR;
    64			break;
    65		default:
    66			pr_warn("btrfs: sysfs: unknown feature set %d\n",
    67					fa->feature_set);
    68			return 0;
    69		}
    70	
    71		if (set & fa->feature_bit)
    72			val |= 1;
    73		if (clear & fa->feature_bit)
    74			val |= 2;
    75	
    76		return val;
    77	}
    78	
    79	static ssize_t btrfs_feature_attr_show(struct kobject *kobj,
    80					       struct kobj_attribute *a, char *buf)
    81	{
    82		int val = 0;
    83		struct btrfs_fs_info *fs_info = to_fs_info(kobj);
    84		struct btrfs_feature_attr *fa = to_btrfs_feature_attr(a);
    85		if (fs_info) {
    86			u64 features = get_features(fs_info, fa->feature_set);
    87			if (features & fa->feature_bit)
    88				val = 1;
    89		} else
    90			val = can_modify_feature(fa);
    91	
    92		return snprintf(buf, PAGE_SIZE, "%d\n", val);
    93	}
    94	
    95	static ssize_t btrfs_feature_attr_store(struct kobject *kobj,
    96						struct kobj_attribute *a,
    97						const char *buf, size_t count)
    98	{
    99		struct btrfs_fs_info *fs_info;
   100		struct btrfs_feature_attr *fa = to_btrfs_feature_attr(a);
   101		u64 features, set, clear;
   102		unsigned long val;
   103		int ret;
   104	
   105		fs_info = to_fs_info(kobj);
   106		if (!fs_info)
   107			return -EPERM;
   108	
   109		if (sb_rdonly(fs_info->sb))
   110			return -EROFS;
   111	
   112		ret = kstrtoul(skip_spaces(buf), 0, &val);
   113		if (ret)
   114			return ret;
   115	
   116		if (fa->feature_set == FEAT_COMPAT) {
   117			set = BTRFS_FEATURE_COMPAT_SAFE_SET;
   118			clear = BTRFS_FEATURE_COMPAT_SAFE_CLEAR;
   119		} else if (fa->feature_set == FEAT_COMPAT_RO) {
   120			set = BTRFS_FEATURE_COMPAT_RO_SAFE_SET;
   121			clear = BTRFS_FEATURE_COMPAT_RO_SAFE_CLEAR;
   122		} else {
   123			set = BTRFS_FEATURE_INCOMPAT_SAFE_SET;
   124			clear = BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR;
   125		}
   126	
   127		features = get_features(fs_info, fa->feature_set);
   128	
   129		/* Nothing to do */
   130		if ((val && (features & fa->feature_bit)) ||
   131		    (!val && !(features & fa->feature_bit)))
   132			return count;
   133	
   134		if ((val && !(set & fa->feature_bit)) ||
   135		    (!val && !(clear & fa->feature_bit))) {
   136			btrfs_info(fs_info,
   137				"%sabling feature %s on mounted fs is not supported.",
   138				val ? "En" : "Dis", fa->kobj_attr.attr.name);
   139			return -EPERM;
   140		}
   141	
   142		btrfs_info(fs_info, "%s %s feature flag",
   143			   val ? "Setting" : "Clearing", fa->kobj_attr.attr.name);
   144	
   145		spin_lock(&fs_info->super_lock);
   146		features = get_features(fs_info, fa->feature_set);
   147		if (val)
   148			features |= fa->feature_bit;
   149		else
   150			features &= ~fa->feature_bit;
   151		set_features(fs_info, fa->feature_set, features);
   152		spin_unlock(&fs_info->super_lock);
   153	
   154		/*
   155		 * We don't want to do full transaction commit from inside sysfs
   156		 */
   157		btrfs_set_pending(fs_info, COMMIT);
   158		wake_up_process(fs_info->transaction_kthread);
   159	
   160		return count;
   161	}
   162	
   163	static umode_t btrfs_feature_visible(struct kobject *kobj,
   164					     struct attribute *attr, int unused)
   165	{
   166		struct btrfs_fs_info *fs_info = to_fs_info(kobj);
   167		umode_t mode = attr->mode;
   168	
   169		if (fs_info) {
   170			struct btrfs_feature_attr *fa;
   171			u64 features;
   172	
   173			fa = attr_to_btrfs_feature_attr(attr);
   174			features = get_features(fs_info, fa->feature_set);
   175	
   176			if (can_modify_feature(fa))
   177				mode |= S_IWUSR;
   178			else if (!(features & fa->feature_bit))
   179				mode = 0;
   180		}
   181	
   182		return mode;
   183	}
   184	
   185	static ssize_t btrfs_supported_checksums_show(struct kobject *kobj,
   186						      struct kobj_attribute *a,
   187						      char *buf)
   188	{
   189		ssize_t ret = 0;
   190		int i;
   191	
 > 192		for (i = 0; i < ARRAY_SIZE(btrfs_csums); i++) {
   193			ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
   194					(i == 0 ? "" : ", "),
   195					btrfs_csums[i].name);
   196	
   197		}
   198	
   199		ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
   200		return ret;
   201	}
   202	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--rgdlqbq57eku7omu
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--rgdlqbq57eku7omu--
