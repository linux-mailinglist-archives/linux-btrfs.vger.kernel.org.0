Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E0D7ABB94
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Sep 2023 00:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjIVWAU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 18:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjIVWAU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 18:00:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1427A7
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 15:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695420007; x=1696024807; i=quwenruo.btrfs@gmx.com;
 bh=EUaAhrmBv2/NcXEvtlpWDEpU6hjDEI8mD3E2rJOGhC4=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=YA9ee0NQnpyXsTEARrx7L5/DG10pfKkLsUQZ8cjBUILm4GSixVpw6FtwoZ35jiqIsFEYmoTrD7e
 zADQ3fmz9XpjhoQZTGjBiRzd4hrliGHnoCwOixnLmCiqSYS8TgvoEa11ucH7enFMNZ3ktPWHCDWNk
 NGW5oBQjZ/gRNNiZvcHS57hBoChrFYHA7+rdopik2TdIkjFrJ2yfhIwy6KRUoEYL0l0CjSQ7ohgLY
 YDxPxZA1J3MDp4TEXebmfYnpdYleu+coclX1egD8DwAX7n9X8TQX/PymjTgPy5n/b8ohiI11KhOLD
 ENxj4QDShkwfFalfvZ7R1kkmojth9Y6UtPvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McYCl-1rG6jz3GYf-00d07g; Sat, 23
 Sep 2023 00:00:07 +0200
Message-ID: <34127e44-7bc7-420d-8acf-ec0ab6598ddb@gmx.com>
Date:   Sat, 23 Sep 2023 07:30:03 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] btrfs: simplify error check condition at
 btrfs_dirty_inode()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1695333082.git.fdmanana@suse.com>
 <5d46b47eaa1ab5c82ad17cb4e3d59ddf9857ff4e.1695333082.git.fdmanana@suse.com>
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
In-Reply-To: <5d46b47eaa1ab5c82ad17cb4e3d59ddf9857ff4e.1695333082.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CRNyRyPwrBL/Wo+AIctDtEEiqDkPUNZkATxxg4zx3F5+S8nFXh0
 RG9Gu7m58mkkQpqR2Md6JR7EuFyd9M9rtfsVqgMwZlpE5ph/zrnbzNzkvp+wtuypiQTaquu
 Dd3K9mZIXIXHAoyPR3rFuuQ1DiWsbFIbnjM4oQ6yJ/Tk/1KHIMksI5POGexHeC8ABcd12Fh
 Bz1GeY662dkr2msI7b7Uw==
UI-OutboundReport: notjunk:1;M01:P0:yfTSPIa6M2A=;1oRlEAfep/t+wUvIja9lfk8JnRi
 9oFG0JpXJMR91ER9+T4PtP3wN+7+HwFeahcDSl7yzN5RP2psQdycDVP9hSE4McvE9VlKjkGRY
 iYI2or9Pj9dc26waCDMFUQ9bhvAFpshFvwmBmiLcNFutViJbOeQgVHKZhSNoktQAV/wlqJYAh
 m316qfDe8+IzFRV8EOWtzR0BRt+jO7+fN0+llR8u1iID2Qztu+qEv5U9oJPNWF2snLBQuGSju
 4t7TwsIfvIt3Fmsl7oLiZjEkXVMTqnlNC5KZKC8eNoJqlBQNP7mZvNLx1Iq9EQK24mdsa/crC
 Cv7GlwoOZAafpR9StmC77JBM/Qh2HY5h5S7c5jWb68N2/ztCodakurnPlFHEq4ex0DNln9G1G
 sDJtNYSTFmUlx+2zue5/gV77ob5UZyC7efe2Dmv91DZdyL/qylIaS7PMCq7IiQi+SLDxDintp
 7Cvq6uhdNGwMA0XT1Wc1PQdsKqDbyoRB6y64f6kBN5k3sfI52IGTf5MlGO+YSPjLXRweklDet
 CiKHnVpKYXYPjH6NmKqI111pX6FhJwFjk+dTZ58MarPSQ0p+A7pP99JUrenRwZ9m16cVf2GK2
 Ny/QW04+TkSTCTxtG9DWlDxT/eoA5pMcrzbDAGZC/07XaQkZtvyEYBj83aidBmEFuOa8faeaN
 dyVmTtw40ylrtXUY4AzqUOw/OK1uKbITNCL+tfkis0d4UxCoNBlJNZM2ecHkVHSgawmQHXlkN
 cBQ/JjcKcdHaAi7RgQhYN6tK78TvFM7Qw3Ls3M3Rv4g1VDTUMStbckF7rov/+PGMfDVndAW0B
 zEY8dDhJl+hyHNjS4ITVkADLhcp0C8WxUlsNaM8Tg6Nc21EhaH12j1/x5aYSBRzU7OPAlrpJJ
 qQuLLvXSccGjlDwEeiSdv+wP8hSnlz0qPk1uXktoZcPUS8FVNxRjIImBnQUdIj93mv50Qd+n9
 cuw41a1GQsKzNdrYefnrRyC0MGs=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/22 20:07, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> The following condition at btrfs_dirty_inode() is redundant:
>
>    if (ret && (ret =3D=3D -ENOSPC || ret =3D=3D -EDQUOT))
>
> The first check for a non-zero 'ret' value is pointless, we can simplify
> this to simply:
>
>    if (ret =3D=3D -ENOSPC || ret =3D=3D -EDQUOT)
>
> Not only this makes it easier to read, it also slightly reduces the text
> size of the btrfs kernel module:
>
>    $ size fs/btrfs/btrfs.ko.before
>       text	   data	    bss	    dec	    hex	filename
>    1641400	 168265	  16864	1826529	 1bdee1	fs/btrfs/btrfs.ko.before
>
>    $ size fs/btrfs/btrfs.ko.after
>       text	   data	    bss	    dec	    hex	filename
>    1641224	 168181	  16864	1826269	 1bdddd	fs/btrfs/btrfs.ko.after
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

A little surprised that compiler didn't optimize it out.

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 514d2e8a4f52..f16dfeabeaf0 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6011,7 +6011,7 @@ static int btrfs_dirty_inode(struct btrfs_inode *i=
node)
>   		return PTR_ERR(trans);
>
>   	ret =3D btrfs_update_inode(trans, root, inode);
> -	if (ret && (ret =3D=3D -ENOSPC || ret =3D=3D -EDQUOT)) {
> +	if (ret =3D=3D -ENOSPC || ret =3D=3D -EDQUOT) {
>   		/* whoops, lets try again with the full transaction */
>   		btrfs_end_transaction(trans);
>   		trans =3D btrfs_start_transaction(root, 1);
