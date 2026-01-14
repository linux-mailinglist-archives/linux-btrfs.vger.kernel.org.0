Return-Path: <linux-btrfs+bounces-20488-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39992D1CA22
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 07:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DA2330B78E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 06:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754263557E2;
	Wed, 14 Jan 2026 06:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wx6a5ORf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64564352C2B
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 06:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768370845; cv=none; b=Ppq5ekHfG67TN3EMQZxcrd0rkj8JiplMQETjdIVhmlyASP9l+CT56VyvzH385uuAioppqVmLOeo1ZGzWTyOCbZsp0iRTuUkk0tIT2vR1HimhenoBf2pE19iTyyxIWZqUERHA8HjdXiLolc5kM/mC9B/vaajhAYMdL6xwDlC7BzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768370845; c=relaxed/simple;
	bh=PyUKjHMKvN9q257dJ5H+FCKwPHHOw/v8wvcDC0gEHI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uunCD56tEdHT5qV6LAEfY6ne5lye581V/OirDe+3OlU9XG/dmhKtIh+u5HC1LhNIvkSNaqDFR1Wjexe5OnPjn0D1wJvVw//vCVCMEnogoQ08BM0uZUyFDtuscBzFupoKU1m02ANObG+m2QNACChn4cOZJI0Gg9NpyL88yTOEbx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wx6a5ORf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768370840; x=1799906840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PyUKjHMKvN9q257dJ5H+FCKwPHHOw/v8wvcDC0gEHI4=;
  b=Wx6a5ORf6mCvjckZNLfgPDGa4SLqofuuWOXUnsHgq5XI0WNKo5NsRgoi
   bd9cH5o8mbEn3fHjDPqs+7hdeScj72AIi0JuWZ8A6MllxnTNZXWrUuyMN
   wXIOyl3zRTS68S25afDTdWEiaOG5+WG4GGTsepY5Qsyqn2DjlxikTkvon
   gWt8d3oe595Ky9OmsL8qE5sNjuN2x8i5n2qjWWokCLUYGpkwZuxcfOEZm
   UP72E0MWCPSn40QhS10vosLALtRiIBNJC84LIP9jey1DVop7FTsXQXC+b
   pZmG2yl+XUrYccjt3ld9HUWhWJdvNVFFwczeW0Ey3uCFImnlj7kS5yi5T
   A==;
X-CSE-ConnectionGUID: gydE4KUTSYibfR+D2kXyXg==
X-CSE-MsgGUID: LyCZ5FMRSBqJOsnCnKVQBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="81028785"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="81028785"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 22:07:17 -0800
X-CSE-ConnectionGUID: yNHxhQaZTOGv36p6JRR86g==
X-CSE-MsgGUID: Uo3wEjqXRfioLHR1qOps+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="205007530"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 13 Jan 2026 22:07:15 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfu2D-00000000Fu4-0map;
	Wed, 14 Jan 2026 06:07:13 +0000
Date: Wed, 14 Jan 2026 14:06:15 +0800
From: kernel test robot <lkp@intel.com>
To: Martin Raiber <martin@urbackup.org>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Martin Raiber <martin@urbackup.org>
Subject: Re: [PATCH 1/7] btrfs: Use percpu refcounting for block groups
Message-ID: <202601141316.7JnRkX9k-lkp@intel.com>
References: <0102019bb2ff56b7-9302e783-c17d-452d-b6a7-11f773776ae7-000000@eu-west-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0102019bb2ff56b7-9302e783-c17d-452d-b6a7-11f773776ae7-000000@eu-west-1.amazonses.com>

Hi Martin,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.19-rc5 next-20260113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Raiber/btrfs-Use-percpu-semaphore-for-space-info-groups_sem/20260113-070107
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/0102019bb2ff56b7-9302e783-c17d-452d-b6a7-11f773776ae7-000000%40eu-west-1.amazonses.com
patch subject: [PATCH 1/7] btrfs: Use percpu refcounting for block groups
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260114/202601141316.7JnRkX9k-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260114/202601141316.7JnRkX9k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601141316.7JnRkX9k-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/btrfs/block-group.c: In function 'btrfs_wait_block_group_reservations':
>> fs/btrfs/block-group.c:416:27: error: passing argument 1 of 'percpu_down_write' from incompatible pointer type [-Wincompatible-pointer-types]
     416 |         percpu_down_write(&space_info->groups_sem);
         |                           ^~~~~~~~~~~~~~~~~~~~~~~
         |                           |
         |                           struct rw_semaphore *
   In file included from include/linux/fs/super_types.h:13,
                    from include/linux/fs/super.h:5,
                    from include/linux/fs.h:5,
                    from include/linux/huge_mm.h:7,
                    from include/linux/mm.h:1268,
                    from fs/btrfs/misc.h:10,
                    from fs/btrfs/block-group.c:5:
   include/linux/percpu-rwsem.h:138:31: note: expected 'struct percpu_rw_semaphore *' but argument is of type 'struct rw_semaphore *'
     138 | extern void percpu_down_write(struct percpu_rw_semaphore *);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> fs/btrfs/block-group.c:417:25: error: passing argument 1 of 'percpu_up_write' from incompatible pointer type [-Wincompatible-pointer-types]
     417 |         percpu_up_write(&space_info->groups_sem);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                         |
         |                         struct rw_semaphore *
   include/linux/percpu-rwsem.h:139:29: note: expected 'struct percpu_rw_semaphore *' but argument is of type 'struct rw_semaphore *'
     139 | extern void percpu_up_write(struct percpu_rw_semaphore *);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/block-group.c: In function 'clear_incompat_bg_bits':
>> fs/btrfs/block-group.c:1022:42: error: passing argument 1 of 'percpu_down_read' from incompatible pointer type [-Wincompatible-pointer-types]
    1022 |                         percpu_down_read(&sinfo->groups_sem);
         |                                          ^~~~~~~~~~~~~~~~~~
         |                                          |
         |                                          struct rw_semaphore *
   include/linux/percpu-rwsem.h:75:65: note: expected 'struct percpu_rw_semaphore *' but argument is of type 'struct rw_semaphore *'
      75 | static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
>> fs/btrfs/block-group.c:1031:40: error: passing argument 1 of 'percpu_up_read' from incompatible pointer type [-Wincompatible-pointer-types]
    1031 |                         percpu_up_read(&sinfo->groups_sem);
         |                                        ^~~~~~~~~~~~~~~~~~
         |                                        |
         |                                        struct rw_semaphore *
   include/linux/percpu-rwsem.h:110:63: note: expected 'struct percpu_rw_semaphore *' but argument is of type 'struct rw_semaphore *'
     110 | static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
         |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   fs/btrfs/block-group.c: In function 'btrfs_remove_block_group':
   fs/btrfs/block-group.c:1173:27: error: passing argument 1 of 'percpu_down_write' from incompatible pointer type [-Wincompatible-pointer-types]
    1173 |         percpu_down_write(&block_group->space_info->groups_sem);
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                           |
         |                           struct rw_semaphore *
   include/linux/percpu-rwsem.h:138:31: note: expected 'struct percpu_rw_semaphore *' but argument is of type 'struct rw_semaphore *'
     138 | extern void percpu_down_write(struct percpu_rw_semaphore *);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/block-group.c:1184:25: error: passing argument 1 of 'percpu_up_write' from incompatible pointer type [-Wincompatible-pointer-types]
    1184 |         percpu_up_write(&block_group->space_info->groups_sem);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                         |
         |                         struct rw_semaphore *
   include/linux/percpu-rwsem.h:139:29: note: expected 'struct percpu_rw_semaphore *' but argument is of type 'struct rw_semaphore *'
     139 | extern void percpu_up_write(struct percpu_rw_semaphore *);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/block-group.c: In function 'btrfs_delete_unused_bgs':
   fs/btrfs/block-group.c:1554:35: error: passing argument 1 of 'percpu_down_write' from incompatible pointer type [-Wincompatible-pointer-types]
    1554 |                 percpu_down_write(&space_info->groups_sem);
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~
         |                                   |
         |                                   struct rw_semaphore *
   include/linux/percpu-rwsem.h:138:31: note: expected 'struct percpu_rw_semaphore *' but argument is of type 'struct rw_semaphore *'
     138 | extern void percpu_down_write(struct percpu_rw_semaphore *);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/block-group.c:1564:41: error: passing argument 1 of 'percpu_up_write' from incompatible pointer type [-Wincompatible-pointer-types]
    1564 |                         percpu_up_write(&space_info->groups_sem);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         |
         |                                         struct rw_semaphore *
   include/linux/percpu-rwsem.h:139:29: note: expected 'struct percpu_rw_semaphore *' but argument is of type 'struct rw_semaphore *'
     139 | extern void percpu_up_write(struct percpu_rw_semaphore *);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/block-group.c:1591:41: error: passing argument 1 of 'percpu_up_write' from incompatible pointer type [-Wincompatible-pointer-types]
    1591 |                         percpu_up_write(&space_info->groups_sem);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         |
         |                                         struct rw_semaphore *
   include/linux/percpu-rwsem.h:139:29: note: expected 'struct percpu_rw_semaphore *' but argument is of type 'struct rw_semaphore *'
     139 | extern void percpu_up_write(struct percpu_rw_semaphore *);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/block-group.c:1628:41: error: passing argument 1 of 'percpu_up_write' from incompatible pointer type [-Wincompatible-pointer-types]
    1628 |                         percpu_up_write(&space_info->groups_sem);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         |
         |                                         struct rw_semaphore *
   include/linux/percpu-rwsem.h:139:29: note: expected 'struct percpu_rw_semaphore *' but argument is of type 'struct rw_semaphore *'
     139 | extern void percpu_up_write(struct percpu_rw_semaphore *);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/block-group.c:1637:33: error: passing argument 1 of 'percpu_up_write' from incompatible pointer type [-Wincompatible-pointer-types]
    1637 |                 percpu_up_write(&space_info->groups_sem);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 struct rw_semaphore *
   include/linux/percpu-rwsem.h:139:29: note: expected 'struct percpu_rw_semaphore *' but argument is of type 'struct rw_semaphore *'
     139 | extern void percpu_up_write(struct percpu_rw_semaphore *);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/block-group.c: In function 'btrfs_reclaim_bgs_work':
   fs/btrfs/block-group.c:1892:35: error: passing argument 1 of 'percpu_down_write' from incompatible pointer type [-Wincompatible-pointer-types]
    1892 |                 percpu_down_write(&space_info->groups_sem);
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~
         |                                   |
         |                                   struct rw_semaphore *
   include/linux/percpu-rwsem.h:138:31: note: expected 'struct percpu_rw_semaphore *' but argument is of type 'struct rw_semaphore *'
     138 | extern void percpu_down_write(struct percpu_rw_semaphore *);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/block-group.c:1905:41: error: passing argument 1 of 'percpu_up_write' from incompatible pointer type [-Wincompatible-pointer-types]
    1905 |                         percpu_up_write(&space_info->groups_sem);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         |
         |                                         struct rw_semaphore *
   include/linux/percpu-rwsem.h:139:29: note: expected 'struct percpu_rw_semaphore *' but argument is of type 'struct rw_semaphore *'
     139 | extern void percpu_up_write(struct percpu_rw_semaphore *);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/block-group.c:1924:41: error: passing argument 1 of 'percpu_up_write' from incompatible pointer type [-Wincompatible-pointer-types]
    1924 |                         percpu_up_write(&space_info->groups_sem);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         |
         |                                         struct rw_semaphore *
   include/linux/percpu-rwsem.h:139:29: note: expected 'struct percpu_rw_semaphore *' but argument is of type 'struct rw_semaphore *'
     139 | extern void percpu_up_write(struct percpu_rw_semaphore *);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/block-group.c:1941:41: error: passing argument 1 of 'percpu_up_write' from incompatible pointer type [-Wincompatible-pointer-types]
    1941 |                         percpu_up_write(&space_info->groups_sem);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         |
         |                                         struct rw_semaphore *
   include/linux/percpu-rwsem.h:139:29: note: expected 'struct percpu_rw_semaphore *' but argument is of type 'struct rw_semaphore *'
     139 | extern void percpu_up_write(struct percpu_rw_semaphore *);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/block-group.c:1957:41: error: passing argument 1 of 'percpu_up_write' from incompatible pointer type [-Wincompatible-pointer-types]
    1957 |                         percpu_up_write(&space_info->groups_sem);


vim +/percpu_down_write +416 fs/btrfs/block-group.c

   396	
   397	void btrfs_wait_block_group_reservations(struct btrfs_block_group *bg)
   398	{
   399		struct btrfs_space_info *space_info = bg->space_info;
   400	
   401		ASSERT(bg->ro);
   402	
   403		if (!(bg->flags & BTRFS_BLOCK_GROUP_DATA))
   404			return;
   405	
   406		/*
   407		 * Our block group is read only but before we set it to read only,
   408		 * some task might have had allocated an extent from it already, but it
   409		 * has not yet created a respective ordered extent (and added it to a
   410		 * root's list of ordered extents).
   411		 * Therefore wait for any task currently allocating extents, since the
   412		 * block group's reservations counter is incremented while a read lock
   413		 * on the groups' semaphore is held and decremented after releasing
   414		 * the read access on that semaphore and creating the ordered extent.
   415		 */
 > 416		percpu_down_write(&space_info->groups_sem);
 > 417		percpu_up_write(&space_info->groups_sem);
   418	
   419		wait_var_event(&bg->reservations, !atomic_read(&bg->reservations));
   420	}
   421	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

