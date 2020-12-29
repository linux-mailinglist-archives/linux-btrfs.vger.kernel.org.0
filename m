Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B612E6F63
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 10:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgL2JcJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Dec 2020 04:32:09 -0500
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:56512 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726014AbgL2JcI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Dec 2020 04:32:08 -0500
Received: from rain.speed47.net (nginx [192.168.80.2])
        by box.speed47.net (Postfix) with ESMTPSA id 86DAA1C8;
        Tue, 29 Dec 2020 10:31:26 +0100 (CET)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1609234286;
        bh=sx8SQweIl2BOB6X2TFL21gIlYUbrvFe80e4FLGcyunk=;
        h=Date:From:Subject:To:In-Reply-To:References;
        b=VRPO6rBsa1BD8kRCgG2yVg1g8nvNMla5YPgx60olHjh76EdjUuS643QtGLsNVpX5v
         Mi4t6o+N3gitdsoxE8VYq4sqGla8Hs1v6P7GmplkTIIibomZkvN+1bBSAGeX6xztsu
         RZNKqFrb2HM7razx8AQRgjA/Wp7Qz+i/T3+J0NL4=
MIME-Version: 1.0
Date:   Tue, 29 Dec 2020 09:31:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "=?utf-8?B?U3TDqXBoYW5lIExlc2ltcGxl?=" <stephane_btrfs2@lesimple.fr>
Message-ID: <646f448658476866588fc364cf1df07a@lesimple.fr>
Subject: Re: 5.6-5.10 balance regression?
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>, "Qu Wenruo" <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
In-Reply-To: <5f819b6c-d737-bb73-5382-370875b599c1@gmx.com>
References: <5f819b6c-d737-bb73-5382-370875b599c1@gmx.com>
 <518c15d55c3d540b26341a773ff7d99f@lesimple.fr>
 <da42984a-1f75-153a-b7fd-145e0d66b6d4@suse.com>
 <505cabfa88575ed6dbe7cb922d8914fb@lesimple.fr>
 <292de7b8-42eb-0c39-d8c7-9a366f688731@prnet.org>
 <2846fc85-6bd3-ae7e-6770-c75096e5d547@gmx.com>
 <344c4bfd-3189-2bf5-9282-2f7b3cb23972@prnet.org>
 <1904ed2c92224d38747377b43e462353@lesimple.fr>
 <485db52d-cf4d-3a5c-9253-13cdb40ccd5e@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

>> Mind me to craft a fix with your signed-off-by?=0A=0ASure!=0A=0A> The =
problem is more complex than I thought, but still we at least have=0A> so=
me workaround.=0A> =0A> Firstly, this happens when an old fs get v2 space=
 cache enabled, but=0A> still has v1 space cache left.=0A> =0A> Newer v2 =
mount should cleanup v1 properly, but older kernel doesn't do=0A> the pro=
per cleaning, thus left some v1 cache.=0A> =0A> Then we call btrfs balanc=
e on such old fs, leading to the -ENOENT error.=0A> We can't ignore the e=
rror, as we have no way to relocate such left over=0A> v1 cache (normally=
 we delete it completely, but with v2 cache, we can't).=0A> =0A> So what =
I can do is only to add a warning message to the problem.=0A> =0A> To sol=
ve your problem, I also submitted a patch to btrfs-progs, to force=0A> v1=
 space cache cleaning even if the fs has v2 space cache enabled.=0A> =0A>=
 Or, you can disable v2 space cache first, using "btrfs check=0A> --clear=
-space-cache v2" first, then "btrfs check --clear-space_cache=0A> v1", an=
d finally mount the fs with "space_cache=3Dv2" again.=0A> =0A> To verify =
there is no space cache v1 left, you can run the following=0A> command to=
 verify:=0A> =0A> # btrfs ins dump-tree -t root <device> | grep EXTENT_DA=
TA=0A> =0A> It should output nothing.=0A> =0A> Then please try if you can=
 balance all your data.=0A=0AYour analysis is correct, I do have v1 lefto=
vers as I commented on=0Athe [PATCH] you've sent.=0A=0ANow, fixing the FS=
:=0A# btrfs check --clear-space-cache v2 /dev/mapper/luks-tank-mdata=0AOp=
ening filesystem to check...=0AChecking filesystem on /dev/mapper/luks-ta=
nk-mdata=0AUUID: 428b20da-dcb1-403e-b407-ba984fd07ebd=0AClear free space =
cache v2=0ASegmentation fault=0A=0AWow, okay. That's unexpected.=0A=0A# b=
trfs --version=0Abtrfs-progs v5.9 =0A=0A(gdb) r=0AStarting program: /usr/=
local/bin/btrfs check --clear-space-cache v2 /dev/mapper/luks-tank-mdata=
=0A[Thread debugging using libthread_db enabled]=0AUsing host libthread_d=
b library "/lib/x86_64-linux-gnu/libthread_db.so.1".=0AOpening filesystem=
 to check...=0AChecking filesystem on /dev/mapper/luks-tank-mdata=0AUUID:=
 428b20da-dcb1-403e-b407-ba984fd07ebd=0AClear free space cache v2=0A=0APr=
ogram received signal SIGSEGV, Segmentation fault.=0Abalance_level (level=
=3D<optimized out>, path=3D0x555555649490, root=3D0x555555645da0, trans=
=3D<optimized out>) at kernel-shared/ctree.c:930=0A930                   =
          root_sub_used(root, right->len);=0A(gdb) bt=0A#0  balance_level=
 (level=3D<optimized out>, path=3D0x555555649490, root=3D0x555555645da0, =
trans=3D<optimized out>) at kernel-shared/ctree.c:930=0A#1  btrfs_search_=
slot (trans=3Dtrans@entry=3D0x55555e8b4d30, root=3Droot@entry=3D0x5555556=
45da0, key=3Dkey@entry=3D0x7fffffffe000, p=3Dp@entry=3D0x555555649490, in=
s_len=3Dins_len@entry=3D-1, cow=3Dcow@entry=3D1)=0A    at kernel-shared/c=
tree.c:1320=0A#2  0x00005555555e3da7 in clear_free_space_tree (root=3D0x5=
55555645da0, trans=3D0x55555e8b4d30) at kernel-shared/free-space-tree.c:1=
161=0A#3  btrfs_clear_free_space_tree (fs_info=3D<optimized out>) at kern=
el-shared/free-space-tree.c:1201=0A#4  0x000055555558cd5f in do_clear_fre=
e_space_cache (clear_version=3Dclear_version@entry=3D2) at check/main.c:9=
872=0A#5  0x000055555559acce in cmd_check (cmd=3D0x555555638900 <cmd_stru=
ct_check>, argc=3D<optimized out>, argv=3D0x7fffffffe490) at check/main.c=
:10194=0A#6  0x000055555556ae88 in cmd_execute (argv=3D0x7fffffffe490, ar=
gc=3D4, cmd=3D0x555555638900 <cmd_struct_check>) at cmds/commands.h:125=
=0A#7  main (argc=3D4, argv=3D0x7fffffffe490) at btrfs.c:402=0A(gdb) =0A=
=0ACan v1 leftovers provoke this?=0A=0AThe patch you've sent for btrfs-pr=
ogs might fix my problem as I wouldn't need=0Ato remove space_cache v2 fi=
rst, so I may not hit this bug, but if you're interested=0Ain looking int=
o this one too, we might kill one bird with two stones!=0A=0AI'm leaving =
my FS as is waiting for your reply,=0A=0ARegards,=0A=0ASt=C3=A9phane.
