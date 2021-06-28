Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B310B3B5BC1
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 11:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhF1Jzz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 05:55:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:59453 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232488AbhF1Jzz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 05:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624873980;
        bh=qzwz3PtAy8XAc7zNKULqS4rQcgX9ettF70dFJh5ft+Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dFD55RX8tJQsQkhv2SnpSvpjaZyOJXdI0ppAuTn1dkf+IOI92hFV56ehTMHLmLR2z
         Uh3bqfMZ22FjdgaaFhKRSVKFuvihFfWmKOUDMMfTnns5f+LoZb1ubEheF/IDjL1IO3
         pq342ijwW0rEtjoenF10pl2W9gpX2h7H25BxWPoM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M72oH-1lsYTr0dId-008aLl; Mon, 28
 Jun 2021 11:53:00 +0200
Subject: Re: [PATCH] btrfs: remove unneeded variable: "ret"
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "13145886936@163.com" <13145886936@163.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        gushengxian <gushengxian@yulong.com>
References: <20210628083050.5302-1-13145886936@163.com>
 <ee06042f-da1a-9137-dda3-b8f14bf1b79a@gmx.com>
 <DM6PR04MB7081A02339DB3ACC72F86261E7039@DM6PR04MB7081.namprd04.prod.outlook.com>
 <PH0PR04MB7416F1BC157F848540DF37389B039@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e73fd408-d5c3-0e17-b3f4-e12f2c105bc0@gmx.com>
 <DM6PR04MB70814C2126868BE1DE1DDC19E7039@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <4d439ecf-56ce-76d9-83c4-d161143b898d@gmx.com>
Date:   Mon, 28 Jun 2021 17:52:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB70814C2126868BE1DE1DDC19E7039@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8V3nm69KoH2KuRY6n8o2mU5xDywINJI5vKy3j0tPvMqU482QK9M
 wpgaLOSwfh2pfwBqb1ICafGWQw4BKcKIlGXvflulTDepYylJq0wlbzM2nEbmdtw9zWsCXkH
 I+0xynJOwLUtwzgVEVW+Ul95aJdQqSN+IV5xGpuuROgBfeFgArBGnwNalsmPlpEdF7MenhE
 6KGHVynoX+UsnPIBQjVfQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yIeWy4OLw94=:s0a9ivvvTIIY+5bmR0bhDA
 9WdqkHiYp4oK27HY62bv9FbEo+OBvvaXBN3DOL1ach/ELRFggMWy7exklZsZ4QNEGWfRhbgDB
 84M50bjyTjrEiImQ0hjmH2WIfnuh8C+WbSycf+wixoZuE9cojNkNdCYkd9WWkE67mdcxoTo3U
 uWmO5pBOp96kbqi0fgJ5qXqiMXp2siF3QHlYH0y2h1WtCq8SHfdgLLnpVIhzge9WMO68wTpcj
 jgQRF40LxvnADrz7kDBXGBtaV0mIPWGgjNOkApmKCKB9+itD2oXYBk6e9gQn02BZ6/f6UUd5n
 cbUjKzfDRJFHArmLTFuNRJaXte1VxFML7sfc6/IMwlUKVcl0XTRUgFZjvWw/7FzXWy6npWLvQ
 7joWxLV9n4avGh+S8UYofIZPwD87RXmXVVs/owmRjbYNbIFKZlcsx+zE38SSpm/w4xMKV1xc5
 Dhfr1kJig0nxvx5o/KAbUNUE3RRW2Qg1i90w2/dL/hRYvh3itRXT2wyjAXLahauoHo0mtVOI2
 aTLJo6bZSoJ74Snse/lVh56sYRZ+rkfSqsj/QjDafP6iWd//eruFKePUpOse0gskkW2Auf9hz
 VJDCDFwniCUA0HCQK1+JttfNrWOsEI4sZ6lpls94/opYq7i7iHX1NOz5WI6XfhDSU+20fSSqR
 GUrZ/AF84LGqhWwdENA9mc5O0/qCUgEV9z1LSF2pNJgXvJah6g1EyhsrTOOJnF51999PonRsK
 7Izv+FNTIY7MyNtfXsUtL9WxGRrB7kVNqMu31oJWdrFLNGD8GFoArjcW9B0srXxzc2CYzLMFB
 1g2wm1M1vHAtMvsnL87mYauAatZoKt1oRoACm2vPvWJH7LzJrCQnJ60HE967ETubqn0qJwq/f
 BI+7h8jY5+fY01XWDZaejrETBjaTaCyA28VjjNIfH4hi3Jz9Ojz78skqwvj3/JVo2DdEOotxv
 ZXyUu4gq0Tp6qX7wgkTnaVc3KsR9km7waIPzhSLSmy/QDfCnL8ffE8153RxygZAQ6Y1qnJ+b9
 +f6Nx2rtJAF/9J/Ryhjqiuz3xwY60UnUz/SPC2P1hOk991KpkUVki+DoBb5lzoxozSpXiij6b
 fvitl5gpAuMjW6xXqvKOQQpEFTPWYRv6ei9cBt8WmE+vwftWyIt+1npPA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/28 =E4=B8=8B=E5=8D=885:48, Damien Le Moal wrote:
> On 2021/06/28 18:45, Qu Wenruo wrote:
>>
>>
>> On 2021/6/28 =E4=B8=8B=E5=8D=885:38, Johannes Thumshirn wrote:
>>> On 28/06/2021 11:34, Damien Le Moal wrote:
>>>> On 2021/06/28 18:22, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2021/6/28 =E4=B8=8B=E5=8D=884:30, 13145886936@163.com wrote:
>>>>>> From: gushengxian <gushengxian@yulong.com>
>>>>>>
>>>>>> Remove unneeded variable: "ret".
>>>>>>
>>>>>> Signed-off-by: gushengxian <13145886936@163.com>
>>>>>> Signed-off-by: gushengxian <gushengxian@yulong.com>
>>>>>
>>>>> Is this detected by some script?
>>>>>
>>>>> Mind to share the script and run it against the whole btrfs code bas=
e?
>>>>
>>>> make M=3Dfs/btrfs W=3D1
>>>>
>>>> should work.
>>>>
>>>> With gcc, unused variable warnings show up only with W=3D1. clang is =
different I
>>>> think.
>>>
>>> Nope doesn't work here, as the variable is actually used (but not need=
ed at all).
>>>
>>> make M=3Dfs/btrfs W=3D1 just prints some warnings about improper kerne=
l-doc formatting.
>>>
>>
>> Yeah, that's why I'm asking for the script, which could be way more
>> valuable than all these small fixes.
>>
>> And, again a Chinese company doing the same tons of small fixes...
>> So nothing could change their behaviors, no matter whatever...
>
> Keep cool ! This one is actually a good fix :)

Yeah, that's why I'm not that exciting.

>
> Just did a make with gcc 11 and W=3D2 and this warning does not show up,=
 but there
> are a lot more warnings about unused macros and some "variable may be us=
ed
> uninitialized" in the zone code... -> Johannes ?
>
> There are lots of warnings about ffs() and other core functions not in b=
trfs
> code though.

Hopes those guys see this comment and do better and more structured
cleanup before any of us :)

Thanks,
Qu
