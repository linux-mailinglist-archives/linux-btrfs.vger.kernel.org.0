Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5913F59CC8A
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 01:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbiHVXyY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 19:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiHVXyW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 19:54:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517235142D
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 16:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661212455;
        bh=oBR43wRnNn9mq+EKAJ+djWDei2e3vRkPORAwBB4srIE=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=WRi6DavfVmh6YCN9D9ErniAm+Ape3J5b6T7YiFP1OA73/5v8+wTYtnfEDKlnRaa3z
         dZhYeYAQZrA0BtkNItDoB44F4w2l6mDtp7/dhxkVR6DeMOp8oVtZ5njXt47dkXw4Dw
         zr1vP6w0CF1XuniKahMRhHrgfrbxoAtfFv6MbdxE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6KUT-1pWyn13fh3-016gqg; Tue, 23
 Aug 2022 01:54:15 +0200
Message-ID: <73c13724-8bd4-ae1e-f35f-8d22d3b9a3d2@gmx.com>
Date:   Tue, 23 Aug 2022 07:54:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1661179270.git.fdmanana@suse.com>
 <5a96945dcc12befa8fd85f6c3766b52c1b652e41.1661179270.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 2/2] btrfs: simplify error handling at
 btrfs_del_root_ref()
In-Reply-To: <5a96945dcc12befa8fd85f6c3766b52c1b652e41.1661179270.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kIu8KEwAWLEGwNzTg5w9p5dUnuFgTe+O6gHsC6yi9xwLhLrKLYw
 yImbilUKVgOaYuTR8FbfVgl6XJ6qELPi0hEmXvSWVUeF6XzIuFd0s59jn0Inz0qqUthhqXh
 2g4oTxz/svJjdZVf2NCf2DBQqM/IuhQLOCzNGAdE5Q+LyVl0O38kDI3sucOKbNt0cW/SBhg
 +TERj/Kpwni3BLO1SX07A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NalTYe9EU/c=:A7nqTsv34iX2rTWjiKYXaM
 NsYZfV2RqypsUsfJRI6lxxAC2lh2GP+HoM+VGY7KlWId/9wtcbrLL2o819qnOmjDeif7C5P3B
 vV0w6TRzF94EsUkLz6NZs3pF1X8w2iuOFZShTIeR3qdbwyccwOZG5yuVLfW5hIW0nGw0MsvJA
 Oz54fehKkmh3KmhL3sNKY9DGdt8WASMbdvCrPvKlhUG/tDoNMgiYnejUVgV43Yn0DD8XU2+H2
 adBEctXpj0nxKL5YWssIqBzXpXJuvUj5XGZoU5NKjLxjpsJ82T+j1oIFR0OPlWYV9X+mFN0Zk
 CEE9EOohu+AD1hpLgv+HmCvltLu0mK+boZU5FVzWlqebkSeFSU2a7LFODbk6IEy5w6X4k+jIp
 KnN6Nj+LnHsBRTsRlnYnBpGo5RFpMDK/NujqSSDIWjeqf/EESj93hJCSu/M7mgK4yoH72rfr9
 cc8eC7bBuZEzJbtEbuhfugSYDJxI0as4AiqtY8RYV5s+YLXmb+nxEm++sgThNfC/bv0r8ULR3
 QH4ROYv6q/NUBYu6LmvWS6qVHzNTKkh0mdA1WqW3lPZZchLq7T5kBQ6sFLmbrrW1xRbdtpYJU
 SwgkC40dSmTOh3OaLdSU6dgD7GZuSvcyarNo8Tewl5jBNQwpcmuuP1vi33xWXmBF48wbDHY9Z
 84IGSA3PycHTl81hOOjwlE5AdynTgQLc04pbbAFhgmlwkXGJ0YJSOtGRkoEMiHTRugBFVAeN5
 rvwRMDo/7cnJ9+rSu4m95RQOGzIp7cm/Jge6BpfetrO/3SqCWbDRiPuPdDlgfDdEEkDP0cfTR
 dED3myETTwqLxVHqcrJvDQNXK7+mUdr+1+9lRr4IDz/wOzO/vM6YuCTmSLJT9G2YGSBUte/eQ
 AEtPicJzYPVIvQTLqVMw3gyfZWh7n7nZ8uTgLIHkTHzx3bVTPZno+FPSD3XuRcYZn7Xyx7Qe1
 kHDyHbaMtL7ySQiYIvTttzy+lUDemlSxeVKMFc1kzvJtV8Gb4bPnna7It4KXuKKX+Abieq8tr
 j4ww0zIog5UICCmsIHGaTslSkEmwVM/d/VRo29GXmrggFHh654Kp5LkLDvHTH6FFPkN1kWuUO
 dWMw+yQ5xjaaqHfxb3GbRalL7dISr7iRlcueeojxaudA8GNoIkzbZZOrw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/22 22:47, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> At btrfs_del_root_ref() we are using two return variables, named 'ret' a=
nd
> 'err'. This makes it harder to follow and easier to return the wrong val=
ue
> in case an error happens - the previous patch in the series, which has t=
he
> subject "btrfs: fix silent failure when deleting root reference", fixed =
a
> bug due to confusion created by these two variables.
>
> So change the function to use a single variable for tracking the return
> value of the function, using only 'ret', which is consistent with most o=
f
> the codebase.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Although one small nitpick inlined below.

> ---
>   fs/btrfs/root-tree.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index d647cb2938c0..e1f599d7a916 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -337,7 +337,6 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *tr=
ans, u64 root_id,
>   	struct extent_buffer *leaf;
>   	struct btrfs_key key;
>   	unsigned long ptr;
> -	int err =3D 0;
>   	int ret;
>
>   	path =3D btrfs_alloc_path();
> @@ -350,7 +349,6 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *tr=
ans, u64 root_id,
>   again:
>   	ret =3D btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
>   	if (ret < 0) {
> -		err =3D ret;
>   		goto out;
>   	} else if (ret =3D=3D 0) {
>   		leaf =3D path->nodes[0];
> @@ -360,18 +358,18 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *=
trans, u64 root_id,
>   		if ((btrfs_root_ref_dirid(leaf, ref) !=3D dirid) ||
>   		    (btrfs_root_ref_name_len(leaf, ref) !=3D name_len) ||
>   		    memcmp_extent_buffer(leaf, name, ptr, name_len)) {
> -			err =3D -ENOENT;
> +			ret =3D -ENOENT;
>   			goto out;
>   		}
>   		*sequence =3D btrfs_root_ref_sequence(leaf, ref);
>
>   		ret =3D btrfs_del_item(trans, tree_root, path);
> -		if (ret) {
> -			err =3D ret;
> +		if (ret)
>   			goto out;
> -		}
> -	} else
> -		err =3D -ENOENT;
> +	} else {
> +		ret =3D -ENOENT;
> +		goto out;
> +	}
>
>   	if (key.type =3D=3D BTRFS_ROOT_BACKREF_KEY) {
>   		btrfs_release_path(path);

To the if () check here can also be a cause of confusion.

Can we split it into two dedicated btrfs_search_slot() calls (instead of
current goto again with different keys) in a separate patch?

I guess that's why the v1 version had some error got overriden, right?

Thanks,
Qu
> @@ -383,7 +381,7 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *tr=
ans, u64 root_id,
>
>   out:
>   	btrfs_free_path(path);
> -	return err;
> +	return ret;
>   }
>
>   /*
