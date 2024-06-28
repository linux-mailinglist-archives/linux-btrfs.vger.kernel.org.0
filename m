Return-Path: <linux-btrfs+bounces-6028-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC7291B5A2
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 06:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A311C2187F
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 04:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCB820DC4;
	Fri, 28 Jun 2024 04:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="C9JcR1QF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451F96FC1
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 04:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719547964; cv=none; b=gqZD/wGom6X22CirXFXxxaZm51nYUuCWtQA4JBx1IkIrifShhugOe4ZHZsJRxyKipvpfzoO9DZkkuIT9jYqt6CZYADuHQeK+DnMN3rJA6d2KU9B4D8lIFAyrGCZIRZwoWAlN5DbZAP6c95Yna/4mcXPSW2mpVRpQQn7DaTkEvak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719547964; c=relaxed/simple;
	bh=zCRWLvQ2uWALmFSPtoay9CeRnN6Ap38HU/ffm5KEPJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8XisAwLkU36IwTZN4bdvXpQB0HrTVOsyqt/HsejeBL4ul3tUzVNQxEQ1Vpz8ztPQVmZRCxcbBa/4WDbS+aKCLFNyCHSj5jmhJBalojsa0qXcKCCax9LSxmXGU7oAK3LhiFgmtyLX4CQlErnmI/Qq7TCyVWvri+9Gnayepi2fYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=C9JcR1QF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1719547954; x=1720152754; i=quwenruo.btrfs@gmx.com;
	bh=aFH7cwnGN9IJsSCUsUGHjGAUscS984iUeW4TWIZh4XQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=C9JcR1QF0/HTXvHOzcdpuRVtIC0PuFUrt+PGN48jDx1jN2L0I/zflfPZH6MCM5Nn
	 fyNo2I6zwttx+iRi4EvMGjVAkImA63iMUYKlhNxIxk+HETxmwhfdPglLdFZgGk3Ky
	 yEen4SvMUDcyKMTfgEzYJevKuyYZb9i7MwrsEUtB6xorEM8qmGPb97ZgnUKdkZGYs
	 NNzMEesq7KuBg5F3niM2MDjZ3o2TrpKj2q/XyK51dab5Zx3e5IYF09dq4Z/hJO0/J
	 RjfuWXl+gaSMqFjpLZR7dmaP6cSGAYfXvh++L6Ifx3LTUSrVDPFdYn4KuaR06zitA
	 NEGntDd2MAk35qNCBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGz1f-1s9WZG3W7P-00Feqo; Fri, 28
 Jun 2024 06:12:34 +0200
Message-ID: <847fb295-1a0e-429d-8d04-67948240fa5c@gmx.com>
Date: Fri, 28 Jun 2024 13:42:29 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: add --subvol option to mkfs.btrfs
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <maharmstone@meta.com>
References: <20240627095455.315620-1-maharmstone@fb.com>
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
In-Reply-To: <20240627095455.315620-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eYBmLQwS/aoVxVP76mrKG3DAz5OawS6CJJqDpE668WtG5npHxce
 KxH1/7Czv9BGUzWQo7MFc8pnLCXc83eP6PQQKnqpIpLJOHPxIZCI+QAGYZbV1y/x1IKed8O
 xWYmztwLTAQ5fFKf8fBOjl3WHD7yoS063uuyKY4A8Zt7aqYsVQPEKQf5viVnMDUZ/8HLahU
 z7qCr2zrsdev0LDBPIfLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VKTJm2d4elM=;FhbCEUXjuHypKnzaI2GwWtkL8Ow
 7yyy8fkCTRhWgxirlmP21S/4B4vp8Y2oDz9+cqcS2pnhDqoyB/fR5NGGqmX43PXhfRboPJJQD
 HMeAdZYYscbO+0sm+g9CYzIxET31PVLr/ht3esgACXzEiiNFFUCZ6B/13kxD136zLycpXf7EE
 x3ih0BQtRH985l+3Qojkr/Bf3k6bWUqDmcjEUq7vN7B6Q6TotiCtAQTDrwfJyCA4RAoESQBNR
 O65EnF/QifizNn2F2GKiHTWV1LcxfYYvME8f+s8rKVVM44VYheAdxLdbcaSgYRUZ58t8aAmIE
 hVaD1aC1bBz1ugSuhAsjTZVkqmupksWQuQBs57m3l/JLpLctuSdDM/jScrEkp5A87vd0VaXWe
 X0A2SG543VlfdxOFpLT1tYNS7fDVdGxO6VP7Qo7pjw6YZtJQ1xfRcf5WUoTvHADnJKxD8ZqBh
 4ikHnAesvP8xTM51Q8Q9N1GzHHyeFu1mF6zKkf6hlQ7I6IVCb1xn6GKmia4Sg5qk+M4SKVdnJ
 v/PcKB6HLNKH2BJYrGx6sva20BTRhtutYDsmMokkpyYr7cMMTEo+y6f80C/UYv4bUNMCd0Hgh
 iUAeldOO8EiSv2SMOpW1VaXbq2zIjTcg9/3hnFMCiFnSEVuOR4Qg6/Z7cq07fHQsAvZEjP9bG
 DMioRYvOTf7iraO2G5qpg1EBJA5BbiNXKEeiXoWXnDLNvhUy/IcC2z7WAAhGhD398Js02zN16
 rsIrS4PaYOXHRNXUpctyU08Ly7phihQT3cLCvwapbwPqEkH8XALXR3HWnupt2voruNcBNcpZp
 LEEpB/GQvJBwG3LOOg98o7M2PDB2h8/7gZSSd+fm7lEgU=



=E5=9C=A8 2024/6/27 19:24, Mark Harmstone =E5=86=99=E9=81=93:
> From: Mark Harmstone <maharmstone@meta.com>
>
> This patch adds a --subvol option, which tells mkfs.btrfs to create the
> specified directories as subvolumes.

I have considered this feature in the past, but I do not have a good
enough UI for that.

>
> Given a populated directory img, the command
>
> $ mkfs.btrfs --rootdir img --subvol usr --subvol home --subvol home/user=
name /dev/loop0

Initially I thought the UI can be a little confusing, but I have no
better alternatives, and it is flex enough to handle all cases I can
thing of.

So a nice solution.

>
> will create subvolumes usr and home within the FS root, and subvolume
> username within the home subvolume. It will fail if any of the
> directories do not yet exist.
>
> Signed-off-by: Mark Harmstone <maharmstone@meta.com>
> ---
>   convert/main.c                              |   4 +-
>   kernel-shared/ctree.h                       |   3 +-
>   kernel-shared/inode.c                       |  46 +--
>   mkfs/main.c                                 | 357 +++++++++++++++++++-
>   mkfs/rootdir.c                              |  31 +-
>   mkfs/rootdir.h                              |  16 +-
>   tests/mkfs-tests/034-rootdir-subvol/test.sh |  33 ++
>   7 files changed, 463 insertions(+), 27 deletions(-)
>   create mode 100755 tests/mkfs-tests/034-rootdir-subvol/test.sh
>
> diff --git a/convert/main.c b/convert/main.c
> index 8e73aa25..7249c793 100644
> --- a/convert/main.c
> +++ b/convert/main.c
> @@ -1314,7 +1314,9 @@ static int do_convert(const char *devname, u32 con=
vert_flags, u32 nodesize,
>   	}
>
>   	image_root =3D btrfs_mksubvol(root, subvol_name,
> -				    CONV_IMAGE_SUBVOL_OBJECTID, true);
> +				    CONV_IMAGE_SUBVOL_OBJECTID, true,
> +				    btrfs_root_dirid(&root->root_item),
> +				    false);
>   	if (!image_root) {
>   		error("unable to link subvolume %s", subvol_name);
>   		goto fail;
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index 1341a418..8a5ddcdb 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -1230,7 +1230,8 @@ int btrfs_add_orphan_item(struct btrfs_trans_handl=
e *trans,
>   int btrfs_mkdir(struct btrfs_trans_handle *trans, struct btrfs_root *r=
oot,
>   		char *name, int namelen, u64 parent_ino, u64 *ino, int mode);
>   struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root, const char =
*base,
> -				  u64 root_objectid, bool convert);
> +				  u64 root_objectid, bool convert, u64 dirid,
> +				  bool dont_change_size);
>   int btrfs_find_free_objectid(struct btrfs_trans_handle *trans,
>   			     struct btrfs_root *fs_root,
>   			     u64 dirid, u64 *objectid);
> diff --git a/kernel-shared/inode.c b/kernel-shared/inode.c
> index 91b4f629..99965558 100644
> --- a/kernel-shared/inode.c
> +++ b/kernel-shared/inode.c
> @@ -584,7 +584,8 @@ out:
>
>   struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root,
>   				  const char *base, u64 root_objectid,
> -				  bool convert)
> +				  bool convert, u64 dirid,
> +				  bool dont_change_size)

Any reason why adding this new parameter?

Normally it's pretty nature that we increase the directory inode's size
with new entries.
Just like btrfs_add_link().



>   {
>   	struct btrfs_trans_handle *trans;
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
> @@ -594,7 +595,6 @@ struct btrfs_root *btrfs_mksubvol(struct btrfs_root =
*root,
>   	struct btrfs_inode_item *inode_item;
>   	struct extent_buffer *leaf;
>   	struct btrfs_key key;
> -	u64 dirid =3D btrfs_root_dirid(&root->root_item);
>   	u64 index =3D 2;
>   	char buf[BTRFS_NAME_LEN + 1]; /* for snprintf null */
>   	int len;
> @@ -632,20 +632,6 @@ struct btrfs_root *btrfs_mksubvol(struct btrfs_root=
 *root,
>   		goto fail;
>   	}
>
> -	key.objectid =3D dirid;
> -	key.type =3D  BTRFS_INODE_ITEM_KEY;
> -	key.offset =3D 0;
> -
> -	ret =3D btrfs_lookup_inode(trans, root, &path, &key, 1);
> -	if (ret) {
> -		error("search for INODE_ITEM %llu failed: %d",
> -				(unsigned long long)dirid, ret);
> -		goto fail;
> -	}
> -	leaf =3D path.nodes[0];
> -	inode_item =3D btrfs_item_ptr(leaf, path.slots[0],
> -				    struct btrfs_inode_item);
> -
>   	key.objectid =3D root_objectid;
>   	key.type =3D BTRFS_ROOT_ITEM_KEY;
>   	key.offset =3D (u64)-1;
> @@ -670,10 +656,26 @@ struct btrfs_root *btrfs_mksubvol(struct btrfs_roo=
t *root,
>   	if (ret)
>   		goto fail;
>
> -	btrfs_set_inode_size(leaf, inode_item, len * 2 +
> -			     btrfs_inode_size(leaf, inode_item));
> -	btrfs_mark_buffer_dirty(leaf);
> -	btrfs_release_path(&path);
> +	if (!dont_change_size) {
> +		key.objectid =3D dirid;
> +		key.type =3D  BTRFS_INODE_ITEM_KEY;
> +		key.offset =3D 0;
> +
> +		ret =3D btrfs_lookup_inode(trans, root, &path, &key, 1);
> +		if (ret) {
> +			error("search for INODE_ITEM %llu failed: %d",
> +					(unsigned long long)dirid, ret);
> +			goto fail;
> +		}
> +		leaf =3D path.nodes[0];
> +		inode_item =3D btrfs_item_ptr(leaf, path.slots[0],
> +					struct btrfs_inode_item);
> +
> +		btrfs_set_inode_size(leaf, inode_item, len * 2 +
> +				btrfs_inode_size(leaf, inode_item));
> +		btrfs_mark_buffer_dirty(leaf);
> +		btrfs_release_path(&path);
> +	}
>
>   	/* add the backref first */
>   	ret =3D btrfs_add_root_ref(trans, tree_root, root_objectid,
> @@ -703,6 +705,10 @@ struct btrfs_root *btrfs_mksubvol(struct btrfs_root=
 *root,
>   		goto fail;
>   	}
>
> +	key.objectid =3D root_objectid;
> +	key.type =3D BTRFS_ROOT_ITEM_KEY;
> +	key.offset =3D (u64)-1;
> +
>   	new_root =3D btrfs_read_fs_root(fs_info, &key);
>   	if (IS_ERR(new_root)) {
>   		error("unable to fs read root: %lu", PTR_ERR(new_root));
> diff --git a/mkfs/main.c b/mkfs/main.c
> index b40f7432..63119fc3 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -440,6 +440,7 @@ static const char * const mkfs_usage[] =3D {
>   	"Creation:",
>   	OPTLINE("-b|--byte-count SIZE", "set size of each device to SIZE (fil=
esystem size is sum of all device sizes)"),
>   	OPTLINE("-r|--rootdir DIR", "copy files from DIR to the image root di=
rectory"),
> +	OPTLINE("-u|--subvol SUBDIR", "create SUBDIR as subvolume rather than =
normal directory"),
>   	OPTLINE("--shrink", "(with --rootdir) shrink the filled filesystem to=
 minimal size"),
>   	OPTLINE("-K|--nodiscard", "do not perform whole device TRIM"),
>   	OPTLINE("-f|--force", "force overwrite of existing filesystem"),
> @@ -1168,6 +1169,67 @@ static void *prepare_one_device(void *ctx)
>   	return NULL;
>   }
>
> +static int create_subvol(struct btrfs_trans_handle *trans,
> +			 struct btrfs_root *root, u64 root_objectid)
> +{
> +	struct extent_buffer *tmp;
> +	struct btrfs_root *new_root;
> +	struct btrfs_key key;
> +	struct btrfs_root_item root_item;
> +	u8 uuid[BTRFS_UUID_SIZE];
> +	int ret;
> +
> +	ret =3D btrfs_copy_root(trans, root, root->node, &tmp,
> +			      root_objectid);

I'm not a super big fan of copying root just to skip the initialization
of some members.

Can't we just use btrfs_create_root() instead?

> +	if (ret)
> +		return ret;
> +
> +	uuid_generate(uuid);
> +
> +	memcpy(&root_item, &root->root_item, sizeof(root_item));
> +	btrfs_set_root_bytenr(&root_item, tmp->start);
> +	btrfs_set_root_level(&root_item, btrfs_header_level(tmp));
> +	btrfs_set_root_generation(&root_item, trans->transid);
> +	memcpy(&root_item.uuid, uuid, BTRFS_UUID_SIZE);
> +
> +	free_extent_buffer(tmp);
> +
> +	key.objectid =3D root_objectid;
> +	key.type =3D BTRFS_ROOT_ITEM_KEY;
> +	key.offset =3D trans->transid;
> +	ret =3D btrfs_insert_root(trans, root->fs_info->tree_root,
> +				&key, &root_item);
> +
> +	key.offset =3D (u64)-1;
> +	new_root =3D btrfs_read_fs_root(root->fs_info, &key);
> +	if (!new_root || IS_ERR(new_root)) {
> +		error("unable to fs read root: %lu", PTR_ERR(new_root));
> +		return PTR_ERR(new_root);
> +	}
> +
> +	ret =3D btrfs_uuid_tree_add(trans, uuid, BTRFS_UUID_KEY_SUBVOL,
> +				  root_objectid);
> +	if (ret < 0) {
> +		error("failed to add uuid entry");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int subvol_compar(const void *p1, const void *p2)
> +{
> +	const struct rootdir_subvol *s1 =3D *(const struct rootdir_subvol**)p1=
;
> +	const struct rootdir_subvol *s2 =3D *(const struct rootdir_subvol**)p2=
;
> +
> +	if (s1->depth < s2->depth)
> +		return 1;
> +	else if (s1->depth > s2->depth)
> +		return -1;
> +	else
> +		return 0;
> +}
> +
>   int BOX_MAIN(mkfs)(int argc, char **argv)
>   {
>   	char *file;
> @@ -1209,6 +1271,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	char *label =3D NULL;
>   	int nr_global_roots =3D sysconf(_SC_NPROCESSORS_ONLN);
>   	char *source_dir =3D NULL;
> +	LIST_HEAD(subvols);
>
>   	cpu_detect_flags();
>   	hash_init_accel();
> @@ -1239,6 +1302,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   			{ "data", required_argument, NULL, 'd' },
>   			{ "version", no_argument, NULL, 'V' },
>   			{ "rootdir", required_argument, NULL, 'r' },
> +			{ "subvol", required_argument, NULL, 'u' },
>   			{ "nodiscard", no_argument, NULL, 'K' },
>   			{ "features", required_argument, NULL, 'O' },
>   			{ "runtime-features", required_argument, NULL, 'R' },
> @@ -1360,6 +1424,25 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   				free(source_dir);
>   				source_dir =3D strdup(optarg);
>   				break;
> +			case 'u': {
> +				struct rootdir_subvol *s;
> +
> +				s =3D malloc(sizeof(struct rootdir_subvol));
> +				if (!s) {
> +					error("out of memory");
> +					goto error;
> +				}
> +
> +				s->dir =3D strdup(optarg);
> +				s->fullpath =3D NULL;
> +				s->parent =3D NULL;
> +				s->parent_inum =3D 0;
> +				INIT_LIST_HEAD(&s->children);
> +				s->root =3D NULL;
> +
> +				list_add_tail(&s->list, &subvols);
> +				break;
> +				}
>   			case 'U':
>   				strncpy_null(fs_uuid, optarg, BTRFS_UUID_UNPARSED_SIZE);
>   				break;
> @@ -1420,6 +1503,159 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   		error("the option --shrink must be used with --rootdir");
>   		goto error;
>   	}
> +	if (!list_empty(&subvols) && source_dir =3D=3D NULL) {
> +		error("the option --subvol must be used with --rootdir");
> +		goto error;
> +	}
> +
> +	if (source_dir) {
> +		char *canonical =3D realpath(source_dir, NULL);
> +
> +		if (!canonical) {
> +			error("could not get canonical path to %s", source_dir);
> +			goto error;
> +		}
> +
> +		free(source_dir);
> +		source_dir =3D canonical;
> +	}
> +
> +	if (!list_empty(&subvols)) {
> +		unsigned int num_subvols =3D 0;
> +		size_t source_dir_len =3D strlen(source_dir);
> +		struct rootdir_subvol **arr, **ptr, *s;
> +
> +		list_for_each_entry(s, &subvols, list) {
> +			size_t tmp_len;
> +			char *tmp, *path;
> +			struct rootdir_subvol *s2;
> +
> +			tmp_len =3D source_dir_len + 1 + strlen(s->dir) + 1;
> +
> +			tmp =3D malloc(tmp_len);
> +			if (!tmp) {
> +				error("out of memory");
> +				goto error;
> +			}
> +
> +			strcpy(tmp, source_dir);
> +			strcat(tmp, "/");
> +			strcat(tmp, s->dir);
> +
> +			if (!path_exists(tmp)) {
> +				error("subvol %s does not exist within rootdir",
> +				      s->dir);
> +				free(tmp);
> +				goto error;
> +			}
> +
> +			if (!path_is_dir(tmp)) {
> +				error("subvol %s is not a directory", s->dir);
> +				free(tmp);
> +				goto error;
> +			}
> +
> +			path =3D realpath(tmp, NULL);
> +
> +			free(tmp);
> +
> +			if (!path) {
> +				error("could not get canonical path to %s",
> +				      s->dir);
> +				goto error;
> +			}
> +
> +			if (strlen(path) < source_dir_len + 1 ||
> +			    memcmp(path, source_dir, source_dir_len) ||
> +			    path[source_dir_len] !=3D '/') {
> +				error("subvol %s is not a child of %s",
> +				      s->dir, source_dir);
> +				free(path);
> +				goto error;
> +			}
> +
> +			for (s2 =3D list_first_entry(&subvols, struct rootdir_subvol, list);
> +			     s2 !=3D s; s2 =3D list_next_entry(s2, list)) {
> +				if (!strcmp(s2->fullpath, path)) {
> +					error("subvol %s specified more than once",
> +					      s->dir);
> +					free(path);
> +					goto error;
> +				}
> +			}
> +
> +			s->fullpath =3D path;
> +
> +			s->depth =3D 0;
> +			for (i =3D source_dir_len + 1; i < strlen(s->fullpath); i++) {
> +				if (s->fullpath[i] =3D=3D '/')
> +					s->depth++;
> +			}
> +
> +			num_subvols++;
> +		}
> +
> +		/* Reorder subvol list by depth. */
> +
> +		arr =3D malloc(sizeof(struct rootdir_subvol*) * num_subvols);
> +		if (!arr) {
> +			error("out of memory");
> +			goto error;
> +		}
> +
> +		ptr =3D arr;
> +
> +		list_for_each_entry(s, &subvols, list) {
> +			*ptr =3D s;
> +			ptr++;
> +		}
> +
> +		qsort(arr, num_subvols, sizeof(struct rootdir_subvol*),
> +		      subvol_compar);
> +
> +		INIT_LIST_HEAD(&subvols);
> +		for (i =3D 0; i < num_subvols; i++) {
> +			list_add_tail(&arr[i]->list, &subvols);
> +		}
> +
> +		free(arr);
> +
> +		/* Assign subvols to parents. */
> +
> +		list_for_each_entry(s, &subvols, list) {
> +			size_t len1;
> +
> +			if (s->depth =3D=3D 0)
> +				break;
> +
> +			len1 =3D strlen(s->fullpath);
> +
> +			for (struct rootdir_subvol *s2 =3D list_next_entry(s, list);
> +			     !list_entry_is_head(s2, &subvols, list);
> +			     s2 =3D list_next_entry(s2, list)) {
> +				size_t len2;
> +
> +				if (s2->depth =3D=3D s->depth)
> +					continue;
> +
> +				len2 =3D strlen(s2->fullpath);
> +
> +				if (len1 <=3D len2 + 1)
> +					continue;
> +
> +				if (s->fullpath[len2] !=3D '/')
> +					continue;
> +
> +				if (memcmp(s->fullpath, s2->fullpath, len2))
> +					continue;
> +
> +				s->parent =3D s2;
> +				list_add_tail(&s->child_list, &s2->children);
> +
> +				break;
> +			}
> +		}
> +	}
>
>   	if (*fs_uuid) {
>   		uuid_t dummy_uuid;
> @@ -1964,9 +2200,68 @@ raid_groups:
>   		goto out;
>   	}
>
> +	if (!list_empty(&subvols)) {
> +		struct rootdir_subvol *s;
> +		u64 objectid =3D BTRFS_FIRST_FREE_OBJECTID;
> +
> +		list_for_each_entry_reverse(s, &subvols, list) {
> +			struct btrfs_key key;
> +
> +			s->objectid =3D objectid;
> +
> +			trans =3D btrfs_start_transaction(root, 1);
> +			if (IS_ERR(trans)) {
> +				errno =3D -PTR_ERR(trans);
> +				error_msg(ERROR_MSG_START_TRANS, "%m");
> +				goto error;
> +			}
> +
> +			ret =3D create_subvol(trans, root, objectid);

Would it be possible to do the subvolume creation during regular
directory traversal?

By that we can just treat a target subvolume as a slightly different
directory creation.
The biggest problem here is, we only insert the root items without any
backref, and immediately commits the transaction, and would need special
handling for target subvolumes anyway.

If by somehow the mkfs is interrupted, what we got is a corrupted fs
with a lot of subvolume which can not be accessed.
(Well, not a huge problem since the mkfs is not done, its super magic is
not a valid one, kernel won't be able to mount them anyway)

Thanks,
Qu
> +			if (ret < 0) {
> +				error("failed to create subvolume: %d", ret);
> +				goto out;
> +			}
> +
> +			ret =3D btrfs_commit_transaction(trans, root);
> +			if (ret) {
> +				errno =3D -ret;
> +				error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
> +				goto out;
> +			}
> +
> +			key.objectid =3D objectid;
> +			key.type =3D BTRFS_ROOT_ITEM_KEY;
> +			key.offset =3D (u64)-1;
> +
> +			s->root =3D btrfs_read_fs_root(fs_info, &key);
> +			if (IS_ERR(s->root)) {
> +				error("unable to fs read root: %lu", PTR_ERR(s->root));
> +				goto out;
> +			}
> +
> +			objectid++;
> +		}
> +	}
> +
>   	if (source_dir) {
> +		LIST_HEAD(subvol_children);
> +
>   		pr_verbose(LOG_DEFAULT, "Rootdir from:       %s\n", source_dir);
> -		ret =3D btrfs_mkfs_fill_dir(source_dir, root);
> +
> +		if (!list_empty(&subvols)) {
> +			struct rootdir_subvol *s;
> +
> +			list_for_each_entry(s, &subvols, list) {
> +				if (s->parent)
> +					continue;
> +
> +				list_add_tail(&s->child_list,
> +					      &subvol_children);
> +			}
> +		}
> +
> +		ret =3D btrfs_mkfs_fill_dir(source_dir, root,
> +					  &subvol_children);
>   		if (ret) {
>   			error("error while filling filesystem: %d", ret);
>   			goto out;
> @@ -1983,6 +2278,41 @@ raid_groups:
>   		} else {
>   			pr_verbose(LOG_DEFAULT, "  Shrink:           no\n");
>   		}
> +
> +		if (!list_empty(&subvols)) {
> +			struct rootdir_subvol *s;
> +
> +			list_for_each_entry_reverse(s, &subvols, list) {
> +				pr_verbose(LOG_DEFAULT,
> +					   "  Subvol from:      %s\n",
> +					   s->fullpath);
> +			}
> +		}
> +	}
> +
> +	if (!list_empty(&subvols)) {
> +		struct rootdir_subvol *s;
> +
> +		list_for_each_entry(s, &subvols, list) {
> +			ret =3D btrfs_mkfs_fill_dir(s->fullpath, s->root,
> +						  &s->children);
> +			if (ret) {
> +				error("error while filling filesystem: %d",
> +				      ret);
> +				goto out;
> +			}
> +		}
> +
> +		list_for_each_entry_reverse(s, &subvols, list) {
> +			if (!btrfs_mksubvol(s->parent ? s->parent->root : root,
> +					    path_basename(s->dir), s->objectid,
> +					    false, s->parent_inum,
> +					    true)) {
> +				error("unable to link subvolume %s",
> +				      path_basename(s->dir));
> +				goto out;
> +			}
> +		}
>   	}
>
>   	if (features.runtime_flags & BTRFS_FEATURE_RUNTIME_QUOTA ||
> @@ -2076,6 +2406,18 @@ out:
>   	free(label);
>   	free(source_dir);
>
> +	while (!list_empty(&subvols)) {
> +		struct rootdir_subvol *head =3D list_entry(subvols.next,
> +					      struct rootdir_subvol,
> +					      list);
> +
> +		free(head->dir);
> +		free(head->fullpath);
> +
> +		list_del(&head->list);
> +		free(head);
> +	}
> +
>   	return !!ret;
>
>   error:
> @@ -2087,6 +2429,19 @@ error:
>   	free(prepare_ctx);
>   	free(label);
>   	free(source_dir);
> +
> +	while (!list_empty(&subvols)) {
> +		struct rootdir_subvol *head =3D list_entry(subvols.next,
> +					      struct rootdir_subvol,
> +					      list);
> +
> +		free(head->dir);
> +		free(head->fullpath);
> +
> +		list_del(&head->list);
> +		free(head);
> +	}
> +
>   	exit(1);
>   success:
>   	exit(0);
> diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
> index 617a7efd..3377bec5 100644
> --- a/mkfs/rootdir.c
> +++ b/mkfs/rootdir.c
> @@ -493,7 +493,8 @@ error:
>
>   static int traverse_directory(struct btrfs_trans_handle *trans,
>   			      struct btrfs_root *root, const char *dir_name,
> -			      struct directory_name_entry *dir_head)
> +			      struct directory_name_entry *dir_head,
> +			      struct list_head *subvol_children)
>   {
>   	int ret =3D 0;
>
> @@ -570,6 +571,28 @@ static int traverse_directory(struct btrfs_trans_ha=
ndle *trans,
>   				pr_verbose(LOG_INFO, "ADD: %s\n", tmp);
>   			}
>
> +			/* Omit child if it is going to be a subvolume. */
> +			if (!list_empty(subvol_children) && S_ISDIR(st.st_mode)) {
> +				struct rootdir_subvol *s;
> +				bool skip =3D false;
> +
> +				if (bconf.verbose < LOG_INFO) {
> +					path_cat_out(tmp, parent_dir_entry->path,
> +						     cur_file->d_name);
> +				}
> +
> +				list_for_each_entry(s, subvol_children, child_list) {
> +					if (!strcmp(tmp, s->fullpath)) {
> +						s->parent_inum =3D parent_inum;
> +						skip =3D true;
> +						break;
> +					}
> +				}
> +
> +				if (skip)
> +					continue;
> +			}
> +
>   			/*
>   			 * We can not directly use the source ino number,
>   			 * as there is a chance that the ino is smaller than
> @@ -680,7 +703,8 @@ fail_no_dir:
>   	goto out;
>   }
>
> -int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root=
)
> +int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root=
,
> +			struct list_head *subvol_children)
>   {
>   	int ret;
>   	struct btrfs_trans_handle *trans;
> @@ -705,7 +729,8 @@ int btrfs_mkfs_fill_dir(const char *source_dir, stru=
ct btrfs_root *root)
>   		goto fail;
>   }
>
> -	ret =3D traverse_directory(trans, root, source_dir, &dir_head);
> +	ret =3D traverse_directory(trans, root, source_dir, &dir_head,
> +				 subvol_children);
>   	if (ret) {
>   		error("unable to traverse directory %s: %d", source_dir, ret);
>   		goto fail;
> diff --git a/mkfs/rootdir.h b/mkfs/rootdir.h
> index 8d5f6896..598eb1a7 100644
> --- a/mkfs/rootdir.h
> +++ b/mkfs/rootdir.h
> @@ -36,7 +36,21 @@ struct directory_name_entry {
>   	struct list_head list;
>   };
>
> -int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root=
);
> +struct rootdir_subvol {
> +	struct list_head list;
> +	struct list_head child_list;
> +	char *dir;
> +	char *fullpath;
> +	struct rootdir_subvol *parent;
> +	u64 parent_inum;
> +	struct list_head children;
> +	unsigned int depth;
> +	u64 objectid;
> +	struct btrfs_root *root;
> +};
> +
> +int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root=
,
> +			struct list_head *subvol_children);
>   u64 btrfs_mkfs_size_dir(const char *dir_name, u32 sectorsize, u64 min_=
dev_size,
>   			u64 meta_profile, u64 data_profile);
>   int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_=
ret,
> diff --git a/tests/mkfs-tests/034-rootdir-subvol/test.sh b/tests/mkfs-te=
sts/034-rootdir-subvol/test.sh
> new file mode 100755
> index 00000000..d8085659
> --- /dev/null
> +++ b/tests/mkfs-tests/034-rootdir-subvol/test.sh
> @@ -0,0 +1,33 @@
> +#!/bin/bash
> +# smoke test for mkfs.btrfs --subvol option
> +
> +source "$TEST_TOP/common" || exit
> +
> +check_prereq mkfs.btrfs
> +check_prereq btrfs
> +
> +setup_root_helper
> +prepare_test_dev
> +
> +tmp=3D$(_mktemp_dir mkfs-rootdir)
> +
> +touch $tmp/foo
> +mkdir $tmp/dir
> +mkdir $tmp/dir/subvol
> +touch $tmp/dir/subvol/bar
> +
> +run_check_mkfs_test_dev --rootdir "$tmp" --subvol dir/subvol
> +run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
> +
> +run_check_mount_test_dev
> +run_check_stdout $SUDO_HELPER "$TOP/btrfs" subvolume list "$TEST_MNT" |=
 \
> +	cut -d\  -f9 > "$tmp/output"
> +run_check_umount_test_dev
> +
> +result=3D$(cat "$tmp/output")
> +
> +if [ "$result" !=3D "dir/subvol" ]; then
> +	_fail "dir/subvol not in subvolume list"
> +fi
> +
> +rm -rf -- "$tmp"

