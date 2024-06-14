Return-Path: <linux-btrfs+bounces-5740-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BE49093BF
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 23:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E32B21580
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 21:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E51F186280;
	Fri, 14 Jun 2024 21:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="c2hl3vSQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC704143C7A
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2024 21:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718401435; cv=none; b=XNDhtcx+HFnhggIYGBcbnZvM9Eg4XlNzD+ZitMw+yDjfzwBO0kCaHae4F24Nk3vunDhRxR3i+eG8gXpJT0n+EN9RNxkT78DthvxjtiM67wmQh69EHKUGYdsTFCNDVJwpAqPCDkkFkiO++018PS42FgmG3le5HKQGX4+eN1Yceqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718401435; c=relaxed/simple;
	bh=FgTl5GvpCVhlIdHTjg7RHdMXTh2CN7ymLaIxhiywPyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nt+ZsFoOz0LRdRcYiD9fLyNOGQVohZuOeAz4MlmrRJzi/NmgcquRJ5oGY1zwDqWHEX2zhVDGtq50oYmhl2Rf1dZZB3ImqnEQTa8C77ucKpJX4zMbXwBf7CZnkR2GGXnrKCLRE6JFTqbJyTCYGDHfTQfx0SoLpUz4mKb/h1o5LCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=c2hl3vSQ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718401425; x=1719006225; i=quwenruo.btrfs@gmx.com;
	bh=LDO3YaT5IzVLzudy8MpvS0gFr7iQ2kZ5yLwRmKxO8rs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=c2hl3vSQ4fxFwhepfdiB/06zIwdk+BwlPvdlzm1ZdVohkcMVu0JFQ4aMhRKc05xI
	 cLhnlK7fv3cK3uOm7QEXJ2QKs2rERmhRZRSn/Extgc69yzYRAIpgOpR8kCSkFod9a
	 z+WW6unBgXsZQV8piT78O3xoQWVGgsOm3k5OrX9ZCyPCFcJk0RwR1p/Kr9YDcu9sP
	 oJkeTjWXWOyuZxy/3xQyhkrzUEBDyfAT9nPpeNRQ/0fzzFjJk5/Mob+oqDi2WYUDX
	 ULEHWLrHuqtOWpGLTK31babWkNLCpTpHiiDdCNzXyhWAK+URTT9LkZX5KZNcg3mp3
	 y2DwztAk+AV+fxBpPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQvD5-1s4or92KCl-00PSAs; Fri, 14
 Jun 2024 23:43:45 +0200
Message-ID: <0034b26d-2558-4656-9d21-b6570e8e4aae@gmx.com>
Date: Sat, 15 Jun 2024 07:13:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not BUG_ON() when freeing tree block after
 error
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <eeb993f33bd03c3aff2b4ec7d6f4385dbc601d84.1718374143.git.fdmanana@suse.com>
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
In-Reply-To: <eeb993f33bd03c3aff2b4ec7d6f4385dbc601d84.1718374143.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:auf8cS3CQC3gzv0jrMNIle5sXTG3/+SGJB5j+MYOk9dtHuC6Dbp
 sRzI11Sv0VobIGl5kTxWFnF/bdza5bWGhdXyatZ0D6OtbSdqxw0W0tq1DNebcu2YBHr0s7m
 4ShLT3CSMD8vMcoWBB7pFg94f/HotBHrob+kt8ATIfiGAp2nvdX9vg5LqqbflgIeQbvT/c3
 GFCXDMIqH+Gv0uk4zEj8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FkBOdFj5xgE=;ZVusO9HjxKQMIMnuvlnstbcjRyl
 jaedthcGv3EF3izdQA7J9ISbl5J3rNkXKqjzeg3SQLH5W1btKGA+gQQxNUmRlXd2C0mBC1bEV
 bE2iey6mKceMFLVjoaxhBdDH/lB+61O94755isaM3VIhIAFjohLskDuWI3xJzoJTZsI0foE1i
 Gi7worX4X2LhixeaQTODHAgo3TFAAaKBYPyREUyGWEt7CmfvJjC8JHEhYDZ40nmshf6rlxEtu
 k7NQ/lyNqqIvLq3XAxCRcY2QjX3qunEoC1jJOixo3/+/D7eBkHvjJ4eDrm1u9f7ydE1M5i/23
 BbUiRTeXU9mZxx5fWSKB/DV0LKu2dBi7indWvbqh9pZNUVHbTZpdhj6CwtxPFomGBNfRnObNR
 r8fvs9jThARZulu0mF8vBCxmi2St84lpec2pfeCRG4BmdghqoA6iqF9ZiSESQEOScnCCI2IXL
 o9HNW9o/jx3B86Q1QyGPEJTygtHxKiU1jHerhehdIudHnd5LD4wDfuOJF/OjomgZ/m+m21Znv
 L6yBV/9fGK3JDvGfArh5sqF9tFkBxzzFuvgyAizPrEUZ+LzdcI+JWhs4jldDofV8dbnvdTsue
 PuFWqS4alkKAoYQtAf00dXuA5UuQnbNing9vBIf+NxEK240++8TfZuUa/InhOqyCjfQY5GQ4X
 WCIb971lGXfz9c3TKa3ktgqF4KlxqvxRcVt/lxM/8QOKeW9qKfGNvl35ch425xFD1BK5Bz/Cv
 qNbzhPMQevNWoI6TCnnH3WtMMv3V6NfEer0Jke79YWVOpLO6K90tsEFmGiCjcTGiadnHcHSWw
 132cqkQcln+dCThcOL3f6kwah8SYhz/nu9eJxzst9LdY4=



=E5=9C=A8 2024/6/14 23:44, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> When freeing a tree block, at btrfs_free_tree_block(), if we fail to
> create a delayed reference we don't deal with the error and just do a
> BUG_ON(). The error most likely to happen is -ENOMEM, and we have a
> comment mentioning that only -ENOMEM can happen, but that is not true,
> because in case qgroups are enabled any error returned from
> btrfs_qgroup_trace_extent_post() (can be -EUCLEAN or anything returned
> from btrfs_search_slot() for example) can be propagated back to
> btrfs_free_tree_block().
>
> So stop doing a BUG_ON() and return the error to the callers and make
> them abort the transaction to prevent leaking space. Syzbot was
> triggering this, likely due to memory allocation failure injection.
>
> Reported-by: syzbot+a306f914b4d01b3958fe@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/000000000000fcba1e05e998263c@g=
oogle.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.c           | 53 ++++++++++++++++++++++++++++++--------
>   fs/btrfs/extent-tree.c     | 24 ++++++++++-------
>   fs/btrfs/extent-tree.h     |  8 +++---
>   fs/btrfs/free-space-tree.c | 10 ++++---
>   fs/btrfs/ioctl.c           |  6 ++++-
>   fs/btrfs/qgroup.c          |  7 ++---
>   6 files changed, 76 insertions(+), 32 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 48aa14046343..a155dbc0bffa 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -620,10 +620,16 @@ int btrfs_force_cow_block(struct btrfs_trans_handl=
e *trans,
>   		atomic_inc(&cow->refs);
>   		rcu_assign_pointer(root->node, cow);
>
> -		btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
> -				      parent_start, last_ref);
> +		ret =3D btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
> +					    parent_start, last_ref);
>   		free_extent_buffer(buf);
>   		add_root_to_dirty_list(root);
> +		if (ret < 0) {
> +			btrfs_tree_unlock(cow);
> +			free_extent_buffer(cow);
> +			btrfs_abort_transaction(trans, ret);
> +			return ret;
> +		}
>   	} else {
>   		WARN_ON(trans->transid !=3D btrfs_header_generation(parent));
>   		ret =3D btrfs_tree_mod_log_insert_key(parent, parent_slot,
> @@ -648,8 +654,14 @@ int btrfs_force_cow_block(struct btrfs_trans_handle=
 *trans,
>   				return ret;
>   			}
>   		}
> -		btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
> -				      parent_start, last_ref);
> +		ret =3D btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
> +					    parent_start, last_ref);
> +		if (ret < 0) {
> +			btrfs_tree_unlock(cow);
> +			free_extent_buffer(cow);
> +			btrfs_abort_transaction(trans, ret);
> +			return ret;
> +		}
>   	}
>   	if (unlock_orig)
>   		btrfs_tree_unlock(buf);
> @@ -983,9 +995,13 @@ static noinline int balance_level(struct btrfs_tran=
s_handle *trans,
>   		free_extent_buffer(mid);
>
>   		root_sub_used_bytes(root);
> -		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
> +		ret =3D btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
>   		/* once for the root ptr */
>   		free_extent_buffer_stale(mid);
> +		if (ret < 0) {
> +			btrfs_abort_transaction(trans, ret);
> +			goto out;
> +		}
>   		return 0;
>   	}
>   	if (btrfs_header_nritems(mid) >
> @@ -1053,10 +1069,14 @@ static noinline int balance_level(struct btrfs_t=
rans_handle *trans,
>   				goto out;
>   			}
>   			root_sub_used_bytes(root);
> -			btrfs_free_tree_block(trans, btrfs_root_id(root), right,
> -					      0, 1);
> +			ret =3D btrfs_free_tree_block(trans, btrfs_root_id(root),
> +						    right, 0, 1);
>   			free_extent_buffer_stale(right);
>   			right =3D NULL;
> +			if (ret < 0) {
> +				btrfs_abort_transaction(trans, ret);
> +				goto out;
> +			}
>   		} else {
>   			struct btrfs_disk_key right_key;
>   			btrfs_node_key(right, &right_key, 0);
> @@ -1111,9 +1131,13 @@ static noinline int balance_level(struct btrfs_tr=
ans_handle *trans,
>   			goto out;
>   		}
>   		root_sub_used_bytes(root);
> -		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
> +		ret =3D btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
>   		free_extent_buffer_stale(mid);
>   		mid =3D NULL;
> +		if (ret < 0) {
> +			btrfs_abort_transaction(trans, ret);
> +			goto out;
> +		}
>   	} else {
>   		/* update the parent key to reflect our changes */
>   		struct btrfs_disk_key mid_key;
> @@ -2878,7 +2902,11 @@ static noinline int insert_new_root(struct btrfs_=
trans_handle *trans,
>   	old =3D root->node;
>   	ret =3D btrfs_tree_mod_log_insert_root(root->node, c, false);
>   	if (ret < 0) {
> -		btrfs_free_tree_block(trans, btrfs_root_id(root), c, 0, 1);
> +		int ret2;
> +
> +		ret2 =3D btrfs_free_tree_block(trans, btrfs_root_id(root), c, 0, 1);
> +		if (ret2 < 0)
> +			btrfs_abort_transaction(trans, ret2);
>   		btrfs_tree_unlock(c);
>   		free_extent_buffer(c);
>   		return ret;
> @@ -4447,9 +4475,12 @@ static noinline int btrfs_del_leaf(struct btrfs_t=
rans_handle *trans,
>   	root_sub_used_bytes(root);
>
>   	atomic_inc(&leaf->refs);
> -	btrfs_free_tree_block(trans, btrfs_root_id(root), leaf, 0, 1);
> +	ret =3D btrfs_free_tree_block(trans, btrfs_root_id(root), leaf, 0, 1);
>   	free_extent_buffer_stale(leaf);
> -	return 0;
> +	if (ret < 0)
> +		btrfs_abort_transaction(trans, ret);
> +
> +	return ret;
>   }
>   /*
>    * delete the item at the leaf level in path.  If that empties
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index eda424192164..58a72a57414a 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3419,10 +3419,10 @@ static noinline int check_ref_cleanup(struct btr=
fs_trans_handle *trans,
>   	return 0;
>   }
>
> -void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
> -			   u64 root_id,
> -			   struct extent_buffer *buf,
> -			   u64 parent, int last_ref)
> +int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
> +			  u64 root_id,
> +			  struct extent_buffer *buf,
> +			  u64 parent, int last_ref)
>   {
>   	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>   	struct btrfs_block_group *bg;
> @@ -3449,11 +3449,12 @@ void btrfs_free_tree_block(struct btrfs_trans_ha=
ndle *trans,
>   		btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf), 0, false)=
;
>   		btrfs_ref_tree_mod(fs_info, &generic_ref);
>   		ret =3D btrfs_add_delayed_tree_ref(trans, &generic_ref, NULL);
> -		BUG_ON(ret); /* -ENOMEM */
> +		if (ret < 0)
> +			return ret;
>   	}
>
>   	if (!last_ref)
> -		return;
> +		return 0;
>
>   	if (btrfs_header_generation(buf) !=3D trans->transid)
>   		goto out;
> @@ -3510,6 +3511,7 @@ void btrfs_free_tree_block(struct btrfs_trans_hand=
le *trans,
>   	 * matter anymore.
>   	 */
>   	clear_bit(EXTENT_BUFFER_CORRUPT, &buf->bflags);
> +	return 0;
>   }
>
>   /* Can return -ENOMEM */
> @@ -5754,7 +5756,7 @@ static noinline int walk_up_proc(struct btrfs_tran=
s_handle *trans,
>   				 struct walk_control *wc)
>   {
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
> -	int ret;
> +	int ret =3D 0;
>   	int level =3D wc->level;
>   	struct extent_buffer *eb =3D path->nodes[level];
>   	u64 parent =3D 0;
> @@ -5849,12 +5851,14 @@ static noinline int walk_up_proc(struct btrfs_tr=
ans_handle *trans,
>   			goto owner_mismatch;
>   	}
>
> -	btrfs_free_tree_block(trans, btrfs_root_id(root), eb, parent,
> -			      wc->refs[level] =3D=3D 1);
> +	ret =3D btrfs_free_tree_block(trans, btrfs_root_id(root), eb, parent,
> +				    wc->refs[level] =3D=3D 1);
> +	if (ret < 0)
> +		btrfs_abort_transaction(trans, ret);
>   out:
>   	wc->refs[level] =3D 0;
>   	wc->flags[level] =3D 0;
> -	return 0;
> +	return ret;
>
>   owner_mismatch:
>   	btrfs_err_rl(fs_info, "unexpected tree owner, have %llu expect %llu",
> diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
> index af9f8800d5ac..2ad51130c037 100644
> --- a/fs/btrfs/extent-tree.h
> +++ b/fs/btrfs/extent-tree.h
> @@ -127,10 +127,10 @@ struct extent_buffer *btrfs_alloc_tree_block(struc=
t btrfs_trans_handle *trans,
>   					     u64 empty_size,
>   					     u64 reloc_src_root,
>   					     enum btrfs_lock_nesting nest);
> -void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
> -			   u64 root_id,
> -			   struct extent_buffer *buf,
> -			   u64 parent, int last_ref);
> +int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
> +			  u64 root_id,
> +			  struct extent_buffer *buf,
> +			  u64 parent, int last_ref);
>   int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
>   				     struct btrfs_root *root, u64 owner,
>   				     u64 offset, u64 ram_bytes,
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index 90f2938bd743..7ba50e133921 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1300,10 +1300,14 @@ int btrfs_delete_free_space_tree(struct btrfs_fs=
_info *fs_info)
>   	btrfs_tree_lock(free_space_root->node);
>   	btrfs_clear_buffer_dirty(trans, free_space_root->node);
>   	btrfs_tree_unlock(free_space_root->node);
> -	btrfs_free_tree_block(trans, btrfs_root_id(free_space_root),
> -			      free_space_root->node, 0, 1);
> -
> +	ret =3D btrfs_free_tree_block(trans, btrfs_root_id(free_space_root),
> +				    free_space_root->node, 0, 1);
>   	btrfs_put_root(free_space_root);
> +	if (ret < 0) {
> +		btrfs_abort_transaction(trans, ret);
> +		btrfs_end_transaction(trans);
> +		return ret;
> +	}
>
>   	return btrfs_commit_transaction(trans);
>   }
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 06447ee6d7ce..d28ebabe3720 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -714,6 +714,8 @@ static noinline int create_subvol(struct mnt_idmap *=
idmap,
>   	ret =3D btrfs_insert_root(trans, fs_info->tree_root, &key,
>   				root_item);
>   	if (ret) {
> +		int ret2;
> +
>   		/*
>   		 * Since we don't abort the transaction in this case, free the
>   		 * tree block so that we don't leak space and leave the
> @@ -724,7 +726,9 @@ static noinline int create_subvol(struct mnt_idmap *=
idmap,
>   		btrfs_tree_lock(leaf);
>   		btrfs_clear_buffer_dirty(trans, leaf);
>   		btrfs_tree_unlock(leaf);
> -		btrfs_free_tree_block(trans, objectid, leaf, 0, 1);
> +		ret2 =3D btrfs_free_tree_block(trans, objectid, leaf, 0, 1);
> +		if (ret2 < 0)
> +			btrfs_abort_transaction(trans, ret2);
>   		free_extent_buffer(leaf);
>   		goto out;
>   	}
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index dfe79534139e..3edbe5bb19c6 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1441,9 +1441,10 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_=
info)
>   	btrfs_tree_lock(quota_root->node);
>   	btrfs_clear_buffer_dirty(trans, quota_root->node);
>   	btrfs_tree_unlock(quota_root->node);
> -	btrfs_free_tree_block(trans, btrfs_root_id(quota_root),
> -			      quota_root->node, 0, 1);
> -
> +	ret =3D btrfs_free_tree_block(trans, btrfs_root_id(quota_root),
> +				    quota_root->node, 0, 1);
> +	if (ret < 0)
> +		btrfs_abort_transaction(trans, ret);
>   	btrfs_put_root(quota_root);
>
>   out:

