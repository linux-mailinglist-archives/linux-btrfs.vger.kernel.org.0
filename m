Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C130D2E70A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 13:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgL2Mar (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Dec 2020 07:30:47 -0500
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:45804 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726014AbgL2Maq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Dec 2020 07:30:46 -0500
Received: from rain.speed47.net (nginx [192.168.80.2])
        by box.speed47.net (Postfix) with ESMTPSA id 22A001C8;
        Tue, 29 Dec 2020 13:30:02 +0100 (CET)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1609245002;
        bh=okQh839YTBW0kiX2H+Kgko/atUU+U++elpL9KkdHv60=;
        h=Date:From:Subject:To:In-Reply-To:References;
        b=eqWnBOSsj+iUlWgq4WAlh+Rf3tF+bi2ffmwrNpERzfPaggvcWDodRKCKP93bkWYWG
         /FRvsXvvvtX9YCJUJkeH30EK8rNakRP6VpLc5ysCySjhYLEbUXRTFUKlHl5Ys8uiIa
         NgN868c/1dzgfOAvuEggjB794+SaZeo6JZAhf5ec=
MIME-Version: 1.0
Date:   Tue, 29 Dec 2020 12:30:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "=?utf-8?B?U3TDqXBoYW5lIExlc2ltcGxl?=" <stephane_btrfs2@lesimple.fr>
Message-ID: <e811efd8b2936a559d665e7303ce0873@lesimple.fr>
Subject: Re: [PATCH] btrfs: relocation: output warning message for
 leftover v1 space cache before aborting current data balance
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>, "Qu Wenruo" <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
In-Reply-To: <82e6288d-7b37-5797-13d9-f786afb33f5d@gmx.com>
References: <82e6288d-7b37-5797-13d9-f786afb33f5d@gmx.com>
 <90cf0737-6d33-94d8-9607-0f9c371c82aa@gmx.com>
 <20201229003837.16074-1-wqu@suse.com>
 <6b4afae37ba5979f25bddabd876a7dc5@lesimple.fr>
 <4f838a67672053e268ffce77ea800a8a@lesimple.fr>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

December 29, 2020 12:32 PM, "Qu Wenruo" <quwenruo.btrfs@gmx.com> wrote:=
=0A=0A> On 2020/12/29 =E4=B8=8B=E5=8D=887:08, St=C3=A9phane Lesimple wrot=
e:=0A> =0A>> December 29, 2020 11:31 AM, "Qu Wenruo" <quwenruo.btrfs@gmx.=
com> wrote:=0A>> =0A>> # btrfs ins dump-tree -t root /dev/mapper/luks-tan=
k-mdata | grep EXTENT_DA=0A>> item 27 key (51933 EXTENT_DATA 0) itemoff 9=
854 itemsize 53=0A>> item 12 key (72271 EXTENT_DATA 0) itemoff 14310 item=
size 53=0A>> item 25 key (74907 EXTENT_DATA 0) itemoff 12230 itemsize 53=
=0A>>> Mind to dump all those related inodes?=0A>>> =0A>>> E.g:=0A>>> =0A=
>>> $ btrfs ins dump-tree -t root <dev> | gerp 51933 -C 10=0A>> =0A>> Sur=
e. I added -w to avoid grepping big numbers just containing the digits 51=
933:=0A>> =0A>> # btrfs ins dump-tree -t root /dev/mapper/luks-tank-mdata=
 | grep 51933 -C 10 -w=0A>> generation 2614632 root_dirid 256 bytenr 4270=
5449811968 level 2 refs 1=0A>> lastsnap 2614456 byte_limit 0 bytes_used 1=
01154816 flags 0x1(RDONLY)=0A>> uuid 1100ff6c-45fa-824d-ad93-869c94a87c7b=
=0A>> parent_uuid 8bb8a884-ea4f-d743-8b0c-b6fdecbc397c=0A>> ctransid 1337=
630 otransid 1249372 stransid 0 rtransid 0=0A>> ctime 1554266422.69348098=
5 (2019-04-03 06:40:22)=0A>> otime 1547877605.465117667 (2019-01-19 07:00=
:05)=0A>> drop key (0 UNKNOWN.0 0) level 0=0A>> item 25 key (51098 ROOT_B=
ACKREF 5) itemoff 10067 itemsize 42=0A>> root backref key dirid 534 seque=
nce 22219 name 20190119_070006_hourly.7=0A>> item 26 key (51933 INODE_ITE=
M 0) itemoff 9907 itemsize 160=0A>> generation 0 transid 1517381 size 262=
144 nbytes 30553407488=0A>> block group 0 mode 100600 links 1 uid 0 gid 0=
 rdev 0=0A>> sequence 116552 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PR=
EALLOC)=0A>> atime 0.0 (1970-01-01 01:00:00)=0A>> ctime 1567904822.739884=
119 (2019-09-08 03:07:02)=0A>> mtime 0.0 (1970-01-01 01:00:00)=0A>> otime=
 0.0 (1970-01-01 01:00:00)=0A>> item 27 key (51933 EXTENT_DATA 0) itemoff=
 9854 itemsize 53=0A>> generation 1517381 type 2 (prealloc)=0A>> prealloc=
 data disk byte 34626327621632 nr 262144=0A>> prealloc data offset 0 nr 2=
62144=0A>> item 28 key (52262 ROOT_ITEM 0) itemoff 9415 itemsize 439=0A>>=
 generation 2618893 root_dirid 256 bytenr 42677048360960 level 3 refs 1=
=0A>> lastsnap 2618893 byte_limit 0 bytes_used 5557338112 flags 0x0(none)=
=0A>> uuid d0d4361f-d231-6d40-8901-fe506e4b2b53=0A>> ctransid 2618893 otr=
ansid 1277275 stransid 0 rtransid 0=0A>> ctime 1609211576.181355141 (2020=
-12-29 04:12:56)=0A>> otime 1550343531.349394412 (2019-02-16 19:58:51)=0A=
>> =0A>>> The point here is to show if we have INODE_ITEM here for the in=
ode number.=0A>> =0A>> I think we do, if I understand the output correctl=
y!=0A>> =0A>>> Although above ins dump should work, I just want to be ext=
ra sure about=0A>>> where the -ENOENT comes from.=0A>>> =0A>>> Would you =
mind to test the following debug output?=0A>> =0A>> Here you go:=0A>> =0A=
>> [ 438.260483] BTRFS info (device dm-10): balance: start -dvrange=3D346=
25344765952..34625344765953=0A>> [ 438.269018] BTRFS info (device dm-10):=
 relocating block group 34625344765952 flags data|raid1=0A>> [ 450.439609=
] BTRFS info (device dm-10): found 167 extents, stage: move data extents=
=0A>> [ 451.026349] delete_v1_space_cache: no FILE_EXTENT found, leaf sta=
rt=3D42676709441536=0A>> data_bytenr=3D34626327621632=0A> =0A> This means=
 the leaf returned by find_all_leafs() is not correct?!=0A> =0A> Would yo=
u please try this one? (Need to clean up previous diff first):=0A=0ASure:=
=0A=0ABTRFS info (device dm-10): balance: start -dvrange=3D34625344765952=
..34625344765953=0ABTRFS info (device dm-10): relocating block group 3462=
5344765952 flags data|raid1=0ABTRFS info (device dm-10): found 167 extent=
s, stage: move data extents=0Adelete_v1_space_cache: no FILE_EXTENT found=
, leaf start=3D42677482782720 data_bytenr=3D34626327621632=0ABTRFS info (=
device dm-10): leaf 42677482782720 gen 2619699 total ptrs 38 free space 6=
595 owner 1=0A        item 0 key (32735 132 726935) itemoff 15844 itemsiz=
e 439=0A                root data bytenr 42705449844736 refs 1=0A        =
item 1 key (32735 144 5) itemoff 15802 itemsize 42=0A        item 2 key (=
32736 132 726938) itemoff 15363 itemsize 439=0A                root data =
bytenr 42705450303488 refs 1=0A        item 3 key (32736 144 5) itemoff 1=
5320 itemsize 43=0A        item 4 key (34615 132 802086) itemoff 14881 it=
emsize 439=0A                root data bytenr 42705443913728 refs 1=0A   =
     item 5 key (34615 144 5) itemoff 14839 itemsize 42=0A        item 6 =
key (34616 132 802088) itemoff 14400 itemsize 439=0A                root =
data bytenr 42705445797888 refs 1=0A        item 7 key (34616 144 5) item=
off 14357 itemsize 43=0A        item 8 key (34688 132 804349) itemoff 139=
18 itemsize 439=0A                root data bytenr 42697575448576 refs 1=
=0A        item 9 key (34688 144 5) itemoff 13874 itemsize 44=0A        i=
tem 10 key (40681 132 0) itemoff 13435 itemsize 439=0A                roo=
t data bytenr 42705844584448 refs 1=0A        item 11 key (40681 144 5) i=
temoff 13414 itemsize 21=0A        item 12 key (46589 132 0) itemoff 1297=
5 itemsize 439=0A                root data bytenr 42705856479232 refs 1=
=0A        item 13 key (46589 144 5) itemoff 12948 itemsize 27=0A        =
item 14 key (50759 132 1239367) itemoff 12509 itemsize 439=0A            =
    root data bytenr 42705450270720 refs 1=0A        item 15 key (50759 1=
44 5) itemoff 12468 itemsize 41=0A        item 16 key (50892 132 1243531)=
 itemoff 12029 itemsize 439=0A                root data bytenr 4270544881=
2544 refs 1=0A        item 17 key (50892 144 5) itemoff 11988 itemsize 41=
=0A        item 18 key (50950 132 1245041) itemoff 11549 itemsize 439=0A =
               root data bytenr 42705448779776 refs 1=0A        item 19 k=
ey (50950 144 5) itemoff 11508 itemsize 41=0A        item 20 key (51007 1=
32 1246989) itemoff 11069 itemsize 439=0A                root data bytenr=
 42705447649280 refs 1=0A        item 21 key (51007 144 5) itemoff 11028 =
itemsize 41=0A        item 22 key (51068 132 1248396) itemoff 10589 items=
ize 439=0A                root data bytenr 42705450156032 refs 1=0A      =
  item 23 key (51068 144 5) itemoff 10548 itemsize 41=0A        item 24 k=
ey (51098 132 1249372) itemoff 10109 itemsize 439=0A                root =
data bytenr 42705449811968 refs 1=0A        item 25 key (51098 144 5) ite=
moff 10067 itemsize 42=0A        item 26 key (51933 1 0) itemoff 9907 ite=
msize 160=0A                inode generation 0 size 262144 mode 100600=0A=
        item 27 key (51933 108 0) itemoff 9854 itemsize 53=0A            =
    extent data disk bytenr 34626327621632 nr 262144=0A                ex=
tent data offset 0 nr 262144 ram 262144=0A        item 28 key (52262 132 =
0) itemoff 9415 itemsize 439=0A                root data bytenr 426770483=
60960 refs 1=0A        item 29 key (52262 144 5) itemoff 9392 itemsize 23=
=0A        item 30 key (52267 132 0) itemoff 8953 itemsize 439=0A        =
        root data bytenr 42705856806912 refs 1=0A        item 31 key (522=
67 144 5) itemoff 8931 itemsize 22=0A        item 32 key (52268 132 0) it=
emoff 8492 itemsize 439=0A                root data bytenr 42678619897856=
 refs 1=0A        item 33 key (52268 144 5) itemoff 8471 itemsize 21=0A  =
      item 34 key (52453 132 0) itemoff 8032 itemsize 439=0A             =
   root data bytenr 42705323196416 refs 1=0A        item 35 key (52453 14=
4 5) itemoff 8011 itemsize 21=0A        item 36 key (58841 132 0) itemoff=
 7572 itemsize 439=0A                root data bytenr 42677453111296 refs=
 1=0A        item 37 key (58841 144 5) itemoff 7545 itemsize 27=0ABTRFS w=
arning (device dm-10): leftover v1 space cache found, please use btrfs-ch=
eck --clear-space-cache v1 to clean it up=0ABTRFS info (device dm-10): ba=
lance: ended with status: -2=0A=0ARegards,=0A=0ASt=C3=A9phane.
