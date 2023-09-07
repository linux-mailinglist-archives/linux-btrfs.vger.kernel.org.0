Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E08797F73
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 01:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbjIGX5Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 19:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbjIGX5P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 19:57:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E2B1BC8
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 16:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1694131029; x=1694735829; i=quwenruo.btrfs@gmx.com;
 bh=zBmyYvjPtOdN3SjTZU0CGlRyPrLpSFkD2SbGR/14kKw=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=SM2ICzpcGvD5NITNtSpJexk5LZgNVL0tb9sH8xLG0cgX1RC23dG7Z+W00jUMTf6axehn1Vj
 m+bnLJ3g0O1m2deXyL4aUQII+/D/ZA7EYv2J64DaNqJX9hdUmsxVPXVp22KiH+9KnfkRIp19e
 l2W0F7JPlMXBY0J3mdfMdjk+/vaSbv1tV35yjgDarbjVGHxndlqv768GF4j+Xq3asSWbNRctT
 iyAm0pPikPwXrqUIyx9xOMkFv4b6dxWkwAYRBgtHv6Hc16DPwPaDc9svb9qu+fdh6m0lWVFsG
 CdsDLG0Qq1gIbZVMascBTzMaeFFnxlEwx1imPqVvMW991+tHCvxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqJmF-1prqVj252p-00nROj; Fri, 08
 Sep 2023 01:57:09 +0200
Message-ID: <c59cd109-ba8b-4dac-8c3e-47f7a1a24d51@gmx.com>
Date:   Fri, 8 Sep 2023 07:57:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] btrfs: reduce parameters of
 btrfs_pin_reserved_extent
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1694126893.git.dsterba@suse.com>
 <339252a0cd7e42cbd8f527601b3c9e7f0d565231.1694126893.git.dsterba@suse.com>
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
In-Reply-To: <339252a0cd7e42cbd8f527601b3c9e7f0d565231.1694126893.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PckMEg8z4kioF61ZtduKS/aUk/ulesc7kljlW2wYFFiSU8ZFxMZ
 wUDWld988jJpat19TtkPfOvH4MSaWYa1clVqq6ux5sYLKqV1RD6FXaOX4r1KLbQrAjDDSaZ
 jCyRViMEPAQDBeKh3iiSkm/aK0x/MDZZJ7EFjz1STo8wugLOpOwOWGffQQ6sDNKKwFdLFXp
 vqrbXszGYOtZAwPQjLR8w==
UI-OutboundReport: notjunk:1;M01:P0:XF//URDjJmY=;9Q24oq1YQIuSJfQrytxeP5RgZWG
 hS7HeffZBh1epCQX4nskK38zA/HXp34WBp+EvyfDKZE5CcRJunVMKVfQ4YlyIv4POZAWVB74c
 wF0+SPyVR38y8uVtE0JzPlGJC9Nh47eNflxtSC2bbSNRyoIXfhjBKmTw1xulcuDsyvS16U1lx
 7qxJA3Dg/FxMbsQxoIiruh8LifnVWHThxLty0X0murP2goKfDXad8CQTdkyIMmzUkGIeV+mp1
 ZNCqy/zBYYPRN4P/T1txuIAO1LnZ3al21NWE1ldvkIX2VjO0JiUVD8sJlKQRr9YA7vZSVl2dw
 ZeLTpLIN4vKPvkTXuMcIb6bYlGYHe/6UJN4TlRRS1EoUG9mAALIuzvbaTZlCAPvPHIquAv1P4
 v6/EZg//pdoCTliqTDmk4OdiynaKTjUsaPGVSxMS48+QyvBTvR4r84lVTMDqq/p53iH/qeUHx
 prD+s37K6NxG2Po6I8HvOHfcUNP1WRS8HCCmo+n0KZareW/ep9Dq+PcVI2J+K0TMNC/r3sFya
 RQDKRj0eYhQJwAFUK7EQ0VffTEwX2SFG13W3rIhDVdcmAfaYBLvCUiSkpajlEzmPO3pgPZKU2
 jogu3gwi0Zem+c6k9vG6VRfnVrUZ3Wo+4h827pa7d7Ln2x1TJps4IxshiF92Q655nG1WbazBU
 ZZj6KafzBOEnTGGOcQAVN+IqK5h9BQfIymJM6C1pACz+iULjsUVlXDWtNKVh+fk3x+ffMMsHP
 31ynT0+CynGnvb/wu04jj1xtEt4j0PAZf38MQQdcB+hrjoCgXUm/tsAvKTTxNyVPmLahxnOfK
 WQhnqg7YGaSelZeyC6MOk8qwxZyXMybMiiJ13DKTA8HBRwwk9jxRGRj9+D2pa/18W8XhMBfBf
 f2brrf3Z3QoZRrlYRqDpucNfzqtX9PrHJ4qAjuTVsOYYMp+TXgiJ9ljSt48dESBvXogAVeWqO
 uOXeAcRh0awYslOue4G/kSJpSW0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/8 07:09, David Sterba wrote:
> There is only one caller of btrfs_pin_reserved_extent that expands the
> parameters to extent buffer members. We can simply pass the extent
> buffer instead.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent-tree.c | 10 +++++-----
>   fs/btrfs/extent-tree.h |  3 ++-
>   fs/btrfs/tree-log.c    |  2 +-
>   3 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 5ef4e852ae2e..98d97c97ab8c 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4560,20 +4560,20 @@ int btrfs_free_reserved_extent(struct btrfs_fs_i=
nfo *fs_info,
>   	return 0;
>   }
>
> -int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans, u64 sta=
rt,
> -			      u64 len)
> +int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans,
> +			      const struct extent_buffer *eb)
>   {
>   	struct btrfs_block_group *cache;
>   	int ret =3D 0;
>
> -	cache =3D btrfs_lookup_block_group(trans->fs_info, start);
> +	cache =3D btrfs_lookup_block_group(trans->fs_info, eb->start);
>   	if (!cache) {
>   		btrfs_err(trans->fs_info, "unable to find block group for %llu",
> -			  start);
> +			  eb->start);
>   		return -ENOSPC;
>   	}
>
> -	ret =3D pin_down_extent(trans, cache, start, len, 1);
> +	ret =3D pin_down_extent(trans, cache, eb->start, eb->len, 1);
>   	btrfs_put_block_group(cache);
>   	return ret;
>   }
> diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
> index 2109c72aea2a..c56f616dcd1b 100644
> --- a/fs/btrfs/extent-tree.h
> +++ b/fs/btrfs/extent-tree.h
> @@ -139,7 +139,8 @@ int btrfs_free_extent(struct btrfs_trans_handle *tra=
ns, struct btrfs_ref *ref);
>
>   int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
>   			       u64 start, u64 len, int delalloc);
> -int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans, u64 sta=
rt, u64 len);
> +int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans,
> +			      const struct extent_buffer *eb);
>   int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
>   int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans, struct btrf=
s_ref *generic_ref);
>   int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref,
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 1834a6ec12bd..4f85c435b793 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -2574,7 +2574,7 @@ static int clean_log_buffer(struct btrfs_trans_han=
dle *trans,
>   	btrfs_tree_unlock(eb);
>
>   	if (trans) {
> -		ret =3D btrfs_pin_reserved_extent(trans, eb->start, eb->len);
> +		ret =3D btrfs_pin_reserved_extent(trans, eb);
>   		if (ret)
>   			return ret;
>   		btrfs_redirty_list_add(trans->transaction, eb);
