Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DAE7DFC15
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 22:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377417AbjKBVrd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 17:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKBVrc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 17:47:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588AF187
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1698961641; x=1699566441; i=quwenruo.btrfs@gmx.com;
        bh=W7qNv+fZBrtMV1D2BFiywBrQwm82+UCmWS/TxIJA5M8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=q3jBs7xqZmAf3ki8WeQrODBahdlQWKPns6HFl+9RJ8OcyzyHR/6QZ9fvfRty3xg2
         OeHTBtkvTh4/Po63YX6GdtHMMM/jGTB8aVJm4moffO4ZhuE7PePGanCrlWtF9u751
         AiSyx53iWmGf+pIPtk3jwlYKjaWIsD519G/+owecTFMwilpdZZvYd80KR/nrVeZGa
         fXxSsePYOYnEkwlcc5uAEqm1yuswDozrUVl5qt2GjbVJpBXEC6s2nVZx18W/WVaBf
         +CzX8hTLG7d+J4iIeM10JEtlq0eplzsVplyNKOQNUIenm3eH0MFdvrhgTFef51eBR
         LBK328JmxFjpLyRzQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4hvR-1rP2VS03mx-011iwP; Thu, 02
 Nov 2023 22:47:21 +0100
Message-ID: <751b2c6a-98dc-4fd4-b0c5-9ae8779f35e2@gmx.com>
Date:   Fri, 3 Nov 2023 08:17:17 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tree-checker: add type and sequence check for
 inline backrefs
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
 <20231102190720.GA113907@zen.localdomain>
 <d69a339c-0cc2-4168-ac90-f6c1b91517b4@gmx.com>
 <20231102203529.GA119621@zen.localdomain>
 <12595173-fdc6-4e49-9e37-e97a6b7e8606@gmx.com>
 <20231102213430.GA123227@zen.localdomain>
 <1035a27a-a1a9-492b-8d4d-3634367fece8@gmx.com>
 <20231102214627.GA123395@zen.localdomain>
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
In-Reply-To: <20231102214627.GA123395@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6vljWR2D6Ri2ewerBLTu9EYN65Nzzy2ZZFcphCiu2Z6spmumO6I
 lFF7wo+sjf643PCyDIDgs6ek6ujanCBr4LCtrw66zJnv2hQv3zWE+njBgkZmSIVrrCyLIAG
 Ny+xjVcy7bwHJyEFYyyeegc72wIn1eCzqHhldHuUv+jI+fBF2sYaB63OPKKeeAtOmRIVhUZ
 71Ajz4ERrLpJp/09htLOw==
UI-OutboundReport: notjunk:1;M01:P0:yO8g23Nn6Tc=;4bVMlI+x44i24CAyR8d2CKs8kS0
 CszYWlUsfJId1iVj8quZZ2ooCdzC2x4vUrbr3KQU9EatZpB8rK0Cb6+F+md8ekBNlNkT97rCV
 EVLk3JA1Env9Gg4c4LDLQUlaTVm/pi3XtUtpg3unBCqr7XySu0hrVnCglLeS3sxYmp8sUveuD
 3N5rLhwgOKs8BpKTdIVSTDRAgy6cXp9ofOsvpGeh+nG26gnkAYPHWvGX5fOHwRTJjMU+REVhG
 ULmV2LW63rYUkqAD2snKBEE5XC8oB2gzq1YHXl40Og+FnlGTMHshZzzT/m03qb4V0yvMCWWI0
 WiQrMu5L0b21QB8Axl5UvwMG8fSNm/DuCi9gq8r97GQJlFXAa4lLPb7M34P16fdd68SyQsd6n
 86jZeirgx23pD1dwibR5taWdqIrWdbfSyDYLoO4lls+7dxll5rwuI9AIJey4rhtINWPD3Jc40
 eCLzc/xMOzDkbs407tpNHFe/7ix/biS7ti5oparmLbLf0kXuMXzkjgtLl9x54XcBDPs0PJhgs
 erLw700+xI6TIQsyHRPyZhbTxo3u83vP5YB9mjGZZzrvWmGQm8DeEPMCX/f6ejk5O+wjvJmVZ
 IKDvbECjwzAMNuNzyvQVE15wdLDc3a95Vfp3fleydJ9OsBWvk0v/lanTj4In2fd4lTBcym9lg
 GRzDv4VNPAC67eatsQKLHR4WfHXG1VDBXP55P5kMN6PMJIndX1apdsPcPTV7Es0iDQhQbgBdW
 vEArM/uGBusnKcx01XU60kSsQdgtJ6eRl+NK8Myy7VS0AutnmsE2PUDuJ1Wdq8uxiISzHI70L
 l1K2hRXC9RoNb3OTQK+suGyB8rGYK5IhQTx0tCLj4zQgxPEzpltOLT/YJaRjn+jVSoAsup72B
 /+wwYkBL3Pz5o6344WyWN7+3x/aOSUot7UwL+vnw07BLOUiZVFq2cVuYBxFMl0SMkC810fNYz
 LylgDsvn72lyOU41+cAcTjR8Hgg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/11/3 08:16, Boris Burkov wrote:
> On Fri, Nov 03, 2023 at 08:09:10AM +1030, Qu Wenruo wrote:
>>
>>
>> On 2023/11/3 08:04, Boris Burkov wrote:
>> [...]
>>>>
>>>>
>>>> Another thing to mention is, that EXTENT_OWNER_REF seems to be inline=
d
>>>> only, has no keyed version.
>>>>
>>>> I have already come upon a rare corner case:
>>>>
>>>>     What if an EXTENT_ITEM is already so large that it can not add a =
new
>>>>     inline ref?
>>>>
>>>> I guess this can only be a problem for converting, as for now squota =
can
>>>> only be enabled at mkfs time, thus the new EXTENT_OWNER_REF can alway=
s
>>>> be inlined.
>>>
>>> It's a good point, but the answer is slightly subtler. You can enable
>>> squota on a live fs, it just doesn't/can't do the O(extents)
>>> conversion for existing extents. The owner ref is created for all *new=
*
>>> extent items, but when creating an extent item, you dictate the item
>>> size which leaves enough room for the inline refs (including the owner
>>> ref).
>>
>> Oh, that's way safer.
>>
>> Although I guess we may want btrfs-progs conversion support for an
>> unmounted btrfs in the future, in that case we may need to consider the
>> keyed version of EXTENT_OWNER_REF, to be able to handle an existing
>> large EXTENT_ITEM.
>
> I would love that, except I couldn't think of a way to do it while
> keeping the semantics of simple quotas, well.. simple :)
>
> We just don't know what subvol an extent is from post-hoc, so any
> conversion would be guessing. Reflinks are really opaque from this
> perspective (and the reason for needing this unpleasant format changing
> item at all).

Oh, indeed I didn't take this into consideration.

And it is indeed making simple quote complex, just forget this idea.

Thanks,
Qu
>
> I suppose "pick the first ref for conversion" could be reasonable and
> useful for some (all?) users.
>
> Current btrfstune for squotas just turns it on for the next mount
> without converting extents.
>
>>
>> And of course, for the sake of consistency (since all the existing 4
>> types all can be inlined or keyed).
>
> True.
>
>>
>> Thanks,
>> Qu
>>
>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> e.g., this works to fix it:
>>>>>
>>>>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>>>>> index 50fdc69fdddf..62150419c6d4 100644
>>>>> --- a/fs/btrfs/tree-checker.c
>>>>> +++ b/fs/btrfs/tree-checker.c
>>>>> @@ -1496,6 +1496,9 @@ static int check_extent_item(struct extent_buf=
fer *leaf,
>>>>>     				   inline_type);
>>>>>     			return -EUCLEAN;
>>>>>     		}
>>>>> +
>>>>> +		if (last_type =3D=3D BTRFS_EXTENT_OWNER_REF_KEY)
>>>>> +			goto next;
>>>>>     		if (inline_type < last_type) {
>>>>>     			extent_err(leaf, slot,
>>>>>     				   "inline ref out-of-order: has type %u, prev type %u",
>>>>> @@ -1512,6 +1515,7 @@ static int check_extent_item(struct extent_buf=
fer *leaf,
>>>>>     				   last_type, last_seq);
>>>>>     			return -EUCLEAN;
>>>>>     		}
>>>>> +next:
>>>>>     		last_type =3D inline_type;
>>>>>     		last_seq =3D seq;
>>>>>     		ptr +=3D btrfs_extent_inline_ref_size(inline_type);
>>>>>
>>>>>>
>>>>>> If so, can we fix it in the kernel first?
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>>
>>>>>>> For a repro, btrfs/301 (available in the master fstests branch) fa=
ils
>>>>>>> with the patch but passes without it.
