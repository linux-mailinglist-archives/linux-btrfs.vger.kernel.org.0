Return-Path: <linux-btrfs+bounces-8356-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0125898B1AD
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 03:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A804B282E77
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 01:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E32FD26D;
	Tue,  1 Oct 2024 01:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AlOxQc0K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE7E29AF;
	Tue,  1 Oct 2024 01:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727745172; cv=none; b=bhmfUPB6lb4w5JJd71eLhlG44G+PZG0rl6WZ0mTKWLz+QiTuweH9dsfZZINPlb/VL9vARfjO2MFojx8O8k4ESxhBw6GArH4ZlZDNse8dJ+HY2qPmtcIGJ0nAaOMTh4KnCmc2kG/fNLrQ0Frc0HdiQpnJ/atuf0pzUjsYCVzd8Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727745172; c=relaxed/simple;
	bh=eMWW+QOibMB9OCanGisHscEcQAO7Efgubx5gtH2ej6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khuKiSuVQ2exXV/Eq1e+UhUhzc1OGsOHAzM104OL00aXdEK58bqa3fu/kqiuiX+qbHQPRfQ+/39WmSW8rMGfmFG7KRcAWIb5454EfRWCyNi306vvtGkGkfx9ze18tUnzRpfY0t3z/a0kf1rqxTJiseDMNMtt/QdaGn83rqNodTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AlOxQc0K; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727745170; x=1759281170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eMWW+QOibMB9OCanGisHscEcQAO7Efgubx5gtH2ej6Q=;
  b=AlOxQc0Krxzt8ZeHdaPJLK5oluIW1caln0SWCaZ8SBdC6AbeZgqgCBoN
   uQzSH0HYSog5Qn8N4oIwgu76RX7S2PbYdZTRQKO+HJZxOZy3cfLijcurm
   uhqyZSSCeyTk7qJUvLQCfakMMc0msZa3n6YaF/R48Dp8q79pL8mlI2rsb
   Wlq46oRSurjDu1HwOaCtu7wdd9cEpq+hreWZUG1SkkL3G9lyJxv66g+Sp
   kbAHUzBnIaT4adCkDRNvUXlro9QyidGzt+q3UiZL4jZ/g1Fs6ngAiA4Uk
   LIT/Y95YExrEfiJ6WL5WzHYODbfpl47vdtf+6lZCZ68vixZ69V2glfgtW
   g==;
X-CSE-ConnectionGUID: wDB1K3kzQLe3VodOqiGecA==
X-CSE-MsgGUID: L1Z/pG4YQYq+4rg/SMw0HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="37532360"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37532360"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 18:12:49 -0700
X-CSE-ConnectionGUID: iaM572qxSbmn80zA5QnYtA==
X-CSE-MsgGUID: IDsAevbUS5mqEhDi40mR6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="74261048"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 30 Sep 2024 18:12:46 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svRRT-000Q6n-39;
	Tue, 01 Oct 2024 01:12:43 +0000
Date: Tue, 1 Oct 2024 09:11:57 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Thumshirn <jth@kernel.org>,
	Chris Mason <chris.mason@fusionio.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] btrfs: tests: add selftests for RAID stripe-tree
Message-ID: <202410010831.9lOBKwBS-lkp@intel.com>
References: <20240930104054.12290-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930104054.12290-1-jth@kernel.org>

Hi Johannes,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master v6.12-rc1 next-20240930]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Thumshirn/btrfs-tests-add-selftests-for-RAID-stripe-tree/20240930-184234
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20240930104054.12290-1-jth%40kernel.org
patch subject: [PATCH] btrfs: tests: add selftests for RAID stripe-tree
config: x86_64-randconfig-122-20241001 (https://download.01.org/0day-ci/archive/20241001/202410010831.9lOBKwBS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241001/202410010831.9lOBKwBS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410010831.9lOBKwBS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/btrfs/print-tree.c: note: in included file:
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
   fs/btrfs/print-tree.c: note: in included file:
>> fs/btrfs/raid-stripe-tree.h:31:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
--
   fs/btrfs/root-tree.c: note: in included file (through fs/btrfs/space-info.h):
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
--
   fs/btrfs/extent-tree.c: note: in included file:
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
   fs/btrfs/extent-tree.c: note: in included file:
>> fs/btrfs/raid-stripe-tree.h:31:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
   fs/btrfs/extent-tree.c:1829:9: sparse: sparse: context imbalance in 'run_and_cleanup_extent_op' - unexpected unlock
   fs/btrfs/extent-tree.c:1893:28: sparse: sparse: context imbalance in 'cleanup_ref_head' - unexpected unlock
   fs/btrfs/extent-tree.c:1972:36: sparse: sparse: context imbalance in 'btrfs_run_delayed_refs_for_head' - unexpected unlock
   fs/btrfs/extent-tree.c:2041:21: sparse: sparse: context imbalance in '__btrfs_run_delayed_refs' - wrong count at exit
--
   fs/btrfs/ctree.c: note: in included file:
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
   fs/btrfs/ctree.c:260:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/ctree.c:260:22: sparse:    struct extent_buffer [noderef] __rcu *
   fs/btrfs/ctree.c:260:22: sparse:    struct extent_buffer *
   fs/btrfs/ctree.c:620:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/ctree.c:620:17: sparse:    struct extent_buffer [noderef] __rcu *
   fs/btrfs/ctree.c:620:17: sparse:    struct extent_buffer *
   fs/btrfs/ctree.c:981:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/ctree.c:981:17: sparse:    struct extent_buffer [noderef] __rcu *
   fs/btrfs/ctree.c:981:17: sparse:    struct extent_buffer *
   fs/btrfs/ctree.c:2910:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/btrfs/ctree.c:2910:9: sparse:    struct extent_buffer [noderef] __rcu *
   fs/btrfs/ctree.c:2910:9: sparse:    struct extent_buffer *
--
   fs/btrfs/inode-item.c: note: in included file (through fs/btrfs/space-info.h):
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
--
   fs/btrfs/super.c: note: in included file (through fs/btrfs/space-info.h):
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
   fs/btrfs/super.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/btrfs.h):
   include/trace/events/btrfs.h:2394:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] opf @@     got restricted blk_opf_t enum req_op @@
   include/trace/events/btrfs.h:2394:1: sparse:     expected unsigned char [usertype] opf
   include/trace/events/btrfs.h:2394:1: sparse:     got restricted blk_opf_t enum req_op
   fs/btrfs/super.c: note: in included file (through include/trace/perf.h, include/trace/define_trace.h, include/trace/events/btrfs.h):
   include/trace/events/btrfs.h:2394:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] opf @@     got restricted blk_opf_t enum req_op @@
   include/trace/events/btrfs.h:2394:1: sparse:     expected unsigned char [usertype] opf
   include/trace/events/btrfs.h:2394:1: sparse:     got restricted blk_opf_t enum req_op
--
   fs/btrfs/transaction.c: note: in included file:
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
   fs/btrfs/transaction.c: note: in included file (through arch/x86/include/generated/asm/unaligned.h, fs/btrfs/accessors.h, fs/btrfs/ctree.h):
   include/asm-generic/unaligned.h:37:16: sparse: sparse: self-comparison always evaluates to true
--
   fs/btrfs/sysfs.c: note: in included file:
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
   fs/btrfs/sysfs.c:662:9: sparse: sparse: context imbalance in 'btrfs_show_u64' - different lock contexts for basic block
--
   fs/btrfs/disk-io.c: note: in included file (through fs/btrfs/raid56.h):
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
--
   fs/btrfs/inode.c: note: in included file (through fs/btrfs/space-info.h):
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
   fs/btrfs/inode.c: note: in included file:
>> fs/btrfs/raid-stripe-tree.h:31:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
   fs/btrfs/inode.c: note: in included file (through arch/x86/include/asm/processor.h, arch/x86/include/asm/cpufeature.h, arch/x86/include/asm/thread_info.h, ...):
   include/linux/err.h:41:17: sparse: sparse: self-comparison always evaluates to false
--
   fs/btrfs/extent_io.c: note: in included file (through fs/btrfs/zoned.h):
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
   fs/btrfs/extent_io.c:2465:13: sparse: sparse: context imbalance in 'detach_extent_buffer_folio' - different lock contexts for basic block
--
   fs/btrfs/ioctl.c: note: in included file:
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
   fs/btrfs/ioctl.c:434:6: sparse: sparse: context imbalance in 'btrfs_exclop_start_try_lock' - wrong count at exit
   fs/btrfs/ioctl.c:447:6: sparse: sparse: context imbalance in 'btrfs_exclop_start_unlock' - unexpected unlock
--
   fs/btrfs/volumes.c: note: in included file:
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
   fs/btrfs/volumes.c: note: in included file:
>> fs/btrfs/raid-stripe-tree.h:31:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
   fs/btrfs/volumes.c:405:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct rcu_string *str @@     got struct rcu_string [noderef] __rcu *name @@
   fs/btrfs/volumes.c:405:31: sparse:     expected struct rcu_string *str
   fs/btrfs/volumes.c:405:31: sparse:     got struct rcu_string [noderef] __rcu *name
   fs/btrfs/volumes.c:659:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *device_path @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:659:43: sparse:     expected char const *device_path
   fs/btrfs/volumes.c:659:43: sparse:     got char [noderef] __rcu *
   fs/btrfs/volumes.c:855:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const * @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:855:50: sparse:     expected char const *
   fs/btrfs/volumes.c:855:50: sparse:     got char [noderef] __rcu *
   fs/btrfs/volumes.c:928:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct rcu_string *str @@     got struct rcu_string [noderef] __rcu *name @@
   fs/btrfs/volumes.c:928:39: sparse:     expected struct rcu_string *str
   fs/btrfs/volumes.c:928:39: sparse:     got struct rcu_string [noderef] __rcu *name
   fs/btrfs/volumes.c:978:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const *dev_path @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:978:34: sparse:     expected char const *dev_path
   fs/btrfs/volumes.c:978:34: sparse:     got char [noderef] __rcu *
   fs/btrfs/volumes.c:1352:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const * @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:1352:42: sparse:     expected char const *
   fs/btrfs/volumes.c:1352:42: sparse:     got char [noderef] __rcu *
   fs/btrfs/volumes.c:2113:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *device_path @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:2113:31: sparse:     expected char const *device_path
   fs/btrfs/volumes.c:2113:31: sparse:     got char [noderef] __rcu *
   fs/btrfs/volumes.c:1505:29: sparse: sparse: self-comparison always evaluates to false
--
   fs/btrfs/free-space-cache.c: note: in included file (through fs/btrfs/space-info.h):
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
   fs/btrfs/free-space-cache.c:1144:9: sparse: sparse: context imbalance in 'write_cache_extent_entries' - different lock contexts for basic block
   fs/btrfs/free-space-cache.c:2398:28: sparse: sparse: context imbalance in 'insert_into_bitmap' - unexpected unlock
--
   fs/btrfs/delayed-ref.c: note: in included file (through fs/btrfs/space-info.h):
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
--
   fs/btrfs/tree-log.c: note: in included file (through fs/btrfs/space-info.h):
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
--
   fs/btrfs/delayed-inode.c: note: in included file (through fs/btrfs/space-info.h):
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
--
   fs/btrfs/props.c: note: in included file (through fs/btrfs/space-info.h):
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
--
   fs/btrfs/dev-replace.c: note: in included file:
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
--
   fs/btrfs/scrub.c: note: in included file:
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
   fs/btrfs/scrub.c: note: in included file:
>> fs/btrfs/raid-stripe-tree.h:31:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
--
   fs/btrfs/block-rsv.c: note: in included file (through fs/btrfs/space-info.h):
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
--
   fs/btrfs/tree-checker.c: note: in included file:
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
--
   fs/btrfs/space-info.c: note: in included file (through fs/btrfs/space-info.h):
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
--
   fs/btrfs/delalloc-space.c: note: in included file (through fs/btrfs/space-info.h):
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
--
   fs/btrfs/raid56.c: note: in included file:
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
--
   fs/btrfs/raid-stripe-tree.c: note: in included file:
>> fs/btrfs/raid-stripe-tree.h:31:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
   fs/btrfs/raid-stripe-tree.c: note: in included file:
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
--
   fs/btrfs/direct-io.c: note: in included file:
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
--
   fs/btrfs/relocation.c: note: in included file:
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
   fs/btrfs/relocation.c: note: in included file:
>> fs/btrfs/raid-stripe-tree.h:31:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
--
   fs/btrfs/bio.c: note: in included file:
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
   fs/btrfs/bio.c: note: in included file:
>> fs/btrfs/raid-stripe-tree.h:31:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'
--
   fs/btrfs/block-group.c: note: in included file (through fs/btrfs/space-info.h):
>> fs/btrfs/volumes.h:837:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_BTRFS_FS_RUN_SANITY_TESTS'

vim +/CONFIG_BTRFS_FS_RUN_SANITY_TESTS +837 fs/btrfs/volumes.h

   836	
 > 837	#if CONFIG_BTRFS_FS_RUN_SANITY_TESTS
   838	struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
   839							u64 logical, u16 total_stripes);
   840	#endif
   841	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

