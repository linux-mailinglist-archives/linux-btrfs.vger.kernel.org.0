Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A31F6846
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2019 11:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfKJKCO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Nov 2019 05:02:14 -0500
Received: from mail.rptsys.com ([23.155.224.45]:28065 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfKJKCN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Nov 2019 05:02:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 15E75BF0EA6B8;
        Sun, 10 Nov 2019 04:02:13 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cg-OY2B14vuq; Sun, 10 Nov 2019 04:02:12 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 27607BF0EA4F6;
        Sun, 10 Nov 2019 04:02:12 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 27607BF0EA4F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1573380132; bh=px/l9J+zEnkc4deTVIjj13Bwo8uLpk7313jSjYZDtfo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=hWSXLmyGm6d2eKfgTQaHClRnkzFmpJFPPmGMTcFFHX9La7iahzu+zeeXa24AFEKIf
         8v82oKqGwmrJJOYJgho770FzOQ7NhKNeoLJUYGjKJBwrYqbo3EHDSq+uQ+wPR5Lktp
         eMTmreGb3ErF2dg3vQ/bRVOm1pmO0sYFuS/q4b2U=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BskIn9iqgjs0; Sun, 10 Nov 2019 04:02:12 -0600 (CST)
Received: from vali.starlink.edu (unknown [192.168.3.2])
        by mail.rptsys.com (Postfix) with ESMTP id 02659BF0EA4B6;
        Sun, 10 Nov 2019 04:02:12 -0600 (CST)
Date:   Sun, 10 Nov 2019 04:02:11 -0600 (CST)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <825354711.177110.1573380131178.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <4c5b062b-30c7-2707-2bef-0ea5f18265c5@gmx.com>
References: <344827358.67114.1573338809278.JavaMail.zimbra@raptorengineeringinc.com> <5d2a48c3-b0ea-1da8-bf53-fb27de45b3c6@gmx.com> <1848426246.125326.1573368477888.JavaMail.zimbra@raptorengineeringinc.com> <64be1293-5845-4054-8d5f-b9ff79168a17@gmx.com> <1503948411.128656.1573370293214.JavaMail.zimbra@raptorengineeringinc.com> <4c5b062b-30c7-2707-2bef-0ea5f18265c5@gmx.com>
Subject: Re: Unusual crash -- data rolled back ~2 weeks?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC65 (Linux)/8.5.0_GA_3042)
Thread-Topic: Unusual crash -- data rolled back ~2 weeks?
Thread-Index: ICKfvidhTKGbM9xhqIQ90jN6cOMzIw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



----- Original Message -----
> From: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "linux-btrfs" <linux-btrfs@vger.kernel.org>
> Sent: Sunday, November 10, 2019 1:45:14 AM
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

I was able to retrieve complete logs from the kernel for the entire time pe=
riod.  The BTRFS filesystem was online resized five days before the last ap=
parent filesystem commit.  Immediately after resize, a couple of csum error=
s were thrown for a single inode on the resized filesystem, though this was=
 not detected at the time.  The underlying hardware did not experience a fa=
ult at any point and is passing all diagnostics at this time.  Intriguingly=
, there are a handful of files accessible from after the last known good fi=
lesystem commit (Oct. 29), but the vast majority are simply absent.

At this point I'm more interested in making sure this type of event does no=
t happen in the future than anything else.  At no point did the kernel prin=
t any type of stack trace or deadlock warning.  I'm starting to wonder if w=
e hit a bug in the online resize path, but am just guessing at this point. =
 The timing is certainly very close / coincidental.

Thanks!
