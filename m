Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15EA40AAB6
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 11:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhINJYQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 05:24:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:50487 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229903AbhINJYL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 05:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631611372;
        bh=jFim4L5E8D6Pyu1X6Iw8He2NTKoQMXTBrXjuMNISTsM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WUEh3D4nZaKiCFl0DW6V99n2ckk7M60O/DUHzey41Oy+ooXGLM9OVHXtiOQEMiXR/
         ZF49YlO0js7yEIB30kmTQmn0MxwVD7sMEvczZXAeYlh34uWGDxW9hKlRF/fvUEfzs3
         rzKS20YngwAdXQXB3RP/r4rY0iw7Zrz5yq3riIjo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTABZ-1mLICS2kBT-00Ua0C; Tue, 14
 Sep 2021 11:22:52 +0200
Subject: Re: [PATCH v2 5/8] btrfs-progs: Add btrfs_uuid_tree_remove
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210914090558.79411-1-nborisov@suse.com>
 <20210914090558.79411-6-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <1b4eb1fd-6770-746c-6b65-84ef12572652@gmx.com>
Date:   Tue, 14 Sep 2021 17:22:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914090558.79411-6-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PLlePZKOOQlvN2D4GI8CvYbNfj5ihKOguJRGN+vZmCXvIQpq8Xc
 QNgL2Jh1N6ePYKUHbEwTIpuyEcpGDYZuEaUg/6NkYHKL7l8nt0s2BUkCRPNzfqA51olWHg1
 WuntWiDZidYugLGa8C0b93jSZO6T7XGyAqa3dJEdNbb3/a0MhFg5Ot56L8j721Dph7wimf5
 h1vmrIA18ebqKh92tqY9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rgjcICmoGsM=:QSn0+B67XQL6DdemWlvaCa
 JQmxaGNolPduCGK+GQQyc6q0AiMmF7fr3+ZdX/Idou2DuvRzHegNrEhV9iD3SUufqRT5Ji3xJ
 vOfYKrhkMAs2kA0DDbyBzdfscIBYFmsOBqk7Dl2AxEw1YbikN/FYTk2VPysqdzrLURNvTbP9K
 QizjdjCpd1K1OGUYPlsTkDtl27RvOymGLKiB4mBD9FM0+1C+MIWEPcJaQhP0Q98FQRGPwULsv
 6Z1gr2X2CtCbB8C/a/rw8bJf9HT7ic9Jklj2BmV2/Xn/WZaGdfLlf2yq1jKRlOOPhj0YS0y1y
 89o9SCLOVDD6pU4uuxGijXEtogkmnK4C4oekwWHL+1n4Ph7P+pgqdoEMqcF3s7U9KIS+f8vch
 L4zQKNG/zbDOg3p8C6qxDVRL0QBte4+d9+koF5n3IX30DRulIUyd2INSVo1yLLvn7Ia+HJ5ZJ
 TTGpTpwcRpTnCw/qpaM8xjokWXRdaDfFvkXpst8qCqYmDtHwVj4BWETTpJdPrwKeqjHIru2B2
 1ZGRMJDPEzhXC1pXI1dRL/ujEIek1Ev+28D8Wbv2nTjyEvHZHwBswA+YojYuTIA7FQVmWlh/H
 EDI/OLTJEyU7xjnfe7tavai+dMm1mN+i2qi/N9mtYqF90gbWDDQA3OfEjdXHGiYtxlGMQbF+7
 qjU6oJRy6ryXacAAt0pU7uzrRmiO49aIaGhq6P3e3OUkpPrJJbgjDHzaXN/JMaJUWxbN5d6mQ
 RmD5/C43ycC6/6aBTO4mjh3Eh6D0KE3BwCURiX5PAus0tFM9+qJyajOHTnJktWOyPsuzuRmpQ
 lM6Dkp3JNHKWdHY8OQwSvapejRWrg9D5xSlgDcqDKGIKD1BW2X5axP7WARfns0O+NSDQspwUn
 7FlEJUHDvEHQB2EHoJdQTP9XhEcH8YoF4fNiZ3zr4/pMi4JOeZxFMOOaV16spUbq0NHN3C9it
 xK8wqAbCbeyJgtoC3kaXrCWSFtkCGdbQ+YnKtez67hq7QQbvneeDvOW7F8PH+igbeONgt8A3I
 qyGfAcsA+C2g7hLIzE1FRWjKVIIiFeFqAgdocCYfZ8xLZFDNyuN38PweBx+t922FHPYkr4iz7
 9yK5Jk2XeEENvM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/14 =E4=B8=8B=E5=8D=885:05, Nikolay Borisov wrote:
> It will be used to clear received data on RW snapshots that were
> received.

It would be more helpful to mention it's a backport of kernel function.

>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

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
