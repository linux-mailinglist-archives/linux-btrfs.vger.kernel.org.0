Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0097D8F18
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Oct 2023 09:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345316AbjJ0HBf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 03:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjJ0HBe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 03:01:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C846A1B5;
        Fri, 27 Oct 2023 00:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1698390066; x=1698994866; i=quwenruo.btrfs@gmx.com;
        bh=jTY0ckS0HdN8Bvzvb2jztSZgkTaU6GUui0+aPPXpxVk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=haWaw23YSscb3hyfI4QU6+SCqLznYwN8nyS5Y5gDeseF+ZO0nXLiSuN9RCm8bCU6
         9TibgxL2m1+2AqerTNaZutPAZr2SF71XV1UrdDiE+ZYWgGWYRYYFEu9xnj6/GGXy7
         55zUq8Nua3Lt9q+2HwrOyvqRVq+EBEcYZslcu2y6x/Sc44VgZx6meWgvADMqWRlhL
         3rBBbOnEnTAbHN+QaMUlmwPA9zD9xLcKsrnFA0wAQOIuGhm+b7+hqQmAiSZ3TZgAe
         6c5b3mN4tJE+8Y0gk9MbYYf+aNcQrpRDnX8BNwA/2/X5jTF7GvBw2EM9EJgHRo7gq
         h3eiNhYRfS6XrUTaZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([122.151.37.21]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4s0t-1qwYMA1YZD-00208K; Fri, 27
 Oct 2023 09:01:06 +0200
Message-ID: <b3cbb9a5-20d2-442d-82be-e5c129f4cf12@gmx.com>
Date:   Fri, 27 Oct 2023 17:30:58 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 211/285] btrfs: scrub: fix grouping of read IO
Content-Language: en-US
To:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Qu Wenruo <wqu@suse.com>, Sam James <sam@gentoo.org>,
        gregkh@linuxfoundation.org
Cc:     dsterba@suse.com, patches@lists.linux.dev, stable@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <87fs1x1p93.fsf@gentoo.org>
 <02e8fca0-43bd-ad60-6aec-6bcc74d594ee@applied-asynchrony.com>
 <740c38b1-60eb-41da-93e0-7d7671f0b3fc@suse.com>
 <f5299d83-cff0-df11-9775-f3d0adc5d998@applied-asynchrony.com>
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
In-Reply-To: <f5299d83-cff0-df11-9775-f3d0adc5d998@applied-asynchrony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5YMZXUse/s++bB+HW8g8cvkBXTSU3twtmTnE76kXpOshLCHwSBW
 lmCAfFLENFXdPINcDXUZcmquxG3AOKUpg+dyV/90lfjkug96BsR9tDFUmSQgmZzQ+s7ZeSK
 aHzatanjwc4h0xkDBn03nBUOvXrKVNWhiosLeUZugKQjXTozbHZ2gPJ4wrzRtAw5vobOiJf
 fhUMNn5gr+hhnIX8zBdFQ==
UI-OutboundReport: notjunk:1;M01:P0:shCDaDl2ew4=;cf9+PI7DZEfhmV9TNdh1SEL6+jC
 hVCPa3SiOTdma7SVlP3sweA/yDZBe3Z13ksLCg4zgMW2iDG8DHoSg/6f/+v1Jxunb0xinNmYf
 dRDXKK3JmnY/qn+3icM1WUYjfaJLmWR77lHnDVVH3C3OPT8lgY18PrzCjmuHmhWsf/8lFu+tH
 Hf7vWBP+0diWbdXv9yL1DGoc+2WFv1mi7O2j27o/jYfmsyK01mBrfi58bWStGtmJU+vW4h99Z
 FdGPKkMETL73RmCerB+oH3eUEvmFOtT76X5Ss7MuGQ1pAUz6/SyyKO847miohY01Qsnno9FRC
 HnXDApLpBqdLRJMRUAfGYZcll/dwSpBd0xOWYL65Q/keYuXhbHlEt3v8P8d43n83ofW+Z7Gae
 ukiP34UOgwxQhG0kVILeQ8/ILhkh1Ry6s4CjWUsAgaO/POkP5/GlpiX1huacgSX0adMrTKYYw
 9UMe2jHmJxOkgb96higJlLa4Jozf3WSy+hP+P7w1ec1aKS6I9qmq2DWiFLa8mTGCer/B/clWZ
 H8pZehwJ5v7wYd7Nh06okaEpZg5vs46rrdEd1oPvhNaEoQuHAsrIgqhQdZLNBAG8/B4D63XjG
 oavUa+4Parz2IzAtRIOIyuLueVtMRSf9gxMnzHlkQv/2hOsdmSpFCsTZSIFGsWh+6h7zI2mqU
 /ERLtfYayxYpVFrL1u9Tz/NyKK07+/EOGvuq0+N+nx/Rczp+paJf9CAh1mx0S5eLCF8gNvooY
 wQSzKHzytcQoNxPB6EV5ozssvtKgV2xViMJFnNXQTOAFI6Q4nlV+dlLicTeQdmfpvFRGowqpt
 bu
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



On 2023/10/27 17:25, Holger Hoffst=C3=A4tte wrote:
> On 2023-10-26 23:01, Qu Wenruo wrote:
>>
>>
>> On 2023/10/27 00:30, Holger Hoffst=C3=A4tte wrote:
>>> On 2023-10-26 15:31, Sam James wrote:
>>>> 'btrfs: scrub: fix grouping of read IO' seems to intorduce a
>>>> -Wmaybe-uninitialized warning (which becomes fatal with the kernel's
>>>> passed -Werror=3D...) with 6.5.9:
>>>>
>>>> ```
>>>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btr=
fs/scrub.c: In function =E2=80=98scrub_simple_mirror.isra=E2=80=99:
>>>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btr=
fs/scrub.c:2075:29: error: =E2=80=98found_logical=E2=80=99 may be used uni=
nitialized [-Werror=3Dmaybe-uninitialized[https://gcc.gnu.org/onlinedocs/g=
cc/Warning-Options.html#index-Wmaybe-uninitialized]]
>>>> =C2=A0 2075 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_logical =3D found_logical +
>>>> BTRFS_STRIPE_LEN;
>>>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btr=
fs/scrub.c:2040:21: note: =E2=80=98found_logical=E2=80=99 was declared her=
e
>>>> =C2=A0 2040 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 found_logical;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~
>>>> ```
>>>
>>> Good find! found_logical is passed by reference to
>>> queue_scrub_stripe(..) (inlined)
>>> where it is used without ever being set:
>>>
>>> ...
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Either >0 as no more extents or <0 fo=
r error. */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (found_logical_ret)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *found_logical_ret =
=3D stripe->logical;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sctx->cur_stripe++;
>>> ...
>>>
>>> Something is missing here, and somehow I don't think it's just the
>>> top-level
>>> initialisation of found_logical.
>>
>> This looks like a false alert for me.
>>
>> @found_logical is intentionally uninitialized to catch any
>> uninitialized usage by compiler.
>>
>> It would be set by queue_scrub_stripe() when there is any stripe found.
>
> Can you show me where the reference is set before the quoted if block?

Sure.

Firstly inside queue_scrub_stripe():

```
         ret =3D scrub_find_fill_first_stripe(bg, &sctx->extent_path,
                                            &sctx->csum_path, dev, physica=
l,
                                            mirror_num, logical, length,
stripe);
         /* Either >0 as no more extents or <0 for error. */
         if (ret)
                 return ret;
         if (found_logical_ret)
                 *found_logical_ret =3D stripe->logical;
```

In this case, we would only set @found_logical_ret to the found stripe's
logical.

Either we got ret > 0, meaning no more extent in the chunk, or we got
some critical error.

Then back to scrub_simple_mirrors():

```
                 ret =3D queue_scrub_stripe(sctx, bg, device, mirror_num,
                                          cur_logical, logical_end -
cur_logical,
                                          cur_physical, &found_logical);
                 if (ret > 0) {
                         /* No more extent, just update the accounting */
                         sctx->stat.last_physical =3D physical +
logical_length;
                         ret =3D 0;
                         break;
                 }
                 if (ret < 0)
                         break;

                 cur_logical =3D found_logical + BTRFS_STRIPE_LEN;
```

We got to the if block I mentioned.

Either we got ret !=3D 0, then we would break out the whole loop of
scrub_simple_mirror().
Or we got ret =3D=3D 0, which would initialize @found_logical.

Thanks,
Qu


> The warning happens because according to the compiler this is exactly
> not what's
> happening, and I did not see any initializing write either.
>
> thanks,
> Holger
