Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F6F7B798F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 10:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbjJDIHM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 04:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjJDIHM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 04:07:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7870183;
        Wed,  4 Oct 2023 01:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1696406821; x=1697011621; i=quwenruo.btrfs@gmx.com;
 bh=Dg4+f8T1b5xuQWELdWHF6gUguPOne4D1W+nJb4+6L54=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=CcMcHiSnBz9VPjMM5CARvuDLDN20iAj3MvCdWo3gZw+Adrt49DmeMY5upLNvqQYTy0EFuQ36pHJ
 tSpJeQxzJNKQuc68xyR18hxeTV8EnAnlI8WZhMDUuq3MZsc59yNOxezsMIJuBxERhOMT2kMoZqFQp
 EV3bmYgpr7/kZ2GZKTfpyP6B0QwaYOSEDNzynb4cGdktdijRluWovccXGewrmS873gy9aBxTYSxFf
 0QcsjeYJa15a885YpXJPGVQDtHETFKFIpZ50RsliPeQIg41LIY96x6kr8WhZUP55IzASK211a1CqK
 K6sqEtOtIpA8ZwfCDqB4X7cxlNkqdl/jCvPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mirna-1rHlQ02B64-00esWN; Wed, 04
 Oct 2023 10:07:01 +0200
Message-ID: <1ce41890-e4f8-43dd-9a1c-23b2b0912349@gmx.com>
Date:   Wed, 4 Oct 2023 18:36:56 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fstests: make some tests that use fsstress easier to
 debug
Content-Language: en-US
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1696333874.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1696333874.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2t6g5KgXFVmmiGAaUzjkjezr418f2ymRrTRV+cuJRKXJ8UJH6vq
 wliNFJoV4n0Hxh39A0z1dwwcXqLU4cS7u8F8h+PgI9NShOz8AWz8Roz2MIIT8DSBV0cLPpU
 9hYfWshUyRYGI4rCNTllTvXCDJIDjnmeCSaXclNpXJyyV8iuBBobKzGwxUEF6ERpMq4+lpZ
 f4VaWGq64fpzJD7dizu0w==
UI-OutboundReport: notjunk:1;M01:P0:exZZf2Kxiz8=;Z0Q/YbJiXUtzxIuOuqK9bo+uJp3
 ZeBMmohX0h6boGJaIVoL5DQh8h+xDLJ6ku/8fXfP8wm739DwacCD6E0jzYBu0jjgHNrSkY/Eq
 fqTgCvLDHIHTV0+0M0HwvaPIMD8seVx19GnDJalLSusiSgDIqpd8pj7dJzmpvxoU8YdW+ghs1
 XmFZlTWzzrGbpbDHZ3PVOzZh1NQd4C9jl0AdqTCoMdkzfTJvQmWWaglpWLT8ZYCPinrfTdet7
 RcR4OFC+OuUg15LodZPi3IRQJ0NXcahTTLGNCrhvZwp8IlZb6hdxvuwEUWquXsexeVQpxKexm
 JxdJWLbu5sHlOGExSSwJfde2TfkHlnc8noYivk1qGhNDksUPsGUXzZTg2AoAcuc5At/UzwWhR
 MeB3l1+n4KeeHciDzbc8thsEK1rXkxJtZtk8HPVt1V2G6xe77R5wNOTHOJb+AbzsFEyU3b5tA
 QkYv7JotMO9ELSp2DZnkyIMPSFu4YTt9rXWJSTVoQmdSSBq/kQRWO+kfE1/DJKMdF7Ye9MruT
 whYsxmojlhn/S8yK2SFGeBcuPC4apeoNSphwP17LmYPgmDxXLXFECN6JqXZAVt8rNfCMD/dUB
 /Ws5zuB9YPwIahh0Hw4ZtEmaM4Je6ep+LHFWW0791fQuG/G/zpFl2EF2hlLeK/xxtcJ56jGiE
 SRm31N/b9huZWI0n/mStg34cTEOZWll5c7qInjQVJNT4DpwIy/VtZERoKExmKw+8aIuczcqEP
 Ck7YbnFhmKkfgW4Tr3tmwuuLZtu+/atMUE5nNzWgaDpNQblMFoa/IqID7wdp8RDvbsQadvOR0
 NBP6Y/LDAAL2wZ7ZhSSL6pvsXNsFXyKH6F6tlXp0TFuVptVCr8/KGTh7j3g/PcVfAiUNhraH8
 z4X7urBWv9iom5GBbM/vL/UrDGg76/81cUxnZTrMNOc/llJdd68jajZ1Nl5Jc+mz+inxD5rUc
 Rk39YyIQnOtYQBcTkCQENYYhye0=
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



On 2023/10/3 22:27, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> Some tests that use fsstress are harder to debug than necessary because =
they
> redirect fsstress' stdout to /dev/null instead of $seqres.full. This mea=
ns we
> have no way of knowing the seed used by fsstress which often helps to tr=
igger
> a bug/failure. More details on the change logs of each patch.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>
> Filipe Manana (2):
>    fstests: redirect fsstress' stdout to $seqres.full instead of /dev/nu=
ll
>    btrfs/192: use append operator to output log replay results to $seqre=
s.full
>
>   tests/btrfs/028   | 2 +-
>   tests/btrfs/049   | 2 +-
>   tests/btrfs/060   | 2 +-
>   tests/btrfs/061   | 2 +-
>   tests/btrfs/062   | 2 +-
>   tests/btrfs/063   | 2 +-
>   tests/btrfs/064   | 2 +-
>   tests/btrfs/065   | 2 +-
>   tests/btrfs/066   | 2 +-
>   tests/btrfs/067   | 2 +-
>   tests/btrfs/068   | 2 +-
>   tests/btrfs/069   | 2 +-
>   tests/btrfs/070   | 2 +-
>   tests/btrfs/071   | 2 +-
>   tests/btrfs/072   | 2 +-
>   tests/btrfs/073   | 2 +-
>   tests/btrfs/074   | 2 +-
>   tests/btrfs/136   | 2 +-
>   tests/btrfs/192   | 4 ++--
>   tests/btrfs/232   | 2 +-
>   tests/btrfs/261   | 2 +-
>   tests/btrfs/286   | 2 +-
>   tests/ext4/057    | 2 +-
>   tests/ext4/307    | 2 +-
>   tests/generic/068 | 2 +-
>   tests/generic/269 | 2 +-
>   tests/generic/409 | 2 +-
>   tests/generic/410 | 2 +-
>   tests/generic/411 | 2 +-
>   tests/generic/589 | 2 +-
>   tests/xfs/051     | 2 +-
>   tests/xfs/057     | 2 +-
>   tests/xfs/297     | 2 +-
>   tests/xfs/305     | 2 +-
>   tests/xfs/538     | 2 +-
>   35 files changed, 36 insertions(+), 36 deletions(-)
>
