Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5429778C1D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 12:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbjHKKdo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 06:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjHKKdn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 06:33:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBA9F5
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 03:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691750022; x=1723286022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=khcevpYazaJGCx4ShUyNm5EYXruWh+5XgTWcaNN7xHo=;
  b=n6byNLZ3VRl70GZvDCE4OkVAUZvqdSyNE9OwkZMcPmotvcyw+TcsOQ8N
   0jgY5wn1uuki2Wlwgc2BBh3ikmJ6EOQGtvVETC++223Bdgi26OHi+Xszg
   c/AuTnArGjFmQnWtjoPob1sZZrsdI8t0kpQ3/DCIxu6hwRfANxtLPT87G
   /LJihq+AXqShA9Tnd6LZQTqHDNZYktA8rSq7x5kBh091RVODftIkRZyDv
   RT5OInbR5ryTQOx20mZudruEC8hBjhL0xaXZagzNGI702LANcBa23f9Ze
   OGY7wvvjXc2Pp8ekfNupZddNAnRAoU6heiusHxkNo/ZyKff/6ig5cG3Yn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="375362227"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="375362227"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 03:33:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="979193583"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="979193583"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 Aug 2023 03:33:39 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUPSc-0007hk-2C;
        Fri, 11 Aug 2023 10:33:38 +0000
Date:   Fri, 11 Aug 2023 18:32:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] btrfs: remove v0 extent handling
Message-ID: <202308111815.mJwoiury-lkp@intel.com>
References: <6258b0bf5e41e52ca0e163e34650d186363628c6.1691740017.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6258b0bf5e41e52ca0e163e34650d186363628c6.1691740017.git.wqu@suse.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master v6.5-rc5 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-remove-v0-extent-handling/20230811-154905
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/6258b0bf5e41e52ca0e163e34650d186363628c6.1691740017.git.wqu%40suse.com
patch subject: [PATCH v2] btrfs: remove v0 extent handling
config: powerpc-randconfig-r034-20230811 (https://download.01.org/0day-ci/archive/20230811/202308111815.mJwoiury-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230811/202308111815.mJwoiury-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308111815.mJwoiury-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/btrfs/print-tree.c:100:17: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
     100 |                           "unexpected extent item size, has %u expect >= %lu",
         |                                                                          ~~~
         |                                                                          %u
     101 |                           item_size, sizeof(*ei));
         |                                      ^~~~~~~~~~~
   fs/btrfs/messages.h:46:40: note: expanded from macro 'btrfs_err'
      46 |         btrfs_printk(fs_info, KERN_ERR fmt, ##args)
         |                                        ~~~    ^~~~
   fs/btrfs/messages.h:27:32: note: expanded from macro 'btrfs_printk'
      27 |         _btrfs_printk(fs_info, fmt, ##args)
         |                                ~~~    ^~~~
   1 warning generated.
--
>> fs/btrfs/extent-tree.c:172:18: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
     172 |                         "unexpected extent item size, has %u expect >= %lu",
         |                                                                        ~~~
         |                                                                        %u
     173 |                                   item_size, sizeof(*ei));
         |                                              ^~~~~~~~~~~
   fs/btrfs/messages.h:46:40: note: expanded from macro 'btrfs_err'
      46 |         btrfs_printk(fs_info, KERN_ERR fmt, ##args)
         |                                        ~~~    ^~~~
   fs/btrfs/messages.h:27:32: note: expanded from macro 'btrfs_printk'
      27 |         _btrfs_printk(fs_info, fmt, ##args)
         |                                ~~~    ^~~~
   fs/btrfs/extent-tree.c:867:17: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
     867 |                           "unexpected extent item size, has %llu expect >= %lu",
         |                                                                            ~~~
         |                                                                            %u
     868 |                           item_size, sizeof(*ei));
         |                                      ^~~~~~~~~~~
   fs/btrfs/messages.h:46:40: note: expanded from macro 'btrfs_err'
      46 |         btrfs_printk(fs_info, KERN_ERR fmt, ##args)
         |                                        ~~~    ^~~~
   fs/btrfs/messages.h:27:32: note: expanded from macro 'btrfs_printk'
      27 |         _btrfs_printk(fs_info, fmt, ##args)
         |                                ~~~    ^~~~
   fs/btrfs/extent-tree.c:1671:17: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
    1671 |                           "unexpected extent item size, has %u expect >= %lu",
         |                                                                          ~~~
         |                                                                          %u
    1672 |                           item_size, sizeof(*ei));
         |                                      ^~~~~~~~~~~
   fs/btrfs/messages.h:46:40: note: expanded from macro 'btrfs_err'
      46 |         btrfs_printk(fs_info, KERN_ERR fmt, ##args)
         |                                        ~~~    ^~~~
   fs/btrfs/messages.h:27:32: note: expanded from macro 'btrfs_printk'
      27 |         _btrfs_printk(fs_info, fmt, ##args)
         |                                ~~~    ^~~~
   fs/btrfs/extent-tree.c:3102:17: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
    3102 |                           "unexpected extent item size, has %u expect >= %lu",
         |                                                                          ~~~
         |                                                                          %u
    3103 |                           item_size, sizeof(*ei));
         |                                      ^~~~~~~~~~~
   fs/btrfs/messages.h:46:40: note: expanded from macro 'btrfs_err'
      46 |         btrfs_printk(fs_info, KERN_ERR fmt, ##args)
         |                                        ~~~    ^~~~
   fs/btrfs/messages.h:27:32: note: expanded from macro 'btrfs_printk'
      27 |         _btrfs_printk(fs_info, fmt, ##args)
         |                                ~~~    ^~~~
   4 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for HOTPLUG_CPU
   Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
   Selected by [y]:
   - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=y] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]


vim +100 fs/btrfs/print-tree.c

    82	
    83	static void print_extent_item(const struct extent_buffer *eb, int slot, int type)
    84	{
    85		struct btrfs_extent_item *ei;
    86		struct btrfs_extent_inline_ref *iref;
    87		struct btrfs_extent_data_ref *dref;
    88		struct btrfs_shared_data_ref *sref;
    89		struct btrfs_disk_key key;
    90		unsigned long end;
    91		unsigned long ptr;
    92		u32 item_size = btrfs_item_size(eb, slot);
    93		u64 flags;
    94		u64 offset;
    95		int ref_index = 0;
    96	
    97		if (unlikely(item_size < sizeof(*ei))) {
    98			btrfs_err(eb->fs_info,
    99				  "unexpected extent item size, has %u expect >= %lu",
 > 100				  item_size, sizeof(*ei));
   101			btrfs_handle_fs_error(eb->fs_info, -EUCLEAN, NULL);
   102		}
   103	
   104		ei = btrfs_item_ptr(eb, slot, struct btrfs_extent_item);
   105		flags = btrfs_extent_flags(eb, ei);
   106	
   107		pr_info("\t\textent refs %llu gen %llu flags %llu\n",
   108		       btrfs_extent_refs(eb, ei), btrfs_extent_generation(eb, ei),
   109		       flags);
   110	
   111		if ((type == BTRFS_EXTENT_ITEM_KEY) &&
   112		    flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
   113			struct btrfs_tree_block_info *info;
   114			info = (struct btrfs_tree_block_info *)(ei + 1);
   115			btrfs_tree_block_key(eb, info, &key);
   116			pr_info("\t\ttree block key (%llu %u %llu) level %d\n",
   117			       btrfs_disk_key_objectid(&key), key.type,
   118			       btrfs_disk_key_offset(&key),
   119			       btrfs_tree_block_level(eb, info));
   120			iref = (struct btrfs_extent_inline_ref *)(info + 1);
   121		} else {
   122			iref = (struct btrfs_extent_inline_ref *)(ei + 1);
   123		}
   124	
   125		ptr = (unsigned long)iref;
   126		end = (unsigned long)ei + item_size;
   127		while (ptr < end) {
   128			iref = (struct btrfs_extent_inline_ref *)ptr;
   129			type = btrfs_extent_inline_ref_type(eb, iref);
   130			offset = btrfs_extent_inline_ref_offset(eb, iref);
   131			pr_info("\t\tref#%d: ", ref_index++);
   132			switch (type) {
   133			case BTRFS_TREE_BLOCK_REF_KEY:
   134				pr_cont("tree block backref root %llu\n", offset);
   135				break;
   136			case BTRFS_SHARED_BLOCK_REF_KEY:
   137				pr_cont("shared block backref parent %llu\n", offset);
   138				/*
   139				 * offset is supposed to be a tree block which
   140				 * must be aligned to nodesize.
   141				 */
   142				if (!IS_ALIGNED(offset, eb->fs_info->sectorsize))
   143					pr_info(
   144				"\t\t\t(parent %llu not aligned to sectorsize %u)\n",
   145						offset, eb->fs_info->sectorsize);
   146				break;
   147			case BTRFS_EXTENT_DATA_REF_KEY:
   148				dref = (struct btrfs_extent_data_ref *)(&iref->offset);
   149				print_extent_data_ref(eb, dref);
   150				break;
   151			case BTRFS_SHARED_DATA_REF_KEY:
   152				sref = (struct btrfs_shared_data_ref *)(iref + 1);
   153				pr_cont("shared data backref parent %llu count %u\n",
   154				       offset, btrfs_shared_data_ref_count(eb, sref));
   155				/*
   156				 * Offset is supposed to be a tree block which must be
   157				 * aligned to sectorsize.
   158				 */
   159				if (!IS_ALIGNED(offset, eb->fs_info->sectorsize))
   160					pr_info(
   161				"\t\t\t(parent %llu not aligned to sectorsize %u)\n",
   162					     offset, eb->fs_info->sectorsize);
   163				break;
   164			default:
   165				pr_cont("(extent %llu has INVALID ref type %d)\n",
   166					  eb->start, type);
   167				return;
   168			}
   169			ptr += btrfs_extent_inline_ref_size(type);
   170		}
   171		WARN_ON(ptr > end);
   172	}
   173	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
