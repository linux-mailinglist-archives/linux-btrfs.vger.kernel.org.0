Return-Path: <linux-btrfs+bounces-7309-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B64C955CDD
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Aug 2024 16:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BE41F2183A
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Aug 2024 14:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390FF80054;
	Sun, 18 Aug 2024 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b="HJ4sGVml"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxh.seznam.cz (mxh.seznam.cz [77.75.78.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278B912F5B1
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Aug 2024 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723989675; cv=none; b=E8FsygD1pYV78MnatwCYU93m+MUXpD2QTN8N9ilqwk37gQMyrIjbwACbARoRxyQ9fmWPvpL29vGw6hEjyT2swvB+LExdZBKaq0Lk2Q+psK1tX3m5PC+ZhL+QQhgtvA78jX7oVUwBf+CLKMR5TOlkeiRVaY9bqZN3K6wxSwIDTBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723989675; c=relaxed/simple;
	bh=aolMVmIJIW7NWE8nyo86DZhKKq2r9J4sAAb9Dwm+gYg=;
	h=From:To:Subject:Date:Message-Id:Mime-Version:Content-Type; b=hj2OsFVkMbkEDCs21vISZZheKsCLh6HI56FvbvD+Z2eQZFDhB/SDVAu9wpt2LUTQiueC/tED3y1jSWL7zgMesJRNfRdKtFg2DnaOdkDJBcxyJ4nFlsrTpW6FFn4GsNzeNo+yvbxqnU5eujNS+u9q/HChhQRQcXpI3B7wJb4GmsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz; spf=pass smtp.mailfrom=email.cz; dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b=HJ4sGVml; arc=none smtp.client-ip=77.75.78.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email.cz
Received: from email.seznam.cz
	by smtpc-mxh-755bbcd9cc-pc28x
	(smtpc-mxh-755bbcd9cc-pc28x [2a02:598:64:8a00::1000:44])
	id 66bd3f830526e483601ff3ba;
	Sun, 18 Aug 2024 16:01:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
	s=szn20221014; t=1723989666;
	bh=E0B02OFeRpHlG5v8ST5IRvvMCATiwUUeF0YQ+hietNA=;
	h=Received:From:To:Subject:Date:Message-Id:Mime-Version:X-Mailer:
	 Content-Type:Content-Transfer-Encoding;
	b=HJ4sGVmlZE1ap4rCcqc+UJs0lty/R26vPJXsIjxyXycM+eLtM8xpmT8UhMbdD0K5C
	 zhpFi6OF6h4n3qEJOx02dVC6NziqyE2zifXUinU7laEZ9DXL8qe8dZAgLn+XrJDri/
	 0ITbhbUJLXKD1B42iZOEwZeh6u0KQNLH3L8Az7x+SIv2C2DHQ0ihLMUH3QSA8M0HYF
	 09ZYrdWIhNfCUUW/lradGpQtjEryZCtWYhhk3cFdV2FXFDeo5LO8yxYJaWiOQjiwDl
	 NLOtBHt6vWsZtbQOtDtQERfP/AV6Y17seKL4tR+nDlL34552WX0nsg9g1lTOsP2OYZ
	 QgIRR3Z6d6FvA==
Received: from unknown ([2a03:e600:100::66])
	by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
	Sun, 18 Aug 2024 15:59:43 +0200 (CEST)
From: <shustriykent@email.cz>
To: <linux-btrfs@vger.kernel.org>
Subject: Cannot mount BTRFS after powerloss: open_ctree failed. Help!
Date: Sun, 18 Aug 2024 15:59:43 +0200 (CEST)
Message-Id: <1Sd.6eimJ.7EQ1gmUF4g6.1cmVvF@seznam.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (szn-mime-2.1.60)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello!
After a powerloss my external backup harddrive became unmountable.
As far as I can tell, the HDD was just idling at that moment (it was unloc=
ked and mounted) - I wasn't running any write operations but might have be=
en running read operations.

I have some backups but not all, so I'd like to restore the filesystem to =
its working state if possible.
Moreover, I was able to salvage some files just fine with PhotoRec. The fi=
lenames, however, are all scrambled (as expected). Sure, I could 'grep' my=
 way out of this, but it would be nice if restoring the whole thing was po=
ssible.
Also, I have already made a full dd image of the /dev/mapper/sda, so I cou=
ld more or less try "dangerous" commands.

Here is the setup:
# lsblk
NAME=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 MAJ:MIN RM=C2=A0=C2=A0 SIZE RO TYPE=C2=A0 MOUNTPOINTS
sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8:0=C2=A0=C2=A0=C2=A0 0 931.5G=C2=A0 0 disk=
 =C2=A0
=E2=94=94=E2=94=80sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 253:1=C2=A0=C2=A0=C2=A0 0 931.5G=C2=A0 0 crypt =


The disk is encrypted with LUKS and inside of it resides BTRFS.
LUKS opens up all right, but when trying to mount /dev/mapper/sda, I get:=


# mount /dev/mapper/sda /mnt/hdd
mount: /mnt/hdd: wrong fs type, bad option, bad superblock on /dev/mapper/=
sda, missing codepage or helper program, or other error.

The drive itself is IMO in excellent condition - no extreme environment, h=
eat, usage, etc. It is a backup harddrive, stored most of the time turned =
off in a safe place.

Here's my kernel version:
# uname -sr 
Linux 5.15.19

Here's btrfs version:
# btrfs --version
btrfs-progs v5.16

Here's what happens when I connect, unlock and try to mount the HDD:
# dmesg
...
[ 5058.244319] usb 2-6: new SuperSpeed USB device number 4 using xhci_hcd=

[ 5058.257607] usb 2-6: New USB device found, idVendor=3D0bc2, idProduct=
=3D2322, bcdDevice=3D 1.00
[ 5058.257610] usb 2-6: New USB device strings: Mfr=3D2, Product=3D3, Seri=
alNumber=3D1
[ 5058.257611] usb 2-6: Product: Expansion
[ 5058.257612] usb 2-6: Manufacturer: Seagate
[ 5058.257612] usb 2-6: SerialNumber: --redacted--
[ 5058.261621] scsi host0: uas
[ 5058.262102] scsi 0:0:0:0: Direct-Access=C2=A0=C2=A0=C2=A0=C2=A0 Seagate=
=C2=A0 Expansion=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9300 PQ: 0 ANSI=
: 6
[ 5058.262823] sd 0:0:0:0: [sda] Spinning up disk...
[ 5059.266294] ...ready
[ 5061.314633] sd 0:0:0:0: [sda] 1953525167 512-byte logical blocks: (1.00=
 TB/932 GiB)
[ 5061.397722] sd 0:0:0:0: [sda] Write Protect is off
[ 5061.397725] sd 0:0:0:0: [sda] Mode Sense: 4f 00 00 00
[ 5061.397872] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA
[ 5061.398310] sd 0:0:0:0: [sda] Optimal transfer size 33553920 bytes
[ 5061.431305] sd 0:0:0:0: [sda] Attached SCSI disk
[ 5198.138488] BTRFS info (device dm-2): flagging fs with big metadata fea=
ture
[ 5198.138491] BTRFS info (device dm-2): using free space tree
[ 5198.138492] BTRFS info (device dm-2): has skinny extents
[ 5198.562045] BTRFS error (device dm-2): parent transid verify failed on =
35520512 wanted 2355 found 2383
[ 5198.568539] BTRFS error (device dm-2): parent transid verify failed on =
35520512 wanted 2355 found 2383
[ 5198.568549] BTRFS warning (device dm-2): failed to read root (objectid=
=3D4): -5
[ 5198.570170] BTRFS error (device dm-2): open_ctree failed


(It is at this point that I get the above mount error.)

I am just a regular user - I haven't used any advanced BTRFS features at a=
ll, just 'mkfs.btrfs' and then 'mount'. That's it.
So the issue is definitely not due to my doing something funny with the fi=
lesystem.
Now, browsing StackExchange and this mailing list I, obviously, didn't fin=
d a solution, otherwise I wouldn't be writing this.
My issue is similar to this one (https://superuser.com/questions/1297540/c=
annot-mount-btrfs-disk-open-ctree-failed), it was, however never answered.=
..

I know I should have made more backups, but yeah, I prefer learning the ha=
rd way, I guess. Very effective, though, and unforgettable for sure!

Any help is greatly appreciated!



Here's the output of a couple more commands I've tried but without any suc=
cess:


* btrfs check:
# sudo btrfs check --super 1 /dev/mapper/sda
using SB copy 1, bytenr 67108864
Opening filesystem to check...
parent transid verify failed on 35520512 wanted 2355 found 2383
parent transid verify failed on 35520512 wanted 2355 found 2383
parent transid verify failed on 35520512 wanted 2355 found 2383
Ignoring transid failure
ERROR: root [4 0] level 0 does not match 1

Couldn't setup device tree
ERROR: cannot open file system


* one more btrfs check:
# btrfs check --mode=3Dlowmem /dev/mapper/sda
Opening filesystem to check...
parent transid verify failed on 35520512 wanted 2355 found 2383
parent transid verify failed on 35520512 wanted 2355 found 2383
parent transid verify failed on 35520512 wanted 2355 found 2383
Ignoring transid failure
ERROR: root [4 0] level 0 does not match 1

Couldn't setup device tree
ERROR: cannot open file system


* btrfs rescue:
# btrfs rescue super-recover -v /dev/mapper/sda
All Devices:
=C2=A0=C2=A0 =C2=A0Device: id =3D 1, name =3D /dev/mapper/sda

Before Recovering:
=C2=A0=C2=A0 =C2=A0[All good supers]:
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0device name =3D /dev/mapper/sda
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0superblock bytenr =3D 65536

=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0device name =3D /dev/mapper/sda
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0superblock bytenr =3D 67108864

=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0device name =3D /dev/mapper/sda
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0superblock bytenr =3D 274877906944=


=C2=A0=C2=A0 =C2=A0[All bad supers]:

All supers are valid, no need to recover


* btrfs-find-root
# btrfs-find-root /dev/mapper/sda
parent transid verify failed on 35520512 wanted 2355 found 2383
parent transid verify failed on 35520512 wanted 2355 found 2383
Couldn't setup device tree
Superblock thinks the generation is 2490
Superblock thinks the level is 0
Found tree root at 500627963904 gen 2490 level 0
Well block 500627570688(gen: 2489 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500627161088(gen: 2488 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500626472960(gen: 2487 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500626259968(gen: 2486 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500626046976(gen: 2485 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500625833984(gen: 2484 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500625620992(gen: 2483 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500625408000(gen: 2482 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500625195008(gen: 2481 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500624982016(gen: 2480 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500624769024(gen: 2479 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500624556032(gen: 2478 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500624343040(gen: 2477 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500624113664(gen: 2476 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500614103040(gen: 2475 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500613890048(gen: 2474 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500613677056(gen: 2473 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500613464064(gen: 2472 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500613251072(gen: 2471 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500613005312(gen: 2470 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500612759552(gen: 2469 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500612546560(gen: 2468 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500612169728(gen: 2467 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500611629056(gen: 2466 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500610449408(gen: 2465 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500609777664(gen: 2464 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500609515520(gen: 2463 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500609318912(gen: 2462 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500607434752(gen: 2461 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500607074304(gen: 2460 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500606812160(gen: 2459 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500606091264(gen: 2458 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500605616128(gen: 2457 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500605452288(gen: 2456 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500604911616(gen: 2455 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500603568128(gen: 2454 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500602798080(gen: 2453 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500602454016(gen: 2452 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500602109952(gen: 2451 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500601667584(gen: 2450 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500600995840(gen: 2449 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500600438784(gen: 2448 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500599816192(gen: 2447 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500599111680(gen: 2446 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500598472704(gen: 2445 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500598112256(gen: 2444 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500597702656(gen: 2443 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500597325824(gen: 2442 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500594704384(gen: 2441 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500594294784(gen: 2440 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500593950720(gen: 2439 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500593557504(gen: 2438 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500593098752(gen: 2437 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500592214016(gen: 2436 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500590510080(gen: 2435 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500590018560(gen: 2434 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500589674496(gen: 2433 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500589084672(gen: 2432 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500586479616(gen: 2431 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 224919552(gen: 2430 level: 0) seems good, but generation/level =
doesn't match, want gen: 2490 level: 0
Well block 36470784(gen: 2406 level: 0) seems good, but generation/level d=
oesn't match, want gen: 2490 level: 0
Well block 36618240(gen: 2383 level: 0) seems good, but generation/level d=
oesn't match, want gen: 2490 level: 0
Well block 30490624(gen: 2382 level: 0) seems good, but generation/level d=
oesn't match, want gen: 2490 level: 0
Well block 39043072(gen: 2358 level: 0) seems good, but generation/level d=
oesn't match, want gen: 2490 level: 0
Well block 500519911424(gen: 2354 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0
Well block 500519698432(gen: 2353 level: 0) seems good, but generation/lev=
el doesn't match, want gen: 2490 level: 0


* btrfs restore
# btrfs restore /dev/mapper/sda /tmp
parent transid verify failed on 35520512 wanted 2355 found 2383
parent transid verify failed on 35520512 wanted 2355 found 2383
parent transid verify failed on 35520512 wanted 2355 found 2383
Ignoring transid failure
ERROR: root [4 0] level 0 does not match 1

Couldn't setup device tree
Could not open root, trying backup super
parent transid verify failed on 35520512 wanted 2355 found 2383
parent transid verify failed on 35520512 wanted 2355 found 2383
parent transid verify failed on 35520512 wanted 2355 found 2383
Ignoring transid failure
ERROR: root [4 0] level 0 does not match 1

Couldn't setup device tree
Could not open root, trying backup super
parent transid verify failed on 35520512 wanted 2355 found 2383
parent transid verify failed on 35520512 wanted 2355 found 2383
parent transid verify failed on 35520512 wanted 2355 found 2383
Ignoring transid failure
ERROR: root [4 0] level 0 does not match 1

Couldn't setup device tree
Could not open root, trying backup super


* This custom mount command produces the following output in dmesg:
# mount -t btrfs -o recovery,nospace_cache,clear_cache,ro /dev/mapper/sda =
/mnt/hdd
mount: /mnt/hdd: wrong fs type, bad option, bad superblock on /dev/mapper/=
sda, missing codepage or helper program, or other error.

# dmesg
...
[ 6683.966291] BTRFS info (device dm-2): flagging fs with big metadata fea=
ture
[ 6683.966296] BTRFS warning (device dm-2): 'recovery' is deprecated, use =
'rescue=3Dusebackuproot' instead
[ 6683.966297] BTRFS info (device dm-2): trying to use backup root at moun=
t time
[ 6683.966298] BTRFS info (device dm-2): disabling free space tree
[ 6683.966299] BTRFS info (device dm-2): force clearing of disk cache
[ 6683.966299] BTRFS info (device dm-2): has skinny extents
[ 6683.985428] BTRFS error (device dm-2): parent transid verify failed on =
35520512 wanted 2355 found 2383
[ 6683.988343] BTRFS error (device dm-2): parent transid verify failed on =
35520512 wanted 2355 found 2383
[ 6683.988351] BTRFS warning (device dm-2): failed to read root (objectid=
=3D4): -5
[ 6684.331633] BTRFS error (device dm-2): parent transid verify failed on =
35520512 wanted 2355 found 2383
[ 6684.331961] BTRFS error (device dm-2): parent transid verify failed on =
35520512 wanted 2355 found 2383
[ 6684.331966] BTRFS warning (device dm-2): failed to read root (objectid=
=3D4): -5
[ 6684.345910] BTRFS error (device dm-2): parent transid verify failed on =
35520512 wanted 2355 found 2383
[ 6684.346238] BTRFS error (device dm-2): parent transid verify failed on =
35520512 wanted 2355 found 2383
[ 6684.346242] BTRFS warning (device dm-2): failed to read root (objectid=
=3D4): -5
[ 6684.352732] BTRFS error (device dm-2): parent transid verify failed on =
35520512 wanted 2355 found 2383
[ 6684.353066] BTRFS error (device dm-2): parent transid verify failed on =
35520512 wanted 2355 found 2383
[ 6684.353070] BTRFS warning (device dm-2): failed to read root (objectid=
=3D4): -5
[ 6684.354139] BTRFS error (device dm-2): open_ctree failed


* At the moment I am (still) running:
# btrfs rescue chunk-recover -y /dev/mapper/sda

(takes a while, but I don't expect much)

By the way, I also have access to a different machine (Linux 6.5.7) with a=
 newer version of btrfs (v6.5.3).
Please let me know if you need the command output from that, I will run it=
 once 'btrfcs rescue chunk-recover' finishes.
Essentially, it still fails to mount, but the dmesg looks slightly differe=
nt, something like:

# dmesg
failed to read root (objectid=3D4): -5

try to load backup roots slot 1
global root 2 0 already exists
failed to load root extent

try to load backup roots slot 2
global root 2 0 already exists
failed to load root extent

try to load backup roots slot 3
global root 2 0 already exists
failed to load root extent

open_ctree failed

