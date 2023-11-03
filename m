Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1191E7E0ABB
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 22:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjKCVfC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Nov 2023 17:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjKCVfB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Nov 2023 17:35:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1282FD6F;
        Fri,  3 Nov 2023 14:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1699047295; x=1699652095; i=quwenruo.btrfs@gmx.com;
        bh=6zfPfsbIV8uj//Kdxf/OpBlrQGJWhE6O9YYGw0R1xy8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=eraUVuOXlXy0ydi/UvgJ3jsNK4Hi8h7Tzdnvau6zgUEl/Qz15CKqY1hHAYNauJnv
         YZLU2JAhjgrtJT4HN5qo0tYqME61uHJqQkHwwTh1aVEKFdxAPmsyQK2JgW2W3D4B/
         nigscjINals1iP43KmkLvYmlIkTlQUJoNwSOeqbiyRdIQIB0xWkSaJgx5MZpQAAEL
         cR02f40PkN90Zgvl0RHdGOHPqfQANuD6KELvSQdlE77bgNtNwnsYUcpAU0bf9dq1+
         kDhahVMKf33FmcyDtYP8JYYjvmiCHQ4rXUim5fdx2xPFuKhAVBdttogM2RBFdzFSM
         BVYlQfj9g9nDMNJv0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MCbIn-1r845d12wN-009fAz; Fri, 03
 Nov 2023 22:34:54 +0100
Message-ID: <44e0572b-d20c-4605-b92b-e16ec607604a@gmx.com>
Date:   Sat, 4 Nov 2023 08:04:50 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: require no compression for generic/352
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <0c1f1f4f5606a7e8847e188c24561e24e104ed42.1699040020.git.josef@toxicpanda.com>
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
In-Reply-To: <0c1f1f4f5606a7e8847e188c24561e24e104ed42.1699040020.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gfh3XEA222JWd8j5IUeDjvTrCeg8SjSR23TqkXWkkMhvEiKGI1l
 dJ/O1ndG0C4GdVQivh5A+Wp15e/rvMr6sK/9XnYKXIwtILyThYYZSeQrw48N1aiMWcAyFd8
 3MEGnBDPdQEej2hJTwZj3SfMV+yGghRT+N1ZN3USJ31R3m4pwaGtPNGsidiI7bHWmd957Nv
 8k0tBPUhQEqrGnDZ5Yopw==
UI-OutboundReport: notjunk:1;M01:P0:2OLUbh4699w=;BTozvSwj1aihKHFk4n6s32BX5p3
 oa7JR/EgrGlGTgIo6nSAWBwlJ+8twkNDcIga1vIO38NFFRfMqTrPIs4mSqA9vGjtuLo6NUaMc
 tUBxlV6aSl8sS4saR5SzA4NiQs3OUY4ThHDKZlvIYS0u3+U0WESznJ5DWaSV9D4XoHhEhtswP
 Q+oi7h5ivTHsLqmFE61zKu5eIgjFahDGeyO2HgkcfmcNgeizbl7rwCn1Yj8Qw6nSzBODO2NAp
 mOjH/7O3PpWBxFXeiEJuVXMvN+7CeVoSIYP/feL8p5w/00977s412BDaCFdTWQ1FpbeikJaYL
 rCTJMR/9BPwTA3wonUjXWGiScP8vUdMxhN2GbcbFgGeNvzumbINQco+2mWxL8PCGA+QChsHTA
 mu2xzmODArnuDGr3JUs0vmPZIkQjhZVh/J1e1K50/wVPR+B14aw6FGdGnms615tOCQseCq+TE
 Xgp9WaQUNuXnNOQOT0GnQqtv6nXxbgKVke0pGbDLiec31zEtdmlOXmeLgX5JnMdqm3UV9BgRq
 xPX+qoExnlRvYKCIMnVk9HGbHp7f+AlmRMjHmrAIzVJAknzD8AHr46FGHDANEE/8wJVtnz9fW
 cmUlUMDJUCENj1Vhm0afto5y72vA52St1Y0GGtwN7A0xopGH/2WmR46xNHJTF01wgaqi1kspe
 LoTrRbgQVq0COa+5tw9JKlQ4HX+WHSD1eo7p8LcetOfH7xu8dWdqYtEoaZvPlFL9GF8eLYzxq
 H6RieAJTOqh6LxyDmIznXRY+VffTxECOc9QgrDqkSl8WVRRdAEqJ+tcm791mAqA0RGds0Obgh
 TKnaPKEq+1xjypdaKDvBNeNtdAQJ3kUv3xvNBYaJRamHESI7Pmvkv+PokO3FMO9wh99pRogjh
 ovG5Br1374Q5QPTGpzqRwYHpWyobHu15eMSplw2Q2zT0YvioUwiVfsdM53awbfDJoKfd2mwhz
 xHKTBhe0++SvI9+jk/beLrjBDBE=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/11/4 06:03, Josef Bacik wrote:
> Our CI has been failing on this test for compression since 0fc226e7
> ("fstests: generic/352 should accomodate other pwrite behaviors").  This
> is because we changed the size of the initial write down to 4k, and we
> write a repeatable pattern.  With compression on btrfs this results in
> an inline extent, and when you reflink an inline extent this just turns
> it into full on copies instead of a reflink.
>
> As this isn't a bug with compression, it's just not well aligned with
> how compression interacts with the allocation of space, simply exclude
> this test from running when you have compression enabled.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   tests/generic/352 | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/tests/generic/352 b/tests/generic/352
> index acc17dac..3a18f076 100755
> --- a/tests/generic/352
> +++ b/tests/generic/352
> @@ -25,6 +25,10 @@ _supported_fs generic
>   _require_scratch_reflink
>   _require_xfs_io_command "fiemap"
>
> +# The size is too small, this will result in an inline extent and then =
reflink
> +# will simply be a copy on btrfs, so exclude compression.
> + _require_no_compress
> +
>   _scratch_mkfs > /dev/null 2>&1
>   _scratch_mount
>
