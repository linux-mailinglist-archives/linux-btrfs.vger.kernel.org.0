Return-Path: <linux-btrfs+bounces-17228-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F39BA56A1
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Sep 2025 02:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78BBA7B3349
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Sep 2025 00:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE431C4A2D;
	Sat, 27 Sep 2025 00:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PdbhtiUK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AAE17E4
	for <linux-btrfs@vger.kernel.org>; Sat, 27 Sep 2025 00:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758932760; cv=none; b=FCbNVAJbFrc1nx+yEaYCVcOYzBO3EFle+Ws4TkPMnB1pCOaCT5piWFdZ9A3uSAyvU3IRS8AcRFeamYKn8k2l8VGzVVPEHi0AdkKVHN4i3BN4wHcJ/2QNNgBwOzAfDStUiIlUfWqzF0RZ4qlTZ73jgVJgCui/j6NSrsY6DnA2IQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758932760; c=relaxed/simple;
	bh=heSoDk+UTEbRM85bGbkvbkSwpH40/FdSJwweEF3ElpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VnSa2kv8Kb/BwB+lOkQFS93I0y/Tr231w17noAUZpIHMBm4wdsQzSpC+GQMuPIk3+JbycsH6W9JSQ68kwL8pN3vS+HdL3o4G642Vn3nwyeuo8mm7/5RzkjY4QWIVBmX1BGG/GnuhHG1PQtkvkz9CmrxqkowpnIOK1Ofh76zIKXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=PdbhtiUK; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1758932754; x=1759537554; i=quwenruo.btrfs@gmx.com;
	bh=0oeGr1wFWU9aGHHjDqgyDWi4r7Df2XvOHHCia3W0ATY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PdbhtiUKlWuezjRU8GXxvFpdy2cLRomvRURXBgUll+uyCpWwn3ZZGlWL4y6jiQNK
	 EWxi1U6mPEgeYdIH2bPVZA23bNW1GQqFrsGEyQjsuXU9tWGflgd4ufNtbgj6NCopg
	 KFDzlN9WbNsTexGB1p9sIYnd0mVIV5gt4KOPUPV6BCOH8nMRBesAi78Bc9JODNbie
	 xtfWb58R4SUjEzs/GVlRgMrItwPzb8Eq2gLJqPWJHSnB+rz7S/64d7zcIAtUuJwRG
	 ae681nnPeBxmG1XELFGMIqwnixYMoN8YendlEuyVCt6nMsY0+eKpZkmuyvSC/lEfS
	 W7lAlFct4zW0rlit3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1wll-1uMOOO0HyT-012t1C; Sat, 27
 Sep 2025 02:25:53 +0200
Message-ID: <3f40c6ba-92c8-4624-8798-98f8915e78e8@gmx.com>
Date: Sat, 27 Sep 2025 09:55:50 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] btrfs-progs 6.16.1: `btrfs rescue chunk-recover` fails with
 "Couldn't read tree root" on a healthy filesystem
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CABXGCsOug_bxVZ5CN1EM0sd9U4JAz=Jf5EB2TQe8gs9=KZvWEA@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <CABXGCsOug_bxVZ5CN1EM0sd9U4JAz=Jf5EB2TQe8gs9=KZvWEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eL1dZgHDGTpDW1kiINckXeVT4FbbzeJj+skvFBj9L4mfRuYloAi
 48va6NKUskJCOPBGuTJ/9oK1esHDSB2efDxR8oXTMwUI6QbUlQuRGCNEHI1s4Np8yPUpLpj
 85sO0rvK8CnnZzvkWyxDontXzcD9H0cPe2OR1dgHxdtVKRgWSSZNkWo+ZcQOE6uFHnc9fiR
 +5JsilM+wGc5v+PMV6lQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rs+hCGyOfOM=;5yGBOv/QxWeE1iau9CZtXdKp1gs
 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
 3vxe1PTPto5jh0xWg=



=E5=9C=A8 2025/9/27 08:12, Mikhail Gavrilov =E5=86=99=E9=81=93:
> Hi,
>=20
> I accidentally ran `btrfs rescue chunk-recover` on a healthy Btrfs files=
ystem
> and noticed that it fails in an unexpected way.
>=20
> System:
> - Fedora 44
> - btrfs-progs-6.16.1-1.fc44.x86_64
> - Linux 6.17.0-0.rc7.250924gcec1e6e5d1ab3.58.fc44.x86_64+debug
> - Single-device FS on /dev/nvme1n1p1
>=20
> Filesystem mounts and works normally. No issues in daily use.
>=20
> However, when I run:
>=20
>      # btrfs rescue chunk-recover /dev/nvme1n1p1
>=20
> it ends with:
>=20
>      Couldn't read tree root
>      open with broken chunk error
>=20
> and prints a long sequence of "corrupt leaf" / "unexpected item end" mes=
sages.
>=20
> Full output is below for clarity:
> # btrfs rescue chunk-recover /dev/nvme1n1p1
> Scanning: DONE in dev0
> corrupt leaf: root=3D1 block=3D13924671995904 slot=3D0, unexpected item =
end,
> have 16283 expect 0

This is indeed a bug, that the introduction of=20
btrfs_fs_info::leaf_data_size is not considering the very old codes=20
inside chunk recovery, so that open_ctree_with_broken_chunk() doesn't=20
populate leaf_data_size, and triggered the above failure.

I'll send out a patch to fix it by removing the stupid idea of=20
btrfs_fs_info::leaf_data_size completely.

Thanks,
Qu

> leaf 13924671995904 items 11 free space 12709 generation 1589644 owner R=
OOT_TREE
> leaf 13924671995904 flags 0x1(WRITTEN) backref revision 1
> fs uuid 95e074d1-833a-4d5e-bc62-66897be15556
> chunk uuid deabd921-0650-4625-9707-e363129fb9c1
> item 0 key (EXTENT_TREE ROOT_ITEM 0) itemoff 15844 itemsize 439
> generation 1589644 root_dirid 0 bytenr 13924660658176 byte_limit 0
> bytes_used 736526336
> last_snapshot 0 flags 0x0(none) refs 1
> drop_progress key (0 UNKNOWN.0 0) drop_level 0
> level 2 generation_v2 1589644
> uuid 00000000-0000-0000-0000-000000000000
> parent_uuid 00000000-0000-0000-0000-000000000000
> received_uuid 00000000-0000-0000-0000-000000000000
> ctransid 0 otransid 0 stransid 0 rtransid 0
> ctime 0.0 (1970-01-01 00:00:00)
> otime 0.0 (1970-01-01 00:00:00)
> stime 0.0 (1970-01-01 00:00:00)
> rtime 0.0 (1970-01-01 00:00:00)
> item 1 key (DEV_TREE ROOT_ITEM 0) itemoff 15405 itemsize 439
> generation 1588108 root_dirid 0 bytenr 19868776087552 byte_limit 0
> bytes_used 1474560
> last_snapshot 0 flags 0x0(none) refs 1
> drop_progress key (0 UNKNOWN.0 0) drop_level 0
> level 1 generation_v2 1588108
> uuid 00000000-0000-0000-0000-000000000000
> parent_uuid 00000000-0000-0000-0000-000000000000
> received_uuid 00000000-0000-0000-0000-000000000000
> ctransid 0 otransid 0 stransid 0 rtransid 0
> ctime 0.0 (1970-01-01 00:00:00)
> otime 0.0 (1970-01-01 00:00:00)
> stime 0.0 (1970-01-01 00:00:00)
> rtime 0.0 (1970-01-01 00:00:00)
> item 2 key (FS_TREE INODE_REF 6) itemoff 15388 itemsize 17
> index 0 namelen 7 name: default
> item 3 key (FS_TREE ROOT_ITEM 0) itemoff 14949 itemsize 439
> generation 1589644 root_dirid 256 bytenr 13924670046208 byte_limit 0
> bytes_used 5382389760
> last_snapshot 0 flags 0x0(none) refs 1
> drop_progress key (0 UNKNOWN.0 0) drop_level 0
> level 3 generation_v2 1589644
> uuid ed6fc36e-c846-4fa7-8985-0ad8d02b3d81
> parent_uuid 00000000-0000-0000-0000-000000000000
> received_uuid 00000000-0000-0000-0000-000000000000
> ctransid 1589644 otransid 0 stransid 0 rtransid 0
> ctime 1758883901.662733695 (2025-09-26 10:51:41)
> otime 1687097304.0 (2023-06-18 14:08:24)
> stime 0.0 (1970-01-01 00:00:00)
> rtime 0.0 (1970-01-01 00:00:00)
> item 4 key (ROOT_TREE_DIR INODE_ITEM 0) itemoff 14789 itemsize 160
> generation 3 transid 0 size 0 nbytes 16384
> block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
> sequence 0 flags 0x0(none)
> atime 1687097304.0 (2023-06-18 14:08:24)
> ctime 1687097304.0 (2023-06-18 14:08:24)
> mtime 1687097304.0 (2023-06-18 14:08:24)
> otime 1687097304.0 (2023-06-18 14:08:24)
> item 5 key (ROOT_TREE_DIR INODE_REF 6) itemoff 14777 itemsize 12
> index 0 namelen 2 name: ..
> item 6 key (ROOT_TREE_DIR DIR_ITEM 2378154706) itemoff 14740 itemsize 37
> location key (FS_TREE ROOT_ITEM 18446744073709551615) type DIR
> transid 0 data_len 0 name_len 7
> name: default
> item 7 key (CSUM_TREE ROOT_ITEM 0) itemoff 14301 itemsize 439
> generation 1589644 root_dirid 0 bytenr 13924661035008 byte_limit 0
> bytes_used 18805227520
> last_snapshot 0 flags 0x0(none) refs 1
> drop_progress key (0 UNKNOWN.0 0) drop_level 0
> level 3 generation_v2 1589644
> uuid 00000000-0000-0000-0000-000000000000
> parent_uuid 00000000-0000-0000-0000-000000000000
> received_uuid 00000000-0000-0000-0000-000000000000
> ctransid 0 otransid 0 stransid 0 rtransid 0
> ctime 0.0 (1970-01-01 00:00:00)
> otime 0.0 (1970-01-01 00:00:00)
> stime 0.0 (1970-01-01 00:00:00)
> rtime 0.0 (1970-01-01 00:00:00)
> item 8 key (UUID_TREE ROOT_ITEM 0) itemoff 13862 itemsize 439
> generation 5 root_dirid 0 bytenr 30539776 byte_limit 0 bytes_used 16384
> last_snapshot 0 flags 0x0(none) refs 1
> drop_progress key (0 UNKNOWN.0 0) drop_level 0
> level 0 generation_v2 5
> uuid 00000000-0000-0000-0000-000000000000
> parent_uuid 00000000-0000-0000-0000-000000000000
> received_uuid 00000000-0000-0000-0000-000000000000
> ctransid 0 otransid 0 stransid 0 rtransid 0
> ctime 0.0 (1970-01-01 00:00:00)
> otime 0.0 (1970-01-01 00:00:00)
> stime 0.0 (1970-01-01 00:00:00)
> rtime 0.0 (1970-01-01 00:00:00)
> item 9 key (FREE_SPACE_TREE ROOT_ITEM 0) itemoff 13423 itemsize 439
> generation 1589644 root_dirid 0 bytenr 13924660756480 byte_limit 0
> bytes_used 14368768
> last_snapshot 0 flags 0x0(none) refs 1
> drop_progress key (0 UNKNOWN.0 0) drop_level 0
> level 2 generation_v2 1589644
> uuid 00000000-0000-0000-0000-000000000000
> parent_uuid 00000000-0000-0000-0000-000000000000
> received_uuid 00000000-0000-0000-0000-000000000000
> ctransid 0 otransid 0 stransid 0 rtransid 0
> ctime 0.0 (1970-01-01 00:00:00)
> otime 0.0 (1970-01-01 00:00:00)
> stime 0.0 (1970-01-01 00:00:00)
> rtime 0.0 (1970-01-01 00:00:00)
> item 10 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 12984 itemsize 439
> generation 5 root_dirid 256 bytenr 30523392 byte_limit 0 bytes_used 1638=
4
> last_snapshot 0 flags 0x0(none) refs 1
> drop_progress key (0 UNKNOWN.0 0) drop_level 0
> level 0 generation_v2 5
> uuid 00000000-0000-0000-0000-000000000000
> parent_uuid 00000000-0000-0000-0000-000000000000
> received_uuid 00000000-0000-0000-0000-000000000000
> ctransid 0 otransid 0 stransid 0 rtransid 0
> ctime 0.0 (1970-01-01 00:00:00)
> otime 0.0 (1970-01-01 00:00:00)
> stime 0.0 (1970-01-01 00:00:00)
> rtime 0.0 (1970-01-01 00:00:00)
> corrupt leaf: root=3D1 block=3D13924671995904 slot=3D0, unexpected item =
end,
> have 16283 expect 0
> leaf 13924671995904 items 11 free space 12709 generation 1589644 owner R=
OOT_TREE
> leaf 13924671995904 flags 0x1(WRITTEN) backref revision 1
> fs uuid 95e074d1-833a-4d5e-bc62-66897be15556
> chunk uuid deabd921-0650-4625-9707-e363129fb9c1
> item 0 key (EXTENT_TREE ROOT_ITEM 0) itemoff 15844 itemsize 439
> generation 1589644 root_dirid 0 bytenr 13924660658176 byte_limit 0
> bytes_used 736526336
> last_snapshot 0 flags 0x0(none) refs 1
> drop_progress key (0 UNKNOWN.0 0) drop_level 0
> level 2 generation_v2 1589644
> uuid 00000000-0000-0000-0000-000000000000
> parent_uuid 00000000-0000-0000-0000-000000000000
> received_uuid 00000000-0000-0000-0000-000000000000
> ctransid 0 otransid 0 stransid 0 rtransid 0
> ctime 0.0 (1970-01-01 00:00:00)
> otime 0.0 (1970-01-01 00:00:00)
> stime 0.0 (1970-01-01 00:00:00)
> rtime 0.0 (1970-01-01 00:00:00)
> item 1 key (DEV_TREE ROOT_ITEM 0) itemoff 15405 itemsize 439
> generation 1588108 root_dirid 0 bytenr 19868776087552 byte_limit 0
> bytes_used 1474560
> last_snapshot 0 flags 0x0(none) refs 1
> drop_progress key (0 UNKNOWN.0 0) drop_level 0
> level 1 generation_v2 1588108
> uuid 00000000-0000-0000-0000-000000000000
> parent_uuid 00000000-0000-0000-0000-000000000000
> received_uuid 00000000-0000-0000-0000-000000000000
> ctransid 0 otransid 0 stransid 0 rtransid 0
> ctime 0.0 (1970-01-01 00:00:00)
> otime 0.0 (1970-01-01 00:00:00)
> stime 0.0 (1970-01-01 00:00:00)
> rtime 0.0 (1970-01-01 00:00:00)
> item 2 key (FS_TREE INODE_REF 6) itemoff 15388 itemsize 17
> index 0 namelen 7 name: default
> item 3 key (FS_TREE ROOT_ITEM 0) itemoff 14949 itemsize 439
> generation 1589644 root_dirid 256 bytenr 13924670046208 byte_limit 0
> bytes_used 5382389760
> last_snapshot 0 flags 0x0(none) refs 1
> drop_progress key (0 UNKNOWN.0 0) drop_level 0
> level 3 generation_v2 1589644
> uuid ed6fc36e-c846-4fa7-8985-0ad8d02b3d81
> parent_uuid 00000000-0000-0000-0000-000000000000
> received_uuid 00000000-0000-0000-0000-000000000000
> ctransid 1589644 otransid 0 stransid 0 rtransid 0
> ctime 1758883901.662733695 (2025-09-26 10:51:41)
> otime 1687097304.0 (2023-06-18 14:08:24)
> stime 0.0 (1970-01-01 00:00:00)
> rtime 0.0 (1970-01-01 00:00:00)
> item 4 key (ROOT_TREE_DIR INODE_ITEM 0) itemoff 14789 itemsize 160
> generation 3 transid 0 size 0 nbytes 16384
> block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
> sequence 0 flags 0x0(none)
> atime 1687097304.0 (2023-06-18 14:08:24)
> ctime 1687097304.0 (2023-06-18 14:08:24)
> mtime 1687097304.0 (2023-06-18 14:08:24)
> otime 1687097304.0 (2023-06-18 14:08:24)
> item 5 key (ROOT_TREE_DIR INODE_REF 6) itemoff 14777 itemsize 12
> index 0 namelen 2 name: ..
> item 6 key (ROOT_TREE_DIR DIR_ITEM 2378154706) itemoff 14740 itemsize 37
> location key (FS_TREE ROOT_ITEM 18446744073709551615) type DIR
> transid 0 data_len 0 name_len 7
> name: default
> item 7 key (CSUM_TREE ROOT_ITEM 0) itemoff 14301 itemsize 439
> generation 1589644 root_dirid 0 bytenr 13924661035008 byte_limit 0
> bytes_used 18805227520
> last_snapshot 0 flags 0x0(none) refs 1
> drop_progress key (0 UNKNOWN.0 0) drop_level 0
> level 3 generation_v2 1589644
> uuid 00000000-0000-0000-0000-000000000000
> parent_uuid 00000000-0000-0000-0000-000000000000
> received_uuid 00000000-0000-0000-0000-000000000000
> ctransid 0 otransid 0 stransid 0 rtransid 0
> ctime 0.0 (1970-01-01 00:00:00)
> otime 0.0 (1970-01-01 00:00:00)
> stime 0.0 (1970-01-01 00:00:00)
> rtime 0.0 (1970-01-01 00:00:00)
> item 8 key (UUID_TREE ROOT_ITEM 0) itemoff 13862 itemsize 439
> generation 5 root_dirid 0 bytenr 30539776 byte_limit 0 bytes_used 16384
> last_snapshot 0 flags 0x0(none) refs 1
> drop_progress key (0 UNKNOWN.0 0) drop_level 0
> level 0 generation_v2 5
> uuid 00000000-0000-0000-0000-000000000000
> parent_uuid 00000000-0000-0000-0000-000000000000
> received_uuid 00000000-0000-0000-0000-000000000000
> ctransid 0 otransid 0 stransid 0 rtransid 0
> ctime 0.0 (1970-01-01 00:00:00)
> otime 0.0 (1970-01-01 00:00:00)
> stime 0.0 (1970-01-01 00:00:00)
> rtime 0.0 (1970-01-01 00:00:00)
> item 9 key (FREE_SPACE_TREE ROOT_ITEM 0) itemoff 13423 itemsize 439
> generation 1589644 root_dirid 0 bytenr 13924660756480 byte_limit 0
> bytes_used 14368768
> last_snapshot 0 flags 0x0(none) refs 1
> drop_progress key (0 UNKNOWN.0 0) drop_level 0
> level 2 generation_v2 1589644
> uuid 00000000-0000-0000-0000-000000000000
> parent_uuid 00000000-0000-0000-0000-000000000000
> received_uuid 00000000-0000-0000-0000-000000000000
> ctransid 0 otransid 0 stransid 0 rtransid 0
> ctime 0.0 (1970-01-01 00:00:00)
> otime 0.0 (1970-01-01 00:00:00)
> stime 0.0 (1970-01-01 00:00:00)
> rtime 0.0 (1970-01-01 00:00:00)
> item 10 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 12984 itemsize 439
> generation 5 root_dirid 256 bytenr 30523392 byte_limit 0 bytes_used 1638=
4
> last_snapshot 0 flags 0x0(none) refs 1
> drop_progress key (0 UNKNOWN.0 0) drop_level 0
> level 0 generation_v2 5
> uuid 00000000-0000-0000-0000-000000000000
> parent_uuid 00000000-0000-0000-0000-000000000000
> received_uuid 00000000-0000-0000-0000-000000000000
> ctransid 0 otransid 0 stransid 0 rtransid 0
> ctime 0.0 (1970-01-01 00:00:00)
> otime 0.0 (1970-01-01 00:00:00)
> stime 0.0 (1970-01-01 00:00:00)
> rtime 0.0 (1970-01-01 00:00:00)
> Couldn't read tree root
> open with broken chunk error
>=20
> This looks misleading and confusing because:
> - The FS is clean and mountable.
> - User expectation: if the FS is healthy, `chunk-recover` should
> either do nothing
>    and exit cleanly, or print "nothing to do", not fail with scary
> corruption messages.
>=20
> Questions:
> - Is this a known limitation of `chunk-recover`?
> - Should the tool detect the healthy state and skip gracefully instead
> of failing?
>=20


