Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBA2DB801B
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2019 19:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404071AbfISRif convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 19 Sep 2019 13:38:35 -0400
Received: from ppagent4.llumc.edu ([143.197.222.70]:35608 "EHLO
        ppagent4.llumc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403898AbfISRie (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Sep 2019 13:38:34 -0400
Received: from pps.filterd (ppagent4.mc.llumc.edu [127.0.0.1])
        by ppagent4.mc.llumc.edu (8.16.0.27/8.16.0.27) with SMTP id x8JHWPuE043988
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2019 10:38:33 -0700
Received: from cgmtaccs ([10.192.102.81])
        by ppagent4.mc.llumc.edu with ESMTP id 2v3vae1ed9-1
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2019 10:38:33 -0700
Received: from CGMTACCS (localhost.localdomain [127.0.0.1])
        by CGMTACCS (Postfix) with ESMTP id 0AEF861
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2019 17:38:33 +0000 (GMT)
Received: from excvhtsp01.mc.ad.lluahsc.org (unknown [10.192.100.112])
        by CGMTACCS (Postfix) with ESMTP id E6FD061
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2019 17:38:32 +0000 (GMT)
Received: from MCDBS2A.mc.ad.lluahsc.org ([fe80::ed15:3fcd:605b:9f7e]) by
 excvhtsp01.mc.ad.lluahsc.org ([::1]) with mapi id 14.03.0351.000; Thu, 19 Sep
 2019 10:38:33 -0700
From:   "Barnes, Samuel" <SABarnes@llu.edu>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Unable to delete directory: input/output error and corrupt leaf
Thread-Topic: Unable to delete directory: input/output error and corrupt leaf
Thread-Index: AdVtq3j3x5ym14bqR8iUtgLU0KrKhgBZT80A
Date:   Thu, 19 Sep 2019 17:38:31 +0000
Message-ID: <4DF2D58151C4C8499907B16D8F72881901CEC458EC@MCDBS2A.mc.ad.lluahsc.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.250.68.15]
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909190150
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a btrfs drive that started have problems, I first noticed some of my old backup directories couldn't be deleted, the automated delete commands removed all the files, but got stuck on the directories. Now if I try to delete I get input/output error:

rm -rf 20190806-020001-412/
rm: cannot remove '20190806-020001-412/backup/media/network_mriphysics/HAT_data/Phantoms/Penn State Coll Time1': Input/output error

dmesg shows the following errors:

[11655.022724] BTRFS critical (device sdc1): corrupt leaf: root=5 block=1399280648192 slot=69 ino=8904454, name hash mismatch with key, have 0x00000000d8649173 expect 0x00000000f88d2ac3 [11655.027629] BTRFS critical (device sdc1): corrupt leaf: root=5 block=1399280648192 slot=69 ino=8904454, name hash mismatch with key, have 0x00000000d8649173 expect 0x00000000f88d2ac3 [11655.027990] BTRFS critical (device sdc1): corrupt leaf: root=5 block=1399280648192 slot=69 ino=8904454, name hash mismatch with key, have 0x00000000d8649173 expect 0x00000000f88d2ac3 [11655.028311] BTRFS critical (device sdc1): corrupt leaf: root=5 block=1399280648192 slot=69 ino=8904454, name hash mismatch with key, have 0x00000000d8649173 expect 0x00000000f88d2ac3

I have tried a scrub, no errors:

sudo ./btrfs scrub status /dev/sdc1
UUID:             d462aea8-a4e8-47a0-b5e7-ab8ec91af82a
Scrub started:    Tue Sep 17 10:43:20 2019
Status:           finished
Duration:         1:46:29
Total to scrub:   1.18TiB
Rate:             193.46MiB/s
Error summary:    no errors found

a btrfs check gives a very very long list of errors most include "link count wrong" such as:

root 5 inode 5202109 errors 2000, link count wrong
    unresolved ref dir 7424552 index 19 namelen 9 name 12-25.dcm filetype 0 errors 3, no dir item, no dir index
    unresolved ref dir 8454942 index 19 namelen 9 name 12-25.dcm filetype 0 errors 3, no dir item, no dir index
    unresolved ref dir 8616651 index 19 namelen 9 name 12-25.dcm filetype 0 errors 3, no dir item, no dir index

another example:

root 5 inode 7422709 errors 2001, no inode item, link count wrong
    unresolved ref dir 261 index 182 namelen 19 name 20190630-020001-715 filetype 2 errors 4, no inode ref

I ran a balance, that didn't help, and interestingly if I run check --repair it aborts:

sudo ./btrfs check --repair /dev/sdc1
enabling repair mode
Opening filesystem to check...
Checking filesystem on /dev/sdc1
UUID: d462aea8-a4e8-47a0-b5e7-ab8ec91af82a
[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
incorrect offsets 9191 67118055
incorrect offsets 9191 67118055
incorrect offsets 9191 67118055
incorrect offsets 9191 67118055
items overlap, can't fix
check/main.c:4265: fix_item_offset: BUG_ON `ret` triggered, value -5 ./btrfs(+0x5e2f0)[0x557b1e3c62f0] ./btrfs(+0x5e396)[0x557b1e3c6396] ./btrfs(+0x6951b)[0x557b1e3d151b] ./btrfs(+0x6a45a)[0x557b1e3d245a] ./btrfs(+0x6cf09)[0x557b1e3d4f09] ./btrfs(main+0x95)[0x557b1e37c690]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7)[0x7f7aec452b97]
./btrfs(_start+0x2a)[0x557b1e37c1ea]
Aborted

dev stats doesn't show any corruption errors:

sudo ./btrfs dev stats /dev/sdc1
[/dev/sdc1].write_io_errs    0
[/dev/sdc1].read_io_errs     0
[/dev/sdc1].flush_io_errs    0
[/dev/sdc1].corruption_errs  0
[/dev/sdc1].generation_errs  0

SMART doesn't show any problems. I updated my kernel to 5.0 and built the latest version of btrfs-prog (5.2.2) and have been using that. I can't find anything else to try, these are incremental backups so it would be nice to save them if possible. Any help much appreciated!! Version and other info listed below:

uname -a
Linux mrispec 5.0.0-27-generic #28~18.04.1-Ubuntu SMP Thu Aug 22 03:00:32 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

./btrfs --version
btrfs-progs v5.2.2 

sudo ./btrfs fi show
Label: 'backup'  uuid: d462aea8-a4e8-47a0-b5e7-ab8ec91af82a
    Total devices 1 FS bytes used 1.17TiB
    devid    1 size 9.09TiB used 1.18TiB path /dev/sdc1

sudo ./btrfs fi df /media/mrispec/backup/ Data, single: total=1.16TiB, used=1.16TiB System, DUP: total=8.00MiB, used=160.00KiB Metadata, DUP: total=11.00GiB, used=8.33GiB GlobalReserve, single: total=512.00MiB, used=0.00B





CONFIDENTIALITY NOTICE: This e-mail communication and any attachments may contain confidential and privileged information for the use of the designated recipients named above. If you are not the intended recipient, you are hereby notified that you have received this communication in error and that any review, disclosure, dissemination, distribution or copying of it or its contents is prohibited. If you have received this communication in error, please notify me immediately by replying to this message and destroy all copies of this communication and any attachments. Thank you.
