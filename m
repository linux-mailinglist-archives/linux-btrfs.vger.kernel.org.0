Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776866F67A7
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 10:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjEDIkv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 04:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjEDIks (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 04:40:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DAF1980
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 01:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1683189633; i=quwenruo.btrfs@gmx.com;
        bh=bhEJfWoY9NfBQYW+DvxJ6SnMvaOnWhCaRSEAVfJWTtI=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=pVJjlkicg2ppGow/ZZcs2Zw+qm6MJ4P/VLxHXlKSilmZccL74aiEDRGd4bwFVB7xs
         mmTD7qwquHvZK4Y4yTGUSBzAhbbMqAkPjWLz/whQxbSZ2nT6ZOXg9wHU3oLpYcsBiD
         HREdZ3iTMALujgqot+8P30FmLjl4siukcfU2O2gXPK1CxaLDuYdH8sjnRzsMfra93i
         GpTKd+nDxFekYXgKv2s3EEZNEoq+tIrZ2y/RxouR+Xxypezt/sryUvv8m+NM2/QnEq
         QZY9IQHqrwMxTj4YdAHPzR72FOkuQZabtoK+O1agc6wxsXO23SF+ZBkGCMSF8egthF
         5qyB50iY9r0zg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvbG2-1qChaY1obG-00shzV; Thu, 04
 May 2023 10:40:33 +0200
Message-ID: <342ed726-4713-be1f-63dc-f2106f5becc1@gmx.com>
Date:   Thu, 4 May 2023 16:40:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Matt Corallo <blnxfsl@bluematt.me>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <4f31977d-9e32-ae10-64fd-039162874214@bluematt.me>
 <2a832a70-2665-eb9e-5b66-e4a3595567e9@bluematt.me>
 <62b9ea2c-c8a3-375f-ed21-d4a9d537f369@gmx.com>
 <2554e872-91b0-849d-5b24-ccb47498983a@bluematt.me>
 <5d869041-1d1c-3fb8-ea02-a3fb189e7ba1@bluematt.me>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: 6.1 Replacement warnings and papercuts
In-Reply-To: <5d869041-1d1c-3fb8-ea02-a3fb189e7ba1@bluematt.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sUbC9AMfqYOSL1+iq6Tg7plGY32bBHzEE1RiIPXASO5aJyDKjd1
 cJ75sfXi9KuuzVgH3BCFtvmu925oN43ot8QrwSN+L8RuVobj0bCs05TggaooQFKOrfHImNz
 5m6KhNtCR4sQC4sMjgqLjP78So9N6sIRL3bxQK7BiV51osYBdNQsPZ/I8WE9352M9KCKjYT
 UH7CDiBYox/OYoE3aMwtA==
UI-OutboundReport: notjunk:1;M01:P0:kA+QnkEvMlE=;WgQJMW0TT8+lZ4MKzb/Hdcyw8X4
 /iLmQckmwtauqfu+45S7ncBm1Pum6GNdnHwInJSYgvusNELvXfCoZINtt/ecXaZTa/8/7Bcu1
 lkZ9snATLlCy8M1gp+3EEWny5vnydhnvEoCjFF34QSYdlZwdB9Vl7geXxenia3fTIgBe+zX7b
 /VCibPE4JbZAF/01Fmsic0+hDeXvm3p+/Lq9cKcQgJZa6FbsHRYWWxDf8XSWyK7pn84t/BQ//
 tHU99sVstlrtvyqTrcrtHWcBjOELPj9rWaDPeTYDApFRTuzTsQjxyLYDsN5OJQQIyh16iRind
 oFXd5Ywq06D05rhEcQYcVqN3D+k7RJTBXqXKE1SmeeBQD7deLn2tL50wjAkQ+2JMV/ax48a21
 KrRUYKW7N6z/BNXWEGR5WeZImIx0aBv2vGhhW8E2D9ssA4WvfzILRUC/UlwaCVZ4DjQyATDYs
 NUU/OMEpMDJQOXU/SQpJY+M0f5+QA7KowOVFQu0wJhU6ZKl9w6GP5JuvLbYIhwdUqnj+qXy1j
 p1GShdjKbopmU5EHRSPAXLeEy0XSHOWy2pEZjYONP0S5sUhrmpSZBo8a/FkwuYqLwAuDLkdCK
 WrmKxM2XllwVLrIC3o8JcCoC7y0ft2HMSC44D435fBTyt4YuAiZXmpRvUu+f+nOIyJ3K6rVA7
 AZFKOorcbyF8hCuGSLwMw3gTzCIbA8eJ7p3tEGQvsfczcw5Wb0SX1yyQ/ydsUDqVfNbbNeOFe
 vjUMhEVQpeJSXi3JpdDrqNiCUtfJIONIPRd4vYmrMZ+QQk0orLHyTyXaqz+FVFS7MZQRvw02G
 UbtDtTc4srVpXgLfdA/VnEBHiGYHTBC55JIs4OlZ6FFmhOSnTiwFDK4gP2BpYQeHXzhvO3M6v
 Nofy1uhSlarJ9mjpyxqu+KJHrsO4yYbGpzmyzhQXXAv5JgViH5J0i39BaqgiSmpVpLIaRM/Mh
 jnY51pNv9uqTRANi0QvRazA2ePI=
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/4 12:46, Matt Corallo wrote:
>
>
> On 5/1/23 8:41=E2=80=AFAM, Matt Corallo wrote:
>>
>>
>> On 4/30/23 9:40=E2=80=AFPM, Qu Wenruo wrote:
>>>
>>>
>>> On 2023/5/1 10:24, Matt Corallo wrote:
>>>> Oh, one more replace papercut, its probably worth noting `btrfs
>>>> scrub status` generally shows gibberish when a replace is running -
>>>> it appears to show the progress assuming all disks but the one being
>>>> replaced had already been scrubbed, shows a start date of the last
>>>> time a scrub was run, etc.
>>>>
>>>> On 4/29/23 11:10=E2=80=AFPM, Matt Corallo wrote:
>>>>> Just starting a drive replacement after a disk failure on 6.1.20
>>>>> (Debian 6.1.20-2~bpo11+1), immediately after an unrelated power
>>>>> failure, and I got a flood of warnings about free space tree like
>>>>> the below.
>>>>>
>>>>> Presumably unrelatedly, I can't remount the array, I assume because
>>>>> the device "thats mounted" is the one being replace:
>>>
>>> When the mount failed, please provide the dmesg of that failure.
>>
>> There's no output in dmesg, only the mount output below. This issue
>> actually persisted after the replace completed. Scrub seemed fine
>> (can't offline the array atm), but `mount -o remount,noatime
>> /a/device/in/the/array /bigraid` worked just fine (after replace
>> finished, though I assume it would have worked prior as well.
>>
>>> And furthermore, btrfs check --readonly output please.
>
> A scrub completed successfully, so presumably there's no hidden corrupti=
on.
>
> Then went to go run a check as requested and on unmount BTRFS complained
> ten or twenty times about
>
> BTRFS warning (device dm-2): folio private not zero on folio .....
>
> then btrfs check passed at least through the free space tree:
>
> # btrfs check --readonly --progress /dev/mapper/bigraid21_crypt
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/bigraid21_crypt
> UUID: e2843f83-aadf-418d-b36b-5642f906808f
> [1/7] checking root items=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (1:27:21 elapsed,
> 435001145 items checked)
> [2/7] checking extents=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (9:00:58 elapsed,
> 45476517 items checked)
> [3/7] checking free space tree=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1:32:56 elapsed, 2=
9259
> items checked)
> ^C/7] checking fs roots=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (0:01:08 elapsed, 12246
> items checked)

So free space tree itself is fine, but the subpage routine is still
reporting that tree block is not uptodate, thus it must be a runtime error=
.

There is a bug fix related to subpage tree block writeback code:

https://lore.kernel.org/linux-btrfs/20230503152441.1141019-3-hch@lst.de/T/=
#u

But that problem only happens after some tree block writeback error,
which is not indicated by the dmesg.

Any full dmesg output? As only that WARN_ON() is not providing enough
info unfortunately.

Thanks,
Qu
