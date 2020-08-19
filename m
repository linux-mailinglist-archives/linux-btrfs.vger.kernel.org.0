Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4982498A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 10:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgHSIwX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 04:52:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:43292 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgHSIvn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 04:51:43 -0400
IronPort-SDR: Tgn0sNsj7i5s9fOArRm/+upzJGJf1fxDMb9I9oGqUNNv/cPhxvAOBfcYkhpETPZSwxoja5D+nN
 CdEHLMgVEQqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="152487595"
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="gz'50?scan'50,208,50";a="152487595"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 01:50:38 -0700
IronPort-SDR: jF7lTJO4Q/nTk+L/lihr/BOGAxwsECtl2uYWIVGFfXQNjik97w+4qzOAk//uk5mjsL3QM3nTY8
 4eGcJ4ih3FGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="gz'50?scan'50,208,50";a="320405792"
Received: from lkp-server01.sh.intel.com (HELO 4cedd236b688) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2020 01:50:36 -0700
Received: from kbuild by 4cedd236b688 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k8Jnn-0000ER-L0; Wed, 19 Aug 2020 08:50:35 +0000
Date:   Wed, 19 Aug 2020 16:50:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] btrfs: switch btrfs_buffered_write() to page-by-page pace
Message-ID: <202008191637.x1mcAqHY%lkp@intel.com>
References: <20200819055344.50784-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20200819055344.50784-1-wqu@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Qu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on v5.9-rc1 next-20200819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Qu-Wenruo/btrfs-switch-btrfs_buffered_write-to-page-by-page-pace/20200819-135541
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: arm-randconfig-r022-20200818 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project b34b1e38381fa4d1b1d9751a6b5233b68e734cfe)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/btrfs/file.c:19:
   fs/btrfs/ctree.h:2265:8: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
   size_t __const btrfs_get_num_csums(void);
          ^~~~~~~~
>> fs/btrfs/file.c:1570:24: warning: comparison of distinct pointer types ('typeof (iov_iter_count(i)) *' (aka 'unsigned int *') and 'typeof (((1UL) << 12) - offset) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
                   size_t write_bytes = min(iov_iter_count(i),
                                        ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:884:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:875:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:865:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:851:29: note: expanded from macro '__typecheck'
                   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                              ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   2 warnings generated.

# https://github.com/0day-ci/linux/commit/89f414f96d87eab3a1c3a3afc5283f80154e7a8b
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review Qu-Wenruo/btrfs-switch-btrfs_buffered_write-to-page-by-page-pace/20200819-135541
git checkout 89f414f96d87eab3a1c3a3afc5283f80154e7a8b
vim +1570 fs/btrfs/file.c

89f414f96d87ea Qu Wenruo          2020-08-19  1550  
e4af400a9c5081 Goldwyn Rodrigues  2018-06-17  1551  static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
e4af400a9c5081 Goldwyn Rodrigues  2018-06-17  1552  					       struct iov_iter *i)
39279cc3d2704c Chris Mason        2007-06-12  1553  {
e4af400a9c5081 Goldwyn Rodrigues  2018-06-17  1554  	struct file *file = iocb->ki_filp;
e4af400a9c5081 Goldwyn Rodrigues  2018-06-17  1555  	loff_t pos = iocb->ki_pos;
496ad9aa8ef448 Al Viro            2013-01-23  1556  	struct inode *inode = file_inode(file);
0b246afa62b0cf Jeff Mahoney       2016-06-22  1557  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
89f414f96d87ea Qu Wenruo          2020-08-19  1558  	struct page *page = NULL;
364ecf3651e086 Qu Wenruo          2017-02-27  1559  	struct extent_changeset *data_reserved = NULL;
376cc685cb3b43 Miao Xie           2013-12-10  1560  	u64 lockstart;
376cc685cb3b43 Miao Xie           2013-12-10  1561  	u64 lockend;
d0215f3e5ebb58 Josef Bacik        2011-01-25  1562  	size_t num_written = 0;
c9149235a42ab9 Tsutomu Itoh       2011-03-30  1563  	int ret = 0;
7ee9e4405f264e Josef Bacik        2013-06-21  1564  	bool only_release_metadata = false;
b6316429af7f36 Josef Bacik        2011-09-30  1565  	bool force_page_uptodate = false;
4b46fce23349bf Josef Bacik        2010-05-23  1566  
d0215f3e5ebb58 Josef Bacik        2011-01-25  1567  	while (iov_iter_count(i) > 0) {
c67d970f0ea8dc Filipe Manana      2019-09-30  1568  		struct extent_state *cached_state = NULL;
7073017aeb98db Johannes Thumshirn 2018-12-05  1569  		size_t offset = offset_in_page(pos);
d0215f3e5ebb58 Josef Bacik        2011-01-25 @1570  		size_t write_bytes = min(iov_iter_count(i),
89f414f96d87ea Qu Wenruo          2020-08-19  1571  					 PAGE_SIZE - offset);
89f414f96d87ea Qu Wenruo          2020-08-19  1572  		size_t reserve_bytes = PAGE_SIZE;
d0215f3e5ebb58 Josef Bacik        2011-01-25  1573  		size_t copied;
79f015f216539d Goldwyn Rodrigues  2017-10-16  1574  		int extents_locked;
39279cc3d2704c Chris Mason        2007-06-12  1575  
914ee295af418e Xin Zhong          2010-12-09  1576  		/*
89f414f96d87ea Qu Wenruo          2020-08-19  1577  		 * Fault pages before locking them in prepare_page()
914ee295af418e Xin Zhong          2010-12-09  1578  		 * to avoid recursive lock
914ee295af418e Xin Zhong          2010-12-09  1579  		 */
d0215f3e5ebb58 Josef Bacik        2011-01-25  1580  		if (unlikely(iov_iter_fault_in_readable(i, write_bytes))) {
914ee295af418e Xin Zhong          2010-12-09  1581  			ret = -EFAULT;
d0215f3e5ebb58 Josef Bacik        2011-01-25  1582  			break;
914ee295af418e Xin Zhong          2010-12-09  1583  		}
914ee295af418e Xin Zhong          2010-12-09  1584  
a0e248bb502d51 Filipe Manana      2019-10-11  1585  		only_release_metadata = false;
d9d8b2a51a404c Qu Wenruo          2015-09-08  1586  
364ecf3651e086 Qu Wenruo          2017-02-27  1587  		extent_changeset_release(data_reserved);
36ea6f3e931391 Nikolay Borisov    2020-06-03  1588  		ret = btrfs_check_data_free_space(BTRFS_I(inode),
36ea6f3e931391 Nikolay Borisov    2020-06-03  1589  						  &data_reserved, pos,
364ecf3651e086 Qu Wenruo          2017-02-27  1590  						  write_bytes);
c6887cd11149d7 Josef Bacik        2016-03-25  1591  		if (ret < 0) {
89f414f96d87ea Qu Wenruo          2020-08-19  1592  			size_t tmp = write_bytes;
38d37aa9c32938 Qu Wenruo          2020-06-24  1593  			if (btrfs_check_nocow_lock(BTRFS_I(inode), pos,
89f414f96d87ea Qu Wenruo          2020-08-19  1594  						   &tmp) > 0) {
89f414f96d87ea Qu Wenruo          2020-08-19  1595  				ASSERT(tmp == write_bytes);
d9d8b2a51a404c Qu Wenruo          2015-09-08  1596  				/*
d9d8b2a51a404c Qu Wenruo          2015-09-08  1597  				 * For nodata cow case, no need to reserve
d9d8b2a51a404c Qu Wenruo          2015-09-08  1598  				 * data space.
d9d8b2a51a404c Qu Wenruo          2015-09-08  1599  				 */
7ee9e4405f264e Josef Bacik        2013-06-21  1600  				only_release_metadata = true;
89f414f96d87ea Qu Wenruo          2020-08-19  1601  				reserve_bytes = 0;
c6887cd11149d7 Josef Bacik        2016-03-25  1602  			} else {
d0215f3e5ebb58 Josef Bacik        2011-01-25  1603  				break;
c6887cd11149d7 Josef Bacik        2016-03-25  1604  			}
c6887cd11149d7 Josef Bacik        2016-03-25  1605  		}
1832a6d5ee3b1a Chris Mason        2007-12-21  1606  
9f3db423f98c5c Nikolay Borisov    2017-02-20  1607  		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
9f3db423f98c5c Nikolay Borisov    2017-02-20  1608  				reserve_bytes);
7ee9e4405f264e Josef Bacik        2013-06-21  1609  		if (ret) {
7ee9e4405f264e Josef Bacik        2013-06-21  1610  			if (!only_release_metadata)
25ce28caaa1ddc Nikolay Borisov    2020-06-03  1611  				btrfs_free_reserved_data_space(BTRFS_I(inode),
bc42bda22345ef Qu Wenruo          2017-02-27  1612  						data_reserved, pos,
d9d8b2a51a404c Qu Wenruo          2015-09-08  1613  						write_bytes);
8257b2dc3c1a10 Miao Xie           2014-03-06  1614  			else
38d37aa9c32938 Qu Wenruo          2020-06-24  1615  				btrfs_check_nocow_unlock(BTRFS_I(inode));
7ee9e4405f264e Josef Bacik        2013-06-21  1616  			break;
7ee9e4405f264e Josef Bacik        2013-06-21  1617  		}
7ee9e4405f264e Josef Bacik        2013-06-21  1618  
376cc685cb3b43 Miao Xie           2013-12-10  1619  again:
89f414f96d87ea Qu Wenruo          2020-08-19  1620  		ret = prepare_one_page(inode, &page, pos, write_bytes,
b6316429af7f36 Josef Bacik        2011-09-30  1621  				       force_page_uptodate);
8b62f87bad9cf0 Josef Bacik        2017-10-19  1622  		if (ret) {
8b62f87bad9cf0 Josef Bacik        2017-10-19  1623  			btrfs_delalloc_release_extents(BTRFS_I(inode),
8702ba9396bf7b Qu Wenruo          2019-10-14  1624  						       reserve_bytes);
d0215f3e5ebb58 Josef Bacik        2011-01-25  1625  			break;
8b62f87bad9cf0 Josef Bacik        2017-10-19  1626  		}
39279cc3d2704c Chris Mason        2007-06-12  1627  
79f015f216539d Goldwyn Rodrigues  2017-10-16  1628  		extents_locked = lock_and_cleanup_extent_if_need(
89f414f96d87ea Qu Wenruo          2020-08-19  1629  				BTRFS_I(inode), &page, 1, pos, write_bytes,
89f414f96d87ea Qu Wenruo          2020-08-19  1630  				&lockstart, &lockend, &cached_state);
79f015f216539d Goldwyn Rodrigues  2017-10-16  1631  		if (extents_locked < 0) {
79f015f216539d Goldwyn Rodrigues  2017-10-16  1632  			if (extents_locked == -EAGAIN)
376cc685cb3b43 Miao Xie           2013-12-10  1633  				goto again;
8b62f87bad9cf0 Josef Bacik        2017-10-19  1634  			btrfs_delalloc_release_extents(BTRFS_I(inode),
8702ba9396bf7b Qu Wenruo          2019-10-14  1635  						       reserve_bytes);
79f015f216539d Goldwyn Rodrigues  2017-10-16  1636  			ret = extents_locked;
376cc685cb3b43 Miao Xie           2013-12-10  1637  			break;
376cc685cb3b43 Miao Xie           2013-12-10  1638  		}
376cc685cb3b43 Miao Xie           2013-12-10  1639  
89f414f96d87ea Qu Wenruo          2020-08-19  1640  		copied = iov_iter_copy_from_user_atomic(page, i, offset,
89f414f96d87ea Qu Wenruo          2020-08-19  1641  							write_bytes);
89f414f96d87ea Qu Wenruo          2020-08-19  1642  		flush_dcache_page(page);
56244ef151c3cd Chris Mason        2016-05-16  1643  
89f414f96d87ea Qu Wenruo          2020-08-19  1644  		if (!PageUptodate(page) && copied < write_bytes) {
b1bf862e9dad43 Chris Mason        2011-02-28  1645  			/*
89f414f96d87ea Qu Wenruo          2020-08-19  1646  			 * Short write on non-uptodate page, we must retry and
89f414f96d87ea Qu Wenruo          2020-08-19  1647  			 * force the page uptodate in next run.
b1bf862e9dad43 Chris Mason        2011-02-28  1648  			 */
89f414f96d87ea Qu Wenruo          2020-08-19  1649  			copied = 0;
b6316429af7f36 Josef Bacik        2011-09-30  1650  			force_page_uptodate = true;
b6316429af7f36 Josef Bacik        2011-09-30  1651  		} else {
89f414f96d87ea Qu Wenruo          2020-08-19  1652  			/* Next run doesn't need forced uptodate */
b6316429af7f36 Josef Bacik        2011-09-30  1653  			force_page_uptodate = false;
b6316429af7f36 Josef Bacik        2011-09-30  1654  		}
914ee295af418e Xin Zhong          2010-12-09  1655  
89f414f96d87ea Qu Wenruo          2020-08-19  1656  		iov_iter_advance(i, copied);
485290a734f142 Qu Wenruo          2015-10-29  1657  
89f414f96d87ea Qu Wenruo          2020-08-19  1658  		if (copied > 0) {
89f414f96d87ea Qu Wenruo          2020-08-19  1659  			ret = btrfs_dirty_pages(BTRFS_I(inode), &page, 1, pos,
89f414f96d87ea Qu Wenruo          2020-08-19  1660  						copied, &cached_state);
89f414f96d87ea Qu Wenruo          2020-08-19  1661  		} else {
89f414f96d87ea Qu Wenruo          2020-08-19  1662  			/* No bytes copied, need to free reserved space */
89f414f96d87ea Qu Wenruo          2020-08-19  1663  			if (only_release_metadata)
89f414f96d87ea Qu Wenruo          2020-08-19  1664  				btrfs_delalloc_release_metadata(BTRFS_I(inode),
89f414f96d87ea Qu Wenruo          2020-08-19  1665  						reserve_bytes, true);
89f414f96d87ea Qu Wenruo          2020-08-19  1666  			else
86d52921a2ba51 Nikolay Borisov    2020-06-03  1667  				btrfs_delalloc_release_space(BTRFS_I(inode),
89f414f96d87ea Qu Wenruo          2020-08-19  1668  						data_reserved, pos, write_bytes,
89f414f96d87ea Qu Wenruo          2020-08-19  1669  						true);
485290a734f142 Qu Wenruo          2015-10-29  1670  		}
914ee295af418e Xin Zhong          2010-12-09  1671  
c67d970f0ea8dc Filipe Manana      2019-09-30  1672  		/*
c67d970f0ea8dc Filipe Manana      2019-09-30  1673  		 * If we have not locked the extent range, because the range's
c67d970f0ea8dc Filipe Manana      2019-09-30  1674  		 * start offset is >= i_size, we might still have a non-NULL
c67d970f0ea8dc Filipe Manana      2019-09-30  1675  		 * cached extent state, acquired while marking the extent range
c67d970f0ea8dc Filipe Manana      2019-09-30  1676  		 * as delalloc through btrfs_dirty_pages(). Therefore free any
c67d970f0ea8dc Filipe Manana      2019-09-30  1677  		 * possible cached extent state to avoid a memory leak.
c67d970f0ea8dc Filipe Manana      2019-09-30  1678  		 */
79f015f216539d Goldwyn Rodrigues  2017-10-16  1679  		if (extents_locked)
376cc685cb3b43 Miao Xie           2013-12-10  1680  			unlock_extent_cached(&BTRFS_I(inode)->io_tree,
e43bbe5e16d87b David Sterba       2017-12-12  1681  					     lockstart, lockend, &cached_state);
c67d970f0ea8dc Filipe Manana      2019-09-30  1682  		else
c67d970f0ea8dc Filipe Manana      2019-09-30  1683  			free_extent_state(cached_state);
c67d970f0ea8dc Filipe Manana      2019-09-30  1684  
8702ba9396bf7b Qu Wenruo          2019-10-14  1685  		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
f1de968376340c Miao Xie           2014-01-09  1686  		if (ret) {
89f414f96d87ea Qu Wenruo          2020-08-19  1687  			btrfs_drop_pages(&page, 1);
d0215f3e5ebb58 Josef Bacik        2011-01-25  1688  			break;
f1de968376340c Miao Xie           2014-01-09  1689  		}
39279cc3d2704c Chris Mason        2007-06-12  1690  
89f414f96d87ea Qu Wenruo          2020-08-19  1691  		if (only_release_metadata) {
38d37aa9c32938 Qu Wenruo          2020-06-24  1692  			btrfs_check_nocow_unlock(BTRFS_I(inode));
da17066c40472c Jeff Mahoney       2016-06-15  1693  			lockstart = round_down(pos,
0b246afa62b0cf Jeff Mahoney       2016-06-22  1694  					       fs_info->sectorsize);
89f414f96d87ea Qu Wenruo          2020-08-19  1695  			lockend = lockstart + PAGE_SIZE - 1;
7ee9e4405f264e Josef Bacik        2013-06-21  1696  
7ee9e4405f264e Josef Bacik        2013-06-21  1697  			set_extent_bit(&BTRFS_I(inode)->io_tree, lockstart,
7ee9e4405f264e Josef Bacik        2013-06-21  1698  				       lockend, EXTENT_NORESERVE, NULL,
7ee9e4405f264e Josef Bacik        2013-06-21  1699  				       NULL, GFP_NOFS);
7ee9e4405f264e Josef Bacik        2013-06-21  1700  		}
7ee9e4405f264e Josef Bacik        2013-06-21  1701  
89f414f96d87ea Qu Wenruo          2020-08-19  1702  		btrfs_drop_pages(&page, 1);
f1de968376340c Miao Xie           2014-01-09  1703  
d0215f3e5ebb58 Josef Bacik        2011-01-25  1704  		cond_resched();
d0215f3e5ebb58 Josef Bacik        2011-01-25  1705  
d0e1d66b5aa1ec Namjae Jeon        2012-12-11  1706  		balance_dirty_pages_ratelimited(inode->i_mapping);
cb843a6f513a1a Chris Mason        2008-10-03  1707  
914ee295af418e Xin Zhong          2010-12-09  1708  		pos += copied;
914ee295af418e Xin Zhong          2010-12-09  1709  		num_written += copied;
d0215f3e5ebb58 Josef Bacik        2011-01-25  1710  	}
39279cc3d2704c Chris Mason        2007-06-12  1711  
364ecf3651e086 Qu Wenruo          2017-02-27  1712  	extent_changeset_free(data_reserved);
d0215f3e5ebb58 Josef Bacik        2011-01-25  1713  	return num_written ? num_written : ret;
39279cc3d2704c Chris Mason        2007-06-12  1714  }
d0215f3e5ebb58 Josef Bacik        2011-01-25  1715  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--jRHKVT23PllUwdXP
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
vU7JYhxe17GFn+bA+0W/E/0fEJe6v6HZAQA=

--jRHKVT23PllUwdXP--
