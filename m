Return-Path: <linux-btrfs+bounces-7880-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C8796FC8A
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 22:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604471C228EC
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 20:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFE01D6C7E;
	Fri,  6 Sep 2024 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ep2jbz+X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411BB1B85E2;
	Fri,  6 Sep 2024 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725653457; cv=none; b=KlQbTLuoY3ZCZs6Jtp6eM1/eLhx0V82c+WVMQHfmkQzkx96J+vB8cwe3PE1mvdZjUGFkZRPVOpArrNQMWk7iJObRvR95vdZjTDvOM+ase6rf2L0lgVEgZOu7vv0QXuZvAi+A8XYnbRokhvkGl49dmIfb+WakT9WVfhFecNL7tLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725653457; c=relaxed/simple;
	bh=HX/FymmvhH8ORDM/+HaYIV4+4DjtWbZmC7Mhuyh1dZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfFbQagKvW+yYhu+CaBP3AYV1bpuWq+R/USDotcFqZThtpMB+mZBuM7dOPIGVMQRsVUjVTe7CZJ6lfvDMlIQaIfal+lVjiWvw1yLcmkTkoTAwgrNCxYSec/oNyQXHo46pBABtQ4w6mH1GJIoeqlhe/Npe1ja63DQZebsgXHk2y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ep2jbz+X; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725653455; x=1757189455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HX/FymmvhH8ORDM/+HaYIV4+4DjtWbZmC7Mhuyh1dZ4=;
  b=Ep2jbz+Xa5S3OVeTCFoP9UAVyz4Md2oEaD/kRj3O3ldvikmbRSA/KpOj
   RJ8nunfX0hQmiJ8aCcoxHABWbXcWgv+/c9EvA/NJJZqunTbpylZKBGITP
   nxZ7UTXvjbXLQk7pxA/bD+hX6cl+yEBQUTgQgR5aInKcfEiLwzLjux4Ep
   hrCUYRZxQCrGoiIsETQWGJwxDP/BsIH5tzUFr739KMEXitaeXqmPt4BKk
   hCkfE7lQWMTcVOmo8jBxN7X0oLJByCZMlGg6I/jsJ/VGM2uArH0hRwBp+
   1opYdEhChkBtiWuy2hKsmcTWs+orQCYyAodXDwNEAWnjPKtFV+RZS8f5N
   g==;
X-CSE-ConnectionGUID: cMqGkuC2RUSybdYIoa8vTw==
X-CSE-MsgGUID: AvpTila1Tj2joVqBdsWUAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35020758"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="35020758"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 13:10:55 -0700
X-CSE-ConnectionGUID: ZyAuURL3TnmX0FK32i5Vag==
X-CSE-MsgGUID: ML/EyMHfS6ePDJAKVbwflA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="66041429"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 06 Sep 2024 13:10:52 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smfIA-000Bfv-2e;
	Fri, 06 Sep 2024 20:10:50 +0000
Date: Sat, 7 Sep 2024 04:10:38 +0800
From: kernel test robot <lkp@intel.com>
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Luca Stefani <luca.stefani.ge1@gmail.com>,
	Chris Mason <chris.mason@fusionio.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] btrfs: Split remaining space to discard in chunks
Message-ID: <202409070311.SB9wmgSx-lkp@intel.com>
References: <20240903071625.957275-3-luca.stefani.ge1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903071625.957275-3-luca.stefani.ge1@gmail.com>

Hi Luca,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.11-rc6]
[also build test ERROR on linus/master]
[cannot apply to kdave/for-next next-20240906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luca-Stefani/btrfs-Always-update-fstrim_range-on-failure/20240903-191851
base:   v6.11-rc6
patch link:    https://lore.kernel.org/r/20240903071625.957275-3-luca.stefani.ge1%40gmail.com
patch subject: [PATCH v3 2/3] btrfs: Split remaining space to discard in chunks
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240907/202409070311.SB9wmgSx-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409070311.SB9wmgSx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409070311.SB9wmgSx-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "blk_alloc_discard_bio" [fs/btrfs/btrfs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

