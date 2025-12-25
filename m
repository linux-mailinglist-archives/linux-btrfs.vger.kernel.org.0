Return-Path: <linux-btrfs+bounces-19998-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99363CDD594
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 07:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A34223019FF9
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 06:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B8C296BDC;
	Thu, 25 Dec 2025 06:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dlRbJmyH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CAF24E4C4;
	Thu, 25 Dec 2025 06:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766642692; cv=none; b=LEIvtHW6ctrj3n9O+DGHAViH+MIX8JD/f0gcF3SlwHSDwvM7MjhfA5yFXfJ7+i3Qdyv+MCdkRUo43QsEebz9PZSbxKQhEYvLBIGUlhPeC565HWTzVd8pBBZMSNogIOnGKHMBn4Me+nB/Aae8/j+gUQY8Qxrhc8BNRBz0GI3SMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766642692; c=relaxed/simple;
	bh=VcKC9/CBFU8uwKDrnoVC8HUQENdMl7CZvAYW/cKoi9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qq6zFN6azqVGD1/LILnP4GDX8hJ14LDHGYuF3klbrVRJ/Ho/G29nb6y8Kp7n8mjywKgMFqDMnzPlWjeQwn7Etyab/RXhSWIWRRIo1peczTNuTzO/uyCrCAowalPF/Io7Of2OoZFjaDEzAuha4vv20QuQ9bsrtENM5uv/MUNQeR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dlRbJmyH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766642691; x=1798178691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VcKC9/CBFU8uwKDrnoVC8HUQENdMl7CZvAYW/cKoi9o=;
  b=dlRbJmyH2W8ncRgJ80QS9ehukvPhZVNlYNCujHJiRp2/LLEXrvFUqQvi
   lY7yp+g7J0Z8njnixwdIwNxTfw6NdNa/Qvp2mTXsziIh/Yxck2Bcrk2zk
   OBbzleGr7OF1C+6X0DqfDAAiEI7f2YZrq6WdgCNh10eAitXYBvlJjDePK
   24UQwpBwLyruIXRCJ3Jek82w0ayHxvX8csk0v20o7eLMc5L4+vITzTO+n
   71kl2qf25LI0olUdTSnOlv7YMT2Gdg44aYlMWQ7fGvn1QIgGqFzluxiz8
   C61f6+qIQJcM3pwgxB8tLiU94jiBFr14jjAX2sdBelgwb6WhqPyYVvLqD
   Q==;
X-CSE-ConnectionGUID: /dPN4JKsSXqVzMQUmv1LNw==
X-CSE-MsgGUID: A805pBMgTYiq51W0D3AiiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="68613581"
X-IronPort-AV: E=Sophos;i="6.21,175,1763452800"; 
   d="scan'208";a="68613581"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2025 22:04:50 -0800
X-CSE-ConnectionGUID: YjemtR3sRSKp5bj/xnm3fA==
X-CSE-MsgGUID: wALkkXzzQruU2rIXRw2m+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,175,1763452800"; 
   d="scan'208";a="199305559"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 24 Dec 2025 22:04:45 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYeSo-000000003nv-31Ir;
	Thu, 25 Dec 2025 06:04:42 +0000
Date: Thu, 25 Dec 2025 14:04:28 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Mailhol <mailhol@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Chris Mason <chris.mason@fusionio.com>,
	David Sterba <dsterba@suse.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kbuild@vger.kernel.org,
	linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-btrfs@vger.kernel.org, linux-hardening@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH v3 3/3] overflow: Remove is_non_negative() and
 is_negative()
Message-ID: <202512251340.UApIFw9R-lkp@intel.com>
References: <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>

Hi Vincent,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3e7f562e20ee87a25e104ef4fce557d39d62fa85]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Mailhol/kbuild-remove-gcc-s-Wtype-limits/20251220-190509
base:   3e7f562e20ee87a25e104ef4fce557d39d62fa85
patch link:    https://lore.kernel.org/r/20251220-remove_wtype-limits-v3-3-24b170af700e%40kernel.org
patch subject: [PATCH v3 3/3] overflow: Remove is_non_negative() and is_negative()
config: i386-randconfig-141-20251225 (https://download.01.org/0day-ci/archive/20251225/202512251340.UApIFw9R-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512251340.UApIFw9R-lkp@intel.com/

smatch warnings:
drivers/md/dm-stripe.c:463 stripe_io_hints() warn: unsigned '*_d' is never less than zero.
drivers/md/dm-stripe.c:463 stripe_io_hints() warn: unsigned '_a' is never less than zero.

vim +463 drivers/md/dm-stripe.c

af4874e03ed82f Mike Snitzer    2009-06-22  454  
40bea431274c24 Mike Snitzer    2009-09-04  455  static void stripe_io_hints(struct dm_target *ti,
40bea431274c24 Mike Snitzer    2009-09-04  456  			    struct queue_limits *limits)
40bea431274c24 Mike Snitzer    2009-09-04  457  {
40bea431274c24 Mike Snitzer    2009-09-04  458  	struct stripe_c *sc = ti->private;
1071d560afb4c2 Mikulas Patocka 2025-08-11  459  	unsigned int io_min, io_opt;
40bea431274c24 Mike Snitzer    2009-09-04  460  
5fb9d4341b782a John Garry      2025-07-11  461  	limits->chunk_sectors = sc->chunk_size;
1071d560afb4c2 Mikulas Patocka 2025-08-11  462  
1071d560afb4c2 Mikulas Patocka 2025-08-11 @463  	if (!check_shl_overflow(sc->chunk_size, SECTOR_SHIFT, &io_min) &&
1071d560afb4c2 Mikulas Patocka 2025-08-11  464  	    !check_mul_overflow(io_min, sc->stripes, &io_opt)) {
1071d560afb4c2 Mikulas Patocka 2025-08-11  465  		limits->io_min = io_min;
1071d560afb4c2 Mikulas Patocka 2025-08-11  466  		limits->io_opt = io_opt;
1071d560afb4c2 Mikulas Patocka 2025-08-11  467  	}
40bea431274c24 Mike Snitzer    2009-09-04  468  }
40bea431274c24 Mike Snitzer    2009-09-04  469  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

