Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BFA4066A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 07:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhIJFPc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 01:15:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:40651 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhIJFPa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 01:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631250857;
        bh=wgU2Pazzfv4KNm2IG2VzNHkcdtN56QcnXWeqUrOE9Fg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=H8wl9R+8sMvTHXLxJVMmq7sIMBnd1yQBLy9ej3X4IlhKsnbictU2tNdAiLquK9wpk
         0nsgga97aoZ8rg4laP7HzQLuKOGNBSCsCQ1vdoUIC9eRDgKCwN28cuK4Qtvm7zIhxC
         GGi76ukZsvzkEnlqHug/SCV/y5SNIX+yCQeWAiwE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MO9z7-1mZm5p3Pw1-00OWPX; Fri, 10
 Sep 2021 07:14:17 +0200
Subject: Re: [PATCH v2] btrfs: Remove received information from snapshot on
 ro->rw switch
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>
References: <20210908135135.1474055-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <12145208-1d34-2d0f-9ddd-d664e6bf1d15@gmx.com>
Date:   Fri, 10 Sep 2021 13:14:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908135135.1474055-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/FZEiLSEMnqzpBwnSHWXUSNJ6Lj4b4HoHz3DhMHX4K/DDgv0PuA
 IPBVO1EAdnHG3a2hE0DcUKzC4apIhaZe9bgAAmrHGyWNy9KA+zwYAFVWToaXmUF9w0z4F9S
 WAKNtr9JhwdQreIjojBm0oId6wjEuqYl7v83vE/tbkiQarIKgI7ASkXdC0LabHGVoodiufd
 v2pbX8IGyItPWdZDU4Drg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aSFVbz8d64M=:X/8BPC0JBsQSrIb1kGObEf
 Hgt3ySiHTwkKa2FBCzRXfwIoEkXa04715uVzD9nTsKRjKzJQ2CtukVRGGy2tSLsIlE8yqzrKQ
 NCaH5O6q7TGT1d2DP2lvfkCEwQ96I3ly1Xd+ZZrvUJpsnawEBIi5j1UBWaewIjpeueps9+Oyg
 CEnzrx9xVk4Uhl8ltj+7Fg8874aHcdtmnezQsKw/x4Zjce2plBSbB4pjffO8ljOLhQCNISoTA
 lt6iVwUJgjnTvpjWAWa+2JPA4h+Sv/8q9qv34c2SohIo/kFr6aCC23hIeldcYt1oLv2M7Acae
 cp3qWjkftinpysFrVilm77qhd6/ULIXzbEV0P7azlYCQBV86Kt6q0Ou1G27lavQwPtiLOyS7k
 3eCWbVoDgIV3oV0bqICVL3vBm1fQ0y4WYwnXLa95A7+WIsJ9ljLe/jt2lgTWbi2rqKwOlXV+/
 knmjH0tfKBSyDYLqW1SMCi6IivZEmk0dVIoJp9pe1UmDnR3Cud0Kwh30e1C6+qnEwCYzVp4v+
 kijYLDJfVn+tA1a+43ohQRhwz+92ExlpAqvR5XPfYcBlTmmwwPxct0WeLGls9OoGsnIMVM7AS
 LlTdmw4ZCXSKMkjeKbkMOg1vA15Vyek47ufxk2g3jjl74xgjAt+bbnr8aNsOmvLsrd2H/SYSE
 cuG2hniqhQin8h79/N9tKwguJJCwR9xeE0HljGV2wFU0dJfcLMXds2RGpM1aHPm6i2wHQAb+O
 2pPMLNnGHkYOIWchCAhTlMq2YlyXIBxsjm/a5opfFjFqWod9mSuLlclBj7BzzH7PNSZEOU1rr
 OqNSjNYtAy6G7SGJ+GeLQcvp8ufGUY0l3c91j/tFDl/DMZwHYKkFvqMb58o7Rz0ZaMdi8ZAcM
 soShiOOtsNalwuI1gk1xt00KWZgrYqRsZ86BXVMQvyK+FRN7ykvIuqex0JgExhWEADmJqqRfz
 ZFP9u7kfr/knDgtPNBospsb/MjfGRi5JqQe4gh9af5Kx7wOL1JbZFjIiedKRHLx2KzOox1m0I
 J1YjPOrd/VCOeAUXrPtbWdnH9jOP4ZvsBhdBm6LU9LWo/DQXfPcPqnvqzkyyW+7yGVMSNbs7Q
 QKWG7E9A2My+vA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/8 =E4=B8=8B=E5=8D=889:51, Nikolay Borisov wrote:
> Currently when a read-only snapshot is received and subsequently its
> ro property is set to false i.e. switched to rw-mode the
> received_uuid/stime/rtime/stransid/rtransid of that subvol remains
> intact. However, once the received volume is switched to RW mode we
> cannot guaranteee that it contains the same data, so it makes sense
> to remove those fields which indicate this volume was ever
> send/received. Additionally, sending such volume can cause conflicts
> due to the presence of received_uuid.
>
> Preserving the received_uuid (and related fields) after transitioning th=
e
> snapshot from RO to RW and then changing the snapshot has a potential fo=
r
> causing send to fail in many unexpected ways if we later turn it back to
> RO and use it for an incremental send operation.
>
> A recent example, in the thread to which the Link tag below points to, w=
e
> had a user with a filesystem that had multiple snapshots with the same
> received_uuid but with different content due to a transition from RO to =
RW
> and then back to RO. When an incremental send was attempted using two of
> those snapshots, it resulted in send emitting a clone operation that was
> intended to clone from the parent root to the send root - however becaus=
e
> both roots had the same received_uuid, the receiver ended up picking the
> send root as the source root for the clone operation, which happened to
> result in the clone operation to fail with -EINVAL, due to the source an=
d
> destination offsets being the same (and on the same root and file). In t=
his
> particular case there was no harm, but we could end up in a case where t=
he
> clone operation succeeds but clones wrong data due to picking up an
> incorrect root - as in the case of multiple snapshots with the same
> received_uuid, it has no way to know which one is the correct one if the=
y
> have different content.
>
> Link: https://lore.kernel.org/linux-btrfs/CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMk=
EVXCdihawH1PgS6TiMchQ@mail.gmail.com/
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Suggested-by: David Sterba <dsterba@suse.cz>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Will add some warning for btrfs-progs to educate users.

Thanks,
Qu
> ---
>   fs/btrfs/ioctl.c | 41 +++++++++++++++++++++++++++++++++++------
>   1 file changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 9eb0c1eb568e..67709d274489 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1927,9 +1927,11 @@ static noinline int btrfs_ioctl_subvol_setflags(s=
truct file *file,
>   	struct inode *inode =3D file_inode(file);
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   	struct btrfs_root *root =3D BTRFS_I(inode)->root;
> +	struct btrfs_root_item *root_item =3D &root->root_item;
>   	struct btrfs_trans_handle *trans;
>   	u64 root_flags;
>   	u64 flags;
> +	bool clear_received_state =3D false;
>   	int ret =3D 0;
>
>   	if (!inode_owner_or_capable(file_mnt_user_ns(file), inode))
> @@ -1960,9 +1962,9 @@ static noinline int btrfs_ioctl_subvol_setflags(st=
ruct file *file,
>   	if (!!(flags & BTRFS_SUBVOL_RDONLY) =3D=3D btrfs_root_readonly(root))
>   		goto out_drop_sem;
>
> -	root_flags =3D btrfs_root_flags(&root->root_item);
> +	root_flags =3D btrfs_root_flags(root_item);
>   	if (flags & BTRFS_SUBVOL_RDONLY) {
> -		btrfs_set_root_flags(&root->root_item,
> +		btrfs_set_root_flags(root_item,
>   				     root_flags | BTRFS_ROOT_SUBVOL_RDONLY);
>   	} else {
>   		/*
> @@ -1971,9 +1973,10 @@ static noinline int btrfs_ioctl_subvol_setflags(s=
truct file *file,
>   		 */
>   		spin_lock(&root->root_item_lock);
>   		if (root->send_in_progress =3D=3D 0) {
> -			btrfs_set_root_flags(&root->root_item,
> +			btrfs_set_root_flags(root_item,
>   				     root_flags & ~BTRFS_ROOT_SUBVOL_RDONLY);
>   			spin_unlock(&root->root_item_lock);
> +			clear_received_state =3D true;
>   		} else {
>   			spin_unlock(&root->root_item_lock);
>   			btrfs_warn(fs_info,
> @@ -1984,14 +1987,40 @@ static noinline int btrfs_ioctl_subvol_setflags(=
struct file *file,
>   		}
>   	}
>
> -	trans =3D btrfs_start_transaction(root, 1);
> +	/*
> +	 * 1 item for updating the uuid root in the root tree
> +	 * 1 item for actually removing the uuid record in the uuid tree
> +	 */
> +	trans =3D btrfs_start_transaction(root, 2);
>   	if (IS_ERR(trans)) {
>   		ret =3D PTR_ERR(trans);
>   		goto out_reset;
>   	}
>
> -	ret =3D btrfs_update_root(trans, fs_info->tree_root,
> -				&root->root_key, &root->root_item);
> +	if (clear_received_state &&
> +	    !btrfs_is_empty_uuid(root_item->received_uuid)) {
> +
> +		ret =3D btrfs_uuid_tree_remove(trans, root_item->received_uuid,
> +					     BTRFS_UUID_KEY_RECEIVED_SUBVOL,
> +					     root->root_key.objectid);
> +
> +		if (ret && ret !=3D -ENOENT) {
> +			btrfs_abort_transaction(trans, ret);
> +			btrfs_end_transaction(trans);
> +			goto out_reset;
> +		}
> +
> +		memset(root_item->received_uuid, 0, BTRFS_UUID_SIZE);
> +		btrfs_set_root_stransid(root_item, 0);
> +		btrfs_set_root_rtransid(root_item, 0);
> +		btrfs_set_stack_timespec_sec(&root_item->stime, 0);
> +		btrfs_set_stack_timespec_nsec(&root_item->stime, 0);
> +		btrfs_set_stack_timespec_sec(&root_item->rtime, 0);
> +		btrfs_set_stack_timespec_nsec(&root_item->rtime, 0);
> +	}
> +
> +	ret =3D btrfs_update_root(trans, fs_info->tree_root, &root->root_key,
> +				root_item);
>   	if (ret < 0) {
>   		btrfs_end_transaction(trans);
>   		goto out_reset;
>
