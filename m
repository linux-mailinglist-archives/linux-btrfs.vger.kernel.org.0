Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E14344B2C6
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 19:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242505AbhKISkH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 13:40:07 -0500
Received: from st43p00im-zteg10061901.me.com ([17.58.63.168]:33653 "EHLO
        st43p00im-zteg10061901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241812AbhKISkG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Nov 2021 13:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1636483039;
        bh=7d/ZO/68PioGiDQXrOFO0jjtZrOwryW8x8NODpALZWY=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=GzKR3YKfJWOtPMmDjDW5clitvZ5LYl6pIrPpmjfBnPj0l9AjMoY2fuuQVC/0i4XWM
         PUhFhgmdM6lb8tVBlOcvpgfSf6z75yxzEcVExBYz58ZHP37YXoHdmd5J2WYbNRWV4T
         n4kPLgt/f/RfBP8B0eK36c/5qxncA1xq4gQsJJp6GOLzy8Jv2vB9gSh0f0iWovyjcJ
         UEBL+JqlCF775QCsm9t6Lic/saHaG3HNx0Yh/vllH/w3lQE17k8QP/l3EoNOgUBFlC
         SUjYlzYd/KmEaA9QFe1Y0j1kIY1EXkfxn0TH44jATZnePK80++wtN70clpGdV1NOJI
         MinYfPIXb4sXQ==
Received: from [192.168.6.187] (206-188-64-235.cpe.distributel.net [206.188.64.235])
        by st43p00im-zteg10061901.me.com (Postfix) with ESMTPSA id 07645860A40;
        Tue,  9 Nov 2021 18:37:17 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: Finding long-term data corruption
From:   Alex Lieflander <atlief@icloud.com>
In-Reply-To: <b341cf51-f747-71b9-e762-89bf6dbb7be2@gmail.com>
Date:   Tue, 9 Nov 2021 13:37:16 -0500
Cc:     linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A4FF989-58C9-4780-A06E-5E0F245EF2BC@icloud.com>
References: <C85EE7D2-FC47-4A0E-B7A8-9285CF46C3FC@icloud.com>
 <b341cf51-f747-71b9-e762-89bf6dbb7be2@gmail.com>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-11-09_05:2021-11-08,2021-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2111090104
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> On Nov 7, 2021, at 2:28 AM, Andrei Borzenkov <arvidjaar@gmail.com> =
wrote:
>=20
>> On 06.11.2021 20:24, Alex Lieflander wrote:
>>=20
>> Hello,
>>=20
>> All of my files and data were exposed to an unknown amount of =
corruption, and I=E2=80=99d like to know how much I can recover and/or =
whether I can detect the extent of the damage. The steps that led me =
here are a bit complicated but (I think) relevant to the problem, so =
I=E2=80=99ve detailed them below.
>>=20
>> I use BTRFS for most of my filesystems, and my system recently died. =
While investigating the issue, I found out that corruption had been =
detected months earlier (after an unclean shutdown) on one of them. =
Corruption was detected on another a few weeks later for unknown =
reasons. The number of detected corruptions continued to grow to about =
160 and 30, respectively, before things began to noticeably malfunction.
>>=20
>> During this time I=E2=80=99d been `btrfs sub snap -r`-ing and `btrfs =
send -p`-ing both to the third BTRFS filesystem as a backup method, with =
no errors except some warnings about the =E2=80=9Ccapabilities=E2=80=9D =
of particular files being =E2=80=9Cset multiple times". I reformatted my =
backup drive a few weeks ago for unrelated reasons (after corruption was =
detected, unbeknownst to me). Since then I continued to regularly =
=E2=80=9Cbackup=E2=80=9D in this way.
>>=20
>> Once I noticed the corruption (that `btrfs scrub` couldn=E2=80=99t =
fix) I tried increasingly aggressive actions until both original =
filesystems were destroyed and unrecoverable. After that I reformatted =
and =E2=80=9Csent=E2=80=9D the corresponding sub-volumes back to their =
original drives (with the newly reformatted filesystems). Now scrub =
detects no errors on any of the filesystems, but btrfs-send can=E2=80=99t =
incrementally send on one of the filesystems. The parent I=E2=80=99m =
using is the one that I sent from the backup drive. On closer =
inspection, the received sub-volume has a few subtle permission changes =
from the sent one. These sub-volumes have always been read-only and I =
don=E2=80=99t think I ever modified them.
>=20
> That most likely is the result of stale received UUID on the source =
side.
>=20
> =
https://lore.kernel.org/linux-btrfs/CAL3q7H5y6z7rRu-ZsZe_WXeHteWx1edZi+L3-=
UL0aa0oYg+qQA@mail.gmail.com/

That problem has now been solved, thank you.

>> With the situation now described, I have a few questions that I=E2=80=99=
m hoping to find the answer to:
>>=20
>> 1. Can corrupt data propagate through sent sub-volumes?
>=20
> You did not really explain what kind of corruption it was or how you
> detected it in the first place. If you are talking about corruption
> detected by scrub - it should not, as btrfs should have either used =
good
> copy (in case of redundant profile) or failed btrfs send (if data was
> unreadable).

When I mention the initial instances of detected corruption, I=E2=80=99m =
referring to entries in my recovered syslog that are similar to:

[696136.626700] BTRFS error (device bcache0): bdev /dev/bcache0 errs: wr =
0, rd 0, flush 0, corrupt 11, gen 0
[696211.391232] BTRFS warning (device bcache0): csum failed root 9219 =
ino 6967679 off 1415057616896 csum 0x9212d341 expected csum 0x8c30380c =
mirror 1

When I mention later instances of detected corruption, I=E2=80=99m (in =
addition) referring to syslog entries similar to:

[158941.583633] BTRFS error (device bcache0): bad tree block level 178 =
on 2811210498048
[   89.312657] BTRFS error (device dm-3): bad tree block start, want =
6733332480 have 9811680321309906454

I also remember similar entires in `dmesg` (shortly before the failure) =
referring to =E2=80=9Clogical=E2=80=9D and =E2=80=9Cphysical=E2=80=9D =
numbers, however I wasn=E2=80=99t able to recover any logs from it.

For the sake of brevity I=E2=80=99ll refer to the time surrounding the =
initial corruption detection as =E2=80=9Cthe incident=E2=80=9D.

>> 2. Can this corruption damage earlier, intact, sub-volumes?
>=20
> Again - what corruption? Physical media errors may happen anywhere.
> RAID5 or RAID6 profiles errors may affect non-related data under some
> conditions.

I have another disk in another country with sub-volumes sent to it =
before and after the incident, and I have no evidence to suggest that it =
experienced direct damage. I think the only way it might have been =
damaged would be by receiving sub-volumes from the other two filesystems =
after the incident; I=E2=80=99m wondering how likely it is that =
sub-volumes sent before the incident would still contain the data =
exactly as it was stored/sent/received.

The earliest I would have access to that disk is in several months and =
it=E2=80=99s pretty outdated; having to use it would be a last resort.

>> 3. Does sub-volume sending include the checksums? Would a clean scrub =
report on the receiving filesystem be an actual indication of =
uncorrupted data?
>=20
> As far as I know send stream does not include any checksums. btrfs
> receive is logical, it creates/writes files from user space so scrub
> results on receive side have no relation to content or state of
> filesystem on send side.
>=20
>> 4. Is there a way that I could detect what data/files are currently =
corrupted? How so?
>=20
> For the third time - explain what kind of corruption you are talking
> about. If corruption cannot be detected by btrfs, you need to use
> data/application specific methods to verify data integrity.
>=20
>> 5. What might cause a sent sub-volume (with no parent) to differ =
between two filesystems? Is that a sign of corruption?
>=20
> You need to show much more details before this can be answered. Full
> send is expected to have the same content. If you have evidences that
> this is not the case, provide logs/commands output/any facts that show
> how you determine that, starting with actual send/receive invocations
> you were using.

I=E2=80=99m not sure what you mean by invocations, but the versions of =
"btrfs-progs=E2=80=9D I used were between 5.1 and 5.10.1. The command I =
used to send/receive the sub-volume was `btrfs send =
/path/to/backup_snapshot | pv -pterbas 2T | btrfs receive =
/path/to/newly_formatted/`. While collecting proof of the differences, I =
realized that the only difference was in the modification time of the =
top-level =E2=80=9Cdirectory=E2=80=9D of the sub-volumes (according to =
`ls -lh`) by 4 days, which is probably normal.

>> 6. Is using sub-volumes in the way that I described appropriate for =
use as a backup solution?
>=20
> You did not really describe much. If you refer to
>=20
> "I=E2=80=99d been `btrfs sub snap -r`-ing and `btrfs send -p`-ing both =
to the
> third BTRFS filesystem as a backup method"
>=20
> yes, it is. Do not forget received UUID pitfall and never ever (and I
> mean really *EVER*) change any subvolume from being read-only to
> read-write as part of restore from backup. Always create a clone
> (writable subvolume) of read-only snapshot and use it as recovered =
content.
>=20
>> Thank you for your work on this interesting and extremely useful =
filesystem, and for reading this far!
>>=20
>> Regards,
>> Alex Lieflander
