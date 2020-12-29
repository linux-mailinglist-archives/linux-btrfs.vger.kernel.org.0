Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769DD2E70D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 14:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgL2NSb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Dec 2020 08:18:31 -0500
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:49740 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725964AbgL2NSb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Dec 2020 08:18:31 -0500
Received: from rain.speed47.net (nginx [192.168.80.2])
        by box.speed47.net (Postfix) with ESMTPSA id 59FC81C8;
        Tue, 29 Dec 2020 14:17:47 +0100 (CET)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1609247867;
        bh=GS1JPWI9ke/o8Xd02xb8qF5NEvnFyi3f6Z1LjdrDQ/k=;
        h=Date:From:Subject:To:In-Reply-To:References;
        b=fcGLv0JDGuSowJV1megoxKevEM3R4T59vahegbFC59xj4BPfpcoG+hwnQ3uESd9jy
         iCWFx04QMAYEdLqQZQCB/i49GvN+ftnYnbN+QIJGdoiHExViH5sEwhJWc5r9M1M7fw
         0dRkr2DSwyy4dHuYSBJBDrWVRLWiX/nX9GgPsJzg=
MIME-Version: 1.0
Date:   Tue, 29 Dec 2020 13:17:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "=?utf-8?B?U3TDqXBoYW5lIExlc2ltcGxl?=" <stephane_btrfs2@lesimple.fr>
Message-ID: <e8107ffa29ffe7285b1da76805bd5fc4@lesimple.fr>
Subject: Re: [PATCH] btrfs: relocation: output warning message for
 leftover v1 space cache before aborting current data balance
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>, "Qu Wenruo" <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
In-Reply-To: <02f6b3d7-c502-fe29-ec74-cce99922296c@gmx.com>
References: <02f6b3d7-c502-fe29-ec74-cce99922296c@gmx.com>
 <43269375-cefd-8059-5335-ed891fdd26fe@suse.com>
 <82e6288d-7b37-5797-13d9-f786afb33f5d@gmx.com>
 <90cf0737-6d33-94d8-9607-0f9c371c82aa@gmx.com>
 <20201229003837.16074-1-wqu@suse.com>
 <6b4afae37ba5979f25bddabd876a7dc5@lesimple.fr>
 <4f838a67672053e268ffce77ea800a8a@lesimple.fr>
 <e811efd8b2936a559d665e7303ce0873@lesimple.fr>
 <9c981dde8dafe773e2a99417e4935f6b@lesimple.fr>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

December 29, 2020 2:08 PM, "Qu Wenruo" <quwenruo.btrfs@gmx.com> wrote:=0A=
=0A> On 2020/12/29 =E4=B8=8B=E5=8D=888:51, St=C3=A9phane Lesimple wrote:=
=0A> =0A>> December 29, 2020 1:43 PM, "Qu Wenruo" <wqu@suse.com> wrote:=
=0A>> =0A>>> On 2020/12/29 =E4=B8=8B=E5=8D=888:30, St=C3=A9phane Lesimple=
 wrote:=0A>> =0A>> December 29, 2020 12:32 PM, "Qu Wenruo" <quwenruo.btrf=
s@gmx.com> wrote:=0A>> =0A>> On 2020/12/29 =E4=B8=8B=E5=8D=887:08, St=C3=
=A9phane Lesimple wrote:=0A>> =0A>> December 29, 2020 11:31 AM, "Qu Wenru=
o" <quwenruo.btrfs@gmx.com> wrote:=0A>> =0A>> # btrfs ins dump-tree -t ro=
ot /dev/mapper/luks-tank-mdata | grep EXTENT_DA=0A>> item 27 key (51933 E=
XTENT_DATA 0) itemoff 9854 itemsize 53=0A>> item 12 key (72271 EXTENT_DAT=
A 0) itemoff 14310 itemsize 53=0A>> item 25 key (74907 EXTENT_DATA 0) ite=
moff 12230 itemsize 53=0A>> Mind to dump all those related inodes?=0A>> =
=0A>> E.g:=0A>> =0A>> $ btrfs ins dump-tree -t root <dev> | gerp 51933 -C=
 10=0A>> =0A>> Sure. I added -w to avoid grepping big numbers just contai=
ning the digits 51933:=0A>> =0A>> # btrfs ins dump-tree -t root /dev/mapp=
er/luks-tank-mdata | grep 51933 -C 10 -w=0A>> generation 2614632 root_dir=
id 256 bytenr 42705449811968 level 2 refs 1=0A>> lastsnap 2614456 byte_li=
mit 0 bytes_used 101154816 flags 0x1(RDONLY)=0A>> uuid 1100ff6c-45fa-824d=
-ad93-869c94a87c7b=0A>> parent_uuid 8bb8a884-ea4f-d743-8b0c-b6fdecbc397c=
=0A>> ctransid 1337630 otransid 1249372 stransid 0 rtransid 0=0A>> ctime =
1554266422.693480985 (2019-04-03 06:40:22)=0A>> otime 1547877605.46511766=
7 (2019-01-19 07:00:05)=0A>> drop key (0 UNKNOWN.0 0) level 0=0A>> item 2=
5 key (51098 ROOT_BACKREF 5) itemoff 10067 itemsize 42=0A>> root backref =
key dirid 534 sequence 22219 name 20190119_070006_hourly.7=0A>> item 26 k=
ey (51933 INODE_ITEM 0) itemoff 9907 itemsize 160=0A>> generation 0 trans=
id 1517381 size 262144 nbytes 30553407488=0A>> block group 0 mode 100600 =
links 1 uid 0 gid 0 rdev 0=0A>> sequence 116552 flags 0x1b(NODATASUM|NODA=
TACOW|NOCOMPRESS|PREALLOC)=0A>> atime 0.0 (1970-01-01 01:00:00)=0A>> ctim=
e 1567904822.739884119 (2019-09-08 03:07:02)=0A>> mtime 0.0 (1970-01-01 0=
1:00:00)=0A>> otime 0.0 (1970-01-01 01:00:00)=0A>> item 27 key (51933 EXT=
ENT_DATA 0) itemoff 9854 itemsize 53=0A>> generation 1517381 type 2 (prea=
lloc)=0A>> prealloc data disk byte 34626327621632 nr 262144=0A>>> Got the=
 point now.=0A>>> =0A>>> The type is preallocated, which means we haven't=
 yet written space cache=0A>>> into it.=0A>>> =0A>>> But the code only ch=
ecks the regular file extent (written, not=0A>>> preallocated).=0A>>> =0A=
>>> So the proper fix would looks like this:=0A>>> =0A>>> diff --git a/fs=
/btrfs/relocation.c b/fs/btrfs/relocation.c=0A>>> index 19b7db8b2117..1d7=
3d7c2fbd7 100644=0A>>> --- a/fs/btrfs/relocation.c=0A>>> +++ b/fs/btrfs/r=
elocation.c=0A>>> @@ -2975,11 +2975,14 @@ static int delete_v1_space_cach=
e(struct=0A>>> extent_buffer *leaf,=0A>>> return 0;=0A>>> =0A>>> for (i =
=3D 0; i < btrfs_header_nritems(leaf); i++) {=0A>>> + u8 type;=0A>>> btrf=
s_item_key_to_cpu(leaf, &key, i);=0A>>> if (key.type !=3D BTRFS_EXTENT_DA=
TA_KEY)=0A>>> continue;=0A>>> ei =3D btrfs_item_ptr(leaf, i, struct=0A>>>=
 btrfs_file_extent_item);=0A>>> - if (btrfs_file_extent_type(leaf, ei) =
=3D=3D=0A>>> BTRFS_FILE_EXTENT_REG &&=0A>>> + type =3D btrfs_file_extent_=
type(leaf, ei);=0A>>> + if ((type =3D=3D BTRFS_FILE_EXTENT_REG ||=0A>>> +=
 type =3D=3D BTRFS_FILE_EXTENT_PREALLOC) &&=0A>>> btrfs_file_extent_disk_=
bytenr(leaf, ei) =3D=3D=0A>>> data_bytenr) {=0A>>> found =3D true;=0A>>> =
space_cache_ino =3D key.objectid;=0A>>> =0A>>> With this, the relocation =
should finish without problem.=0A>> =0A>> Aaah, it makes sense indeed.=0A=
>> =0A>> Do you want me to try this fix right now, or do you want to have=
 a look=0A>> at the btrfs-progs crash first? I don't know if it's related=
, but if it is,=0A>> then maybe I won't be able to reproduce it again aft=
er finishing the balance.=0A> =0A> The problem is, I'm not that confident=
 with v2 space cache debugging,=0A> thus can't help much.=0A> =0A> But at=
 least, the problem you're reporting doesn't really need a=0A> btrfs-chec=
k repair.=0A> Just a kernel fix would be enough.=0A=0AYes indeed.=0A=0A>>=
 I don't mind leaving the FS in this state for a few more days/weeks if n=
eeded.=0A> =0A> That's fine if you want some one to look into the btrfs-p=
rogs bug.=0A=0AI'll leave it like this up to, let's say, mid-January. If =
nobody has expressed interest=0Ain looking into this other problem, I'll =
apply your final patch and complete the balance,=0Aso that you can add a =
Tested-By.=0A=0A> I'll submit a proper bug fix soon.=0A=0AThanks,=0A=0AGo=
od evening!=0A=0A-- =0ASt=C3=A9phane
