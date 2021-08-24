Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726563F595C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 09:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbhHXHue (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 03:50:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:56725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234616AbhHXHue (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 03:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629791387;
        bh=vn/8bsVQlzs8Z8bCof+YXwW10aTNt+XPMmCaYmsTRP4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ST+IOvBxcc3m6ejwsL7zZ7ooUMBgHIPEGr6Dcq/qAO7jY+OTEVWZVtwVVSTdomcVD
         yFdOcPa/hJSHuqMsqb/7RE0M14B+aSsN+qIYOnGhnqeXTQitrfcZSAMIYKADEfJWjD
         V9gzqKWWir7h+0qBj4DobIFSGMoUv4Usnuq35wSM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M4axg-1mHsxY2iUY-001iLu; Tue, 24
 Aug 2021 09:49:47 +0200
Subject: Re: [PATCH RFC 0/4] btrfs: qgroup: rescan enhancement related to
 INCONSISTENT flag
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210822070200.36953-1-wqu@suse.com>
 <20210823173025.GM5047@twin.jikos.cz>
 <9d957532-5473-feba-6ad6-695d459a85bb@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <30cf7d9a-c1da-ac96-ba92-c8456692f854@gmx.com>
Date:   Tue, 24 Aug 2021 15:49:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9d957532-5473-feba-6ad6-695d459a85bb@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mCFAgxwMu5EsggG+KslfnfVxDc5wKpJp1ycCbtuffOpNXFVXs8h
 cONFF/DyQeoYAgWP2aa7axddT7eH4xAwwdRg4wvGvwZgyfihDvdq8lctrv6uNVULY/Y5DEF
 DcVatysOLPg5Aqq7jM+/0cGUc9mDNZk4Fg7tJtPlj56hefpDZkKaJx56U7aRxKtRyRaPTF9
 v6yecmhn6v9eRuScO5xtA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:t/2QEfb4Pzo=:wor9+Jega3hS/vAVGEkG/Q
 tD5RClalHvz3Nj4RUpiOXUoM+ybvkrJklZseyk1gt9ktaIIEBYZ0ApWKQxh2fY0jz6dLWO/y9
 yexNL+3ac66FUlOWpXZE+Innu1twodJIyQ1wGwHjLdKlTJiMcak3Vzy3DtYnk5aNfUvQFpCtv
 Bd11Wi0WO4zhhM0zboPlPDo6/7lAAHJdkgPDopOUwZSTDa/uU6mWF8B9yNj+YmnTr0ejnACuV
 i9VahVDWg21ejwnoG2MIiS1Qkza1bCak3vJdgviYuABjeJh+czvZdFNEzZzGmtrTGJidEFaBG
 T4Pn7ez2W4HFawTt4CHwrX1dl3e1I/O5mWP6/opYRHUHttgosnRCSvSU3W3zJpe6el0Fthpkc
 o65Ga7QTDXQrdWJaXCi/yUqPNKOIDjNvBPYkq9mvaNPlDwyGnimF/eZrMqip6WL6JCTC9hXBt
 3uYT5ytd6acVVXX/ln35selYu5ENy5OZ+Re0+xN18G3NYtHZiknFbuF2iYAV1AF9oRi0swEDp
 QLYRQF/CmaolCYLiQInH5F/GG21gQBq2eZVOGT0gua8GCehdierjUQV5/mHPxHQkXeLJFf7L4
 AGiGDfnULRejzypVLvQHTZooKbz/XUOESzq2Nply3wKbM7cYoJ5Wbxch83gk8+9minQDILBt7
 oYAL4KEdjpKKIQ9TI765Qw/XrMUCCD0hMOYodF9+PZexKFgedvGv76U+6nJp8dqwEI5UASEUO
 pPJSOntWE55xbdsR2YgaqSHoPeTrpGmuPCGy+1KyI0deQxhwBFotMokElnFvyE3/V/NYM6AyQ
 up/0JM8Xcdtxuq2OiRQ56w7IU/PJnAA1HnMFSbdpsP/QQWrKr42F2SGaGseBXvPw2CSiyhSZw
 MUZl9r7u/ho9Op8OyBah4unvwRfRJJESK9YZfDKW5RY4bOhUtSJAJsfpKP7SpmLXQ3FJ1mBuT
 RcK/yF3kfKliv1c7HqzVhNmWM/0EMUcGjeKbzd5hGdFsOX1fwpZTRVqMLJKR1aEmRtCHii4AO
 GA35+7mk344N7AVUHnyzp8ARaVMWQUwp89HaVHfcrmZkjCNBUZvG97IfhtEjUrt3fCdnkI6kq
 g5ZqMgzWDzvCeMT8/S+iS6u2kxDJw6asaPx94EUbckVEOsW8h8gb+Bfsw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/24 =E4=B8=8B=E5=8D=882:54, Qu Wenruo wrote:
>
>
> On 2021/8/24 =E4=B8=8A=E5=8D=881:30, David Sterba wrote:
>> On Sun, Aug 22, 2021 at 03:01:56PM +0800, Qu Wenruo wrote:
>>> There is a long existing window that if we did some operations marking
>>> qgroup INCONSISTENT during a qgroup rescan, the INCONSISTENT bit will =
be
>>> cleared by rescan, leaving incorrect qgroup numbers unnoticed.
>>>
>>> Furthermore, when we mark qgroup INCONSISTENT, we can in theory skip a=
ll
>>> qgroup accountings.
>>> Since the numbers are already crazy, we don't really need to waste tim=
e
>>> updating something that's already wrong.
>>>
>>> So here we introduce two runtime flags:
>>>
>>> - BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN
>>> =C2=A0=C2=A0 To inform any running rescan to exit immediately and don'=
t clear
>>> =C2=A0=C2=A0 the INCONSISTENT bit on its exit.
>>>
>>> - BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING
>>> =C2=A0=C2=A0 To inform qgroup code not to do any accounting for dirty =
extents.
>>>
>>> =C2=A0=C2=A0 But still allow operations on qgroup relationship to be c=
ontinued.
>>>
>>> Both flags will be set when an operation marks the qgroup INCONSISTENT
>>> and only get cleared when a new rescan is started.
>>>
>>>
>>> With those flags, we can have the following enhancement:
>>>
>>> - Prevent qgroup rescan to clear inconsistent flag which should be kep=
t
>>> =C2=A0=C2=A0 If an operation marks qgroup inconsistent when a rescan i=
s running,
>>> =C2=A0=C2=A0 qgroup rescan will clear the inconsistent flag while the =
qgroup
>>> =C2=A0=C2=A0 numbers are already wrong.
>>>
>>> - Skip qgroup accountings while qgroup numbers are already inconsisten=
t
>>>
>>> - Skip huge subtree accounting when dropping subvolumes
>>> =C2=A0=C2=A0 With the obvious cost of marking qgroup inconsistent
>>>
>>>
>>> Reason for RFC:
>>> - If the runtime qgroup flags are acceptable
>>
>> As long as it's internal I think it's ok.
>>
>>> - If the behavior of marking qgroup inconsistent when dropping large
>>> =C2=A0=C2=A0 subvolumes
>>
>> That could be a bit problematic because user never knows if the rescan
>> has been started or not.
>
> I guess for the end users, the new behavior means they should know which
> operations could cancel rescan and cause qgroup to be inconsistent.
>
> For now, only qgroup inherit (snapshot creation with -i option or qgroup
> assign) and large subvolume dropping can cause such situation.
>
> If there is something like snapper running, we can teach snapper to
> check the qgroup status with an interval.
>
> But for non-snapper qgroup users, it can indeed be problematic,
> especially considering how frequently snapshot dropping can be.
>
> Any better idea on how to balance the performance and qgroup consistency=
?

Another idea is to allow the user to specify the threshold to skip
certain subtree drop.

And by default, we set the threshold to MAX_LEVEL, so no subtree will be
skipped (aka, super slow drop, but no sudden qgroup related slow down).

For the qgroup inherit case, it's no difference, any caller that would
bring qgroup inconsistent should know what they are doing.
Thus only the subvolume drop is the key.

Any idea for the interface? Per-fs sysfs? Or mount option?

Thanks,
Qu
>
> Thanks,
> Qu
>
>>
>>> - If the lifespan of runtime qgroup flags are acceptable
>>> =C2=A0=C2=A0 They have longer than needed lifespan (from inconsistent =
time
>>> point to
>>> =C2=A0=C2=A0 next rescan), not sure if it's OK.
>>
>> On first read I haven't found anything obviously problematic.
>>
