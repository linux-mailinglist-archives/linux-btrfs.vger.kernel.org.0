Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143A83222CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 00:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhBVXzT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 18:55:19 -0500
Received: from mout.gmx.net ([212.227.15.18]:50559 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231569AbhBVXzS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 18:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614038026;
        bh=51fyxy6SW8zwg98+G6pKgimlUdFkAGku6EepE46zScI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=c3p0er5VReHPsN9Wx32OmI6mkcatLrxM+79eJYKiOIb2sj95JabPjoMDgv3UrEJVr
         hK5aKALG1GDvmopHzIxOjWco7fZQCO5TI13MjPRIbixYlIKo6zxnq1KH8WhOQ2EbhE
         xKzJfQE+i0L9W9y8AzqwIuFHe6oiMm7LOR9+C/3A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MqJm5-1lbM302fwJ-00nTD4; Tue, 23
 Feb 2021 00:53:46 +0100
Subject: Re: [PATCH 5/6] btrfs: Remove btrfs_inode from
 btrfs_delayed_inode_reserve_metadata
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210222164047.978768-1-nborisov@suse.com>
 <20210222164047.978768-6-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <b44ce4c5-ecc4-2fa0-d2ea-8cc98785dfbd@gmx.com>
Date:   Tue, 23 Feb 2021 07:53:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210222164047.978768-6-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y9E3Tztqd73Ox7rTr1FMb7Abdfu3q2YQpPM42fLeq0IHbRQ6e6O
 5gbC5UP4eEsS3eJwty/dEy3D+dDoFUmp0h8rrULd9MryOwYyA5cklsSTXWqOoiRLT1m0lbU
 afgW8wmKakqmjA6rSB9D1nZ76qGTdvBu4QBTjszZtq4aWKIn5js4enURQecPS3XIOudns73
 +EhgLE2fKThjOWr9SsK5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RmhRu6Ht7tg=:qgI3Tp2rvhPylLfcTXry2u
 3XWGQuJhxizs/4TmLqkbdvbabaHcFfV4YzxByb3r9df6jpYQQidr97AxPYpN/4a1bIwd2kbw1
 4ESsbXCV88NdP2IdRp46gWIhYcVLHfMYRNMTKi3vGsRRxR+riu0fT0edSn7O2I2mhKOoISDel
 bPBH3eJqz3mlSHid57+WrEDAxBBVsdPdOTAtt8htBEkt1ue4Cm3VYoP+/3YyMQFsKGn9jHSnY
 JW+VRacpp3dIgp0Cnq5ZCK1ykEhHcZ9yZuQY2i7fch968PVbMSSCIjHNoqkJUpaJXhsLfeTcO
 zgzZpj7qNSDS0tNOD/7+Az6t27rej9WuOKKK4g9HfXW9tHA+are9f2p6oarePs3oz3i38RD1m
 0Xf4+yAM+33Yx7t/XAged+D9qDCXC8swcWSDiQyEhARAy46Vp96ZiVwynrquMmsMjGmJSbP7M
 LIYGsaVUstnEXCjq/Vc3HuTka0Mao9V+kRMLIN+e/JsBKXYZl0tC0IkrWp/koxPY8rzY5EC5X
 PjFU1cJeuec4u4eYrF8Ccq5SSSnbGXCrixoeuo2gR4r+/1YULg+ju2yiZOVDjrmUReK7SPhEB
 KQl0YUQTLSey7DLZEgyY8cl0bJMwq4qCMwpuJTIAnIf87oA40Sjymq3pzzcDCSZ7KDIJ3Quwv
 OR85PV++M4m4mt6PYDVh9zvbDbIjhMS1rDb3YjMSVvq0ewP9wgSfDSlyHvOnSEvkSAzaXkzL0
 mRqC6Xr4x0LH4GtgDZosK8vmm3i55PzFWtS0R89op4dbmYAPP360GOVe9cKUpozvHCqZcG5Lc
 TBbk1YbAi86uAgjnEftYR9tA6WZkMTksqP5Ts1w2Z3zc75PfAHI1ybeUyBRya2zhze6H41Z9b
 TkpPZkGcoJ/9vj6H8jUQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/23 =E4=B8=8A=E5=8D=8812:40, Nikolay Borisov wrote:
> It's only used for tracepoint to obtain the ino, but we already have
> the ino from btrfs_delayed_node::inode_id.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/delayed-inode.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 6dcf2cd1b39e..875daca63d5d 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -602,7 +602,6 @@ static void btrfs_delayed_item_release_metadata(stru=
ct btrfs_root *root,
>   static int btrfs_delayed_inode_reserve_metadata(
>   					struct btrfs_trans_handle *trans,
>   					struct btrfs_root *root,
> -					struct btrfs_inode *inode,
>   					struct btrfs_delayed_node *node)
>   {
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
> @@ -647,7 +646,7 @@ static int btrfs_delayed_inode_reserve_metadata(
>   			node->bytes_reserved =3D num_bytes;
>   			trace_btrfs_space_reservation(fs_info,
>   						      "delayed_inode",
> -						      btrfs_ino(inode),
> +						      node->inode_id,
>   						      num_bytes, 1);
>   		} else {
>   			btrfs_qgroup_free_meta_prealloc(root, num_bytes);
> @@ -658,7 +657,7 @@ static int btrfs_delayed_inode_reserve_metadata(
>   	ret =3D btrfs_block_rsv_migrate(src_rsv, dst_rsv, num_bytes, true);
>   	if (!ret) {
>   		trace_btrfs_space_reservation(fs_info, "delayed_inode",
> -					      btrfs_ino(inode), num_bytes, 1);
> +					      node->inode_id, num_bytes, 1);
>   		node->bytes_reserved =3D num_bytes;
>   	}
>
> @@ -1833,8 +1832,7 @@ int btrfs_delayed_update_inode(struct btrfs_trans_=
handle *trans,
>   		goto release_node;
>   	}
>
> -	ret =3D btrfs_delayed_inode_reserve_metadata(trans, root, inode,
> -						   delayed_node);
> +	ret =3D btrfs_delayed_inode_reserve_metadata(trans, root, delayed_node=
);
>   	if (ret)
>   		goto release_node;
>
>
