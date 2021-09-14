Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D4D40AABA
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 11:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhINJZT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 05:25:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:48419 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhINJZS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 05:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631611439;
        bh=tLQjPgKudA4UmZj37h4My90h9ETFaCt4QYomMlwTNFk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=hJI/l3T7F6Koex/a1IT+T5VtRnRH4YqRbZp24Zp0HgsMu+2JwaAveTMqgw3uyf/Fs
         KkiRderf08U4Y4gM3urmAs/R7eO0jWHnJSiBIPaw68yZ+kpjnI8CRBZz78FgH5h0mC
         yYUhOpNw4yadGb9gRHNTbV6ibA6XQTjMPLuNdhr4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1wpt-1msyVb4B7h-012F6K; Tue, 14
 Sep 2021 11:23:59 +0200
Subject: Re: [PATCH v2 6/8] btrfs-progs: Implement helper to remove received
 information of RW subvol
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210914090558.79411-1-nborisov@suse.com>
 <20210914090558.79411-7-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <c3e85419-011a-02e4-736e-ae463349d6ea@gmx.com>
Date:   Tue, 14 Sep 2021 17:23:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914090558.79411-7-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lgr0H/rIQkeHngan57Ss2lvVqajCSJcld/DefryHudnxU4YV9dK
 fR7wqiJAqfTjtAJtMrcSq/qiGEta0nTnZpilaCmAxdHiJzCzGhlvK3oHVPvCAoHEpjabZf7
 Q5wM12t3GJGoh+an3y7AGWZL9poCmUTFD9d3XfoyHCKqXn6VZB+msWaJGCwpiJoDw7cKUQH
 5vqtYwgONzvtcSm8+daSQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RN7SvvKnBfY=:FT1iZedTczTXoVKjE28Coz
 3SEJ7Byjm5BmJ+hlRQNpalq1hln5EsZmIh7BnyKnDTYdcbpadvQIPGLTrQSekKD4AwiNhY3MK
 ONhGzoTRTCy5ze74lXbHF8Crc7bfYvAP1OJr7NX99ZhBGsaCDdFNFwo6jkMjx9O0XZO++Ndsz
 BmAdHi2JoUIDFS8S7lnEuPMuuiCmwtVoDoH/M7eoZaMNQs8704MR+X6uiaccVY91/zqbxqIsM
 xvxvjLmgFBylN4TVf888Z/qB9Q77TobHlAdKlXjWm8aehoM6wWRRRQHpr0RdXmHShOWUU4uK4
 ZFqWqkiG8wQr8I/N9ndP8WJ/Td4WaLvTzQeSQx5595eybyMWOSD1gWyac4gj6Z7XdE/dPuB5R
 mmUvAYz2mD3yOg0/ceUcubjtCMFaJmVOpnjEntPha4kkT1j0D9eVI1jvJiXq/zS1lxYHhOwVj
 CbJZJ+Xpf6Ru99adINMmp5fvDa4TqsDrWwXBgP7GCXJjo2R20wN7ns7pSkcq4tgc65kmM6lvQ
 dBUVo0w2F/AvZNmt0PAGh7wvLuYI7lW8H+ia6ZH1Y/q8Tie4AF2AXuKNYtcFMRkrgEpi+s0fE
 tcVrR6WEzNOH7Xh+3Exv2myNEq8M9zIGumMLeRpTHFYZRwZcaNREjnVezyek3q1/tt0kYDkBN
 xokhF9A5KUxDs1ex0EziUWHutY04EXjhk5SwYbZspmWLU5vfFL0NEerHpKvUnqkMBqSAW+Z5m
 cRDmagrBjpb2hDByqfeUmjfh7afjsT7SZVrForLVm4eyAg2xwS61eFuJycKOv603/fy/DvZ63
 bfM17e0TtwwyxXRzd+gbTho/YSv1rder8X5hoeNW1jnYlvBC+vtoiexhBC5AStTDAUa1CaNUZ
 rxQnaFzE5t0+OnVE1dpVJvbUpK03Khk82iB40zrx+jU3KQeGTGUzaNJHIp5hxRfKfgN6WThpZ
 zRtq4wFMvi8pI22iXP1iFzKnBanOWcdF2lLo0PDhx2SGIoB72jNd1Ty7W4eNSejcfBhVSbp+p
 mjn0pWmitYkR71+y52ZeCdEQH5t9Lm2Nilvhbndb8Z7lkMmFcsU6yPD9+5v/zB2jWd87m1lx2
 UwZd6Kdvvm2D0s=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/14 =E4=B8=8B=E5=8D=885:05, Nikolay Borisov wrote:
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   check/mode-common.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   check/mode-common.h |  1 +
>   2 files changed, 41 insertions(+)
>
> diff --git a/check/mode-common.c b/check/mode-common.c
> index 0059672c6402..7a5313280f3f 100644
> --- a/check/mode-common.c
> +++ b/check/mode-common.c
> @@ -1301,3 +1301,43 @@ int repair_dev_item_bytes_used(struct btrfs_fs_in=
fo *fs_info,
>   	btrfs_abort_transaction(trans, ret);
>   	return ret;
>   }
> +
> +int repair_received_subvol(struct btrfs_root *root)
> +{
> +	struct btrfs_root_item *root_item =3D &root->root_item;
> +	struct btrfs_trans_handle *trans;
> +	int ret;
> +
> +	trans =3D btrfs_start_transaction(root, 2);
> +	if (IS_ERR(trans))
> +		return PTR_ERR(trans);
> +
> +	ret =3D btrfs_uuid_tree_remove(trans, root_item->received_uuid,
> +			BTRFS_UUID_KEY_RECEIVED_SUBVOL, root->root_key.objectid);
> +
> +	if (ret && ret !=3D -ENOENT) {
> +		btrfs_abort_transaction(trans, ret);
> +		return ret;
> +	}
> +
> +	memset(root_item->received_uuid, 0, BTRFS_UUID_SIZE);
> +	btrfs_set_root_stransid(root_item, 0);
> +	btrfs_set_root_rtransid(root_item, 0);
> +	btrfs_set_stack_timespec_sec(&root_item->stime, 0);
> +	btrfs_set_stack_timespec_nsec(&root_item->stime, 0);
> +	btrfs_set_stack_timespec_sec(&root_item->rtime, 0);
> +	btrfs_set_stack_timespec_nsec(&root_item->rtime, 0);
> +
> +	ret =3D btrfs_update_root(trans, gfs_info->tree_root, &root->root_key,
> +			root_item);
> +	if (ret < 0) {
> +		btrfs_abort_transaction(trans, ret);
> +		return ret;
> +	}
> +
> +	ret =3D btrfs_commit_transaction(trans, gfs_info->tree_root);
> +	if (!ret)
> +		printf("Cleared received information for subvol: %llu\n",
> +				root->root_key.objectid);
> +	return ret;
> +}
> diff --git a/check/mode-common.h b/check/mode-common.h
> index cdfb10d58cde..f1ec5dca0199 100644
> --- a/check/mode-common.h
> +++ b/check/mode-common.h
> @@ -130,6 +130,7 @@ int reset_imode(struct btrfs_trans_handle *trans, st=
ruct btrfs_root *root,
>   		struct btrfs_path *path, u64 ino, u32 mode);
>   int repair_imode_common(struct btrfs_root *root, struct btrfs_path *pa=
th);
>   int check_repair_free_space_inode(struct btrfs_path *path);
> +int repair_received_subvol(struct btrfs_root *root);
>
>   /*
>    * Check if the inode mode @imode is valid
>
