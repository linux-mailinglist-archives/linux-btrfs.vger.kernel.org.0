Return-Path: <linux-btrfs+bounces-1318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2AF827D2B
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 04:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48CA286320
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 03:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AFF2F44;
	Tue,  9 Jan 2024 03:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XK/IKlDT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB19259D
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Jan 2024 03:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704769420; x=1736305420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VbA1am66UFeOg3LRU9B9AMQb7xwkuclnXTgN8tlRIdM=;
  b=XK/IKlDTkbxv32jq2gt4ra0rqt1k0Wl3SLEhFxQUqCnq9vPHlRvqAFT/
   ozt+HLGg/pToDPqvVlfC3iZKlQDjno7w6beVWZaoQQwdCBKnGWRgmMS89
   ZfCYAmAIun86NgsAl/6P1/Q4UQPs2+G5ynjL5NJVgSpbg8qJZ2e54KlYy
   QaPpWaqRJHm0jatPRsMfW2Dp+1poUimMcOjyvNPCTuuOTJKP1o/8LIN/G
   n3Ny9HP8O1W1vyjmVuXyW5X5eGXrzjr2x0St1dcUz9NExNGaPhbEU9evb
   qVvxknSlQNYY1LdPVywGP8Q1mon2YlpdTPsEtMe8XGZF8fHNbO2aPLjdh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5434473"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="5434473"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 19:03:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="781628888"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="781628888"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 08 Jan 2024 19:03:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rN2Ol-0005OY-0j;
	Tue, 09 Jan 2024 03:03:27 +0000
Date: Tue, 9 Jan 2024 11:02:54 +0800
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/3] btrfs: zlib: fix and simplify the inline extent
 decompression
Message-ID: <202401091012.pLm6PcKG-lkp@intel.com>
References: <29b7793e53e1cdd559ad212ee69cec211a3b4db2.1704704328.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29b7793e53e1cdd559ad212ee69cec211a3b4db2.1704704328.git.wqu@suse.com>

Hi Qu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on next-20240108]
[cannot apply to linus/master v6.7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-zlib-fix-and-simplify-the-inline-extent-decompression/20240108-171206
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/29b7793e53e1cdd559ad212ee69cec211a3b4db2.1704704328.git.wqu%40suse.com
patch subject: [PATCH 1/3] btrfs: zlib: fix and simplify the inline extent decompression
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240109/202401091012.pLm6PcKG-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401091012.pLm6PcKG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401091012.pLm6PcKG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/btrfs/zlib.c:402:15: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
     401 |                 pr_warn_ratelimited("BTRFS: infalte failed, decompressed=%lu expected=%lu\n",
         |                                                                                       ~~~
         |                                                                                       %zu
     402 |                                         to_copy, destlen);
         |                                                  ^~~~~~~
   include/linux/printk.h:665:49: note: expanded from macro 'pr_warn_ratelimited'
     665 |         printk_ratelimited(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                                                ~~~     ^~~~~~~~~~~
   include/linux/printk.h:649:17: note: expanded from macro 'printk_ratelimited'
     649 |                 printk(fmt, ##__VA_ARGS__);                             \
         |                        ~~~    ^~~~~~~~~~~
   include/linux/printk.h:455:60: note: expanded from macro 'printk'
     455 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:427:19: note: expanded from macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +402 fs/btrfs/zlib.c

   355	
   356	int zlib_decompress(struct list_head *ws, const u8 *data_in,
   357			struct page *dest_page, unsigned long dest_pgoff, size_t srclen,
   358			size_t destlen)
   359	{
   360		struct workspace *workspace = list_entry(ws, struct workspace, list);
   361		int ret = 0;
   362		int wbits = MAX_WBITS;
   363		unsigned long to_copy;
   364	
   365		workspace->strm.next_in = data_in;
   366		workspace->strm.avail_in = srclen;
   367		workspace->strm.total_in = 0;
   368	
   369		workspace->strm.next_out = workspace->buf;
   370		workspace->strm.avail_out = workspace->buf_size;
   371		workspace->strm.total_out = 0;
   372		/* If it's deflate, and it's got no preset dictionary, then
   373		   we can tell zlib to skip the adler32 check. */
   374		if (srclen > 2 && !(data_in[1] & PRESET_DICT) &&
   375		    ((data_in[0] & 0x0f) == Z_DEFLATED) &&
   376		    !(((data_in[0]<<8) + data_in[1]) % 31)) {
   377	
   378			wbits = -((data_in[0] >> 4) + 8);
   379			workspace->strm.next_in += 2;
   380			workspace->strm.avail_in -= 2;
   381		}
   382	
   383		if (Z_OK != zlib_inflateInit2(&workspace->strm, wbits)) {
   384			pr_warn("BTRFS: inflateInit failed\n");
   385			return -EIO;
   386		}
   387	
   388		/*
   389		 * Everything (in/out buf) should be at most one sector, there should
   390		 * be no need to switch any input/output buffer.
   391		 */
   392		ret = zlib_inflate(&workspace->strm, Z_FINISH);
   393		to_copy = min(workspace->strm.total_out, destlen);
   394		if (ret != Z_STREAM_END)
   395			goto out;
   396	
   397		memcpy_to_page(dest_page, dest_pgoff, workspace->buf, to_copy);
   398	
   399	out:
   400		if (unlikely(to_copy != destlen)) {
   401			pr_warn_ratelimited("BTRFS: infalte failed, decompressed=%lu expected=%lu\n",
 > 402						to_copy, destlen);
   403			ret = -EIO;
   404		} else {
   405			ret = 0;
   406		}
   407	
   408		zlib_inflateEnd(&workspace->strm);
   409	
   410		if (unlikely(to_copy < destlen))
   411			memzero_page(dest_page, dest_pgoff + to_copy, destlen - to_copy);
   412		return ret;
   413	}
   414	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

