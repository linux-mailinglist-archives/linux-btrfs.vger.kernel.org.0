Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50741F67D1
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2019 07:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfKJGsB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Nov 2019 01:48:01 -0500
Received: from mail.rptsys.com ([23.155.224.45]:47316 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfKJGsA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Nov 2019 01:48:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id EF3ECBED3FDDD;
        Sun, 10 Nov 2019 00:47:59 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id KqOOm46VmNin; Sun, 10 Nov 2019 00:47:59 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 1F991BED3FDDA;
        Sun, 10 Nov 2019 00:47:59 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 1F991BED3FDDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1573368479; bh=C9oMVeinQ94ERDK3p3WUWz3nURCPSxmARR0qbNqhUqE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=D4J/AOSfaQfIrxEfw7SQv5FmG8NjDK/rFYT6vsgJ6fXtnxsCR1K958b/40NZWQWao
         8MZ3VgLIYb1rw2zsOIXVXz4nVXIScQP0HEvq7M/zB4qvlmj/whNW9IlzF35IMOFGwl
         cZM/P5Eic1947QHDThCi6YtRhrzvuB1FcUkv0MDk=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8_xKpmzsmFTt; Sun, 10 Nov 2019 00:47:58 -0600 (CST)
Received: from vali.starlink.edu (unknown [192.168.3.2])
        by mail.rptsys.com (Postfix) with ESMTP id E9871BED3FDD7;
        Sun, 10 Nov 2019 00:47:58 -0600 (CST)
Date:   Sun, 10 Nov 2019 00:47:57 -0600 (CST)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <1848426246.125326.1573368477888.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <5d2a48c3-b0ea-1da8-bf53-fb27de45b3c6@gmx.com>
References: <344827358.67114.1573338809278.JavaMail.zimbra@raptorengineeringinc.com> <5d2a48c3-b0ea-1da8-bf53-fb27de45b3c6@gmx.com>
Subject: Re: Unusual crash -- data rolled back ~2 weeks?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC65 (Linux)/8.5.0_GA_3042)
Thread-Topic: Unusual crash -- data rolled back ~2 weeks?
Thread-Index: jGqq1Ls5pP2X9LEczNgWUutybaGmrA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



----- Original Message -----
> From: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>, "linux-btrfs" <li=
nux-btrfs@vger.kernel.org>
> Sent: Saturday, November 9, 2019 9:38:21 PM
> Subject: Re: Unusual crash -- data rolled back ~2 weeks?

> On 2019/11/10 =E4=B8=8A=E5=8D=886:33, Timothy Pearson wrote:
>> We just experienced a very unusual crash on a Linux 5.3 file server usin=
g NFS to
>> serve a BTRFS filesystem.  NFS went into deadlock (D wait) with no appar=
ent
>> underlying disk subsystem problems, and when the server was hard reboote=
d to
>> clear the D wait the BTRFS filesystem remounted itself in the state that=
 it was
>> in approximately two weeks earlier (!).
>=20
> This means during two weeks, the btrfs is not committed.

Is there any hope of getting the data from that interval back via btrfs-rec=
over or a similar tool, or does the lack of commit mean the data was stored=
 in RAM only and is therefore gone after the server reboot?

If the latter, I'm somewhat surprised given the I/O load on the disk array =
in question, but it would also offer a clue as to why it hard locked the fi=
lesystem eventually (presumably on memory exhaustion -- the server has some=
thing like 128GB of RAM, so it could go quite a while before hitting the ph=
ysical RAM limits).

>=20
>>  There was also significant corruption of certain files (e.g. LDAP MDB a=
nd MySQL
>>  InnoDB) noted -- we restored from backup for those files, but are conce=
rned
>>  about the status of the entire filesystem at this point.
>=20
> Btrfs check is needed to ensure no metadata corruption.
>=20
> Also, we need sysrq+w output to determine where we are deadlocking.
> Otherwise, it's really hard to find any clue from the report.

It would have been gathered if we'd known the filesystem was in this bad st=
ate.  At the time, the priority was on restoring service and we had assumed=
 NFS had just wedged itself (again).  It was only after reboot and remount =
that the damage slowly came to light.

Do the described symptoms (what little we know of them at this point) line =
up with the issues fixed by https://patchwork.kernel.org/patch/11141559/ ? =
 Right now we're hoping that this particular issue was fixed by that series=
, but if not we might consider increasing backup frequency to nightly for t=
his particular array and seeing if it happens again.

Thanks!
