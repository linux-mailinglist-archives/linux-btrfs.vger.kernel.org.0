Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DCC775CA1
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 13:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjHIL3X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 07:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjHIL3W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 07:29:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C97ED
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 04:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1691580557; x=1692185357; i=quwenruo.btrfs@gmx.com;
 bh=5ijW/2QcVaxawtYZNHI3TAXUzmUbBqeL6EhnEwWkjjc=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=SFODvEF/NQV783Oc367zvDPLo0pSb+aOsa1SleonjSMoTjPutVNBivIs9zroEQ8T0OtG84L
 AVE2D0F3m819ZNfqYlCobjwiHk8bfz0cEeOL59NVnQVmuvlOBtiNav24P7qHvriHLIUskuhzP
 rz98TLMFat1/S7sWZFYS+lG+Y/dwrW1ZYg0E/BOCtK+w0PhZeLldPw1xDK9jcmKIgKZA030tp
 EV8RTx97Nt6LvUDZe51VYxbUJ0ossrOR/H79kkpYSjzW5l6+0XF1kmvSMaA/NNWdvlDdn6J6K
 1/a1pp7BYhuFtBUFBY2TndCxM4jz2YvSHZzbXidu1kNx57pRTRYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrhQC-1q05fM2LQa-00ngFx; Wed, 09
 Aug 2023 13:29:17 +0200
Message-ID: <82f89f3c-78b0-4c7f-a426-7fde89bf490a@gmx.com>
Date:   Wed, 9 Aug 2023 19:29:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: handle errors properly in
 update_inline_extent_backref()
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <7a56e967d536bbb3d40c90def6e59e9970ef3445.1691564698.git.wqu@suse.com>
 <ZNN2muT7ONRWvn1c@twin.jikos.cz>
Content-Language: en-US
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
In-Reply-To: <ZNN2muT7ONRWvn1c@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eloY65Rvm57AS6I9Eut8nSW153wVEqnHf5qEcbpnI5xtZ970lsE
 0lZgLut9eZRSHk8rpdXZC0p7fxRUcijxvXAMmZUKYWdns0yPYn+q8uRzP3QMddokf46uH04
 /KO8QxnAhNDLhoYUUq3m4agjLx+SGnNRS0JMZa0Jkc5uPBguoYC5/Es+fkxBVKyPka54ZfR
 efwV5qtBMZfJ9tb2mBftg==
UI-OutboundReport: notjunk:1;M01:P0:8KmPQuM/VFE=;aNsU+8VyLwQQkMpF7ghf6TebcZJ
 X5J5rtPXMiPDAAWlvl+Ee41WMlJsBIE3R9p1B5XGgFgOP9ViT6GgBb26aqXic/I/ZJD8letbP
 qCoNE/KLn1kFkQTm15TMt1cQpnGcdfDJs6JdAS3YUvJEYbJeNtU2U4fusovqspMkB4u4bXY5n
 kt5inat0RGVeM1fueAjvsU22cijXu6B2z4tBg34LlawhIgnGVei76A2QW5z6DiStlml/Twf5e
 IQkHNkmxz17XYGdi+2UYWGpbgXHAxvMmPW0yld33iUStKuXirvLNvtXzjdhLVvv2/vpvIQCAB
 Rz1rQEmM2M8G78BxiDUFP0Sr+c1cIjziRwEwQ+0NL7g5qHPRidYYzV2ZcdIxYl/EWGCngo5mG
 BQUEvDYyy41VNpt5uZ1tUKK75xdQssHGKFzXFkD30FPaCXEMiSTuYi+6z5UwAk0Zxd82k5bnN
 lAB70AezVvq/kt0Ekazcy55Z+S2wBjZJBjXkI73fCvghZo5BuNdr7jMwMrKsSJ8rUH7M1D60W
 mT89KRPQorqu+O/GecDynEz8Kie2LIOBOXMBruEWYCHdhvEq2arW5GeqQrHyv0JobZoyC/54s
 dVy+lPJHqEQNufzoI+rUc+4LnuwoC68Wt2BDI/1MXjFFDqcDdBd685iWpxXn8dkP4IEqIGSzU
 qMBzM3RVXLzaGAOruMjOtJHoPtVYwWNT5UP08Y/FTFgIOr0Yz5mmB/s0r/vQ6zCCvdo/EQyDk
 N+l7NqmAzKm/qdaM1IyTH7mJ5kOyB+cgM+qmEozdep4p7f4gyBLubS5xogo5O/+P2s1RzwWOU
 kTwBlPWTt/JWQkmm3A9Ac2PKiYgggZ22oXaDjFu0MVLLYUwwpvQmXYgYF4rNCjPlDkIHmxicd
 4nF65AKEs37Bju5i6QZsRh6la3nPS3u5+6/l4oMH1swIDyEOV8QWnocozq7PpXHOjRW1IUEIL
 f8fWpOBHiDDZ9XnEEO7JMnjmjwU=
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



On 2023/8/9 19:20, David Sterba wrote:
> On Wed, Aug 09, 2023 at 03:08:21PM +0800, Qu Wenruo wrote:
>> [PROBLEM]
>> Inside function update_inline_extent_backref(), we have several
>> BUG_ON()s along with some ASSERT()s which can be triggered by corrupted
>> filesystem.
>>
>> [ANAYLYSE]
>> Most of those BUG_ON()s and ASSERT()s are just a way of handling
>> unexpected on-disk data.
>>
>> Although we have tree-checker to rule out obviously incorrect extent
>> tree blocks, it's not enough for those ones.
>>
>> Thus we need proper error handling for them.
>>
>> [FIX]
>> Thankfully all the callers of update_inline_extent_backref() would
>> eventually handle the errror by aborting the current transaction.
>>
>> So this patch would do the proper error handling by:
>>
>> - Make update_inline_extent_backref() to return int
>>    The return value would be either 0 or -EUCLEAN.
>>
>> - Replace BUG_ON()s and ASSERT()s with proper error handling
>>    This includes:
>>    * Dump the bad extent tree leaf
>>    * Output an error message for the cause
>>      This would include the extent bytenr, num_bytes (if needed),
>>      the bad values and expected good values.
>>    * Return -EUCLEAN
>>
>>    Note here we remove all the WARN_ON()s, as eventually the transactio=
n
>>    would be aborted, thus a backtrace would be triggered anyway.
>>
>> - Better comments on why we expect refs =3D=3D 1 and refs_to_mode =3D=
=3D -1 for
>>    tree blocks
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Is this fix for syzbot report
> https://lore.kernel.org/linux-btrfs/000000000000287928060275b914@google.=
com/
> ?

Unfortunately, I don't think this is the proper fix.

Since there is no reproducer, I'm not sure if it's really corrupted fs
causing the bug.

If it's something else, then the patch won't help at all, except a
little better debug output.

Thanks,
Qu
