Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1907ABBA0
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Sep 2023 00:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjIVWFC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 18:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjIVWFB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 18:05:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22466A7
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 15:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695420286; x=1696025086; i=quwenruo.btrfs@gmx.com;
 bh=L5adeccJViq/uZdMVO5RK7edyHgEJBZlFxh3Ou3V0QU=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=Y+6byMFlRTLlQC7JFAJjP6cNKjWD07d8GCDVfetNIS5OiY5OTcdunkYjzKqV9zeLz97bwct33Od
 ZLSQvecIoXacenNOdRIpDJIPsgR7pF8NfljzN/7LGtiTEV7clkwjUWCknKiA+0W9wEP2kZmeTxwJi
 o9lpKOMhxTjcnTHEq4z5HQEbBoHg3J3z5MaqRpUmaxI188ykTxBMMhDevVd+YpsVSk5miLbUJlNFe
 N8Qu+12Ut11mYD5+6w3bTyPxlfmyjdxX0CMcV98Rf/WX+ODFCD0K/f3JwbACipHgS/RS8Sa0NsWfY
 sh//n8X4flJCdoKyPgsxda5+hSkk/r548/hA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MG9gE-1qtkPJ2X7M-00GblY; Sat, 23
 Sep 2023 00:04:46 +0200
Message-ID: <ca188a2e-7932-4cda-be69-fe36be7e92dd@gmx.com>
Date:   Sat, 23 Sep 2023 07:34:42 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] btrfs: remove redundant root argument from
 btrfs_update_inode()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1695333082.git.fdmanana@suse.com>
 <cccbd191f2e3c18c826c06a24fb2758339fdf1ba.1695333082.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <cccbd191f2e3c18c826c06a24fb2758339fdf1ba.1695333082.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t7Uwq3h82RRj2KB01ACvNLoEZUdvqIE1HoUdDcee19uZNum2AZb
 T0ySGGWEt4xTezt+tJIZmTROxoMYXyiF4zxtQo2mnGDjwHEUZTnAK5mpSSehZvOyvxubsj3
 mPGJ3MXO+88JU3aZhck5sygFKcvMI6JqeZqhCzhd91D2mxJFJSspW3s21imd2NIaR/oxOqm
 XSlY3LSPxZJb/JElArrnw==
UI-OutboundReport: notjunk:1;M01:P0:0bx61nRIcco=;Ykgze+DvS/Ph/AID5eVU22y80xy
 fYqrZxXOfZ5rVGRrBTvtdf9n3LBXK+K/yNkDTKz8qDh8oelcRarx79S+Ym1CtdTM/Gr7LDsD4
 LMLjwMlVSzhM7oKAlYM9slKtV3Pw8/ilB74YA+/0Q6ObZRAMPiOcjVGNXHh4XCRRhl+HQ4hR+
 LGOxCMUMkmAF657IPeKDnj77CPv8SqgFh1hFhMioW+XhVh5D43RyDGnl85Hk8NLtzPcVFz6sp
 QrmBmbX3UWgvJZJR+da649Um/Q8Xa9X5rIr/cVVXTfex4pvm8UWQbAOp9ZwNSDv3w+j0FX+gf
 3K9oXsLmxY6pTCjC2YBBSXqpjPMshrjYo70Ezz6usaGGEwFY9CIJPTFl9U02r8aYkI7GncvmR
 gL80ESAFNsF3kvajs4CUTNTH/+tx5skYy6MFMGVnKGbyXG4M/6457rM8sTApsh6nK41OhojJ/
 PxyhJUkJnGDsFQKWddZtg4oBi+8giKKi3D9i4Vh7Phii/XebyXSPYx1W7ga0CLHMSyEolOGIi
 O+WtCcNglLRFvIjlmpszVkbMqL7jAWSTsgGZ6qz9P1n+50OreOKiFn+cqqtrIm9lLuQMu5H/H
 oPy3qp8T3ysdWay4bBQ1A9Kc+RGbY+jqoDfU+iDi/WyYRfnvu0cL3RrmxS6CKc1d86C6Ut8b1
 w0Gf2lF0MNxhTD3HxlYsxrQiT8W+rS9tz3/++rnb7WxysxE/uUSY8XFmv0//y6oVaQ/5q5fT/
 RiqHO74m/9/bO9E3t8hPlsFESnNYJQHNg9QyfzVn430KuBohKPT6i93b1PVVzniGfOsZQ0D87
 k0fVgeeniXWKTbiTP5sTlUfDBxdV8K8J+H2o6ugUQ5QORRbdvUI68UxPbZnmqpOv5luJ8BT5p
 J3d/DUHoE5g/dU/W59av1pXO0q1Y9KF3wL2VOkekARCS35lQokT4cPBagAUoyGu0tClSx+TG5
 Av7dSlBy9pW7dccAEflWwA0HHN4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/22 20:07, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> The root argument for btrfs_update_inode() always matches the root of th=
e
> given inode, so remove the root argument and get it from the inode
> argument.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/block-group.c      |  3 +--
>   fs/btrfs/btrfs_inode.h      |  2 +-
>   fs/btrfs/file.c             |  8 ++++----
>   fs/btrfs/free-space-cache.c | 13 ++++++-------
>   fs/btrfs/inode.c            | 34 +++++++++++++++++-----------------
>   fs/btrfs/ioctl.c            |  2 +-
>   fs/btrfs/reflink.c          |  3 +--
>   fs/btrfs/tree-log.c         | 12 ++++++------
>   fs/btrfs/verity.c           |  4 ++--
>   fs/btrfs/xattr.c            |  4 ++--
>   10 files changed, 41 insertions(+), 44 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 2b9aaeefaf76..6e2a4000bfe0 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3051,7 +3051,6 @@ static int cache_save_setup(struct btrfs_block_gro=
up *block_group,
>   			    struct btrfs_path *path)
>   {
>   	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
> -	struct btrfs_root *root =3D fs_info->tree_root;
>   	struct inode *inode =3D NULL;
>   	struct extent_changeset *data_reserved =3D NULL;
>   	u64 alloc_hint =3D 0;
> @@ -3103,7 +3102,7 @@ static int cache_save_setup(struct btrfs_block_gro=
up *block_group,
>   	 * time.
>   	 */
>   	BTRFS_I(inode)->generation =3D 0;
> -	ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> +	ret =3D btrfs_update_inode(trans, BTRFS_I(inode));
>   	if (ret) {
>   		/*
>   		 * So theoretically we could recover from this, simply set the
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index d12556627cce..f2c928345d53 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -482,7 +482,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_ino=
de *inode,
>   				    struct page *page, size_t pg_offset,
>   				    u64 start, u64 end);
>   int btrfs_update_inode(struct btrfs_trans_handle *trans,
> -		       struct btrfs_root *root, struct btrfs_inode *inode);
> +		       struct btrfs_inode *inode);
>   int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
>   				struct btrfs_inode *inode);
>   int btrfs_orphan_add(struct btrfs_trans_handle *trans, struct btrfs_in=
ode *inode);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 7d6652941210..e847043defce 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2460,7 +2460,7 @@ int btrfs_replace_file_extents(struct btrfs_inode =
*inode,
>   		if (!extent_info || extent_info->update_times)
>   			inode->vfs_inode.i_mtime =3D inode_set_ctime_current(&inode->vfs_in=
ode);
>
> -		ret =3D btrfs_update_inode(trans, root, inode);
> +		ret =3D btrfs_update_inode(trans, inode);
>   		if (ret)
>   			break;
>
> @@ -2700,7 +2700,7 @@ static int btrfs_punch_hole(struct file *file, lof=
f_t offset, loff_t len)
>   	ASSERT(trans !=3D NULL);
>   	inode_inc_iversion(inode);
>   	inode->i_mtime =3D inode_set_ctime_current(inode);
> -	ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> +	ret =3D btrfs_update_inode(trans, BTRFS_I(inode));
>   	updated_inode =3D true;
>   	btrfs_end_transaction(trans);
>   	btrfs_btree_balance_dirty(fs_info);
> @@ -2726,7 +2726,7 @@ static int btrfs_punch_hole(struct file *file, lof=
f_t offset, loff_t len)
>   		} else {
>   			int ret2;
>
> -			ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> +			ret =3D btrfs_update_inode(trans, BTRFS_I(inode));
>   			ret2 =3D btrfs_end_transaction(trans);
>   			if (!ret)
>   				ret =3D ret2;
> @@ -2793,7 +2793,7 @@ static int btrfs_fallocate_update_isize(struct ino=
de *inode,
>   	inode_set_ctime_current(inode);
>   	i_size_write(inode, end);
>   	btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
> -	ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> +	ret =3D btrfs_update_inode(trans, BTRFS_I(inode));
>   	ret2 =3D btrfs_end_transaction(trans);
>
>   	return ret ? ret : ret2;
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index acb8ef3dd6b0..6f93c9a2c3e3 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -359,7 +359,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_tra=
ns_handle *trans,
>   	if (ret)
>   		goto fail;
>
> -	ret =3D btrfs_update_inode(trans, root, inode);
> +	ret =3D btrfs_update_inode(trans, inode);
>
>   fail:
>   	if (locked)
> @@ -1326,7 +1326,7 @@ static int __btrfs_wait_cache_io(struct btrfs_root=
 *root,
>   	  "failed to write free space cache for block group %llu error %d",
>   				  block_group->start, ret);
>   	}
> -	btrfs_update_inode(trans, root, BTRFS_I(inode));
> +	btrfs_update_inode(trans, BTRFS_I(inode));
>
>   	if (block_group) {
>   		/* the dirty list is protected by the dirty_bgs_lock */
> @@ -1367,7 +1367,6 @@ int btrfs_wait_cache_io(struct btrfs_trans_handle =
*trans,
>   /*
>    * Write out cached info to an inode.
>    *
> - * @root:        root the inode belongs to
>    * @inode:       freespace inode we are writing out
>    * @ctl:         free space cache we are going to write out
>    * @block_group: block_group for this cache if it belongs to a block_g=
roup
> @@ -1378,7 +1377,7 @@ int btrfs_wait_cache_io(struct btrfs_trans_handle =
*trans,
>    * on mount.  This will return 0 if it was successful in writing the c=
ache out,
>    * or an errno if it was not.
>    */
> -static int __btrfs_write_out_cache(struct btrfs_root *root, struct inod=
e *inode,
> +static int __btrfs_write_out_cache(struct inode *inode,
>   				   struct btrfs_free_space_ctl *ctl,
>   				   struct btrfs_block_group *block_group,
>   				   struct btrfs_io_ctl *io_ctl,
> @@ -1511,7 +1510,7 @@ static int __btrfs_write_out_cache(struct btrfs_ro=
ot *root, struct inode *inode,
>   		invalidate_inode_pages2(inode->i_mapping);
>   		BTRFS_I(inode)->generation =3D 0;
>   	}
> -	btrfs_update_inode(trans, root, BTRFS_I(inode));
> +	btrfs_update_inode(trans, BTRFS_I(inode));
>   	if (must_iput)
>   		iput(inode);
>   	return ret;
> @@ -1537,8 +1536,8 @@ int btrfs_write_out_cache(struct btrfs_trans_handl=
e *trans,
>   	if (IS_ERR(inode))
>   		return 0;
>
> -	ret =3D __btrfs_write_out_cache(fs_info->tree_root, inode, ctl,
> -				block_group, &block_group->io_ctl, trans);
> +	ret =3D __btrfs_write_out_cache(inode, ctl, block_group,
> +				      &block_group->io_ctl, trans);
>   	if (ret) {
>   		btrfs_debug(fs_info,
>   	  "failed to write free space cache for block group %llu error %d",
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 44836d1f99a9..13a97d3ce34a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -671,7 +671,7 @@ static noinline int cow_file_range_inline(struct btr=
fs_inode *inode, u64 size,
>   	}
>
>   	btrfs_update_inode_bytes(inode, size, drop_args.bytes_found);
> -	ret =3D btrfs_update_inode(trans, root, inode);
> +	ret =3D btrfs_update_inode(trans, inode);
>   	if (ret && ret !=3D -ENOSPC) {
>   		btrfs_abort_transaction(trans, ret);
>   		goto out;
> @@ -4002,9 +4002,9 @@ static noinline int btrfs_update_inode_item(struct=
 btrfs_trans_handle *trans,
>    * copy everything in the in-memory inode into the btree.
>    */
>   int btrfs_update_inode(struct btrfs_trans_handle *trans,
> -		       struct btrfs_root *root,
>   		       struct btrfs_inode *inode)
>   {
> +	struct btrfs_root *root =3D inode->root;
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>   	int ret;
>
> @@ -4034,7 +4034,7 @@ int btrfs_update_inode_fallback(struct btrfs_trans=
_handle *trans,
>   {
>   	int ret;
>
> -	ret =3D btrfs_update_inode(trans, inode->root, inode);
> +	ret =3D btrfs_update_inode(trans, inode);
>   	if (ret =3D=3D -ENOSPC)
>   		return btrfs_update_inode_item(trans, inode->root, inode);
>   	return ret;
> @@ -4143,7 +4143,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans=
_handle *trans,
>   	inode_inc_iversion(&dir->vfs_inode);
>   	inode_set_ctime_current(&inode->vfs_inode);
>   	dir->vfs_inode.i_mtime =3D inode_set_ctime_current(&dir->vfs_inode);
> -	ret =3D btrfs_update_inode(trans, root, dir);
> +	ret =3D btrfs_update_inode(trans, dir);
>   out:
>   	return ret;
>   }
> @@ -4157,7 +4157,7 @@ int btrfs_unlink_inode(struct btrfs_trans_handle *=
trans,
>   	ret =3D __btrfs_unlink_inode(trans, dir, inode, name, NULL);
>   	if (!ret) {
>   		drop_nlink(&inode->vfs_inode);
> -		ret =3D btrfs_update_inode(trans, inode->root, inode);
> +		ret =3D btrfs_update_inode(trans, inode);
>   	}
>   	return ret;
>   }
> @@ -4843,7 +4843,7 @@ static int maybe_insert_hole(struct btrfs_root *ro=
ot, struct btrfs_inode *inode,
>   		btrfs_abort_transaction(trans, ret);
>   	} else {
>   		btrfs_update_inode_bytes(inode, 0, drop_args.bytes_found);
> -		btrfs_update_inode(trans, root, inode);
> +		btrfs_update_inode(trans, inode);
>   	}
>   	btrfs_end_transaction(trans);
>   	return ret;
> @@ -4994,7 +4994,7 @@ static int btrfs_setsize(struct inode *inode, stru=
ct iattr *attr)
>   		i_size_write(inode, newsize);
>   		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
>   		pagecache_isize_extended(inode, oldsize, newsize);
> -		ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> +		ret =3D btrfs_update_inode(trans, BTRFS_I(inode));
>   		btrfs_drew_write_unlock(&root->snapshot_lock);
>   		btrfs_end_transaction(trans);
>   	} else {
> @@ -6010,7 +6010,7 @@ static int btrfs_dirty_inode(struct btrfs_inode *i=
node)
>   	if (IS_ERR(trans))
>   		return PTR_ERR(trans);
>
> -	ret =3D btrfs_update_inode(trans, root, inode);
> +	ret =3D btrfs_update_inode(trans, inode);
>   	if (ret =3D=3D -ENOSPC || ret =3D=3D -EDQUOT) {
>   		/* whoops, lets try again with the full transaction */
>   		btrfs_end_transaction(trans);
> @@ -6018,7 +6018,7 @@ static int btrfs_dirty_inode(struct btrfs_inode *i=
node)
>   		if (IS_ERR(trans))
>   			return PTR_ERR(trans);
>
> -		ret =3D btrfs_update_inode(trans, root, inode);
> +		ret =3D btrfs_update_inode(trans, inode);
>   	}
>   	btrfs_end_transaction(trans);
>   	if (inode->delayed_node)
> @@ -6457,7 +6457,7 @@ int btrfs_add_link(struct btrfs_trans_handle *tran=
s,
>   		parent_inode->vfs_inode.i_mtime =3D
>   			inode_set_ctime_current(&parent_inode->vfs_inode);
>
> -	ret =3D btrfs_update_inode(trans, root, parent_inode);
> +	ret =3D btrfs_update_inode(trans, parent_inode);
>   	if (ret)
>   		btrfs_abort_transaction(trans, ret);
>   	return ret;
> @@ -6608,7 +6608,7 @@ static int btrfs_link(struct dentry *old_dentry, s=
truct inode *dir,
>   	} else {
>   		struct dentry *parent =3D dentry->d_parent;
>
> -		err =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> +		err =3D btrfs_update_inode(trans, BTRFS_I(inode));
>   		if (err)
>   			goto fail;
>   		if (inode->i_nlink =3D=3D 1) {
> @@ -8349,7 +8349,7 @@ static int btrfs_truncate(struct btrfs_inode *inod=
e, bool skip_writeback)
>   		if (ret !=3D -ENOSPC && ret !=3D -EAGAIN)
>   			break;
>
> -		ret =3D btrfs_update_inode(trans, root, inode);
> +		ret =3D btrfs_update_inode(trans, inode);
>   		if (ret)
>   			break;
>
> @@ -8402,7 +8402,7 @@ static int btrfs_truncate(struct btrfs_inode *inod=
e, bool skip_writeback)
>   		int ret2;
>
>   		trans->block_rsv =3D &fs_info->trans_block_rsv;
> -		ret2 =3D btrfs_update_inode(trans, root, inode);
> +		ret2 =3D btrfs_update_inode(trans, inode);
>   		if (ret2 && !ret)
>   			ret =3D ret2;
>
> @@ -8833,7 +8833,7 @@ static int btrfs_rename_exchange(struct inode *old=
_dir,
>   					   BTRFS_I(old_dentry->d_inode),
>   					   old_name, &old_rename_ctx);
>   		if (!ret)
> -			ret =3D btrfs_update_inode(trans, root, BTRFS_I(old_inode));
> +			ret =3D btrfs_update_inode(trans, BTRFS_I(old_inode));
>   	}
>   	if (ret) {
>   		btrfs_abort_transaction(trans, ret);
> @@ -8848,7 +8848,7 @@ static int btrfs_rename_exchange(struct inode *old=
_dir,
>   					   BTRFS_I(new_dentry->d_inode),
>   					   new_name, &new_rename_ctx);
>   		if (!ret)
> -			ret =3D btrfs_update_inode(trans, dest, BTRFS_I(new_inode));
> +			ret =3D btrfs_update_inode(trans, BTRFS_I(new_inode));
>   	}
>   	if (ret) {
>   		btrfs_abort_transaction(trans, ret);
> @@ -9093,7 +9093,7 @@ static int btrfs_rename(struct mnt_idmap *idmap,
>   					   BTRFS_I(d_inode(old_dentry)),
>   					   &old_fname.disk_name, &rename_ctx);
>   		if (!ret)
> -			ret =3D btrfs_update_inode(trans, root, BTRFS_I(old_inode));
> +			ret =3D btrfs_update_inode(trans, BTRFS_I(old_inode));
>   	}
>   	if (ret) {
>   		btrfs_abort_transaction(trans, ret);
> @@ -9649,7 +9649,7 @@ static int __btrfs_prealloc_file_range(struct inod=
e *inode, int mode,
>   			btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
>   		}
>
> -		ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> +		ret =3D btrfs_update_inode(trans, BTRFS_I(inode));
>
>   		if (ret) {
>   			btrfs_abort_transaction(trans, ret);
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 018ea98b239a..24eae7c2b3ae 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -385,7 +385,7 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
>   	btrfs_sync_inode_flags_to_i_flags(inode);
>   	inode_inc_iversion(inode);
>   	inode_set_ctime_current(inode);
> -	ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> +	ret =3D btrfs_update_inode(trans, BTRFS_I(inode));
>
>    out_end_trans:
>   	btrfs_end_transaction(trans);
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index 65d2bd6910f2..fabd856e5079 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -25,7 +25,6 @@ static int clone_finish_inode_update(struct btrfs_tran=
s_handle *trans,
>   				     const u64 olen,
>   				     int no_time_update)
>   {
> -	struct btrfs_root *root =3D BTRFS_I(inode)->root;
>   	int ret;
>
>   	inode_inc_iversion(inode);
> @@ -43,7 +42,7 @@ static int clone_finish_inode_update(struct btrfs_tran=
s_handle *trans,
>   		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
>   	}
>
> -	ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> +	ret =3D btrfs_update_inode(trans, BTRFS_I(inode));
>   	if (ret) {
>   		btrfs_abort_transaction(trans, ret);
>   		btrfs_end_transaction(trans);
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 595982434216..a7bba3d61e55 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -889,7 +889,7 @@ static noinline int replay_one_extent(struct btrfs_t=
rans_handle *trans,
>
>   update_inode:
>   	btrfs_update_inode_bytes(BTRFS_I(inode), nbytes, drop_args.bytes_foun=
d);
> -	ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> +	ret =3D btrfs_update_inode(trans, BTRFS_I(inode));
>   out:
>   	iput(inode);
>   	return ret;
> @@ -1444,7 +1444,7 @@ static noinline int add_inode_ref(struct btrfs_tra=
ns_handle *trans,
>   			if (ret)
>   				goto out;
>
> -			ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> +			ret =3D btrfs_update_inode(trans, BTRFS_I(inode));
>   			if (ret)
>   				goto out;
>   		}
> @@ -1622,7 +1622,7 @@ static noinline int fixup_inode_link_count(struct =
btrfs_trans_handle *trans,
>
>   	if (nlink !=3D inode->i_nlink) {
>   		set_nlink(inode, nlink);
> -		ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> +		ret =3D btrfs_update_inode(trans, BTRFS_I(inode));
>   		if (ret)
>   			goto out;
>   	}
> @@ -1731,7 +1731,7 @@ static noinline int link_to_fixup_dir(struct btrfs=
_trans_handle *trans,
>   			set_nlink(inode, 1);
>   		else
>   			inc_nlink(inode);
> -		ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> +		ret =3D btrfs_update_inode(trans, BTRFS_I(inode));
>   	} else if (ret =3D=3D -EEXIST) {
>   		ret =3D 0;
>   	}
> @@ -1938,7 +1938,7 @@ static noinline int replay_one_name(struct btrfs_t=
rans_handle *trans,
>   out:
>   	if (!ret && update_size) {
>   		btrfs_i_size_write(BTRFS_I(dir), dir->i_size + name.len * 2);
> -		ret =3D btrfs_update_inode(trans, root, BTRFS_I(dir));
> +		ret =3D btrfs_update_inode(trans, BTRFS_I(dir));
>   	}
>   	kfree(name.name);
>   	iput(dir);
> @@ -2482,7 +2482,7 @@ static int replay_one_buffer(struct btrfs_root *lo=
g, struct extent_buffer *eb,
>   							drop_args.bytes_found);
>   					/* Update the inode's nbytes. */
>   					ret =3D btrfs_update_inode(wc->trans,
> -							root, BTRFS_I(inode));
> +								 BTRFS_I(inode));
>   				}
>   				iput(inode);
>   				if (ret)
> diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> index 744f4f4d4c68..66e2270b0dae 100644
> --- a/fs/btrfs/verity.c
> +++ b/fs/btrfs/verity.c
> @@ -487,7 +487,7 @@ static int rollback_verity(struct btrfs_inode *inode=
)
>   	}
>   	inode->ro_flags &=3D ~BTRFS_INODE_RO_VERITY;
>   	btrfs_sync_inode_flags_to_i_flags(&inode->vfs_inode);
> -	ret =3D btrfs_update_inode(trans, root, inode);
> +	ret =3D btrfs_update_inode(trans, inode);
>   	if (ret) {
>   		btrfs_abort_transaction(trans, ret);
>   		goto out;
> @@ -554,7 +554,7 @@ static int finish_verity(struct btrfs_inode *inode, =
const void *desc,
>   	}
>   	inode->ro_flags |=3D BTRFS_INODE_RO_VERITY;
>   	btrfs_sync_inode_flags_to_i_flags(&inode->vfs_inode);
> -	ret =3D btrfs_update_inode(trans, root, inode);
> +	ret =3D btrfs_update_inode(trans, inode);
>   	if (ret)
>   		goto end_trans;
>   	ret =3D del_orphan(trans, inode);
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index b906f809650e..76ff93b3eb27 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -265,7 +265,7 @@ int btrfs_setxattr_trans(struct inode *inode, const =
char *name,
>
>   	inode_inc_iversion(inode);
>   	inode_set_ctime_current(inode);
> -	ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> +	ret =3D btrfs_update_inode(trans, BTRFS_I(inode));
>   	if (ret)
>   		btrfs_abort_transaction(trans, ret);
>   out:
> @@ -408,7 +408,7 @@ static int btrfs_xattr_handler_set_prop(const struct=
 xattr_handler *handler,
>   	if (!ret) {
>   		inode_inc_iversion(inode);
>   		inode_set_ctime_current(inode);
> -		ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> +		ret =3D btrfs_update_inode(trans, BTRFS_I(inode));
>   		if (ret)
>   			btrfs_abort_transaction(trans, ret);
>   	}
