Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFFF5ABEC5
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Sep 2022 13:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiICLd3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Sep 2022 07:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiICLd3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 07:33:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144A56D9C1
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 04:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662204808; x=1693740808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bwuFF/h+pb3a4uxf5G1xrDWG4LVJKcY4K0JCaoPWshg=;
  b=hfSy+nBLlEHjllDf0rn+k26d6Ne+KZjCJWYjpWR9gojgFgl9v4qLFJcj
   pqorrSHWkfT4LDeMJnC/TX7zfN2fNjM3sSICZfCWlLD9QY0xLcFrG/+5E
   VihUcfTpt6kKs2A75HK9QWDp21gZeQhpa+2i2SNXrabcUSLMY10tpJGzz
   oIvX8wOrzwcITtVatviq8Rl91GP7Mv0JIxJUYdn2CyJD1/wOmmUPmfFF7
   owxco0oYwa+gfIiafqINILFJSEg2OtgDvtx5GVF6GEsIlUyqBJG4MNIx+
   g/3fPT1C3GeMp84p1yMXuWL0w3Qm7VZoshthGPpw0Jjv+0MrmzYdvqsj4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="297445881"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="297445881"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 04:33:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="941576583"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 03 Sep 2022 04:33:26 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUROv-0001Zb-28;
        Sat, 03 Sep 2022 11:33:25 +0000
Date:   Sat, 3 Sep 2022 19:33:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH PoC 9/9] btrfs: scrub: implement recoverable sectors
 report for scrub_fs
Message-ID: <202209031939.5FTgOh5V-lkp@intel.com>
References: <06e4f67a9e50c2b6dfc49a086ee62053cbdcc0ae.1662191784.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06e4f67a9e50c2b6dfc49a086ee62053cbdcc0ae.1662191784.git.wqu@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master v6.0-rc3 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-scrub-introduce-a-new-family-of-ioctl-scrub_fs/20220903-162128
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: hexagon-randconfig-r045-20220902 (https://download.01.org/0day-ci/archive/20220903/202209031939.5FTgOh5V-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e6387ecfd7e78ac47fca972ef76f3286e6cd3900
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qu-Wenruo/btrfs-scrub-introduce-a-new-family-of-ioctl-scrub_fs/20220903-162128
        git checkout e6387ecfd7e78ac47fca972ef76f3286e6cd3900
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/btrfs/scrub.c:5382:6: warning: variable 'nr_good' set but not used [-Wunused-but-set-variable]
           int nr_good = 0;
               ^
   1 warning generated.


vim +/nr_good +5382 fs/btrfs/scrub.c

  5376	
  5377	static void scrub_fs_recover_data(struct scrub_fs_ctx *sfctx, int sector_nr)
  5378	{
  5379		struct btrfs_fs_info *fs_info = sfctx->fs_info;
  5380		const bool has_csum = !!sfctx->sectors[sector_nr].csum;
  5381		bool mismatch_found = false;
> 5382		int nr_good = 0;
  5383		int io_fail = 0;
  5384		int mirror_nr;
  5385	
  5386		for (mirror_nr = 0; mirror_nr < sfctx->nr_copies; mirror_nr++) {
  5387			struct scrub_fs_sector *sector =
  5388				scrub_fs_get_sector(sfctx, sector_nr, mirror_nr);
  5389	
  5390			if (sector->flags & SCRUB_FS_SECTOR_FLAG_GOOD)
  5391				nr_good++;
  5392			if (!(sector->flags & SCRUB_FS_SECTOR_FLAG_IO_DONE))
  5393				io_fail++;
  5394		}
  5395	
  5396		if (has_csum) {
  5397			/*
  5398			 * There is at least one good copy, thus all the other
  5399			 * corrupted sectors can also be recovered.
  5400			 */
  5401			for (mirror_nr = 0; mirror_nr < sfctx->nr_copies; mirror_nr++) {
  5402				struct scrub_fs_sector *sector =
  5403					scrub_fs_get_sector(sfctx, sector_nr, mirror_nr);
  5404	
  5405				if (sector->flags & SCRUB_FS_SECTOR_FLAG_GOOD)
  5406					continue;
  5407				sector->flags |= SCRUB_FS_SECTOR_FLAG_RECOVERABLE;
  5408				sfctx->stat.data_recoverable += fs_info->sectorsize;
  5409			}
  5410	
  5411			/* Place holder for writeback */
  5412			return;
  5413		}
  5414	
  5415		/*
  5416		 * No datasum case, it's much harder.
  5417		 *
  5418		 * The idea is, we have to compare all the sectors to determine if they
  5419		 * match.
  5420		 *
  5421		 * Firstly rule out sectors which don't have extra working copies.
  5422		 */
  5423		if (sfctx->nr_copies - io_fail <= 1) {
  5424			sfctx->stat.data_nocsum_uncertain += fs_info->sectorsize;
  5425			return;
  5426		}
  5427	
  5428		/*
  5429		 * For now, we can only support one case, all data read matches with each
  5430		 * other, or we consider them all uncertain.
  5431		 */
  5432		for (mirror_nr = 0; mirror_nr < sfctx->nr_copies - 1; mirror_nr++) {
  5433			struct scrub_fs_sector *sector =
  5434				scrub_fs_get_sector(sfctx, sector_nr, mirror_nr);
  5435			struct scrub_fs_sector *next_sector;
  5436			int ret;
  5437	
  5438			/* The first sector has IO error, skip to the next run. */
  5439			if (!(sector->flags & SCRUB_FS_SECTOR_FLAG_IO_DONE))
  5440				continue;
  5441	
  5442			next_sector = scrub_fs_find_next_working_mirror(sfctx,
  5443					sector_nr, mirror_nr);
  5444			/* We're already the last working copy, can break now. */
  5445			if (!next_sector)
  5446				break;
  5447	
  5448			ret = scrub_fs_memcmp_sectors(sfctx, sector, next_sector);
  5449			if (ret)
  5450				mismatch_found = true;
  5451		}
  5452	
  5453		/*
  5454		 * We have found mismatched contents, mark all those sectors
  5455		 * which doesn't have IO error as uncertain.
  5456		 */
  5457		if (mismatch_found)
  5458			sfctx->stat.data_nocsum_uncertain +=
  5459				(sfctx->nr_copies - io_fail) << fs_info->sectorsize_bits;
  5460	}
  5461	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
