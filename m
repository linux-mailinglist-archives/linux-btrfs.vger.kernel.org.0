Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE204550DFB
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 02:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbiFTAih (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 20:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237650AbiFTAig (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 20:38:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2D4641D
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 17:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655685512;
        bh=1pynNGUTBe4/wJPwsoIfPgjtJCt+YiDuQrLFxnWQQR8=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=QiYMZXYiU3uXuuT7GJTP88Ir+q56Yr0yPFRE4mxaGs/YYiqxZw6a46Cm1FzBQviae
         GAJD8zIKX5sP9U+oklwLFf63U6JbHJRIpNpkrzjsApLFT/ke+lQoxZZoF9yee21Tv0
         x7RPDCpB/5IDsLlvpIs7bKIQwAf2lJaytGMj/D3k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWASY-1oDWvN2dKM-00Xdn2; Mon, 20
 Jun 2022 02:38:32 +0200
Message-ID: <5d892115-c132-b2ea-7651-9cb94f76ee6b@gmx.com>
Date:   Mon, 20 Jun 2022 08:38:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     "David C. Partridge" <david.partridge@perdrix.co.uk>,
        linux-btrfs@vger.kernel.org
References: <001f01d88344$ed8aa1d0$c89fe570$@perdrix.co.uk>
 <603196b9-fa55-f5cc-d9b5-3cf69f19c6ef@gmx.com>
 <000001d8837c$91bc74e0$b5355ea0$@perdrix.co.uk>
 <838a65c7-214b-adc1-2c9e-3923da6575e2@gmx.com>
 <000001d883c7$698edad0$3cac9070$@perdrix.co.uk>
 <e7c18d33-4807-7d6f-53f5-6e3f59b687ef@gmx.com>
 <000401d883cd$cc588fc0$6509af40$@perdrix.co.uk>
 <393cf34a-0ae9-d34c-b2bb-ea74d906dfa5@gmx.com>
 <000201d883db$a22686e0$e67394a0$@perdrix.co.uk>
 <000901d883e0$289d73b0$79d85b10$@perdrix.co.uk>
 <b8579f1c-a277-2a01-2126-77ffcc0ab2d5@gmx.com>
 <000c01d883e7$1757e570$4607b050$@perdrix.co.uk>
 <cbc6be27-fa40-f5e3-657b-742e274dceec@gmail.com>
 <003801d88418$15096b50$3f1c41f0$@perdrix.co.uk>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Problems with BTRFS formatted disk
In-Reply-To: <003801d88418$15096b50$3f1c41f0$@perdrix.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0XpuR44cnjrFZ7pF+eVUw+PgbLDK0JidFF/HzI1bWGxESMqCP8T
 r7O6wDPRWzrApXLDqNQyMFkhSIKfRZ5MaZ4GaVSE5FA9xKUvDprJyf67C7j4xI8DaqYIWvl
 i2mwIB8+ctBGIPjipqeOYgUDX37LcUuzuNABg9CELufMlxObK/2IreGXlIGT0mE40at/XKY
 jXnD3hH8xLJcnRN1SRlnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hfhO6jI4Hbo=:fa8GFYguFYGM/9LcKkfUeu
 hQmF4blW9k5Ye5ldShfIPuaWZvL+CBQUhM9osG6393pFtEOPeZF3GODCEdcL/Dq2zON6cvcBZ
 d6vmlSK5geC/2DF7opU/JWY9x5jqMgzHb//S6iGcz9cfv2MTlrokStLcknsksQU+crwLY9zvI
 x+Y7DZO5VqGz/bItJChoPGcgodqEKGXxR02Lp4CIEF5+gZ34bJ0NOF0m0sa4Ppu6d9qU/oW3v
 2eAD1dSrWt+903Qw6gbKMQ7rGUN+x04BC9A291rWR+80JFQCArQ7oGnBzEw2ROYZnKGJxO2Py
 dlNs9qvklcvxCrC8GtWDExQ1qo9j4Ul1m5ORc4eiUp8ZLXnr26KVvUXx3Y5y+bB0khadzZ6Wd
 8kOMU67mlixmyt63Nej6NmvWwILNhDUB2b2Ksku/SKGMMhDMXL6qKBDSaY/Q9k2uI7jRFz7wU
 0FMPKpLlF6wZp5QyDWNM4LghmSuYSDB+eZuVd5hz09l1RKaZSXvuE1sJa7EwkpEX2rm9qIdyT
 jnDu0O4ZtBwulepLoMMrXnqnhUMH+grgI4zd7+N+cxLZNc8FXvR7mAtmxzn5Lv3SwO/JH2PuY
 SoNEbSKmwBjsWlPTvhnjn+WMuiCfG974BAGt4IG+9iXVvmgSyYBbWKI0w5Jaic0ByggwSh6fD
 V/4RZ4dlXd39wT5Td08Wk6SCz8YRzuEH1JkhkXuidlz3KlJRNuSAyuUHrrfym3Izlhsp6BJGJ
 q7tiKcVSU/gCYwsFjBXj6YoyiNVM1bTgl56gaTkFIzDFbgqHtTEY2eBlsmE/+on8tau/84Cx3
 98lds5X1ezr9aOHZmd0HG6HvLcKER153Nu1yZhd3Gqq6we2oGrm1Y95cqkWQTF7DZsTzH777u
 1sWHF+GHxzuchAMU+3CBddUV7PkkgB9YopH4MzEYQE+yjYr//TLGzZ3IdiJrXi+qJeGEgX3rP
 vf2Fsfa6zrwOTbwj2s0ZTpwkGvhX9hVsAOfjonZwwyAdF9C1KR6FySPDwmNHmNoMP26PGtBYH
 vwadr7Ckcuyr9gbvI+FAXzO9RfDpT5qE5MEop23vhcgGBFLJCJPnDQVhWWHCktdNGNuieUTS/
 mjxIjVA8Fwim0WMSrMOzdhfNfLX8RfT3b2kd1TWLU95qAqffRLrvXcmUg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/20 04:06, David C. Partridge wrote:
> Yes write caching was enabled - I suspect that the way it worked was tha=
t on power fail the super-caps held the data until power was restored.
>
> Sadly it wasn't restored for a few weeks by which time the super-caps ha=
d lost their charge.

A little off-topic here, since I'm not familiar with how those hardware
RAID controllers work.

Yep, those cards should have (super) caps to handle power loss, but for
  SCSI SYNC CACHE commands, they should "the device server ensure that
the specified logical blocks have their most recent data values recorded
in non-volatile cache and/or on the medium."

Considering in a power loss event, the juice in those caps is definitely
not enough to power those HDDs, it should at least have some
non-volatile cache, like NAND, as backups.

But from sites I can found, it only states the card has 1024MiB cache
memory.

Even with caps to keep the memory alive, it's still far from
"non-volatile cache" required by SCSI spec.

Or is this a common practice in hardware RAID controller world to use
volatile cache and break the SCSI spec requirement?

Thanks,
Qu
>
> I've reconfigured to use write through.
>
>
> -----Original Message-----
> From: Andrei Borzenkov <arvidjaar@gmail.com>
> Sent: 19 June 2022 20:06
> To: David C. Partridge <david.partridge@perdrix.co.uk>; 'Qu Wenruo' <quw=
enruo.btrfs@gmx.com>; linux-btrfs@vger.kernel.org
> Subject: Re: Problems with BTRFS formatted disk
>
> On 19.06.2022 17:15, David C. Partridge wrote:
>> I can't "grab what I can" as I don't have enough TB to copy the data I =
want to save =E2=98=B9
>>
>> Does it make any sense to try:
>>
>>   mount -o remount,rw /mnt
>>   btrfs subvolume delete /mnt/@
>>   btrfs subvolume delete /mnt/@_daily.20220525_00:11:01
>>   btrfs subvolume delete /mnt/@_daily.20220526_00:11:01
>>   btrfs subvolume delete /mnt/@_hourly.20220526_06:00:01
>>   btrfs subvolume delete /mnt/@_hourly.20220526_09:00:01
>>   btrfs subvolume delete /mnt/@_hourly.20220526_12:00:01
>>
>>   mv /mnt/@_daily.20220524_00:11:01 /mnt/@
>>
>> or is that doomed to total failure?
>>
>> The disks behind the raid card are all Western Digital WD4001FYYG SAS d=
rives
>>
>
> Is write caching enabled for these disks? I know that it is default for
> some RAID cards (at least, for some profiles).
>
> For disks behind RAID controller write caching is normally managed by
> RAID controller itself.
>
