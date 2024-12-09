Return-Path: <linux-btrfs+bounces-10162-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDEB9E946C
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 13:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43651887B03
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42594228CA2;
	Mon,  9 Dec 2024 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+h7eZwJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BDA228C83
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747853; cv=none; b=LrRmG8s699nN7Q2dNs2aiyzuS/JlIDerUITAOEEQTSig+/rcORBJix+kAhzLYJGw2Dg7Cwoh5xMNbXdnsjubUDfFsXFL7o7y0TEZB+Ee1c6mHjTtnrA5+RhevNq3v3+8EIBeCdMh7AaVcUK3ATPn0LMG116ufafP4NPWKlO3wD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747853; c=relaxed/simple;
	bh=BqxO5EXIqsAcnDQE81MAzZXKdCnlZS1jBEPAa5BMhcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqwofblgLsIlygLyJs5DufP9MeXqqRmJVSLjB+DuXKGf+x5XS3WoJB23q//M49C3Gq2S1OiYL1gti3Q8f237Aytt/LRaDmHyaITA820iEygjhdzxet6yHGwSaNWnDqNm7o/Lsqz5Ydnf0U/LppIAbjtdIeCm4neDukRn4fX6MCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+h7eZwJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733747850; x=1765283850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BqxO5EXIqsAcnDQE81MAzZXKdCnlZS1jBEPAa5BMhcg=;
  b=i+h7eZwJOBFHYnPjZV8UopeFL2j3CKF/s5DGNFLBAuqHCYAx9GIjXrOC
   ID3cKnCp9o3gqrznQAWbLbp7l5hGtbZ14PRV9yZpfLQGyVocvOZ05vV26
   d1Lg1RFl9MiQvcbxI7pPmEexKJ7e/VcZocrR6N5gCwVw2FVLbIUTpnAy3
   Nm4TQD2XUAKRES8hohg/qA6A0xT8rUBtIJc2WxzqaHWjfosKk5Mz+5QhG
   oiCKuHfsJe1U6a8hBysOAkZfHtX8S3HH2Vfu7sUt1CnUuXfTQ5+WHzkXE
   Dtp3YQ1W46MxcghjpYL3uMoEdUQoV1Unwywdwo7N9PFijEdcz5dWhby83
   A==;
X-CSE-ConnectionGUID: +zQoAwReSUqL7ZR4qu/ODA==
X-CSE-MsgGUID: Ew1BxsZTSvi84tB643onVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33954466"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="33954466"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 04:37:29 -0800
X-CSE-ConnectionGUID: hatdD59FRRyHNVM6Fk0H8Q==
X-CSE-MsgGUID: zF/PBI+gQNyW9wa0M45Ixw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="95260216"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 Dec 2024 04:37:29 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKd0w-0004Jx-1x;
	Mon, 09 Dec 2024 12:37:26 +0000
Date: Mon, 9 Dec 2024 20:36:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	"Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: Re: [PATCH] btrfs: edits tree_insert() to use rb helpers
Message-ID: <202412092033.josUXvY4-lkp@intel.com>
References: <5e023dcf8f086296da987f8ba2b43be0aca15b86.1733695544.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e023dcf8f086296da987f8ba2b43be0aca15b86.1733695544.git.beckerlee3@gmail.com>

Hi Roger,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.13-rc2 next-20241209]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roger-L-Beckermeyer-III/btrfs-edits-tree_insert-to-use-rb-helpers/20241209-104108
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/5e023dcf8f086296da987f8ba2b43be0aca15b86.1733695544.git.beckerlee3%40gmail.com
patch subject: [PATCH] btrfs: edits tree_insert() to use rb helpers
config: x86_64-buildonly-randconfig-001-20241209 (https://download.01.org/0day-ci/archive/20241209/202412092033.josUXvY4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241209/202412092033.josUXvY4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412092033.josUXvY4-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/btrfs/delayed-ref.c: In function 'tree_insert':
>> fs/btrfs/delayed-ref.c:342:17: error: implicit declaration of function 'rb_find_add_cached'; did you mean 'rb_find_add_rcu'? [-Werror=implicit-function-declaration]
     342 |         exist = rb_find_add_cached(node, root, comp_refs_node);
         |                 ^~~~~~~~~~~~~~~~~~
         |                 rb_find_add_rcu
   fs/btrfs/delayed-ref.c:342:15: warning: assignment to 'struct rb_node *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     342 |         exist = rb_find_add_cached(node, root, comp_refs_node);
         |               ^
   cc1: some warnings being treated as errors


vim +342 fs/btrfs/delayed-ref.c

   334	
   335	static struct btrfs_delayed_ref_node* tree_insert(struct rb_root_cached *root,
   336			struct btrfs_delayed_ref_node *ins)
   337	{
   338		struct rb_node *node = &ins->ref_node;
   339		struct rb_node *exist;
   340		struct btrfs_delayed_ref_node *entry;
   341	
 > 342		exist = rb_find_add_cached(node, root, comp_refs_node);
   343		if (exist != NULL) {
   344			entry = rb_entry(exist, struct btrfs_delayed_ref_node, ref_node);
   345			return entry;
   346		}
   347		return NULL;
   348	}
   349	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

