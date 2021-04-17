Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2B4363290
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Apr 2021 00:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbhDQWiS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Apr 2021 18:38:18 -0400
Received: from autoscheduling.com ([54.39.22.251]:40832 "EHLO
        autoscheduling.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbhDQWiS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Apr 2021 18:38:18 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Apr 2021 18:38:18 EDT
Received: from [192.168.1.140] (cpe-98-15-218-236.hvc.res.rr.com [98.15.218.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rdhamlin)
        by autoscheduling.com (Postfix) with ESMTPSA id 8550427BE42
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Apr 2021 18:30:41 -0400 (EDT)
Authentication-Results: autoscheduling.com; dmarc=none (p=none dis=none) header.from=pandemonium.dev
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pandemonium.dev;
        s=mail; t=1618698641;
        bh=PhKIgp4RjfzkuORvDzfRcrTyQ6av1MyPncL8FtR5k/U=;
        h=From:Subject:Date:To:From;
        b=MrJL4CW7XVBe6242it0CI96x6q1SHCJWOaPQbmUSJPpd20Oeu9W6rkKAtNV8fsRvl
         zt9BwwxHQtLiFVew8s4g0QkEA1GzVvpDYGJPq1ynYXxOxRQGedbDVyndsaW0ObKU7J
         sK+XOf3ioUQoreitqZPN7wiiDm8CfBY0hHcE1UnqEqdHleJxMzamKom2pUHER3vsAv
         BCbyCdnrMBTVBF0wkc8GgeFPU5wk9OroU9CDGNHkjBQpQO/cIIYzmabhSkJS9QlxRi
         DzZ6KQC4mLVUxuhzw06yJ6Kudge6WoZY8UgstrJJGsk1o+qFyg/9DE6irePyrratBH
         Wk8ighibGOcbw==
From:   "Richard D. Hamlin" <rdhamlin@pandemonium.dev>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_ABF89FA9-C28A-4DA2-ACAE-69487B2C3A04"
X-Priority: 1
Subject: Recovery from automatic balance?
Message-Id: <B4E898C4-B227-45BD-A93A-AF01FD484BCD@pandemonium.dev>
Date:   Sat, 17 Apr 2021 18:30:37 -0400
To:     linux-btrfs@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
X-Mailer: Apple Mail (2.3445.104.17)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--Apple-Mail=_ABF89FA9-C28A-4DA2-ACAE-69487B2C3A04
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

An Ubuntu 18.04 desktop system (Linux version 4.15.0-140-generic =
(buildd@lgw01-amd64-054) (gcc version 7.5.0 (Ubuntu =
7.5.0-3ubuntu1~18.04)) #144-Ubuntu SMP Fri Mar 19 14:12:35 UTC 2021 =
(Ubuntu 4.15.0-140.144-generic 4.15.18)), that I was logged into, but =
that was idle at the time, spontaneously remounted the primary =
filesystem readonly, due to an error that occurred during automatic =
balancing. (Naturally, this resulted in many processes failing after =
that.)

Apr 16 16:03:25 kernel: BTRFS: error (device dm-17) in =
balance_level:1962: errno=3D-117 unknown
Apr 16 16:03:25 kernel: BTRFS info (device dm-17): forced readonly


I have since attempted to recover this filesystem with the latest kernel =
and progs without success; actually seemed to make it worse.=20

$ sudo btrfs check =E2=80=94readonly /dev/mapper/ub
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
root 895 inode 24368511 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 4096
root 895 inode 24368517 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 12288
root 895 inode 24368519 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 57344
root 895 inode 24368522 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 20480
root 1386 inode 23147891 errors 100, file extent discount
Found file extent holes:
	start: 32768, len: 90112
ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/mapper/ub
UUID: 10f30b03-9566-4d46-997f-c80b29dd3589
found 139004862505 bytes used, error(s) found
total csum bytes: 127989452
total tree bytes: 3912400896
total fs tree bytes: 3542646784
total extent tree bytes: 197771264
btree space waste bytes: 932473031
file data blocks allocated: 4659957428224
 referenced 591153811456


$ sudo btrfs check =E2=80=94repair /dev/mapper/ub

enabling repair mode
WARNING:

	Do not use --repair unless you are advised to do so by a =
developer
	or an experienced user, and then only after having accepted that =
no
	fsck can successfully repair all types of filesystem corruption. =
Eg.
	some software or hardware bugs can fatally damage a volume.
	The operation will start in 10 seconds.
	Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
root 895 inode 24368511 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 4096
root 895 inode 24368517 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 12288
root 895 inode 24368519 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 57344
root 895 inode 24368522 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 20480
ERROR: errors found in fs roots

Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/mapper/ub
UUID: 10f30b03-9566-4d46-997f-c80b29dd3589
No device size related problem found
cache and super generation don't match, space cache will be invalidated
Fixed discount file extents for inode: 23147891 in root: 1386
found 139004862505 bytes used, error(s) found
total csum bytes: 127989452
total tree bytes: 3912400896
total fs tree bytes: 3542646784
total extent tree bytes: 197771264
btree space waste bytes: 932473031
file data blocks allocated: 4659957428224
 referenced 591153811456


$ sudo btrfs check =E2=80=94readonly /dev/mapper/ub

(see attached=E2=80=94seemed to cause more problems than it solved.)

--Apple-Mail=_ABF89FA9-C28A-4DA2-ACAE-69487B2C3A04
Content-Disposition: attachment;
	filename=btrfs-check-ro2.out
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="btrfs-check-ro2.out"
Content-Transfer-Encoding: 7bit

[1/7] checking root items
[2/7] checking extents
ref mismatch on [46437662720 4096] extent item 3, found 2
incorrect local backref count on 46437662720 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584cbbf9fc0
backref disk bytenr does not match extent record, bytenr=46437662720, ref bytenr=0
backpointer mismatch on [46437662720 4096]
ref mismatch on [46598303744 4096] extent item 3, found 2
incorrect local backref count on 46598303744 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c40ca4e0
backref disk bytenr does not match extent record, bytenr=46598303744, ref bytenr=0
backpointer mismatch on [46598303744 4096]
ref mismatch on [46605271040 4096] extent item 3, found 2
incorrect local backref count on 46605271040 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584db8e5220
backref disk bytenr does not match extent record, bytenr=46605271040, ref bytenr=0
backpointer mismatch on [46605271040 4096]
ref mismatch on [46652837888 4096] extent item 2, found 1
incorrect local backref count on 46652837888 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d41b5200
backref disk bytenr does not match extent record, bytenr=46652837888, ref bytenr=0
backpointer mismatch on [46652837888 4096]
ref mismatch on [46684008448 4096] extent item 3, found 2
incorrect local backref count on 46684008448 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c1eb4130
backref disk bytenr does not match extent record, bytenr=46684008448, ref bytenr=0
backpointer mismatch on [46684008448 4096]
ref mismatch on [46684016640 4096] extent item 3, found 2
incorrect local backref count on 46684016640 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c1eb4450
backref disk bytenr does not match extent record, bytenr=46684016640, ref bytenr=0
backpointer mismatch on [46684016640 4096]
ref mismatch on [46684041216 16384] extent item 3, found 2
incorrect local backref count on 46684041216 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c1eb4c30
backref disk bytenr does not match extent record, bytenr=46684041216, ref bytenr=0
backpointer mismatch on [46684041216 16384]
ref mismatch on [46704087040 4096] extent item 3, found 2
incorrect local backref count on 46704087040 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584db8f67c0
backref disk bytenr does not match extent record, bytenr=46704087040, ref bytenr=0
backpointer mismatch on [46704087040 4096]
ref mismatch on [46708744192 8192] extent item 8, found 7
incorrect local backref count on 46708744192 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584db91cc70
backref disk bytenr does not match extent record, bytenr=46708744192, ref bytenr=0
backpointer mismatch on [46708744192 8192]
ref mismatch on [46714953728 12288] extent item 3, found 2
incorrect local backref count on 46714953728 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d41665c0
backref disk bytenr does not match extent record, bytenr=46714953728, ref bytenr=0
backpointer mismatch on [46714953728 12288]
ref mismatch on [46716219392 4096] extent item 3, found 2
incorrect local backref count on 46716219392 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d4169340
backref disk bytenr does not match extent record, bytenr=46716219392, ref bytenr=0
backpointer mismatch on [46716219392 4096]
ref mismatch on [46716223488 4096] extent item 3, found 2
incorrect local backref count on 46716223488 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d4169530
backref disk bytenr does not match extent record, bytenr=46716223488, ref bytenr=0
backpointer mismatch on [46716223488 4096]
ref mismatch on [46716227584 4096] extent item 3, found 2
incorrect local backref count on 46716227584 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d4169720
backref disk bytenr does not match extent record, bytenr=46716227584, ref bytenr=0
backpointer mismatch on [46716227584 4096]
ref mismatch on [46939971584 4096] extent item 3, found 2
incorrect local backref count on 46939971584 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d421b4f0
backref disk bytenr does not match extent record, bytenr=46939971584, ref bytenr=0
backpointer mismatch on [46939971584 4096]
ref mismatch on [47016779776 12288] extent item 3, found 2
incorrect local backref count on 47016779776 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d41c1cc0
backref disk bytenr does not match extent record, bytenr=47016779776, ref bytenr=0
backpointer mismatch on [47016779776 12288]
ref mismatch on [47052800000 4096] extent item 3, found 2
incorrect local backref count on 47052800000 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c1ea3110
backref disk bytenr does not match extent record, bytenr=47052800000, ref bytenr=0
backpointer mismatch on [47052800000 4096]
ref mismatch on [47053193216 4096] extent item 3, found 2
incorrect local backref count on 47053193216 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c1ea4510
backref disk bytenr does not match extent record, bytenr=47053193216, ref bytenr=0
backpointer mismatch on [47053193216 4096]
ref mismatch on [47053709312 4096] extent item 3, found 2
incorrect local backref count on 47053709312 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c1ea8c10
backref disk bytenr does not match extent record, bytenr=47053709312, ref bytenr=0
backpointer mismatch on [47053709312 4096]
ref mismatch on [47074861056 8192] extent item 8, found 7
incorrect local backref count on 47074861056 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c4113610
backref disk bytenr does not match extent record, bytenr=47074861056, ref bytenr=0
backpointer mismatch on [47074861056 8192]
ref mismatch on [47097647104 12288] extent item 3, found 2
incorrect local backref count on 47097647104 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d41f7e00
backref disk bytenr does not match extent record, bytenr=47097647104, ref bytenr=0
backpointer mismatch on [47097647104 12288]
ref mismatch on [47132995584 8192] extent item 8, found 7
incorrect local backref count on 47132995584 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c4129840
backref disk bytenr does not match extent record, bytenr=47132995584, ref bytenr=0
backpointer mismatch on [47132995584 8192]
ref mismatch on [48381575168 8192] extent item 3, found 2
incorrect local backref count on 48381575168 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c7a61370
backref disk bytenr does not match extent record, bytenr=48381575168, ref bytenr=0
backpointer mismatch on [48381575168 8192]
ref mismatch on [48432177152 4096] extent item 3, found 2
incorrect local backref count on 48432177152 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c40ee9a0
backref disk bytenr does not match extent record, bytenr=48432177152, ref bytenr=0
backpointer mismatch on [48432177152 4096]
ref mismatch on [48653344768 4096] extent item 3, found 2
incorrect local backref count on 48653344768 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d4144540
backref disk bytenr does not match extent record, bytenr=48653344768, ref bytenr=0
backpointer mismatch on [48653344768 4096]
ref mismatch on [48676462592 28672] extent item 3, found 2
incorrect local backref count on 48676462592 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c0f760c0
backref disk bytenr does not match extent record, bytenr=48676462592, ref bytenr=0
backpointer mismatch on [48676462592 28672]
ref mismatch on [48676491264 12288] extent item 3, found 2
incorrect local backref count on 48676491264 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c0f762b0
backref disk bytenr does not match extent record, bytenr=48676491264, ref bytenr=0
backpointer mismatch on [48676491264 12288]
ref mismatch on [49118896128 8192] extent item 3, found 2
incorrect local backref count on 49118896128 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d4197df0
backref disk bytenr does not match extent record, bytenr=49118896128, ref bytenr=0
backpointer mismatch on [49118896128 8192]
ref mismatch on [49191358464 16384] extent item 3, found 2
incorrect local backref count on 49191358464 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584cbc180b0
backref disk bytenr does not match extent record, bytenr=49191358464, ref bytenr=0
backpointer mismatch on [49191358464 16384]
ref mismatch on [52679806976 4096] extent item 3, found 2
incorrect local backref count on 52679806976 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d417f7e0
backref disk bytenr does not match extent record, bytenr=52679806976, ref bytenr=0
backpointer mismatch on [52679806976 4096]
ref mismatch on [76316332032 4096] extent item 3, found 2
incorrect local backref count on 76316332032 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c409c9b0
backref disk bytenr does not match extent record, bytenr=76316332032, ref bytenr=0
backpointer mismatch on [76316332032 4096]
ref mismatch on [76369100800 24576] extent item 3, found 2
incorrect local backref count on 76369100800 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584cbc20b70
backref disk bytenr does not match extent record, bytenr=76369100800, ref bytenr=0
backpointer mismatch on [76369100800 24576]
ref mismatch on [76382679040 16384] extent item 3, found 2
incorrect local backref count on 76382679040 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d4228620
backref disk bytenr does not match extent record, bytenr=76382679040, ref bytenr=0
backpointer mismatch on [76382679040 16384]
ref mismatch on [76511391744 4096] extent item 2, found 1
incorrect local backref count on 76511391744 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c40b2800
backref disk bytenr does not match extent record, bytenr=76511391744, ref bytenr=0
backpointer mismatch on [76511391744 4096]
ref mismatch on [76519047168 12288] extent item 3, found 2
incorrect local backref count on 76519047168 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c40f5d70
backref disk bytenr does not match extent record, bytenr=76519047168, ref bytenr=0
backpointer mismatch on [76519047168 12288]
ref mismatch on [76525899776 36864] extent item 3, found 2
incorrect local backref count on 76525899776 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c7a4a280
backref disk bytenr does not match extent record, bytenr=76525899776, ref bytenr=0
backpointer mismatch on [76525899776 36864]
ref mismatch on [76532961280 28672] extent item 2, found 1
incorrect local backref count on 76532961280 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584db9072a0
backref disk bytenr does not match extent record, bytenr=76532961280, ref bytenr=0
backpointer mismatch on [76532961280 28672]
ref mismatch on [76542070784 4096] extent item 3, found 2
incorrect local backref count on 76542070784 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c41036a0
backref disk bytenr does not match extent record, bytenr=76542070784, ref bytenr=0
backpointer mismatch on [76542070784 4096]
ref mismatch on [76565979136 8192] extent item 3, found 2
incorrect local backref count on 76565979136 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584cbc50640
backref disk bytenr does not match extent record, bytenr=76565979136, ref bytenr=0
backpointer mismatch on [76565979136 8192]
ref mismatch on [76590026752 28672] extent item 3, found 2
incorrect local backref count on 76590026752 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584cbc46f20
backref disk bytenr does not match extent record, bytenr=76590026752, ref bytenr=0
backpointer mismatch on [76590026752 28672]
ref mismatch on [76664426496 32768] extent item 3, found 2
incorrect local backref count on 76664426496 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584cbbde5a0
backref disk bytenr does not match extent record, bytenr=76664426496, ref bytenr=0
backpointer mismatch on [76664426496 32768]
ref mismatch on [76664459264 24576] extent item 3, found 2
incorrect local backref count on 76664459264 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584cbbde790
backref disk bytenr does not match extent record, bytenr=76664459264, ref bytenr=0
backpointer mismatch on [76664459264 24576]
ref mismatch on [76668641280 4096] extent item 3, found 2
incorrect local backref count on 76668641280 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584cbbee390
backref disk bytenr does not match extent record, bytenr=76668641280, ref bytenr=0
backpointer mismatch on [76668641280 4096]
ref mismatch on [76676239360 12288] extent item 3, found 2
incorrect local backref count on 76676239360 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d4153680
backref disk bytenr does not match extent record, bytenr=76676239360, ref bytenr=0
backpointer mismatch on [76676239360 12288]
ref mismatch on [76915044352 24576] extent item 3, found 2
incorrect local backref count on 76915044352 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c40826b0
backref disk bytenr does not match extent record, bytenr=76915044352, ref bytenr=0
backpointer mismatch on [76915044352 24576]
ref mismatch on [77050687488 45056] extent item 3, found 2
incorrect local backref count on 77050687488 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d4176440
backref disk bytenr does not match extent record, bytenr=77050687488, ref bytenr=0
backpointer mismatch on [77050687488 45056]
ref mismatch on [77499654144 8192] extent item 3, found 2
incorrect local backref count on 77499654144 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c40a5270
backref disk bytenr does not match extent record, bytenr=77499654144, ref bytenr=0
backpointer mismatch on [77499654144 8192]
ref mismatch on [77871374336 8192] extent item 3, found 2
incorrect local backref count on 77871374336 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d41d3390
backref disk bytenr does not match extent record, bytenr=77871374336, ref bytenr=0
backpointer mismatch on [77871374336 8192]
ref mismatch on [78024851456 8192] extent item 3, found 2
incorrect local backref count on 78024851456 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d42015a0
backref disk bytenr does not match extent record, bytenr=78024851456, ref bytenr=0
backpointer mismatch on [78024851456 8192]
ref mismatch on [78076735488 12288] extent item 3, found 2
incorrect local backref count on 78076735488 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d41e3300
backref disk bytenr does not match extent record, bytenr=78076735488, ref bytenr=0
backpointer mismatch on [78076735488 12288]
ref mismatch on [78099509248 12288] extent item 3, found 2
incorrect local backref count on 78099509248 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584db90d890
backref disk bytenr does not match extent record, bytenr=78099509248, ref bytenr=0
backpointer mismatch on [78099509248 12288]
ref mismatch on [78104055808 12288] extent item 2, found 1
incorrect local backref count on 78104055808 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d41a5840
backref disk bytenr does not match extent record, bytenr=78104055808, ref bytenr=0
backpointer mismatch on [78104055808 12288]
ref mismatch on [78104211456 12288] extent item 3, found 2
incorrect local backref count on 78104211456 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d41a6d50
backref disk bytenr does not match extent record, bytenr=78104211456, ref bytenr=0
backpointer mismatch on [78104211456 12288]
ref mismatch on [78104223744 12288] extent item 3, found 2
incorrect local backref count on 78104223744 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584d41a6f40
backref disk bytenr does not match extent record, bytenr=78104223744, ref bytenr=0
backpointer mismatch on [78104223744 12288]
ref mismatch on [78113230848 12288] extent item 3, found 2
incorrect local backref count on 78113230848 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c40d4fb0
backref disk bytenr does not match extent record, bytenr=78113230848, ref bytenr=0
backpointer mismatch on [78113230848 12288]
ref mismatch on [78118203392 12288] extent item 3, found 2
incorrect local backref count on 78118203392 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c40dc6a0
backref disk bytenr does not match extent record, bytenr=78118203392, ref bytenr=0
backpointer mismatch on [78118203392 12288]
ref mismatch on [80023441408 12288] extent item 3, found 2
incorrect local backref count on 80023441408 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c1ec1d50
backref disk bytenr does not match extent record, bytenr=80023441408, ref bytenr=0
backpointer mismatch on [80023441408 12288]
ref mismatch on [80046997504 81920] extent item 3, found 2
incorrect local backref count on 80046997504 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c1e967e0
backref disk bytenr does not match extent record, bytenr=80046997504, ref bytenr=0
backpointer mismatch on [80046997504 81920]
ref mismatch on [80069644288 217088] extent item 3, found 2
incorrect local backref count on 80069644288 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584cbc32060
backref disk bytenr does not match extent record, bytenr=80069644288, ref bytenr=0
backpointer mismatch on [80069644288 217088]
ref mismatch on [80084697088 86016] extent item 3, found 2
incorrect local backref count on 80084697088 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c40930b0
backref disk bytenr does not match extent record, bytenr=80084697088, ref bytenr=0
backpointer mismatch on [80084697088 86016]
ref mismatch on [82423832576 176128] extent item 3, found 2
incorrect local backref count on 82423832576 parent 191759597568 owner 0 offset 0 found 0 wanted 1 back 0x5584c1eb8240
backref disk bytenr does not match extent record, bytenr=82423832576, ref bytenr=0
backpointer mismatch on [82423832576 176128]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
root 895 inode 24368511 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 4096
root 895 inode 24368517 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 12288
root 895 inode 24368519 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 57344
root 895 inode 24368522 errors 100, file extent discount
Found file extent holes:
	start: 0, len: 20480
ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/mapper/ub
UUID: 10f30b03-9566-4d46-997f-c80b29dd3589
cache and super generation don't match, space cache will be invalidated
found 139004829740 bytes used, error(s) found
total csum bytes: 127989452
total tree bytes: 3912417280
total fs tree bytes: 3542646784
total extent tree bytes: 197787648
btree space waste bytes: 932487405
file data blocks allocated: 4659957428224
 referenced 591153811456

--Apple-Mail=_ABF89FA9-C28A-4DA2-ACAE-69487B2C3A04
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8




Any ideas about how to fix it?  (I don=E2=80=99t have time to hack the =
kernel myself.)
And if not, how can I quickly just get a list of the affected files?

Also, is there away to turn off automatic balancing, so something like =
this does not happen at a most inconvenient time like this in the =
future?  (I know someone who decided once to defrag his hard drive the =
night before taxes were due, turning his system into a brick, but =
personally I=E2=80=99d rather not do anything that risky at a critical =
time!)=20
Thanks!


More info:

[liveuser@localhost-live ~]$ sudo mount -t btrfs -o recovery,ro =
/dev/mapper/ub /mnt/ub=20
[liveuser@localhost-live ~]$ uname -a
Linux localhost-live 5.11.12-300.fc34.x86_64 #1 SMP Wed Apr 7 16:31:13 =
UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
[liveuser@localhost-live ~]$ sudo btrfs --version
btrfs-progs v5.11.1=20
[liveuser@localhost-live ~]$ sudo btrfs fi show
Label: none  uuid: 10f30b03-9566-4d46-997f-c80b29dd3589
	Total devices 1 FS bytes used 129.46GiB
	devid    1 size 138.37GiB used 138.37GiB path /dev/mapper/ub

Label: 'docker-data-root'  uuid: 557fa6a5-5212-4d7a-b0af-297673f7bc45
	Total devices 1 FS bytes used 70.14MiB
	devid    1 size 24.00GiB used 4.28GiB path =
/dev/mapper/ultrafastvg-docker--data

[liveuser@localhost-live ~]$ sudo btrfs fi df /mnt/ub
Data, single: total=3D128.06GiB, used=3D125.81GiB
System, DUP: total=3D32.00MiB, used=3D16.00KiB
Metadata, DUP: total=3D5.12GiB, used=3D3.64GiB
GlobalReserve, single: total=3D352.50MiB, used=3D0.00B


[liveuser@localhost-live ~]$ dmesg | tail -5
[  787.767187] BTRFS: device fsid 10f30b03-9566-4d46-997f-c80b29dd3589 =
devid 1 transid 12553082 /dev/dm-19 scanned by systemd-udevd (3026)
[ 1299.217577] BTRFS warning (device dm-19): 'recovery' is deprecated, =
use 'rescue=3Dusebackuproot' instead
[ 1299.217583] BTRFS info (device dm-19): trying to use backup root at =
mount time
[ 1299.217585] BTRFS info (device dm-19): disk space caching is enabled
[ 1299.217587] BTRFS info (device dm-19): has skinny extents




--Apple-Mail=_ABF89FA9-C28A-4DA2-ACAE-69487B2C3A04--
