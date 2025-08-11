Return-Path: <linux-btrfs+bounces-15977-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977CCB1FE6B
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 07:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455373B19ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 05:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D41268C73;
	Mon, 11 Aug 2025 05:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTdiqoqX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1892C260587
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 05:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754888433; cv=none; b=eXDAH3zCXYA3e5tN1DPIqatIUHLr56OIcVjIPua1JGG3bQYRIpKhwOmsNbG5pt09LCZoyoYKwXHRoZSuwxsoWvEcFpq944rRkQh2OgXd7FJ78FN8bXPYpXbGSC+u280M2QELVFVLS9i6nnvFyx40hg0XrNvA22hZFe28n2REUc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754888433; c=relaxed/simple;
	bh=vlN27QOltomPx0bZ3cZKAYMwlG9ifr95fO3AWB9WgbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYckjO96+eRR8Bn4ZB4rfMWnd2qu0JEyR75YCJ8e+z7IAt9tfZYwV50LEdvXVRqOxWxsMpTmrbZlpEevsaiymUPifHvuff6h0OGOhohAa0JgFsgZGtMHJl+XRSJ/wkiOH5RPyrrtivm1mSbrbwIpim2ecInONtm9zNU9IeCRYQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTdiqoqX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754888431; x=1786424431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vlN27QOltomPx0bZ3cZKAYMwlG9ifr95fO3AWB9WgbU=;
  b=LTdiqoqXC7QOkr34D413DYJXHkSB9AwuqTSu1Ep69jEnxFqa66BAmGqh
   tZNFNlxTyNLn0PDPaRy3Z/9STnlY3LK7BEoGKq/XVrmN0IQPS+3XHRYSQ
   7JW58qW5d7V6HDIQdktB/WqBi5XIaTxyaHZ+ZIiBhgyLeJ9v8knYjgy35
   36MBM/wUAZG4XSAXbF0UlC8FK8KLU705HhWZYKSzjFyyk5A9xJ4mxs74i
   MU4foZ4h682KATqJS3OKCOXFpbysix12gNKTIbh8nM2r7JnlqOuzSrCFW
   p87IqTAC5wgl8SvtqqKd+LmSNjIhSdX8LH3oiT0mG2wu+yq61tl2S6rIb
   A==;
X-CSE-ConnectionGUID: ejjn70M2Q5SgDki+vLyPBw==
X-CSE-MsgGUID: pn3ntRJ4Tv2W+CVUgDfVNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="56164596"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56164596"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 22:00:30 -0700
X-CSE-ConnectionGUID: yL0dSQOrTnG2tbh3usarPQ==
X-CSE-MsgGUID: +iwQiDieSuiZ2YW28PSYvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="171172143"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 10 Aug 2025 22:00:29 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ulKe2-0005YG-0M;
	Mon, 11 Aug 2025 05:00:26 +0000
Date: Mon, 11 Aug 2025 13:00:23 +0800
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] btrfs: use blocksize to check if compression is making
 things larger
Message-ID: <202508111239.5dVvTsGq-lkp@intel.com>
References: <14db816c702a3567faa0cd5efe2110b6ebfba970.1754871148.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14db816c702a3567faa0cd5efe2110b6ebfba970.1754871148.git.wqu@suse.com>

Hi Qu,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.17-rc1 next-20250808]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-use-blocksize-to-check-if-compression-is-making-things-larger/20250811-081450
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/14db816c702a3567faa0cd5efe2110b6ebfba970.1754871148.git.wqu%40suse.com
patch subject: [PATCH] btrfs: use blocksize to check if compression is making things larger
config: riscv-randconfig-002-20250811 (https://download.01.org/0day-ci/archive/20250811/202508111239.5dVvTsGq-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 3769ce013be2879bf0b329c14a16f5cb766f26ce)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250811/202508111239.5dVvTsGq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508111239.5dVvTsGq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/btrfs/zstd.c:402:24: error: use of undeclared identifier 'inode'
     402 |         const u32 blocksize = inode->root->fs_info->sectorsize;
         |                               ^~~~~
   1 error generated.
--
>> fs/btrfs/zlib.c:150:24: error: use of undeclared identifier 'inode'
     150 |         const u32 blocksize = inode->root->fs_info->sectorsize;
         |                               ^~~~~
   1 error generated.


vim +/inode +402 fs/btrfs/zstd.c

   386	
   387	int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
   388				 u64 start, struct folio **folios, unsigned long *out_folios,
   389				 unsigned long *total_in, unsigned long *total_out)
   390	{
   391		struct workspace *workspace = list_entry(ws, struct workspace, list);
   392		zstd_cstream *stream;
   393		int ret = 0;
   394		int nr_folios = 0;
   395		struct folio *in_folio = NULL;  /* The current folio to read. */
   396		struct folio *out_folio = NULL; /* The current folio to write to. */
   397		unsigned long tot_in = 0;
   398		unsigned long tot_out = 0;
   399		unsigned long len = *total_out;
   400		const unsigned long nr_dest_folios = *out_folios;
   401		const u64 orig_end = start + len;
 > 402		const u32 blocksize = inode->root->fs_info->sectorsize;
   403		unsigned long max_out = nr_dest_folios * PAGE_SIZE;
   404		unsigned int cur_len;
   405	
   406		workspace->params = zstd_get_btrfs_parameters(workspace->req_level, len);
   407		*out_folios = 0;
   408		*total_out = 0;
   409		*total_in = 0;
   410	
   411		/* Initialize the stream */
   412		stream = zstd_init_cstream(&workspace->params, len, workspace->mem,
   413				workspace->size);
   414		if (unlikely(!stream)) {
   415			struct btrfs_inode *inode = BTRFS_I(mapping->host);
   416	
   417			btrfs_err(inode->root->fs_info,
   418		"zstd compression init level %d failed, root %llu inode %llu offset %llu",
   419				  workspace->req_level, btrfs_root_id(inode->root),
   420				  btrfs_ino(inode), start);
   421			ret = -EIO;
   422			goto out;
   423		}
   424	
   425		/* map in the first page of input data */
   426		ret = btrfs_compress_filemap_get_folio(mapping, start, &in_folio);
   427		if (ret < 0)
   428			goto out;
   429		cur_len = btrfs_calc_input_length(in_folio, orig_end, start);
   430		workspace->in_buf.src = kmap_local_folio(in_folio, offset_in_folio(in_folio, start));
   431		workspace->in_buf.pos = 0;
   432		workspace->in_buf.size = cur_len;
   433	
   434		/* Allocate and map in the output buffer */
   435		out_folio = btrfs_alloc_compr_folio();
   436		if (out_folio == NULL) {
   437			ret = -ENOMEM;
   438			goto out;
   439		}
   440		folios[nr_folios++] = out_folio;
   441		workspace->out_buf.dst = folio_address(out_folio);
   442		workspace->out_buf.pos = 0;
   443		workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
   444	
   445		while (1) {
   446			size_t ret2;
   447	
   448			ret2 = zstd_compress_stream(stream, &workspace->out_buf,
   449					&workspace->in_buf);
   450			if (unlikely(zstd_is_error(ret2))) {
   451				struct btrfs_inode *inode = BTRFS_I(mapping->host);
   452	
   453				btrfs_warn(inode->root->fs_info,
   454	"zstd compression level %d failed, error %d root %llu inode %llu offset %llu",
   455					   workspace->req_level, zstd_get_error_code(ret2),
   456					   btrfs_root_id(inode->root), btrfs_ino(inode),
   457					   start);
   458				ret = -EIO;
   459				goto out;
   460			}
   461	
   462			/* Check to see if we are making it bigger */
   463			if (tot_in + workspace->in_buf.pos > blocksize * 2 &&
   464					tot_in + workspace->in_buf.pos <
   465					tot_out + workspace->out_buf.pos) {
   466				ret = -E2BIG;
   467				goto out;
   468			}
   469	
   470			/* We've reached the end of our output range */
   471			if (workspace->out_buf.pos >= max_out) {
   472				tot_out += workspace->out_buf.pos;
   473				ret = -E2BIG;
   474				goto out;
   475			}
   476	
   477			/* Check if we need more output space */
   478			if (workspace->out_buf.pos == workspace->out_buf.size) {
   479				tot_out += PAGE_SIZE;
   480				max_out -= PAGE_SIZE;
   481				if (nr_folios == nr_dest_folios) {
   482					ret = -E2BIG;
   483					goto out;
   484				}
   485				out_folio = btrfs_alloc_compr_folio();
   486				if (out_folio == NULL) {
   487					ret = -ENOMEM;
   488					goto out;
   489				}
   490				folios[nr_folios++] = out_folio;
   491				workspace->out_buf.dst = folio_address(out_folio);
   492				workspace->out_buf.pos = 0;
   493				workspace->out_buf.size = min_t(size_t, max_out,
   494								PAGE_SIZE);
   495			}
   496	
   497			/* We've reached the end of the input */
   498			if (workspace->in_buf.pos >= len) {
   499				tot_in += workspace->in_buf.pos;
   500				break;
   501			}
   502	
   503			/* Check if we need more input */
   504			if (workspace->in_buf.pos == workspace->in_buf.size) {
   505				tot_in += workspace->in_buf.size;
   506				kunmap_local(workspace->in_buf.src);
   507				workspace->in_buf.src = NULL;
   508				folio_put(in_folio);
   509				start += cur_len;
   510				len -= cur_len;
   511				ret = btrfs_compress_filemap_get_folio(mapping, start, &in_folio);
   512				if (ret < 0)
   513					goto out;
   514				cur_len = btrfs_calc_input_length(in_folio, orig_end, start);
   515				workspace->in_buf.src = kmap_local_folio(in_folio,
   516								 offset_in_folio(in_folio, start));
   517				workspace->in_buf.pos = 0;
   518				workspace->in_buf.size = cur_len;
   519			}
   520		}
   521		while (1) {
   522			size_t ret2;
   523	
   524			ret2 = zstd_end_stream(stream, &workspace->out_buf);
   525			if (unlikely(zstd_is_error(ret2))) {
   526				struct btrfs_inode *inode = BTRFS_I(mapping->host);
   527	
   528				btrfs_err(inode->root->fs_info,
   529	"zstd compression end level %d failed, error %d root %llu inode %llu offset %llu",
   530					  workspace->req_level, zstd_get_error_code(ret2),
   531					  btrfs_root_id(inode->root), btrfs_ino(inode),
   532					  start);
   533				ret = -EIO;
   534				goto out;
   535			}
   536			if (ret2 == 0) {
   537				tot_out += workspace->out_buf.pos;
   538				break;
   539			}
   540			if (workspace->out_buf.pos >= max_out) {
   541				tot_out += workspace->out_buf.pos;
   542				ret = -E2BIG;
   543				goto out;
   544			}
   545	
   546			tot_out += PAGE_SIZE;
   547			max_out -= PAGE_SIZE;
   548			if (nr_folios == nr_dest_folios) {
   549				ret = -E2BIG;
   550				goto out;
   551			}
   552			out_folio = btrfs_alloc_compr_folio();
   553			if (out_folio == NULL) {
   554				ret = -ENOMEM;
   555				goto out;
   556			}
   557			folios[nr_folios++] = out_folio;
   558			workspace->out_buf.dst = folio_address(out_folio);
   559			workspace->out_buf.pos = 0;
   560			workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
   561		}
   562	
   563		if (tot_out >= tot_in) {
   564			ret = -E2BIG;
   565			goto out;
   566		}
   567	
   568		ret = 0;
   569		*total_in = tot_in;
   570		*total_out = tot_out;
   571	out:
   572		*out_folios = nr_folios;
   573		if (workspace->in_buf.src) {
   574			kunmap_local(workspace->in_buf.src);
   575			folio_put(in_folio);
   576		}
   577		return ret;
   578	}
   579	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

