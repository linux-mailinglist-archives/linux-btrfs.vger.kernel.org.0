Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EF240A254
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 03:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbhINBIm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 21:08:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:57147 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230404AbhINBIl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 21:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631581643;
        bh=izl4kUDJWqWj7Zr2fzNiuJk/2RAmGwaP+OCtj3nFwog=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=NgCARNKbClVsVczFe9Pv9suuPj8XgDQ913a5BkQxVmTdDPDwI1j6W90SxeDi57AIf
         pI1lgTQUrkDdOemvyjvbDXuJhyYbHJBgt244tnLtAPsr1dKz8Yc1Z3M9cd/QM/byP2
         7HIvTdywSx5w1rt1bJl29QczduhyH9cXBbsKnpwQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLzBp-1mhCeZ2Ozh-00Hw0Q; Tue, 14
 Sep 2021 03:07:23 +0200
Subject: Re: [PATCH 5/8] btrfs-progs: Add btrfs_uuid_tree_remove
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210913131729.37897-1-nborisov@suse.com>
 <20210913131729.37897-6-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f84fe95a-1469-9e39-2813-4111fe258390@gmx.com>
Date:   Tue, 14 Sep 2021 09:07:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913131729.37897-6-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GGxLwWwpPS1R9Y0G1IEc9ZwGmsQCghEL0r4VQOaU8WU36WdYZrM
 0FGwHsu+mfKPyvfcLOzrh6iJvoN/eUoIL+vGibUlJzvPnst7y7x/hBizClav/emzqQkBYw7
 0zWe3JAUDpY2sCjyCLz05WXvvC5S37QeQnofiQ2UDJP1QP1VSh6yS+vk8MFs2DL+xvZ1edT
 K1v2UHixYMj2QFMnYn24g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nv6/D22u/g8=:GN3BkIrWeDTeZyM4l+AT/p
 hNCq1z+mUDQs5RpT9913h57MQz3YcUtUBjRDXS2RnFFN7zbB+7zvXjhSXdJwftc0pB8Sqd/nB
 KbqlDcfuPXbbpwm2ndRnMfLZbvWoOTIV3y8jTHCHrWnQWKh3KonGHR1oL6AkVe2s39qTYLOd2
 x8mPfJrmIpCJ2eCNmLSHFfD7kQSic+sxIg1abw7jjHvULwQVBGXdlQWIfmvhxBV8G91En5B95
 0CoObN9P5pQN6PhdmPmYJCWvqWFOQdcOh7ovDzAmRtyxDuVLpXdGB6cgMENjiRtKWZAxTekd6
 mSgM5P569yF54/RxaWODmmGwaFZYTZTDDsD0h0GR6zbQRqdT7O7iy20b2+ZWCUWqSGXjtN5t3
 PcUAPjo8PbXLR2+lZVJZYKy+cg/yWG4CrKxvRvjjrEAEndvE0V0Hl+ZzFRGl6h8GcEd4pPvEN
 /TL9Dk3CCIp7VnfJDDJDe4PSvVUWeNyayq7t3pbgk4nWpvuLMd623ZPWiKCsyVtoTypGc97Yg
 irj4SotMxlYT4tbhjSy+l5/095tpveYpbjEKto/IR+7noiPaudRfMOuoiten/QYtGed6NYQuJ
 OZa3gbqIxoMIRaL+CL0dMlKCmH0jhMsAgfjZnnPbY1LC+GWQdd1Fnm8AEfHwOXUnCFjhZbSu4
 HEbhM+y+Yz0/La/Y0u8dHbD1pEwtQky8RedY54kWaahhu3dHgquNuahR92+Pi+lTXRbKhQh54
 17ftLM53CkMY1/IeZD5BISpKj70PoBIqRpjrw1/7p+wvvEi2EDlnkmQF/yF/f1C9i5/pdz3m2
 pV71OPkuo9gfALFqBnk85RWnoJ55xBtQ68NSaJH2LfdZBQtT8cEqT0gfdF1jmQtvMSWcYUiTc
 5BKG6MpnRJRJPA7zz7QRi2F/G8bKlPP3rK99dij3o527pMcxhuFtrsnWHTKgdEioLUQxxkB0U
 zLI/s7ZEmCbVUldCNxr3pVXceJleBUFZszzUZ7Ybc8wWqvTZYm5mC0c1N97Wnqm0ktsCFoi+x
 slu7icXH/Mooz9KyupBSxYdiydqV7K/+pUkVURZP9peUMuYPeWr2PRa4L6dd4LSLOBH/PMwOH
 Abt3E9w3qM+urI=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/13 =E4=B8=8B=E5=8D=889:17, Nikolay Borisov wrote:
> It will be used to clear received data on RW snapshots that were
> received.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   kernel-shared/ctree.h     |  3 ++
>   kernel-shared/uuid-tree.c | 82 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 85 insertions(+)
>
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index 91a85796a678..158281a9fd67 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -2860,6 +2860,9 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle =
*trans, u8 *uuid, u8 type,
>   			u64 subvol_id_cpu);
>
>   int btrfs_is_empty_uuid(u8 *uuid);
> +int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, =
u8 type,
> +               u64 subid);
> +

I have checked the callers in the incoming check patches, they are all
starting a new trans on uuid tree, thus there is no need to start a
trans out of this function.

Let's just pass the subvolume root into the function, and start a new
trans in side the function.

So that we only need one parameter @root, everything else can be fetched
from @root, and we can also modify the root item and uuid tree just in
one go.

Thanks,
Qu
>
>   static inline int is_fstree(u64 rootid)
>   {
> diff --git a/kernel-shared/uuid-tree.c b/kernel-shared/uuid-tree.c
> index 51a7b5d9ff5d..0f0fbf667dda 100644
> --- a/kernel-shared/uuid-tree.c
> +++ b/kernel-shared/uuid-tree.c
> @@ -120,3 +120,85 @@ int btrfs_is_empty_uuid(u8 *uuid)
>   	}
>   	return 1;
>   }
> +
> +int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, =
u8 type,
> +		u64 subid)
> +{
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +	struct btrfs_root *uuid_root =3D fs_info->uuid_root;
> +	int ret;
> +	struct btrfs_path *path =3D NULL;
> +	struct btrfs_key key;
> +	struct extent_buffer *eb;
> +	int slot;
> +	unsigned long offset;
> +	u32 item_size;
> +	unsigned long move_dst;
> +	unsigned long move_src;
> +	unsigned long move_len;
> +
> +	if (!uuid_root) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	btrfs_uuid_to_key(uuid, &key);
> +	key.type =3D type;
> +
> +	path =3D btrfs_alloc_path();
> +	if (!path) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	ret =3D btrfs_search_slot(trans, uuid_root, &key, path, -1, 1);
> +	if (ret < 0) {
> +		warning("error %d while searching for uuid item!", ret);
> +		goto out;
> +	}
> +	if (ret > 0) {
> +		ret =3D -ENOENT;
> +		goto out;
> +	}
> +
> +
> +	eb =3D path->nodes[0];
> +	slot =3D path->slots[0];
> +	offset =3D btrfs_item_ptr_offset(eb, slot);
> +	item_size =3D btrfs_item_size_nr(eb, slot);
> +	if (!IS_ALIGNED(item_size, sizeof(u64))) {
> +		warning("uuid item with illegal size %lu!",	(unsigned long)item_size)=
;
> +		ret =3D -ENOENT;
> +		goto out;
> +	}
> +	while (item_size) {
> +		__le64 read_subid;
> +
> +		read_extent_buffer(eb, &read_subid, offset, sizeof(read_subid));
> +		if (le64_to_cpu(read_subid) =3D=3D subid)
> +			break;
> +		offset +=3D sizeof(read_subid);
> +		item_size -=3D sizeof(read_subid);
> +	}
> +
> +	if (!item_size) {
> +		ret =3D -ENOENT;
> +		goto out;
> +	}
> +
> +	item_size =3D btrfs_item_size_nr(eb, slot);
> +	if (item_size =3D=3D sizeof(subid)) {
> +		ret =3D btrfs_del_item(trans, uuid_root, path);
> +		goto out;
> +	}
> +
> +	move_dst =3D offset;
> +	move_src =3D offset + sizeof(subid);
> +	move_len =3D item_size - (move_src - btrfs_item_ptr_offset(eb, slot));
> +	memmove_extent_buffer(eb, move_dst, move_src, move_len);
> +	btrfs_truncate_item(path, item_size - sizeof(subid), 1);
> +
> +out:
> +	btrfs_free_path(path);
> +	return ret;
> +}
>
