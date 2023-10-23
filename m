Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF68F7D2AE3
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Oct 2023 09:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjJWHGr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Oct 2023 03:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWHGq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Oct 2023 03:06:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1A0188
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 00:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1698044794; x=1698649594; i=quwenruo.btrfs@gmx.com;
        bh=doTb7RQnj81IAfrLm5AJ+B75o6HrlhQV45b5yWXWRAU=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=OcxKukN5pQbt8r8Yep5EyiA907f6FZn7i7aZRhOjAGBKg5EBZJTA2zUMRvHipbbJ
         oXrzMr415V5pnJDH8kYt40xWm8rzuYfv31v+vE6owBAGOJPm13yM98AvzYCTQEDCk
         Xtc3rOtlhyCLmlzUKJTX95fTxttPLJjuQjJFVLAPDiQsgWXm4lSugT1+Knn6s6SMV
         J3y3wBEil8bxifFZEgbbCkFKZEj6+BRirhJKfhocP+NW9Anch1bEtI08gJMh7j1TB
         tYUQGLHVdMSTDSGyQ+vnXqitgyq9Uc4VkAQTQ3zmj1fshvhiu41lhAGjob0Pa8ILa
         cP1Q5iogXOTtJSdqtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.10.18] ([218.215.59.251]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdefJ-1rUQoq2J5F-00Zh0p; Mon, 23
 Oct 2023 09:06:34 +0200
Message-ID: <45a12dcb-c3f0-44f7-9fb6-301d3f060e82@gmx.com>
Date:   Mon, 23 Oct 2023 17:36:24 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRF: no free space
To:     Reindl Harald <h.reindl@thelounge.net>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <2856c6f2-8d3c-412b-a012-a8151a4b1392@thelounge.net>
 <9760a471-6473-4c11-a807-ded4bb2833e2@gmx.com>
 <78d67a9f-9b9f-436c-884a-9659864d7757@thelounge.net>
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
In-Reply-To: <78d67a9f-9b9f-436c-884a-9659864d7757@thelounge.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R5LUap2gbPMQv6yuo4GFpnmr6rUUa4SIvKXh+MvWmOjBr+Hq7LL
 0+lgOdqLCPVRPGuk2dWk7m44sPacV9HVUEVxh+zfxMg90R4vhOgjeXWmMS4oxzGnIWmT57v
 HGYC3kIBpYixtKvo6DnW7zwaOtSDpjMRNg4jy2TUOaHRVQNDEQthzkcB0VHGt0ScBki8VXA
 Pir4PudRPCUysblUiZy9Q==
UI-OutboundReport: notjunk:1;M01:P0:wgdaXv5QC1U=;L5/fGScVlvY2qC/XJVkM4aU3bLt
 iEqH4/uCQbIrpASXsrfVlJmw767sxyIGbfsb2Ev24ls+IC4EnEe0v5ICISkriJEtWNH1SmEPf
 PSEFe9wMPXdCeViJICGr6MhoiYrjvqDyXnYFSFyp3hsMQ7a3zkfu/1z0Zie2P06WFDAK44lPz
 u4xTjKeSVV//C3jfDtASrr18+GqQqHhAAuCrf6or9ZjR3r+eWxtF3NsX/AORNLvRDWP/b4rOM
 nCDUn22ZK/tUVZZ5hVeGyO6jogM3QfRCsCpk6iR+AVPYtrI9RHYXXPLy7J69ffAEziu+YBv6x
 aMBDHFOfMcvGkVpyPOeLzt6V6kWcqRvXOByVuJCDUHO65QwOpnIFqNDL+QT9HHsSJNPJQ9N7F
 g2WEEV5Y9PXLtOGJlCK4XGtGc9P7gkCDjJvz6HFAeKosXml+jRCyOU/y6ZM9FFp7xYVMTQPlx
 Vka8QcWJfPLmkwqU9+VFQkbMPntHkzwOYaKxerfmWpDvIdJmfcm8nb9HwStU5xyDHbyARbirQ
 b+rDvOB0wlKyYcJ09Oq7Hj5yzE1GwDJ8yrQTcDZext1Mm+3l2mr2phVISBVZzNlObI4PfSoz2
 wXfbXmJC0e056pdKftPc6Cq5BJlhxglU09m2pGIS8o+yu79C0q/YsL5MkmGPeK09bIALjU/zz
 NaJv+jQr9SHd+5IinrLn61KKiKCCzs/vqDC7a4vmoyonAmDdknMGcczkOPv9PRSlMrwKin+T8
 QxVg6BnhQwQ0nMfVDBa8bYqd6EXDYqougtF3B+EFJAThpLSfhhoaw6fJz8hVdPEYBvTI2TigS
 VRway2JY9ONvvrYOlQL0aNbE0DgobH8GNCoRoHoU2z7knCVXApG8qULeirYriwN3d1ukd2rwX
 vcz0Xkjgg3YHjuvelOBe++T/wPOADLxK0Wz/nwDQ12srp6U61YYIcjtzjZUpzMImV3UiqgpXO
 +MrF43yUCVGQKm55TWD0ENixb3s=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/23 17:25, Reindl Harald wrote:
>
>
> Am 22.10.23 um 23:33 schrieb Qu Wenruo:
>> On 2023/10/22 21:13, Reindl Harald wrote:
>>> this is a *new* filesystem and somewhere in the middle of the night at
>>> 10% usage a large rsync stopped because BTRF thinks the filesystem is
>>> full - how is this possible in 2023?
>>>
>>> Metadata, DUP: total=3D1.00GiB, used=3D945.61MiB
>>
>> Metadata is already exhausted. Thus no way to start balance.
>
> pervert on a fresh 2 TB filesystem with 200 GB data in 2023 especially
> because i found "btrfs filesystem resize -100M" as solution which worked
> and afterwards balance was possible again

Then this is a little different.

If you can later reclaim space, it means your previous deletion indeed
emptied several data chunks, but they are not removed until cleaner get
kicked in.

Thanks,
Qu
>
> nearly as laughable as a small ext4 filesystem come swith defualts that
> you get a warning it's not useable after 2038
