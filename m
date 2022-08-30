Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A67F5A5ADE
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Aug 2022 06:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiH3ErJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 00:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiH3ErH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 00:47:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0645AB434
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Aug 2022 21:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661834817;
        bh=M7hMMYbEcTYWdC3j6uz4aBJaTD3+a6uPobEipjUilY4=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ZPpAy0rKAxmR4YmDsK5otTiWQxXJXG9V7qF3Tiv3p8WVGrGCeOXJmy7136GGy8wJn
         M3nvoWD3MsNEgKfARhVtqhyq0ZJIa4rfVRqL2Ioqw41pyQkyty6z7Ni/Hexi+s5DPa
         5ad75GWvgKYxYt5w3lDfyEcvEIN5uSMzZJTLP/iw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MatRT-1p022t3mSR-00cNUP; Tue, 30
 Aug 2022 06:46:57 +0200
Message-ID: <8f9f288a-4c29-8128-327c-5430945e5984@gmx.com>
Date:   Tue, 30 Aug 2022 12:46:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] btrfs-progs: check for invalid free space tree entries
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, David Sterba <dsterba@suse.cz>
References: <e3fa3936cd8b01a05390d364a2cf41ca6c3f7834.1659128926.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <e3fa3936cd8b01a05390d364a2cf41ca6c3f7834.1659128926.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lan0cTilNCJ2MR2eYvYddGF5JE/J3ZkTBJ6KAcRH9skNBZ/mLwP
 KPFyuQUT6y0VKuG5tCtM6CfPxFk+N5QO330LEWORQ5SR7Pt4qSk3QaFqoMpzhEncHMrc1Iz
 I61/fCqzRsXpyEDC3ECF4MLPJtxrXnZyzhBFXjeGh8CPCdpprlPpAmVeVZzcBiefsOZ2dRf
 ZSkVgzX4WrDCmIn4D7WBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pc46gIrzRFA=:4iziuSoUUmSbJGjr4ifkDQ
 7r+hW/+LIrXQ3HYq/I2CIK1Yqf83Eu72aWzvhFq5KDw8YIcCWLIivO7DgWSNqNyyouFUQGdSS
 ehqtLOW4sWaqj3g3Hr4CXUG+fEMreMrWGNCGYWwt8Dr/MND/O2LviyY9FAw3zluuh6cxXaufK
 9RqSM4e30eDb02QGdK1bEtp3WI6xTx9SZfG7ynmbJlYKvlPmABWySJXth+ZaMSrGxxfoTkIAH
 YFve5WaLi+FeZAPLpP4Ylgz+T6bXDhiWgEPhK/vg95iWz9iza++GAaTfyhYLUtKXj8fZMpSp5
 9bzeu2V/YnSmuNzbOZ5fL6Ghh3sMSXc+mzfin6Ac/cLiaZCAwrNeoOCDwe1mezpKahDmbKoO9
 1Xo6U9LxxbZgahaTo/GMHZNqq0BUxllv/6+r+rB01murnvXt7DNLZT1wnUXzT8YFteLpxySEz
 dAJJvDxGmfwP/tvL7JSFqJvbNHVxvAHBKmF0GVjTlY98OPAv6faQcPYBn7RivlsdQjRSURMEk
 NkSR+9ey+YIRxwZvf46szYacqGUp/T7kk/m1HZ/IfXnyAR9mBWnDuuA9iNY5raFCGV7ja/WVx
 yNLbjvaQke/YV3aW3mSOgIp0fwc7n7lhnmfkfIt7dArRWv8/DzpYYA1BsniF0JPipQlwtVCli
 BEEGnj7blj8o8Rjw8aoF/wsF1qUsaJkm4KCyd293A3rVCiOo6qUqQz1TWz56Q5cCvyx68vJcz
 CEB7cJfniE/OOdKmynIKtfUSGN3FxZolamUCmDnr/lqyY2YAKwMf1vZYp6H8aceQeJO9Qj444
 c+9QaORV2dDsaZc0p3UDKzKIwSwPFgtolozw6h/Y1CsXDFerEKTziNpGlGaGz8/KhMJh2Y38K
 xBIlyuvfAGCCZirinjKrUR0iSJ7nf2ggL9Q1g44ggINMfsJX0+wYja3EB8ZoAQa2VylpPNm1o
 Nc2eYWbOClkC8ezggqzeG/wbSjjmA/5JscHLwaG/xb4rYl5T2ArZDu0pas9YwYds010SApqQ+
 5wsczCSOTv7A8TsReHwwj+bdE+aExSQeE5BUatrgVnQC4me+545RTWMPHlETZtAbqbA494ASP
 1SPg0eV+TYBeMvTaBOv2Vk7sSu/NZLEkD5xQS/LsFOrnoooQzOHVqZVzw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

David, something is wrong with the patch in upstream, but not in the
patch in the mailing list.

>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
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

Here, the original code just goto out tag, and there we call
btrfs_free_path() and free everything.

But in devel branch, we're using on-stack path, and out tag no longer
has the btrfs_release_path(), but just return.

This leaks the path, causing every valid btrfs to cause eb leakage:

[adam@btrfs-vm btrfs-progs]$ ./btrfs check ~/test.img
Opening filesystem to check...
Checking filesystem on /home/adam/test.img
UUID: 956ba692-d951-4c63-8c50-73541d01a6f3
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 16461824 bytes used, no error found
total csum bytes: 13836
total tree bytes: 2293760
total fs tree bytes: 2129920
total extent tree bytes: 65536
btree space waste bytes: 441740
file data blocks allocated: 14168064
  referenced 14168064
extent buffer leak: start 33062912 len 16384

In my case, above eb is the fst root node.

I'll send out a fix for it since it's already in the v5.19 release.

Thanks,
Qu
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
