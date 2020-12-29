Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3C42E70B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 13:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgL2Mvy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Dec 2020 07:51:54 -0500
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:47524 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726002AbgL2Mvy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Dec 2020 07:51:54 -0500
Received: from rain.speed47.net (nginx [192.168.80.2])
        by box.speed47.net (Postfix) with ESMTPSA id C664B47B;
        Tue, 29 Dec 2020 13:51:11 +0100 (CET)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1609246271;
        bh=rwDACV58CHmMLzSbpkl/obZE009979Np4YQqXMsmxrg=;
        h=Date:From:Subject:To:In-Reply-To:References;
        b=LA9MI4jNvGf563xRpuj3SKscaQjtBElok5+93AwwYvXuTydn8OXA3aXqNCt1xk73n
         K2DbaoxP3oqoI1ZoNmLpCPCBt25TlFUdbumneulDYRiR+E9k0c3D0keEhhpBw9GKy/
         goKzUwOnT3XIpjQIBbHCcj25fsIbUp3M4BtH9QBY=
MIME-Version: 1.0
Date:   Tue, 29 Dec 2020 12:51:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "=?utf-8?B?U3TDqXBoYW5lIExlc2ltcGxl?=" <stephane_btrfs2@lesimple.fr>
Message-ID: <9c981dde8dafe773e2a99417e4935f6b@lesimple.fr>
Subject: Re: [PATCH] btrfs: relocation: output warning message for
 leftover v1 space cache before aborting current data balance
To:     "Qu Wenruo" <wqu@suse.com>, "Qu Wenruo" <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
In-Reply-To: <43269375-cefd-8059-5335-ed891fdd26fe@suse.com>
References: <43269375-cefd-8059-5335-ed891fdd26fe@suse.com>
 <82e6288d-7b37-5797-13d9-f786afb33f5d@gmx.com>
 <90cf0737-6d33-94d8-9607-0f9c371c82aa@gmx.com>
 <20201229003837.16074-1-wqu@suse.com>
 <6b4afae37ba5979f25bddabd876a7dc5@lesimple.fr>
 <4f838a67672053e268ffce77ea800a8a@lesimple.fr>
 <e811efd8b2936a559d665e7303ce0873@lesimple.fr>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

December 29, 2020 1:43 PM, "Qu Wenruo" <wqu@suse.com> wrote:=0A=0A> On 20=
20/12/29 =E4=B8=8B=E5=8D=888:30, St=C3=A9phane Lesimple wrote:=0A> =0A>> =
December 29, 2020 12:32 PM, "Qu Wenruo" <quwenruo.btrfs@gmx.com> wrote:=
=0A>> =0A>>> On 2020/12/29 =E4=B8=8B=E5=8D=887:08, St=C3=A9phane Lesimple=
 wrote:=0A>> =0A>> December 29, 2020 11:31 AM, "Qu Wenruo" <quwenruo.btrf=
s@gmx.com> wrote:=0A>> =0A>> # btrfs ins dump-tree -t root /dev/mapper/lu=
ks-tank-mdata | grep EXTENT_DA=0A>> item 27 key (51933 EXTENT_DATA 0) ite=
moff 9854 itemsize 53=0A>> item 12 key (72271 EXTENT_DATA 0) itemoff 1431=
0 itemsize 53=0A>> item 25 key (74907 EXTENT_DATA 0) itemoff 12230 itemsi=
ze 53=0A>> Mind to dump all those related inodes?=0A>> =0A>> E.g:=0A>> =
=0A>> $ btrfs ins dump-tree -t root <dev> | gerp 51933 -C 10=0A>> =0A>> S=
ure. I added -w to avoid grepping big numbers just containing the digits =
51933:=0A>> =0A>> # btrfs ins dump-tree -t root /dev/mapper/luks-tank-mda=
ta | grep 51933 -C 10 -w=0A>> generation 2614632 root_dirid 256 bytenr 42=
705449811968 level 2 refs 1=0A>> lastsnap 2614456 byte_limit 0 bytes_used=
 101154816 flags 0x1(RDONLY)=0A>> uuid 1100ff6c-45fa-824d-ad93-869c94a87c=
7b=0A>> parent_uuid 8bb8a884-ea4f-d743-8b0c-b6fdecbc397c=0A>> ctransid 13=
37630 otransid 1249372 stransid 0 rtransid 0=0A>> ctime 1554266422.693480=
985 (2019-04-03 06:40:22)=0A>> otime 1547877605.465117667 (2019-01-19 07:=
00:05)=0A>> drop key (0 UNKNOWN.0 0) level 0=0A>> item 25 key (51098 ROOT=
_BACKREF 5) itemoff 10067 itemsize 42=0A>> root backref key dirid 534 seq=
uence 22219 name 20190119_070006_hourly.7=0A>> item 26 key (51933 INODE_I=
TEM 0) itemoff 9907 itemsize 160=0A>> generation 0 transid 1517381 size 2=
62144 nbytes 30553407488=0A>> block group 0 mode 100600 links 1 uid 0 gid=
 0 rdev 0=0A>> sequence 116552 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|=
PREALLOC)=0A>> atime 0.0 (1970-01-01 01:00:00)=0A>> ctime 1567904822.7398=
84119 (2019-09-08 03:07:02)=0A>> mtime 0.0 (1970-01-01 01:00:00)=0A>> oti=
me 0.0 (1970-01-01 01:00:00)=0A>> item 27 key (51933 EXTENT_DATA 0) itemo=
ff 9854 itemsize 53=0A>> generation 1517381 type 2 (prealloc)=0A>> preall=
oc data disk byte 34626327621632 nr 262144=0A> =0A> Got the point now.=0A=
> =0A> The type is preallocated, which means we haven't yet written space=
 cache=0A> into it.=0A> =0A> But the code only checks the regular file ex=
tent (written, not=0A> preallocated).=0A> =0A> So the proper fix would lo=
oks like this:=0A> =0A> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/rel=
ocation.c=0A> index 19b7db8b2117..1d73d7c2fbd7 100644=0A> --- a/fs/btrfs/=
relocation.c=0A> +++ b/fs/btrfs/relocation.c=0A> @@ -2975,11 +2975,14 @@ =
static int delete_v1_space_cache(struct=0A> extent_buffer *leaf,=0A> retu=
rn 0;=0A> =0A> for (i =3D 0; i < btrfs_header_nritems(leaf); i++) {=0A> +=
 u8 type;=0A> btrfs_item_key_to_cpu(leaf, &key, i);=0A> if (key.type !=3D=
 BTRFS_EXTENT_DATA_KEY)=0A> continue;=0A> ei =3D btrfs_item_ptr(leaf, i, =
struct=0A> btrfs_file_extent_item);=0A> - if (btrfs_file_extent_type(leaf=
, ei) =3D=3D=0A> BTRFS_FILE_EXTENT_REG &&=0A> + type =3D btrfs_file_exten=
t_type(leaf, ei);=0A> + if ((type =3D=3D BTRFS_FILE_EXTENT_REG ||=0A> + t=
ype =3D=3D BTRFS_FILE_EXTENT_PREALLOC) &&=0A> btrfs_file_extent_disk_byte=
nr(leaf, ei) =3D=3D=0A> data_bytenr) {=0A> found =3D true;=0A> space_cach=
e_ino =3D key.objectid;=0A>=0A> With this, the relocation should finish w=
ithout problem.=0A=0AAaah, it makes sense indeed.=0A=0ADo you want me to =
try this fix right now, or do you want to have a look=0Aat the btrfs-prog=
s crash first? I don't know if it's related, but if it is,=0Athen maybe I=
 won't be able to reproduce it again after finishing the balance.=0A=0AI =
don't mind leaving the FS in this state for a few more days/weeks if need=
ed.=0A=0A> Thanks for all your effort, from reporting to most of the debu=
g, this=0A> really helps a lot!=0A=0ANo problem, glad to help. Thanks for=
 looking into it so fast!=0A=0A-- =0ASt=C3=A9phane.
