Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDBD44F0E2
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Nov 2021 03:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbhKMCvG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Nov 2021 21:51:06 -0500
Received: from st43p00im-ztfb10073301.me.com ([17.58.63.186]:50202 "EHLO
        st43p00im-ztfb10073301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232113AbhKMCvF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Nov 2021 21:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1636771693;
        bh=CFKUWPOYg/S+tMB5g5ST9vs1cm/Ukg1RUbfKedtAGrA=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:To:Date;
        b=1W0nKTU2ZAJk1pRHJ2EMwPhF9bDQfPsqvnKbbxCL3zFkb4qqbWhbSXVnfIxh83a7X
         P68sgZug3yAFgEM3wiq7tx6CyQYMtEJYUhb3Z2HBwPgW8pxo+LY+qM4fDnJP8kL93Y
         sB5cHgDoQc3+ZU95dF6R7V/aHxqjBrnz09FbjZdULnHDAPnDBlQHB1X+CzDWwMGGYg
         qnkccfas1JcWiAKPxbN7H8Uy50Z06lhDhb8UF58bzQbq8i/eikulbVHPB3cd4GpVWw
         zfJj5XsZjyZI1VlpHViRtLvbqeBcc7EH8V/GcF27k1G/I+qeUl5NrDrqz/1F1vq3uF
         mAFn3ZeZ0sXcg==
Received: from [192.168.6.187] (206-188-64-235.cpe.distributel.net [206.188.64.235])
        by st43p00im-ztfb10073301.me.com (Postfix) with ESMTPSA id 79CC52A0341
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Nov 2021 02:48:13 +0000 (UTC)
From:   Alex Lieflander <atlief@icloud.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Fwd: Finding long-term data corruption
Message-Id: <6CE25073-39BE-4EF1-AC3D-3483B38AA8A0@icloud.com>
References: <9A4FF989-58C9-4780-A06E-5E0F245EF2BC@icloud.com>
To:     linux-btrfs@vger.kernel.org
Date:   Fri, 12 Nov 2021 21:48:12 -0500
X-Mailer: Apple Mail (2.3445.104.21)
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-11-12=5F07:2021-11-12=5F01,2021-11-12=5F07,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2111130010
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hopefully I=E2=80=99m not pestering anyone, but I would really =
appreciate if someone could point me in the right direction. I can=E2=80=99=
t do much on my system until I figure out what my next, best course of =
action might be.

I copied and rephrased my remaining questions here. In retrospect of the =
revised questions, much of the context might not have been needed in the =
first place, although it should be found near the question of the same =
base number in my original message (quoted below). Partial answers are =
welcome too.

1a. How likely is it that BTRFS would detect any corruption/damage (with =
and/or without scrubbing), such that it would refuse to `btrfs send` =
files/sub-volumes affected by it?

1.b. If a sub-volume contains a file for which the source filesystem has =
no valid copy (detectably or not), but that file hasn=E2=80=99t changed =
between incremental `btrfs send`-ing, will the received/generated =
sub-volume still contain the file with its original, uncorrupted version =
(assuming that it already had a valid copy)?

1.c. What about corruption/damage to the metadata related to such a file =
(detectable or not)?

2.a. Could sending a (possibly affected) sub-volume from a =
corrupted/damaged filesystem cause any harm to the receiving filesystem =
(or to its existing files/sub-volumes)?

4.a. If any of my filesystems currently contain any corrupted/damaged =
files (unbeknownst to BTRFS, even after `btrfs scrub`-ing), what things =
could I try to detect them (in my situation, please see the context of 1 =
and 2)?

4.b. Is there anything else that I should do or try?

> Begin forwarded message:
>=20
> From: Alex Lieflander <atlief@icloud.com>
> Subject: Re: Finding long-term data corruption
> Date: November 9, 2021 at 1:37:16 PM EST
> To: Andrei Borzenkov <arvidjaar@gmail.com>
> Cc: linux-btrfs@vger.kernel.org
>=20
>> On Nov 7, 2021, at 2:28 AM, Andrei Borzenkov <arvidjaar@gmail.com> =
wrote:
>>=20
>>> On 06.11.2021 20:24, Alex Lieflander wrote:
>>>=20
>>> Hello,
>>>=20
>>> All of my files and data were exposed to an unknown amount of =
corruption, and I=E2=80=99d like to know how much I can recover and/or =
whether I can detect the extent of the damage. The steps that led me =
here are a bit complicated but (I think) relevant to the problem, so =
I=E2=80=99ve detailed them below.
>>>=20
>>> I use BTRFS for most of my filesystems, and my system recently died. =
While investigating the issue, I found out that corruption had been =
detected months earlier (after an unclean shutdown) on one of them. =
Corruption was detected on another a few weeks later for unknown =
reasons. The number of detected corruptions continued to grow to about =
160 and 30, respectively, before things began to noticeably malfunction.
>>>=20
>>> During this time I=E2=80=99d been `btrfs sub snap -r`-ing and `btrfs =
send -p`-ing both to the third BTRFS filesystem as a backup method, with =
no errors except some warnings about the =E2=80=9Ccapabilities=E2=80=9D =
of particular files being =E2=80=9Cset multiple times". I reformatted my =
backup drive a few weeks ago for unrelated reasons (after corruption was =
detected, unbeknownst to me). Since then I continued to regularly =
=E2=80=9Cbackup=E2=80=9D in this way.
>>>=20
>>> Once I noticed the corruption (that `btrfs scrub` couldn=E2=80=99t =
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
>>=20
>> That most likely is the result of stale received UUID on the source =
side.
>>=20
>> =
https://lore.kernel.org/linux-btrfs/CAL3q7H5y6z7rRu-ZsZe_WXeHteWx1edZi+L3-=
UL0aa0oYg+qQA@mail.gmail.com/
>=20
> That problem has now been solved, thank you.
>=20
>>> With the situation now described, I have a few questions that I=E2=80=99=
m hoping to find the answer to:
>>>=20
>>> 1. Can corrupt data propagate through sent sub-volumes?
>>=20
>> You did not really explain what kind of corruption it was or how you
>> detected it in the first place. If you are talking about corruption
>> detected by scrub - it should not, as btrfs should have either used =
good
>> copy (in case of redundant profile) or failed btrfs send (if data was
>> unreadable).
>=20
> When I mention the initial instances of detected corruption, I=E2=80=99m=
 referring to entries in my recovered syslog that are similar to:
>=20
> [696136.626700] BTRFS error (device bcache0): bdev /dev/bcache0 errs: =
wr 0, rd 0, flush 0, corrupt 11, gen 0
> [696211.391232] BTRFS warning (device bcache0): csum failed root 9219 =
ino 6967679 off 1415057616896 csum 0x9212d341 expected csum 0x8c30380c =
mirror 1
>=20
> When I mention later instances of detected corruption, I=E2=80=99m (in =
addition) referring to syslog entries similar to:
>=20
> [158941.583633] BTRFS error (device bcache0): bad tree block level 178 =
on 2811210498048
> [   89.312657] BTRFS error (device dm-3): bad tree block start, want =
6733332480 have 9811680321309906454
>=20
> I also remember similar entires in `dmesg` (shortly before the =
failure) referring to =E2=80=9Clogical=E2=80=9D and =E2=80=9Cphysical=E2=80=
=9D numbers, however I wasn=E2=80=99t able to recover any logs from it.
>=20
> For the sake of brevity I=E2=80=99ll refer to the time surrounding the =
initial corruption detection as =E2=80=9Cthe incident=E2=80=9D.
>=20
>>> 2. Can this corruption damage earlier, intact, sub-volumes?
>>=20
>> Again - what corruption? Physical media errors may happen anywhere.
>> RAID5 or RAID6 profiles errors may affect non-related data under some
>> conditions.
>=20
> I have another disk in another country with sub-volumes sent to it =
before and after the incident, and I have no evidence to suggest that it =
experienced direct damage. I think the only way it might have been =
damaged would be by receiving sub-volumes from the other two filesystems =
after the incident; I=E2=80=99m wondering how likely it is that =
sub-volumes sent before the incident would still contain the data =
exactly as it was stored/sent/received.
>=20
> The earliest I would have access to that disk is in several months and =
it=E2=80=99s pretty outdated; having to use it would be a last resort.
>=20
>>> 3. Does sub-volume sending include the checksums? Would a clean =
scrub report on the receiving filesystem be an actual indication of =
uncorrupted data?
>>=20
>> As far as I know send stream does not include any checksums. btrfs
>> receive is logical, it creates/writes files from user space so scrub
>> results on receive side have no relation to content or state of
>> filesystem on send side.
>>=20
>>> 4. Is there a way that I could detect what data/files are currently =
corrupted? How so?
>>=20
>> For the third time - explain what kind of corruption you are talking
>> about. If corruption cannot be detected by btrfs, you need to use
>> data/application specific methods to verify data integrity.
>>=20
>>> 5. What might cause a sent sub-volume (with no parent) to differ =
between two filesystems? Is that a sign of corruption?
>>=20
>> You need to show much more details before this can be answered. Full
>> send is expected to have the same content. If you have evidences that
>> this is not the case, provide logs/commands output/any facts that =
show
>> how you determine that, starting with actual send/receive invocations
>> you were using.
>=20
> I=E2=80=99m not sure what you mean by invocations, but the versions of =
"btrfs-progs=E2=80=9D I used were between 5.1 and 5.10.1. The command I =
used to send/receive the sub-volume was `btrfs send =
/path/to/backup_snapshot | pv -pterbas 2T | btrfs receive =
/path/to/newly_formatted/`. While collecting proof of the differences, I =
realized that the only difference was in the modification time of the =
top-level =E2=80=9Cdirectory=E2=80=9D of the sub-volumes (according to =
`ls -lh`) by 4 days, which is probably normal.
>=20
>>> 6. Is using sub-volumes in the way that I described appropriate for =
use as a backup solution?
>>=20
>> You did not really describe much. If you refer to
>>=20
>> "I=E2=80=99d been `btrfs sub snap -r`-ing and `btrfs send -p`-ing =
both to the
>> third BTRFS filesystem as a backup method"
>>=20
>> yes, it is. Do not forget received UUID pitfall and never ever (and I
>> mean really *EVER*) change any subvolume from being read-only to
>> read-write as part of restore from backup. Always create a clone
>> (writable subvolume) of read-only snapshot and use it as recovered =
content.
>>=20
>>> Thank you for your work on this interesting and extremely useful =
filesystem, and for reading this far!
>>>=20
>>> Regards,
>>> Alex Lieflander

