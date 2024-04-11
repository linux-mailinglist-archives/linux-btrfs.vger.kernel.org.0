Return-Path: <linux-btrfs+bounces-4170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D52168A2225
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 01:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878612881EC
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 23:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9987947A79;
	Thu, 11 Apr 2024 23:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="YbLXkdDe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6634779E
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877305; cv=none; b=ei2TSLxDGwWMIYEymPb+Xlv7bU2EBedzNzGFkUmUXgIj/jA1EaEHxCERJxtIiuCVu7DCjJyDrXoQn5vTSMJQQb35DX7uPO0GusWJWi5N8fsaIfkVJaM+o306XhYo+ONGTHpKfSzQ2aH5CbFxFNzHEQu22R4eaA0d+vzyAx6uCqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877305; c=relaxed/simple;
	bh=vQc6N3SQ3WS8ujf7Tzea0ghWVIEaX2FxfFtnzLiMdQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X7ewmnBnHp8ak1dwmt6dP72OX2aB3zxJCN5g0fs0oXp12paqDe/TrZezVDwkhJG14heOfCBcseIm/p95Ipv2g6XnAWNZ+kWZsRkErNIYmmLCLmPJfAlJq/vsbblsXUT7LWciioDbMc9o+X6HJ4t0F8RWGYlrru/xyvyAkNG4i/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=YbLXkdDe; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712877296; x=1713482096; i=quwenruo.btrfs@gmx.com;
	bh=XHfNiInczrP38SpUI8Yr0Lal8lCyFnTztLFXM5fTCC8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YbLXkdDe2TaPrIRWXQ19BFIoiz7RRbYnS7UwvQTlVj4TI71G7ilmPZVwztep6Oc8
	 6xy9H0eU7AWecqRcpByVbMWg+DAUb7TCz9pmeHxS+iQoJc9H2Ddi7QV3Cxs0X/bdJ
	 XOOKzyq1d88YRvJ95+4SNJ4psGRU+r/BQb8amLIb9SbAS4tTyEHmXem98jUfjBZpX
	 OWHOFGZ0uFc8H8iSiHdl6Ad0nsU6N8HLLWcO3uQbUZ7jAG6cOjwOtOowUW8MZEygd
	 L3ecDfy2rW+JT8cpsUOB15KmJbIlNG8wmyjEXFSXlF9b7BJt9lLR7dfJMTsLrjxXa
	 aAwLINM5n/Vk77osLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MS3il-1sJy3o45IR-00TVyC; Fri, 12
 Apr 2024 01:14:56 +0200
Message-ID: <cafbc026-9b94-4dd4-be89-577f416a2624@gmx.com>
Date: Fri, 12 Apr 2024 08:44:52 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] btrfs: export find_next_inode() as
 btrfs_find_first_inode()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1712837044.git.fdmanana@suse.com>
 <f6020d8c33aeea495917c26b26812dda8eb27a12.1712837044.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <f6020d8c33aeea495917c26b26812dda8eb27a12.1712837044.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7IVqaUCvl21NuJD6GBu5QA/Mi176MjV2leshdo7nM/35/2vrd7B
 B5cWiU4nuKFIRiVhqtjxDFwxV69SfVHn5RpOi8rc6ZN+Xf5h6d+YfLXPrYnmekJHRu9PBT7
 uFq+x0uhWYKdjG0Sv8n71XZEjQXdbVcQXEuI7hcedj7NX9or6+ZYPGZLp6ztSHVo1bA7IIQ
 ZXXULi4iSY9NAAtOz9Gzw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yahrmocqJOc=;QyIBsWddLMKRFLWrolHJ64K786Q
 ByllAAoIxAxtogVSq8K/Nvypo0/WjtS54BKp4nfFM7/4lJI6B4j5ND4IB1MYeAp6D6opwX3Xu
 OyMfKkX3V2asjYdyxEXw/bgm6svzBUQMM61emYIUYBV8FG9/tjR2OMwoPexILo0jV9S01MZSw
 FbSEEfSA7LxRESSYBwi3E2UlTfPW0CVDf/17J00INlsfCGC5blAgQT+0arSiieUke7kfgtHAo
 j/irO9xm3YGwiiAB+D4wOpv7TBPsmdEbWS9yFC1/wwRuuCLOPnhv+6mgWJnnkNOWSh7BcfKh/
 Jl9PeHlF+RsZ3Nu1w9+qC1RgNRMpShXBzanbxLTdh+LNSC5h9j4je8qxfoB2N9ild55IQKz43
 Y6oPobiWQFzBTnsJ4bWH/D8h2IT8/L69geq2TvyVk2zcWmQfjAuGirfTvauma71W3PAgXhPy7
 FOEVJApN+MeYcOrFkyn0HWYkCRnZCOvShXxswBedUVcYAKCH27IYISRKNednHdDZ5ft712MbM
 dfgsg+EotdaJ5wQi+DuWPz80W5NXEcbigBhFvaA/mokL3Am3zmjrWzovO/Mx0tQkItQWR+zjz
 AL7MlppxcmN4d3dUyRFAf2t45y8uK4d3/8uXCwZE1a8xcBeMdY9LttyjNnTtPJ2Vpj+Kz/P2X
 lQUPhU9uYp/tq6Y+/JtRrEHaQ6XjC1mSGEXVqy+hmFlF36poG7lZ0eEznP0KkDZdJ4I0qOLwb
 fgASDPnVJkoO0F3ZkJsORxARV3Brkpa1+yfnrX8bE8u9uoNEmAjnnPArKufMBGi+R5bobpiLy
 kQ6UfUgGTUXg13UZPgx0/I1z3W+521bmvtAWzLCiqE0aQ=



=E5=9C=A8 2024/4/12 01:49, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Export the relocation private helper find_next_inode() to inode.c, as th=
is
> same logic is also used at btrfs_prune_dentries() and will be used by an
> upcoming change that adds an extent map shrinker. The next patch will
> change btrfs_prune_dentries() to use this helper.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/btrfs_inode.h |   1 +
>   fs/btrfs/inode.c       |  58 +++++++++++++++++++++++
>   fs/btrfs/relocation.c  | 105 ++++++++++-------------------------------
>   3 files changed, 84 insertions(+), 80 deletions(-)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index ed8bd15aa3e2..9a87ada7fe52 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -543,6 +543,7 @@ ssize_t btrfs_dio_read(struct kiocb *iocb, struct io=
v_iter *iter,
>   		       size_t done_before);
>   struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter =
*iter,
>   				  size_t done_before);
> +struct btrfs_inode *btrfs_find_first_inode(struct btrfs_root *root, u64=
 min_ino);
>
>   extern const struct dentry_operations btrfs_dentry_operations;
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d4539b4b8148..9dc41334c3a3 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -10827,6 +10827,64 @@ void btrfs_assert_inode_range_clean(struct btrf=
s_inode *inode, u64 start, u64 en
>   	ASSERT(ordered =3D=3D NULL);
>   }
>
> +/*
> + * Find the first inode with a minimum number.
> + *
> + * @root:	The root to search for.
> + * @min_ino:	The minimum inode number.
> + *
> + * Find the first inode in the @root with a number >=3D @min_ino and re=
turn it.
> + * Returns NULL if no such inode found.
> + */
> +struct btrfs_inode *btrfs_find_first_inode(struct btrfs_root *root, u64=
 min_ino)
> +{
> +	struct rb_node *node;
> +	struct rb_node *prev =3D NULL;
> +	struct btrfs_inode *inode;
> +
> +	spin_lock(&root->inode_lock);
> +again:
> +	node =3D root->inode_tree.rb_node;
> +	while (node) {
> +		prev =3D node;
> +		inode =3D rb_entry(node, struct btrfs_inode, rb_node);
> +		if (min_ino < btrfs_ino(inode))
> +			node =3D node->rb_left;
> +		else if (min_ino > btrfs_ino(inode))
> +			node =3D node->rb_right;
> +		else
> +			break;
> +	}
> +
> +	if (!node) {
> +		while (prev) {
> +			inode =3D rb_entry(prev, struct btrfs_inode, rb_node);
> +			if (min_ino <=3D btrfs_ino(inode)) {
> +				node =3D prev;
> +				break;
> +			}
> +			prev =3D rb_next(prev);
> +		}
> +	}
> +
> +	while (node) {
> +		inode =3D rb_entry(prev, struct btrfs_inode, rb_node);
> +		if (igrab(&inode->vfs_inode)) {
> +			spin_unlock(&root->inode_lock);
> +			return inode;
> +		}
> +
> +		min_ino =3D btrfs_ino(inode) + 1;
> +		if (cond_resched_lock(&root->inode_lock))
> +			goto again;
> +
> +		node =3D rb_next(node);
> +	}
> +	spin_unlock(&root->inode_lock);
> +
> +	return NULL;
> +}
> +
>   static const struct inode_operations btrfs_dir_inode_operations =3D {
>   	.getattr	=3D btrfs_getattr,
>   	.lookup		=3D btrfs_lookup,
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 5c9ef6717f84..5b19b41f64a2 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -951,60 +951,6 @@ int btrfs_update_reloc_root(struct btrfs_trans_hand=
le *trans,
>   	return ret;
>   }
>
> -/*
> - * helper to find first cached inode with inode number >=3D objectid
> - * in a subvolume
> - */
> -static struct inode *find_next_inode(struct btrfs_root *root, u64 objec=
tid)
> -{
> -	struct rb_node *node;
> -	struct rb_node *prev;
> -	struct btrfs_inode *entry;
> -	struct inode *inode;
> -
> -	spin_lock(&root->inode_lock);
> -again:
> -	node =3D root->inode_tree.rb_node;
> -	prev =3D NULL;
> -	while (node) {
> -		prev =3D node;
> -		entry =3D rb_entry(node, struct btrfs_inode, rb_node);
> -
> -		if (objectid < btrfs_ino(entry))
> -			node =3D node->rb_left;
> -		else if (objectid > btrfs_ino(entry))
> -			node =3D node->rb_right;
> -		else
> -			break;
> -	}
> -	if (!node) {
> -		while (prev) {
> -			entry =3D rb_entry(prev, struct btrfs_inode, rb_node);
> -			if (objectid <=3D btrfs_ino(entry)) {
> -				node =3D prev;
> -				break;
> -			}
> -			prev =3D rb_next(prev);
> -		}
> -	}
> -	while (node) {
> -		entry =3D rb_entry(node, struct btrfs_inode, rb_node);
> -		inode =3D igrab(&entry->vfs_inode);
> -		if (inode) {
> -			spin_unlock(&root->inode_lock);
> -			return inode;
> -		}
> -
> -		objectid =3D btrfs_ino(entry) + 1;
> -		if (cond_resched_lock(&root->inode_lock))
> -			goto again;
> -
> -		node =3D rb_next(node);
> -	}
> -	spin_unlock(&root->inode_lock);
> -	return NULL;
> -}
> -
>   /*
>    * get new location of data
>    */
> @@ -1065,7 +1011,7 @@ int replace_file_extents(struct btrfs_trans_handle=
 *trans,
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>   	struct btrfs_key key;
>   	struct btrfs_file_extent_item *fi;
> -	struct inode *inode =3D NULL;
> +	struct btrfs_inode *inode =3D NULL;
>   	u64 parent;
>   	u64 bytenr;
>   	u64 new_bytenr =3D 0;
> @@ -1112,13 +1058,13 @@ int replace_file_extents(struct btrfs_trans_hand=
le *trans,
>   		 */
>   		if (root->root_key.objectid !=3D BTRFS_TREE_RELOC_OBJECTID) {
>   			if (first) {
> -				inode =3D find_next_inode(root, key.objectid);
> +				inode =3D btrfs_find_first_inode(root, key.objectid);
>   				first =3D 0;
> -			} else if (inode && btrfs_ino(BTRFS_I(inode)) < key.objectid) {
> -				btrfs_add_delayed_iput(BTRFS_I(inode));
> -				inode =3D find_next_inode(root, key.objectid);
> +			} else if (inode && btrfs_ino(inode) < key.objectid) {
> +				btrfs_add_delayed_iput(inode);
> +				inode =3D btrfs_find_first_inode(root, key.objectid);
>   			}
> -			if (inode && btrfs_ino(BTRFS_I(inode)) =3D=3D key.objectid) {
> +			if (inode && btrfs_ino(inode) =3D=3D key.objectid) {
>   				struct extent_state *cached_state =3D NULL;
>
>   				end =3D key.offset +
> @@ -1128,21 +1074,19 @@ int replace_file_extents(struct btrfs_trans_hand=
le *trans,
>   				WARN_ON(!IS_ALIGNED(end, fs_info->sectorsize));
>   				end--;
>   				/* Take mmap lock to serialize with reflinks. */
> -				if (!down_read_trylock(&BTRFS_I(inode)->i_mmap_lock))
> +				if (!down_read_trylock(&inode->i_mmap_lock))
>   					continue;
> -				ret =3D try_lock_extent(&BTRFS_I(inode)->io_tree,
> -						      key.offset, end,
> -						      &cached_state);
> +				ret =3D try_lock_extent(&inode->io_tree, key.offset,
> +						      end, &cached_state);
>   				if (!ret) {
> -					up_read(&BTRFS_I(inode)->i_mmap_lock);
> +					up_read(&inode->i_mmap_lock);
>   					continue;
>   				}
>
> -				btrfs_drop_extent_map_range(BTRFS_I(inode),
> -							    key.offset, end, true);
> -				unlock_extent(&BTRFS_I(inode)->io_tree,
> -					      key.offset, end, &cached_state);
> -				up_read(&BTRFS_I(inode)->i_mmap_lock);
> +				btrfs_drop_extent_map_range(inode, key.offset, end, true);
> +				unlock_extent(&inode->io_tree, key.offset, end,
> +					      &cached_state);
> +				up_read(&inode->i_mmap_lock);
>   			}
>   		}
>
> @@ -1185,7 +1129,7 @@ int replace_file_extents(struct btrfs_trans_handle=
 *trans,
>   	if (dirty)
>   		btrfs_mark_buffer_dirty(trans, leaf);
>   	if (inode)
> -		btrfs_add_delayed_iput(BTRFS_I(inode));
> +		btrfs_add_delayed_iput(inode);
>   	return ret;
>   }
>
> @@ -1527,7 +1471,7 @@ static int invalidate_extent_cache(struct btrfs_ro=
ot *root,
>   				   const struct btrfs_key *max_key)
>   {
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
> -	struct inode *inode =3D NULL;
> +	struct btrfs_inode *inode =3D NULL;
>   	u64 objectid;
>   	u64 start, end;
>   	u64 ino;
> @@ -1537,23 +1481,24 @@ static int invalidate_extent_cache(struct btrfs_=
root *root,
>   		struct extent_state *cached_state =3D NULL;
>
>   		cond_resched();
> -		iput(inode);
> +		if (inode)
> +			iput(&inode->vfs_inode);
>
>   		if (objectid > max_key->objectid)
>   			break;
>
> -		inode =3D find_next_inode(root, objectid);
> +		inode =3D btrfs_find_first_inode(root, objectid);
>   		if (!inode)
>   			break;
> -		ino =3D btrfs_ino(BTRFS_I(inode));
> +		ino =3D btrfs_ino(inode);
>
>   		if (ino > max_key->objectid) {
> -			iput(inode);
> +			iput(&inode->vfs_inode);
>   			break;
>   		}
>
>   		objectid =3D ino + 1;
> -		if (!S_ISREG(inode->i_mode))
> +		if (!S_ISREG(inode->vfs_inode.i_mode))
>   			continue;
>
>   		if (unlikely(min_key->objectid =3D=3D ino)) {
> @@ -1586,9 +1531,9 @@ static int invalidate_extent_cache(struct btrfs_ro=
ot *root,
>   		}
>
>   		/* the lock_extent waits for read_folio to complete */
> -		lock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached_state);
> -		btrfs_drop_extent_map_range(BTRFS_I(inode), start, end, true);
> -		unlock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached_state);
> +		lock_extent(&inode->io_tree, start, end, &cached_state);
> +		btrfs_drop_extent_map_range(inode, start, end, true);
> +		unlock_extent(&inode->io_tree, start, end, &cached_state);
>   	}
>   	return 0;
>   }

