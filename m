Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1117741EE48
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Oct 2021 15:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhJANQK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Oct 2021 09:16:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:47465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231411AbhJANQJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Oct 2021 09:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633094061;
        bh=Zv9FgBV1N/7SZuZAPxt9Fb3H9JdIlDW41on7IC23Ryo=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=lwFyDwNq0lHft4d3v2UBMTZ6W2WYMxWbSM/EL9TmJNvPwq9lNF4YukHmADT50Jq2X
         yOEr2rUqMrawpo3q6Ozw4Eb+iG6jo2ftykN+tDR39kOD68k2kjN6Rjy7QaY9Q4NpLD
         sfvE1ZfgNPTOTmJEH0jZOXXKVXTNIlCymMZqxtZo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5fIW-1mTYXu1uws-0079j9; Fri, 01
 Oct 2021 15:14:21 +0200
Message-ID: <f3d480f1-36ef-229e-d3f2-469305250144@gmx.com>
Date:   Fri, 1 Oct 2021 21:14:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 1/4] btrfs: deal with errors when checking if a dir entry
 exists during log replay
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1633082623.git.fdmanana@suse.com>
 <2c11d304684692a7f41d34c149099580f1bce9e8.1633082623.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <2c11d304684692a7f41d34c149099580f1bce9e8.1633082623.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XlBRmbSsGcKJYARGf4sjZCp3o290yLWi3AGwQhwoyNQ8FgTyROo
 XMSX7c4c5UWk1OedOiThDqNrFnWDbCHDsG4QCbI0Qi+BGhAQ9vd+zNkmiK/tJG7uQxxufCP
 jzN0UnXrv+8BO7Mhl5GV47uQ13pxbi0noMqDDh/lgFX31gqrRpV2AKl7E3v4/LrYou0JN60
 wYkL/P9H/ppTDwXk1W54Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7LT86bjI4mQ=:ZAbLByaAuP/Svh5cAkmPXT
 cCh5grst6rkBlGo6us+l0MGMmQi0Xe0/619jKHRE/1Cn+lshvtykPuS5lRvo3GBQrawJps/Ca
 n9XUDraBlhs2Ik2V9BYJLDIt7I1+UgZtaqT8e4bT3MpJ0Q0cXipByVRi2EpTDq75a8BM+XXlj
 vF4OfQVZKbkU/fZnsYqnKrt15x+1h/D2d87uHx6oCQynfE5AKsI5ssWd4sOHXUcPJZ274BQs8
 AfgOW1Ug+/KTHwBuADfW/e2H/kOY3uLXxWVAUltnfOlGuOg5PIwSgCXJK6LXMifZSL8iyXAal
 NwkDybKw2Skdgb1c7+hy0THhEwG084A1AVjP4rSS0ydkaAl/U7F3YkIa1gMVP6dvx6O97Soux
 2f4kq+BvW96B1IESCbDirshb0MW7eShL3E7YDyDtToD9Sa4jHx+GRY4CchgRjGEniJAO0ddtL
 5sECjL0tU0QhuiUB6UgF/Ghc7O4YP7c+qXMfHlkN90qJ0S7WVMvr+AjdkfZaMtcy08/vK1IJ2
 ib2R4UNvPufpHyr/dunASDFjxfvbxmwRqm9WaijbvNCzu4tViGQzRICIA95ygP6LwTjW5P25K
 HiUIOcoJc3AMBNuccOYwB+rfVaADzQDLPwHoH7qfNgr1vBnSbsRTsFXx2EVYXYGAN19hdXjrq
 ynkuyUPemPhfAWkLy+TdL/FMvrOaKFs/HYk46bQowpSh7Rl+abCaFF7G6UWJCON+RkcWCAZEN
 Og27iWJh6fdvSBKCWKoqcmwV2OFfguY8zeni3+Pcp8q/M5KAIcHCubeU4TSsTCkWzkjAf//5B
 mvoESqljGG/qbkfqkiZzRo12hTTwBLLlZ4ZA+SNQoLMuL/U0xWfhvNDbGIlPnp4gRQCZ6+dSu
 ffUric167HfJjMBEeTK/WsZ3yohUAmQb9+7e10ioETo/gFH+PJfeJbOJ3SNSrtr6VTTHSRC8J
 QuTjPVZwqEvyrSnKxpLpYmtZ5MhCvQZRMR5CcW3zwjdMcRPaewQsXPjspRqgzO+aPiYoiNWJp
 ZwE/V1SuUbkT1BQi6nqh8AUtWz5mOA96UUpW3rnkYo96aV3TTPFvOH0V8gxz0hgHhvvLASprO
 70USTQhAlMWnnA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/1 20:52, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> Currently inode_in_dir() ignores errors returned from
> btrfs_lookup_dir_index_item() and from btrfs_lookup_dir_item(), treating
> any errors as if the directory entry does not exists in the fs/subvolume
> tree, which is obviously not correct, as we can get errors such as -EIO
> when reading extent buffers while searching the fs/subvolume's tree.
>
> Fix that by making inode_in_dir() return the errors and making its only
> caller, add_inode_ref(), deal with returned errors as well.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/tree-log.c | 47 ++++++++++++++++++++++++++++-----------------
>   1 file changed, 29 insertions(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index b765ca7536fe..79d7cca704fb 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -967,9 +967,11 @@ static noinline int drop_one_dir_item(struct btrfs_=
trans_handle *trans,
>   }
>
>   /*
> - * helper function to see if a given name and sequence number found
> - * in an inode back reference are already in a directory and correctly
> - * point to this inode
> + * Helper function to see if a given name and sequence number found in =
an inode
> + * back reference are already in a directory and correctly point to thi=
s inode.
> + *
> + * Returns: < 0 on error, 0 if the directory entry does not exists and =
1 if it
> + * exists.
>    */
>   static noinline int inode_in_dir(struct btrfs_root *root,
>   				 struct btrfs_path *path,
> @@ -978,29 +980,35 @@ static noinline int inode_in_dir(struct btrfs_root=
 *root,
>   {
>   	struct btrfs_dir_item *di;
>   	struct btrfs_key location;
> -	int match =3D 0;
> +	int ret =3D 0;
>
>   	di =3D btrfs_lookup_dir_index_item(NULL, root, path, dirid,
>   					 index, name, name_len, 0);

I did a quick search for "btrfs_lookup_dir_", and find most if not all
callers are handling the NULL case just like ENOENT.

Can we make btrfs_lookup_match_dir() to return -ENOENT when the target
is not found?

Return NULL while we still have another PTR_ERR(-ENOENT) to indicate not
found is really asking for problems.

Thanks,
Qu
> -	if (di && !IS_ERR(di)) {
> +	if (IS_ERR(di)) {
> +		if (PTR_ERR(di) !=3D -ENOENT)
> +			ret =3D PTR_ERR(di);
> +		goto out;
> +	} else if (di) {
>   		btrfs_dir_item_key_to_cpu(path->nodes[0], di, &location);
>   		if (location.objectid !=3D objectid)
>   			goto out;
> -	} else
> +	} else {
>   		goto out;
> -	btrfs_release_path(path);
> +	}
>
> +	btrfs_release_path(path);
>   	di =3D btrfs_lookup_dir_item(NULL, root, path, dirid, name, name_len,=
 0);
> -	if (di && !IS_ERR(di)) {
> -		btrfs_dir_item_key_to_cpu(path->nodes[0], di, &location);
> -		if (location.objectid !=3D objectid)
> -			goto out;
> -	} else
> +	if (IS_ERR(di)) {
> +		ret =3D PTR_ERR(di);
>   		goto out;
> -	match =3D 1;
> +	} else if (di) {
> +		btrfs_dir_item_key_to_cpu(path->nodes[0], di, &location);
> +		if (location.objectid =3D=3D objectid)
> +			ret =3D 1;
> +	}
>   out:
>   	btrfs_release_path(path);
> -	return match;
> +	return ret;
>   }
>
>   /*
> @@ -1545,10 +1553,12 @@ static noinline int add_inode_ref(struct btrfs_t=
rans_handle *trans,
>   		if (ret)
>   			goto out;
>
> -		/* if we already have a perfect match, we're done */
> -		if (!inode_in_dir(root, path, btrfs_ino(BTRFS_I(dir)),
> -					btrfs_ino(BTRFS_I(inode)), ref_index,
> -					name, namelen)) {
> +		ret =3D inode_in_dir(root, path, btrfs_ino(BTRFS_I(dir)),
> +				   btrfs_ino(BTRFS_I(inode)), ref_index,
> +				   name, namelen);
> +		if (ret < 0) {
> +			goto out;
> +		} else if (ret =3D=3D 0) {
>   			/*
>   			 * look for a conflicting back reference in the
>   			 * metadata. if we find one we have to unlink that name
> @@ -1608,6 +1618,7 @@ static noinline int add_inode_ref(struct btrfs_tra=
ns_handle *trans,
>   			if (ret)
>   				goto out;
>   		}
> +		/* Else, ret =3D=3D 1, we already have a perfect match, we're done. *=
/
>
>   		ref_ptr =3D (unsigned long)(ref_ptr + ref_struct_size) + namelen;
>   		kfree(name);
>
