Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36212EB279
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 19:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbhAESZJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 13:25:09 -0500
Received: from box5.speed47.net ([188.165.215.42]:47128 "EHLO mx.speed47.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728815AbhAESZI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 13:25:08 -0500
Received: from rain.speed47.net (nginx [192.168.80.2])
        by box.speed47.net (Postfix) with ESMTPSA id A0E66123;
        Tue,  5 Jan 2021 19:24:24 +0100 (CET)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1609871064;
        bh=VYb3xbdcI8bdtdOvrEj54YjWhHaYO+sRUasLVRBOB7Q=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References;
        b=A1w7QxioEepD9gUv0NPKWCYrsiy7ooYfZQmxYI9oT41Nr0Q8GzlIcqKlEtgDmasTz
         Y0e6qNn9ivJmah2jaCVaLl9BiOW7VXqPxhK4EQiZDY0ktjJexhPU/CwAdZ9QwCxZDQ
         ADgTo6VXIsXaxp9Rhdv/8N4NV86GkHuECINbV4ck=
MIME-Version: 1.0
Date:   Tue, 05 Jan 2021 18:24:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "=?utf-8?B?U3TDqXBoYW5lIExlc2ltcGxl?=" <stephane_btrfs2@lesimple.fr>
Message-ID: <7f932027eebe43b2e63908f1d4889e24@lesimple.fr>
Subject: Re: [PATCH] btrfs: relocation: fix wrong file extent type check
 to avoid false -ENOENT error
To:     dsterba@suse.cz, "Qu Wenruo" <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20210104161655.GJ6430@twin.jikos.cz>
References: <20210104161655.GJ6430@twin.jikos.cz>
 <20201229132934.117325-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

FWIW, just recompiled with the patch to be 100% sure, as I still had=0Ath=
e problematic FS around untouched:=0A=0A[  199.722122] BTRFS info (device=
 dm-10): balance: start -dvrange=3D34625344765952..34625344765953=0A[  19=
9.730267] BTRFS info (device dm-10): relocating block group 3462534476595=
2 flags data|raid1=0A[  212.232222] BTRFS info (device dm-10): found 167 =
extents, stage: move data extents=0A[  236.124541] BTRFS info (device dm-=
10): found 167 extents, stage: update data pointers=0A[  248.011778] BTRF=
S info (device dm-10): balance: ended with status: 0=0A=0AAs expected, al=
l is good now!=0A=0ATested-By: St=C3=A9phane Lesimple <stephane_btrfs2@le=
simple.fr>=0A=0A-- =0ASt=C3=A9phane.=0A=0AJanuary 4, 2021 5:18 PM, "David=
 Sterba" <dsterba@suse.cz> wrote:=0A=0A> On Tue, Dec 29, 2020 at 09:29:34=
PM +0800, Qu Wenruo wrote:=0A> =0A>> [BUG]=0A>> There are several bug rep=
orts about recent kernel unable to relocate=0A>> certain data block group=
s.=0A>> =0A>> Sometimes the error just go away, but there is one reporter=
 who can=0A>> reproduce it reliably.=0A>> =0A>> The dmesg would look like=
:=0A>> [ 438.260483] BTRFS info (device dm-10): balance: start -dvrange=
=3D34625344765952..34625344765953=0A>> [ 438.269018] BTRFS info (device d=
m-10): relocating block group 34625344765952 flags data|raid1=0A>> [ 450.=
439609] BTRFS info (device dm-10): found 167 extents, stage: move data ex=
tents=0A>> [ 463.501781] BTRFS info (device dm-10): balance: ended with s=
tatus: -2=0A>> =0A>> [CAUSE]=0A>> The -ENOENT error is returned from the =
following chall chain:=0A>> =0A>> add_data_references()=0A>> |- delete_v1=
_space_cache();=0A>> |- if (!found)=0A>> return -ENOENT;=0A>> =0A>> The v=
ariable @found is set to true if we find a data extent whose=0A>> disk by=
tenr matches parameter @data_bytes.=0A>> =0A>> With extra debug, the offe=
nding tree block looks like this:=0A>> leaf bytenr =3D 42676709441536, da=
ta_bytenr =3D 34626327621632=0A>> =0A>> ctime 1567904822.739884119 (2019-=
09-08 03:07:02)=0A>> mtime 0.0 (1970-01-01 01:00:00)=0A>> otime 0.0 (1970=
-01-01 01:00:00)=0A>> item 27 key (51933 EXTENT_DATA 0) itemoff 9854 item=
size 53=0A>> generation 1517381 type 2 (prealloc)=0A>> prealloc data disk=
 byte 34626327621632 nr 262144 <<<=0A>> prealloc data offset 0 nr 262144=
=0A>> item 28 key (52262 ROOT_ITEM 0) itemoff 9415 itemsize 439=0A>> gene=
ration 2618893 root_dirid 256 bytenr 42677048360960 level 3 refs 1=0A>> l=
astsnap 2618893 byte_limit 0 bytes_used 5557338112 flags 0x0(none)=0A>> u=
uid d0d4361f-d231-6d40-8901-fe506e4b2b53=0A>> =0A>> Although item 27 has =
disk bytenr 34626327621632, which matches the=0A>> data_bytenr, its type =
is prealloc, not reg.=0A>> This makes the existing code skip that item, a=
nd return -ENOENT.=0A>> =0A>> [FIX]=0A>> The code is modified in commit 1=
9b546d7a1b2 ("btrfs: relocation: Use=0A>> btrfs_find_all_leafs to locate =
data extent parent tree leaves"), before=0A>> that commit, we use somethi=
ng like=0A>> "if (type =3D=3D BTRFS_FILE_EXTENT_INLINE) continue;".=0A>> =
=0A>> But in that offending commit, we use (type =3D=3D BTRFS_FILE_EXTENT=
_REG),=0A>> ignoring BTRFS_FILE_EXTENT_PREALLOC.=0A>> =0A>> Fix it by als=
o checking BTRFS_FILE_EXTENT_PREALLOC.=0A>> =0A>> Reported-by: St=C3=A9ph=
ane Lesimple <stephane_btrfs2@lesimple.fr>=0A>> Fixes: 19b546d7a1b2 ("btr=
fs: relocation: Use btrfs_find_all_leafs to locate data extent parent tre=
e=0A>> leaves")=0A>> Signed-off-by: Qu Wenruo <wqu@suse.com>=0A> =0A> Tha=
nk you all for tracking down the bug, added to misc-next.
