Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823CD75ECF0
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 09:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjGXH6v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 03:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjGXH6Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 03:58:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F44B3
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 00:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690185462; x=1721721462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TgcaBNEYIGLRW6+34tr9A98bCq8zLZnStV1oc/gJftg=;
  b=aD+yjFyheoijHj7fd1Ndw4c6lIJr4f0d1MAEs1SPyDnIhZwUONu3nOVG
   TvLT6tZYoghEslYSOn33Qti+dvMxVNcIBxkYtZ0XMQj66j+4INxXhIvX0
   sbc+iDFQBBxbJKZD7lIcsfmqGjDtko7S36EWZQ0kFeevAxELi0e2QOwmW
   RR6+qoZkisaz21JHYC0tjn2Uu32PO/+2S4Di8bp6vE9Z5i5yHYNlB4RYb
   afEwooKRjlnYawqKrBz+QSIAnVMFBSeVnMp/hbZi3MY70JTl8wNhZM50y
   cblKbuHlzxuRyWuPpyJpVbEeP35mQe79h6cCWzOTpMmP/9+p/oEi/XZ9o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="366268058"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="366268058"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 00:57:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="795675614"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="795675614"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2023 00:57:41 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNqRo-0009a4-17;
        Mon, 24 Jul 2023 07:57:40 +0000
Date:   Mon, 24 Jul 2023 15:57:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH 5/8] btrfs: zoned: activate metadata block group on write
 time
Message-ID: <202307241541.8w52nEnt-lkp@intel.com>
References: <2f8e30f966cfd9e06b0745a691bd1a5566aab780.1690171333.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f8e30f966cfd9e06b0745a691bd1a5566aab780.1690171333.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Naohiro,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.5-rc3 next-20230724]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Naohiro-Aota/btrfs-zoned-introduce-block_group-context-for-submit_eb_page/20230724-122053
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/2f8e30f966cfd9e06b0745a691bd1a5566aab780.1690171333.git.naohiro.aota%40wdc.com
patch subject: [PATCH 5/8] btrfs: zoned: activate metadata block group on write time
config: arm-randconfig-r002-20230724 (https://download.01.org/0day-ci/archive/20230724/202307241541.8w52nEnt-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230724/202307241541.8w52nEnt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307241541.8w52nEnt-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/btrfs/extent_io.c:214:16: warning: variable 'pages_processed' set but not used [-Wunused-but-set-variable]
     214 |         unsigned long pages_processed = 0;
         |                       ^
>> fs/btrfs/extent_io.c:1827:60: error: too many arguments to function call, expected 3, have 4
    1827 |         if (!btrfs_check_meta_write_pointer(eb->fs_info, wbc, eb, bg_context)) {
         |              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                       ^~~~~~~~~~
   fs/btrfs/zoned.h:191:20: note: 'btrfs_check_meta_write_pointer' declared here
     191 | static inline bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
         |                    ^
   1 warning and 1 error generated.


vim +1827 fs/btrfs/extent_io.c

  1766	
  1767	/*
  1768	 * Submit all page(s) of one extent buffer.
  1769	 *
  1770	 * @page:	the page of one extent buffer
  1771	 * @eb_context:	to determine if we need to submit this page, if current page
  1772	 *		belongs to this eb, we don't need to submit
  1773	 *
  1774	 * The caller should pass each page in their bytenr order, and here we use
  1775	 * @eb_context to determine if we have submitted pages of one extent buffer.
  1776	 *
  1777	 * If we have, we just skip until we hit a new page that doesn't belong to
  1778	 * current @eb_context.
  1779	 *
  1780	 * If not, we submit all the page(s) of the extent buffer.
  1781	 *
  1782	 * Return >0 if we have submitted the extent buffer successfully.
  1783	 * Return 0 if we don't need to submit the page, as it's already submitted by
  1784	 * previous call.
  1785	 * Return <0 for fatal error.
  1786	 */
  1787	static int submit_eb_page(struct page *page, struct writeback_control *wbc,
  1788				  struct extent_buffer **eb_context,
  1789				  struct btrfs_block_group **bg_context)
  1790	{
  1791		struct address_space *mapping = page->mapping;
  1792		struct extent_buffer *eb;
  1793		int ret;
  1794	
  1795		if (!PagePrivate(page))
  1796			return 0;
  1797	
  1798		if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
  1799			return submit_eb_subpage(page, wbc);
  1800	
  1801		spin_lock(&mapping->private_lock);
  1802		if (!PagePrivate(page)) {
  1803			spin_unlock(&mapping->private_lock);
  1804			return 0;
  1805		}
  1806	
  1807		eb = (struct extent_buffer *)page->private;
  1808	
  1809		/*
  1810		 * Shouldn't happen and normally this would be a BUG_ON but no point
  1811		 * crashing the machine for something we can survive anyway.
  1812		 */
  1813		if (WARN_ON(!eb)) {
  1814			spin_unlock(&mapping->private_lock);
  1815			return 0;
  1816		}
  1817	
  1818		if (eb == *eb_context) {
  1819			spin_unlock(&mapping->private_lock);
  1820			return 0;
  1821		}
  1822		ret = atomic_inc_not_zero(&eb->refs);
  1823		spin_unlock(&mapping->private_lock);
  1824		if (!ret)
  1825			return 0;
  1826	
> 1827		if (!btrfs_check_meta_write_pointer(eb->fs_info, wbc, eb, bg_context)) {
  1828			/*
  1829			 * If for_sync, this hole will be filled with
  1830			 * trasnsaction commit.
  1831			 */
  1832			if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
  1833				ret = -EAGAIN;
  1834			else
  1835				ret = 0;
  1836			free_extent_buffer(eb);
  1837			return ret;
  1838		}
  1839	
  1840		*eb_context = eb;
  1841	
  1842		if (!lock_extent_buffer_for_io(eb, wbc)) {
  1843			free_extent_buffer(eb);
  1844			return 0;
  1845		}
  1846		if (*bg_context) {
  1847			/* Implies write in zoned mode. */
  1848			struct btrfs_block_group *bg = *bg_context;
  1849	
  1850			/* Mark the last eb in the block group. */
  1851			btrfs_schedule_zone_finish_bg(bg, eb);
  1852			bg->meta_write_pointer += eb->len;
  1853		}
  1854		write_one_eb(eb, wbc);
  1855		free_extent_buffer(eb);
  1856		return 1;
  1857	}
  1858	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
