Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCB83E4572
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 14:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbhHIMOV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 08:14:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:50899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233193AbhHIMOL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Aug 2021 08:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628511217;
        bh=wdTKDXUtEz1rdigNQZRsyA51qq2iv89XwmvK7alWjfQ=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=F9lWLcZefhuiTR/1p8G8b9EaauOt5V5WgahkZsEX0i75j3hbY8m3k2S17jNYSsawW
         IKfwdX8+hkiGZBISeI/472sKMSRCJqILCVxHpuvYVl5KL697ntyx62htu9nyBooGtQ
         2Q/kEXeeh1/BqL/8/HW3bja9xa4tPw7nIUF2xlAo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTzb8-1me7Bi1WWg-00Qy0e; Mon, 09
 Aug 2021 14:13:37 +0200
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org
References: <202108070109.1tqb3qPy-lkp@intel.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v5 09/11] btrfs: defrag: use defrag_one_cluster() to
 implement btrfs_defrag_file()
Message-ID: <002d4e5e-b523-cead-0e00-7a6e1c7c3228@gmx.com>
Date:   Mon, 9 Aug 2021 20:13:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202108070109.1tqb3qPy-lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1UZ++2KY94EiMrXGaVcbNpf4Sh7FVOACQHbbQ4XA/kr26JA2TRJ
 X3WiyHiCYki549bqTLMwURBlekZ7aHqC1/HBETb1DxLp5PqK/43Bwysj73qBjoL3mIDlE1I
 yjRoGwdheaunJGUUqmwEM7cBJjRAYYUAC3LcpWiS7r7LH3H3loJ2XO4Nfa+7sX0fd72v7eS
 mzmqY8uKwz/65fc/9/8MA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9e2+XudEL6M=:Gnmwl8Y76BZRqVKO3uzDt+
 k8SBMH5EVGz5s77kv0ccMHAOS/2FeoIPVzGFpokojhpLHrvdar3b02T7fQTP2LT38LX4xV5j1
 Ed5WDL+F0ohRog6SXmUhFAXMcqhDEZWb7OmG7gFmYLsAmgP+HHILGihNmb6lxLRRsihrizu39
 DdnhuvtmO10ZoM+i54ix6L8fJw8ynx3H/7M5nITEl4lVpHxeA1l+Yc7WB5UW+iAMYEr8604Ig
 vppHP2OBLAeu6gr/LDAuWo4fk1Zjaqwh9q7ODmk0okJzndfcLmo7c56Gx/HJdAi3FxFjpwVnf
 y4vR64bNpOkUt4la7ZGHCb5lnkAlr8vhtLbRD0ulm/N73SDMtoZxFm7EYPf58ah+FL8zjckAk
 ROxQa1CK7khwqiGCfdbuk6jiRYsw29OD9X45t428s3RtH0Evkpq6dXJxPsFwlSV5JpVPL+L0A
 kRwXTVKnsQQBJ46skt4vvXNUj24w9W/SDhHVLDNwU8dcxZH/4FY/FAeR1fZb21VtBYffTSAKj
 u7VvnMNcvLYKIugEOmI++kziIZqNyUNGy6K0nR9L9tHCOvqKvK7VFih1UIFJu7zbkXEEOw2RV
 AWglWLj1EM/v2Def6vmpV8uKvEhyjevVavYgu+sn6xuyweRKmg1qFzcjTsYaaTfAUehLe9GhR
 SMUyk3rfdgrVXavWQT+nhzMN1sNQbdUjDYD1f7EuMOvXnURkl0UllAFhT4QN6uWCc5uvDIUWu
 AVML0Ne6go3ItjLp3ZsIjD7M86mRX1RGykd5c1du9G6v1We3WpKVeCLx/grdLXQrePikUEuzK
 Uu7clNl0mKy9TC4XlLU8xtagNUP9op1SuFUtvnD6rsqO+UnaqgIRtN4vys1iTIyqeXx13nMsT
 dyklnqAnnMphCz2Sz7htnNn5uDx5gPGFpXHoD0XAi1/xRmuDS7oeMSaPoNo6Ug1BjnM4O2o/y
 MMgY3yksEELDOURup3fUcA9dan4zsvtHICuXFfqwXieKPePoOHAARCeClD6JcDZUlU5mPpP71
 FZR16GDaRydYJOYUsRTsVyMEhitqASeh0sTf1CSz9IeHK6gzdgeaJfNDYrjqno5OMbNiVVKzQ
 asYEs8+Pc8qRLDL1bMHZe8IW4UAbUPb2PXkNRAlDPtHpx/W86f6xwbDBQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/9 =E4=B8=8B=E5=8D=887:32, Dan Carpenter wrote:
> Hi Qu,
>
> url:    https://github.com/0day-ci/linux/commits/Qu-Wenruo/btrfs-defrag-=
rework-to-support-sector-perfect-defrag/20210806-161501
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git =
for-next
> config: h8300-randconfig-m031-20210804 (attached as .config)
> compiler: h8300-linux-gcc (GCC) 10.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> New smatch warnings:
> fs/btrfs/ioctl.c:1869 btrfs_defrag_file() error: uninitialized symbol 'r=
et'.

OK, it's indeed a possible case, and I even find a special case where we
don't need to go through the branch reported by the static checker.

>
> vim +/ret +1869 fs/btrfs/ioctl.c
>
> fe90d1614439a8 Qu Wenruo                 2021-08-06  1757  int btrfs_def=
rag_file(struct inode *inode, struct file_ra_state *ra,
> 4cb5300bc839b8 Chris Mason               2011-05-24  1758  		      struc=
t btrfs_ioctl_defrag_range_args *range,
> 4cb5300bc839b8 Chris Mason               2011-05-24  1759  		      u64 n=
ewer_than, unsigned long max_to_defrag)
> 4cb5300bc839b8 Chris Mason               2011-05-24  1760  {
> 0b246afa62b0cf Jeff Mahoney              2016-06-22  1761  	struct btrfs=
_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1762  	unsigned lon=
g sectors_defragged =3D 0;
> 151a31b25e5c94 Li Zefan                  2011-09-02  1763  	u64 isize =
=3D i_size_read(inode);
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1764  	u64 cur;
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1765  	u64 last_byt=
e;
> 1e2ef46d89ee41 David Sterba              2017-07-17  1766  	bool do_comp=
ress =3D range->flags & BTRFS_DEFRAG_RANGE_COMPRESS;
> fe90d1614439a8 Qu Wenruo                 2021-08-06  1767  	bool ra_allo=
cated =3D false;
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1768  	int compress=
_type =3D BTRFS_COMPRESS_ZLIB;
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1769  	int ret;
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1770  	u32 extent_t=
hresh =3D range->extent_thresh;
> 4cb5300bc839b8 Chris Mason               2011-05-24  1771
> 0abd5b17249ea5 Liu Bo                    2013-04-16  1772  	if (isize =
=3D=3D 0)
> 0abd5b17249ea5 Liu Bo                    2013-04-16  1773  		return 0;
> 0abd5b17249ea5 Liu Bo                    2013-04-16  1774
> 0abd5b17249ea5 Liu Bo                    2013-04-16  1775  	if (range->s=
tart >=3D isize)
> 0abd5b17249ea5 Liu Bo                    2013-04-16  1776  		return -EIN=
VAL;

Firstly, we skip several invalid cases, like empty file or range beyond
isize.

Notice that now range->start < isize; AKA range->start <=3D isize - 1;

> 1a419d85a76853 Li Zefan                  2010-10-25  1777
> 1e2ef46d89ee41 David Sterba              2017-07-17  1778  	if (do_compr=
ess) {
> ce96b7ffd11e26 Chengguang Xu             2019-10-10  1779  		if (range->=
compress_type >=3D BTRFS_NR_COMPRESS_TYPES)
> 1a419d85a76853 Li Zefan                  2010-10-25  1780  			return -EI=
NVAL;
> 1a419d85a76853 Li Zefan                  2010-10-25  1781  		if (range->=
compress_type)
> 1a419d85a76853 Li Zefan                  2010-10-25  1782  			compress_t=
ype =3D range->compress_type;
> 1a419d85a76853 Li Zefan                  2010-10-25  1783  	}
> f46b5a66b3316e Christoph Hellwig         2008-06-11  1784
> 0abd5b17249ea5 Liu Bo                    2013-04-16  1785  	if (extent_t=
hresh =3D=3D 0)
> ee22184b53c823 Byongho Lee               2015-12-15  1786  		extent_thre=
sh =3D SZ_256K;
> 940100a4a7b78b Chris Mason               2010-03-10  1787
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1788  	if (range->s=
tart + range->len > range->start) {
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1789  		/* Got a sp=
ecific range */
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1790  		last_byte =
=3D min(isize, range->start + range->len) - 1;
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1791  	} else {
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1792  		/* Defrag u=
ntil file end */
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1793  		last_byte =
=3D isize - 1;
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1794  	}

No matter the range->len, last_byte <=3D isize - 1;
Also start->range <=3D isize - 1;

Thus we can have a worst case where start->range =3D=3D last_byte.

> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1795
> 4cb5300bc839b8 Chris Mason               2011-05-24  1796  	/*
> fe90d1614439a8 Qu Wenruo                 2021-08-06  1797  	 * If we wer=
e not given a ra, allocate a readahead context. As
> 0a52d108089f33 David Sterba              2017-06-22  1798  	 * readahead=
 is just an optimization, defrag will work without it so
> 0a52d108089f33 David Sterba              2017-06-22  1799  	 * we don't =
error out.
> 4cb5300bc839b8 Chris Mason               2011-05-24  1800  	 */
> fe90d1614439a8 Qu Wenruo                 2021-08-06  1801  	if (!ra) {
> fe90d1614439a8 Qu Wenruo                 2021-08-06  1802  		ra_allocate=
d =3D true;
> 63e727ecd238be David Sterba              2017-06-22  1803  		ra =3D kzal=
loc(sizeof(*ra), GFP_KERNEL);
> 0a52d108089f33 David Sterba              2017-06-22  1804  		if (ra)
> 4cb5300bc839b8 Chris Mason               2011-05-24  1805  			file_ra_st=
ate_init(ra, inode->i_mapping);
> 4cb5300bc839b8 Chris Mason               2011-05-24  1806  	}
> 4cb5300bc839b8 Chris Mason               2011-05-24  1807
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1808  	/* Align the=
 range */
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1809  	cur =3D roun=
d_down(range->start, fs_info->sectorsize);
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1810  	last_byte =
=3D round_up(last_byte, fs_info->sectorsize) - 1;

Even for the worst case, range->start =3D=3D last_byte.

If range->start =3D last_byte =3D 4K (aka isize =3D 4K + 1), then:
cur =3D 4K;
last_byte =3D 4K - 1;

Now we don't need to go through the while() loop at all.

> 4cb5300bc839b8 Chris Mason               2011-05-24  1811
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1812  	while (cur <=
 last_byte) {
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1813  		u64 cluster=
_end;
> 1e701a3292e25a Chris Mason               2010-03-11  1814
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1815  		/* The clus=
ter size 256K should always be page aligned */
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1816  		BUILD_BUG_O=
N(!IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
> 008873eafbc77d Li Zefan                  2011-09-02  1817
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1818  		/* We want =
the cluster ends at page boundary when possible */
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1819  		cluster_end=
 =3D (((cur >> PAGE_SHIFT) +
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1820  			       (SZ=
_256K >> PAGE_SHIFT)) << PAGE_SHIFT) - 1;
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1821  		cluster_end=
 =3D min(cluster_end, last_byte);
> 940100a4a7b78b Chris Mason               2010-03-10  1822
> 64708539cd23b3 Josef Bacik               2021-02-10  1823  		btrfs_inode=
_lock(inode, 0);
> eede2bf34f4fa8 Omar Sandoval             2016-11-03  1824  		if (IS_SWAP=
FILE(inode)) {
> eede2bf34f4fa8 Omar Sandoval             2016-11-03  1825  			ret =3D -E=
TXTBSY;
> 64708539cd23b3 Josef Bacik               2021-02-10  1826  			btrfs_inod=
e_unlock(inode, 0);
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1827  			break;
> ecb8bea87d05fd Liu Bo                    2012-03-29  1828  		}
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1829  		if (!(inode=
->i_sb->s_flags & SB_ACTIVE)) {
> 64708539cd23b3 Josef Bacik               2021-02-10  1830  			btrfs_inod=
e_unlock(inode, 0);
> 4cb5300bc839b8 Chris Mason               2011-05-24  1831  			break;
>
> Can we hit this break statement on the first iteration through the loop?
>
> 3eaa2885276fd6 Chris Mason               2008-07-24  1832  		}
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1833  		if (do_comp=
ress)
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1834  			BTRFS_I(in=
ode)->defrag_compress =3D compress_type;
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1835  		ret =3D def=
rag_one_cluster(BTRFS_I(inode), ra, cur,
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1836  				cluster_e=
nd + 1 - cur, extent_thresh,
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1837  				newer_tha=
n, do_compress,
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1838  				&sectors_=
defragged, max_to_defrag);
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1839  		btrfs_inode=
_unlock(inode, 0);
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1840  		if (ret < 0=
)
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1841  			break;
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1842  		cur =3D clu=
ster_end + 1;
> 4cb5300bc839b8 Chris Mason               2011-05-24  1843  	}
> f46b5a66b3316e Christoph Hellwig         2008-06-11  1844
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1845  	if (ra_alloc=
ated)
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1846  		kfree(ra);
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1847  	if (sectors_=
defragged) {
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1848  		/*
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1849  		 * We have =
defragged some sectors, for compression case
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1850  		 * they nee=
d to be written back immediately.
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1851  		 */
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1852  		if (range->=
flags & BTRFS_DEFRAG_RANGE_START_IO) {
> 1e701a3292e25a Chris Mason               2010-03-11  1853  			filemap_fl=
ush(inode->i_mapping);
> dec8ef90552f7b Filipe Manana             2014-03-01  1854  			if (test_b=
it(BTRFS_INODE_HAS_ASYNC_EXTENT,
> dec8ef90552f7b Filipe Manana             2014-03-01  1855  				     &BTR=
FS_I(inode)->runtime_flags))
> 1e701a3292e25a Chris Mason               2010-03-11  1856  				filemap_f=
lush(inode->i_mapping);
> dec8ef90552f7b Filipe Manana             2014-03-01  1857  		}
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1858  		if (range->=
compress_type =3D=3D BTRFS_COMPRESS_LZO)
> 0b246afa62b0cf Jeff Mahoney              2016-06-22  1859  			btrfs_set_=
fs_incompat(fs_info, COMPRESS_LZO);
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1860  		else if (ra=
nge->compress_type =3D=3D BTRFS_COMPRESS_ZSTD)
> 5c1aab1dd5445e Nick Terrell              2017-08-09  1861  			btrfs_set_=
fs_incompat(fs_info, COMPRESS_ZSTD);
> d0b928ff1ed56a Qu Wenruo                 2021-08-06  1862  		ret =3D sec=
tors_defragged;
> 1a419d85a76853 Li Zefan                  2010-10-25  1863  	}

We also skip above (sectors_defraged) branch.

> 1e2ef46d89ee41 David Sterba              2017-07-17  1864  	if (do_compr=
ess) {
> 64708539cd23b3 Josef Bacik               2021-02-10  1865  		btrfs_inode=
_lock(inode, 0);
> eec63c65dcbeb1 David Sterba              2017-07-17  1866  		BTRFS_I(ino=
de)->defrag_compress =3D BTRFS_COMPRESS_NONE;
> 64708539cd23b3 Josef Bacik               2021-02-10  1867  		btrfs_inode=
_unlock(inode, 0);
> 633085c79c84c3 Filipe David Borba Manana 2013-08-16  1868  	}
> 940100a4a7b78b Chris Mason               2010-03-10 @1869  	return ret;

And @ret is indeed uninitialized.

Will fix it in next update.

Thanks,
Qu

> f46b5a66b3316e Christoph Hellwig         2008-06-11  1870  }
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
