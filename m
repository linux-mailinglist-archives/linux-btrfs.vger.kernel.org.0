Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0923E8A45
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 08:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhHKGkT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 02:40:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:42467 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234609AbhHKGkT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 02:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628663991;
        bh=gaU5i+t7N5T5+ZjwCc3jhv62kMIkZRj1D8JgX3miY+I=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=P9xgxIw4W6og36cYa3PpYfMuvKcjgDBzrLMh/1MwPvOWE5NVBBMAasAH6eRvJi+Zn
         taiVykqttKVnik5y2VVz+vYQhJOWimkrnUv407S7oYv+chS8zEttKHn8a8jO1sNmRE
         7I7tBRkfTkVp2f18/pV8IHBh203TRMEVni1sV5yQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mqb1W-1mrOEA2T1E-00mZ27; Wed, 11
 Aug 2021 08:39:51 +0200
Subject: Re: [PATCH] btrfs: zoned: fix ordered extent boundary calculation
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
References: <20210811063708.2520540-1-naohiro.aota@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <cb4636c9-5cee-7d53-7068-c6e29471c06a@gmx.com>
Date:   Wed, 11 Aug 2021 14:39:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811063708.2520540-1-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E5hybpT+s8AypFKbrv0zAwrw47lmiQFyAfrgA8x5gm2cetcPCR2
 rkAtSchPWm31Yx/8272CoBCLh1kusOpdgb6DkqgFRKqv1uXM+7tKtNRvhuvoAg07xhVb0mM
 5lPxF9a9Wa25tXjyjpxkHsCuknNO+qgHCCTTKUnoZCR9tTALbjIaKVsOtfVxBnCfch+/bfa
 /XYCCOBk/CQIJKdaTXL5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9HLYNyaCu/8=:mYryqT3A23nchFhPf9NhhW
 Tu5b7+ZbBWWg58MfYFZ9oyakuysTZdUM0svb9ueWyBG/3VzJVVjhlPchy2X577HtpIA/ivZTQ
 28ASYA0Lp8wwJhiMD11gmIppRxSgtSxFt5DT4SVpMopZHrICO1nWmdrURTk/m4trcrQFULPFt
 2QPVXSOU2pGG8ZFkLTMIBqawClrFIT+jhbShisiDLXeyC13etcZn1/7mglFUL46FT6ioX9eCQ
 2kuFUaqnxLZIGhmQN3zh8ogEr7p5P6W4tGqkiBz7vIX6QwGRa3eNv+IosCjerjbp4nai0aJe2
 iI3PkbzwBI8U/LLiEJIIpoxg2Ft2aV9ghXhLENoSjC9LUKSUpPg4hosD0GfkWxNfuFan4nqpY
 s4ia44ai2csek5GWHhKkUN8n9N0J6HXCe7KvsYYHa1eLOpxGfYo/8F3vWmg/jpoOiHEtGx9tG
 wY1v4na6eH+J5u0tHqtGYEb/dl+D/71HKy9uYIVPKxFhVJPbINw/IwqONO1+nSVjj0Rlbw3lJ
 1FNjTazuyB1mZ9Yas3k4lBZ2w8fyPotradrmRilWLuew/KklXY/taimrF7E8wgGKrS3iSJaK5
 MmR+RGOniCa6Ak6UWfqK2p/jCR8njYV+aR+rb6MT2vWarwlwhbWHydGpngOecWrREffbHv48U
 owVB2vpKlFLt6yy/Ysv4RjL7pzgimXl3SsSNxoKBf5AgBascPl7Lk5OxHpxjqcVgCJdBvYI4h
 8KMlkC9RAsH7hKh2IV8xpvbBbqyhHvSchO1SAHn6b9Ppv8pN0bsL1sSiNbgmpo89/cEPw0vqI
 UVWgUY/yzKh4y0ia1DqQtCpvGHFjlfLEtMrnYxCSh5FOeIJ/i8Fyy+W3qWfFR/E5JHJn5Bzbd
 SFhFL4Ic0C51ggfXvURSrXeRrCfRo8/dK+rTE8zOqCl7gaSex/sCOevGh3RclkcOOtkLJyiPc
 EqKd1Gk15BqCaoH9pVlIG7N7ljjtVYUSPd94eyMf7hRQkEGEE7dbhTbM2ueS7a0Lz7aLm1kOi
 OzjqZ+vdsDYnsAQdwg5pNuQmia3zSSAR1Ron+aPCQiOce/S0WXbhmRxgtrjBAMg/pMzlOireq
 6aNKnUw4OtGoKXqD6QSHfENCo/iNsT8Jh6e3lyF8s4SUuY6JgjcxT076w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/11 =E4=B8=8B=E5=8D=882:37, Naohiro Aota wrote:
> btrfs_lookup_ordered_extent() should be queried with the offset in a fil=
e
> instead of the logical address. Pass the file offset from
> submit_extent_page() to calc_bio_boundaries().
>
> Also, calc_bio_boundaries() relies on the bio's operation flag, so move =
the
> call site after setting it.
>
> Fixes: 390ed29b817e ("btrfs: refactor submit_extent_page() to make bio a=
nd its flag tracing easier")
> Cc: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent_io.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 7d4c03762374..c353bfd89dfc 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3241,7 +3241,7 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctr=
l *bio_ctrl,
>   }
>
>   static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
> -			       struct btrfs_inode *inode)
> +			       struct btrfs_inode *inode, u64 file_offset)
>   {
>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>   	struct btrfs_io_geometry geom;
> @@ -3283,7 +3283,7 @@ static int calc_bio_boundaries(struct btrfs_bio_ct=
rl *bio_ctrl,
>   	}
>
>   	/* Ordered extent not yet created, so we're good */
> -	ordered =3D btrfs_lookup_ordered_extent(inode, logical);
> +	ordered =3D btrfs_lookup_ordered_extent(inode, file_offset);
>   	if (!ordered) {
>   		bio_ctrl->len_to_oe_boundary =3D U32_MAX;
>   		return 0;
> @@ -3300,7 +3300,7 @@ static int alloc_new_bio(struct btrfs_inode *inode=
,
>   			 struct writeback_control *wbc,
>   			 unsigned int opf,
>   			 bio_end_io_t end_io_func,
> -			 u64 disk_bytenr, u32 offset,
> +			 u64 disk_bytenr, u32 offset, u64 file_offset,
>   			 unsigned long bio_flags)
>   {
>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> @@ -3317,13 +3317,13 @@ static int alloc_new_bio(struct btrfs_inode *ino=
de,
>   		bio =3D btrfs_bio_alloc(disk_bytenr + offset);
>   	bio_ctrl->bio =3D bio;
>   	bio_ctrl->bio_flags =3D bio_flags;
> -	ret =3D calc_bio_boundaries(bio_ctrl, inode);
> -	if (ret < 0)
> -		goto error;
>   	bio->bi_end_io =3D end_io_func;
>   	bio->bi_private =3D &inode->io_tree;
>   	bio->bi_write_hint =3D inode->vfs_inode.i_write_hint;
>   	bio->bi_opf =3D opf;
> +	ret =3D calc_bio_boundaries(bio_ctrl, inode, file_offset);
> +	if (ret < 0)
> +		goto error;
>   	if (wbc) {
>   		struct block_device *bdev;
>
> @@ -3398,6 +3398,7 @@ static int submit_extent_page(unsigned int opf,
>   		if (!bio_ctrl->bio) {
>   			ret =3D alloc_new_bio(inode, bio_ctrl, wbc, opf,
>   					    end_io_func, disk_bytenr, offset,
> +					    page_offset(page) + cur,
>   					    bio_flags);
>   			if (ret < 0)
>   				return ret;
>
