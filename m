Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D084D790473
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Sep 2023 02:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347308AbjIBARH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Sep 2023 20:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIBARG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Sep 2023 20:17:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84894E7E
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Sep 2023 17:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693613817; x=1694218617; i=quwenruo.btrfs@gmx.com;
 bh=T8zfrEbCkv5gG4gZ77APYM9SAykt3ahosxHIBgrydxg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=C5lA/mW8n+gblvo3KRAvTo3pH+8PYMLLRAG6U9Wssr7gHPwMKhWqXvxESOuUroZ5rbuQsvO
 BKHswFzUm/Rv2y/FAqNCbfd3vF1rkqvtBLgPPJ7D5hL6vM92X/VzWt+pF2bf44cP8qX9XOwtS
 oAig2lGVJlklUNoi2hqMYNb6g8/QMA9pmRf1eEOiUvYm14jyfmGBpNeSKTDRgRWXC71uGCWK3
 L0LaTdRrjs+Fz4Zdcm3XfVje1yKYtgJCKQmAIJpMkw+hTIUXHjpdnixDksVfeMYCSWtq/uXa8
 qczNdt1oDVlQCCTdhLa1K8zX/PEfEQwY/o8sioSVtPzCihFpHYjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHoN2-1qPWSk2biA-00EvPf; Sat, 02
 Sep 2023 02:16:57 +0200
Message-ID: <384937d2-78ce-48d0-a6d1-751fee0d953b@gmx.com>
Date:   Sat, 2 Sep 2023 08:16:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] btrfs: qgroup: use qgroup_iterator facility to
 replace @tmp ulist of qgroup_update_refcnt()
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
References: <cover.1693441298.git.wqu@suse.com>
 <ce02f493bf56e540679db37393a9ca243b20c012.1693441298.git.wqu@suse.com>
 <20230901131650.GL14420@twin.jikos.cz>
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
In-Reply-To: <20230901131650.GL14420@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nKX33DNmyIdfuzO9WtIisb3GvcWcSv5+yiZpeXL0QhQet221Cgs
 sxSo87bInPbBSkc7KByt0q3oy1CgtLbxdEnZ3x5W3uKFgWUzzJuTxO5CFk/q2zolIi1pOy9
 IcE5v24+d7BOUtoR5gzRMpT92IIrRlBEcSvQE78w/IsHoPoNj8Q8PpIfj7qmtlXGVC+CA2v
 +q73L9a41rx1J1IJByUNg==
UI-OutboundReport: notjunk:1;M01:P0:UXP7hobfudc=;7350uqex9lK3eJiKUtio7J6bRXx
 xP7CdjJhUJgqkls0pBvufq4mVQ0lOXK48PU5EZR13HB3RCZAuo2ODVGiqdttpKmiyTlkucrN9
 mWOWiTRuNDLGvYYeVai2Ec4mDYRJLv1l8yIIrB74d1EU7x3zQcnxdy07Pj2rQxqMr6kYP0mdZ
 VidUG+cxKxjFwDg6OJKpqVW9j3s+eILUawzmJCS4aOzrDT3iKg+yrw7cyhXyHWreGL60oP6Ws
 KC1ezBxT0cyLW5k+rBXM7VO8+u/fok+A86DPWVRHsk49fVAc3zKaIXHpgZg7WzL9HiskVeGi8
 E2hkYxoy3Q7CcfOYrYrqnzkT69WYQ698e4FoH+oFiWVrSrd52eTcC+Fmx5lgbsJatGTCAcThu
 RapSE7OF8p1Wj3NGwobdxarGJ5/vWmN02KS0NFuQw65Gr+wXzelCiNc3Bswz/fYMutBIP7htb
 xi7JYJlU6a1K6VyMnUYta3Vm2TaTiaJoNiggxpmdC8YLiEd+tw3PRbFErpyShrzcMVMYe6HpB
 O1ez9VwYMXOwNKkMQ4fmJX7DFdwM7LECidfx7u+/4roEblyXcCYbifeholhwR5hXSSPAs0qFo
 676DLFfHwTpWDGYH4/K7xE8nYYPrzqetVwG6sx8hArbYkY9zg38XWDbRPWz+sb0YuQ4gSCvct
 5+iUN1I4WpO/d9dI98WpxRFikDjF45MOp2mK0+sPUKpfW4wvFE7hG8ktM7z3kq0+iKQksSw9k
 NMstvsDs9bBFUWhX4zcqiyFhO1MR75corHafphkmRVUT1O7tTF336DRznKflnox8zDcKpcKV5
 IsmhKgLrQiqssYBZFaKlmo6vnnHSFhGjyj1TKFZZkSyT7aYIHVRI6bQbjT6LS+WY8AY6vv/Kn
 5Urc30/i6yay4tvKE/akVWrSLAgDaGiytnsqJtkmLtavnv6Aska7aPlCEdN/ASMjvV4Zta4aq
 ZjtNAPFY/Ztaaeyx6AAguhYMvNE=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/1 21:16, David Sterba wrote:
> Please don't put the @ in the variable references in the subjects.

Now removed, but I'm wondering what's the guideline for referring the
variable names in the commit message/subject line?

I didn't remember when but I have seen such "@" prefix for variable
names in the mailing list, thus I followed the scheme.

If there is a guideline it can help me from causing more damage in the
future.

Thanks,
Qu
>
> On Thu, Aug 31, 2023 at 08:30:36AM +0800, Qu Wenruo wrote:
>> For function qgroup_update_refcnt(), we use @tmp list to iterate all th=
e
>> involved qgroups of a subvolume.
>>
>> It's a perfect match for qgroup_iterator facility, as that @tmp ulist
>> has a very limited lifespan (just inside the while() loop).
>>
>> By migrating to qgroup_iterator, we can get rid of the GFP_ATOMIC memor=
y
>> allocation and no more error handling needed.
>>
>> Reviewed-by: Boris Burkov <boris@bur.io>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
