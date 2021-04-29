Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1512436EB32
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 15:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhD2NQX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 09:16:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49058 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhD2NQW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 09:16:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TDDqck106537;
        Thu, 29 Apr 2021 13:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=uxFwOSLBj+uPtoKwuS/JXoaGlb+M4znvdUoinrxs3xY=;
 b=M/uIsC/2PSL35p9PgpE+H3tHplChueUuMQZLEzDevUaNCoCMziLr5wgxI4RLP3B6CNhU
 QUEG1x/wOnwDNq5bpx7fb60jKJBos378n68YmLXgu1RXn5dS4zuqBxYOwAY2/P0dUuuc
 9rZtNo+lmbfN1n8svWgNJKI6uMpjrmOJDPLbYvjFo6g6FYuyJuId91xXkMHq3EgWoush
 DMxXkqzX9Vi9kEIz4dyTeFQWoTtQfaTSo5fc0n5KAmicseCwAjNdKK7A5j1AAhxDvA2f
 0f23jlTjTBCH7Q6iJQ91IFveryOFDw1eSJm/CeParM5VZ97KcTJj/mE12+sFTP4QRt3m XA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 385ahbvb19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 13:15:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TDA2Wr078574;
        Thu, 29 Apr 2021 13:15:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 384b5a9rpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 13:15:18 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13TDBwuM091276;
        Thu, 29 Apr 2021 13:15:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 384b5a9rp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 13:15:17 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13TDFFqJ003733;
        Thu, 29 Apr 2021 13:15:15 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Apr 2021 06:15:14 -0700
Date:   Thu, 29 Apr 2021 16:15:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Tian Tao <tiantao6@hisilicon.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-btrfs@vger.kernel.org, Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH] btrfs: delete unneeded assignments in btrfs_defrag_file
Message-ID: <202104271518.USQaHfwx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619488221-29490-1-git-send-email-tiantao6@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: L3qAucWbyFFWTDrKNUz1Epgr0n4nz6ui
X-Proofpoint-ORIG-GUID: L3qAucWbyFFWTDrKNUz1Epgr0n4nz6ui
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290091
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi Tian,

url:    https://github.com/0day-ci/linux/commits/Tian-Tao/btrfs-delete-unneeded-assignments-in-btrfs_defrag_file/20210427-095112
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: um-randconfig-m031-20210426 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/btrfs/ioctl.c:1700 btrfs_defrag_file() error: uninitialized symbol 'ret'.

vim +/ret +1700 fs/btrfs/ioctl.c

4cb5300bc839b8a Chris Mason               2011-05-24  1495  int btrfs_defrag_file(struct inode *inode, struct file *file,
4cb5300bc839b8a Chris Mason               2011-05-24  1496  		      struct btrfs_ioctl_defrag_range_args *range,
4cb5300bc839b8a Chris Mason               2011-05-24  1497  		      u64 newer_than, unsigned long max_to_defrag)
4cb5300bc839b8a Chris Mason               2011-05-24  1498  {
0b246afa62b0cf5 Jeff Mahoney              2016-06-22  1499  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
4cb5300bc839b8a Chris Mason               2011-05-24  1500  	struct btrfs_root *root = BTRFS_I(inode)->root;
4cb5300bc839b8a Chris Mason               2011-05-24  1501  	struct file_ra_state *ra = NULL;
f46b5a66b3316ef Christoph Hellwig         2008-06-11  1502  	unsigned long last_index;
151a31b25e5c941 Li Zefan                  2011-09-02  1503  	u64 isize = i_size_read(inode);
940100a4a7b78b2 Chris Mason               2010-03-10  1504  	u64 last_len = 0;
940100a4a7b78b2 Chris Mason               2010-03-10  1505  	u64 skip = 0;
940100a4a7b78b2 Chris Mason               2010-03-10  1506  	u64 defrag_end = 0;
4cb5300bc839b8a Chris Mason               2011-05-24  1507  	u64 newer_off = range->start;
f46b5a66b3316ef Christoph Hellwig         2008-06-11  1508  	unsigned long i;
008873eafbc77de Li Zefan                  2011-09-02  1509  	unsigned long ra_index = 0;
f46b5a66b3316ef Christoph Hellwig         2008-06-11  1510  	int ret;
                                                                ^^^^^^^^

4cb5300bc839b8a Chris Mason               2011-05-24  1511  	int defrag_count = 0;
1a419d85a76853d Li Zefan                  2010-10-25  1512  	int compress_type = BTRFS_COMPRESS_ZLIB;
aab110abcbbf06b David Sterba              2014-07-29  1513  	u32 extent_thresh = range->extent_thresh;
09cbfeaf1a5a67b Kirill A. Shutemov        2016-04-01  1514  	unsigned long max_cluster = SZ_256K >> PAGE_SHIFT;
c41570c9d29764f Justin Maggard            2014-01-21  1515  	unsigned long cluster = max_cluster;
ee22184b53c823f Byongho Lee               2015-12-15  1516  	u64 new_align = ~((u64)SZ_128K - 1);
4cb5300bc839b8a Chris Mason               2011-05-24  1517  	struct page **pages = NULL;
1e2ef46d89ee41c David Sterba              2017-07-17  1518  	bool do_compress = range->flags & BTRFS_DEFRAG_RANGE_COMPRESS;
4cb5300bc839b8a Chris Mason               2011-05-24  1519  
0abd5b17249ea5c Liu Bo                    2013-04-16  1520  	if (isize == 0)
0abd5b17249ea5c Liu Bo                    2013-04-16  1521  		return 0;
0abd5b17249ea5c Liu Bo                    2013-04-16  1522  
0abd5b17249ea5c Liu Bo                    2013-04-16  1523  	if (range->start >= isize)
0abd5b17249ea5c Liu Bo                    2013-04-16  1524  		return -EINVAL;
1a419d85a76853d Li Zefan                  2010-10-25  1525  
1e2ef46d89ee41c David Sterba              2017-07-17  1526  	if (do_compress) {
ce96b7ffd11e261 Chengguang Xu             2019-10-10  1527  		if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
1a419d85a76853d Li Zefan                  2010-10-25  1528  			return -EINVAL;
1a419d85a76853d Li Zefan                  2010-10-25  1529  		if (range->compress_type)
1a419d85a76853d Li Zefan                  2010-10-25  1530  			compress_type = range->compress_type;
1a419d85a76853d Li Zefan                  2010-10-25  1531  	}
f46b5a66b3316ef Christoph Hellwig         2008-06-11  1532  
0abd5b17249ea5c Liu Bo                    2013-04-16  1533  	if (extent_thresh == 0)
ee22184b53c823f Byongho Lee               2015-12-15  1534  		extent_thresh = SZ_256K;
940100a4a7b78b2 Chris Mason               2010-03-10  1535  
4cb5300bc839b8a Chris Mason               2011-05-24  1536  	/*
0a52d108089f337 David Sterba              2017-06-22  1537  	 * If we were not given a file, allocate a readahead context. As
0a52d108089f337 David Sterba              2017-06-22  1538  	 * readahead is just an optimization, defrag will work without it so
0a52d108089f337 David Sterba              2017-06-22  1539  	 * we don't error out.
4cb5300bc839b8a Chris Mason               2011-05-24  1540  	 */
4cb5300bc839b8a Chris Mason               2011-05-24  1541  	if (!file) {
63e727ecd238be2 David Sterba              2017-06-22  1542  		ra = kzalloc(sizeof(*ra), GFP_KERNEL);
0a52d108089f337 David Sterba              2017-06-22  1543  		if (ra)
4cb5300bc839b8a Chris Mason               2011-05-24  1544  			file_ra_state_init(ra, inode->i_mapping);
4cb5300bc839b8a Chris Mason               2011-05-24  1545  	} else {
4cb5300bc839b8a Chris Mason               2011-05-24  1546  		ra = &file->f_ra;
4cb5300bc839b8a Chris Mason               2011-05-24  1547  	}
4cb5300bc839b8a Chris Mason               2011-05-24  1548  
63e727ecd238be2 David Sterba              2017-06-22  1549  	pages = kmalloc_array(max_cluster, sizeof(struct page *), GFP_KERNEL);
4cb5300bc839b8a Chris Mason               2011-05-24  1550  	if (!pages) {
4cb5300bc839b8a Chris Mason               2011-05-24  1551  		ret = -ENOMEM;
4cb5300bc839b8a Chris Mason               2011-05-24  1552  		goto out_ra;
4cb5300bc839b8a Chris Mason               2011-05-24  1553  	}
4cb5300bc839b8a Chris Mason               2011-05-24  1554  
4cb5300bc839b8a Chris Mason               2011-05-24  1555  	/* find the last page to defrag */
1e701a3292e25a6 Chris Mason               2010-03-11  1556  	if (range->start + range->len > range->start) {
151a31b25e5c941 Li Zefan                  2011-09-02  1557  		last_index = min_t(u64, isize - 1,
09cbfeaf1a5a67b Kirill A. Shutemov        2016-04-01  1558  			 range->start + range->len - 1) >> PAGE_SHIFT;
1e701a3292e25a6 Chris Mason               2010-03-11  1559  	} else {
09cbfeaf1a5a67b Kirill A. Shutemov        2016-04-01  1560  		last_index = (isize - 1) >> PAGE_SHIFT;
1e701a3292e25a6 Chris Mason               2010-03-11  1561  	}
1e701a3292e25a6 Chris Mason               2010-03-11  1562  
4cb5300bc839b8a Chris Mason               2011-05-24  1563  	if (newer_than) {
4cb5300bc839b8a Chris Mason               2011-05-24  1564  		ret = find_new_extents(root, inode, newer_than,
ee22184b53c823f Byongho Lee               2015-12-15  1565  				       &newer_off, SZ_64K);
4cb5300bc839b8a Chris Mason               2011-05-24  1566  		if (!ret) {
4cb5300bc839b8a Chris Mason               2011-05-24  1567  			range->start = newer_off;
4cb5300bc839b8a Chris Mason               2011-05-24  1568  			/*
4cb5300bc839b8a Chris Mason               2011-05-24  1569  			 * we always align our defrag to help keep
4cb5300bc839b8a Chris Mason               2011-05-24  1570  			 * the extents in the file evenly spaced
4cb5300bc839b8a Chris Mason               2011-05-24  1571  			 */
09cbfeaf1a5a67b Kirill A. Shutemov        2016-04-01  1572  			i = (newer_off & new_align) >> PAGE_SHIFT;
4cb5300bc839b8a Chris Mason               2011-05-24  1573  		} else
4cb5300bc839b8a Chris Mason               2011-05-24  1574  			goto out_ra;
4cb5300bc839b8a Chris Mason               2011-05-24  1575  	} else {
09cbfeaf1a5a67b Kirill A. Shutemov        2016-04-01  1576  		i = range->start >> PAGE_SHIFT;
4cb5300bc839b8a Chris Mason               2011-05-24  1577  	}
4cb5300bc839b8a Chris Mason               2011-05-24  1578  	if (!max_to_defrag)
070034bdf98544b chandan                   2015-06-09  1579  		max_to_defrag = last_index - i + 1;
4cb5300bc839b8a Chris Mason               2011-05-24  1580  
2a0f7f5769992ba Li Zefan                  2011-10-10  1581  	/*
2a0f7f5769992ba Li Zefan                  2011-10-10  1582  	 * make writeback starts from i, so the defrag range can be
2a0f7f5769992ba Li Zefan                  2011-10-10  1583  	 * written sequentially.
2a0f7f5769992ba Li Zefan                  2011-10-10  1584  	 */
2a0f7f5769992ba Li Zefan                  2011-10-10  1585  	if (i < inode->i_mapping->writeback_index)
2a0f7f5769992ba Li Zefan                  2011-10-10  1586  		inode->i_mapping->writeback_index = i;
2a0f7f5769992ba Li Zefan                  2011-10-10  1587  
f7f43cc84152e53 Chris Mason               2011-10-11  1588  	while (i <= last_index && defrag_count < max_to_defrag &&
09cbfeaf1a5a67b Kirill A. Shutemov        2016-04-01  1589  	       (i < DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE))) {

In the original code "ret" at the end of the while loop.

4cb5300bc839b8a Chris Mason               2011-05-24  1590  		/*
4cb5300bc839b8a Chris Mason               2011-05-24  1591  		 * make sure we stop running if someone unmounts
4cb5300bc839b8a Chris Mason               2011-05-24  1592  		 * the FS
4cb5300bc839b8a Chris Mason               2011-05-24  1593  		 */
1751e8a6cb935e5 Linus Torvalds            2017-11-27  1594  		if (!(inode->i_sb->s_flags & SB_ACTIVE))
4cb5300bc839b8a Chris Mason               2011-05-24  1595  			break;

These paths are why Smatch complains about unintialized variables.

4cb5300bc839b8a Chris Mason               2011-05-24  1596  
0b246afa62b0cf5 Jeff Mahoney              2016-06-22  1597  		if (btrfs_defrag_cancelled(fs_info)) {
0b246afa62b0cf5 Jeff Mahoney              2016-06-22  1598  			btrfs_debug(fs_info, "defrag_file cancelled");
210549ebe9047ae David Sterba              2013-02-09  1599  			ret = -EAGAIN;
210549ebe9047ae David Sterba              2013-02-09  1600  			break;


You're right that it doesn't make sense to set ret = -EAGAIN here and
then reset it later.

210549ebe9047ae David Sterba              2013-02-09  1601  		}
210549ebe9047ae David Sterba              2013-02-09  1602  
09cbfeaf1a5a67b Kirill A. Shutemov        2016-04-01  1603  		if (!should_defrag_range(inode, (u64)i << PAGE_SHIFT,
6c282eb40ed6f64 Li Zefan                  2012-06-11  1604  					 extent_thresh, &last_len, &skip,
1e2ef46d89ee41c David Sterba              2017-07-17  1605  					 &defrag_end, do_compress)){
940100a4a7b78b2 Chris Mason               2010-03-10  1606  			unsigned long next;
940100a4a7b78b2 Chris Mason               2010-03-10  1607  			/*
940100a4a7b78b2 Chris Mason               2010-03-10  1608  			 * the should_defrag function tells us how much to skip
940100a4a7b78b2 Chris Mason               2010-03-10  1609  			 * bump our counter by the suggested amount
940100a4a7b78b2 Chris Mason               2010-03-10  1610  			 */
09cbfeaf1a5a67b Kirill A. Shutemov        2016-04-01  1611  			next = DIV_ROUND_UP(skip, PAGE_SIZE);
940100a4a7b78b2 Chris Mason               2010-03-10  1612  			i = max(i + 1, next);
940100a4a7b78b2 Chris Mason               2010-03-10  1613  			continue;
940100a4a7b78b2 Chris Mason               2010-03-10  1614  		}
008873eafbc77de Li Zefan                  2011-09-02  1615  
008873eafbc77de Li Zefan                  2011-09-02  1616  		if (!newer_than) {
09cbfeaf1a5a67b Kirill A. Shutemov        2016-04-01  1617  			cluster = (PAGE_ALIGN(defrag_end) >>
09cbfeaf1a5a67b Kirill A. Shutemov        2016-04-01  1618  				   PAGE_SHIFT) - i;
008873eafbc77de Li Zefan                  2011-09-02  1619  			cluster = min(cluster, max_cluster);
008873eafbc77de Li Zefan                  2011-09-02  1620  		} else {
008873eafbc77de Li Zefan                  2011-09-02  1621  			cluster = max_cluster;
008873eafbc77de Li Zefan                  2011-09-02  1622  		}
008873eafbc77de Li Zefan                  2011-09-02  1623  
008873eafbc77de Li Zefan                  2011-09-02  1624  		if (i + cluster > ra_index) {
008873eafbc77de Li Zefan                  2011-09-02  1625  			ra_index = max(i, ra_index);
0a52d108089f337 David Sterba              2017-06-22  1626  			if (ra)
d3c0bab5632337f David Sterba              2017-06-22  1627  				page_cache_sync_readahead(inode->i_mapping, ra,
d3c0bab5632337f David Sterba              2017-06-22  1628  						file, ra_index, cluster);
e4826a5b2430f23 chandan                   2015-06-09  1629  			ra_index += cluster;
008873eafbc77de Li Zefan                  2011-09-02  1630  		}
940100a4a7b78b2 Chris Mason               2010-03-10  1631  
64708539cd23b31 Josef Bacik               2021-02-10  1632  		btrfs_inode_lock(inode, 0);
eede2bf34f4fa84 Omar Sandoval             2016-11-03  1633  		if (IS_SWAPFILE(inode)) {
eede2bf34f4fa84 Omar Sandoval             2016-11-03  1634  			ret = -ETXTBSY;
eede2bf34f4fa84 Omar Sandoval             2016-11-03  1635  		} else {
1e2ef46d89ee41c David Sterba              2017-07-17  1636  			if (do_compress)
eec63c65dcbeb14 David Sterba              2017-07-17  1637  				BTRFS_I(inode)->defrag_compress = compress_type;
008873eafbc77de Li Zefan                  2011-09-02  1638  			ret = cluster_pages_for_defrag(inode, pages, i, cluster);
eede2bf34f4fa84 Omar Sandoval             2016-11-03  1639  		}
ecb8bea87d05fd2 Liu Bo                    2012-03-29  1640  		if (ret < 0) {
64708539cd23b31 Josef Bacik               2021-02-10  1641  			btrfs_inode_unlock(inode, 0);
4cb5300bc839b8a Chris Mason               2011-05-24  1642  			goto out_ra;
ecb8bea87d05fd2 Liu Bo                    2012-03-29  1643  		}
940100a4a7b78b2 Chris Mason               2010-03-10  1644  
4cb5300bc839b8a Chris Mason               2011-05-24  1645  		defrag_count += ret;
d0e1d66b5aa1ec9 Namjae Jeon               2012-12-11  1646  		balance_dirty_pages_ratelimited(inode->i_mapping);
64708539cd23b31 Josef Bacik               2021-02-10  1647  		btrfs_inode_unlock(inode, 0);
f46b5a66b3316ef Christoph Hellwig         2008-06-11  1648  
4cb5300bc839b8a Chris Mason               2011-05-24  1649  		if (newer_than) {
4cb5300bc839b8a Chris Mason               2011-05-24  1650  			if (newer_off == (u64)-1)
4cb5300bc839b8a Chris Mason               2011-05-24  1651  				break;

break statement

940100a4a7b78b2 Chris Mason               2010-03-10  1652  
e1f041e14cfb322 Liu Bo                    2012-03-29  1653  			if (ret > 0)
e1f041e14cfb322 Liu Bo                    2012-03-29  1654  				i += ret;
e1f041e14cfb322 Liu Bo                    2012-03-29  1655  
4cb5300bc839b8a Chris Mason               2011-05-24  1656  			newer_off = max(newer_off + 1,
09cbfeaf1a5a67b Kirill A. Shutemov        2016-04-01  1657  					(u64)i << PAGE_SHIFT);
3eaa2885276fd6d Chris Mason               2008-07-24  1658  
ee22184b53c823f Byongho Lee               2015-12-15  1659  			ret = find_new_extents(root, inode, newer_than,
ee22184b53c823f Byongho Lee               2015-12-15  1660  					       &newer_off, SZ_64K);
4cb5300bc839b8a Chris Mason               2011-05-24  1661  			if (!ret) {
4cb5300bc839b8a Chris Mason               2011-05-24  1662  				range->start = newer_off;
09cbfeaf1a5a67b Kirill A. Shutemov        2016-04-01  1663  				i = (newer_off & new_align) >> PAGE_SHIFT;
4cb5300bc839b8a Chris Mason               2011-05-24  1664  			} else {
4cb5300bc839b8a Chris Mason               2011-05-24  1665  				break;

And here.

3eaa2885276fd6d Chris Mason               2008-07-24  1666  			}
4cb5300bc839b8a Chris Mason               2011-05-24  1667  		} else {
008873eafbc77de Li Zefan                  2011-09-02  1668  			if (ret > 0) {
cbcc83265d929ac Li Zefan                  2011-09-02  1669  				i += ret;
09cbfeaf1a5a67b Kirill A. Shutemov        2016-04-01  1670  				last_len += ret << PAGE_SHIFT;
4cb5300bc839b8a Chris Mason               2011-05-24  1671  			} else {
940100a4a7b78b2 Chris Mason               2010-03-10  1672  				i++;
008873eafbc77de Li Zefan                  2011-09-02  1673  				last_len = 0;
008873eafbc77de Li Zefan                  2011-09-02  1674  			}
f46b5a66b3316ef Christoph Hellwig         2008-06-11  1675  		}
4cb5300bc839b8a Chris Mason               2011-05-24  1676  	}
f46b5a66b3316ef Christoph Hellwig         2008-06-11  1677  
dec8ef90552f7b8 Filipe Manana             2014-03-01  1678  	if ((range->flags & BTRFS_DEFRAG_RANGE_START_IO)) {
1e701a3292e25a6 Chris Mason               2010-03-11  1679  		filemap_flush(inode->i_mapping);
dec8ef90552f7b8 Filipe Manana             2014-03-01  1680  		if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
dec8ef90552f7b8 Filipe Manana             2014-03-01  1681  			     &BTRFS_I(inode)->runtime_flags))
1e701a3292e25a6 Chris Mason               2010-03-11  1682  			filemap_flush(inode->i_mapping);
dec8ef90552f7b8 Filipe Manana             2014-03-01  1683  	}
1e701a3292e25a6 Chris Mason               2010-03-11  1684  
1a419d85a76853d Li Zefan                  2010-10-25  1685  	if (range->compress_type == BTRFS_COMPRESS_LZO) {
0b246afa62b0cf5 Jeff Mahoney              2016-06-22  1686  		btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
5c1aab1dd5445ed Nick Terrell              2017-08-09  1687  	} else if (range->compress_type == BTRFS_COMPRESS_ZSTD) {
5c1aab1dd5445ed Nick Terrell              2017-08-09  1688  		btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
1a419d85a76853d Li Zefan                  2010-10-25  1689  	}
1a419d85a76853d Li Zefan                  2010-10-25  1690  
4cb5300bc839b8a Chris Mason               2011-05-24  1691  out_ra:
1e2ef46d89ee41c David Sterba              2017-07-17  1692  	if (do_compress) {
64708539cd23b31 Josef Bacik               2021-02-10  1693  		btrfs_inode_lock(inode, 0);
eec63c65dcbeb14 David Sterba              2017-07-17  1694  		BTRFS_I(inode)->defrag_compress = BTRFS_COMPRESS_NONE;
64708539cd23b31 Josef Bacik               2021-02-10  1695  		btrfs_inode_unlock(inode, 0);
633085c79c84c39 Filipe David Borba Manana 2013-08-16  1696  	}
4cb5300bc839b8a Chris Mason               2011-05-24  1697  	if (!file)
4cb5300bc839b8a Chris Mason               2011-05-24  1698  		kfree(ra);
4cb5300bc839b8a Chris Mason               2011-05-24  1699  	kfree(pages);
940100a4a7b78b2 Chris Mason               2010-03-10 @1700  	return ret;
f46b5a66b3316ef Christoph Hellwig         2008-06-11  1701  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

