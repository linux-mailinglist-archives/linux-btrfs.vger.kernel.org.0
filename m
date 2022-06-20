Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEA2550E86
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 04:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiFTCNC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 22:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiFTCNA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 22:13:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3F5BB8
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 19:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655691173;
        bh=dQWAoU9a5YCxlL6EWZx2KV5tV/PmU9OVXMWMSwzKmEk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=j5ckNOr1xwjwbsBJtxplEHkUX2+q4iDMToZ07dO2clS9LvvSja90umdocXLfzXhbQ
         qPiuTLg3PjVvyZ2Bo0zuReI6z/yIdD203H7iQlG+ROP3Zn+sSlFq802SU/21tbJaS0
         LZfU82DFjPnKTphoI5j7fqemaqGJAzynLhDNQ/qc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbzyJ-1nPeQN13Il-00dUT2; Mon, 20
 Jun 2022 04:12:53 +0200
Message-ID: <ded34e12-4a36-14a8-bf4a-df81da77d0a2@gmx.com>
Date:   Mon, 20 Jun 2022 10:12:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Problems with BTRFS formatted disk
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     "David C. Partridge" <david.partridge@perdrix.co.uk>,
        linux-btrfs@vger.kernel.org
References: <20220620090137.1661.409509F4@e16-tech.com>
 <1f033574-9c56-8454-a4a2-7db57ffd0e01@gmx.com>
 <20220620101209.B0E9.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220620101209.B0E9.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1tjs2xamcRfvqJiC1bNyiDHfhaS6VcAQEcd3EoH12lFs2SSpXvt
 kuxWuNqgiXTzSRNF5StqfUQ1zcXbVfEuXspy3jH6S6kl6Wjm3yY8Wtq8KOX9AtQ5mfDo9+j
 B1PLSiRG5MkRT4coPl7jAUyJ4owf+NS1i6h8jWZyG2CGuSUY3EjT0P0lXcvM9fz3d9P5Hsg
 1eyJ95gKGZ9XnZsN+Q5cQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0LbGgO2Du1o=:7HDzyRe0EVEBUztYMx0HOc
 Z2IW046bNHludYOYSNZBgj1HMcCCoZx1WIsqvfVC9ji0eJnD56QQZZf1pvuyH1E0jGlgvflRH
 WvowVj5juNZtF3wUEfMlIwN+hGdCzkc25PKmCohVjidVcBLQOux9VTpW1DSW+GTOzgqvff7ob
 aw2hFnlojIHbPkT22DgqEDIG0EbuxxahLr7cHnucMLDVRrF7f0GIkSg+kSJH0E6Ki56B+h+Ni
 LGdUm3C6FZZLpPIj+8z3Iu6mr4JF1ps6Wh/9MMnmvj3+Y4FffxGQUt96QvEh0oP+OxfBC0/Xt
 xFOw3BwJwTJzjEZW/wJ2rPdeOYmEF9nSlUgHH8HqZNCJ0Te5k8KDO9L3uBuFIGFRtbycUAwws
 QiB+99Ba6oSyMCt4bFKEYCcZ/hlqeF7B7FN0jilKIgxpzDQz/HU6WIDgFbtDaa+sjBs+5qjEe
 U5RIelzkQcNOImVCbR+wSqGRMbloNVT5xa9DQl4PIVlYqMOdTYUGzXzl5rLXZQfmHxhJKuWG2
 KxrJG7s1E6FvWKeGsPYAgMkQxeYoCW0NaxDLNQsG5ALb44mNMucqfzEA+KyvUZU+SEjbRAalh
 rFqHOqavSnk60OqIyLUzDYw8ylde+CfR/ooTq60GIzWhEdjvBoF1xKrspfJAfBRltgxkGpQF1
 NGDUGy02a0LhMUeVQHJYLzQ8JHYId/wdn4l+NKoqktweknk9ezwJa+rNFtbYmqLsx1xokHmeV
 9OqmPKdTSD9e+IpFSwE60OrM4ht6XXqtiJd/T5QP7//hGUDZ6molr6htYdF1bmuWlNIOdgIQR
 nTikYp9oVrHnJFztOLr9QXUeHUGSa0B8TCnWdLHMUVyw6QL3IQGI34iu7tv3v7iUE26nFT9kt
 OQLAcCj0iZSvvljAB5WJGiVHOTNqp0sbhqzQysXiOeMawjLD4hp+lqheC+qNGbztwRXNAuPn0
 yEyHBZ/5D26MKg3AszwGHKFyqzRMeC3GL0Etdu7nmi5EcqP4pNbZmTUbYgxvwo9k8mHJTFHHL
 j29O40n/00s2TIGtUhQVpVKIxonFZuKG7y5rsAffkiQ10CicdDKjwCH+VyUVGALXyzq8Uuf4+
 QUIAsRff14P74NPWUVlJYuhgmZRiPGJzd2sBcPudhWQSFWDneuh8BWX5w==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/20 10:12, Wang Yugui wrote:
> Hi,
>
>> On 2022/6/20 09:01, Wang Yugui wrote:
>>> Hi,
>>>
>>>> On 2022/6/20 04:06, David C. Partridge wrote:
>>>>> Yes write caching was enabled - I suspect that the way it worked was=
 that on power fail the super-caps held the data until power was restored.
>>>>>
>>>>> Sadly it wasn't restored for a few weeks by which time the super-cap=
s had lost their charge.
>>>>
>>>> A little off-topic here, since I'm not familiar with how those hardwa=
re
>>>> RAID controllers work.
>>>>
>>>> Yep, those cards should have (super) caps to handle power loss, but f=
or
>>>>     SCSI SYNC CACHE commands, they should "the device server ensure t=
hat
>>>> the specified logical blocks have their most recent data values recor=
ded
>>>> in non-volatile cache and/or on the medium."
>>>>
>>>> Considering in a power loss event, the juice in those caps is definit=
ely
>>>> not enough to power those HDDs, it should at least have some
>>>> non-volatile cache, like NAND, as backups.
>>>>
>>>> But from sites I can found, it only states the card has 1024MiB cache
>>>> memory.
>>>>
>>>> Even with caps to keep the memory alive, it's still far from
>>>> "non-volatile cache" required by SCSI spec.
>>>>
>>>> Or is this a common practice in hardware RAID controller world to use
>>>> volatile cache and break the SCSI spec requirement?
>>>
>>>
>>> "non-volatile cache"  require a battery(inside or separated) and
>>> Backup Flash(inside or separated).
>>
>> Then it comes the question, why there is need for battery if our
>> non-volatile cache is NAND flash?
>> Since NAND doesn't need power to keep its data.
>>
>> My guess is, NAND flash is not fast enough so they have battery for RAM
>> as the primary cache, and only when power loss happen, then use the
>> battery to power the RAM so that we have enough time to dump the conten=
t
>> of RAM into the backup flash?
>
> Yes.
>
> RAM/memory is fast than NAND.
> and NAND have the limit of total write bytes.
>
OK, got it.

Thanks,
Qu
