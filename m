Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4E0262DDA
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 13:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgIILaw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 07:30:52 -0400
Received: from mout.gmx.net ([212.227.17.21]:55571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728709AbgIILaG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 07:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599651001;
        bh=M1r5ExNnhKog920VWZtVkoKuibSH4hHRBwOyk41QuuE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=hHYdiy8CPf3gcdNNFq7C8UV/Sexhfn0DCmHRLJl3Z25G7F8JDylYz/9k3D8HYAKUR
         zBefMRuY6bg4r8+KIAws22HIYrJQOJtf1nBDym05vCkh1kCXW8rj/I78UPxMnx0XiP
         VRwJs+0o2kbEJmvTmonKEOioHo4hOenWZSAaO3J4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MlNtF-1kwxmN1Mgn-00lp7l; Wed, 09
 Sep 2020 13:15:11 +0200
Subject: Re: [PATCH 02/10] btrfs: Remove pg_offset from btrfs_get_extent
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200909094914.29721-1-nborisov@suse.com>
 <20200909094914.29721-3-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <450bcec0-4571-8ecc-a2ff-4bfb3b905bdb@gmx.com>
Date:   Wed, 9 Sep 2020 19:15:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909094914.29721-3-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4b/SvjE62NP/fb7SrmANr5lWcf8BukvoUl7vJ1A+lsiPT3LVdf9
 a8OU1Cu/PG7k92BqNa8D108+RXwMtIE3kL24v6dxHLEJvpKNibRcte4JKlq8jJg11jBVWtQ
 6cBNAhIzuYYFw7bK0/KY2u+v1FHac0Rx6h5JFy9o0OCdAMGpVhzdqt7wQpQ1P7fGmXtJd87
 kUkp2+0NTWwsC9qmo6JJQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pgVTafHyaWk=:gtRaZvZEyPf+7NumN1/Qtt
 HlC1glJ0dRNksfqhLz9JQO++p8mQIJp25YeHsosDT2eOHhruBcUJuzesDuzfwTZO+nhfTaWEy
 dFRsbUCSeGcNZdKsg6MMPef45DqWQzRF8DigHEaTFCFo7KqrwWQy4YJ2/5uF33L5cmkFGf9+V
 oD6CADnCbiaO4dNJSAW0ZHrjaJJLj6qJgrs1XiaBAwQ5BwHab1l8DIxG0Wf4P9OH9mj+VR5Sx
 yG4st0Y5u+wzFplOtP7BKmOMXDHFix6KZ6Nni4URFYh0qNnlTw7TcgsFz3Z9T8+PzKODRdInj
 TrbgCeKlhcp5idORIc/DoqNgPhp5C7jmctJ7qNI7O4CbZx6XoTtFBjJbjdNBDi/J1fYEUH3k3
 6kU2rG0ka1sdvCiW27QyDagg+caz9oetTiIsQTP6A5wHS8C3QMNZrLYWDxWKHb+I/dDQdckat
 gKYa8T+H3fJCAqGq0rZxcJyQDWScbspzTuGeuIocJlJWRn1OhfGlBqRvshJnD0r1VC20+1S14
 3hvQCB2gHOjsgBhMnl1slDwjABgdBJ1+sNQrFh7D+ggmOrZgZXdjFmtN71xoS8FQixbBTESEk
 kEsf2of54Ec9hdj+6GubOfZhtnASw0FcxOPkx02ats1jxKltF5mzEwFSV5zNoMD1Zk50CtR0i
 4ewgHSXpCOdMx/RrfrV4YesoMkAPlvXEjtjBFRtmnENBRrIp/8zgfezg3LCgRCfWZXnYro4KZ
 +l73twNAVcoIjBvP5/nNtt3eyh4b/D8HgpZ6tIZtrZ0BPwYoFJ23Ji0aH0DD/JrqTHbsHSXEH
 ZsORhzGWf41v8aHC5aPOdzrmpTl5N/GKR9NXr+67ICLe9sOUju9ZkWS3QD7WvKgziw1WWysIa
 14JjjOrMclKLgNgj6A8uSzYWF/zgiA9kXrwBhpcBzelRlI6mtR5pdi3AcG6At0+8bkbjkyese
 pZf3DaTSGjL9l8KYouovog90MnwGrg9wAWhi4eWeozS5senAhIVLdCJJD5qS10y+7QhaP5mSJ
 f+2Z/PTsZj2pTPz5jen4ClAjokLw33fjf3/mdMP1P8yme09AsPaKZcOWIgt19GcbedefZvesj
 3Dj2csPwErdKeHQt0AAXjzWhUrZ2u62CV6cVqbezd4uf0FAheN9iWoiHEFlg+mYjoHyy3ZcHV
 PhusA3+sySjXV0kqdvvdgQiFUmTX0poTnzxjK7C6bUeXqurs+i6ZKvnfCPg55R3YrvawVcOx3
 YPS4yoRsOOmc8E3D982YO97cVj8qiKm89VM+UQA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/9 =E4=B8=8B=E5=8D=885:49, Nikolay Borisov wrote:
> Btrfs doesn't support subpage blocksize io as such pg_offset is always
> zero. Remove this argument to cleanup the parameter list.

Oh, I prefer not to remove it, as the subpage support is not that far away=
.

Especially data subpage read just needs a few very small patches to
enable...

Thanks,
Qu
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/ctree.h             |  3 +--
>  fs/btrfs/disk-io.c           |  3 +--
>  fs/btrfs/disk-io.h           |  3 +--
>  fs/btrfs/extent_io.c         |  8 ++++---
>  fs/btrfs/extent_io.h         |  4 ++--
>  fs/btrfs/file.c              | 12 +++++------
>  fs/btrfs/inode.c             | 28 +++++++++++-------------
>  fs/btrfs/ioctl.c             |  2 +-
>  fs/btrfs/tests/inode-tests.c | 42 ++++++++++++++++++------------------
>  9 files changed, 50 insertions(+), 55 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 98c5f6178efc..7c7afa823f71 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3000,8 +3000,7 @@ struct inode *btrfs_iget_path(struct super_block *=
s, u64 ino,
>  			      struct btrfs_root *root, struct btrfs_path *path);
>  struct inode *btrfs_iget(struct super_block *s, u64 ino, struct btrfs_r=
oot *root);
>  struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
> -				    struct page *page, size_t pg_offset,
> -				    u64 start, u64 end);
> +				    struct page *page, u64 start, u64 end);
>  int btrfs_update_inode(struct btrfs_trans_handle *trans,
>  			      struct btrfs_root *root,
>  			      struct inode *inode);
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index d63498f3c75f..c6c9b6b13bf0 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -209,8 +209,7 @@ void btrfs_set_buffer_lockdep_class(u64 objectid, st=
ruct extent_buffer *eb,
>   * that covers the entire device
>   */
>  struct extent_map *btree_get_extent(struct btrfs_inode *inode,
> -				    struct page *page, size_t pg_offset,
> -				    u64 start, u64 len)
> +				    struct page *page, u64 start, u64 len)
>  {
>  	struct extent_map_tree *em_tree =3D &inode->extent_tree;
>  	struct extent_map *em;
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 00dc39d47ed3..dbc8c353c86c 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -124,8 +124,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_tr=
ans_handle *trans,
>  int btree_lock_page_hook(struct page *page, void *data,
>  				void (*flush_fn)(void *));
>  struct extent_map *btree_get_extent(struct btrfs_inode *inode,
> -				    struct page *page, size_t pg_offset,
> -				    u64 start, u64 len);
> +				    struct page *page, u64 start, u64 len);
>  int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags);
>  int __init btrfs_end_io_wq_init(void);
>  void __cold btrfs_end_io_wq_exit(void);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index a1e070ec7ad8..ac92c0ab1402 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3127,7 +3127,7 @@ __get_extent_map(struct inode *inode, struct page =
*page, size_t pg_offset,
>  		*em_cached =3D NULL;
>  	}
>
> -	em =3D get_extent(BTRFS_I(inode), page, pg_offset, start, len);
> +	em =3D get_extent(BTRFS_I(inode), page, start, len);
>  	if (em_cached && !IS_ERR_OR_NULL(em)) {
>  		BUG_ON(*em_cached);
>  		refcount_inc(&em->refs);
> @@ -3161,7 +3161,7 @@ static int __do_readpage(struct page *page,
>  	int ret =3D 0;
>  	int nr =3D 0;
>  	size_t pg_offset =3D 0;
> -	size_t iosize;
> +	size_t iosize =3D 0;
>  	size_t disk_io_size;
>  	size_t blocksize =3D inode->i_sb->s_blocksize;
>  	unsigned long this_bio_flag =3D 0;
> @@ -3208,6 +3208,8 @@ static int __do_readpage(struct page *page,
>  					     cur + iosize - 1, &cached);
>  			break;
>  		}
> +		if (pg_offset !=3D 0)
> +			trace_printk("PG offset: %lu iosize: %lu\n", pg_offset, iosize);
>  		em =3D __get_extent_map(inode, page, pg_offset, cur,
>  				      end - cur + 1, get_extent, em_cached);
>  		if (IS_ERR_OR_NULL(em)) {
> @@ -3540,7 +3542,7 @@ static noinline_for_stack int __extent_writepage_i=
o(struct btrfs_inode *inode,
>  							     page_end, 1);
>  			break;
>  		}
> -		em =3D btrfs_get_extent(inode, NULL, 0, cur, end - cur + 1);
> +		em =3D btrfs_get_extent(inode, NULL, cur, end - cur + 1);
>  		if (IS_ERR_OR_NULL(em)) {
>  			SetPageError(page);
>  			ret =3D PTR_ERR_OR_ZERO(em);
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 06611947a9f7..41621731a4fe 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -187,8 +187,8 @@ static inline int extent_compress_type(unsigned long=
 bio_flags)
>  struct extent_map_tree;
>
>  typedef struct extent_map *(get_extent_t)(struct btrfs_inode *inode,
> -					  struct page *page, size_t pg_offset,
> -					  u64 start, u64 len);
> +					  struct page *page, u64 start,
> +					  u64 len);
>
>  int try_release_extent_mapping(struct page *page, gfp_t mask);
>  int try_release_extent_buffer(struct page *page);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index af4eab9cbc51..0020c6780035 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -466,7 +466,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrf=
s_inode *inode,
>  		u64 em_len;
>  		int ret =3D 0;
>
> -		em =3D btrfs_get_extent(inode, NULL, 0, search_start, search_len);
> +		em =3D btrfs_get_extent(inode, NULL, search_start, search_len);
>  		if (IS_ERR(em))
>  			return PTR_ERR(em);
>
> @@ -2511,7 +2511,7 @@ static int find_first_non_hole(struct inode *inode=
, u64 *start, u64 *len)
>  	struct extent_map *em;
>  	int ret =3D 0;
>
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0,
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL,
>  			      round_down(*start, fs_info->sectorsize),
>  			      round_up(*len, fs_info->sectorsize));
>  	if (IS_ERR(em))
> @@ -3113,7 +3113,7 @@ static int btrfs_zero_range_check_range_boundary(s=
truct btrfs_inode *inode,
>  	int ret;
>
>  	offset =3D round_down(offset, sectorsize);
> -	em =3D btrfs_get_extent(inode, NULL, 0, offset, sectorsize);
> +	em =3D btrfs_get_extent(inode, NULL, offset, sectorsize);
>  	if (IS_ERR(em))
>  		return PTR_ERR(em);
>
> @@ -3146,7 +3146,7 @@ static int btrfs_zero_range(struct inode *inode,
>
>  	inode_dio_wait(inode);
>
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, alloc_start,
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, alloc_start,
>  			      alloc_end - alloc_start);
>  	if (IS_ERR(em)) {
>  		ret =3D PTR_ERR(em);
> @@ -3190,7 +3190,7 @@ static int btrfs_zero_range(struct inode *inode,
>
>  	if (BTRFS_BYTES_TO_BLKS(fs_info, offset) =3D=3D
>  	    BTRFS_BYTES_TO_BLKS(fs_info, offset + len - 1)) {
> -		em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, alloc_start,
> +		em =3D btrfs_get_extent(BTRFS_I(inode), NULL, alloc_start,
>  				      sectorsize);
>  		if (IS_ERR(em)) {
>  			ret =3D PTR_ERR(em);
> @@ -3430,7 +3430,7 @@ static long btrfs_fallocate(struct file *file, int=
 mode,
>  	/* First, check if we exceed the qgroup limit */
>  	INIT_LIST_HEAD(&reserve_list);
>  	while (cur_offset < alloc_end) {
> -		em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, cur_offset,
> +		em =3D btrfs_get_extent(BTRFS_I(inode), NULL, cur_offset,
>  				      alloc_end - cur_offset);
>  		if (IS_ERR(em)) {
>  			ret =3D PTR_ERR(em);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index cce6f8789a4e..a7b62b93246b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4722,7 +4722,7 @@ int btrfs_cont_expand(struct inode *inode, loff_t =
oldsize, loff_t size)
>  					   block_end - 1, &cached_state);
>  	cur_offset =3D hole_start;
>  	while (1) {
> -		em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, cur_offset,
> +		em =3D btrfs_get_extent(BTRFS_I(inode), NULL, cur_offset,
>  				      block_end - cur_offset);
>  		if (IS_ERR(em)) {
>  			err =3D PTR_ERR(em);
> @@ -6530,8 +6530,7 @@ static noinline int uncompress_inline(struct btrfs=
_path *path,
>   * Return: ERR_PTR on error, non-NULL extent_map on success.
>   */
>  struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
> -				    struct page *page, size_t pg_offset,
> -				    u64 start, u64 len)
> +				    struct page *page, u64 start, u64 len)
>  {
>  	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>  	int ret =3D 0;
> @@ -6678,9 +6677,8 @@ struct extent_map *btrfs_get_extent(struct btrfs_i=
node *inode,
>  			goto out;
>
>  		size =3D btrfs_file_extent_ram_bytes(leaf, item);
> -		extent_offset =3D page_offset(page) + pg_offset - extent_start;
> -		copy_size =3D min_t(u64, PAGE_SIZE - pg_offset,
> -				  size - extent_offset);
> +		extent_offset =3D page_offset(page) - extent_start;
> +		copy_size =3D min_t(u64, PAGE_SIZE, size - extent_offset);
>  		em->start =3D extent_start + extent_offset;
>  		em->len =3D ALIGN(copy_size, fs_info->sectorsize);
>  		em->orig_block_len =3D em->len;
> @@ -6691,18 +6689,16 @@ struct extent_map *btrfs_get_extent(struct btrfs=
_inode *inode,
>  		if (!PageUptodate(page)) {
>  			if (btrfs_file_extent_compression(leaf, item) !=3D
>  			    BTRFS_COMPRESS_NONE) {
> -				ret =3D uncompress_inline(path, page, pg_offset,
> +				ret =3D uncompress_inline(path, page, 0,
>  							extent_offset, item);
>  				if (ret)
>  					goto out;
>  			} else {
>  				map =3D kmap(page);
> -				read_extent_buffer(leaf, map + pg_offset, ptr,
> -						   copy_size);
> -				if (pg_offset + copy_size < PAGE_SIZE) {
> -					memset(map + pg_offset + copy_size, 0,
> -					       PAGE_SIZE - pg_offset -
> -					       copy_size);
> +				read_extent_buffer(leaf, map, ptr, copy_size);
> +				if (copy_size < PAGE_SIZE) {
> +					memset(map + copy_size, 0,
> +					       PAGE_SIZE - copy_size);
>  				}
>  				kunmap(page);
>  			}
> @@ -6754,7 +6750,7 @@ struct extent_map *btrfs_get_extent_fiemap(struct =
btrfs_inode *inode,
>  	u64 delalloc_end;
>  	int err =3D 0;
>
> -	em =3D btrfs_get_extent(inode, NULL, 0, start, len);
> +	em =3D btrfs_get_extent(inode, NULL, start, len);
>  	if (IS_ERR(em))
>  		return em;
>  	/*
> @@ -7397,7 +7393,7 @@ static int btrfs_dio_iomap_begin(struct inode *ino=
de, loff_t start,
>  		goto err;
>  	}
>
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, start, len);
>  	if (IS_ERR(em)) {
>  		ret =3D PTR_ERR(em);
>  		goto unlock_err;
> @@ -10044,7 +10040,7 @@ static int btrfs_swap_activate(struct swap_info_=
struct *sis, struct file *file,
>  		struct btrfs_block_group *bg;
>  		u64 len =3D isize - start;
>
> -		em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len);
> +		em =3D btrfs_get_extent(BTRFS_I(inode), NULL, start, len);
>  		if (IS_ERR(em)) {
>  			ret =3D PTR_ERR(em);
>  			goto out;
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index b31949df7bfc..31ebbe918156 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1162,7 +1162,7 @@ static struct extent_map *defrag_lookup_extent(str=
uct inode *inode, u64 start)
>
>  		/* get the big lock and read metadata off disk */
>  		lock_extent_bits(io_tree, start, end, &cached);
> -		em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len);
> +		em =3D btrfs_get_extent(BTRFS_I(inode), NULL, start, len);
>  		unlock_extent_cached(io_tree, start, end, &cached);
>
>  		if (IS_ERR(em))
> diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
> index 894a63a92236..6bcb392e7367 100644
> --- a/fs/btrfs/tests/inode-tests.c
> +++ b/fs/btrfs/tests/inode-tests.c
> @@ -263,7 +263,7 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>
>  	/* First with no extents */
>  	BTRFS_I(inode)->root =3D root;
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, 0, sectorsize);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, sectorsize);
>  	if (IS_ERR(em)) {
>  		em =3D NULL;
>  		test_err("got an error when we shouldn't have");
> @@ -283,7 +283,7 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>  	 */
>  	setup_file_extents(root, sectorsize);
>
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, 0, (u64)-1);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, (u64)-1);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
> @@ -305,7 +305,7 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>  	offset =3D em->start + em->len;
>  	free_extent_map(em);
>
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
> @@ -333,7 +333,7 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>  	offset =3D em->start + em->len;
>  	free_extent_map(em);
>
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
> @@ -356,7 +356,7 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>  	free_extent_map(em);
>
>  	/* Regular extent */
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
> @@ -384,7 +384,7 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>  	free_extent_map(em);
>
>  	/* The next 3 are split extents */
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
> @@ -413,7 +413,7 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>  	offset =3D em->start + em->len;
>  	free_extent_map(em);
>
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
> @@ -435,7 +435,7 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>  	offset =3D em->start + em->len;
>  	free_extent_map(em);
>
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
> @@ -469,7 +469,7 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>  	free_extent_map(em);
>
>  	/* Prealloc extent */
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
> @@ -498,7 +498,7 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>  	free_extent_map(em);
>
>  	/* The next 3 are a half written prealloc extent */
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
> @@ -528,7 +528,7 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>  	offset =3D em->start + em->len;
>  	free_extent_map(em);
>
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
> @@ -561,7 +561,7 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>  	offset =3D em->start + em->len;
>  	free_extent_map(em);
>
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
> @@ -596,7 +596,7 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>  	free_extent_map(em);
>
>  	/* Now for the compressed extent */
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
> @@ -630,7 +630,7 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>  	free_extent_map(em);
>
>  	/* Split compressed extent */
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
> @@ -665,7 +665,7 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>  	offset =3D em->start + em->len;
>  	free_extent_map(em);
>
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
> @@ -692,7 +692,7 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>  	offset =3D em->start + em->len;
>  	free_extent_map(em);
>
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
> @@ -727,7 +727,7 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>  	free_extent_map(em);
>
>  	/* A hole between regular extents but no hole extent */
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset + 6, sectorsiz=
e);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, offset + 6, sectorsize);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
> @@ -754,7 +754,7 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>  	offset =3D em->start + em->len;
>  	free_extent_map(em);
>
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, SZ_4M);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, offset, SZ_4M);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
> @@ -787,7 +787,7 @@ static noinline int test_btrfs_get_extent(u32 sector=
size, u32 nodesize)
>  	offset =3D em->start + em->len;
>  	free_extent_map(em);
>
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
> @@ -871,7 +871,7 @@ static int test_hole_first(u32 sectorsize, u32 nodes=
ize)
>  	insert_inode_item_key(root);
>  	insert_extent(root, sectorsize, sectorsize, sectorsize, 0, sectorsize,
>  		      sectorsize, BTRFS_FILE_EXTENT_REG, 0, 1);
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, 0, 2 * sectorsize);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, 2 * sectorsize);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
> @@ -893,7 +893,7 @@ static int test_hole_first(u32 sectorsize, u32 nodes=
ize)
>  	}
>  	free_extent_map(em);
>
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, sectorsize, 2 * secto=
rsize);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, sectorsize, 2 * sectorsi=
ze);
>  	if (IS_ERR(em)) {
>  		test_err("got an error when we shouldn't have");
>  		goto out;
>
