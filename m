Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3C55AA346
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 00:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiIAWpe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 18:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbiIAWpZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 18:45:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BE7419BF
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 15:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662072318;
        bh=6YGaBy8uN1LrUCrzswR0kOqi1lhG/6TnTE5lLiqu+Kg=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=GQaj7eNlGq+K38PpidcykwXr4GRgA0fzsSTr1xeZtdvCkQldV1Bc/fbCM6cn59I91
         3Q+7f3pJzQphDQQEU90awL6m5SOpH/rLCtowCmeXXmyWpnr7ITNBxkiZiap20fPO8B
         WdxoPP4zQmO0t5awsmIaDQNJoZEvVvJccsbZR4Cw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mt757-1pMors3DB3-00tWOg; Fri, 02
 Sep 2022 00:45:18 +0200
Message-ID: <dff8a919-c43c-e102-4b18-4dbcc1fae4bc@gmx.com>
Date:   Fri, 2 Sep 2022 06:45:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 07/10] btrfs: rename btrfs_check_shared() to a more
 descriptive name
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1662022922.git.fdmanana@suse.com>
 <c9954cf24dce0f62ad89dd5839c36e3ba9b14b8d.1662022922.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <c9954cf24dce0f62ad89dd5839c36e3ba9b14b8d.1662022922.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8hezkUf+Xy+hKkjinS5+G47Pz/vIV8bmKIzzPXVHMDUvJrV1Wh2
 x9xyyD4JBSoHZzea6o+BybZu1843dXD6gBgwcwr+XsTRwHGv2z0uRGqaN6UItrfHKGzgT+s
 32m1fOflArYz5GzOlHBHTwNoQz2bAEZhU8jvBfVdF3D+MKyhOWRxUIO4CsNrOqemNj7u8bv
 4viIvOaO4tlRa6xsjYyxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/rhiT7djfmc=:lAn/u3S/+8wnl1LovUl4/f
 rcjbh+o26VflI1YWuzzJMklkG31HX9VBhysnRYHnxlGBRzlRj0qIWBPF2+dHTngejLu5y7CXo
 YXb3axCayWVwIoysOfEyQ0hJaVy4tk03IXCX2stm02HEInRtzkTa0o3P2ZuhpBC29IKI5A0hp
 JNWFCo0hiISDGIKcxY1VttgQ0MIUKeIUfJYCakpkMcd6mSrWwQiUprKz160fhFn5J/I6T7+Ca
 snWYjtqDGzcl0R/O8aa3aWpax2ei3GZ43i77NcdJSunLeszvOOhKAsUja3cP5tugawDlAKX6/
 JbEcN2q7h3yYxGW7fOxcGYATH4mSxXtWE70EbscmdhwJDOKWnaKTlMhH9gNPgVTm8N+vklklq
 t548PLJtHK/e1TEkTZmVBr2yHQOj4qLE6j7cQ2UsprtLod/NkEH0QVF+Gh8697kRJkAZx93K6
 0iHawqTVFLItYhclNYo/UWIph2vy9/iN4GTadrt9hiHoGu7zy0GY3rbXXGC1HuCufq/31m4ew
 zR8/9SBGFzxBT4dg2gr4Q74+KYTIl5z94hUuA2jM5SGTIWBbgHg8HaECoYewsYSA3suchXKL0
 bCrAGxXzSohfFv+NsRZ6wLg8v0lpUvZnC6dTp5PAzUw5g7ADeFYEKZY29ZaeE+A+r7V4o803n
 +HTtIHn/ULKswgm06n4damuzi+pa8O/reh3xVCh6wS4Gp2Aa5Rzdb/o+x5wtdQmgTfHpsDTsI
 TinMWtdRGeo+PM2+JZB9JS9IKEGuuSH/ErGUIWNS+bBr/ak6JnwdAySXiA5jGlksf8XkXeQro
 2b3NkVWtHsczayAocli+vp/3MBcnRN1FvdQiZWi7QaT/78GT7z7QHM1kLAlTVrfrT54FS1+Ex
 gCqjD3M0nxtirypEABmofMurTq4tXAU+uwo/svc7GQNtLutKPvwSDb1ZCg5cbEBkOAhQwmeGw
 t4L9tck3ngkEL439GWNPD/6Mc6XT18V25pvxNct7jG/RxgqIuBG35zwsuo+iSAC8Ky2Vn676k
 8QqH1DKLSx6L2mok6ob9YVU2D6J8fxjxnHDU0aZKpD8yWxLS1NNKBlO/XxvwAhqto+yKuQ2Te
 rCre3k7t+UEKSIv2Zn6OyvLVlQKhulAESW1c6wp2wECOx+H5pnrd2mVjYqUntBF6CYQfqMqTL
 rJTsXuAZJqZpHxwGYOazgUSpcQ
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/1 21:18, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> The function btrfs_check_shared() is supposed to be used to check if a
> data extent is shared, but its name is too generic, may easily cause
> confusion in the sense that it may be used for metadata extents.
>
> So rename it to btrfs_is_data_extent_shared(), which will also make it
> less confusing after the next change that adds a backref lookup cache fo=
r
> the b+tree nodes that lead to the leaf that contains the file extent ite=
m
> that points to the target data extent.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/backref.c   | 8 ++++----
>   fs/btrfs/backref.h   | 4 ++--
>   fs/btrfs/extent_io.c | 5 +++--
>   3 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index d385357e19b6..e2ac10a695b6 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -1512,7 +1512,7 @@ int btrfs_find_all_roots(struct btrfs_trans_handle=
 *trans,
>   }
>
>   /**
> - * Check if an extent is shared or not
> + * Check if a data extent is shared or not.
>    *
>    * @root:   root inode belongs to
>    * @inum:   inode number of the inode whose extent we are checking
> @@ -1520,7 +1520,7 @@ int btrfs_find_all_roots(struct btrfs_trans_handle=
 *trans,
>    * @roots:  list of roots this extent is shared among
>    * @tmp:    temporary list used for iteration
>    *
> - * btrfs_check_shared uses the backref walking code but will short
> + * btrfs_is_data_extent_shared uses the backref walking code but will s=
hort
>    * circuit as soon as it finds a root or inode that doesn't match the
>    * one passed in. This provides a significant performance benefit for
>    * callers (such as fiemap) which want to know whether the extent is
> @@ -1531,8 +1531,8 @@ int btrfs_find_all_roots(struct btrfs_trans_handle=
 *trans,
>    *
>    * Return: 0 if extent is not shared, 1 if it is shared, < 0 on error.
>    */
> -int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
> -		struct ulist *roots, struct ulist *tmp)
> +int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64 =
bytenr,
> +				struct ulist *roots, struct ulist *tmp)
>   {
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>   	struct btrfs_trans_handle *trans;
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index 2759de7d324c..08354394b1bb 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -62,8 +62,8 @@ int btrfs_find_one_extref(struct btrfs_root *root, u64=
 inode_objectid,
>   			  u64 start_off, struct btrfs_path *path,
>   			  struct btrfs_inode_extref **ret_extref,
>   			  u64 *found_off);
> -int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
> -		struct ulist *roots, struct ulist *tmp_ulist);
> +int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64 =
bytenr,
> +				struct ulist *roots, struct ulist *tmp);
>
>   int __init btrfs_prelim_ref_init(void);
>   void __cold btrfs_prelim_ref_exit(void);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1260038eb47d..a47710516ecf 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5656,8 +5656,9 @@ int extent_fiemap(struct btrfs_inode *inode, struc=
t fiemap_extent_info *fieinfo,
>   			 * then we're just getting a count and we can skip the
>   			 * lookup stuff.
>   			 */
> -			ret =3D btrfs_check_shared(root, btrfs_ino(inode),
> -						 bytenr, roots, tmp_ulist);
> +			ret =3D btrfs_is_data_extent_shared(root, btrfs_ino(inode),
> +							  bytenr, roots,
> +							  tmp_ulist);
>   			if (ret < 0)
>   				goto out_free;
>   			if (ret)
