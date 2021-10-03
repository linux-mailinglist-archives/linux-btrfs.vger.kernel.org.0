Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48735420027
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Oct 2021 07:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhJCFL0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Oct 2021 01:11:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:50671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhJCFLZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 3 Oct 2021 01:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633237777;
        bh=LitTU9t8Vj51u+jxH2xD9IB4bRPvhU0fiKGk8j79ULM=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=KRXSFfZ2ZTyfrPerPufeKb+rzQ+qWR/xaIcrn1rAt3FxXfPAelX7mkpyTXJngcBvh
         CCbwBsuI+E7bBCcgpBLdx34jAR+3fASHlOr1juobwljeA+AYXjIH8rUwZOlkeEJl+Y
         bX5WCmWeCWTHMf3YKyn39DreKLaothDdHIzXU3v0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTABT-1mNIjf2VjT-00UYCp; Sun, 03
 Oct 2021 07:09:37 +0200
Message-ID: <393db99f-705e-b979-a01b-a2b306480987@gmx.com>
Date:   Sun, 3 Oct 2021 13:09:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: Filesystem Degradation and transid Verification Failure
Content-Language: en-US
To:     dmzlaamx@gmail.com,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <001201d7b77f$74fa76a0$5eef63e0$@gmail.com>
 <7df50802-a70a-d468-0b6f-de08edceab33@gmx.com>
 <000401d7b802$108b50d0$31a1f270$@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <000401d7b802$108b50d0$31a1f270$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:346LxXSLT/qlp4xIQ/nvRzePHkaQqgWCqoVKK/lQQQ+9rvXXkXO
 eP7yByLlRrdLfCPeLKudVzOskO1/HigSXiHS1YBHGEFL0XEDbTOx7rnU1J7fjQBBLh0u53B
 AT6nZqdxIsPjBMRqNUdN71277vER8SKNzMmb3ft3C//XsQFEVF7lyWEEdlOuzLGhrBI0Hrw
 n83HPCLEQ+UxJbNiniGZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7SxnPNwula8=:Xj9FgXZY2suE8x42M9neR1
 7uz5dDaZa1bUiMw5MpeBmGkt4R98wqGUZOPXVHoR+lJOABefJNv6wrOCSXjLPmJ0gGNx6mgxI
 IvEATknRrKeOYDmJcJvncqI57JNmcmJ0EWA7fjL8XJz2BJJ2i/1xBnCpEXttQieM1mHsCSupv
 BwELXwhGVE8N8oJ5zkkX1dGi8YcbIJ0mT9TdpudGVUB8exnY45Hq9iDJc/L/wtNGDMVI9Enlk
 VcRWKzvfk+YZ7eBZ4R3nK2BJnj5wvBKpuwow6/OnJ0VniToX/MBMi2vb+2/iIMFyKAQ4CYHap
 KSWSJx95cugfdAJVOilZw0vb68Q294ASRWRT4z25akMocxkiC0fU2MXuCF1Up54M8tBy/9S20
 I0dKvz+fEn+H4RknAhZDFpn0inwsrZ+x1FhYy8Oro2PdJzbZbqCrnevB1GAIuywNmtmB9uYMr
 m8vPqr7JnVaENXHuGxBmWczsUKaYcP2FmSK14FwMzegYhRs5OqylfBEpFBBMdsb5/oEonN9MU
 GJkk03h3gobmxEkJNSXYZ0lsiNVKMCT5PQ7klAualMGSF40u60fmX2f8plvOR8HsBVBlYtcpS
 seVhwLHXRGuieI9w7YMz40kPF44Dy/x+ai3BnNoln9OVc1rCM6IPpposOWXcmseNt+yqaG1GD
 Z2rWb9sqR0rJEo7cHleZ8mw2SAxSej28L2kYlrZoGee9J3F0x5pFhxiYhJd/CSIm8etx5qzOX
 sWFGP5m6GwUXmy5CM5xCsqPg+fZTIDa7laC5qRzXG6IIQHwn6XisEcbscqona5RtpxycRbMOQ
 z59/9on6Pz7Qw7xEr0G88jJM1s6nWByOBd1iFxD1oQUsk2laG5nHSvVQLMjwxiuoVZ7lHw+HS
 YkMRAv/veB3xw8Ur8NRnpxDRy+rXS2uEdFHZFsehytsdVyVeqxSalpUNWCPQbnx+7byCcV7h+
 6ECA+zoJfbMkYzDsO0QwzM0gB9yOE7PPhS0cnLJVXizJgvuDO96Gmu7UQTuULJ+TT+i0jGMIo
 KPJwM5bzmGzHECiMvgQdO5qcK9Hm4kDD/+ymUK7tc5HzmNY7byPf9gSI+t1PocptAH3dpVznx
 SkGsCHR7MGFNGU=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/3 10:55, dmzlaamx@gmail.com wrote:
> On 2021/10/3 13:23, quwenruo.btrfs@gmx.com wrote:
>> On 2021/10/2 19:20, dmzlaamx@gmail.com wrote:
>>> Hello,
>>> I must preface this by saying I have never used a mailing list before
>>> so please forgive any lack of understanding of the protocols and stand=
ards.
>>>
>>> I have been having a lot of trouble attempting to recover the
>>> filesystem on a single 6TB disk. The drive can be mounted, but certain
>>> folders return =E2=80=9CInput/output error=E2=80=9D when attempting to=
 access them.
>>
>> The error is caused by transid, and according to the expected transid, =
it's a missing write.
>>
>> This seems to happen either you have mounted with "nobarrier" mount opt=
ion, or the device has non-reliable firmware handling FLUSH/FUA commands.
>>
>> In above cases, a power loss can lead to such problem.
>
> A power loss is what I assumed, interesting to see that it's very likely=
 the cause.
>
>> Mind to share the hardware model and firmware version?
>> We're trying to collect such known bad HDDs.
>
> The disk model number is ST6000VN0041-2EL
> The disk firmware version is SC61
>
>>> I have attempted btrfs check, recover, restore, and rescue, and have
>>> managed to recover some of the data =E2=80=93 although the folders whi=
ch
>>> presented issues have not been recovered.
>>> Btrfs restore returns transid errors even with alternate roots.
>>>
>>> I want to run btrfs check --repair,  but before that I want to check
>>> if there=E2=80=99s anything else I should do before resorting to that.
>>>
>>> Supplementary info
>>> 	uname:		Linux eros-station 5.12.9-arch1-1 #1 SMP PREEMPT
>>> Thu, 03 Jun 2021 11:36:13 +0000 x86_64 GNU/Linux
>>> 	Btrfs version:	btrfs-progs v5.14.1
>>>
>>> The results from the two other btrfs commands are attached, including
>>> the first few hundred lines from dmesg.
>>>
>>> Should I attempt repairing the filesystem, or are there other options
>>> I should try first?
>>
>> No much thing can be done if you have already tried btrfs-restore and g=
ot nothing you want.
>
> Does this mean that I can/should proceed with btrfs check --repair?

Yes, as I don't believe there is much thing can be done.

I'm afraid btrfs check --repair won't bring much help either.

> Or is the data totally and completely unrecoverable, even by a data reco=
very company?

The data may not be fully destroyed, but we lost the metadata to reach the=
m.

Not familiar with data recovery company, especially not sure if they are
familiar with btrfs enough.

But I assume if they take the full binary dump, and can do a full
metadata scan, they may or may not recovery some older metadata to reach
part of the data.

> Just wondering how screwed I am.

Not your fault, but more like the fault of your HDD vendor.

Thanks,
Qu

>
>> If you still plan to use that HDD, then we recommend to disable write c=
ache:
>> https://btrfs.wiki.kernel.org/index.php/FAQ#I_see_a_warning_in_dmesg_ab=
out_barriers_being_disabled_when_mounting_my_filesystem._What_does_that_me=
an.3F
>
> Alright, this does seem like an important thing to do.
>
>> Thanks,
>> Qu
>>
>>> Thank you
>
