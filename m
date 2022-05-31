Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B6E53980E
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 22:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346183AbiEaUgc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 16:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiEaUga (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 16:36:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8C599685;
        Tue, 31 May 2022 13:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654029388; x=1685565388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UcP5WuQIdkSTdicoS+vwN6+o9XnzSB7WA88k4WCqMlQ=;
  b=h4RtxOHS9GTCImH8qe3m6f0O3C9xrZ/77qf226mY6PtFv2dAL1ApHJN/
   GoJmPAVVIOIoHtN8AqC9du2kp5Dd50uEksO0JVWDShdAsQt4zdyzXA7oL
   PcZPzDYPfATTkF8A/nfrVadxJNA4FBfpNqTlbY3tJAoB8wuioN+0KHXw2
   Eu2qCxK9TlooPt5X9JtybUgDT90LJKvdBJ7GfmTBIdqo1bn+0w/EpIbAd
   8uGPCKRPK26pirEju3wCK0V6IQSxqfm2V7SeyvfuSYMci+kLkg5Dz1Qta
   hJA7uZMZAqSfWy6CYN1OAfRU5zhXOPoKuYPwJXuhn+zrQyw9x3zmpMybH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="361753319"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="361753319"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 13:36:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="667087464"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 31 May 2022 13:36:25 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nw8bI-00033T-Q4;
        Tue, 31 May 2022 20:36:24 +0000
Date:   Wed, 1 Jun 2022 04:35:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <chris.mason@fusionio.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 3/3] btrfs: Replace kmap() with kmap_local_page() in
 zlib.c
Message-ID: <202206010437.EX5Nj7cu-lkp@intel.com>
References: <20220531145335.13954-4-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531145335.13954-4-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi "Fabio,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on v5.18 next-20220531]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Francesco/btrfs-Replace-kmap-with-kmap_local_page/20220531-225557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220601/202206010437.EX5Nj7cu-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c825abd6b0198fb088d9752f556a70705bc99dfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a549d3a90067e82e5e7d44d78a98e4a4feb628c3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Fabio-M-De-Francesco/btrfs-Replace-kmap-with-kmap_local_page/20220531-225557
        git checkout a549d3a90067e82e5e7d44d78a98e4a4feb628c3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/btrfs/zlib.c:125:6: warning: variable 'data_in' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (out_page == NULL) {
               ^~~~~~~~~~~~~~~~
   fs/btrfs/zlib.c:270:6: note: uninitialized use occurs here
           if (data_in) {
               ^~~~~~~
   fs/btrfs/zlib.c:125:2: note: remove the 'if' if its condition is always false
           if (out_page == NULL) {
           ^~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/zlib.c:115:6: warning: variable 'data_in' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (Z_OK != zlib_deflateInit(&workspace->strm, workspace->level)) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/zlib.h:148:25: note: expanded from macro 'Z_OK'
   #define Z_OK            0
                           ^
   fs/btrfs/zlib.c:270:6: note: uninitialized use occurs here
           if (data_in) {
               ^~~~~~~
   fs/btrfs/zlib.c:115:2: note: remove the 'if' if its condition is always false
           if (Z_OK != zlib_deflateInit(&workspace->strm, workspace->level)) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/zlib.c:100:15: note: initialize the variable 'data_in' to silence this warning
           char *data_in;
                        ^
                         = NULL
>> fs/btrfs/zlib.c:125:6: warning: variable 'cpage_out' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (out_page == NULL) {
               ^~~~~~~~~~~~~~~~
   fs/btrfs/zlib.c:267:6: note: uninitialized use occurs here
           if (cpage_out)
               ^~~~~~~~~
   fs/btrfs/zlib.c:125:2: note: remove the 'if' if its condition is always false
           if (out_page == NULL) {
           ^~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/zlib.c:115:6: warning: variable 'cpage_out' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (Z_OK != zlib_deflateInit(&workspace->strm, workspace->level)) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/zlib.h:148:25: note: expanded from macro 'Z_OK'
   #define Z_OK            0
                           ^
   fs/btrfs/zlib.c:267:6: note: uninitialized use occurs here
           if (cpage_out)
               ^~~~~~~~~
   fs/btrfs/zlib.c:115:2: note: remove the 'if' if its condition is always false
           if (Z_OK != zlib_deflateInit(&workspace->strm, workspace->level)) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/zlib.c:101:17: note: initialize the variable 'cpage_out' to silence this warning
           char *cpage_out;
                          ^
                           = NULL
   4 warnings generated.


vim +125 fs/btrfs/zlib.c

c8b978188c9a0fd Chris Mason           2008-10-29   93  
c4bf665a3197554 David Sterba          2019-10-01   94  int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
c4bf665a3197554 David Sterba          2019-10-01   95  		u64 start, struct page **pages, unsigned long *out_pages,
c4bf665a3197554 David Sterba          2019-10-01   96  		unsigned long *total_in, unsigned long *total_out)
c8b978188c9a0fd Chris Mason           2008-10-29   97  {
261507a02ccba9a Li Zefan              2010-12-17   98  	struct workspace *workspace = list_entry(ws, struct workspace, list);
c8b978188c9a0fd Chris Mason           2008-10-29   99  	int ret;
c8b978188c9a0fd Chris Mason           2008-10-29  100  	char *data_in;
c8b978188c9a0fd Chris Mason           2008-10-29  101  	char *cpage_out;
c8b978188c9a0fd Chris Mason           2008-10-29  102  	int nr_pages = 0;
c8b978188c9a0fd Chris Mason           2008-10-29  103  	struct page *in_page = NULL;
c8b978188c9a0fd Chris Mason           2008-10-29  104  	struct page *out_page = NULL;
c8b978188c9a0fd Chris Mason           2008-10-29  105  	unsigned long bytes_left;
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  106  	unsigned int in_buf_pages;
38c31464089f639 David Sterba          2017-02-14  107  	unsigned long len = *total_out;
4d3a800ebb12999 David Sterba          2017-02-14  108  	unsigned long nr_dest_pages = *out_pages;
e5d74902362f1a0 David Sterba          2017-02-14  109  	const unsigned long max_out = nr_dest_pages * PAGE_SIZE;
c8b978188c9a0fd Chris Mason           2008-10-29  110  
c8b978188c9a0fd Chris Mason           2008-10-29  111  	*out_pages = 0;
c8b978188c9a0fd Chris Mason           2008-10-29  112  	*total_out = 0;
c8b978188c9a0fd Chris Mason           2008-10-29  113  	*total_in = 0;
c8b978188c9a0fd Chris Mason           2008-10-29  114  
f51d2b59120ff36 David Sterba          2017-09-15  115  	if (Z_OK != zlib_deflateInit(&workspace->strm, workspace->level)) {
62e855771dacf7c Jeff Mahoney          2016-09-20  116  		pr_warn("BTRFS: deflateInit failed\n");
60e1975acb48fc3 Zach Brown            2014-05-09  117  		ret = -EIO;
c8b978188c9a0fd Chris Mason           2008-10-29  118  		goto out;
c8b978188c9a0fd Chris Mason           2008-10-29  119  	}
c8b978188c9a0fd Chris Mason           2008-10-29  120  
7880991344f7364 Sergey Senozhatsky    2014-07-07  121  	workspace->strm.total_in = 0;
7880991344f7364 Sergey Senozhatsky    2014-07-07  122  	workspace->strm.total_out = 0;
c8b978188c9a0fd Chris Mason           2008-10-29  123  
b0ee5e1ec44afda David Sterba          2021-06-14  124  	out_page = alloc_page(GFP_NOFS);
4b72029dc3fd6ba Li Zefan              2010-11-09 @125  	if (out_page == NULL) {
60e1975acb48fc3 Zach Brown            2014-05-09  126  		ret = -ENOMEM;
4b72029dc3fd6ba Li Zefan              2010-11-09  127  		goto out;
4b72029dc3fd6ba Li Zefan              2010-11-09  128  	}
a549d3a90067e82 Fabio M. De Francesco 2022-05-31  129  	cpage_out = kmap_local_page(out_page);
c8b978188c9a0fd Chris Mason           2008-10-29  130  	pages[0] = out_page;
c8b978188c9a0fd Chris Mason           2008-10-29  131  	nr_pages = 1;
c8b978188c9a0fd Chris Mason           2008-10-29  132  
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  133  	workspace->strm.next_in = workspace->buf;
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  134  	workspace->strm.avail_in = 0;
7880991344f7364 Sergey Senozhatsky    2014-07-07  135  	workspace->strm.next_out = cpage_out;
09cbfeaf1a5a67b Kirill A. Shutemov    2016-04-01  136  	workspace->strm.avail_out = PAGE_SIZE;
c8b978188c9a0fd Chris Mason           2008-10-29  137  
7880991344f7364 Sergey Senozhatsky    2014-07-07  138  	while (workspace->strm.total_in < len) {
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  139  		/*
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  140  		 * Get next input pages and copy the contents to
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  141  		 * the workspace buffer if required.
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  142  		 */
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  143  		if (workspace->strm.avail_in == 0) {
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  144  			bytes_left = len - workspace->strm.total_in;
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  145  			in_buf_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  146  					   workspace->buf_size / PAGE_SIZE);
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  147  			if (in_buf_pages > 1) {
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  148  				int i;
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  149  
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  150  				for (i = 0; i < in_buf_pages; i++) {
a549d3a90067e82 Fabio M. De Francesco 2022-05-31  151  					if (data_in) {
a549d3a90067e82 Fabio M. De Francesco 2022-05-31  152  						kunmap_local(data_in);
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  153  						put_page(in_page);
55276e14df4324a David Sterba          2021-10-27  154  					}
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  155  					in_page = find_get_page(mapping,
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  156  								start >> PAGE_SHIFT);
a549d3a90067e82 Fabio M. De Francesco 2022-05-31  157  					data_in = kmap_local_page(in_page);
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  158  					memcpy(workspace->buf + i * PAGE_SIZE,
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  159  					       data_in, PAGE_SIZE);
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  160  					start += PAGE_SIZE;
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  161  				}
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  162  				workspace->strm.next_in = workspace->buf;
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  163  			} else {
a549d3a90067e82 Fabio M. De Francesco 2022-05-31  164  				if (data_in) {
a549d3a90067e82 Fabio M. De Francesco 2022-05-31  165  					kunmap_local(data_in);
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  166  					put_page(in_page);
55276e14df4324a David Sterba          2021-10-27  167  				}
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  168  				in_page = find_get_page(mapping,
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  169  							start >> PAGE_SHIFT);
a549d3a90067e82 Fabio M. De Francesco 2022-05-31  170  				data_in = kmap_local_page(in_page);
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  171  				start += PAGE_SIZE;
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  172  				workspace->strm.next_in = data_in;
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  173  			}
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  174  			workspace->strm.avail_in = min(bytes_left,
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  175  						       (unsigned long) workspace->buf_size);
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  176  		}
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  177  
7880991344f7364 Sergey Senozhatsky    2014-07-07  178  		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
c8b978188c9a0fd Chris Mason           2008-10-29  179  		if (ret != Z_OK) {
62e855771dacf7c Jeff Mahoney          2016-09-20  180  			pr_debug("BTRFS: deflate in loop returned %d\n",
c8b978188c9a0fd Chris Mason           2008-10-29  181  			       ret);
7880991344f7364 Sergey Senozhatsky    2014-07-07  182  			zlib_deflateEnd(&workspace->strm);
60e1975acb48fc3 Zach Brown            2014-05-09  183  			ret = -EIO;
c8b978188c9a0fd Chris Mason           2008-10-29  184  			goto out;
c8b978188c9a0fd Chris Mason           2008-10-29  185  		}
c8b978188c9a0fd Chris Mason           2008-10-29  186  
c8b978188c9a0fd Chris Mason           2008-10-29  187  		/* we're making it bigger, give up */
7880991344f7364 Sergey Senozhatsky    2014-07-07  188  		if (workspace->strm.total_in > 8192 &&
7880991344f7364 Sergey Senozhatsky    2014-07-07  189  		    workspace->strm.total_in <
7880991344f7364 Sergey Senozhatsky    2014-07-07  190  		    workspace->strm.total_out) {
130d5b415a091e4 David Sterba          2014-06-20  191  			ret = -E2BIG;
c8b978188c9a0fd Chris Mason           2008-10-29  192  			goto out;
c8b978188c9a0fd Chris Mason           2008-10-29  193  		}
c8b978188c9a0fd Chris Mason           2008-10-29  194  		/* we need another page for writing out.  Test this
c8b978188c9a0fd Chris Mason           2008-10-29  195  		 * before the total_in so we will pull in a new page for
c8b978188c9a0fd Chris Mason           2008-10-29  196  		 * the stream end if required
c8b978188c9a0fd Chris Mason           2008-10-29  197  		 */
7880991344f7364 Sergey Senozhatsky    2014-07-07  198  		if (workspace->strm.avail_out == 0) {
a549d3a90067e82 Fabio M. De Francesco 2022-05-31  199  			kunmap_local(cpage_out);
c8b978188c9a0fd Chris Mason           2008-10-29  200  			if (nr_pages == nr_dest_pages) {
c8b978188c9a0fd Chris Mason           2008-10-29  201  				out_page = NULL;
60e1975acb48fc3 Zach Brown            2014-05-09  202  				ret = -E2BIG;
c8b978188c9a0fd Chris Mason           2008-10-29  203  				goto out;
c8b978188c9a0fd Chris Mason           2008-10-29  204  			}
b0ee5e1ec44afda David Sterba          2021-06-14  205  			out_page = alloc_page(GFP_NOFS);
4b72029dc3fd6ba Li Zefan              2010-11-09  206  			if (out_page == NULL) {
60e1975acb48fc3 Zach Brown            2014-05-09  207  				ret = -ENOMEM;
4b72029dc3fd6ba Li Zefan              2010-11-09  208  				goto out;
4b72029dc3fd6ba Li Zefan              2010-11-09  209  			}
a549d3a90067e82 Fabio M. De Francesco 2022-05-31  210  			cpage_out = kmap_local_page(out_page);
c8b978188c9a0fd Chris Mason           2008-10-29  211  			pages[nr_pages] = out_page;
c8b978188c9a0fd Chris Mason           2008-10-29  212  			nr_pages++;
09cbfeaf1a5a67b Kirill A. Shutemov    2016-04-01  213  			workspace->strm.avail_out = PAGE_SIZE;
7880991344f7364 Sergey Senozhatsky    2014-07-07  214  			workspace->strm.next_out = cpage_out;
c8b978188c9a0fd Chris Mason           2008-10-29  215  		}
c8b978188c9a0fd Chris Mason           2008-10-29  216  		/* we're all done */
7880991344f7364 Sergey Senozhatsky    2014-07-07  217  		if (workspace->strm.total_in >= len)
c8b978188c9a0fd Chris Mason           2008-10-29  218  			break;
7880991344f7364 Sergey Senozhatsky    2014-07-07  219  		if (workspace->strm.total_out > max_out)
c8b978188c9a0fd Chris Mason           2008-10-29  220  			break;
c8b978188c9a0fd Chris Mason           2008-10-29  221  	}
7880991344f7364 Sergey Senozhatsky    2014-07-07  222  	workspace->strm.avail_in = 0;
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  223  	/*
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  224  	 * Call deflate with Z_FINISH flush parameter providing more output
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  225  	 * space but no more input data, until it returns with Z_STREAM_END.
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  226  	 */
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  227  	while (ret != Z_STREAM_END) {
7880991344f7364 Sergey Senozhatsky    2014-07-07  228  		ret = zlib_deflate(&workspace->strm, Z_FINISH);
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  229  		if (ret == Z_STREAM_END)
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  230  			break;
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  231  		if (ret != Z_OK && ret != Z_BUF_ERROR) {
7880991344f7364 Sergey Senozhatsky    2014-07-07  232  			zlib_deflateEnd(&workspace->strm);
60e1975acb48fc3 Zach Brown            2014-05-09  233  			ret = -EIO;
c8b978188c9a0fd Chris Mason           2008-10-29  234  			goto out;
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  235  		} else if (workspace->strm.avail_out == 0) {
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  236  			/* get another page for the stream end */
a549d3a90067e82 Fabio M. De Francesco 2022-05-31  237  			kunmap_local(cpage_out);
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  238  			if (nr_pages == nr_dest_pages) {
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  239  				out_page = NULL;
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  240  				ret = -E2BIG;
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  241  				goto out;
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  242  			}
b0ee5e1ec44afda David Sterba          2021-06-14  243  			out_page = alloc_page(GFP_NOFS);
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  244  			if (out_page == NULL) {
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  245  				ret = -ENOMEM;
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  246  				goto out;
c8b978188c9a0fd Chris Mason           2008-10-29  247  			}
a549d3a90067e82 Fabio M. De Francesco 2022-05-31  248  			cpage_out = kmap_local_page(out_page);
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  249  			pages[nr_pages] = out_page;
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  250  			nr_pages++;
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  251  			workspace->strm.avail_out = PAGE_SIZE;
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  252  			workspace->strm.next_out = cpage_out;
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  253  		}
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  254  	}
3fd396afc05fc90 Mikhail Zaslonko      2020-01-30  255  	zlib_deflateEnd(&workspace->strm);
c8b978188c9a0fd Chris Mason           2008-10-29  256  
7880991344f7364 Sergey Senozhatsky    2014-07-07  257  	if (workspace->strm.total_out >= workspace->strm.total_in) {
60e1975acb48fc3 Zach Brown            2014-05-09  258  		ret = -E2BIG;
c8b978188c9a0fd Chris Mason           2008-10-29  259  		goto out;
c8b978188c9a0fd Chris Mason           2008-10-29  260  	}
c8b978188c9a0fd Chris Mason           2008-10-29  261  
c8b978188c9a0fd Chris Mason           2008-10-29  262  	ret = 0;
7880991344f7364 Sergey Senozhatsky    2014-07-07  263  	*total_out = workspace->strm.total_out;
7880991344f7364 Sergey Senozhatsky    2014-07-07  264  	*total_in = workspace->strm.total_in;
c8b978188c9a0fd Chris Mason           2008-10-29  265  out:
c8b978188c9a0fd Chris Mason           2008-10-29  266  	*out_pages = nr_pages;
a549d3a90067e82 Fabio M. De Francesco 2022-05-31  267  	if (cpage_out)
a549d3a90067e82 Fabio M. De Francesco 2022-05-31  268  		kunmap_local(cpage_out);
55276e14df4324a David Sterba          2021-10-27  269  
a549d3a90067e82 Fabio M. De Francesco 2022-05-31  270  	if (data_in) {
a549d3a90067e82 Fabio M. De Francesco 2022-05-31  271  		kunmap_local(data_in);
09cbfeaf1a5a67b Kirill A. Shutemov    2016-04-01  272  		put_page(in_page);
55276e14df4324a David Sterba          2021-10-27  273  	}
c8b978188c9a0fd Chris Mason           2008-10-29  274  	return ret;
c8b978188c9a0fd Chris Mason           2008-10-29  275  }
c8b978188c9a0fd Chris Mason           2008-10-29  276  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
