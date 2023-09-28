Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221AC7B152C
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 09:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjI1Hkl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 03:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjI1Hkk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 03:40:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD91196;
        Thu, 28 Sep 2023 00:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695886829; x=1696491629; i=quwenruo.btrfs@gmx.com;
 bh=3pratlt3UEo0JoEnCEEX3XccHQki+VOIBSy6aKzv3vE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=RJNPYQB6jxFrvhNyKR/WcvgXHvKC6vW0pSNi1ToAbyG7Ue5MREiYAlCBmvJ8SHRZk4PBC+KXm8d
 1nkolhQNlp8LKIlNdbwuZUTEataMehZRL5r1etZWFRImolpC8Ebf5g7fSQ94HnpeMJvmI0qja62nL
 TE3TeOWibZKF5hXZi3gg2Sjk9VmJp/Wt9QTSjYTz5fpr3HjU3oEil+wYU6h+fKX9qW9geP1HNasDQ
 jPcLw7st+Cvjr+Vs4I9+zvx0Hjo6SN5PkKVI9UhOqDI3HthVJqhGfMbv3yYfr3BjZR+N6yKkrQuJW
 HVM4jbPAUHVrDvm55jqP2kxJ2MQhi+XWUWrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.112.26] ([173.244.62.10]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuDXp-1rda2T3UMP-00ucc7; Thu, 28
 Sep 2023 09:40:29 +0200
Message-ID: <0a8d40fc-501e-4d85-903a-83d9b3508bf5@gmx.com>
Date:   Thu, 28 Sep 2023 17:10:25 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fstests: add configuration option for executing post
 mkfs commands
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com
References: <cover.1695543976.git.anand.jain@oracle.com>
 <eff4da60fe7a6ce56851d5fc706b5f2f2d772c56.1695543976.git.anand.jain@oracle.com>
 <dfc4cece-d809-4b5b-93f7-7251ba3a492a@gmx.com>
 <5485cd32-2308-c9c5-4c97-9ff6c74c64dd@oracle.com>
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
In-Reply-To: <5485cd32-2308-c9c5-4c97-9ff6c74c64dd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:14eEXJBEldyYslrdbXjk4ckt8R19p6JpRcuChX85l7FEguvbwrQ
 gHlformwJge35EpMr5cM0HAFNGCa0FF3naQolZHJu4N+F//7h7E0ToKXkWEPWrYkTCoLoLO
 MjwkoWS2lJitoFfMWyBDJZlfkkQDW1ppfuZe6l2+ziQbTawtSwnF6lvznUQwHFWmEplZvz/
 JFcAtZzxlrmT8gU+IEdaA==
UI-OutboundReport: notjunk:1;M01:P0:4el7K4idEpM=;lSHh4kR9Ej4k0e70RRCL2sBcV7G
 c+a86mFIrXXCErupJo7/fEVG1/1tHn3pclO3WTPmtZWJyIzmevSiglGvsQ45EXysPbV2IedzH
 9du0NJww1cczNuN9yegFy3YUsAbS9ZcKVRNC36CXDYFZDCN9cCEMeRiCm0g1/4KhW6K21StgC
 uwSPTECKI4+Ba3FUueUPZVNgdYnYMGol4LrxuYokKrUJA+mBiAdRYWelIVU8TgrhxyPV0iQqK
 D0US36WTlJ01UgOOkbQe9jLvKbjV7OCte/nvGfHdmBKVBowrUY2Ulk4x1lNUi08bJf4iUSxu0
 mXtDKDiekvvEP1wyrwWi2CI6r/gMnu5kqxH+uC1PZVdJetkvFW+FRbeFpP8qYN/iec4PrBhSc
 Y+OJ/+z1ZbKilVHBay3xJxyUQcZtAE/sfKRSQs9h8Yw7BdedzJCCkGybfcneVQSWgbbSeGCvg
 8BRk6ftGSM9COPFnGz/t+fZYbDlHZ9OFi5engDnlJFLbISv0SFZn1csqtoZNBcy0uAsNN0mUt
 RzCLxb+ZYBlf0JsY3/EmovMZ4q8hviY/mLMmdZ12/ALlMkoB0mUhR9jojLGMSJZdYWjwYxQdb
 5f7Ef1lfijtN5Iy62Pl3ZG5KD5bpv/3S3tpEiGQX1falycrwMV8G7jXz3janP+cDKdISO+wOI
 QPHG02tCfAlImydR3qce9GhPC8ji+VWekhkkltEpof0cHogU7HlMasFcDfmqB6oARxEsGQrSJ
 Pr9V+DvQpEqXrp/D29jD+z1ZYJBacrGTgj8WAzj6iQegrGVBzmVDOP4z47A7ZOVuV1y8hzEsi
 rhKs8qnqKLjywT0neXusvq7VBdHxLk+aKgpfjc36atR9PABDjLpLcuYD7G5wrMb/VP5GE3NPa
 3pimQVJq2z0Tbq8FKGdjsaeUkI6YHgUqQr3zi2qZbHkxdOttlN8hvZmWS8cQRhaHQE78JL1Xg
 gAxmyZxDMO4fJjmJ1JCLDD+9wd8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/28 15:04, Anand Jain wrote:
>
>
> On 28/09/2023 12:26, Qu Wenruo wrote:
>>
>>
>> On 2023/9/28 13:53, Anand Jain wrote:
>>> This patch introduces new configuration file parameters,
>>> POST_SCRATCH_MKFS_CMD and POST_SCRATCH_POOL_MKFS_CMD.
>>>
>>> Usage example:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 POST_SCRATCH_MKFS_CMD=
=3D"btrfstune -m"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 POST_SCRATCH_POOL_MKF=
S_CMD=3D"btrfstune -m"
>>
>> Can't we add extra options for mkfs.btrfs to support metadata uuid at
>> mkfs time?
>>
>> We already support quota and all other features, I think it would be
>> much easier to implement metadata_uuid inside mkfs.
>>
>> If this feature is only for metadata_uuid, then I really prefer to do i=
t
>> inside mkfs.btrfs.
>
> Thanks for the comments.
>
> The use of btrfstune -m is just an example; any other command,
> function, or script can be assigned to the variable POST_SCRATCH_xx.

The last time I tried something like this, I got strong objection from
some guy in the XFS community.

Just good luck if you can have a better chance.

>
> Now, regarding updating mkfs.btrfs with the btrfstune -m feature,
> why not? It simplifies testing. However, can we identify a use case
> other than testing?

For consistency, I believe all (at the ones we can enable) features
should have a mkfs equivalent at least.

(And can get around the the test limitations for sure)

Thanks,
Qu
>
> Thanks, Anand
>
>>
>> Thanks,
>> Qu
>>>
>>> With this configuration option, test cases using _scratch_mkfs(),
>>> scratch_pool_mkfs(), or _scratch_mkfs_sized() will run the above
>>> set value after the mkfs operation.
>>>
>>> Other mkfs functions, such as _mkfs_dev(), are not connected to the
>>> POST_SCRATCH_MKFS_CMD.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> =C2=A0 common/btrfs | 35 +++++++++++++++++++++++++++++++++++
>>> =C2=A0 1 file changed, 35 insertions(+)
>>>
>>> diff --git a/common/btrfs b/common/btrfs
>>> index 798c899f6233..b0972e882c7c 100644
>>> --- a/common/btrfs
>>> +++ b/common/btrfs
>>> @@ -690,17 +690,48 @@ _require_btrfs_scratch_logical_resolve_v2()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _scratch_unmount
>>> =C2=A0 }
>>>
>>> +post_scratch_mkfs_cmd()
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 if [[ -v POST_SCRATCH_MKFS_CMD ]]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "$POST_SCRATCH_MKFS_C=
MD $SCRATCH_DEV"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $POST_SCRATCH_MKFS_CMD $SC=
RATCH_DEV
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return $?
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0
>>> +}
>>> +
>>> +post_scratch_pool_mkfs_cmd()
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 if [[ -v POST_SCRATCH_POOL_MKFS_CMD ]]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "$POST_SCRATCH_POOL_M=
KFS_CMD $SCRATCH_DEV_POOL"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $POST_SCRATCH_POOL_MKFS_CM=
D $SCRATCH_DEV_POOL
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return $?
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0
>>> +}
>>> +
>>> =C2=A0 _scratch_mkfs_retry_btrfs()
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # _scratch_do_mkfs() may retry mkfs wit=
hout $MKFS_OPTIONS
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _scratch_do_mkfs "$MKFS_BTRFS_PROG" "ca=
t" $*
>>>
>>> +=C2=A0=C2=A0=C2=A0 if [[ $? =3D=3D 0 ]]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 post_scratch_mkfs_cmd
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return $?
>>> =C2=A0 }
>>>
>>> =C2=A0 _scratch_mkfs_btrfs()
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_o=
pt -b $fssize $SCRATCH_DEV
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if [[ $? =3D=3D 0 ]]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 post_scratch_mkfs_cmd
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return $?
>>> =C2=A0 }
>>>
>>> @@ -708,5 +739,9 @@ _scratch_pool_mkfs_btrfs()
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRA=
TCH_DEV_POOL
>>>
>>> +=C2=A0=C2=A0=C2=A0 if [[ $? =3D=3D 0 ]]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 post_scratch_pool_mkfs_cmd
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return $?
>>> =C2=A0 }
