Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA92F74B96F
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jul 2023 00:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjGGWRX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 18:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGGWRT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 18:17:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583AE1BE1
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 15:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1688768235; x=1689373035; i=quwenruo.btrfs@gmx.com;
 bh=bPROw2T54e8Xrdd1rCymW8SGIUJyURF87HXFjvekc3Y=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=X3ISD8b6PMcpEdjeHz0AL9CY835YHqKzZKs5BEx5D9CGy/R75BI1oz8rk5vDt2eJbW/SqgQ
 McFMnABxn8Kzazl74BLjTBf+oobJ8ccEmdtuT0COn8lq7vbsHJ5fIqAZMeiV51fYsBvQwsfme
 oThR9g/ukOU3WSBxakAWQHwzKtPi+pTq7SFClWRZMxOmKzT7VM92LchdIklgIt9PkcY50b5dk
 DFxz5AQ9nHb0t29ZWl4R8/dAjIuU4Sv9ahOQP8rxFXpeEOkReX836OmrkoNTHbba2tjvjdqyt
 m4v22+cBZIUDg/JZPednQclPrKjpoYPzXVObb7bkzKQ8nLucxntw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9MpY-1pwyf01v8e-015FaI; Sat, 08
 Jul 2023 00:17:15 +0200
Message-ID: <33e2f4fa-3e1c-c249-8d8a-8d491da2f2e2@gmx.com>
Date:   Sat, 8 Jul 2023 06:17:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: question to btrfs scrub
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8a3d7ad6-0ddb-3160-eece-8d6228b9c0a6@gmx.com>
 <PR3PR04MB7340BD6CD63180053CCA023ED62AA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <3d208b62-efc2-afe4-e928-986dc4c53936@gmx.com>
 <PR3PR04MB7340ACCB059FA7C9A22052DBD62EA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <e4237dc0-2bdc-a8b3-9db5-6b0e24b7b513@suse.com>
 <PR3PR04MB7340B6C8F2191ED355D1232BD62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <80136f6f-0575-58e8-ea8d-7053c8af4db0@suse.com>
 <PR3PR04MB734063CF2AEA3709D3AFD9A5D62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <11a9ec6a-7469-fdba-4375-c24e8ea5f7fb@gmx.com>
 <PR3PR04MB7340A2D0D9738902AC008CE0D62DA@PR3PR04MB7340.eurprd04.prod.outlook.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PR3PR04MB7340A2D0D9738902AC008CE0D62DA@PR3PR04MB7340.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:anvNBaZym8oj88QsEGOT63lcNdbcN2hLFl8XnuY3f1nIH69yjF9
 i0xzWto15tfFpMrGzwvvdQiCKkD47mGRcYa9CCF0UJE0uAlaTmyFMBtR0kPc72r0+vXBs7g
 aCCl2Xedivcz/5Qvcfvy983YoO+Vr7J8mH707e1q7p/KS92iK9Dy9f2mvFt3uYTQoONLWK5
 QWHgtS2Ylb2MJ74pXQWXw==
UI-OutboundReport: notjunk:1;M01:P0:OUTnpLpJb/o=;GG2nI2aXyRQVMBIuHkqKM805eCo
 Z1Yx9vbh/eylhx6XnsHt7gsWHPq3Qs2XNE0j+l/bbkuYPUIc9GjE3h6k2JOkp8t/nucytRSDt
 P6w9NexgiEoUVVXyA2r51HBN1yk0sXRwp3g3AL+YW2h9gHAHb645nvA4ZuZWAzbLjEZNgRzxf
 WAG5zhDjj+9P6baWpV5lwd0ih3w8d2mIhNhKSMDEeT4kQWn9d63ORH1Yhn62tabA6gZ/hmGDc
 VaMOnXnRiT1aQD7e/2kERvCyP/uf33ISHqo3V8xwv1H6XLdXabzHFgX8xw0LwrbkwbRKRvZtz
 nyBv3HbCWkB3d5teHC9RYcSja6DOb7NggGBUziUXfD99DPop4b0qEEsO5suSXytgTNIkq2CHI
 5lcQE0yNyVda6H1Mi3gdRmVNFinfSwLxEyk/xJRUxU5evyWbhKlL2jdR5EsT4BkUm9ykdWZ9A
 YVDPnwL0u7o6pD61o96pU9e5PtZCz47ce3q3U3JWSJTPal7CC+mZebOC/2VCfsmq95GznZX/0
 6xynFLBHJKWpeVm+81yn6uds63/migPi8ufXPX29omw2yW5gPqA6tSWTYkOe/4ZXtzDAVXqOb
 gabOBIbwJGJlM3RSFVyxZ0J8NMe5hQr3tToOqX4T94vfE2SGxeQM6A167Css82Rh9KEAuvKq6
 hU5/CG0QMpokyAESDiBB6FOXSNXyTXQZzh/F5KYpqtdEkRVgqreqrURaotlV4ZMr1Kz8PVhdF
 quW/9/bRba3tqahqPihcJrQzvOB5u3nUYRY4iGGqdFg8wz77sh+UImDlJJcfWl3jonuaPbtGC
 yzG/8lYr+GiOXgHydp71W1BZmHI0cdNldjfZ5arD1ezWiJ+itaN2Ct9wQQLU0uJS+MPPfFUzz
 DvWv+Wi2b9KMUR6fYWdWHYlDudYgrGeCPb6N+iPEcsxZ7MttdW4wcJoHM4ZeR3s9HUyrpV/Xz
 6EfiGwo9SFAC4iepjjFjUDOccVs=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/8 04:48, Bernd Lentes wrote:
>
>> -----Original Message-----
>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>> Sent: Thursday, July 6, 2023 8:20 AM
>> To: Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>; Qu Wenruo
>> <wqu@suse.com>; linux-btrfs <linux-btrfs@vger.kernel.org>
>> Subject: Re: question to btrfs scrub
>
>
>
>> Checksum have two functions:
>>
>> - Detect errors
>>    As long as it's not a false alert, then it makes sense.
>>    But please keep in mind that, a csum mismatch will prevent anyone
>>    from reading that corrupted data, whether this is the expected
>>    behavior really depends on your workload.
>>
>>    E.g. if some archive with built-in error detect and recovery (like R=
AR
>>    files), it's definitely not a good idea to return -EIO for the whole
>>    block, other than reading out the corrupted data and let the softwar=
e
>>    to handle them.
>>
>> - Recover the good data from the extra mirrors
>>    This only works if you're using profiles with duplication (DUP,
>>    RAID1*, RAID10, RAID5, RAID6).
>>    Otherwise btrfs won't be able to recover anything.
>>
>> In your case, since you're already using LVM, thus I believe the fs is =
using
>> default profiles (DUP for meta, SINGLE for data), thus there would be n=
o extra
>> copy to recover from.
>>
>> So there is really error detection functionality lost if go nodatasum.
>>
>>> OK. I know which VM images produced checksum errors. I delete them and
>> restore them from the backup.
>>
>> You mentioned snapshots are utilized for those images, thus you have to
>> delete all the involved files, including ones in the snapshots.
>>
>>> So it finds errors in the data csum, correct ?
>>
>> Yes, either there are some files not deleted, or the file is snapshoted=
.
>
> I don't understand what you mean with that.

Is the file you deleted also in other snapshots?

And are you sure you deleted every file reported in dmesg by scrub?

Another possibility is, scrub reports can be ratelimited, thus some
files are not properly prompted.

Thanks,
Qu

>
> Thanks.
>
> Bernd
>
> Helmholtz Zentrum M=C3=BCnchen =E2=80=93 Deutsches Forschungszentrum f=
=C3=BCr Gesundheit und Umwelt (GmbH)
> Ingolst=C3=A4dter Landstra=C3=9Fe 1, D-85764 Neuherberg, https://www.hel=
mholtz-munich.de
> Gesch=C3=A4ftsf=C3=BChrung: Prof. Dr. med. Dr. h.c. Matthias Tsch=C3=B6p=
, Daniela Sommer (komm.) | Aufsichtsratsvorsitzende: MinDir=E2=80=99in Pro=
f. Dr. Veronika von Messling
> Registergericht: Amtsgericht M=C3=BCnchen HRB 6466 | USt-IdNr. DE 129521=
671
