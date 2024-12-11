Return-Path: <linux-btrfs+bounces-10265-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD439ED6C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 20:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA991885398
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 19:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B13120A5CF;
	Wed, 11 Dec 2024 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="tuSfg0xq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FACEC148;
	Wed, 11 Dec 2024 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733946470; cv=none; b=L/5jYu+oKNC51QQ0lsnwsgfqR9RBNY5t+gTjmkd+ausn9mJ8o67Wzvsoa5/jrfpBO4MI5z74N2zDypqEpC/gs+IWseDQy7w5+l1IOWCPm1aD2unNFclbrvntFhOXF7R1BXIPoyiqTGFZvNc67XV9WENQZ/lCTH7Afe0F6WihJ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733946470; c=relaxed/simple;
	bh=O87OApdluPfit8r/CJr1WPF4/bZoMzP/ml/FN4G03Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErLgS1ps69HPqa9SqP0Zc3brtNKqQp2YVVFUiIanZAUJNNOdTP6ezeEkTWorua6Ly/7SA73yOzPqj1ai6Vb6HyImIpbphppbAhTmyxSQZivo/Hfa6qLYN5tSU/myPrvqCgDAGAZNmU+y3G3ARKMh1LJeCB/FOUC2EVxIIW55xZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=tuSfg0xq; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733946462; x=1734551262; i=quwenruo.btrfs@gmx.com;
	bh=EYqCeMOXsv9Y/tMm5/9JHlRgVKtJXXu+vaSzJwPZ/co=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tuSfg0xqmGapNW7mTumOpZqfohdFjTzzGjNtbFAK14Ih2sFDqsWtCfvOLDucBXj8
	 xJr4ZiKgE9BfbP0382FNG3QtuV2tUFLaaC6TzKEcuFyptN38BpkRhHLxO0fgU+bR6
	 Y8nC8IiZZE6L5Zy4wwcTgLtp4WWVbpKuRnIJ256qTGiF5uzfCoqL6H3JGztlVQR2k
	 nWO4a2RPMcNIK9vPlYWc3SrWWzEvCAT5yIH3IxplovF1/jlChsnWT8TcFiOJ/Vq0H
	 Mfq4W32ip+Hd/Ap2c7xqPzWJJo8YloCqIYH84edMSmbziU9FntnW2ve0vAyTaBXH3
	 qdWRx7lehoiDdyPqNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvsJ5-1teEDh0U5P-011qpF; Wed, 11
 Dec 2024 20:47:42 +0100
Message-ID: <2e8ec0ba-aaa8-4107-9fbe-b3288a45f5a6@gmx.com>
Date: Thu, 12 Dec 2024 06:17:37 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: enhance ordered extent double freeing detection
To: kernel test robot <lkp@intel.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
References: <53b793f2e7a7788f89cda97de565cfc1577cbf75.1733890357.git.wqu@suse.com>
 <202412120136.6OwbbtZf-lkp@intel.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <202412120136.6OwbbtZf-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mt8qBO4LpHgNWd55sWnGsk/ujCTW9PCwaLsp/jlRPnowevLQWQk
 w5zEjNcgWZgWZW4ji6l+NL9iVWEL15TnIg6QaZ4uXJhVauO9u8lqSGS46cE9gFhohSyCcx/
 Fj+zX2D9PQ1EwViqoEk5rYMcfZdlBbqRczQDwTSDwoe/H+zT1WUiBCwB+CJWxVWElyOVFvd
 pslRPClYBD8i3r4IrRtZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nCcuJwAlm5w=;eWWwPMIsKjxwgRfhM5sO+2J0HZU
 kfPe5LAYxwnVYHuol3HiAIyqton9W0efB/T33y7InCdqCmtxNpgrUTEtC+MBKDd+aFA2V8dfM
 CONuOqHKzyhBHKE5SlyqJOdE2KIIbBv9kavGpBUOiZZjXl7GGDCq/Wk3HfK2em8UWmTHy7/YU
 hOSjpX6+FpFeenqZBGJ7jU4e6OwGh7XRoWfHL0SzVnnVV6taN0h1aHR7VAdwIAhIzqJcYzMZs
 6quGNQFHbkbfg8g6Y9boBWhMAuuWv8SK0EeNR2TJr82EEfCSAv3+h2mElj0gwj9AytYlGgjHQ
 unJLA+b2Pqx9Zvj50ucZqHNBCcfhfSrjxynDmhOhr4ZC+2QdZdqn1V6TYLSUYcHa6mjkJ9TMj
 qo/6/Uq3KD3dqu4wBHgfkM1nGZDpPbzX1lOsubeQBy8bYJnCSYv7kzHQ9yt3AUVhDeSdKk11P
 Vj0+kyduTT10pypfUv61pYPD72ftB3MjlGprgiLR09nyQsu4XEywjdhn1kW/In6VNrvhEcA/+
 9s8CbyUI2BmI5EC8mLb72hJ/zPhgz1vtAM/uW5aYl/uMr8ZoQC5xR/up4SWFGj48SoLOlOTiw
 kb/EsA8d797AVwIxXA06en4EalUriTltP3v3gVp0E13iA/7OoDoYRImgz04/TYVP9/UoUVEsb
 J5C9vY7WDRA3hF+STlg5zmA7qrJ6VTlKpxRdGcWBIqc8cbqZSpBzIf/ums5H5VB7VpDgZCaam
 4aBEGHg1HyBfbNewwySixfuiwYXzifjs/Q0+1DQ2I9Vn/69CpN/58V/mYMYvm++wnikJdjui1
 a7iZhtgZyIljgVbM22dODk6DEe7HSjSTSUGYE5RA/9Qxq8HnEvp/rkiSDFHgnIYYwJLDIoo51
 MfXHyKUcV8DwO0lekCXXtLnBQaIRN1RINSHsjFEqxf3FHA/OlFIf1ycO/QRaCEpLTNiFpMPAX
 wT4s8DMGbmoVVYItSkJ2GURjVbqVWOViFtvFrrmIOUU87Ckuhm7s13BDGOe1cewCMH/B+hjm7
 9NsKLQEFCfJUi5iNgd86As56wJmgYZwYCJZUAr/iMOQnrIKA8h2365OJmvSeozJlPVDGcPwEl
 VThHG2H48h0QCo8dUOk3YB0RCDctGjAA76V/fWl6hDH7dH9Tr7fEDuLqsppIL420PgwQ3ayb4
 =



=E5=9C=A8 2024/12/12 04:41, kernel test robot =E5=86=99=E9=81=93:
> Hi Qu,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on kdave/for-next]
> [also build test ERROR on linus/master v6.13-rc2 next-20241211]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-e=
nhance-ordered-extent-double-freeing-detection/20241211-121647
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git =
for-next
> patch link:    https://lore.kernel.org/r/53b793f2e7a7788f89cda97de565cfc=
1577cbf75.1733890357.git.wqu%40suse.com
> patch subject: [PATCH] btrfs: enhance ordered extent double freeing dete=
ction
> config: i386-buildonly-randconfig-003-20241211 (https://download.01.org/=
0day-ci/archive/20241212/202412120136.6OwbbtZf-lkp@intel.com/config)
> compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab5=
1eccf88f5321e7c60591c5546b254b6afab99)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arch=
ive/20241212/202412120136.6OwbbtZf-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412120136.6OwbbtZf-lk=
p@intel.com/
>
> All errors (new ones prefixed by >>):
>
>     In file included from fs/btrfs/ordered-data.c:7:
>     In file included from include/linux/blkdev.h:9:
>     In file included from include/linux/blk_types.h:10:
>     In file included from include/linux/bvec.h:10:
>     In file included from include/linux/highmem.h:8:
>     In file included from include/linux/cacheflush.h:5:
>     In file included from arch/x86/include/asm/cacheflush.h:5:
>     In file included from include/linux/mm.h:2223:
>     include/linux/vmstat.h:518:36: warning: arithmetic between different=
 enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enu=
m-conversion]
>       518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // ski=
p "nr_"
>           |                               ~~~~~~~~~~~ ^ ~~~
>>> fs/btrfs/ordered-data.c:200:10: error: no member named 'finished_bitma=
p' in 'struct btrfs_ordered_extent'
>       200 |                 entry->finished_bitmap =3D bitmap_zalloc(
>           |                 ~~~~~  ^

I don't know why but it looks like IS_ENABLED() is not exactly doing the
#ifdef #endif, thus those checks are not fully skipped in this case.

Anyway I'll change it to the more traditional #ifdef #endif instead.

Thanks for the report.
Qu

>     fs/btrfs/ordered-data.c:202:15: error: no member named 'finished_bit=
map' in 'struct btrfs_ordered_extent'
>       202 |                 if (!entry->finished_bitmap) {
>           |                      ~~~~~  ^
>     fs/btrfs/ordered-data.c:380:38: error: no member named 'finished_bit=
map' in 'struct btrfs_ordered_extent'
>       380 |                 nr_set =3D bitmap_count_set(ordered->finishe=
d_bitmap, start_bit, nbits);
>           |                                           ~~~~~~~  ^
>     fs/btrfs/ordered-data.c:388:17: error: no member named 'finished_bit=
map' in 'struct btrfs_ordered_extent'
>       388 |                                    ordered->finished_bitmap)=
;
>           |                                    ~~~~~~~  ^
>     fs/btrfs/messages.h:44:41: note: expanded from macro 'btrfs_crit'
>        44 |         btrfs_printk(fs_info, KERN_CRIT fmt, ##args)
>           |                                                ^~~~
>     fs/btrfs/messages.h:27:32: note: expanded from macro 'btrfs_printk'
>        27 |         _btrfs_printk(fs_info, fmt, ##args)
>           |                                       ^~~~
>     fs/btrfs/ordered-data.c:390:23: error: no member named 'finished_bit=
map' in 'struct btrfs_ordered_extent'
>       390 |                 bitmap_set(ordered->finished_bitmap, start_b=
it, nbits);
>           |                            ~~~~~~~  ^
>     fs/btrfs/ordered-data.c:418:37: error: no member named 'finished_bit=
map' in 'struct btrfs_ordered_extent'
>       418 |                 if (WARN_ON(!bitmap_full(ordered->finished_b=
itmap,
>           |                                          ~~~~~~~  ^
>     include/asm-generic/bug.h:123:25: note: expanded from macro 'WARN_ON=
'
>       123 |         int __ret_warn_on =3D !!(condition);                =
              \
>           |                                ^~~~~~~~~
>     fs/btrfs/ordered-data.c:426:14: error: no member named 'finished_bit=
map' in 'struct btrfs_ordered_extent'
>       426 |                                 ordered->finished_bitmap);
>           |                                 ~~~~~~~  ^
>     fs/btrfs/messages.h:44:41: note: expanded from macro 'btrfs_crit'
>        44 |         btrfs_printk(fs_info, KERN_CRIT fmt, ##args)
>           |                                                ^~~~
>     fs/btrfs/messages.h:27:32: note: expanded from macro 'btrfs_printk'
>        27 |         _btrfs_printk(fs_info, fmt, ##args)
>           |                                       ^~~~
>     fs/btrfs/ordered-data.c:675:23: error: no member named 'finished_bit=
map' in 'struct btrfs_ordered_extent'
>       675 |                         bitmap_free(entry->finished_bitmap);
>           |                                     ~~~~~  ^
>     1 warning and 8 errors generated.
>
>
> vim +200 fs/btrfs/ordered-data.c
>
>     147
>     148	static struct btrfs_ordered_extent *alloc_ordered_extent(
>     149				struct btrfs_inode *inode, u64 file_offset, u64 num_bytes,
>     150				u64 ram_bytes, u64 disk_bytenr, u64 disk_num_bytes,
>     151				u64 offset, unsigned long flags, int compress_type)
>     152	{
>     153		struct btrfs_ordered_extent *entry;
>     154		int ret;
>     155		u64 qgroup_rsv =3D 0;
>     156
>     157		if (flags &
>     158		    ((1 << BTRFS_ORDERED_NOCOW) | (1 << BTRFS_ORDERED_PREALLOC)=
)) {
>     159			/* For nocow write, we can release the qgroup rsv right now */
>     160			ret =3D btrfs_qgroup_free_data(inode, NULL, file_offset, num_b=
ytes, &qgroup_rsv);
>     161			if (ret < 0)
>     162				return ERR_PTR(ret);
>     163		} else {
>     164			/*
>     165			 * The ordered extent has reserved qgroup space, release now
>     166			 * and pass the reserved number for qgroup_record to free.
>     167			 */
>     168			ret =3D btrfs_qgroup_release_data(inode, file_offset, num_byte=
s, &qgroup_rsv);
>     169			if (ret < 0)
>     170				return ERR_PTR(ret);
>     171		}
>     172		entry =3D kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOF=
S);
>     173		if (!entry)
>     174			return ERR_PTR(-ENOMEM);
>     175
>     176		entry->file_offset =3D file_offset;
>     177		entry->num_bytes =3D num_bytes;
>     178		entry->ram_bytes =3D ram_bytes;
>     179		entry->disk_bytenr =3D disk_bytenr;
>     180		entry->disk_num_bytes =3D disk_num_bytes;
>     181		entry->offset =3D offset;
>     182		entry->bytes_left =3D num_bytes;
>     183		entry->inode =3D BTRFS_I(igrab(&inode->vfs_inode));
>     184		entry->compress_type =3D compress_type;
>     185		entry->truncated_len =3D (u64)-1;
>     186		entry->qgroup_rsv =3D qgroup_rsv;
>     187		entry->flags =3D flags;
>     188		refcount_set(&entry->refs, 1);
>     189		init_waitqueue_head(&entry->wait);
>     190		INIT_LIST_HEAD(&entry->list);
>     191		INIT_LIST_HEAD(&entry->log_list);
>     192		INIT_LIST_HEAD(&entry->root_extent_list);
>     193		INIT_LIST_HEAD(&entry->work_list);
>     194		INIT_LIST_HEAD(&entry->bioc_list);
>     195		init_completion(&entry->completion);
>     196
>     197		if (IS_ENABLED(CONFIG_BTRFS_DEBUG)) {
>     198			struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>     199
>   > 200			entry->finished_bitmap =3D bitmap_zalloc(
>     201				num_bytes >> fs_info->sectorsize_bits, GFP_NOFS);
>     202			if (!entry->finished_bitmap) {
>     203				kmem_cache_free(btrfs_ordered_extent_cache, entry);
>     204				return ERR_PTR(-ENOMEM);
>     205			}
>     206		}
>     207		/*
>     208		 * We don't need the count_max_extents here, we can assume that=
 all of
>     209		 * that work has been done at higher layers, so this is truly t=
he
>     210		 * smallest the extent is going to get.
>     211		 */
>     212		spin_lock(&inode->lock);
>     213		btrfs_mod_outstanding_extents(inode, 1);
>     214		spin_unlock(&inode->lock);
>     215
>     216		return entry;
>     217	}
>     218
>


