Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522D85FD514
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Oct 2022 08:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJMGpJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Oct 2022 02:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJMGpH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 02:45:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACCD42D7A
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 23:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665643493;
        bh=DCrF1qWvl5gRO7pdapHN6E0LwUN/gOOeaMcvTcMwu9U=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=KLpbSOiXWK7bfcZiY0VXaf+HWFcWyFiowrXd52jE7trYJG7dYinDlRrHLTcXl/J+u
         HWRlqU/6UXtTdnvf22ljPFqSMm6u9yJ4bY2+ENZHv8a8SOzfWURQLo9kHdDKJnZc+U
         voGmEIlG9g5U8FlYUd0bwpeZx5mj0jFByqZylbjA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFsUp-1owIl12zM7-00HKZk; Thu, 13
 Oct 2022 08:44:53 +0200
Message-ID: <a2633456-dd2f-534c-6505-fa4c8121f3e5@gmx.com>
Date:   Thu, 13 Oct 2022 14:44:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] btrfs: make btrfs module init/exit match their
 sequence
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <679d22de5f137a32e97ffa5e7d5f5961f7a2b782.1665566176.git.wqu@suse.com>
 <63038e02-81fc-92b7-4e33-0a2c6c356698@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <63038e02-81fc-92b7-4e33-0a2c6c356698@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VngLPlK2Gl70USpBo8gVtDRup9+YoGUC+V+FoayAu+Oh/hEf33I
 fK3gE0QbzVJQWompOjla2oMmRsxYvHixeSmMB0edsOS6IKgG4zM0KpyHgBzPJg5YqfSZXkX
 Sq7Yd8Ba89+Q9/+ZWfjQ9Yf09nvbfsTPL8Qw+0Tx5d3xeKrQe45iZxne4k2sc2ltLUQLJ+q
 6i5RIWdqMfVW/GKAvsLpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9d29+Kaf5F8=:OVh83ECvbr/JQ8ZPKTbchM
 LRIAQB2IYyX8KiYUOntHYDG/4N2Q727fG0yd4wDNdxajlO3YOkVkkzUnm7Eh4DlrrWHrqXpod
 3KU7ZfgqeVSLz5RC5x5SucYBOiqexcxJ7pCb9aA+f5XIJNiTn3ZFAvKOOzx/JFfUYPk55gZkv
 3hDmeBr16zMvwsyIO41Fn8tcX4W8MNdsUFHu0QPYuzhfHMhrBBSp2LIlCxeyKT1FQ1hwu0VtM
 psJeWszlCLiwHzgyXwLQWbawcXqmj5FU4Gw4IdotJIbzLKENXIhkd+5yh3IIMabY7E9edHEqL
 KBDDbzckUT4ic5IBUsvu3d15G+QdcnazsOkYEBesm/n33dvwKboHQi7v0T7h3gUrw7NKOgF3+
 ARfGU/YHS+uIrysXr/WFvw/DgrykO/KSgL3hO2wTyKCoK61jHBhFvI/gdajn6Uonp3lp0eJnX
 MWu2s/mGIGZU56dC+XeO0mHAauJOKFpX85H1MJyX2tnuLFhFhSeMHD7lWdXwphsY2v29QdkEV
 qWypJ+8mxPZycwgThsErV4y9YuW9n0Z2wnfS+WowHymRowtBw59N4KMpZzRy/L1BGa5B3Ysfi
 ItjKBEPecv3z3qxAwYSCqcYosc2MbG2cUnjtA3/HcX8WmsL5B6CRc7Oik41uQkoo4ESO/xm9M
 8wfdepo722Ya+74H0LtU81EH1zCu8Jon8Bp/SoCfmU2m0Dk4nIPUgaqY+MPr/x9Nn6l7EnRZ9
 9d0bEhxnopHp2rhnJDkss3WnuQeoV6UM2pwHCFVdeHTDA0iWpBYn+hPdaTPEfuytrTnRT/UPr
 NUlu1397EAAKE/wxSZdfFADGVzX465uLZSwz/29kuWoi6tiRuk549MLDEGMphkiuXGUklaBPa
 mx6Al/lJSYNLwOABucRI7V80SIwsdmlRQcrjSATJ2cEY8c1QwonrgNvsT5Jj3AzEueOQ6FfIC
 jHgys6KSGnUaPdoGMbkvSHby7ixB+wiVacs54/oSKf7LLSjPFjL3Kew48yYUVe63iugdlavLb
 dyJtZH99yyT6gPJ9q72n7klYKdv9IbHWStt74CpZ/fr4e1dMQHcaY6PQdj4PEm7meKAdcM+/k
 VoWJrYiaGJFXITlKqr5nA0vwyL9YOV9bviAyQ0yz0RSDppsd5Rp0DBL9O/pcuvcuL6NVc4QZL
 0WvX9F4IqncZbrN8fSiLXBbaAbVpbzGJalO/gkMDTDmLUob0aHzbWesjk6F8o5x+KJZeph6QT
 MjKl3wNSJ4q8TskVrmwWe69m1796D8RaijnstR0FfF8z23Hkrgq0XW5VWuzX3CHn4ost72bhZ
 ohOnh8M1XiMNXTX0q2+UpfwgvhJgociR69XYiryHI+YPohCBLKlC+prGlA7vlmGV/hb/l9sTR
 0eFuC30zT/OPkWKvy0219vSkHbenwt0jmWBHbds/HyGQuhIcd9ezZZQhNFkR3F9qoehzhnSqq
 sCYZt8WOt1rvMg3Z2xiTJ5MaZ74ml43szjsC1J0bdYKJjZlpmCRBYv6H1eDGkeqoQUdbc9isx
 GKLq/n2OI3PdJV4L/0X+Qll5reGBQDb9Mh78LdMXqviWn
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/13 14:03, Anand Jain wrote:
>
>> With this patch, init_btrfs_fs()/exit_btrfs_fs() will be much easier to
>> expand and will always follow the strict order.
>>
>
> Nice idea.
>
>
>> -=C2=A0=C2=A0=C2=A0 btrfs_print_mod_info();
> ::
>> -=C2=A0=C2=A0=C2=A0 err =3D btrfs_run_sanity_tests();
>
> ::
>
>> +=C2=A0=C2=A0=C2=A0 }, {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init_func =3D btrfs_run_sa=
nity_tests,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .exit_func =3D NULL,
>> +=C2=A0=C2=A0=C2=A0 }, {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init_func =3D btrfs_print_=
mod_info,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .exit_func =3D NULL,
>> +=C2=A0=C2=A0=C2=A0 }, {
>
>
>  =C2=A0Is there any special reason to switch the order of calling for
> sanity_tests() and mod_info()?

Mentioned in the commit message:


   Only one modification in the order, now we call btrfs_print_mod_info()
   after sanity checks.
   As it makes no sense to print the mod into, and fail the sanity tests.




>
>
>> +static bool mod_init_result[ARRAY_SIZE(mod_init_seq)];
>
>  =C2=A0Why not move bool mod_init_result into the (non-const) struct
> init_sequence?
>
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If we call exit_btrfs_fs() it would cause s=
ection mismatch.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * As init_btrfs_fs() belongs to .init.text, w=
hile exit_btrfs_fs()
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * belongs to .exit.text.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>  =C2=A0Why not move it into a helper that can be called at both exit and=
 init?

IIRC the last time I went the helper path, it caused section mismatch
again, as all __init/__exit functions can only call functions inside
.init/.exit.text.

Thus the helper way won't solve it.

Thanks,
Qu

>
> -Anand
