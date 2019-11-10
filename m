Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB69BF67EF
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2019 08:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfKJHs4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Nov 2019 02:48:56 -0500
Received: from mail.rptsys.com ([23.155.224.45]:40670 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfKJHs4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Nov 2019 02:48:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 47B04BEE66876;
        Sun, 10 Nov 2019 01:48:55 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gPOmUHKjgkyk; Sun, 10 Nov 2019 01:48:54 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 4B9BDBEE666A6;
        Sun, 10 Nov 2019 01:48:54 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 4B9BDBEE666A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1573372134; bh=969y4amN4AnLVSWLArGCaoxfy9QHehgEbC5bfAQaBk8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ausnfbhYZvf5M1X+Ha1nkqClbEoWGIC7DmfaDqC34f4dnXaLUeevc8OKBrFvCeDnE
         1bkcxzRtotj9/1GAcpZ7yR5ABgMLTYICmvB1gVw9qDlGW4eKSBqAKU4GkvMQH72HIk
         jGHhlpMvkhuBnpwagy2f+uUY9KimkMNILfXOngYo=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dZnCTzLlBhWS; Sun, 10 Nov 2019 01:48:54 -0600 (CST)
Received: from vali.starlink.edu (unknown [192.168.3.2])
        by mail.rptsys.com (Postfix) with ESMTP id 21B9CBEE66653;
        Sun, 10 Nov 2019 01:48:54 -0600 (CST)
Date:   Sun, 10 Nov 2019 01:48:53 -0600 (CST)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <1414992181.132590.1573372133022.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <4c5b062b-30c7-2707-2bef-0ea5f18265c5@gmx.com>
References: <344827358.67114.1573338809278.JavaMail.zimbra@raptorengineeringinc.com> <5d2a48c3-b0ea-1da8-bf53-fb27de45b3c6@gmx.com> <1848426246.125326.1573368477888.JavaMail.zimbra@raptorengineeringinc.com> <64be1293-5845-4054-8d5f-b9ff79168a17@gmx.com> <1503948411.128656.1573370293214.JavaMail.zimbra@raptorengineeringinc.com> <4c5b062b-30c7-2707-2bef-0ea5f18265c5@gmx.com>
Subject: Re: Unusual crash -- data rolled back ~2 weeks?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC73 (Linux)/8.5.0_GA_3042)
Thread-Topic: Unusual crash -- data rolled back ~2 weeks?
Thread-Index: KtRoJGjHbdtjK48XvGdD7m6d3D8RoA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



----- Original Message -----
> From: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "linux-btrfs" <linux-btrfs@vger.kernel.org>
> Sent: Sunday, November 10, 2019 7:45:14 AM
> Subject: Re: Unusual crash -- data rolled back ~2 weeks?

> On 2019/11/10 =E4=B8=8B=E5=8D=883:18, Timothy Pearson wrote:
>>=20
>>=20
>> ----- Original Message -----
>>> From: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>>> To: "Timothy Pearson" <tpearson@raptorengineering.com>
>>> Cc: "linux-btrfs" <linux-btrfs@vger.kernel.org>
>>> Sent: Sunday, November 10, 2019 6:54:55 AM
>>> Subject: Re: Unusual crash -- data rolled back ~2 weeks?
>>=20
>>> On 2019/11/10 =E4=B8=8B=E5=8D=882:47, Timothy Pearson wrote:
>>>>
>>>>
>>>> ----- Original Message -----
>>>>> From: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>>>>> To: "Timothy Pearson" <tpearson@raptorengineering.com>, "linux-btrfs"
>>>>> <linux-btrfs@vger.kernel.org>
>>>>> Sent: Saturday, November 9, 2019 9:38:21 PM
>>>>> Subject: Re: Unusual crash -- data rolled back ~2 weeks?
>>>>
>>>>> On 2019/11/10 =E4=B8=8A=E5=8D=886:33, Timothy Pearson wrote:
>>>>>> We just experienced a very unusual crash on a Linux 5.3 file server =
using NFS to
>>>>>> serve a BTRFS filesystem.  NFS went into deadlock (D wait) with no a=
pparent
>>>>>> underlying disk subsystem problems, and when the server was hard reb=
ooted to
>>>>>> clear the D wait the BTRFS filesystem remounted itself in the state =
that it was
>>>>>> in approximately two weeks earlier (!).
>>>>>
>>>>> This means during two weeks, the btrfs is not committed.
>>>>
>>>> Is there any hope of getting the data from that interval back via btrf=
s-recover
>>>> or a similar tool, or does the lack of commit mean the data was stored=
 in RAM
>>>> only and is therefore gone after the server reboot?
>>>
>>> If it's deadlock preventing new transaction to be committed, then no
>>> metadata is even written back to disk, so no way to recover metadata.
>>> Maybe you can find some data written, but without metadata it makes no
>>> sense.
>>=20
>> OK, I'll just assume the data written in that window is unrecoverable at=
 this
>> point then.
>>=20
>> Would the commit deadlock affect only one btrfs filesystem or all of the=
m on the
>> machine?  I take it there is no automatic dmesg spew on extended deadloc=
k?
>> dmesg was completely clean at the time of the fault / reboot.
>=20
> It should have some kernel message for things like process hang for over
> 120s.
> If you could recover that, it would help us to locate the cause.
>=20
> Normally such deadlock should only affect the unlucky fs which meets the
> condition, not all filesystems.
> But if you're unlucky enough, it may happen to other filesystems.
>=20
> Anyway, without enough info, it's really hard to say.

Agreed.  I'll check to see if there's some chance of a dmesg rotated file s=
till hanging around from ~2 weeks prior when I get back tomorrow.

>>=20
>>>>
>>>> If the latter, I'm somewhat surprised given the I/O load on the disk a=
rray in
>>>> question, but it would also offer a clue as to why it hard locked the
>>>> filesystem eventually (presumably on memory exhaustion -- the server h=
as
>>>> something like 128GB of RAM, so it could go quite a while before hitti=
ng the
>>>> physical RAM limits).
>>>>
>>>>>
>>>>>>  There was also significant corruption of certain files (e.g. LDAP M=
DB and MySQL
>>>>>>  InnoDB) noted -- we restored from backup for those files, but are c=
oncerned
>>>>>>  about the status of the entire filesystem at this point.
>>>>>
>>>>> Btrfs check is needed to ensure no metadata corruption.
>>>>>
>>>>> Also, we need sysrq+w output to determine where we are deadlocking.
>>>>> Otherwise, it's really hard to find any clue from the report.
>>>>
>>>> It would have been gathered if we'd known the filesystem was in this b=
ad state.
>>>> At the time, the priority was on restoring service and we had assumed =
NFS had
>>>> just wedged itself (again).  It was only after reboot and remount that=
 the
>>>> damage slowly came to light.
>>>>
>>>> Do the described symptoms (what little we know of them at this point) =
line up
>>>> with the issues fixed by https://patchwork.kernel.org/patch/11141559/ =
?  Right
>>>> now we're hoping that this particular issue was fixed by that series, =
but if
>>>> not we might consider increasing backup frequency to nightly for this
>>>> particular array and seeing if it happens again.
>>>
>>> That fix is already in v5.3, thus I don't think that's the case.
>>>
>>> Thanks,
>>> Qu
>>=20
>> Looking more carefully, the server in question had been booted on 5.3-rc=
3
>> somehow.  It's possible that this was because earlier versions were show=
ing
>> driver problems with the other hardware, but somehow this machine was ru=
nning
>> 5.3-rc3 and the patch was created *after* rc3 release.
>=20
> If that's the case, just upgrade the kernel should prevent such problem
> from happening.
> And it's a relief that we don't need to face another deadly deadlock.

Yes, absolutely, the kernel was updated immediately once this was discovere=
d, but it was too late for the unfortunate filesystem in question.  At leas=
t we had a good DR test and backup check. :)

I'll keep an eye on this over the coming months to make sure it doesn't rec=
ur.

Thanks!
