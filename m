Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6E358583D
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Jul 2022 05:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbiG3DXR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jul 2022 23:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239608AbiG3DXQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jul 2022 23:23:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA225925E
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jul 2022 20:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659151389;
        bh=XjcDfeQpz4/F9gM6TqJv9ebR6CEEu3C8d1aalnuYNP8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=LX7r1xFlcaq/fzZ2abl4C9ES9odBHMV/Uus8TFynOEOaJuRCkdZdsH86SK19rkGq0
         8QwS5+hXXyxFUQ5n35VhOxTFrXK6P/y7KOcnmBi6llJmR0SDuMHpfoL7swZIqFM8KW
         Eg3vWMV8NzTevwv3S57n3uFgIyMFwCYiNXRVwmGw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuUnK-1nRJhG28Re-00rbn4; Sat, 30
 Jul 2022 05:23:09 +0200
Message-ID: <e7d8fd1f-1a26-1fa1-e3f6-5b4cda79dab7@gmx.com>
Date:   Sat, 30 Jul 2022 11:23:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] btrfs-progs: check for invalid free space tree entries
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <e3fa3936cd8b01a05390d364a2cf41ca6c3f7834.1659128926.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <e3fa3936cd8b01a05390d364a2cf41ca6c3f7834.1659128926.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dkgryo38ysd36bTMi7ZgFdIDebEjdF6TvfuCxi6jbWxROMwR3UX
 c+tnIkKhixx2LYSopytktQeIUWLh/zRIWh6bL/TCic+HbQPwl3EbdzQ1snTWOKypYWIsbGC
 Y659RPDy+tli8ooYBpJoUmK0jG5JlkafFAYf1I0ovovqezVWM9pcellY1EW51s7iR4l7M52
 rLCxmcIUtR7uLmnpthvnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o7VacZgbXTI=:0W9w66hb0pu1nd/q939v7Y
 b1RIjtFvIcrpPWfkeDWZTNWekCUBcLXqAN3uxPYYfwpaSHLCVvhQ1mKCLd5SWJ3TJ7n8LNCka
 NhbSGttLtgvAltPdE4TITescmoHp7P6TLnZCngX1RQiNCKc1WDEuV4f4z4aAF0Re8IYsuYr1H
 Kqax2/Z36vpaAvMadY0Ajq2xK3jDzmdRwTn/OE0yWKpuRbr6omsnOBK7ueTyYhHEIGW5q0F/P
 KEGeAfgE62iEiB9SNVuBq+lVGQ+/jh5+keJLU7Bk1AMJ4FsJtcPiinCXBCEdP3rv8E7VXmnnz
 Ftv28lZUhO+Iok6O6+9FRNK0ThmVwApblih+DQTmhV1JYXuQf52CQxT3KYlCb3dcDttBQ7lDW
 APqyaiSZHNpW9f6eFGMVIQT2x2Uf3B8bfMd2RAB6KsL7Q+AioBnS/svlqTI3/ApZsE8h5DnBX
 upUsF+8QhbnrjSY6CcZS5mmyRRS1RktHvRkniya6KnWH1H6dmMoOyScjsVT3GvgfrEAxRQfhN
 zTuMwIVvc0F0M+xrRRvouDf+7OTmqyzQZx9nrHhDuqC3g7MrXUN+E1mqYxYcFaA9AkEAbwQmk
 /nmdnsnTtKXBpRIpuQqTK1HhNZSkyKsgFzfE0nEACaH/U1cebTASqQ4jb/wIXvHLG0dnKlzq8
 w7xYohyCrqrOZZjAazB1PRzJYB3dWUam1ePnaw+innCA+ep4RlbMTr7vn6USu1PeP+TpGyUjh
 vobiXKu8bqkNaEtCSSV5u/aoElEQkXwCuGFv8VM1RUvQgcyXWyg5ugdX+pwCC15jtSsMHmpy4
 HKh8fq6/Y7mCpID2mScht/ZnD/RUVwOYRfBjzZGwbSVRC5ySN1yFBQUAIPNl/RchY0iOW2H/n
 SQd54qwfYWfhWJcKy/aMY1t8e13k+EGdubOTRJCgJmYIqin+PAH090P3n9Lt4M9lfePbqEI3Z
 Snyoqx3k6GzlZg+u4XQ1IxFW6MOhYR1GvZbMj6B3OKfxa0eUyD85WEnab5NNE3wUUD+Uk7SYJ
 +8IylD84gPUTkWaSp0y3ysNlxWykCMfOY+OJAyNLu5h7pVQYa1sR+vczMIRXEcF8yhocwhWXw
 Uq8tkxwjTAZ8o6EWN/2FFkrYR99zuY7ZGP2U1ygW3eADJhIFhIf0wtUJg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/30 05:08, Josef Bacik wrote:
> While testing some changes to how we reclaim block groups I started
> hitting failures with my TEST_DEV.  This occurred because I had a bug
> and failed to properly remove a block groups free space tree entries.
> However this wasn't caught in testing when it happened because
> btrfs check only checks that the free space cache for the existing block
> groups is valid, it doesn't check for free space entries that don't have
> a corresponding block group.
>
> Fix this by checking for free space entries that don't have a
> corresponding block group.  Additionally add a test image to validate
> this fix.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   check/main.c                                  |  79 ++++++++++++++++++
>   .../corrupt-free-space-tree.img.xz            | Bin 0 -> 1368 bytes
>   2 files changed, 79 insertions(+)
>   create mode 100644 tests/fsck-tests/058-bad-free-space-tree-entry/corr=
upt-free-space-tree.img.xz
>
> diff --git a/check/main.c b/check/main.c
> index 4f7ab8b2..fb119bfe 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -5729,6 +5729,83 @@ static int verify_space_cache(struct btrfs_root *=
root,
>   	return ret;
>   }
>
> +static int check_free_space_tree(struct btrfs_root *root)
> +{
> +	struct btrfs_key key =3D {};
> +	struct btrfs_path *path;
> +	int ret =3D 0;
> +
> +	path =3D btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	while (1) {
> +		struct btrfs_block_group *bg;
> +		u64 cur_start =3D key.objectid;
> +
> +		ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +		if (ret < 0)
> +			goto out;
> +
> +		/*
> +		 * We should be landing on an item, so if we're above the
> +		 * nritems we know we hit the end of the tree.
> +		 */
> +		if (path->slots[0] >=3D btrfs_header_nritems(path->nodes[0]))
> +			break;
> +
> +		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +
> +		if (key.type !=3D BTRFS_FREE_SPACE_INFO_KEY) {
> +			fprintf(stderr, "Failed to find a space info key at %llu [%llu %u %l=
lu]\n",
> +				cur_start, key.objectid, key.type, key.offset);
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		bg =3D btrfs_lookup_first_block_group(gfs_info, key.objectid);
> +		if (!bg) {
> +			fprintf(stderr, "We have a space info key for a block group that doe=
sn't exist\n");
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		btrfs_release_path(path);
> +		key.objectid +=3D key.offset;
> +		key.offset =3D 0;
> +	}
> +	ret =3D 0;
> +out:
> +	btrfs_free_path(path);
> +	return ret;
> +}
> +
> +static int check_free_space_trees(struct btrfs_root *root)
> +{
> +	struct btrfs_root *free_space_root;
> +	struct rb_node *n;
> +	struct btrfs_key key =3D {
> +		.objectid =3D BTRFS_FREE_SPACE_TREE_OBJECTID,
> +		.type =3D BTRFS_ROOT_ITEM_KEY,
> +		.offset =3D 0,
> +	};
> +	int ret =3D 0;
> +
> +	free_space_root =3D btrfs_global_root(gfs_info, &key);
> +	while (1) {
> +		ret =3D check_free_space_tree(free_space_root);
> +		if (ret)
> +			break;
> +		n =3D rb_next(&root->rb_node);
> +		if (!n)
> +			break;
> +		free_space_root =3D rb_entry(n, struct btrfs_root, rb_node);
> +		if (root->root_key.objectid !=3D BTRFS_FREE_SPACE_TREE_OBJECTID)
> +			break;
> +	}
> +	return ret;
> +}
> +
>   static int check_space_cache(struct btrfs_root *root)
>   {
>   	struct extent_io_tree used;
> @@ -10121,6 +10198,8 @@ static int validate_free_space_cache(struct btrf=
s_root *root)
>   	}
>
>   	ret =3D check_space_cache(root);
> +	if (!ret && btrfs_fs_compat_ro(gfs_info, FREE_SPACE_TREE))
> +		ret =3D check_free_space_trees(root);
>   	if (ret && btrfs_fs_compat_ro(gfs_info, FREE_SPACE_TREE) &&
>   	    repair) {
>   		ret =3D do_clear_free_space_cache(2);
> diff --git a/tests/fsck-tests/058-bad-free-space-tree-entry/corrupt-free=
-space-tree.img.xz b/tests/fsck-tests/058-bad-free-space-tree-entry/corrup=
t-free-space-tree.img.xz
> new file mode 100644
> index 0000000000000000000000000000000000000000..93280b82749c87183c822274=
0f15f6abca3d9bbf
> GIT binary patch
> literal 1368
> zcmV-e1*iJ`H+ooF000E$*0e?f03iVu0001VFXf}+Q~w1OT>wRyj;C3^v%$$4d1ocf
> zjjaF1$3^@a-*Xj3r-#5<9#Wqg%5NYWtuFyaX3{;HIsTkK=3DA=3DaNB3|l5$%+=3Do8g1{`
> z9>n_MeGBmNWMc2O8%=3DOwNuQkT%DC=3Du6%>3ias*)m2w2Vj{<X`j2OnKGMEZ%xR1cy`
> zv?-{L(P2Vkw0p<|MXz$0(HMoM8$Cs<!9}Ebp|h0L_u(K6y=3Dq5|H5~9~lfr>K%U40+
> z_*HaH3>s3Be3<P8!YiHA`cw6c01&vER1Oyfl&3F9`o@wse1epc9c+bHS%moHfGbi0
> za>G|qceZM^9=3D!MAA{x7B*DdZw`=3DMZbP>g&&UJ78w*_xFJ*ymY);<Mbk211PVqr9pY
> z2$a*{$ddCoWl0v${~c<P0kv>=3D&F%~Em~&)LIgI!eG5|{o17mJxTHbL0LzMS}X7Rn(
> z8aG+sA}om=3DlMvs%yH^30B*fHO+M3JW%myi2Q@oISpjzVQL->PHN#F;kkTDP9m3d&G
> zATJRzI9%32{Q#bQRBPs+qO=3D%P(RJuP|KXmbBKz&TwxJq`c>bGV$H_w?rL#W~CBA&Y
> zTVrF&)Lgdkg=3Dt8HuJHV%5gY<|+kT6=3Dfq0y7i5Dq~A`8gp{)hlOigUZY*~kzbW*nyy
> zPy`p*ZYH)a7M@cM%W+<aS#c!NBv6M#k&B?|Gp>@{OMl<t$~kLNW5L+}or+3uMfZCa
> zPdfQpi-M`W(}|V|bGaH}H$OWtV5FtcB!t8htp{EN<x2hz!>(-bc0W+2Ou$DqMhHg0
> zAXXfJ)lD^OQ+ZsozgJ|ED^p@%Xk(nRRA=3D1*@@0`G!v_f=3Deu`$4g=3D+OcYHd?o<s{k<
> zxnc&Y__V)N3e2C_ckEzS<C+G7Nmfx90n%C0*tw3Kx?CrF*A4nznbUo#(uhw;yi{b&
> zUFA$8;MagqpNk9<F7lTE&f5YUW5zkYknyP}6_&g7maa>n#o^)Go`Vsk4wWALj%6xo
> zaptcSD`V9YyHG^8)iRj!Joyn!>AZaZYq|%`TqWRNiYO4%%UH-fOt<QXMD?{|hGUbp
> zrYY)<e8>}&<1eT_XhMooY9PF)hWGE81Aws&1!uWAsqM;Ila>-d{V}&$g0ds)zg&5W
> zy@oE>Vku@9rAuL@*wgdz7LuW?v&?fv^VEo(ELFU8)sSplTO|-_Q>g)KAl2D8@Wv4Y
> zy}hHu5?eK*DQHnJhNk1<@fb?xFkdSAlPxV;TKl{n;f9EkWjJt73KuO}-qG&G+*R)4
> zhwOeTHj!?vZ|(K2a(js@blT`!xJhTI{G8PmIgngOpf5HKr4%f_C@7a5O$XsR>`ph3
> zJz=3DxXUxXe6<DAbu*W&a8RFF;`p>>7gvsh$Ew3X_(ssfEfMDkER1cYqYxN3}-w)g0`
> z`SCbd(vQevQ;+U<8TtQb{OE;fs!)YC&?A1H9|)Br;s1wxo&K&9?UjEYW|mKVQq6tH
> zm(NruvFH7=3D%Q?*I)g6tb0-kV?<>qj-__Hc`D^QsGKI9`d+nL^1g*N?EU%c~9&I=3DR?
> zBW6edh^W^U!u{1k%mq`Fcp#QU4}(<wxlpXBWvSX#&huX4Ijqe+-iDRro04Xy+{kR)
> z(^+iDSztUr)`280d<1=3DuO{~1UM1%4>BZvQQ4zC#B;#@cKzqPk)OV4xGUgcG@RzDoN
> zvL!%GwW?EsbyiH<;7;8+b{X<zmZ8HfcL|V@C=3Da>Xdph+>?Zp590000pn{%NX14{`2
> a0kH~zs0jcD4TH0>#Ao{g000001X)^gHlHK_
>
> literal 0
> HcmV?d00001
>
