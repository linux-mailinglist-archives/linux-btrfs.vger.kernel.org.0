Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AA37ABBD4
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Sep 2023 00:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjIVWfi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 18:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjIVWfg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 18:35:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414EFAB
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 15:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695422128; x=1696026928; i=quwenruo.btrfs@gmx.com;
 bh=L+9A1YRQlRUscezOzl6anJlZVNpkFmFnb6dvQNhxaLk=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=M/KavADES2f9TcYFh9yxf8VbhwzXFOdRPxj590ExhW8ngxdKG4uLkuLXCG0OnYPxs5Cm5UPVdeT
 jci04uIgSd+0NP3ha8QHRbHORYR8pc+B2qrcwMsYQqGUtZRUEMc0gswreeTN5VSa/1U67sE1qwZOk
 zVPthrGtetu7I7eifE2sA8CmBNJvwljtbiYR6N/++Z0GF1nmt5HwPNFr7Vw+AvxmqlWZ1XJ2o9La5
 zVfNecZbW0qYtrALawVPuLJQJOnI1Pq7UqFsuerQd5uWKnsp7LAZRz9cfJ9iNaBZd/XzhWAyuY3tT
 K37VZ2y2ljXOSlyEP7/HI4qJ5TdQkuxTKKlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.6.112.4] ([173.244.62.37]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5G9t-1ripFC2ThN-01188k; Sat, 23
 Sep 2023 00:35:28 +0200
Message-ID: <0dc65467-c8ba-4fbb-9475-e753c91d4a77@gmx.com>
Date:   Sat, 23 Sep 2023 08:05:25 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] btrfs: relocation: use on-stack iterator in
 build_backref_tree
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1695380646.git.dsterba@suse.com>
 <7588cec46a2d548400de33930811fa12026f1dd1.1695380646.git.dsterba@suse.com>
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
In-Reply-To: <7588cec46a2d548400de33930811fa12026f1dd1.1695380646.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uXWr3Vg/f+ofAZKRiYvxlTJgeyVsIpRRJP3k9p1l80B2w46fnv+
 1zflkE8aUtqr1BvSItqQO+/R1LmoR0BTgWOtvNHxKiIobkwjG/abHgH3bjfMuUeE6XhhMGe
 Nj+9cBcCJlCG7xCGA8PnM3uYHU0ugZOTB6RtiPl6qhcoww0US/g4mI9ETN40dyZgQJUAZ94
 zqFKbLY7IPc5WJV4SrX8w==
UI-OutboundReport: notjunk:1;M01:P0:TnIe1k781zs=;SUGpDn0UQhPjCijpp0Nb9cbFdzt
 3B63m1mIqJf3VkUl071iz7aKwAvrAI326htjPnCwwwg86/RCiYGuklLurRsxCigFTqupw7SHb
 BhLHjPFW80prEtfJ9RT7DrJXGntxJNIyigSPc5Q0+UJ7ZeQBYv3qXrNLmHse6jza1L5qhSQSj
 8q1b9nE0QutF75Pf148mducv+Wc1DZ8uBLWuxRQMHVX1iLRDDt6HMZjxp2NOF11TmyglMUUhD
 5w3atitLEzijmds0uia/ftyS6UprKUO6lBNeqji012Ya+zB0pEReDyXFUqLndzz6lk9iw6wHi
 lxTpvjpuNS8ZNg4RGC7LfhHFJZAE2JwMWN065pPw/4N7QE3xoyS3w0B6OlM5ncxGpINTrdXrO
 cVsR5r307Fok3UlhAsr8KQ8RfNMaBWxh5HT/wtE9iQhNVJCSzwzpNz3ooQf5+JWBRAxqCjLAC
 +ca697JruFcKLcGDZcOatj0AsjDoP0m7FIVum8kBJC5VlFKUb7KicYD/WwVbpWU6RjXCwhx/r
 UpW/KsNMjchyONoDTzOi02y8cZBLg0iXWPFxuIL4zFkkw3ipSI5S8b7hE4QRcMQDUIV+foyeo
 2q7QDxRdI2cSuVD9o6mWzvRxAg2tLOJ6k076K13jjFz9XlCjMh/4D5bdTgcdrmCPaVkZPcif/
 xJ0Lc7CLzHhqrIEDegcyTik8FisrT6/4+tNtziJzymFWsTy0eemsQskT21BrV+WCEIAzPN+rd
 s8j3ZIU3pYeTEMfBtcCon2MSmAMLGKMuI3Nimt+ljyE6iJUFNBUTh4zfN+nwFS6DL0JHgGKi0
 zYXiDVcKIAJfaGoAanEoySx1mzoK9GVTHkkR0IETY18IaA//URur74Q5s88/kfmq2yvY170fk
 3aGSG0q1IVWIS3JcTQTiqiLA/kYh4ZJ6wDJ+xshcTiK4FLwhDKM7/DZ8R/MsklVC+5USS/19n
 eyrjXfzeiU1WIMOkyqucWTcMZqQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/22 20:37, David Sterba wrote:
> build_backref_tree() is called in a loop by relocate_tree_blocks()
> for each relocated block. The iterator is allocated and freed repeatedly
> while we could simply use an on-stack variable to avoid the allocation
> and remove one more failure case. The stack grows by 48 bytes.
>
> This was the only use of btrfs_backref_iter_alloc() so it's changed to
> be an initializer and btrfs_backref_iter_free() can be removed
> completely.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/backref.c    | 26 ++++++++++----------------
>   fs/btrfs/backref.h    | 11 ++---------
>   fs/btrfs/relocation.c | 12 ++++++------
>   3 files changed, 18 insertions(+), 31 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 0dc91bf654b5..691b20b47065 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -2828,26 +2828,20 @@ void free_ipath(struct inode_fs_paths *ipath)
>   	kfree(ipath);
>   }
>
> -struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_inf=
o *fs_info)
> +int btrfs_backref_iter_init(struct btrfs_fs_info *fs_info,
> +			    struct btrfs_backref_iter *iter)
>   {
> -	struct btrfs_backref_iter *ret;
> -
> -	ret =3D kzalloc(sizeof(*ret), GFP_NOFS);
> -	if (!ret)
> -		return NULL;
> -
> -	ret->path =3D btrfs_alloc_path();
> -	if (!ret->path) {
> -		kfree(ret);
> -		return NULL;
> -	}
> +	memset(iter, 0, sizeof(struct btrfs_backref_iter));
> +	iter->path =3D btrfs_alloc_path();
> +	if (!iter->path)
> +		return -ENOMEM;

We can do one step further, by integrating the btrfs_path into @iter,
other than re-allocating it again and again.

Thanks,
Qu
>
>   	/* Current backref iterator only supports iteration in commit root */
> -	ret->path->search_commit_root =3D 1;
> -	ret->path->skip_locking =3D 1;
> -	ret->fs_info =3D fs_info;
> +	iter->path->search_commit_root =3D 1;
> +	iter->path->skip_locking =3D 1;
> +	iter->fs_info =3D fs_info;
>
> -	return ret;
> +	return 0;
>   }
>
>   int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 byte=
nr)
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index 83a9a34e948e..24fabbd2a80a 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -269,15 +269,8 @@ struct btrfs_backref_iter {
>   	u32 end_ptr;
>   };
>
> -struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_inf=
o *fs_info);
> -
> -static inline void btrfs_backref_iter_free(struct btrfs_backref_iter *i=
ter)
> -{
> -	if (!iter)
> -		return;
> -	btrfs_free_path(iter->path);
> -	kfree(iter);
> -}
> +int btrfs_backref_iter_init(struct btrfs_fs_info *fs_info,
> +			    struct btrfs_backref_iter *iter);
>
>   static inline struct extent_buffer *btrfs_backref_get_eb(
>   		struct btrfs_backref_iter *iter)
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index d1dcbb15baa7..6a31e73c3df7 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -464,7 +464,7 @@ static noinline_for_stack struct btrfs_backref_node =
*build_backref_tree(
>   			struct reloc_control *rc, struct btrfs_key *node_key,
>   			int level, u64 bytenr)
>   {
> -	struct btrfs_backref_iter *iter;
> +	struct btrfs_backref_iter iter;
>   	struct btrfs_backref_cache *cache =3D &rc->backref_cache;
>   	/* For searching parent of TREE_BLOCK_REF */
>   	struct btrfs_path *path;
> @@ -474,9 +474,9 @@ static noinline_for_stack struct btrfs_backref_node =
*build_backref_tree(
>   	int ret;
>   	int err =3D 0;
>
> -	iter =3D btrfs_backref_iter_alloc(rc->extent_root->fs_info);
> -	if (!iter)
> -		return ERR_PTR(-ENOMEM);
> +	ret =3D btrfs_backref_iter_init(rc->extent_root->fs_info, &iter);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
>   	path =3D btrfs_alloc_path();
>   	if (!path) {
>   		err =3D -ENOMEM;
> @@ -494,7 +494,7 @@ static noinline_for_stack struct btrfs_backref_node =
*build_backref_tree(
>
>   	/* Breadth-first search to build backref cache */
>   	do {
> -		ret =3D btrfs_backref_add_tree_node(cache, path, iter, node_key,
> +		ret =3D btrfs_backref_add_tree_node(cache, path, &iter, node_key,
>   						  cur);
>   		if (ret < 0) {
>   			err =3D ret;
> @@ -522,7 +522,7 @@ static noinline_for_stack struct btrfs_backref_node =
*build_backref_tree(
>   	if (handle_useless_nodes(rc, node))
>   		node =3D NULL;
>   out:
> -	btrfs_backref_iter_free(iter);
> +	btrfs_backref_iter_release(&iter);
>   	btrfs_free_path(path);
>   	if (err) {
>   		btrfs_backref_error_cleanup(cache, node);
