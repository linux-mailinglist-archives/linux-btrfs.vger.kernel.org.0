Return-Path: <linux-btrfs+bounces-9304-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D38649B9D6E
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Nov 2024 07:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1361C21972
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Nov 2024 06:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9563815383A;
	Sat,  2 Nov 2024 06:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Va86dPUz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91C9140E50;
	Sat,  2 Nov 2024 06:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730528844; cv=none; b=sC6hRyhQztbAAhPX+bpPhKIRkDbGq/v/NJV8S1NC9O03Vi6B1EGv3HUbM4FvgpsZhwzbSQNv+FmvIO3zyoS5l51p3m4uIflOqPtv3yDP6qhl7j2EBDosYA9+AcPofvyTOg/xpcCodJNRBvlzFJuPVEKW7e23vLCqm1N628OR5Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730528844; c=relaxed/simple;
	bh=NeKGlkLbLdft0XKhphzd5Trc200cEmEajoHwAu/+cS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ck8SPUWkQOCzzUyrefNIC55oTX609HbgPPl8BLjIVl8meDBIxH+7CcyCkKUBxQGhJ/J80Gchbf5S+Pn7NpskzptggPVnC1wnfn60mEnZxiEfZcvKYZ8qeaM//bSIIR5nyJ2j7zb5y06qeLLjhd/0kj9aAxLiTSQSoi3cZkPCKEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Va86dPUz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730528841; x=1762064841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NeKGlkLbLdft0XKhphzd5Trc200cEmEajoHwAu/+cS4=;
  b=Va86dPUzxtajwPIRxRCzJR7GpafV490L4JYyPJSB5tTBboboks9ME9IE
   L8eYJ0FZZhD6LLOBHed47FOSrOqHkOBzm+xGGaICRib+EM9n+e0YjEtpZ
   ppMSbbqvMG0zVXEHquM7xg4jSwgGOKaKdaPL/26OGxhXX1owcrltR2Owr
   sSwr1mvsyu2xxvZklC4SCPzf3/T971TwWktKouF/zHRjFWpRWWIxNVV50
   SXYrZvU6EQZ+yost7pITH5tNxn6are+KjEFnh5h4nuAT7Z5fDi6wgFYJD
   9egNtv+/7+ItzU5vGOilwYXx0I+ZPOXckeIXwcayA7ujTZC8hW2Mzps11
   w==;
X-CSE-ConnectionGUID: qxey9CIORA6QdTZOgBIszA==
X-CSE-MsgGUID: zcbj37FHQNO4FA1Wnv3png==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="33133753"
X-IronPort-AV: E=Sophos;i="6.11,252,1725346800"; 
   d="scan'208";a="33133753"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 23:27:21 -0700
X-CSE-ConnectionGUID: 5Qxaxqq8SXKXqYUf1kjzng==
X-CSE-MsgGUID: TzSIkDaASdGAmQ8FRETa+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,252,1725346800"; 
   d="scan'208";a="87979674"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 01 Nov 2024 23:27:19 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t77bQ-000iVJ-1I;
	Sat, 02 Nov 2024 06:27:16 +0000
Date: Sat, 2 Nov 2024 14:26:48 +0800
From: kernel test robot <lkp@intel.com>
To: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, clm@fb.com,
	josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, baijiaju1990@gmail.com,
	zhenghaoran@buaa.edu.cn, 21371365@buaa.edu.cn
Subject: Re: [PATCH] btrfs: Fix data race in log_conflicting_inodes
Message-ID: <202411021443.lsHICRJl-lkp@intel.com>
References: <20241101035133.925251-1-zhenghaoran@buaa.edu.cn>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101035133.925251-1-zhenghaoran@buaa.edu.cn>

Hi Hao-ran,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.12-rc5 next-20241101]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hao-ran-Zheng/btrfs-Fix-data-race-in-log_conflicting_inodes/20241101-115429
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20241101035133.925251-1-zhenghaoran%40buaa.edu.cn
patch subject: [PATCH] btrfs: Fix data race in log_conflicting_inodes
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241102/202411021443.lsHICRJl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411021443.lsHICRJl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411021443.lsHICRJl-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/sched.h:2145,
                    from fs/btrfs/tree-log.c:6:
   fs/btrfs/tree-log.c: In function 'log_conflicting_inodes':
>> fs/btrfs/tree-log.c:5790:33: error: 'struct btrfs_log_ctx' has no member named 'conflict_inodes_lock'; did you mean 'conflict_inodes'?
    5790 |         spin_lock_irqsave(&ctx->conflict_inodes_lock, logging_conflict_inodes_flags);
         |                                 ^~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock.h:244:48: note: in definition of macro 'raw_spin_lock_irqsave'
     244 |                 flags = _raw_spin_lock_irqsave(lock);   \
         |                                                ^~~~
   fs/btrfs/tree-log.c:5790:9: note: in expansion of macro 'spin_lock_irqsave'
    5790 |         spin_lock_irqsave(&ctx->conflict_inodes_lock, logging_conflict_inodes_flags);
         |         ^~~~~~~~~~~~~~~~~
   fs/btrfs/tree-log.c:5792:46: error: 'struct btrfs_log_ctx' has no member named 'conflict_inodes_lock'; did you mean 'conflict_inodes'?
    5792 |                 spin_unlock_irqrestore(&ctx->conflict_inodes_lock, logging_conflict_inodes_flags);
         |                                              ^~~~~~~~~~~~~~~~~~~~
         |                                              conflict_inodes
>> fs/btrfs/tree-log.c:5791:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    5791 |         if (ctx->logging_conflict_inodes)
         |         ^~
   fs/btrfs/tree-log.c:5793:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    5793 |                 return 0;
         |                 ^~~~~~
   fs/btrfs/tree-log.c:5796:38: error: 'struct btrfs_log_ctx' has no member named 'conflict_inodes_lock'; did you mean 'conflict_inodes'?
    5796 |         spin_unlock_irqrestore(&ctx->conflict_inodes_lock, logging_conflict_inodes_flags);
         |                                      ^~~~~~~~~~~~~~~~~~~~
         |                                      conflict_inodes
   fs/btrfs/tree-log.c:5877:33: error: 'struct btrfs_log_ctx' has no member named 'conflict_inodes_lock'; did you mean 'conflict_inodes'?
    5877 |         spin_lock_irqsave(&ctx->conflict_inodes_lock, logging_conflict_inodes_flags);
         |                                 ^~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock.h:244:48: note: in definition of macro 'raw_spin_lock_irqsave'
     244 |                 flags = _raw_spin_lock_irqsave(lock);   \
         |                                                ^~~~
   fs/btrfs/tree-log.c:5877:9: note: in expansion of macro 'spin_lock_irqsave'
    5877 |         spin_lock_irqsave(&ctx->conflict_inodes_lock, logging_conflict_inodes_flags);
         |         ^~~~~~~~~~~~~~~~~
   fs/btrfs/tree-log.c:5879:38: error: 'struct btrfs_log_ctx' has no member named 'conflict_inodes_lock'; did you mean 'conflict_inodes'?
    5879 |         spin_unlock_irqrestore(&ctx->conflict_inodes_lock, logging_conflict_inodes_flags);
         |                                      ^~~~~~~~~~~~~~~~~~~~
         |                                      conflict_inodes


vim +5790 fs/btrfs/tree-log.c

  5777	
  5778	static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
  5779					  struct btrfs_root *root,
  5780					  struct btrfs_log_ctx *ctx)
  5781	{
  5782		int ret = 0;
  5783		unsigned long logging_conflict_inodes_flags;
  5784	
  5785		/*
  5786		 * Conflicting inodes are logged by the first call to btrfs_log_inode(),
  5787		 * otherwise we could have unbounded recursion of btrfs_log_inode()
  5788		 * calls. This check guarantees we can have only 1 level of recursion.
  5789		 */
> 5790		spin_lock_irqsave(&ctx->conflict_inodes_lock, logging_conflict_inodes_flags);
> 5791		if (ctx->logging_conflict_inodes)
  5792			spin_unlock_irqrestore(&ctx->conflict_inodes_lock, logging_conflict_inodes_flags);
  5793			return 0;
  5794	
  5795		ctx->logging_conflict_inodes = true;
  5796		spin_unlock_irqrestore(&ctx->conflict_inodes_lock, logging_conflict_inodes_flags);
  5797	
  5798		/*
  5799		 * New conflicting inodes may be found and added to the list while we
  5800		 * are logging a conflicting inode, so keep iterating while the list is
  5801		 * not empty.
  5802		 */
  5803		while (!list_empty(&ctx->conflict_inodes)) {
  5804			struct btrfs_ino_list *curr;
  5805			struct inode *inode;
  5806			u64 ino;
  5807			u64 parent;
  5808	
  5809			curr = list_first_entry(&ctx->conflict_inodes,
  5810						struct btrfs_ino_list, list);
  5811			ino = curr->ino;
  5812			parent = curr->parent;
  5813			list_del(&curr->list);
  5814			kfree(curr);
  5815	
  5816			inode = btrfs_iget_logging(ino, root);
  5817			/*
  5818			 * If the other inode that had a conflicting dir entry was
  5819			 * deleted in the current transaction, we need to log its parent
  5820			 * directory. See the comment at add_conflicting_inode().
  5821			 */
  5822			if (IS_ERR(inode)) {
  5823				ret = PTR_ERR(inode);
  5824				if (ret != -ENOENT)
  5825					break;
  5826	
  5827				inode = btrfs_iget_logging(parent, root);
  5828				if (IS_ERR(inode)) {
  5829					ret = PTR_ERR(inode);
  5830					break;
  5831				}
  5832	
  5833				/*
  5834				 * Always log the directory, we cannot make this
  5835				 * conditional on need_log_inode() because the directory
  5836				 * might have been logged in LOG_INODE_EXISTS mode or
  5837				 * the dir index of the conflicting inode is not in a
  5838				 * dir index key range logged for the directory. So we
  5839				 * must make sure the deletion is recorded.
  5840				 */
  5841				ret = btrfs_log_inode(trans, BTRFS_I(inode),
  5842						      LOG_INODE_ALL, ctx);
  5843				btrfs_add_delayed_iput(BTRFS_I(inode));
  5844				if (ret)
  5845					break;
  5846				continue;
  5847			}
  5848	
  5849			/*
  5850			 * Here we can use need_log_inode() because we only need to log
  5851			 * the inode in LOG_INODE_EXISTS mode and rename operations
  5852			 * update the log, so that the log ends up with the new name and
  5853			 * without the old name.
  5854			 *
  5855			 * We did this check at add_conflicting_inode(), but here we do
  5856			 * it again because if some other task logged the inode after
  5857			 * that, we can avoid doing it again.
  5858			 */
  5859			if (!need_log_inode(trans, BTRFS_I(inode))) {
  5860				btrfs_add_delayed_iput(BTRFS_I(inode));
  5861				continue;
  5862			}
  5863	
  5864			/*
  5865			 * We are safe logging the other inode without acquiring its
  5866			 * lock as long as we log with the LOG_INODE_EXISTS mode. We
  5867			 * are safe against concurrent renames of the other inode as
  5868			 * well because during a rename we pin the log and update the
  5869			 * log with the new name before we unpin it.
  5870			 */
  5871			ret = btrfs_log_inode(trans, BTRFS_I(inode), LOG_INODE_EXISTS, ctx);
  5872			btrfs_add_delayed_iput(BTRFS_I(inode));
  5873			if (ret)
  5874				break;
  5875		}
  5876	
  5877		spin_lock_irqsave(&ctx->conflict_inodes_lock, logging_conflict_inodes_flags);
  5878		ctx->logging_conflict_inodes = false;
  5879		spin_unlock_irqrestore(&ctx->conflict_inodes_lock, logging_conflict_inodes_flags);
  5880		if (ret)
  5881			free_conflicting_inodes(ctx);
  5882	
  5883		return ret;
  5884	}
  5885	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

