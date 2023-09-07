Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61679797F76
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 01:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbjIGX6A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 19:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjIGX6A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 19:58:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA919D
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 16:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1694131073; x=1694735873; i=quwenruo.btrfs@gmx.com;
 bh=fWsQa3lAIYPirmOcOCkJtw1uZwBCVnAJeNPusU3CWEg=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=FPHT4pFwSsY5aBJkZwY8V+gAmTy+NEORmxfASou4Q4mrOOTJVVdoq3iGtzL4t7JwV5m7BF6
 SslDQpRIO/fsifdJr2fsgPHNULKLVP7Nf80MTajUo05TT3xMMZJJ4d0Egf9WGeIChRh5Mspjc
 JyJCXiGISvyaQZnxq7YcuyvCixNSl1SqeBNB8FvTXV0ZpvvzHWJROoiyispqFYCkAdlZFg8Ca
 J15ndyAvF+05re4B7j5QInYjUNiKWJSIIk9PhIvC6pINtemjAvaxkNfRs23AEoLAChEmZ6p92
 60bcC0uJ0T9wdQ/j2lMKIhrobNMJ/PZ7KOzR6FYDiI4ziN7yw3eQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N79yG-1pZMwW2gUW-017R5q; Fri, 08
 Sep 2023 01:57:53 +0200
Message-ID: <47803cc6-1408-43cd-9190-1690d4af394c@gmx.com>
Date:   Fri, 8 Sep 2023 07:57:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] btrfs: reduce parameters of
 btrfs_pin_extent_for_log_replay
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1694126893.git.dsterba@suse.com>
 <579a7f7e44703c87aa64a253e6f4c14b4bde8c24.1694126893.git.dsterba@suse.com>
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
In-Reply-To: <579a7f7e44703c87aa64a253e6f4c14b4bde8c24.1694126893.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:esNDXfz30Mn7C03NvF5DmzDcMMq4tz5y2PQeaOGUjtyE5qWKNKw
 AD3czfG5zw4dD4gqHWhwYfTlbDpGNgvYUXjncgywa+H/BbpfpjC1Eem1mZ2oFw43Itnw0IO
 npXhQs6NWkTfCZhadfZKYjcxGqQRv2pz2PZUmpoVpk+lfnjoZcI+XllrLzjdrzJAhdnwzVA
 6OF5us9ghWN/mY272SLjw==
UI-OutboundReport: notjunk:1;M01:P0:nYkWjP4pIf8=;/Hk64pXxJKi1NAHSOzDGdcWaeNs
 eb9qUGBlLc8RfI5C/no2bq9yw2tgiTzyb7ND8u+b9rO5jzRWU5APszQs9BEyUQWgHSWf2yxga
 D7B9u+eiSQPvzk+3cwCMol0QXnYnWVZqJofHyjcUuLBXLi4KDxSr47qERXlSpnbHCfBKl4KNG
 0mkbicWFXr206lq37ZLgC04AiRiju6flf3crMQXynOdl+w/SHwFR8qogGoK72MdEKdlStY1cB
 yeIRnsu6Y9q7m/TNf+VrZiV4VgUPV5gNWuzaUrQesgACk9xo7x1N8YFs6kcxXkZJVV1XFkzus
 wIGn1bImCTLFNGLjV5QJKcQHSxFLtJnlejHP0FqAySbxmQDO5a4uPTsKexZaA9tkH85Kihg1J
 llIZtdmuh3KnSeT+0ti0xNmLD/3NMBdaW8eHmJk2Cbq6TqezaxdJzho7UUptqwh/yxBzY41+N
 2DWQ11vql5Q6GJL0j38q9OOewKtebgXWBHvz2rj3NJtoxaf/MWandHGLCAFSGOyDg7grBLDSe
 2SxGVg6JfqShcIVd06g9MnSGuQ7ZQ7wABBkwFOUeytvdNVcwV0CFvrUCKetAN2nqeuigjV2K9
 dU69TsP/Z4h3YpK/kqc+pTexmGg+0yYPGwcAknB+SehR+mi0duCDZOLf/1VKldIOi2UvAJqSh
 YSOugRwn2LHEjJolCron2eSxEyii6L0YjQ6gyp/9cBcuNC7/A8gdxOhX5SugBH5Y1Nn9Meyev
 5yH828Pk1Q2bviZvQRg+c5mg0ZjblPZ1YrkPPsVDTRyEqRvCEy3Ms8Xnm6YiGUJllplzZuxyz
 5ZuZin9EwFt7BY1SRbRFv1B7vcXr/5oG8AwIPMAuEYJwvaiN2h3oljmzbrdgnV2ggnreg5cCA
 rDthtR138eL8GGfaBh0teD88ZXUOQwd9wfeqFi0CQj5FtxAelo4sONNXGU1H6mzSS9r38Dy24
 4xWwFxCP+BR5Qpir2vTJDF/bC+s=
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
> Both callers of btrfs_pin_extent_for_log_replay expand the parameters to
> extent buffer members. We can simply pass the extent buffer instead.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent-tree.c | 8 ++++----
>   fs/btrfs/extent-tree.h | 2 +-
>   fs/btrfs/tree-log.c    | 7 ++-----
>   3 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 98d97c97ab8c..3e46bb4cc957 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2567,12 +2567,12 @@ int btrfs_pin_extent(struct btrfs_trans_handle *=
trans,
>    * this function must be called within transaction
>    */
>   int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
> -				    u64 bytenr, u64 num_bytes)
> +				    const struct extent_buffer *eb)
>   {
>   	struct btrfs_block_group *cache;
>   	int ret;
>
> -	cache =3D btrfs_lookup_block_group(trans->fs_info, bytenr);
> +	cache =3D btrfs_lookup_block_group(trans->fs_info, eb->start);
>   	if (!cache)
>   		return -EINVAL;
>
> @@ -2584,10 +2584,10 @@ int btrfs_pin_extent_for_log_replay(struct btrfs=
_trans_handle *trans,
>   	if (ret)
>   		goto out;
>
> -	pin_down_extent(trans, cache, bytenr, num_bytes, 0);
> +	pin_down_extent(trans, cache, eb->start, eb->len, 0);
>
>   	/* remove us from the free space cache (if we're there at all) */
> -	ret =3D btrfs_remove_free_space(cache, bytenr, num_bytes);
> +	ret =3D btrfs_remove_free_space(cache, eb->start, eb->len);
>   out:
>   	btrfs_put_block_group(cache);
>   	return ret;
> diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
> index c56f616dcd1b..dd31ee85f360 100644
> --- a/fs/btrfs/extent-tree.h
> +++ b/fs/btrfs/extent-tree.h
> @@ -103,7 +103,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_hand=
le *trans,
>   int btrfs_pin_extent(struct btrfs_trans_handle *trans, u64 bytenr, u64=
 num,
>   		     int reserved);
>   int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
> -				    u64 bytenr, u64 num_bytes);
> +				    const struct extent_buffer *eb);
>   int btrfs_exclude_logged_extents(struct extent_buffer *eb);
>   int btrfs_cross_ref_exist(struct btrfs_root *root,
>   			  u64 objectid, u64 offset, u64 bytenr, bool strict,
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 4f85c435b793..15c8cb6627fe 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -347,8 +347,7 @@ static int process_one_buffer(struct btrfs_root *log=
,
>   	}
>
>   	if (wc->pin) {
> -		ret =3D btrfs_pin_extent_for_log_replay(wc->trans, eb->start,
> -						      eb->len);
> +		ret =3D btrfs_pin_extent_for_log_replay(wc->trans, eb);
>   		if (ret)
>   			return ret;
>
> @@ -7203,9 +7202,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log=
_root_tree)
>   			 * each subsequent pass.
>   			 */
>   			if (ret =3D=3D -ENOENT)
> -				ret =3D btrfs_pin_extent_for_log_replay(trans,
> -							log->node->start,
> -							log->node->len);
> +				ret =3D btrfs_pin_extent_for_log_replay(trans, log->node);
>   			btrfs_put_root(log);
>
>   			if (!ret)
