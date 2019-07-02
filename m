Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B897D5C710
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 04:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfGBCUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jul 2019 22:20:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:60349 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfGBCUY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jul 2019 22:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562034018;
        bh=OJw8+ZSQcuJSORDsPjtuOpIdTdSd8qLgMf/7xqJzR+c=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Tgu+W582Oke1Z9BbOQdpDiG6IBnRnLbbwu65rYSsdh/p6ytemQxnCLcoH6Mtft2ZY
         kXKH1pOk37HtykHhq3iFl67XcGLty0cl6sp2e9B/x8Ko1c9BnFQWXN2om5LpzTFUZG
         X0hucjrpuozVG7MxSn+tDr3JtpcMCnawK/Zql3vk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MryT9-1iMufM1U17-00nupB; Tue, 02
 Jul 2019 04:20:18 +0200
Subject: Re: [PATCH 1/2] btrfs: Return number of compressed extents directly
 in compress_file_range
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190701165055.15483-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <bc079d86-bffb-c952-8156-1cdca9fca08d@gmx.com>
Date:   Tue, 2 Jul 2019 10:20:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190701165055.15483-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iyHIcGLNOokhP+sY2aHUrWhl1KjJSgGmyHdw/QE9kPW38mPWUey
 lw7Sm0HaStQn3LWMjCrgcbcwX1EUsRo1VoV9HevcvJv1DqwdJmj6jlQwBY75KgfEnRYXnl3
 DrCk+iVOI0r4m2a+W+6OlS4QmNfC+OPYtml3rLgfvnjwExFD/aYO2svt5LsEmK5/r0p68vW
 Of/NXuGAxGvwhZoDt30iQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bKL1vW553tM=:gkUQua85STLU5mQJkct5jV
 lL7rK0r6GZLFFUvXJqs5SSwJBFa/ODQq/6ypoKe8ot0Jam6zxYgy+xhNMpWdEp11p1byCW6Hm
 quetcGbKK8iuw/2bljcdPzAV7TUQCrmrTB//yRDy72ZSH1TJVj+UlfPyxzB3y+sHYsXuu3mxR
 MR1X8z5gG6BsIXS8zQFw6hZLhZxUdunovBkxPdnHdo3thYIffLBgejxZj4fnjNf59YHG1kBwX
 KpA13sDaf9Rs2PnTNTtQI/3Mk2+sPIrN+vTNwwRH3uFPrD8oukJvpBnylzZ9kB2zkBNfrhSVS
 lkswFr7lsXcE4GxO2FQX8d2nqt+4zkSMQ6N/zcpj8W1DuooHCdLaQb/xpwXztk51gR9ubg81X
 bJkRIEe3ZUYwmylwYZipHJ/95DvvQl/PypJsl2SSr09MZ1xnt/7+K/MnUEjl4RUzRsHVnZgoF
 /0w/wD5ZOXiFdknlbYsD/746doHsuyFyUr86WL8Ny0RaP9QbvfGNdWpuH9+5MPQQtYqHNlXdm
 U4ZZq6cb59b0bbgawScIVwLZ07x+B+4jtLsy8kyG1C1VQjaxD5C72IUK1F+ReH7+IvZ2xNnyM
 D760TOX1GDHdFizKTCinRSyHKzn7swthTuYHYVytFuF8hTimy7A/C9JhlXaQVfABX6YA8zCQ5
 U+QxZq/WaVbPIfDWQzzeRbOtkUvdxQNdKDprUDtyveKmXsx2pKkT4zUHXTdDJ6lORe9p3N8TV
 aLPpSrM1+1cNhEctJJoMg8/K+U8RHhu+ZVEQEJFjo0RbyJRSdrpYPwBCBDhXC6Qu4nRmEdNwU
 Irry51RNUfwP/ruhw8QppLcvyVhQxFzG2ruoFmsiPbWiIBXYl5N3DEJ3JoLoa62kj3ax1P2Cf
 sV4biW3StJnwVdYLhRtVN+8zD3OWn/ClChYDLnR4GcIOG/IoEZj2JfPy/JLkS4wmNkpiQzNcZ
 aEAAmLwx13aiAZq6UdjgILyV6eK7+DqX1CmxH8txOtum7lXXLiw2ZU8pK4dNOd/r+xdYTb/NN
 zz8Z2ae6r61vnE5tj6BP7qB4u3H/E21W/6IERV/fuZX8Z8wLBf4Li5xRIpXScUIiT6swjtYB6
 9sd6x3Zktg3QRPVFlXh3epjjXAKsVkDkmLd
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/2 =E4=B8=8A=E5=8D=8812:50, Nikolay Borisov wrote:
> compress_file_range returns a void, yet uses a function parameter as a
> return value. Make that more idiomatic by simply returning the number
> of compressed extents directly. Also track such extents in more aptly
> named variables. No functional changes
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/inode.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4e183c2d3555..3b0bf5ea9eb6 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -440,8 +440,7 @@ static inline void inode_should_defrag(struct btrfs_=
inode *inode,
>   * are written in the same order that the flusher thread sent them
>   * down.
>   */
> -static noinline void compress_file_range(struct async_chunk *async_chun=
k,
> -					 int *num_added)
> +static noinline int compress_file_range(struct async_chunk *async_chunk=
)
>  {
>  	struct inode *inode =3D async_chunk->inode;
>  	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> @@ -457,6 +456,7 @@ static noinline void compress_file_range(struct asyn=
c_chunk *async_chunk,
>  	int i;
>  	int will_compress;
>  	int compress_type =3D fs_info->compress_type;
> +	int compressed_extents =3D 0;
>  	int redirty =3D 0;
>
>  	inode_should_defrag(BTRFS_I(inode), start, end, end - start + 1,
> @@ -619,7 +619,7 @@ static noinline void compress_file_range(struct asyn=
c_chunk *async_chunk,
>  		 */
>  		total_in =3D ALIGN(total_in, PAGE_SIZE);
>  		if (total_compressed + blocksize <=3D total_in) {
> -			*num_added +=3D 1;
> +			compressed_extents +=3D 1;
>
>  			/*
>  			 * The async work queues will take care of doing actual
> @@ -636,7 +636,7 @@ static noinline void compress_file_range(struct asyn=
c_chunk *async_chunk,
>  				cond_resched();
>  				goto again;
>  			}
> -			return;
> +			return compressed_extents;
>  		}
>  	}
>  	if (pages) {
> @@ -675,9 +675,9 @@ static noinline void compress_file_range(struct asyn=
c_chunk *async_chunk,
>  		extent_range_redirty_for_io(inode, start, end);
>  	add_async_extent(async_chunk, start, end - start + 1, 0, NULL, 0,
>  			 BTRFS_COMPRESS_NONE);
> -	*num_added +=3D 1;
> +	compressed_extents +=3D 1;
>
> -	return;
> +	return compressed_extents;
>
>  free_pages_out:
>  	for (i =3D 0; i < nr_pages; i++) {
> @@ -685,6 +685,8 @@ static noinline void compress_file_range(struct asyn=
c_chunk *async_chunk,
>  		put_page(pages[i]);
>  	}
>  	kfree(pages);
> +
> +	return 0;
>  }
>
>  static void free_async_extent_pages(struct async_extent *async_extent)
> @@ -1122,12 +1124,12 @@ static noinline int cow_file_range(struct inode =
*inode,
>  static noinline void async_cow_start(struct btrfs_work *work)
>  {
>  	struct async_chunk *async_chunk;
> -	int num_added =3D 0;
> +	int compressed_extents =3D 0;
>
>  	async_chunk =3D container_of(work, struct async_chunk, work);
>
> -	compress_file_range(async_chunk, &num_added);
> -	if (num_added =3D=3D 0) {
> +	compressed_extents =3D compress_file_range(async_chunk);
> +	if (compressed_extents =3D=3D 0) {
>  		btrfs_add_delayed_iput(async_chunk->inode);
>  		async_chunk->inode =3D NULL;
>  	}
>
