Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49ACB3C7E59
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 08:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbhGNGIp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 02:08:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:39905 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237946AbhGNGIo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 02:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626242750;
        bh=aBUdDV5NQB0B5dnG/dXJ1JRvaW0MDXxWAyCPjnBvkLQ=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=Ujrkvh+CgC95+EOEZCsh3dTlR0/fwAVmzgjt50OFW0FJ9oObe5O9H1BgwECfJx+um
         2iuqc/s3V3C/UyPCOTFI1dQL1WChTe1hAlDFazZo/ZooGVIMSPeulb/vvqNQAauoIc
         qSavfSVbS3fT7r/4kUacxaqvxdNu6SharWtQ6Gpg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbAci-1lSHKf21N2-00bdfe; Wed, 14
 Jul 2021 08:05:50 +0200
To:     Chris Murphy <lists@colorremedies.com>
Cc:     DanglingPointer <danglingpointerexception@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <63396688-0dc7-17c5-a830-5893b030a30f@gmail.com>
 <86f0624a-cba4-58a3-0a80-460d3f12e8b3@gmx.com>
 <CAJCQCtTFkYHocpdqtS=1y-At11wz5-Kv4Tx5D-QeRg9JpEGdMA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: migrating to space_cache=2 and btrfs userspace commands
Message-ID: <889c88ad-f51a-5b1f-3613-0b78af77477c@gmx.com>
Date:   Wed, 14 Jul 2021 14:05:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTFkYHocpdqtS=1y-At11wz5-Kv4Tx5D-QeRg9JpEGdMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ss2ZPlr6Ww19x6czgx+h5nhCiPfCm62V9/yN7KRO+iSt5KvSXFz
 ALbV3m0amUHBkRULow0grWYymJLcIymf29HgS/OFudUgfd6+Gr9dvmh+HSExeqNuJvHADde
 6RB2MVtbijfgvMrddE3uYgR7VHxw9PieN1sD6MsNFZeyh2Yz4v1bFvVKs/GTTnsIL/FSt1N
 a04fAiXlgtE9WpJehsmsw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0IdmLlmQbcU=:9kRFRIDusrgEgyfXmOEVND
 FV+53+jRmtBCiW5w3rgC88ZAq/Vyp4WLv/8yX9w4a8QcwIOe5c8DETNMp2MNLkJmME48WZQKo
 Yodg3Bqs7wzwEuLTtbVQirZDi72tH6TWNZcsM0tBGUbd6FgcGJVqWt9oVaKVc7jgAlWtkEjzZ
 to+7Rm5KttSS3+zbparZBDxwJt432reJCt+S9bYOxkYJH+I4SSMBEMlXle8mtDzC/EyYcCKEx
 Kaiym3ToXHy8HfnEPn1/d7fkfUoZiWmtDRTFPiaGIVC2Ghrq67FucoHx9KRKZgSP2G0AxPERK
 cQLOaQDKp3B2CzOF3VDfiNh/BP1zaP2rqHbLAkeFmR/74bP8hgSq/A8IpQID/AU/TwHJMrDOL
 XlzYjs1BGDom29y9YECqEXlpJM9ehpFNr4ndxxMf3pXZexaYbtngRmja1rbkDznuokFRnbDcZ
 MPfzg0W8EZOq/9vdFZ776UZFvBh/JX6jYxOKIAKusrXgPOL5bLeEXUXeVKl2GHyN8w0Rmdp3L
 L1rTbeDFkTqmIWNwsJV9+NqOtP6uiszLajAo3EUAxQutmKUEvBsLCy7k62ENiAR/obB5d4MeJ
 SCwRTJqclA6nty8L/E04AwdnIOvNmQwOURverUwTwuis4WAKZeTJnD5wq6beN9unAu1QG2NQP
 7HjdnGT6wnqAIe44wEVJji+bAUz38VoQV0td+s+oMVXtHOTDLr6mtUo0JelorzSnNtQz9myZW
 Uh7/6jyzSwTl452cq43AEkrwTqGASwbS5JXdOlXB6auQRTHVhfPuX0uwydVqeCcuHPhbkh5Oi
 /bVTB2NMu11o09hgNA0QEfHDZwl/Gq3iWs6wJyZmN3a3QhEn+ocxCzezcq/Y8tk7mpokXaEIa
 Vcss5/6TpXWegLuBbZD9DLz3Qij44w5PE+ZLwJ7mLZf9NQbcZmJE1D1lv8W3wD37i3sCrvrYW
 CVUiR+Ir9s2OxfcisL+kvsSRCuhebrPB+bVY86zUj2ZMZRj0odxb121unhj5sy/YhpMPM/KbR
 G771i8Dau+Nw4Pi4kaAkMARSFOpyxsSvY4PJzuWj4XSM083Razsz8XwnLPPAwvejy8cpMYssk
 KBKwkYnvuDZos1XhZcRdroZAUscSPQ5Srx3MDnO9Joh8jc4VjXkxloE4w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/14 =E4=B8=8B=E5=8D=881:44, Chris Murphy wrote:
> On Tue, Jul 13, 2021 at 10:59 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2021/7/13 =E4=B8=8B=E5=8D=8811:38, DanglingPointer wrote:
>
>>> 2. If we use space_cache=3Dv2, is it indeed still the case that the
>>>      "btrfs" command will NOT work with the filesystem?
>>
>> Why would you think "btrfs" won't work on a btrfs?
>>
>
> Maybe this?
>
> man 5 btrfs, space_cache includes:
>
>   The btrfs(8) command currently only has read-only support for v2. A
> read-write command may be run on a v2 filesystem by clearing the
> cache, running the command, and then remounting with space_cache=3Dv2.
>

Oh, that's only for offline tools writing into the fs, namingly "btrfs
check --repair" and "mkfs.btrfs -R"

And I believe that sentence is now out-of-date after btrfs-progs v4.19,
which pulls all the support for write time free space tree (v2 space cache=
).

I'll soon send out a patch to fix that.

Thanks,
Qu
