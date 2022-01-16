Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD79C48FF98
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 00:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbiAPXGH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 18:06:07 -0500
Received: from mout.gmx.net ([212.227.15.15]:43841 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233896AbiAPXGH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 18:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642374364;
        bh=/Uw+2zLCEY706HS/cVW0RnoGb7zKy+i8jgq622hVetg=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=SKfDnuXOyAQnOkfQ2W1dosEG3XqCDzDkgTxiGF/3s9dsjrTG6XJ9MTYCF5/OjGFw+
         +A2p+rSg+AzjlEyhf8iDUcFQRQk7gSa4sPDAxNbMz3BY5hnelccdCZm4EWg0pGnynB
         bLdnlZLnYbS17hfgjHqfDJRsNTrIgqBpR4Io8krU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MlNpH-1mSRfS3l09-00liO0; Mon, 17
 Jan 2022 00:06:04 +0100
Message-ID: <9f606c83-6222-fb60-9ada-c6596650db99@gmx.com>
Date:   Mon, 17 Jan 2022 07:06:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: 'btrfs check' doesn't find errors in corrupted old btrfs (corrupt
 leaf, invalid tree level)
Content-Language: en-US
To:     Stickstoff <stickstoff@posteo.de>, lists@colorremedies.com,
        linux-btrfs@vger.kernel.org
References: <6ed4cd5a-7430-f326-4056-25ae7eb44416@posteo.de>
 <CAJCQCtSO6HqkpzHWWovgaGY0C0QYoxzyL-HSsRxX-qYU2ZXPVA@mail.gmail.com>
 <0aed5133-5768-f9c5-492f-3218fbc3bb46@gmx.com>
 <b949dfae-1ff2-1ff4-1f1f-0c778a5f2458@posteo.de>
 <089bc046-9936-3cb7-ea8c-b6ff563dce77@gmx.com>
 <c81eb4b8-f820-d819-612c-ba034e6594c5@gmx.com>
 <c906e9f3-395d-ad07-fb64-aa13be544699@posteo.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <c906e9f3-395d-ad07-fb64-aa13be544699@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1pLC6rZHUYfgKrOHhepkIqakex/4hIapwbcu2UinTBIC0LVEQIu
 mcx9epdeNqJng7tPHDJMxMboC9sgBNlhU3uUUux6n5O3wfsqntVAYtsPtF1E/uej3KZOThr
 jz+lG/MtNFZotTjTNCnUdneALT6TOg/dlWAtgWt31MT1TeaJRLI6HfmAEiQjoinduscBqrS
 k6s3GsnVpWOpRpD95x2XQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LevdsHuSWx4=:zgEr8HvkiQntRh0MlRc3oA
 3mBvVcd+Wf3GcoZf3RR175RMe5MEW3juW25uRwPmJsfPyXhi7S1jdKUtUt695Ry6JwU09v0zk
 V/LPE5ItKrkmS3rtbbVSnIV61WgDjcIvL4LOf2eAT9O9mdGV1mc2lHapyMerBIER1YJbcKB05
 TytO+yGkWlOA4K7AbIPKfsDxiZ6mh+WSitdn30I+SV3Ajq2eCfk2HTV7UGDMy1hWXB5NE/Yvf
 uw1ufhmjSpDsw75nKZ6as/Qd6D5PUv9CXawYQXRnR7xZpdH+ZYbrflN23DElpTeIlvejml8ud
 dny3xkdevHZh1/KkX4wzJ0kBF2T4vF/XLoBctjdHhx1+I61ZJGDblPMiW/uMR4yToIoTlgIOV
 fbyXGipOrNxkJsH8KqcbWAZu+oBYzEP4MKfi+8XPRJgPJ8FcbKLR4a7wDzk6NJ6IcQVPKFWht
 L0tF/6t2Qyz6Lbpia3SK6fkllY9f4wamRguDChbYBoEGGantQRuk97yQm65Pz+Ro02p8T9BMD
 YEJYtHQZlBIsyrASZHCOPBUz9E75I/1jm4gmTpF+wOpiKLWu5ZQC98JqBz6XG0iqbQxXptxnn
 WFIG9r1jmsbKbD23wGv4CUalSTPckKmN8s+WodViNQ+y5DvARVNOsMD5HViSwbX2LprpdQpI5
 qf/fYXYfpT3lS0zeZT8SsinsdffE/8ZzC5yAfmHzEU1PLRC6rYlagF8F/qanbLrfkqOPjD97n
 bqfZB6O40Ap3AEJXULEoUjCEEpCbWJn25Lw8gu7lRRSWpO13Ss8c3lKfrhMfQAe9jSB9uLFrf
 YaRyR1OfT/xG2G8mD6DcZv6hwMWBKEshQbdB+HoTET8JSE0xj93d2CJVKVsXm+m9CQhVSZaG9
 QlvOpwevc6kiDOkpXGHVqKYvQRCp/8yxVNpqDk1qRPBl8Bp1X6d2sArWMCt1q0IYJztZBLnkV
 +ew5Mp/1tEzaIP9U4D5ZNx4xuJlynCNmssgKwc9SqzIzq4uUVwP1HtVHPKu31IUd4xfPQhqKD
 68HdiR0dONvMChdgrZOgQxL1KYNbTIlF0cg52ZIo/yuiZLv15b2WGVpEXkg9cJoEneHmnXrzH
 /JO9CrVVQlJ82U=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/16 22:01, Stickstoff wrote:
>
> On 1/16/22 1:49 PM, Qu Wenruo wrote:
> [..]
>>
>> This is your special fix:
>> https://github.com/adam900710/btrfs-progs/tree/dirty_fix
>>
>> What you need is firstly setup your btrfs-progs compiling environment,
>> then compile btrfs-corrupt-block (make btrfs-corrupt-block).
>>
>> Then inside your compiled btrfs-progs directory
>>
>> # ./btrfs-corrupt-block -X <device>
>>
>> If it runs correctly, it should show something like:
>>
>> =C2=A0=C2=A0 reseted offending key
>>
>> If something wrong happened, it would not write the modified metadata
>> back to disk (using the same metadata CoW mechanism as kernel).
>>
>> Thanks,
>> Qu
>>
>
> Thank you so much, Qu, for this tool!
>
> I got it to compile and run after a quick refresh of git syntax :-)
> (..and a slight hesitation to run a "corruptor" tool haha)
>
> ./btrfs-corrupt-block -X /dev/mapper/123
> extent buffer leak: start 934285934592 len 16384
> extent buffer leak: start 934314885120 len 16384

Stupid me, I forgot to free the path.

But no big deal, btrfs-progs can handle it without problem.

> extent buffer leak: start 934323601408 len 16384
> reseted offending key
>
> This seems to have done its magic then.
> I unmounted, mounted, and am scrubbing the filesystem. It didn't abort
> yet, so far so good!
> If scrub goes through, I'll recreate the btrfs from scratch just to be
> safe.

No need if that's the only problem.

Although the bitflip is not really the problem for the filesystem, but
the memory hardware.

So if you plan to use the same system, I'd strongly recommend to use
newer kernel.

Thanks,
Qu

> With removing one drive from raid, btrfs-send to a fresh btrfs,
> then adding the other drive to form a raid-1 again.
>
> I am really grateful for your help, Qu and all! This saved me a lot of
> time and effort, and I learned some more internals on the way too.
> Thank you!
>
> Stickstoff
