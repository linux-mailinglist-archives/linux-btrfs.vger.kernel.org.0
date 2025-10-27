Return-Path: <linux-btrfs+bounces-18369-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59C2C0F386
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 17:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5B3564D20
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 16:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A2130EF84;
	Mon, 27 Oct 2025 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYsJVQPb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A8B30CD91
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581095; cv=none; b=gWXgOzDjA4TFss531gGul5iOUtoAl7S/8HKSGDoidBA23Rbtbrbs4D80OSEMsD9Bj680hxDCfiiQiKLhc+XVl5/M4oD3zFtR6+/pRaKOZXYKhUuQaZ1dCTs59BX0FKrOEKaViSayWagX4lfQ3I/ja63tO2r0ukBYOUXq0JGymjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581095; c=relaxed/simple;
	bh=dm8A/qyQjDO//xtPEdtwtlpgXj5bAJ7D8ySG6nd2G0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4h4LHAy1JJg6zci84+/TQORlazc6fCcRIJ7FNwDR4RtLy25YvAdP1eZ2mN9MjxcWTUBcwRZdwjLMGb3ttvfnjrI8x9z9lbLiYfxt9sDWpebxHj+Vb5uun69ek0i7lIzz9rmEZTFvucIhydX1BRctTO/SIHeI1hzfIrksXAy1z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYsJVQPb; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761581094; x=1793117094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dm8A/qyQjDO//xtPEdtwtlpgXj5bAJ7D8ySG6nd2G0I=;
  b=jYsJVQPbfEkXHb/kLoDRYm4a89rX7gFCOAz7xyHoTcSOneoKqil1to/5
   PKv3lnlUss9gYER1ycGsm/AuEDFv+GzsWQ9eaVqLhrBPXuag2Vj31iyYC
   hJkE/3kjqux0VXUHBENlN6ZfO4/OCjvj1p1kh2xqZY3QDDMMQX8bDNy6r
   lGLZgdlOLZNs0/j1qFKxPTJTv53WGGxilbpWux3hcsS+kv/hRpPCf+9wH
   hkXPK5l2JRy59+xuQDvlVfDPNtJzRfxz+8f5Jtsf13vUJtutoSB6bw1nc
   3wr5GoB45Coir8f6nuY8gFHw7qaRaU0JILGzdRYsjx1a7fIkOvhGmqh1t
   Q==;
X-CSE-ConnectionGUID: Ss+OeQd+R4Cnzq/iIAV74A==
X-CSE-MsgGUID: hMdkyw+WQHyR+ctb4A5NFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62697175"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="62697175"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 09:04:53 -0700
X-CSE-ConnectionGUID: vdFxKknXQUKzmMAZJre6zw==
X-CSE-MsgGUID: it2GcJ4aQxSGK6TGRKUPKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="184980229"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 27 Oct 2025 09:04:51 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDPiD-000GxR-1n;
	Mon, 27 Oct 2025 16:04:49 +0000
Date: Tue, 28 Oct 2025 00:04:11 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Harmstone <mark@harmstone.com>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Mark Harmstone <mark@harmstone.com>
Subject: Re: [PATCH v4 15/16] btrfs: handle discarding fully-remapped block
 groups
Message-ID: <202510272322.N1S5rdDc-lkp@intel.com>
References: <20251024181227.32228-16-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024181227.32228-16-mark@harmstone.com>

Hi Mark,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on next-20251027]
[cannot apply to linus/master v6.18-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Harmstone/btrfs-add-definitions-and-constants-for-remap-tree/20251025-021910
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20251024181227.32228-16-mark%40harmstone.com
patch subject: [PATCH v4 15/16] btrfs: handle discarding fully-remapped block groups
config: arm-randconfig-003-20251027 (https://download.01.org/0day-ci/archive/20251027/202510272322.N1S5rdDc-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251027/202510272322.N1S5rdDc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510272322.N1S5rdDc-lkp@intel.com/

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   fs/btrfs/discard.c: In function 'btrfs_discard_workfn':
>> fs/btrfs/discard.c:596:6: warning: 'discard_state' may be used uninitialized in this function [-Wmaybe-uninitialized]
      if (discard_state == BTRFS_DISCARD_BITMAPS ||
         ^


vim +/discard_state +596 fs/btrfs/discard.c

   513	
   514	/*
   515	 * Discard work queue callback
   516	 *
   517	 * @work: work
   518	 *
   519	 * Find the next block_group to start discarding and then discard a single
   520	 * region.  It does this in a two-pass fashion: first extents and second
   521	 * bitmaps.  Completely discarded block groups are sent to the unused_bgs path.
   522	 */
   523	static void btrfs_discard_workfn(struct work_struct *work)
   524	{
   525		struct btrfs_discard_ctl *discard_ctl;
   526		struct btrfs_block_group *block_group;
   527		enum btrfs_discard_state discard_state;
   528		int discard_index = 0;
   529		u64 trimmed = 0;
   530		u64 minlen = 0;
   531		u64 now = ktime_get_ns();
   532	
   533		discard_ctl = container_of(work, struct btrfs_discard_ctl, work.work);
   534	
   535		block_group = peek_discard_list(discard_ctl, &discard_state,
   536						&discard_index, now);
   537		if (!block_group)
   538			return;
   539		if (!btrfs_run_discard_work(discard_ctl)) {
   540			spin_lock(&discard_ctl->lock);
   541			btrfs_put_block_group(block_group);
   542			discard_ctl->block_group = NULL;
   543			spin_unlock(&discard_ctl->lock);
   544			return;
   545		}
   546		if (now < block_group->discard_eligible_time) {
   547			spin_lock(&discard_ctl->lock);
   548			btrfs_put_block_group(block_group);
   549			discard_ctl->block_group = NULL;
   550			spin_unlock(&discard_ctl->lock);
   551			btrfs_discard_schedule_work(discard_ctl, false);
   552			return;
   553		}
   554	
   555		/* Perform discarding */
   556		minlen = discard_minlen[discard_index];
   557	
   558		switch (discard_state) {
   559		case BTRFS_DISCARD_BITMAPS: {
   560			u64 maxlen = 0;
   561	
   562			/*
   563			 * Use the previous levels minimum discard length as the max
   564			 * length filter.  In the case something is added to make a
   565			 * region go beyond the max filter, the entire bitmap is set
   566			 * back to BTRFS_TRIM_STATE_UNTRIMMED.
   567			 */
   568			if (discard_index != BTRFS_DISCARD_INDEX_UNUSED)
   569				maxlen = discard_minlen[discard_index - 1];
   570	
   571			btrfs_trim_block_group_bitmaps(block_group, &trimmed,
   572					       block_group->discard_cursor,
   573					       btrfs_block_group_end(block_group),
   574					       minlen, maxlen, true);
   575			discard_ctl->discard_bitmap_bytes += trimmed;
   576	
   577			break;
   578		}
   579	
   580		case BTRFS_DISCARD_FULLY_REMAPPED:
   581			btrfs_trim_fully_remapped_block_group(block_group);
   582			break;
   583	
   584		default:
   585			btrfs_trim_block_group_extents(block_group, &trimmed,
   586					       block_group->discard_cursor,
   587					       btrfs_block_group_end(block_group),
   588					       minlen, true);
   589			discard_ctl->discard_extent_bytes += trimmed;
   590	
   591			break;
   592		}
   593	
   594		/* Determine next steps for a block_group */
   595		if (block_group->discard_cursor >= btrfs_block_group_end(block_group)) {
 > 596			if (discard_state == BTRFS_DISCARD_BITMAPS ||
   597			    discard_state == BTRFS_DISCARD_FULLY_REMAPPED) {
   598				btrfs_finish_discard_pass(discard_ctl, block_group);
   599			} else {
   600				block_group->discard_cursor = block_group->start;
   601				spin_lock(&discard_ctl->lock);
   602				if (block_group->discard_state !=
   603				    BTRFS_DISCARD_RESET_CURSOR)
   604					block_group->discard_state =
   605								BTRFS_DISCARD_BITMAPS;
   606				spin_unlock(&discard_ctl->lock);
   607			}
   608		}
   609	
   610		now = ktime_get_ns();
   611		spin_lock(&discard_ctl->lock);
   612		discard_ctl->prev_discard = trimmed;
   613		discard_ctl->prev_discard_time = now;
   614		btrfs_put_block_group(block_group);
   615		discard_ctl->block_group = NULL;
   616		__btrfs_discard_schedule_work(discard_ctl, now, false);
   617		spin_unlock(&discard_ctl->lock);
   618	}
   619	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

