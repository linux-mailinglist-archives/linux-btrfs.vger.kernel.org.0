Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68783550E7C
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 04:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbiFTCFL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 22:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiFTCFJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 22:05:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15CCA440
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 19:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655690698;
        bh=UVFv+Q3mJtV0MerFQ7tziLtRmww0cE2jEqQ8CqvkFwQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fDixYioE2kdfGLHGFs80eajFP+E3AcWzHy+wuveEPFIq41e030htqGSnWAa3DmSu5
         p2hNFTgsp5gjpgPvq0R4e7j/S9rFA/WzFGzH4GXB9gZnlHFfEe/DQQM9NYImzKEVLB
         1lBG3yXUjOC/XVLOEoi0k87l0QUvNTejiqbAzOnI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MC30P-1nqlvA31cD-00CPIX; Mon, 20
 Jun 2022 04:04:58 +0200
Message-ID: <1f033574-9c56-8454-a4a2-7db57ffd0e01@gmx.com>
Date:   Mon, 20 Jun 2022 10:04:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Problems with BTRFS formatted disk
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     "David C. Partridge" <david.partridge@perdrix.co.uk>,
        linux-btrfs@vger.kernel.org
References: <003801d88418$15096b50$3f1c41f0$@perdrix.co.uk>
 <5d892115-c132-b2ea-7651-9cb94f76ee6b@gmx.com>
 <20220620090137.1661.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220620090137.1661.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ckNyJMyt5J3dH/WcqrA7+OqGwmoKg9VSDNi2ZOie96TrWiQ11SZ
 NfWL9spdilKI/Z7nqPbozyGHSMeJ2K/xyMue3VO3t0XZ8lx5SUXcLiVnUOS6LT6mMFe7Ypb
 r7cwmVTMMkt4Jkzr3AdHpFwhk1Mh9UIHukSnyADFzsy72qVXRUM/8wsBDZU0awgg0kYmRzL
 A+CWC9N494scqiF8VhyEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mmCKGzS4VHc=:Dd3aNO3FjQgJRaLyJ8aakX
 ymqq0NkbrS1pmc55GPrScoGMzgfm9joNF5SV3viRcWkrHnv7zym5u/UOFT7h0EkPwSAmJ8+gV
 Od9IvfZZqZH1JCksd6XDCD/9Kx6Hb5Q0V3rI7d4Dh/2D/Wj/sIUnFJVNaRG5KR33E+UY3Yjfr
 d5jfoMCD9KAPhMN9sWbciDiS82/p4kpCRfv0ITZdBdwtSPg/Ni74Etj62cA8jAFeEOeAosMr+
 uBYDIWluQQffRPqD3Uw6s1scDJeX2kB2nqG/J/V5Kx6Sl1ZCz2OTn+arSZ2gkzTYobysmymkg
 oGAnqafRXneGpyPXCorGrpCkmUBeQfKureb0sWXyJTPTkc+iNEO+Z2aIsG85XeXJF5dZNXbC7
 x2ZCRlvXeJ3GDRo+Lb80q366A5vK7t9BPxzWTp2Ref/sQ38LrCL37+FFm+VaOgkIBjOd38G+/
 kAQTE0l9S+bmpEJtWC4/lgxzkrTV96If7dwxoHczLiJwJA2M/O9q0g9T4ic8FR+9Hk7VN13fA
 UENtT60u7MHfeHIhXJ2LbKmsuvbcQRs7aLr4E+MwOJqPw+wjowLgvE78PYSC+pMpvI+8kCwe1
 0AbvbEwDFHa78koob0GtANfCqhOsM3WacZXoxTq5UJFHTOyLbir73BONrBRmRVb1Rhujs61UY
 4mJvFm21mbunGmYWS9IMKyjNHf2vm24pAIBNvdvQx/JOQ2yTe7kPxaO8HpWlD7LgdX4Gx1Aac
 iNd7htvR0XlXfz69+suoNR0UOpRDbaomh7WhMUvBlgzL9T9I40Y2XM6hseWxuDQL7iwDYhZpc
 S9Jqcx91MvGjY3Pw3usPC+SG1x+nYGlysR7fwZaWXrBMkC9Q43XAri5XFdwRBd9qU1rMBrMf6
 F06ruCbOH3JuWpl9+nug2jgt0bXIlKfBcJoGGLPQJdbUUimNGEqzakSqM42mPUUOjjPeSAgUw
 uUX9vFm4kMEUJgVdWlFOeH+wDwLqixbEH5DqxoqycNmDBWdc2Wt+f8Bmjy1/p7g6hUG83TcLo
 8xN+ijMlw2XD1lp4JLudgqscNJR75Wp29gcpp0O1HWNy7nyjyMFvKxJf3vPrRbEbdgoujt3Fi
 OVPePT1VTVi4DvcDm3V90/CE77IkF5gbyRrXo0ZJxT3Zk3m0kN6GuWDvQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/20 09:01, Wang Yugui wrote:
> Hi,
>
>> On 2022/6/20 04:06, David C. Partridge wrote:
>>> Yes write caching was enabled - I suspect that the way it worked was t=
hat on power fail the super-caps held the data until power was restored.
>>>
>>> Sadly it wasn't restored for a few weeks by which time the super-caps =
had lost their charge.
>>
>> A little off-topic here, since I'm not familiar with how those hardware
>> RAID controllers work.
>>
>> Yep, those cards should have (super) caps to handle power loss, but for
>>    SCSI SYNC CACHE commands, they should "the device server ensure that
>> the specified logical blocks have their most recent data values recorde=
d
>> in non-volatile cache and/or on the medium."
>>
>> Considering in a power loss event, the juice in those caps is definitel=
y
>> not enough to power those HDDs, it should at least have some
>> non-volatile cache, like NAND, as backups.
>>
>> But from sites I can found, it only states the card has 1024MiB cache
>> memory.
>>
>> Even with caps to keep the memory alive, it's still far from
>> "non-volatile cache" required by SCSI spec.
>>
>> Or is this a common practice in hardware RAID controller world to use
>> volatile cache and break the SCSI spec requirement?
>
>
> "non-volatile cache"  require a battery(inside or separated) and
> Backup Flash(inside or separated).

Then it comes the question, why there is need for battery if our
non-volatile cache is NAND flash?
Since NAND doesn't need power to keep its data.

My guess is, NAND flash is not fast enough so they have battery for RAM
as the primary cache, and only when power loss happen, then use the
battery to power the RAM so that we have enough time to dump the content
of RAM into the backup flash?

Thanks,
Qu

>
> For Microsemi Adaptec,
> the battery and Backup Flash are in separated 'Flash Backup Module
> AFM-700'.
>
> For broadcom MegaRAID 9480/9580,
> Backup Flash is inside the card,
> but the battery is in separated CacheVault CVPM05.
>
> For Dell, H730/H740 have battery/backup flash inside,
> but H330 have no battery inside and we can not add battery to H330.
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/06/20
>
>
