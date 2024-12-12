Return-Path: <linux-btrfs+bounces-10274-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DA49EDD00
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 02:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA122836CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 01:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B4A558BB;
	Thu, 12 Dec 2024 01:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqOfWzo4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7904225A8
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 01:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733966360; cv=none; b=nDZ8MGsm8gmuw354oa3k0RetGM7T3jGVhp2mxIDBtUiM/pTTE9MkpUeK7auffUcXxm0bCZ1WEsCXg5KEoWn3ijbwX4z5zEv7lOnXsNiNRDhMZTFbt/bdOObgilczfnM3hNjnaMowWVr/qgKeSJqzSvET8ol0zbwtyXni+p7B098=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733966360; c=relaxed/simple;
	bh=SUvPk8jDBgmSsgdUZODT3DlXcip3GbyUYCxyAPF398w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=on7cz1Tk8wflv/+MT33xNc5NDoCPz0MTZWth8DMwwC1CUUmiypaggscFEJDn55AoQ/d9+iWDzDWDEAqenW3i6OqcIEpH0aDsM1p27KqHGL0CbfnvQc97oaTW7K4tAydSSzgfV/w0MyCcVnTWXBqkqPve2vVx1VzsMJ7Mx1wz+S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqOfWzo4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733966358; x=1765502358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SUvPk8jDBgmSsgdUZODT3DlXcip3GbyUYCxyAPF398w=;
  b=nqOfWzo4YDK4CfYymTwByH4qclcEYPZxpbPKuH64D4LbuvAZdoyCOKee
   fQg29eojzldcGbjRHy8yx9FetsVD3L7tP7qxyq/Peog08VwC3P56L0AY0
   HNrTabhbMVJjbxXxF5apFiI5LSXqQUoHaDqNlWHmpBz4mIdUE/9sgiGE1
   gzQC1Brw3dbO9wWw/YISIjIzuzHmFcbpvFAUOQAPMPINPD9DjmFDHgCRY
   3KMOXTzDqk6HIkpjrmJiyMp+KvLRR+MN4vv+5NrxqyqaafUQTSG/sRJ5p
   FhperSeYHl6rpjycfek+w6AdxiYV8tanDSFoYx+XW6HTDvx9erNf8tmzM
   g==;
X-CSE-ConnectionGUID: 7zPBgL8UQMeVYpvxkNdGiQ==
X-CSE-MsgGUID: b3RG8neISkSpJjgejbA+TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="33699088"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="33699088"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 17:19:17 -0800
X-CSE-ConnectionGUID: cy5apSg4RZiXMmeSfpBTHQ==
X-CSE-MsgGUID: 9gWnfv01R7KwxltFpsjBkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="96451175"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Dec 2024 17:19:15 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLXrF-0007Hh-2U;
	Thu, 12 Dec 2024 01:19:13 +0000
Date: Thu, 12 Dec 2024 09:18:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	linux-btrfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: Re: [PATCH] btrfs: edit __btrfs_add_delayed_item() to use rb helper
Message-ID: <202412120959.0utuK69J-lkp@intel.com>
References: <9b85bdbc269d20886590f0a70de66c602d72aa9d.1733695544.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b85bdbc269d20886590f0a70de66c602d72aa9d.1733695544.git.beckerlee3@gmail.com>

Hi Roger,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.13-rc2 next-20241211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roger-L-Beckermeyer-III/btrfs-edit-__btrfs_add_delayed_item-to-use-rb-helper/20241209-104443
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/9b85bdbc269d20886590f0a70de66c602d72aa9d.1733695544.git.beckerlee3%40gmail.com
patch subject: [PATCH] btrfs: edit __btrfs_add_delayed_item() to use rb helper
config: s390-defconfig (https://download.01.org/0day-ci/archive/20241212/202412120959.0utuK69J-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412120959.0utuK69J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412120959.0utuK69J-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/btrfs/delayed-inode.c:392:10: error: call to undeclared function 'rb_find_add_cached'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           exist = rb_find_add_cached(&ins->rb_node, root, btrfs_add_delayed_item_cmp);
                   ^
   fs/btrfs/delayed-inode.c:392:8: error: incompatible integer to pointer conversion assigning to 'struct rb_node *' from 'int' [-Wint-conversion]
           exist = rb_find_add_cached(&ins->rb_node, root, btrfs_add_delayed_item_cmp);
                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/rb_find_add_cached +392 fs/btrfs/delayed-inode.c

   380	
   381	static int __btrfs_add_delayed_item(struct btrfs_delayed_node *delayed_node,
   382					    struct btrfs_delayed_item *ins)
   383	{
   384		struct rb_root_cached *root;
   385		struct rb_node *exist;
   386	
   387		if (ins->type == BTRFS_DELAYED_INSERTION_ITEM)
   388			root = &delayed_node->ins_root;
   389		else
   390			root = &delayed_node->del_root;
   391	
 > 392		exist = rb_find_add_cached(&ins->rb_node, root, btrfs_add_delayed_item_cmp);
   393		if (exist != NULL)
   394			return -EEXIST;
   395	
   396		if (ins->type == BTRFS_DELAYED_INSERTION_ITEM &&
   397		    ins->index >= delayed_node->index_cnt)
   398			delayed_node->index_cnt = ins->index + 1;
   399	
   400		delayed_node->count++;
   401		atomic_inc(&delayed_node->root->fs_info->delayed_root->items);
   402		return 0;
   403	}
   404	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

