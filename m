Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2446A7ABBA7
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Sep 2023 00:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjIVWJS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 18:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjIVWJR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 18:09:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932E7CA
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 15:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695420546; x=1696025346; i=quwenruo.btrfs@gmx.com;
 bh=UfXxtwD2kk2D3uqJaUh9iCjSigVeSucUbHBoQssMG9Q=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=o0vNgZbpeLH0ewNjDZQq+/MvxOXEtAKnOIpgBitmTtZiwJWWA+C8rIvP6Iq5AA0ETj+xHWCZnER
 Nwr4iuJadNVJONiMEFxI7TAFHvI/rd2T2pp67iELlyzEroL4uzpM1oqsKKYNACdzWe4kzKSV7uH6j
 X0J4/2mDPYw0HsXTS+Ekh0Jr2HWHQqgAAbVaAtMP+z+6DL48JqpPTTuJoQkMVeHFS64iPnPGG+ih1
 vbBd8/b3OnSGYEV0Q/mxn46NJir52KqaLgYdeAjH28BJeVhJmB/cV38p4QVyKkm2N/z05f2pYzY/9
 uFumm/BmPQOcBMoyzMmah80kcub9Vam0zWcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8XTv-1roJ282GNl-014SCD; Sat, 23
 Sep 2023 00:09:06 +0200
Message-ID: <3ccfde61-9e2d-4c1f-a03d-a7b0b61be7e3@gmx.com>
Date:   Sat, 23 Sep 2023 07:39:04 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] btrfs: remove redundant root argument from
 maybe_insert_hole()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1695333082.git.fdmanana@suse.com>
 <6f3a5b0048ea27c88a69e4861e2b6b86afd284f9.1695333082.git.fdmanana@suse.com>
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
In-Reply-To: <6f3a5b0048ea27c88a69e4861e2b6b86afd284f9.1695333082.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mI5hFNnSnoThooJo+RdeAE81fBk8tmilQ3Es+S6fvmQhLpC68VO
 BQzO3RQWX9FgEiOxjiVertitzxWoNXgJGhBRAj13P+BMMA+Wg51zBtQn6KJQEP4p+zXhjx0
 +UboDFEkJ/SKjAiKkl4nuS4UYJTJ5h5n4dgNED2FLoo+QWurBGcqNZyBErxa5pSSFKq3X/I
 llKYKG2GoyFOEfpAgOlzw==
UI-OutboundReport: notjunk:1;M01:P0:oLnavdu3xuE=;WS+DtG9e1JLjGNorZa2ARfj3IGu
 KILjpsHDHZP4amT3vG9FNJdg/um6djm2DdGxqpXa+hTZkZLPlmNxtqVe0cvv3sN64By2LiSKc
 RSNLKmJy1yKi6OjmA1T+IbvByDXaGTM9ZM2XZ1nKGAl+yA85kd0DqJWoh9zWtjzne/PW5QupN
 h/B1CoqPj9cKt7mdPok87qZ0rPO2RbVQMmACNFAjBEDF2eeHJBCJNc8Pysacs14+tuuMQJVnj
 EO5WcZFJCxT2ohsBa7BLrevYFo7vVi0rpC7Zy42C7Spv0qhteu8RHbfNKXADunPWdnCS82ebK
 TMQloQUfdB6OuchwKvLrjyJT97UAvWPrtvv8By+wqlixoXGsAURNVy+CYJ2wjMStdNWOKuoXi
 swATofGhIJE09/ZoSBLu0PYFNQTIAK6jFPVdCQFcKJPum3pldOsNpnOBAXRiECR5edp1wjh0/
 aLWIxBBo16+IG3td92LO8X5XoumL8bG6HU09kfFHfGFJI2kCeawwtkWMiwz5hPugqPL2cg29N
 zNdpJWZhX/oUmT1v/1KW3oTyQhjMVx3Fv4xiZyVS5hAq1CHSs/cANCl+v6aMUja//evCL2URp
 /eRf22RWeR0KZ+o40tXD4mzcJSuPrkIiHBvkzF9s/vn51W7lXxhQn83Gxddf/OxPw1qNeMbv7
 V+9GfOSoYkyMbox6eKnieUeCfUGcgKO9Lve3hgiYAnL762TLXCjA9jfBYjqn8+BfoqUx7Y2hq
 2agxLeC5Vrh/YtLWPNWzHjdbqoMsKvcGqK6xWQWCin8dvWbMwpMIZChyv+hLdYiXAgagt6pDC
 Z9r+aV42+N7w1fIdUJx7XVsp2dVIhnM2fc6xBO9zRKzQat6kJO7WNw2AfGiW/QO/G8ktWJ3lj
 DZeRDELVCcJR1JJoItLOjtcI7jxRdInjQx5gHzpat93DDwnW341gIvtFQ3ufL6t/U8Eustzgd
 waoFWHIszrHGT0vA4z82pIKmozM=
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
> The root argument for maybe_insert_hole() always matches the root of the
> given inode, so remove the root argument and get it from the inode
> argument.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 54647b7fb600..52576deda654 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4800,9 +4800,9 @@ int btrfs_truncate_block(struct btrfs_inode *inode=
, loff_t from, loff_t len,
>   	return ret;
>   }
>
> -static int maybe_insert_hole(struct btrfs_root *root, struct btrfs_inod=
e *inode,
> -			     u64 offset, u64 len)
> +static int maybe_insert_hole(struct btrfs_inode *inode, u64 offset, u64=
 len)
>   {
> +	struct btrfs_root *root =3D inode->root;
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>   	struct btrfs_trans_handle *trans;
>   	struct btrfs_drop_extents_args drop_args =3D { 0 };
> @@ -4898,8 +4898,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, l=
off_t oldsize, loff_t size)
>   		if (!test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
>   			struct extent_map *hole_em;
>
> -			err =3D maybe_insert_hole(root, inode, cur_offset,
> -						hole_size);
> +			err =3D maybe_insert_hole(inode, cur_offset, hole_size);
>   			if (err)
>   				break;
>
