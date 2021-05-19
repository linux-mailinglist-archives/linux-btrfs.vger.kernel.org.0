Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D8B388B48
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346792AbhESKEA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 06:04:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:42625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345656AbhESKD5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 06:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621418556;
        bh=84Cxbg7IsrG9Y36RNvBiaCc8yJJvoiMt1yIVblrLjlA=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=lNd2uqWmO3hFgzq2I+qPAOp0ryznFZ5EvwnnM6lcOqiWreaNk359Cy1j+IuI/sdbb
         ybl4T234G2wSvSxhg6tsMCwjEDNKF6gMT7S/ZEALiPn8YIs+NbV20+5dbu0DonC2FJ
         e3aiiFryb55Pu0qpEaFzdqcmibsk51ysK4tpawlA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mf078-1lH90r13RC-00gcJx; Wed, 19
 May 2021 12:02:35 +0200
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <a924147d-1403-369b-85d5-a5ba5be662d8@petaramesh.org>
 <31eea3fb-926e-ce69-95bc-5ade744100d3@gmx.com>
 <d88d8d90-9218-dd51-a47e-7b7c507eb583@petaramesh.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: System freeze with BTRFS corruption on 4 systems with kernel 5.12
 (MANJARO)
Message-ID: <2e5259da-fcec-0abe-09a6-3c86c1750477@gmx.com>
Date:   Wed, 19 May 2021 18:02:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d88d8d90-9218-dd51-a47e-7b7c507eb583@petaramesh.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SHTDLICZrdSnxby/t1h0JCzE/HihSamJYN1u4t9mmphnqkA4D9G
 qWjaRypxE1QzbSRB6otI62k9FsM9j4/sZq/cSaQpn6eDutw12DQnrJg+Ssba3BNrv9/FltB
 W/dLtStp8UW7bJ6CXc4zQx+gH2gFUk4YN9AWSWMuCmZ9mLqKYkbaZArB4KCb3bU7nGqw8ko
 keBFM0SEk2Ft0XnDOzLjw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:resLMXeO5P4=:faZ4tn0bV/MuUurD3+w+Jr
 NSeK273ZDjRvXPOB6R9eUEKmQJg2y+Tp22QDDr4jNsyBvF/FQT/C7XZFnIPHbzoX8+/c5Hhlx
 0ArBwPkOmV42t8Ww2YPBbRondAyY1CGAfLsD3wkwOpQIZ+0ZAhBCbygvly/ODG5YrHudNs9kn
 LfK6iu5gyLK7haEJpud9YuMnndm0QsmYGQt6Cygj41C4QeBkGa98BvcdQU6lilTyH1pLiUIB+
 kVd3VpezovVK+mHx8ls8q+M1S7Ik7GYiZ5OzPcK8OWzO5Oo15tGul1mokQHfx39/IwOEwYEqj
 ma5LSPyZcrKA4Yk6A0GoFTHBl73LljnSPQJ9RZfr79bnRnGn0UoXEZfY/nVfz8GBOAxnfh+xM
 KTaxdSXVx9Ethj9JJloIo7kG8ygiMf5vpzGKdwiZd2s7ZSLWej0afehRTHuipNaMAUvDe5muX
 psdepHLGm6/1yyYGvLys5PFeFRWaoMxfTQ0w3U997tx0A21ebB2YGatgLkRKTPlT+5r/tXvyC
 BhrKlvp/G3GEeuPXDo/xtLw1vUWcxXmOjCn4f7sThGdgPmxud+55uBrZrGhVZoBgL0BCUHCsN
 e4u2XdkCUjrEwFek7TOjUy4/P8AOLOOMG1Fa8bIjBdOio4+ThIWR/qLJ3ZjfpyuGaIIh4Ipp0
 Ms+oWqKfY1vSRTpJcTN6CWdbR/F4kH78SQ5MiJf+11njI5CSgjUA919GDGbzD5dEzdh5Spou2
 5CvuTuyD/IwWTxO5EjxhGq9CSmtWCvq6fPFEF79DZau2sOxGtpQ0w07Ti9z4iXScSHje4NtOM
 UZzrg02/UkZxxcEKqSk2zYIIz7tny+Yq3mkLPryhVssdyoVuyE22eZXWfu/64L6z3MT9PFJWa
 VNv+InAdZlxB3pY1meM0/ZDtDDx79++lNzZ4f+abgl7todg62zDMsKcnBBHPh2edd11lexaZU
 wgZfr9SC5NzQ7OwC/dahNsx37i0HuAqGhI464mloPbSJtCJSZYwFcd3YjvwuGZx81Yq5OXWd0
 RzYSW22TvkyA4knk26dtKHR5h8VmFohgj4Hfn1814tPu7H1J9D5O1ghUwmDZD+Oli44mnubeA
 KXN0fmiIEwFtFW3Nz81Mpg44VdKfbr9CLso2pPGB4OlECeqk6Iza4SLVh+lJPjWb3P17Pstc3
 ucYmcfQB9PQOPD/GoY4c8qKiTP0TqRmhxWiQKJHehpSFLeW2MDUEPjtQtZbR2jwhDjBHKScTE
 C1daL0RzmdzmuyPOB
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/19 =E4=B8=8B=E5=8D=885:17, Sw=C3=A2mi Petaramesh wrote:
> On 5/19/21 9:25 AM, Qu Wenruo wrote:
>>
>>> Kernel affected : Linux 5.12.1-2-MANJARO
>>> (Not sure if I tried Manjaro Linux 5.12.1-1-MANJARO)
>>>
>>> Kernel not affected : All previous versions up to 5.11.18-1-MANJARO
>>>
>>> Symptoms : Under heavy disk usage (such as performing a system backup
>>> onto external USB HD) the machine soon completely freezes and only a
>>> hard power cycle can get it out of it.
>>
>> Any dying message?
>>
> No, just a sudden and complete system and disks freeze. Thus no
> messages, nothing logged.

Have you tried something like net-console to catch something?

If it's some hang, after 120s it would have some dmesg popping out.
But in that hang case, you should still be able to do a lot of things.

If it's something like BUG_ON(), it would immediately show up.
(And if the trace is not btrfs related, I bet it's something in the dm
layer)

Without the dying message, it's really hard to further debug.

Considering you have so many devices, it should be pretty simple to
setup a device running nc to receive all the net-console output:
https://www.kernel.org/doc/html/latest/networking/netconsole.html

>
>>>
>>> After reboot, systems on which BTRFS is built over bcache may show hea=
vy
>>> filesystem corruption.
>>
>> Which kind of corruption? Just data csum mismatch?
>
> AFAIR it was some kind of =E2=80=9Cgeneration mismatch=E2=80=9D, expecte=
d something,
> found another, in very large quantities.

That means flush command doesn't work as expected.

Considering there are extra layers involved, it's pretty hard to tell
which is the cause, btrfs or dm-* modules.

>
> The machine with BTRFS RAID-1 could heal itself out of this by running a
> simple btrfs scrub,

This further proves it may be lower layer doing something wrong.

As if it's btrfs itself causing the bug, the transid mismatch shouldn't
be recoverable at all.

For btrfs caused error, it would be broken COW, thus all copies should
be corrupted.

It's really a good practice to have LUKS under all your fs, but it also
introduces an extra layer of flush problems.
Did you have any raw btrfs directly over HDD/SDD experiencing such problem=
?

Thanks,
Qu

> I gave up on the non-RAID one my previous experience
> with similar errors making me think the FS was beyond repair, I
> reformatted and restored from backups.
>
>> Does `btrfs check` reports other problems?
>
> I didn't try.
>
> Thanks for the quick help :)
>
> =E0=A5=90
>
