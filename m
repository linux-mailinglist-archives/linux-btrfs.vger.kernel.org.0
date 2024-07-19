Return-Path: <linux-btrfs+bounces-6622-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1D1937DD1
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jul 2024 00:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9C02825AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 22:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B49148849;
	Fri, 19 Jul 2024 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FNE5EW9q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63042137E
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721427805; cv=none; b=PZR4pefYUuuyBVEamYhNLq0OivFQRqAz1c+HHoXjibwvP+dgVXX3T1USIeizEBaAMVLdsdoso03iUw0QuAOoBbkaBDlyi3YH/lT/9jjjwIn3cCOS/1XatO1GpTLop8kx3SNPEYtrphKv9SInNrDUedRRbX1fLwcxWNIbYtQBTR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721427805; c=relaxed/simple;
	bh=mLI2O6OWGK5CxxHn8n1V/kiH3YwtJ9eB1Q+Ub1gtNSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nJaa2hu5aXvqRws2sE+JCpoJiD8rZrhtJoQuC7spPdw6fUptbYUTx4i1zt8S/SW0kpeIEp3l6Ta0uy4xYfGKeDNzPZISbep81UBgElrm0/DZxVb0HPsLOf4O4ZQ3eB3++gGm8tfnu9/mmjC8waViPtuwmvvKceS/Y3j1nPvnrUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FNE5EW9q; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721427797; x=1722032597; i=quwenruo.btrfs@gmx.com;
	bh=3aMfSVo63euh6Bf50iMkl6HSYfxcEK3AGIFDvkgXQAY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FNE5EW9qKtbY6OamIaZ30WprdmPx4M3+JgtgqtlgJ5e89I9ad4b7GgALcBa2mxX4
	 KKltWeiOPnlKiUs7Cubz/QWg3UTzp76TbiLcrvVnQnIDYQjWIG7fBb0dTOXQNjB92
	 NfsChfOfXGWTJ94GX5CjHh28tNGGIRShcvTboPYtlqQMLeYC2bABrl5+L+5W1j2Wi
	 RGKXKgym6QWvSWFTivO0UPxrvnvJlLyMG5xVW0cNboBrA9L5d8GAIMIPMJ7boiKL8
	 IEN1wvIWSFK/2V01jW2YdD2NqeDNmDuZh4+vV88O7bFDVbwcZkOmkB8XlGKdnewC+
	 0F3qC/fxlQfApmjkyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEFzx-1sf4ML3QJx-006SjZ; Sat, 20
 Jul 2024 00:23:17 +0200
Message-ID: <3b2eb376-99e0-4428-9c35-3ee72ca1af50@gmx.com>
Date: Sat, 20 Jul 2024 07:53:14 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs-progs: add set_uuid param to
 btrfs_make_subvolume
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
References: <20240719150343.3992904-1-maharmstone@fb.com>
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
In-Reply-To: <20240719150343.3992904-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sVulWMWuSlhSkMX68Je+eibCzusDugIZIAGxKrFqO9N296nAZDU
 +gOht01kY/dLHMb2J+G8HF3hp92ZCOoJiivZnur2qwWiJc3VX7DQ2BGoDP+8Xo6NYO9ojzu
 09110qBmGWqMi/SrODQrctJPoY2gjqttnQnrmVbuItoe00dJdhZ7V+Atab9gWjY1GNW2vBs
 71xl1+uvFZfvuXNYudozQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LuIY/Bdpjxs=;BzfMV9V15+oTNqA//TEkDeOhR0o
 WHXVyBZi6bm8tOr8Rh8yfWGlHcmCK9hChKmC919CXqt6Mc0fuutAcNIioFfzoUePIc9lM9z4U
 iGdN9qJoWIruKxhVVGSLObRjSW7/ZmxpCW/55rGqXOnxxmJtk1S0m2DaxRrTS9WzUINnENxe/
 zASDC/myTPPk6aY2WjQ1bU1Ck5ZNe7DwQ0MaZCNwl6IF4Uajzsxslw5a8XCr5e1XnvpGD7tCZ
 uyE00wCHlfloQMxXtLCAmgNLmjKPJpIZ/yYjO/bBpKj63AKeKmF/aflhEwHnJ/FYfCrlaEMOg
 5SR0P2CISpfElZqMebCpAE3i8TpumTUt1XJ2IIbLavMYIAjJIpUT2b/QhR0hyKynUV50QOBl1
 Gr6r0cZvYqw1ipXIwHJE1WSp+ELncpQjAlDvv4Yj4LBg3KzOfOZxOQPJZM0rL0AXtwkvzzyDq
 AOb6/8ITmGyKoinurGx1NPT0aTPG6b9+LbunCLfUDl/JzObjDj5N68H91GHoj2QmMeR8U5GKz
 AB6MqWKMC3S9dpA/QxskdPMOV+bgM6//ichffZzxp5+pY4sd8eDPWhpYeArC8f+PYAmMGasZL
 yyiSmJ3UMVNDY8zI4S/fa6qlsYMWwAN+vONfW4BU7JZScvIsfnupy88Xk2rnDdEtjkodsnpPR
 CdOg+NGnxtEeMELv+HwtyDbDTA1Pq5OUA7wbC2gKBW88BeNpEQPT+fvpNbqSMcGpWuYuyktNr
 aw04woCm+PX2ds6kDLaOm9cpVvyHDio3+vW7H1nuqZdUrRYNcybT8vMI+4CrK6rVRhxIydrqX
 puSUAsl0DuO8KzDpN+50iCLA==



=E5=9C=A8 2024/7/20 00:33, Mark Harmstone =E5=86=99=E9=81=93:
> Adds a set_uuid parameter to btrfs_make_subvolume, which generates a
> uuid for the new root and adds it to the uuid tree.
>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   common/root-tree-utils.c | 72 +++++++++++++++++++++++++++++++++++++++-
>   common/root-tree-utils.h |  5 ++-
>   convert/main.c           |  5 +--
>   mkfs/main.c              | 59 ++------------------------------
>   4 files changed, 80 insertions(+), 61 deletions(-)
>
> diff --git a/common/root-tree-utils.c b/common/root-tree-utils.c
> index 6a57c51a..f9343304 100644
> --- a/common/root-tree-utils.c
> +++ b/common/root-tree-utils.c
> @@ -15,6 +15,7 @@
>    */
>
>   #include <time.h>
> +#include <uuid/uuid.h>
>   #include "common/root-tree-utils.h"
>   #include "common/messages.h"
>   #include "kernel-shared/disk-io.h"
> @@ -58,13 +59,70 @@ error:
>   	return ret;
>   }
>
> +int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 =
type,
> +			u64 subvol_id_cpu)
> +{
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +	struct btrfs_root *uuid_root =3D fs_info->uuid_root;
> +	int ret;
> +	struct btrfs_path *path =3D NULL;
> +	struct btrfs_key key;
> +	struct extent_buffer *eb;
> +	int slot;
> +	unsigned long offset;
> +	__le64 subvol_id_le;
> +
> +	btrfs_uuid_to_key(uuid, type, &key);
> +
> +	path =3D btrfs_alloc_path();
> +	if (!path) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	ret =3D btrfs_insert_empty_item(trans, uuid_root, path, &key, sizeof(s=
ubvol_id_le));
> +	if (ret < 0 && ret !=3D -EEXIST) {
> +		warning(
> +		"inserting uuid item failed (0x%016llx, 0x%016llx) type %u: %d",
> +			key.objectid, key.offset, type, ret);
> +		goto out;
> +	}
> +
> +	if (ret >=3D 0) {
> +		/* Add an item for the type for the first time. */
> +		eb =3D path->nodes[0];
> +		slot =3D path->slots[0];
> +		offset =3D btrfs_item_ptr_offset(eb, slot);
> +	} else {
> +		/*
> +		 * ret =3D=3D -EEXIST case, an item with that type already exists.
> +		 * Extend the item and store the new subvol_id at the end.
> +		 */
> +		btrfs_extend_item(path, sizeof(subvol_id_le));
> +		eb =3D path->nodes[0];
> +		slot =3D path->slots[0];
> +		offset =3D btrfs_item_ptr_offset(eb, slot);
> +		offset +=3D btrfs_item_size(eb, slot) - sizeof(subvol_id_le);
> +	}
> +
> +	ret =3D 0;
> +	subvol_id_le =3D cpu_to_le64(subvol_id_cpu);
> +	write_extent_buffer(eb, &subvol_id_le, offset, sizeof(subvol_id_le));
> +	btrfs_mark_buffer_dirty(eb);
> +
> +out:
> +	btrfs_free_path(path);
> +	return ret;
> +}
> +
>   /*
>    * Create a subvolume and initialize its content with the top inode.
>    *
>    * The created tree root would have its root_ref as 1.
>    * Thus for subvolumes caller needs to properly add ROOT_BACKREF items=
.
>    */
> -int btrfs_make_subvolume(struct btrfs_trans_handle *trans, u64 objectid=
)
> +int btrfs_make_subvolume(struct btrfs_trans_handle *trans, u64 objectid=
,
> +			 bool set_uuid)
>   {
>   	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>   	struct btrfs_root *root;
> @@ -96,6 +154,18 @@ int btrfs_make_subvolume(struct btrfs_trans_handle *=
trans, u64 objectid)
>   	ret =3D btrfs_make_root_dir(trans, root, BTRFS_FIRST_FREE_OBJECTID);
>   	if (ret < 0)
>   		goto error;
> +
> +	if (set_uuid) {
> +		uuid_generate(root->root_item.uuid);
> +
> +		ret =3D btrfs_uuid_tree_add(trans, root->root_item.uuid,
> +					  BTRFS_UUID_KEY_SUBVOL, objectid);
> +		if (ret < 0) {
> +			error("failed to add uuid entry");
> +			goto error;
> +		}
> +	}
> +
>   	ret =3D btrfs_update_root(trans, fs_info->tree_root, &root->root_key,
>   				&root->root_item);
>   	if (ret < 0)
> diff --git a/common/root-tree-utils.h b/common/root-tree-utils.h
> index 0c4ece24..78731dd5 100644
> --- a/common/root-tree-utils.h
> +++ b/common/root-tree-utils.h
> @@ -21,10 +21,13 @@
>
>   int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
>   			struct btrfs_root *root, u64 objectid);
> -int btrfs_make_subvolume(struct btrfs_trans_handle *trans, u64 objectid=
);
> +int btrfs_make_subvolume(struct btrfs_trans_handle *trans, u64 objectid=
,
> +			 bool set_uuid);
>   int btrfs_link_subvolume(struct btrfs_trans_handle *trans,
>   			 struct btrfs_root *parent_root,
>   			 u64 parent_dir, const char *name,
>   			 int namelen, struct btrfs_root *subvol);
> +int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 =
type,
> +			u64 subvol_id_cpu);
>
>   #endif
> diff --git a/convert/main.c b/convert/main.c
> index 078ef64e..c863ce91 100644
> --- a/convert/main.c
> +++ b/convert/main.c
> @@ -1022,13 +1022,14 @@ static int init_btrfs(struct btrfs_mkfs_config *=
cfg, struct btrfs_root *root,
>   			     BTRFS_FIRST_FREE_OBJECTID);
>
>   	/* subvol for fs image file */
> -	ret =3D btrfs_make_subvolume(trans, CONV_IMAGE_SUBVOL_OBJECTID);
> +	ret =3D btrfs_make_subvolume(trans, CONV_IMAGE_SUBVOL_OBJECTID, false)=
;
>   	if (ret < 0) {
>   		error("failed to create subvolume image root: %d", ret);
>   		goto err;
>   	}
>   	/* subvol for data relocation tree */
> -	ret =3D btrfs_make_subvolume(trans, BTRFS_DATA_RELOC_TREE_OBJECTID);
> +	ret =3D btrfs_make_subvolume(trans, BTRFS_DATA_RELOC_TREE_OBJECTID,
> +				   false);
>   	if (ret < 0) {
>   		error("failed to create DATA_RELOC root: %d", ret);
>   		goto err;
> diff --git a/mkfs/main.c b/mkfs/main.c
> index cf5cae45..0bdb414a 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -735,62 +735,6 @@ static void update_chunk_allocation(struct btrfs_fs=
_info *fs_info,
>   	}
>   }
>
> -static int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uu=
id,
> -			       u8 type, u64 subvol_id_cpu)
> -{
> -	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -	struct btrfs_root *uuid_root =3D fs_info->uuid_root;
> -	int ret;
> -	struct btrfs_path *path =3D NULL;
> -	struct btrfs_key key;
> -	struct extent_buffer *eb;
> -	int slot;
> -	unsigned long offset;
> -	__le64 subvol_id_le;
> -
> -	btrfs_uuid_to_key(uuid, type, &key);
> -
> -	path =3D btrfs_alloc_path();
> -	if (!path) {
> -		ret =3D -ENOMEM;
> -		goto out;
> -	}
> -
> -	ret =3D btrfs_insert_empty_item(trans, uuid_root, path, &key, sizeof(s=
ubvol_id_le));
> -	if (ret < 0 && ret !=3D -EEXIST) {
> -		warning(
> -		"inserting uuid item failed (0x%016llx, 0x%016llx) type %u: %d",
> -			key.objectid, key.offset, type, ret);
> -		goto out;
> -	}
> -
> -	if (ret >=3D 0) {
> -		/* Add an item for the type for the first time. */
> -		eb =3D path->nodes[0];
> -		slot =3D path->slots[0];
> -		offset =3D btrfs_item_ptr_offset(eb, slot);
> -	} else {
> -		/*
> -		 * ret =3D=3D -EEXIST case, an item with that type already exists.
> -		 * Extend the item and store the new subvol_id at the end.
> -		 */
> -		btrfs_extend_item(path, sizeof(subvol_id_le));
> -		eb =3D path->nodes[0];
> -		slot =3D path->slots[0];
> -		offset =3D btrfs_item_ptr_offset(eb, slot);
> -		offset +=3D btrfs_item_size(eb, slot) - sizeof(subvol_id_le);
> -	}
> -
> -	ret =3D 0;
> -	subvol_id_le =3D cpu_to_le64(subvol_id_cpu);
> -	write_extent_buffer(eb, &subvol_id_le, offset, sizeof(subvol_id_le));
> -	btrfs_mark_buffer_dirty(eb);
> -
> -out:
> -	btrfs_free_path(path);
> -	return ret;
> -}
> -
>   static int create_uuid_tree(struct btrfs_trans_handle *trans)
>   {
>   	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> @@ -1871,7 +1815,8 @@ raid_groups:
>   		goto out;
>   	}
>
> -	ret =3D btrfs_make_subvolume(trans, BTRFS_DATA_RELOC_TREE_OBJECTID);
> +	ret =3D btrfs_make_subvolume(trans, BTRFS_DATA_RELOC_TREE_OBJECTID,
> +				   false);
>   	if (ret) {
>   		error("unable to create data reloc tree: %d", ret);
>   		goto out;

