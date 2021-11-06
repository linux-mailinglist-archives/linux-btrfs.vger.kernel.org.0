Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CECB446F5B
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 18:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhKFRh3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Nov 2021 13:37:29 -0400
Received: from st43p00im-ztdg10071801.me.com ([17.58.63.171]:36946 "EHLO
        st43p00im-ztdg10071801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229551AbhKFRh3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 6 Nov 2021 13:37:29 -0400
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Nov 2021 13:37:29 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1636219495;
        bh=O8+SG18ILvHx1KtGy9ZSVUq7611okJID63BB9mVg1pc=;
        h=From:Content-Type:Mime-Version:Date:Subject:Message-Id:To;
        b=YWY3kNDuY4OvFStAilQbSYhJpmOvuMeNPQgtXhMUtoNDiY16W9acGA+MROEV7h3TH
         1rYj24wJuAHmUDWrTflhn1lLEJmgCWNBBY+oQcOhd/NQ+JiZab7o7DnDEct6T1hCRc
         O+YXNJHGuBk76poUGRr/6bAvZDCR0cFgMMT1a+jG75l8gih2JleBhANAmWNL7XSDKj
         LMjhMFu9PJQGijXHlWspI2HhYoVioADVGhufNaQIQQH6xpNxaq4HNqca9SpaZ7S2W/
         Cq44BzOEpxLb6NoLjVVR3OdqFBZ0J+EUvnjUkOGNGGfTXTeRKl4E+Rtwhk5cp3KBZk
         4O4oTKxst6H0g==
Received: from [192.168.6.94] (206-188-64-235.cpe.distributel.net [206.188.64.235])
        by st43p00im-ztdg10071801.me.com (Postfix) with ESMTPSA id 5843554001F;
        Sat,  6 Nov 2021 17:24:55 +0000 (UTC)
From:   Alex Lieflander <atlief@icloud.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Date:   Sat, 6 Nov 2021 13:24:53 -0400
Subject: Finding long-term data corruption
Message-Id: <C85EE7D2-FC47-4A0E-B7A8-9285CF46C3FC@icloud.com>
To:     linux-btrfs@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.21)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-11-06_02:2021-11-03,2021-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=897 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2111060108
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

All of my files and data were exposed to an unknown amount of =
corruption, and I=E2=80=99d like to know how much I can recover and/or =
whether I can detect the extent of the damage. The steps that led me =
here are a bit complicated but (I think) relevant to the problem, so =
I=E2=80=99ve detailed them below.

I use BTRFS for most of my filesystems, and my system recently died. =
While investigating the issue, I found out that corruption had been =
detected months earlier (after an unclean shutdown) on one of them. =
Corruption was detected on another a few weeks later for unknown =
reasons. The number of detected corruptions continued to grow to about =
160 and 30, respectively, before things began to noticeably malfunction.

During this time I=E2=80=99d been `btrfs sub snap -r`-ing and `btrfs =
send -p`-ing both to the third BTRFS filesystem as a backup method, with =
no errors except some warnings about the =E2=80=9Ccapabilities=E2=80=9D =
of particular files being =E2=80=9Cset multiple times". I reformatted my =
backup drive a few weeks ago for unrelated reasons (after corruption was =
detected, unbeknownst to me). Since then I continued to regularly =
=E2=80=9Cbackup=E2=80=9D in this way.

Once I noticed the corruption (that `btrfs scrub` couldn=E2=80=99t fix) =
I tried increasingly aggressive actions until both original filesystems =
were destroyed and unrecoverable. After that I reformatted and =
=E2=80=9Csent=E2=80=9D the corresponding sub-volumes back to their =
original drives (with the newly reformatted filesystems). Now scrub =
detects no errors on any of the filesystems, but btrfs-send can=E2=80=99t =
incrementally send on one of the filesystems. The parent I=E2=80=99m =
using is the one that I sent from the backup drive. On closer =
inspection, the received sub-volume has a few subtle permission changes =
from the sent one. These sub-volumes have always been read-only and I =
don=E2=80=99t think I ever modified them.

With the situation now described, I have a few questions that I=E2=80=99m =
hoping to find the answer to:

1. Can corrupt data propagate through sent sub-volumes?

2. Can this corruption damage earlier, intact, sub-volumes?

3. Does sub-volume sending include the checksums? Would a clean scrub =
report on the receiving filesystem be an actual indication of =
uncorrupted data?

4. Is there a way that I could detect what data/files are currently =
corrupted? How so?

5. What might cause a sent sub-volume (with no parent) to differ between =
two filesystems? Is that a sign of corruption?

6. Is using sub-volumes in the way that I described appropriate for use =
as a backup solution?

Thank you for your work on this interesting and extremely useful =
filesystem, and for reading this far!

Regards,
Alex Lieflander=
