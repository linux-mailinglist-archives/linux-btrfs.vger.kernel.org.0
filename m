Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBA34B861C
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 11:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiBPKol (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 05:44:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiBPKoj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 05:44:39 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5250AB1ABA
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 02:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645008263;
        bh=P9v7EW5MyXbvQpJKNIa+2fEM019ZIYwBJTfDQNKtomw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=GDL0DZeUBZr+1uzRyWnzP8b6Wr1W9V8Pf7FRddn519I+/+agT2SumpvF0OYqNIsxe
         oCKrbgsOTnXjnRkbleZIr0UcEATM5dvjDlLiq8cFvMEKFfoM7dSGdPTWxEkktfTzCy
         VWubQ1CG+naFBnEcA7USTVGWasEJN6XK4jgcG/Y8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUXtY-1nkeNq2OP2-00QX7D; Wed, 16
 Feb 2022 11:44:23 +0100
Message-ID: <1ba2560e-3271-03b0-a0c8-4908615e66e9@gmx.com>
Date:   Wed, 16 Feb 2022 18:44:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] btrfs-progs: allow user to insert property
 compression=none to file.
Content-Language: en-US
To:     li zhang <zhanglikernel@gmail.com>, David Sterba <dsterba@suse.cz>,
        linux-btrfs@vger.kernel.org
References: <1642323163-2235-1-git-send-email-zhanglikernel@gmail.com>
 <20220117134441.GG14046@twin.jikos.cz>
 <CAAa-AGm4VUDFNZwe_rY4cJ0XZfXGdGRh0tPhSq-WOZYLVcPgDg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAAa-AGm4VUDFNZwe_rY4cJ0XZfXGdGRh0tPhSq-WOZYLVcPgDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zazlBl188NsiTiG/+KoYP2KopUJjTcuUpOmBtmUyZ+oj/Qa9QEZ
 d4biwTgwNO0ZQFZjBUoGs/h3OuyCUQLaVyS7tpcBNkoDatwAccEmO0AhTQ/HiYR1fMOavQ9
 41pwuxxztP/GAS8tW/quJXeqCLy+L6x/GD9thQDGtZKb3JkxM2jeaC9M0D6yKGFbjY0DyPO
 3WiO4pAMqOJJwzqcosPwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vp4HUWdDHpg=:8e5fTewjVtEiT1a21agHn3
 0FNy42wli40e/TDNM8qQjxbndQJL+4w5Np8HAXN1oQA7+yulzx4gBhCY6OnP/Uz7oQOA90oHq
 70YZYpcW5SyUoKGF9t+GHTfEwU5lu0Jp9Hg3uvTnHv25NdmAutHlNIBcavwdSkOEFOcdiKVRR
 M281jhpp53q8xGFfFvwVihxJcAp6cXnTcCJVmAkRjVhx8G8oOtTeqtn2kPlvXb2bNM+L3dJ5r
 v5/oIiGlAaoag9Aej8aRGIxRER97QRGv6W4c9B/5lYkuV3TJJLsB1vojCkETXO3W39rM0v3OQ
 DWW0ivHVTv/G392wz+b0In/V960nRKv/SHqq6MBLy/Ix/c8MkV1RVlIkK6VGhyx/Tc6ygs7ax
 GHs6C2Zh7ZfOAf9vwQVB6c7CFsYs/n92Kuojnx3lyzMPXnW4GxhGNqn6irZPvRXWdE7izuxrJ
 cMNlURoCEenBkEvzxtnGqUpnco9wQ7IWrQpZwwv3fZEYcJmTjO2DY+E7TmE36q7a9GSZvwwUl
 QWUZD04SldTceJuYZw3LqjDEIWqaII7ioVJPr/7v96/ORNaFQNcgukfDbJYBwmlrAaZl5em5K
 2+eZ4xuY0MQv28BFaqr0MM5hbNzxxf6Js8/H4U3AW9Via7fcckWz9MDIlYxUvXKr2Co2OXTE5
 NTwlQV9+ZaEKHCuTWmVpDNEpHB/WVkhcwmKn/oxwuYszWq+dhLcdxTml+a7PLXvtT+RtTPM6x
 QNwQL44lCImKkbPd7+G1842yCSNEBXsfvyhcmafH7wdfOt49P2GFS0ErGsWMF1XDdp/w5Y9UZ
 312blzmn/WqqKTTvX+lTSUf2Sw2JV0ngD2Q+E8DH+Xo3bG681tVuLe7DxwB2XJZh9EPq5rzic
 o2UV1BUXzhjm/k7E5NREYWhA01BaCUYpND6aN3Hh8Yk9aehcX7vdx8WhsvVlqav8qkeKkpUr0
 UoESa9XNGPWkyMRj+ZXVdvAkh3+fUX5uO965C3pjK03Or+azL6TRDgIh9f6v+8SD19s1JuZAc
 dUilNvMsaYYydkAoMPN33XQe98bd5WFy2zGVCAVL2JTyH6TingIDp+fEf6ETCE9zoCplfCPXY
 8jD/mGmykr1g4g=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Furthermore, that kernel commit has a big problem for a lot of
compression users:

  No way to disable compression on a per-file basis, if using
compression=3D mount option.

As progs always convert "none"/"no" to "", this leads means older progs
on newer kernel will use default value, and no way to really set
"none"/"no".

This is already a big behavior breakage.

Thanks,
Qu

On 2022/1/19 18:49, li zhang wrote:
> Old behavior:
> # Insert compressed none in the file
> $ btrfs property set file compression none
> $ btrfs property gets file
> # no output, (none value converted to empty string)
>
> New behavior:
> # Insert compressed none in the file
> $ btrfs property set file compression none
> $ btrfs property gets file
> compression=3Dnone
> (with compression=3Dnone inserted in the file's xattr)
>
>
> Convert the attribute compression=3Dnone to an empty string "", which wa=
s
> introduced in commit df11e2787b5b57ecdb313f2725dc5c9a5e549576(btrfs-prog=
s),
> according to the comments, in the past it seemed that the empty string
> "" represented
> no compression, but after commit 5548c8c6f55b(btrfs-devel), the
> character The string
> "none" means no compression. so the command
> "btrfs property set <file> compression none" is not working.
>
> David Sterba <dsterba@suse.cz> =E4=BA=8E2022=E5=B9=B41=E6=9C=8817=E6=97=
=A5=E5=91=A8=E4=B8=80 21:45=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Sun, Jan 16, 2022 at 04:52:43PM +0800, Li Zhang wrote:
>>> 1. If the user adds the property "compression=3Dnone" to the file,
>>> remove the code that converts the None string to an empty string.
>>
>> This is related to 5548c8c6f55b ("btrfs: props: change how empty value
>> is interpreted") and needs some explanation that what it does on old an=
d
>> new kernel. Maybe some backward compatibility code in progs is needed t=
o
>> take the version into account.
>>
>>>
>>> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
>>> ---
>>>   cmds/property.c | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/cmds/property.c b/cmds/property.c
>>> index b3ccc0f..ec1b408 100644
>>> --- a/cmds/property.c
>>> +++ b/cmds/property.c
>>> @@ -190,8 +190,6 @@ static int prop_compression(enum prop_object_type =
type,
>>>        xattr_name[XATTR_BTRFS_PREFIX_LEN + strlen(name)] =3D '\0';
>>>
>>>        if (value) {
>>> -             if (strcmp(value, "no") =3D=3D 0 || strcmp(value, "none"=
) =3D=3D 0)
>>> -                     value =3D "";
>>>                sret =3D fsetxattr(fd, xattr_name, value, strlen(value)=
, 0);
>>>        } else {
>>>                sret =3D fgetxattr(fd, xattr_name, NULL, 0);
>>> --
>>> 1.8.3.1
