Return-Path: <linux-btrfs+bounces-15461-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8AAB01704
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 10:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C0A1C247E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 08:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FEB2153CB;
	Fri, 11 Jul 2025 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kzbqFKmV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE151213E9F
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224269; cv=none; b=F/Zqtc3zOrw0U73yFbhJJdqlexmFToUJxspnxzGa3np0xw2VkPwq+pGFEVqvt80Z8F7mLV6Uem3VY0qlNrh+69HqVZT5/eeBTSL9waLNUX5uB1HLbj9l6IGS6ndQH868DVF6iwmSKw3koJeWtuDG9lZ1sNNxbnsPSs+ZFOr0Ias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224269; c=relaxed/simple;
	bh=UfY3kZTk/jldGbyOqWqHvg2DM5BdKXOzW5BD38WS58k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MD6CB5ktdvTY7potoFmUgTzXZtvDXXj4OXXT33k4FRVe1GQxZ4f/4xt9DPg8P56JVHYo41ViMDiFsBVU0rkFfDmiCc1jfEe0/jIcnWjWllkhGyVhQ9V0o29VG1qmvQV2fIHLay4KQOlk4z+RqdLaEDMojtMIT/WQfcW9E7iRlAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kzbqFKmV; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752224260; x=1752829060; i=quwenruo.btrfs@gmx.com;
	bh=1hrlUq6CjDNgfgQhyO48ObepZnf5m0s5LITm6EQNly8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kzbqFKmVI631o3t+77ebIxF9Bmzl3OvOWQk4vs+HDFepU0H4fSXcMfkseV/C/Jle
	 KMRL8qE3v8YGZXLhjXMe1jQuVs9Dch4XLWctyD1FNVRdIvrGFfVsHaVMony0vun8V
	 5bZiG5wKuPxYX+h4/og1+BqcsvoDoysTDG9laoKlyu64P8mAB7xwmfWjS+HnA6pRm
	 vmF6IKbRcrfn4/mvuwVsqyoreBkKSmXdd5shNKLuBm0uI0qHvH0RVTcYnUvyKZxJe
	 iN2+2fAnK+3Ydgn8psqnuHbCdi4eJqkd4A0SBf5xPUxHMBqbn6xJr6Xa8pG783dZ1
	 WibqvADYLv63G4/Idg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2wGi-1udSxi1hcq-00BAyK; Fri, 11
 Jul 2025 10:57:39 +0200
Message-ID: <037ee218-6f14-4167-8075-839826440cf0@gmx.com>
Date: Fri, 11 Jul 2025 18:27:35 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove btrfs_clear_extent_bits()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <89e52089f6d6cb7b4dad233f30bf8d8ee8ea857c.1752224006.git.fdmanana@suse.com>
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
In-Reply-To: <89e52089f6d6cb7b4dad233f30bf8d8ee8ea857c.1752224006.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HPicjLopJ3byesQUW5yC+ksPjaw+a5cfpVzo0gWOKJQMfiJ3nWY
 JKhesMA/wy0A3YWmaZqGf0a1Grj9F/E7jtpxdO+G8P2ekNcvw89zOh95UB9lmOzAERBJhK9
 3Zkm5rbL9cDhx3qNB9IXApS1fCQlGjk7/ejpGqFB3vN3UB6hO520wVMwG2y7yPi3NVmOCmM
 GdRb06HLbn78L/6d0JreA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mb3ei0kg/1Q=;BiQ1rXUjfxH6U3pnmOzr8z2Zyn6
 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
 w/jYetantgavIHGvrpxYNmg=



=E5=9C=A8 2025/7/11 18:24, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> It's just a simple wrapper around btrfs_clear_extent_bit() that passes a
> NULL for its last argument (a cached extent state record), plus there is
> not counter part - we have a btrfs_set_extent_bit() but we do not have a
> btrfs_set_extent_bits() (plural version). So just remove it and make all
> callers use btrfs_clear_extent_bit() directly.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/block-group.c           | 12 ++++++------
>   fs/btrfs/disk-io.c               |  2 +-
>   fs/btrfs/extent-io-tree.h        |  6 ------
>   fs/btrfs/inode.c                 |  4 ++--
>   fs/btrfs/qgroup.c                |  4 ++--
>   fs/btrfs/reflink.c               |  4 ++--
>   fs/btrfs/relocation.c            |  2 +-
>   fs/btrfs/tests/extent-io-tests.c |  4 ++--
>   fs/btrfs/tests/inode-tests.c     | 24 ++++++++++++------------
>   fs/btrfs/volumes.c               | 10 +++++-----
>   10 files changed, 33 insertions(+), 39 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index fb62a8cf03b3..999b61c97011 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -832,8 +832,8 @@ static int load_extent_tree_free(struct btrfs_cachin=
g_control *caching_ctl)
>  =20
>   static inline void btrfs_free_excluded_extents(const struct btrfs_bloc=
k_group *bg)
>   {
> -	btrfs_clear_extent_bits(&bg->fs_info->excluded_extents, bg->start,
> -				bg->start + bg->length - 1, EXTENT_DIRTY);
> +	btrfs_clear_extent_bit(&bg->fs_info->excluded_extents, bg->start,
> +			       bg->start + bg->length - 1, EXTENT_DIRTY, NULL);
>   }
>  =20
>   static noinline void caching_thread(struct btrfs_work *work)
> @@ -1436,14 +1436,14 @@ static bool clean_pinned_extents(struct btrfs_tr=
ans_handle *trans,
>   	 */
>   	mutex_lock(&fs_info->unused_bg_unpin_mutex);
>   	if (prev_trans) {
> -		ret =3D btrfs_clear_extent_bits(&prev_trans->pinned_extents, start, e=
nd,
> -					      EXTENT_DIRTY);
> +		ret =3D btrfs_clear_extent_bit(&prev_trans->pinned_extents, start, en=
d,
> +					     EXTENT_DIRTY, NULL);
>   		if (ret)
>   			goto out;
>   	}
>  =20
> -	ret =3D btrfs_clear_extent_bits(&trans->transaction->pinned_extents, s=
tart, end,
> -				      EXTENT_DIRTY);
> +	ret =3D btrfs_clear_extent_bit(&trans->transaction->pinned_extents, st=
art, end,
> +				     EXTENT_DIRTY, NULL);
>   out:
>   	mutex_unlock(&fs_info->unused_bg_unpin_mutex);
>   	if (prev_trans)
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 44e7ae4a2e0b..9cc14ab35297 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4641,7 +4641,7 @@ static void btrfs_destroy_marked_extents(struct bt=
rfs_fs_info *fs_info,
>  =20
>   	while (btrfs_find_first_extent_bit(dirty_pages, start, &start, &end,
>   					   mark, NULL)) {
> -		btrfs_clear_extent_bits(dirty_pages, start, end, mark);
> +		btrfs_clear_extent_bit(dirty_pages, start, end, mark, NULL);
>   		while (start <=3D end) {
>   			eb =3D find_extent_buffer(fs_info, start);
>   			start +=3D fs_info->nodesize;
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index 819da07bff09..36facca37973 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -192,12 +192,6 @@ static inline int btrfs_unlock_extent(struct extent=
_io_tree *tree, u64 start, u6
>   						cached, NULL);
>   }
>  =20
> -static inline int btrfs_clear_extent_bits(struct extent_io_tree *tree, =
u64 start,
> -					  u64 end, u32 bits)
> -{
> -	return btrfs_clear_extent_bit(tree, start, end, bits, NULL);
> -}
> -
>   int btrfs_set_record_extent_bits(struct extent_io_tree *tree, u64 star=
t, u64 end,
>   				 u32 bits, struct extent_changeset *changeset);
>   int btrfs_set_extent_bit(struct extent_io_tree *tree, u64 start, u64 e=
nd,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 6781956197c7..7ed340cac33f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3374,8 +3374,8 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, st=
ruct btrfs_device *dev,
>   	    btrfs_test_range_bit(&inode->io_tree, file_offset, end, EXTENT_NO=
DATASUM,
>   				 NULL)) {
>   		/* Skip the range without csum for data reloc inode */
> -		btrfs_clear_extent_bits(&inode->io_tree, file_offset, end,
> -					EXTENT_NODATASUM);
> +		btrfs_clear_extent_bit(&inode->io_tree, file_offset, end,
> +				       EXTENT_NODATASUM, NULL);
>   		return true;
>   	}
>  =20
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index ae9bc7c71a34..1a5972178b3a 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -4116,8 +4116,8 @@ static int qgroup_unreserve_range(struct btrfs_ino=
de *inode,
>   		 * Now the entry is in [start, start + len), revert the
>   		 * EXTENT_QGROUP_RESERVED bit.
>   		 */
> -		clear_ret =3D btrfs_clear_extent_bits(&inode->io_tree, entry_start,
> -						    entry_end, EXTENT_QGROUP_RESERVED);
> +		clear_ret =3D btrfs_clear_extent_bit(&inode->io_tree, entry_start, en=
try_end,
> +						   EXTENT_QGROUP_RESERVED, NULL);
>   		if (!ret && clear_ret < 0)
>   			ret =3D clear_ret;
>  =20
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index 0197bd9160a7..ce25ab7f0e99 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -93,8 +93,8 @@ static int copy_inline_to_page(struct btrfs_inode *ino=
de,
>   	if (ret < 0)
>   		goto out_unlock;
>  =20
> -	btrfs_clear_extent_bits(&inode->io_tree, file_offset, range_end,
> -				EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG);
> +	btrfs_clear_extent_bit(&inode->io_tree, file_offset, range_end,
> +			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG, NULL)=
;
>   	ret =3D btrfs_set_extent_delalloc(inode, file_offset, range_end, 0, N=
ULL);
>   	if (ret)
>   		goto out_unlock;
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 175fc3acc38b..70a9c20b2caf 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3651,7 +3651,7 @@ static noinline_for_stack int relocate_block_group=
(struct reloc_control *rc)
>   	}
>  =20
>   	btrfs_release_path(path);
> -	btrfs_clear_extent_bits(&rc->processed_blocks, 0, (u64)-1, EXTENT_DIRT=
Y);
> +	btrfs_clear_extent_bit(&rc->processed_blocks, 0, (u64)-1, EXTENT_DIRTY=
, NULL);
>  =20
>   	if (trans) {
>   		btrfs_end_transaction_throttle(trans);
> diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io=
-tests.c
> index 660141fc67a8..b19328d077d3 100644
> --- a/fs/btrfs/tests/extent-io-tests.c
> +++ b/fs/btrfs/tests/extent-io-tests.c
> @@ -326,7 +326,7 @@ static int test_find_delalloc(u32 sectorsize, u32 no=
desize)
>   out_bits:
>   	if (ret)
>   		dump_extent_io_tree(tmp);
> -	btrfs_clear_extent_bits(tmp, 0, total_dirty - 1, (unsigned)-1);
> +	btrfs_clear_extent_bit(tmp, 0, total_dirty - 1, (unsigned)-1, NULL);
>   out:
>   	if (locked_page)
>   		put_page(locked_page);
> @@ -662,7 +662,7 @@ static int test_find_first_clear_extent_bit(void)
>   out:
>   	if (ret)
>   		dump_extent_io_tree(&tree);
> -	btrfs_clear_extent_bits(&tree, 0, (u64)-1, CHUNK_TRIMMED | CHUNK_ALLOC=
ATED);
> +	btrfs_clear_extent_bit(&tree, 0, (u64)-1, CHUNK_TRIMMED | CHUNK_ALLOCA=
TED, NULL);
>  =20
>   	return ret;
>   }
> diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
> index a29d2c02c2c8..a4c2b7748b95 100644
> --- a/fs/btrfs/tests/inode-tests.c
> +++ b/fs/btrfs/tests/inode-tests.c
> @@ -950,10 +950,10 @@ static int test_extent_accounting(u32 sectorsize, =
u32 nodesize)
>   	}
>  =20
>   	/* [BTRFS_MAX_EXTENT_SIZE/2][sectorsize HOLE][the rest] */
> -	ret =3D btrfs_clear_extent_bits(&BTRFS_I(inode)->io_tree,
> -				      BTRFS_MAX_EXTENT_SIZE >> 1,
> -				      (BTRFS_MAX_EXTENT_SIZE >> 1) + sectorsize - 1,
> -				      EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
> +	ret =3D btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree,
> +				     BTRFS_MAX_EXTENT_SIZE >> 1,
> +				     (BTRFS_MAX_EXTENT_SIZE >> 1) + sectorsize - 1,
> +				     EXTENT_DELALLOC | EXTENT_DELALLOC_NEW, NULL);
>   	if (ret) {
>   		test_err("clear_extent_bit returned %d", ret);
>   		goto out;
> @@ -1017,10 +1017,10 @@ static int test_extent_accounting(u32 sectorsize=
, u32 nodesize)
>   	}
>  =20
>   	/* [BTRFS_MAX_EXTENT_SIZE+4k][4K HOLE][BTRFS_MAX_EXTENT_SIZE+4k] */
> -	ret =3D btrfs_clear_extent_bits(&BTRFS_I(inode)->io_tree,
> -				      BTRFS_MAX_EXTENT_SIZE + sectorsize,
> -				      BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1,
> -				      EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
> +	ret =3D btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree,
> +				     BTRFS_MAX_EXTENT_SIZE + sectorsize,
> +				     BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1,
> +				     EXTENT_DELALLOC | EXTENT_DELALLOC_NEW, NULL);
>   	if (ret) {
>   		test_err("clear_extent_bit returned %d", ret);
>   		goto out;
> @@ -1051,8 +1051,8 @@ static int test_extent_accounting(u32 sectorsize, =
u32 nodesize)
>   	}
>  =20
>   	/* Empty */
> -	ret =3D btrfs_clear_extent_bits(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
> -				      EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
> +	ret =3D btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
> +				     EXTENT_DELALLOC | EXTENT_DELALLOC_NEW, NULL);
>   	if (ret) {
>   		test_err("clear_extent_bit returned %d", ret);
>   		goto out;
> @@ -1066,8 +1066,8 @@ static int test_extent_accounting(u32 sectorsize, =
u32 nodesize)
>   	ret =3D 0;
>   out:
>   	if (ret)
> -		btrfs_clear_extent_bits(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
> -					EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
> +		btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
> +				       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW, NULL);
>   	iput(inode);
>   	btrfs_free_dummy_root(root);
>   	btrfs_free_dummy_fs_info(fs_info);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 31aecd291d6c..3e31030063cd 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5017,8 +5017,8 @@ int btrfs_shrink_device(struct btrfs_device *devic=
e, u64 new_size)
>  =20
>   	mutex_lock(&fs_info->chunk_mutex);
>   	/* Clear all state bits beyond the shrunk device size */
> -	btrfs_clear_extent_bits(&device->alloc_state, new_size, (u64)-1,
> -				CHUNK_STATE_MASK);
> +	btrfs_clear_extent_bit(&device->alloc_state, new_size, (u64)-1,
> +			       CHUNK_STATE_MASK, NULL);
>  =20
>   	btrfs_device_set_disk_total_bytes(device, new_size);
>   	if (list_empty(&device->post_commit_list))
> @@ -5445,9 +5445,9 @@ static void chunk_map_device_clear_bits(struct btr=
fs_chunk_map *map, unsigned in
>   		struct btrfs_io_stripe *stripe =3D &map->stripes[i];
>   		struct btrfs_device *device =3D stripe->dev;
>  =20
> -		btrfs_clear_extent_bits(&device->alloc_state, stripe->physical,
> -					stripe->physical + map->stripe_size - 1,
> -					bits | EXTENT_NOWAIT);
> +		btrfs_clear_extent_bit(&device->alloc_state, stripe->physical,
> +				       stripe->physical + map->stripe_size - 1,
> +				       bits | EXTENT_NOWAIT, NULL);
>   	}
>   }
>  =20


