Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F91F67DA
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2019 08:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfKJHSQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Nov 2019 02:18:16 -0500
Received: from mail.rptsys.com ([23.155.224.45]:53309 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbfKJHSQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Nov 2019 02:18:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 5AFFBBEDD6597;
        Sun, 10 Nov 2019 01:18:15 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9S3X6PRZw_WK; Sun, 10 Nov 2019 01:18:14 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 6C568BEDD6395;
        Sun, 10 Nov 2019 01:18:14 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 6C568BEDD6395
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1573370294; bh=V5fWKPHP8ynID8Vs2tcPifL983B501xGcGz+qyXEtpg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Kicj3AbhLgR2d+CmeZnqgUsr5l9Y77L/HjCFOv5LryWfMLD13WLgsw1Yrlija69Ma
         viMgTKttGBXlRqtjrvc6RAtRgAK1iNuK6Rgft8IESkKcbx+X+PCLzSaPsQdEytU5i7
         GTVtVzOoiwC1Z+zE+7b2Nes25lZmJ25Ysn2kZFT0=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EZxdCVpjjqYf; Sun, 10 Nov 2019 01:18:14 -0600 (CST)
Received: from vali.starlink.edu (unknown [192.168.3.2])
        by mail.rptsys.com (Postfix) with ESMTP id 43646BEDD6330;
        Sun, 10 Nov 2019 01:18:14 -0600 (CST)
Date:   Sun, 10 Nov 2019 01:18:13 -0600 (CST)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <1503948411.128656.1573370293214.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <64be1293-5845-4054-8d5f-b9ff79168a17@gmx.com>
References: <344827358.67114.1573338809278.JavaMail.zimbra@raptorengineeringinc.com> <5d2a48c3-b0ea-1da8-bf53-fb27de45b3c6@gmx.com> <1848426246.125326.1573368477888.JavaMail.zimbra@raptorengineeringinc.com> <64be1293-5845-4054-8d5f-b9ff79168a17@gmx.com>
Subject: Re: Unusual crash -- data rolled back ~2 weeks?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC73 (Linux)/8.5.0_GA_3042)
Thread-Topic: Unusual crash -- data rolled back ~2 weeks?
Thread-Index: ffVpObKqd3resuH9GP9SArEBsTJRZg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



----- Original Message -----
> From: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "linux-btrfs" <linux-btrfs@vger.kernel.org>
> Sent: Sunday, November 10, 2019 6:54:55 AM
> Subject: Re: Unusual crash -- data rolled back ~2 weeks?

> On 2019/11/10 =E4=B8=8B=E5=8D=882:47, Timothy Pearson wrote:
>>=20
>>=20
>> ----- Original Message -----
>>> From: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>>> To: "Timothy Pearson" <tpearson@raptorengineering.com>, "linux-btrfs"
>>> <linux-btrfs@vger.kernel.org>
>>> Sent: Saturday, November 9, 2019 9:38:21 PM
>>> Subject: Re: Unusual crash -- data rolled back ~2 weeks?
>>=20
>>> On 2019/11/10 =E4=B8=8A=E5=8D=886:33, Timothy Pearson wrote:
>>>> We just experienced a very unusual crash on a Linux 5.3 file server us=
ing NFS to
>>>> serve a BTRFS filesystem.  NFS went into deadlock (D wait) with no app=
arent
>>>> underlying disk subsystem problems, and when the server was hard reboo=
ted to
>>>> clear the D wait the BTRFS filesystem remounted itself in the state th=
at it was
>>>> in approximately two weeks earlier (!).
>>>
>>> This means during two weeks, the btrfs is not committed.
>>=20
>> Is there any hope of getting the data from that interval back via btrfs-=
recover
>> or a similar tool, or does the lack of commit mean the data was stored i=
n RAM
>> only and is therefore gone after the server reboot?
>=20
> If it's deadlock preventing new transaction to be committed, then no
> metadata is even written back to disk, so no way to recover metadata.
> Maybe you can find some data written, but without metadata it makes no
> sense.

OK, I'll just assume the data written in that window is unrecoverable at th=
is point then.

Would the commit deadlock affect only one btrfs filesystem or all of them o=
n the machine?  I take it there is no automatic dmesg spew on extended dead=
lock?  dmesg was completely clean at the time of the fault / reboot.

>>=20
>> If the latter, I'm somewhat surprised given the I/O load on the disk arr=
ay in
>> question, but it would also offer a clue as to why it hard locked the
>> filesystem eventually (presumably on memory exhaustion -- the server has
>> something like 128GB of RAM, so it could go quite a while before hitting=
 the
>> physical RAM limits).
>>=20
>>>
>>>>  There was also significant corruption of certain files (e.g. LDAP MDB=
 and MySQL
>>>>  InnoDB) noted -- we restored from backup for those files, but are con=
cerned
>>>>  about the status of the entire filesystem at this point.
>>>
>>> Btrfs check is needed to ensure no metadata corruption.
>>>
>>> Also, we need sysrq+w output to determine where we are deadlocking.
>>> Otherwise, it's really hard to find any clue from the report.
>>=20
>> It would have been gathered if we'd known the filesystem was in this bad=
 state.
>> At the time, the priority was on restoring service and we had assumed NF=
S had
>> just wedged itself (again).  It was only after reboot and remount that t=
he
>> damage slowly came to light.
>>=20
>> Do the described symptoms (what little we know of them at this point) li=
ne up
>> with the issues fixed by https://patchwork.kernel.org/patch/11141559/ ? =
 Right
>> now we're hoping that this particular issue was fixed by that series, bu=
t if
>> not we might consider increasing backup frequency to nightly for this
>> particular array and seeing if it happens again.
>=20
> That fix is already in v5.3, thus I don't think that's the case.
>=20
> Thanks,
> Qu

Looking more carefully, the server in question had been booted on 5.3-rc3 s=
omehow.  It's possible that this was because earlier versions were showing =
driver problems with the other hardware, but somehow this machine was runni=
ng 5.3-rc3 and the patch was created *after* rc3 release.

Thanks!
