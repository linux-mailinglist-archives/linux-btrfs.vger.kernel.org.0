Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4645535F906
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Apr 2021 18:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344641AbhDNQdn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Apr 2021 12:33:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:18163 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231158AbhDNQdm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Apr 2021 12:33:42 -0400
IronPort-SDR: UqQeaOZO/gcQ4oOwte/jUU26fLuLrpRrmwM4sJxiRMy6tOpgj+53arcuQXgfDuIUhyMSsSPoe1
 P85rU1Dlgtkg==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="258642903"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="gz'50?scan'50,208,50";a="258642903"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 09:33:20 -0700
IronPort-SDR: uHpXH/h2D9fiLY/ehbUpJf4/Aw0AyT0p7se47EnuGy9CS96UNLbqn8vKjhSkSuRbfrXtPd8TpR
 b700OuINuExg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="gz'50?scan'50,208,50";a="461280475"
Received: from lkp-server02.sh.intel.com (HELO fa9c8fcc3464) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Apr 2021 09:33:17 -0700
Received: from kbuild by fa9c8fcc3464 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWiS4-00006z-KE; Wed, 14 Apr 2021 16:33:16 +0000
Date:   Thu, 15 Apr 2021 00:32:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] btrfs: zoned: fix unpaired block group unfreeze during
 device replace
Message-ID: <202104150027.OO5B2sX5-lkp@intel.com>
References: <a76c376dfb6b391b96986c03664ecb657a24b012.1618402032.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <a76c376dfb6b391b96986c03664ecb657a24b012.1618402032.git.fdmanana@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on v5.12-rc7 next-20210414]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/fdmanana-kernel-org/btrfs-zoned-fix-unpaired-block-group-unfreeze-during-device-replace/20210414-201003
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: x86_64-randconfig-r033-20210414 (attached as .config)
compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 9829f5e6b1bca9b61efc629770d28bb9014dec45)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install x86_64 cross compiling tool for clang build
        # apt-get install binutils-x86-64-linux-gnu
        # https://github.com/0day-ci/linux/commit/31f44555b4f7341b558a9062f0977e8fe817045d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review fdmanana-kernel-org/btrfs-zoned-fix-unpaired-block-group-unfreeze-during-device-replace/20210414-201003
        git checkout 31f44555b4f7341b558a9062f0977e8fe817045d
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/btrfs/scrub.c:3836:1: warning: unused label 'done' [-Wunused-label]
   done:
   ^~~~~
   1 warning generated.


vim +/done +3836 fs/btrfs/scrub.c

de17addce7a20d Naohiro Aota   2021-02-04  3586  
a2de733c78fa7a Arne Jansen    2011-03-08  3587  static noinline_for_stack
a36cf8b8933e4a Stefan Behrens 2012-11-02  3588  int scrub_enumerate_chunks(struct scrub_ctx *sctx,
32934280967d00 Omar Sandoval  2018-08-14  3589  			   struct btrfs_device *scrub_dev, u64 start, u64 end)
a2de733c78fa7a Arne Jansen    2011-03-08  3590  {
a2de733c78fa7a Arne Jansen    2011-03-08  3591  	struct btrfs_dev_extent *dev_extent = NULL;
a2de733c78fa7a Arne Jansen    2011-03-08  3592  	struct btrfs_path *path;
0b246afa62b0cf Jeff Mahoney   2016-06-22  3593  	struct btrfs_fs_info *fs_info = sctx->fs_info;
0b246afa62b0cf Jeff Mahoney   2016-06-22  3594  	struct btrfs_root *root = fs_info->dev_root;
a2de733c78fa7a Arne Jansen    2011-03-08  3595  	u64 length;
a2de733c78fa7a Arne Jansen    2011-03-08  3596  	u64 chunk_offset;
55e3a601c81cdc Zhaolei        2015-08-05  3597  	int ret = 0;
76a8efa171bf6c Zhaolei        2015-11-17  3598  	int ro_set;
a2de733c78fa7a Arne Jansen    2011-03-08  3599  	int slot;
a2de733c78fa7a Arne Jansen    2011-03-08  3600  	struct extent_buffer *l;
a2de733c78fa7a Arne Jansen    2011-03-08  3601  	struct btrfs_key key;
a2de733c78fa7a Arne Jansen    2011-03-08  3602  	struct btrfs_key found_key;
32da5386d9a4fd David Sterba   2019-10-29  3603  	struct btrfs_block_group *cache;
ff023aac31198e Stefan Behrens 2012-11-06  3604  	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
a2de733c78fa7a Arne Jansen    2011-03-08  3605  
a2de733c78fa7a Arne Jansen    2011-03-08  3606  	path = btrfs_alloc_path();
a2de733c78fa7a Arne Jansen    2011-03-08  3607  	if (!path)
a2de733c78fa7a Arne Jansen    2011-03-08  3608  		return -ENOMEM;
a2de733c78fa7a Arne Jansen    2011-03-08  3609  
e4058b54d1e442 David Sterba   2015-11-27  3610  	path->reada = READA_FORWARD;
a2de733c78fa7a Arne Jansen    2011-03-08  3611  	path->search_commit_root = 1;
a2de733c78fa7a Arne Jansen    2011-03-08  3612  	path->skip_locking = 1;
a2de733c78fa7a Arne Jansen    2011-03-08  3613  
a36cf8b8933e4a Stefan Behrens 2012-11-02  3614  	key.objectid = scrub_dev->devid;
a2de733c78fa7a Arne Jansen    2011-03-08  3615  	key.offset = 0ull;
a2de733c78fa7a Arne Jansen    2011-03-08  3616  	key.type = BTRFS_DEV_EXTENT_KEY;
a2de733c78fa7a Arne Jansen    2011-03-08  3617  
a2de733c78fa7a Arne Jansen    2011-03-08  3618  	while (1) {
a2de733c78fa7a Arne Jansen    2011-03-08  3619  		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
a2de733c78fa7a Arne Jansen    2011-03-08  3620  		if (ret < 0)
8c51032f978bac Arne Jansen    2011-06-03  3621  			break;
8c51032f978bac Arne Jansen    2011-06-03  3622  		if (ret > 0) {
8c51032f978bac Arne Jansen    2011-06-03  3623  			if (path->slots[0] >=
8c51032f978bac Arne Jansen    2011-06-03  3624  			    btrfs_header_nritems(path->nodes[0])) {
8c51032f978bac Arne Jansen    2011-06-03  3625  				ret = btrfs_next_leaf(root, path);
55e3a601c81cdc Zhaolei        2015-08-05  3626  				if (ret < 0)
55e3a601c81cdc Zhaolei        2015-08-05  3627  					break;
55e3a601c81cdc Zhaolei        2015-08-05  3628  				if (ret > 0) {
55e3a601c81cdc Zhaolei        2015-08-05  3629  					ret = 0;
8c51032f978bac Arne Jansen    2011-06-03  3630  					break;
8c51032f978bac Arne Jansen    2011-06-03  3631  				}
55e3a601c81cdc Zhaolei        2015-08-05  3632  			} else {
55e3a601c81cdc Zhaolei        2015-08-05  3633  				ret = 0;
55e3a601c81cdc Zhaolei        2015-08-05  3634  			}
8c51032f978bac Arne Jansen    2011-06-03  3635  		}
a2de733c78fa7a Arne Jansen    2011-03-08  3636  
a2de733c78fa7a Arne Jansen    2011-03-08  3637  		l = path->nodes[0];
a2de733c78fa7a Arne Jansen    2011-03-08  3638  		slot = path->slots[0];
a2de733c78fa7a Arne Jansen    2011-03-08  3639  
a2de733c78fa7a Arne Jansen    2011-03-08  3640  		btrfs_item_key_to_cpu(l, &found_key, slot);
a2de733c78fa7a Arne Jansen    2011-03-08  3641  
a36cf8b8933e4a Stefan Behrens 2012-11-02  3642  		if (found_key.objectid != scrub_dev->devid)
a2de733c78fa7a Arne Jansen    2011-03-08  3643  			break;
a2de733c78fa7a Arne Jansen    2011-03-08  3644  
962a298f35110e David Sterba   2014-06-04  3645  		if (found_key.type != BTRFS_DEV_EXTENT_KEY)
a2de733c78fa7a Arne Jansen    2011-03-08  3646  			break;
a2de733c78fa7a Arne Jansen    2011-03-08  3647  
a2de733c78fa7a Arne Jansen    2011-03-08  3648  		if (found_key.offset >= end)
a2de733c78fa7a Arne Jansen    2011-03-08  3649  			break;
a2de733c78fa7a Arne Jansen    2011-03-08  3650  
a2de733c78fa7a Arne Jansen    2011-03-08  3651  		if (found_key.offset < key.offset)
a2de733c78fa7a Arne Jansen    2011-03-08  3652  			break;
a2de733c78fa7a Arne Jansen    2011-03-08  3653  
a2de733c78fa7a Arne Jansen    2011-03-08  3654  		dev_extent = btrfs_item_ptr(l, slot, struct btrfs_dev_extent);
a2de733c78fa7a Arne Jansen    2011-03-08  3655  		length = btrfs_dev_extent_length(l, dev_extent);
a2de733c78fa7a Arne Jansen    2011-03-08  3656  
ced96edc48ba45 Qu Wenruo      2014-06-19  3657  		if (found_key.offset + length <= start)
ced96edc48ba45 Qu Wenruo      2014-06-19  3658  			goto skip;
a2de733c78fa7a Arne Jansen    2011-03-08  3659  
a2de733c78fa7a Arne Jansen    2011-03-08  3660  		chunk_offset = btrfs_dev_extent_chunk_offset(l, dev_extent);
a2de733c78fa7a Arne Jansen    2011-03-08  3661  
a2de733c78fa7a Arne Jansen    2011-03-08  3662  		/*
a2de733c78fa7a Arne Jansen    2011-03-08  3663  		 * get a reference on the corresponding block group to prevent
a2de733c78fa7a Arne Jansen    2011-03-08  3664  		 * the chunk from going away while we scrub it
a2de733c78fa7a Arne Jansen    2011-03-08  3665  		 */
a2de733c78fa7a Arne Jansen    2011-03-08  3666  		cache = btrfs_lookup_block_group(fs_info, chunk_offset);
ced96edc48ba45 Qu Wenruo      2014-06-19  3667  
ced96edc48ba45 Qu Wenruo      2014-06-19  3668  		/* some chunks are removed but not committed to disk yet,
ced96edc48ba45 Qu Wenruo      2014-06-19  3669  		 * continue scrubbing */
ced96edc48ba45 Qu Wenruo      2014-06-19  3670  		if (!cache)
ced96edc48ba45 Qu Wenruo      2014-06-19  3671  			goto skip;
ced96edc48ba45 Qu Wenruo      2014-06-19  3672  
78ce9fc269af6e Naohiro Aota   2021-02-04  3673  		if (sctx->is_dev_replace && btrfs_is_zoned(fs_info)) {
78ce9fc269af6e Naohiro Aota   2021-02-04  3674  			spin_lock(&cache->lock);
78ce9fc269af6e Naohiro Aota   2021-02-04  3675  			if (!cache->to_copy) {
78ce9fc269af6e Naohiro Aota   2021-02-04  3676  				spin_unlock(&cache->lock);
31f44555b4f734 Filipe Manana  2021-04-14  3677  				btrfs_put_block_group(cache);
31f44555b4f734 Filipe Manana  2021-04-14  3678  				goto skip;
78ce9fc269af6e Naohiro Aota   2021-02-04  3679  			}
78ce9fc269af6e Naohiro Aota   2021-02-04  3680  			spin_unlock(&cache->lock);
78ce9fc269af6e Naohiro Aota   2021-02-04  3681  		}
78ce9fc269af6e Naohiro Aota   2021-02-04  3682  
2473d24f2b77da Filipe Manana  2020-05-08  3683  		/*
2473d24f2b77da Filipe Manana  2020-05-08  3684  		 * Make sure that while we are scrubbing the corresponding block
2473d24f2b77da Filipe Manana  2020-05-08  3685  		 * group doesn't get its logical address and its device extents
2473d24f2b77da Filipe Manana  2020-05-08  3686  		 * reused for another block group, which can possibly be of a
2473d24f2b77da Filipe Manana  2020-05-08  3687  		 * different type and different profile. We do this to prevent
2473d24f2b77da Filipe Manana  2020-05-08  3688  		 * false error detections and crashes due to bogus attempts to
2473d24f2b77da Filipe Manana  2020-05-08  3689  		 * repair extents.
2473d24f2b77da Filipe Manana  2020-05-08  3690  		 */
2473d24f2b77da Filipe Manana  2020-05-08  3691  		spin_lock(&cache->lock);
2473d24f2b77da Filipe Manana  2020-05-08  3692  		if (cache->removed) {
2473d24f2b77da Filipe Manana  2020-05-08  3693  			spin_unlock(&cache->lock);
2473d24f2b77da Filipe Manana  2020-05-08  3694  			btrfs_put_block_group(cache);
2473d24f2b77da Filipe Manana  2020-05-08  3695  			goto skip;
2473d24f2b77da Filipe Manana  2020-05-08  3696  		}
6b7304af62d02d Filipe Manana  2020-05-08  3697  		btrfs_freeze_block_group(cache);
2473d24f2b77da Filipe Manana  2020-05-08  3698  		spin_unlock(&cache->lock);
2473d24f2b77da Filipe Manana  2020-05-08  3699  
55e3a601c81cdc Zhaolei        2015-08-05  3700  		/*
55e3a601c81cdc Zhaolei        2015-08-05  3701  		 * we need call btrfs_inc_block_group_ro() with scrubs_paused,
55e3a601c81cdc Zhaolei        2015-08-05  3702  		 * to avoid deadlock caused by:
55e3a601c81cdc Zhaolei        2015-08-05  3703  		 * btrfs_inc_block_group_ro()
55e3a601c81cdc Zhaolei        2015-08-05  3704  		 * -> btrfs_wait_for_commit()
55e3a601c81cdc Zhaolei        2015-08-05  3705  		 * -> btrfs_commit_transaction()
55e3a601c81cdc Zhaolei        2015-08-05  3706  		 * -> btrfs_scrub_pause()
55e3a601c81cdc Zhaolei        2015-08-05  3707  		 */
55e3a601c81cdc Zhaolei        2015-08-05  3708  		scrub_pause_on(fs_info);
b12de52896c0e8 Qu Wenruo      2019-11-15  3709  
b12de52896c0e8 Qu Wenruo      2019-11-15  3710  		/*
b12de52896c0e8 Qu Wenruo      2019-11-15  3711  		 * Don't do chunk preallocation for scrub.
b12de52896c0e8 Qu Wenruo      2019-11-15  3712  		 *
b12de52896c0e8 Qu Wenruo      2019-11-15  3713  		 * This is especially important for SYSTEM bgs, or we can hit
b12de52896c0e8 Qu Wenruo      2019-11-15  3714  		 * -EFBIG from btrfs_finish_chunk_alloc() like:
b12de52896c0e8 Qu Wenruo      2019-11-15  3715  		 * 1. The only SYSTEM bg is marked RO.
b12de52896c0e8 Qu Wenruo      2019-11-15  3716  		 *    Since SYSTEM bg is small, that's pretty common.
b12de52896c0e8 Qu Wenruo      2019-11-15  3717  		 * 2. New SYSTEM bg will be allocated
b12de52896c0e8 Qu Wenruo      2019-11-15  3718  		 *    Due to regular version will allocate new chunk.
b12de52896c0e8 Qu Wenruo      2019-11-15  3719  		 * 3. New SYSTEM bg is empty and will get cleaned up
b12de52896c0e8 Qu Wenruo      2019-11-15  3720  		 *    Before cleanup really happens, it's marked RO again.
b12de52896c0e8 Qu Wenruo      2019-11-15  3721  		 * 4. Empty SYSTEM bg get scrubbed
b12de52896c0e8 Qu Wenruo      2019-11-15  3722  		 *    We go back to 2.
b12de52896c0e8 Qu Wenruo      2019-11-15  3723  		 *
b12de52896c0e8 Qu Wenruo      2019-11-15  3724  		 * This can easily boost the amount of SYSTEM chunks if cleaner
b12de52896c0e8 Qu Wenruo      2019-11-15  3725  		 * thread can't be triggered fast enough, and use up all space
b12de52896c0e8 Qu Wenruo      2019-11-15  3726  		 * of btrfs_super_block::sys_chunk_array
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3727  		 *
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3728  		 * While for dev replace, we need to try our best to mark block
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3729  		 * group RO, to prevent race between:
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3730  		 * - Write duplication
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3731  		 *   Contains latest data
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3732  		 * - Scrub copy
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3733  		 *   Contains data from commit tree
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3734  		 *
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3735  		 * If target block group is not marked RO, nocow writes can
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3736  		 * be overwritten by scrub copy, causing data corruption.
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3737  		 * So for dev-replace, it's not allowed to continue if a block
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3738  		 * group is not RO.
b12de52896c0e8 Qu Wenruo      2019-11-15  3739  		 */
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3740  		ret = btrfs_inc_block_group_ro(cache, sctx->is_dev_replace);
de17addce7a20d Naohiro Aota   2021-02-04  3741  		if (!ret && sctx->is_dev_replace) {
de17addce7a20d Naohiro Aota   2021-02-04  3742  			ret = finish_extent_writes_for_zoned(root, cache);
de17addce7a20d Naohiro Aota   2021-02-04  3743  			if (ret) {
de17addce7a20d Naohiro Aota   2021-02-04  3744  				btrfs_dec_block_group_ro(cache);
de17addce7a20d Naohiro Aota   2021-02-04  3745  				scrub_pause_off(fs_info);
de17addce7a20d Naohiro Aota   2021-02-04  3746  				btrfs_put_block_group(cache);
de17addce7a20d Naohiro Aota   2021-02-04  3747  				break;
de17addce7a20d Naohiro Aota   2021-02-04  3748  			}
de17addce7a20d Naohiro Aota   2021-02-04  3749  		}
de17addce7a20d Naohiro Aota   2021-02-04  3750  
76a8efa171bf6c Zhaolei        2015-11-17  3751  		if (ret == 0) {
76a8efa171bf6c Zhaolei        2015-11-17  3752  			ro_set = 1;
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3753  		} else if (ret == -ENOSPC && !sctx->is_dev_replace) {
76a8efa171bf6c Zhaolei        2015-11-17  3754  			/*
76a8efa171bf6c Zhaolei        2015-11-17  3755  			 * btrfs_inc_block_group_ro return -ENOSPC when it
76a8efa171bf6c Zhaolei        2015-11-17  3756  			 * failed in creating new chunk for metadata.
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3757  			 * It is not a problem for scrub, because
76a8efa171bf6c Zhaolei        2015-11-17  3758  			 * metadata are always cowed, and our scrub paused
76a8efa171bf6c Zhaolei        2015-11-17  3759  			 * commit_transactions.
76a8efa171bf6c Zhaolei        2015-11-17  3760  			 */
76a8efa171bf6c Zhaolei        2015-11-17  3761  			ro_set = 0;
195a49eaf655eb Filipe Manana  2021-02-05  3762  		} else if (ret == -ETXTBSY) {
195a49eaf655eb Filipe Manana  2021-02-05  3763  			btrfs_warn(fs_info,
195a49eaf655eb Filipe Manana  2021-02-05  3764  		   "skipping scrub of block group %llu due to active swapfile",
195a49eaf655eb Filipe Manana  2021-02-05  3765  				   cache->start);
195a49eaf655eb Filipe Manana  2021-02-05  3766  			scrub_pause_off(fs_info);
195a49eaf655eb Filipe Manana  2021-02-05  3767  			ret = 0;
195a49eaf655eb Filipe Manana  2021-02-05  3768  			goto skip_unfreeze;
76a8efa171bf6c Zhaolei        2015-11-17  3769  		} else {
5d163e0e68ce74 Jeff Mahoney   2016-09-20  3770  			btrfs_warn(fs_info,
913e153572218c David Sterba   2017-07-13  3771  				   "failed setting block group ro: %d", ret);
6b7304af62d02d Filipe Manana  2020-05-08  3772  			btrfs_unfreeze_block_group(cache);
55e3a601c81cdc Zhaolei        2015-08-05  3773  			btrfs_put_block_group(cache);
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3774  			scrub_pause_off(fs_info);
55e3a601c81cdc Zhaolei        2015-08-05  3775  			break;
55e3a601c81cdc Zhaolei        2015-08-05  3776  		}
55e3a601c81cdc Zhaolei        2015-08-05  3777  
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3778  		/*
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3779  		 * Now the target block is marked RO, wait for nocow writes to
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3780  		 * finish before dev-replace.
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3781  		 * COW is fine, as COW never overwrites extents in commit tree.
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3782  		 */
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3783  		if (sctx->is_dev_replace) {
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3784  			btrfs_wait_nocow_writers(cache);
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3785  			btrfs_wait_ordered_roots(fs_info, U64_MAX, cache->start,
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3786  					cache->length);
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3787  		}
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3788  
1bbb97b8ce7ddf Qu Wenruo      2020-01-24  3789  		scrub_pause_off(fs_info);
3ec17a67cc340b Dan Carpenter  2019-10-31  3790  		down_write(&dev_replace->rwsem);
ff023aac31198e Stefan Behrens 2012-11-06  3791  		dev_replace->cursor_right = found_key.offset + length;
ff023aac31198e Stefan Behrens 2012-11-06  3792  		dev_replace->cursor_left = found_key.offset;
ff023aac31198e Stefan Behrens 2012-11-06  3793  		dev_replace->item_needs_writeback = 1;
cb5583dd52fab4 David Sterba   2018-09-07  3794  		up_write(&dev_replace->rwsem);
cb5583dd52fab4 David Sterba   2018-09-07  3795  
8c204c9657c32e Zhao Lei       2015-08-19  3796  		ret = scrub_chunk(sctx, scrub_dev, chunk_offset, length,
32934280967d00 Omar Sandoval  2018-08-14  3797  				  found_key.offset, cache);
ff023aac31198e Stefan Behrens 2012-11-06  3798  
ff023aac31198e Stefan Behrens 2012-11-06  3799  		/*
ff023aac31198e Stefan Behrens 2012-11-06  3800  		 * flush, submit all pending read and write bios, afterwards
ff023aac31198e Stefan Behrens 2012-11-06  3801  		 * wait for them.
ff023aac31198e Stefan Behrens 2012-11-06  3802  		 * Note that in the dev replace case, a read request causes
ff023aac31198e Stefan Behrens 2012-11-06  3803  		 * write requests that are submitted in the read completion
ff023aac31198e Stefan Behrens 2012-11-06  3804  		 * worker. Therefore in the current situation, it is required
ff023aac31198e Stefan Behrens 2012-11-06  3805  		 * that all write requests are flushed, so that all read and
ff023aac31198e Stefan Behrens 2012-11-06  3806  		 * write requests are really completed when bios_in_flight
ff023aac31198e Stefan Behrens 2012-11-06  3807  		 * changes to 0.
ff023aac31198e Stefan Behrens 2012-11-06  3808  		 */
2073c4c2e51a93 David Sterba   2017-03-31  3809  		sctx->flush_all_writes = true;
ff023aac31198e Stefan Behrens 2012-11-06  3810  		scrub_submit(sctx);
3fb99303c64e31 David Sterba   2017-05-16  3811  		mutex_lock(&sctx->wr_lock);
ff023aac31198e Stefan Behrens 2012-11-06  3812  		scrub_wr_submit(sctx);
3fb99303c64e31 David Sterba   2017-05-16  3813  		mutex_unlock(&sctx->wr_lock);
ff023aac31198e Stefan Behrens 2012-11-06  3814  
ff023aac31198e Stefan Behrens 2012-11-06  3815  		wait_event(sctx->list_wait,
ff023aac31198e Stefan Behrens 2012-11-06  3816  			   atomic_read(&sctx->bios_in_flight) == 0);
b708ce969af3ce Zhaolei        2015-08-05  3817  
b708ce969af3ce Zhaolei        2015-08-05  3818  		scrub_pause_on(fs_info);
12cf93728dfba2 Wang Shilong   2014-02-19  3819  
12cf93728dfba2 Wang Shilong   2014-02-19  3820  		/*
12cf93728dfba2 Wang Shilong   2014-02-19  3821  		 * must be called before we decrease @scrub_paused.
12cf93728dfba2 Wang Shilong   2014-02-19  3822  		 * make sure we don't block transaction commit while
12cf93728dfba2 Wang Shilong   2014-02-19  3823  		 * we are waiting pending workers finished.
12cf93728dfba2 Wang Shilong   2014-02-19  3824  		 */
ff023aac31198e Stefan Behrens 2012-11-06  3825  		wait_event(sctx->list_wait,
ff023aac31198e Stefan Behrens 2012-11-06  3826  			   atomic_read(&sctx->workers_pending) == 0);
2073c4c2e51a93 David Sterba   2017-03-31  3827  		sctx->flush_all_writes = false;
12cf93728dfba2 Wang Shilong   2014-02-19  3828  
b708ce969af3ce Zhaolei        2015-08-05  3829  		scrub_pause_off(fs_info);
ff023aac31198e Stefan Behrens 2012-11-06  3830  
78ce9fc269af6e Naohiro Aota   2021-02-04  3831  		if (sctx->is_dev_replace &&
78ce9fc269af6e Naohiro Aota   2021-02-04  3832  		    !btrfs_finish_block_group_to_copy(dev_replace->srcdev,
78ce9fc269af6e Naohiro Aota   2021-02-04  3833  						      cache, found_key.offset))
78ce9fc269af6e Naohiro Aota   2021-02-04  3834  			ro_set = 0;
78ce9fc269af6e Naohiro Aota   2021-02-04  3835  
78ce9fc269af6e Naohiro Aota   2021-02-04 @3836  done:
3ec17a67cc340b Dan Carpenter  2019-10-31  3837  		down_write(&dev_replace->rwsem);
1a1a8b732c7e95 Filipe Manana  2016-05-14  3838  		dev_replace->cursor_left = dev_replace->cursor_right;
1a1a8b732c7e95 Filipe Manana  2016-05-14  3839  		dev_replace->item_needs_writeback = 1;
3ec17a67cc340b Dan Carpenter  2019-10-31  3840  		up_write(&dev_replace->rwsem);
1a1a8b732c7e95 Filipe Manana  2016-05-14  3841  
76a8efa171bf6c Zhaolei        2015-11-17  3842  		if (ro_set)
2ff7e61e0d30ff Jeff Mahoney   2016-06-22  3843  			btrfs_dec_block_group_ro(cache);
ff023aac31198e Stefan Behrens 2012-11-06  3844  
758f2dfcf8a249 Filipe Manana  2015-11-19  3845  		/*
758f2dfcf8a249 Filipe Manana  2015-11-19  3846  		 * We might have prevented the cleaner kthread from deleting
758f2dfcf8a249 Filipe Manana  2015-11-19  3847  		 * this block group if it was already unused because we raced
758f2dfcf8a249 Filipe Manana  2015-11-19  3848  		 * and set it to RO mode first. So add it back to the unused
758f2dfcf8a249 Filipe Manana  2015-11-19  3849  		 * list, otherwise it might not ever be deleted unless a manual
758f2dfcf8a249 Filipe Manana  2015-11-19  3850  		 * balance is triggered or it becomes used and unused again.
758f2dfcf8a249 Filipe Manana  2015-11-19  3851  		 */
758f2dfcf8a249 Filipe Manana  2015-11-19  3852  		spin_lock(&cache->lock);
758f2dfcf8a249 Filipe Manana  2015-11-19  3853  		if (!cache->removed && !cache->ro && cache->reserved == 0 &&
bf38be65f3703d David Sterba   2019-10-23  3854  		    cache->used == 0) {
758f2dfcf8a249 Filipe Manana  2015-11-19  3855  			spin_unlock(&cache->lock);
6e80d4f8c422d3 Dennis Zhou    2019-12-13  3856  			if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
6e80d4f8c422d3 Dennis Zhou    2019-12-13  3857  				btrfs_discard_queue_work(&fs_info->discard_ctl,
6e80d4f8c422d3 Dennis Zhou    2019-12-13  3858  							 cache);
6e80d4f8c422d3 Dennis Zhou    2019-12-13  3859  			else
031f24da2c8a7b Qu Wenruo      2018-05-22  3860  				btrfs_mark_bg_unused(cache);
758f2dfcf8a249 Filipe Manana  2015-11-19  3861  		} else {
758f2dfcf8a249 Filipe Manana  2015-11-19  3862  			spin_unlock(&cache->lock);
758f2dfcf8a249 Filipe Manana  2015-11-19  3863  		}
195a49eaf655eb Filipe Manana  2021-02-05  3864  skip_unfreeze:
6b7304af62d02d Filipe Manana  2020-05-08  3865  		btrfs_unfreeze_block_group(cache);
a2de733c78fa7a Arne Jansen    2011-03-08  3866  		btrfs_put_block_group(cache);
a2de733c78fa7a Arne Jansen    2011-03-08  3867  		if (ret)
a2de733c78fa7a Arne Jansen    2011-03-08  3868  			break;
32934280967d00 Omar Sandoval  2018-08-14  3869  		if (sctx->is_dev_replace &&
af1be4f851db4f Stefan Behrens 2012-11-27  3870  		    atomic64_read(&dev_replace->num_write_errors) > 0) {
ff023aac31198e Stefan Behrens 2012-11-06  3871  			ret = -EIO;
ff023aac31198e Stefan Behrens 2012-11-06  3872  			break;
ff023aac31198e Stefan Behrens 2012-11-06  3873  		}
ff023aac31198e Stefan Behrens 2012-11-06  3874  		if (sctx->stat.malloc_errors > 0) {
ff023aac31198e Stefan Behrens 2012-11-06  3875  			ret = -ENOMEM;
ff023aac31198e Stefan Behrens 2012-11-06  3876  			break;
ff023aac31198e Stefan Behrens 2012-11-06  3877  		}
ced96edc48ba45 Qu Wenruo      2014-06-19  3878  skip:
a2de733c78fa7a Arne Jansen    2011-03-08  3879  		key.offset = found_key.offset + length;
712673339a0d08 Chris Mason    2011-05-23  3880  		btrfs_release_path(path);
a2de733c78fa7a Arne Jansen    2011-03-08  3881  	}
a2de733c78fa7a Arne Jansen    2011-03-08  3882  
a2de733c78fa7a Arne Jansen    2011-03-08  3883  	btrfs_free_path(path);
8c51032f978bac Arne Jansen    2011-06-03  3884  
55e3a601c81cdc Zhaolei        2015-08-05  3885  	return ret;
a2de733c78fa7a Arne Jansen    2011-03-08  3886  }
a2de733c78fa7a Arne Jansen    2011-03-08  3887  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--WIyZ46R2i8wDzkSu
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--WIyZ46R2i8wDzkSu--
