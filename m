Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7491734CB1D
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 10:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhC2InU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Mar 2021 04:43:20 -0400
Received: from mout.web.de ([217.72.192.78]:36975 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235414AbhC2Imu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 04:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1617007367;
        bh=YqgtbxL6q9LePe4NPutf/P4WHwRYd/UOkFuV0Fclcas=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=N+qnTDTEl09rsUJEt1eUVrBbwvMEddeUf3zMFiz/I3fk3KU1LuLHqn2S0qoUtPumY
         p19uHK99dEIulQb4NgIwU5tEpRvLMwXUO2uNn+dBXuNlvyVQV2V4VU26OzRyqVQWUs
         5i1+MWpkMUEDTiun7BUHaPkTAg735p5UxGwkJqxs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [62.216.205.228] ([62.216.205.228]) by web-mail.web.de
 (3c-app-webde-bap09.server.lan [172.19.172.9]) (via HTTP); Mon, 29 Mar 2021
 10:42:47 +0200
MIME-Version: 1.0
Message-ID: <trinity-a06881cd-b3d5-4055-b151-f8ad46e425e1-1617007367803@3c-app-webde-bap09>
From:   B A <chris.std@web.de>
To:     Chris Murphy <lists@colorremedies.com>,
        btrfs kernel mailing list <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Aw: Re: Re: Help needed with filesystem errors: parent transid
 verify failed
Content-Type: multipart/mixed;
 boundary=rehcsed-67aeeedb-f411-41fb-9c4b-42350dd75faf
Date:   Mon, 29 Mar 2021 10:42:47 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAJCQCtSp1cmA6iVmRfRXrxzo7pUA8eSUGwzuifbZkS=p0deO0Q@mail.gmail.com>
References: <trinity-ed62f670-6e98-4395-85c0-2a7ea4415ee4-1616946036541@3c-app-webde-bs48>
 <CAJCQCtQZOywtL+sz1XBC54ew=JJaLsx=UkgmeZi3q-ob39vgjw@mail.gmail.com>
 <trinity-10b6732b-bd13-45e0-b795-66e3c9a869c4-1617003257785@3c-app-webde-bap09>
 <CAJCQCtSp1cmA6iVmRfRXrxzo7pUA8eSUGwzuifbZkS=p0deO0Q@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:g6Glk6gl8pJ83YxpNxiRlrNFdGtMiRglGK7Lcj3Lr9wR05DEaM1cBInIZ5HxEUMAoM0+j
 0TRdU9d80i86bf51G3wxoWJfY9o3hEL/PbqFZRvXfyOsJZaVwrw5xI+CMtnrleKtvnvSo2jp7iti
 6vxowln0AEA78inTf3a4nGQIinWRLPxAd4F2o7lTrmFF2iMsIH2jZnhUMqFY/tiKYS6whqMk42N3
 dHQQ0UzPPbubW+p27pFWgwAzLMs/VJFZxabz/r8c0IBXXCa+9R0ctBYi7622vw1waQ5Ih30cRCR/
 8M=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PMfuHsekpE0=:NAnM8dK+eqfVB5U7VpnuUC
 FkkNdGdhdrpgr6ZkgBVbioLxW8CtNIHClSeZ40tZOVl0qaheVyDfqSaBAznR4EBCuC+9QxPVv
 Dy/eLj8lbB7I4T2I1Y2snA9NLbXF6mKo3BFCj32LTKy6Z9RqKnrQ59L73zq4ImJGwD8P5W/db
 mgzrBSi37wGXr9ZNrbAzJNLNhDU5tWt1guJv/o7nLZBWqpsYVZb37qTY51pg07v8GNG8501ti
 r1YpEeP9Bmh7mx815YGvtX0WQWEeCk4CE8KEKycll4DR26jV67/M++76yHKkpmSjhGLtm2f2H
 NCwkmlTOt3Chun2cwLP6hkT1A/Gp9DFk8t5N34qi5aKnFLjesp2mTjD9BehiiTl3JVHjClKIj
 Ck85/IEbhbV7NY9rrRdu7bZkjiox4e2qnS9vg8A4CIGvlB0Oi0A/f1d4XhpOXfBqm2mYvcT63
 BU7BOaAGUJ1LtRjgyT/kd3imHSGqxUfTn6BilHmU/g5aBTnwSuK44L8YYroR5h0A9IGzZ5Nxh
 1aZZ+RZWRT+PJzknnfGTRZ19lStrWcI/Xrqo4xrUI0vwacXobtwZch6wLV3Ki/wpdJWNjQh8T
 qC61CC1c8kN59YilxPHMU8DofTfdhniUnuxGHvqMnUOiIXjokrQXZDJ2GF+KeO8VxZvgoU3TD
 zOhqqviCWiD50k95wbtpKieG9kgjdsBR/KzymHOqobRLt9Tb0xmwIkSjJD4jdr7gZo8ESSjRZ
 Kz5Djee+GgsySWAy+JJeBsAZ3YwVvLm6kqGAZuUY1LKzrdpiE1Tc4L7qE3scuVPoZ3zghNq85
 IRnkn8nmiTKES1069MDkuEA5PkydiGsWyVMd4NsY7wDR/zmb7fVNS666Hjp+kzpElxvVftgHR
 S1Qc/19H2gAyzEg5ZYiIrYAWk36/zQoCqTIjVHF/herE4s4sYj1+drlZ84NsaO
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--rehcsed-67aeeedb-f411-41fb-9c4b-42350dd75faf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> Gesendet: Montag, 29=2E M=C3=A4rz 2021 um 08:09 Uhr
> Von: "Chris Murphy" <lists@colorremedies=2Ecom>
> An: "B A" <chris=2Estd@web=2Ede>, "Btrfs BTRFS" <linux-btrfs@vger=2Ekern=
el=2Eorg>
> Cc: "Qu Wenruo" <quwenruo=2Ebtrfs@gmx=2Ecom>, "Josef Bacik" <josef@toxic=
panda=2Ecom>
> Betreff: Re: Re: Help needed with filesystem errors: parent transid veri=
fy failed
> [=E2=80=A6]
>=20
> What do you get for:
>=20
> btrfs insp dump-s -f /dev/dm-0

See attached file "btrfs_insp_dump-s_-f=2Etxt"

> Hopefully Qu or Josef will have an idea=2E
>=20
> --
> Chris Murphy

Thanks again!

Kind regards,
Chris
--rehcsed-67aeeedb-f411-41fb-9c4b-42350dd75faf
Content-Type: text/plain
Content-Disposition: attachment; filename=btrfs_insp_dump-s_-f.txt

superblock: bytenr=65536, device=/dev/mapper/luks-ff6e174f-4cd3-42a7-8ee5-47005dd077dc
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0x0fcf13cc [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			1a149bda-057d-4775-ba66-1bf259fce9a5
metadata_uuid		1a149bda-057d-4775-ba66-1bf259fce9a5
label			fedora_chstpc-2
generation		2734487
root			1144777555968
sys_array_size		129
chunk_root_generation	2708287
root_level		1
chunk_root		1144718917632
chunk_root_level	1
log_root		0
log_root_transid	0
log_root_level		0
total_bytes		322120450048
bytes_used		247510102016
sectorsize		4096
nodesize		16384
leafsize (deprecated)	16384
stripesize		4096
root_dir		6
num_devices		1
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x169
			( MIXED_BACKREF |
			  COMPRESS_LZO |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA )
cache_generation	2734487
uuid_tree_generation	2734487
dev_item.uuid		f7c9ee7f-0de1-49bb-a838-fdc9b4111331
dev_item.fsid		1a149bda-057d-4775-ba66-1bf259fce9a5 [match]
dev_item.type		0
dev_item.total_bytes	322120450048
dev_item.bytes_used	288903659520
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0
sys_chunk_array[2048]:
	item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 1144718884864)
		length 33554432 owner 2 stripe_len 65536 type SYSTEM|DUP
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 1
			stripe 0 devid 1 offset 1074790400
			dev_uuid f7c9ee7f-0de1-49bb-a838-fdc9b4111331
			stripe 1 devid 1 offset 1108344832
			dev_uuid f7c9ee7f-0de1-49bb-a838-fdc9b4111331
backup_roots[4]:
	backup 0:
		backup_tree_root:	1144895651840	gen: 2734484	level: 1
		backup_chunk_root:	1144718917632	gen: 2708287	level: 1
		backup_extent_root:	1144891129856	gen: 2734484	level: 2
		backup_fs_root:		1145036898304	gen: 2734355	level: 0
		backup_dev_root:	1144828215296	gen: 2734438	level: 1
		backup_csum_root:	1144889982976	gen: 2734484	level: 2
		backup_total_bytes:	322120450048
		backup_bytes_used:	247427117056
		backup_num_devices:	1

	backup 1:
		backup_tree_root:	1144902451200	gen: 2734485	level: 1
		backup_chunk_root:	1144718917632	gen: 2708287	level: 1
		backup_extent_root:	1144897241088	gen: 2734485	level: 2
		backup_fs_root:		1145036898304	gen: 2734355	level: 0
		backup_dev_root:	1144828215296	gen: 2734438	level: 1
		backup_csum_root:	1144891408384	gen: 2734485	level: 2
		backup_total_bytes:	322120450048
		backup_bytes_used:	247439462400
		backup_num_devices:	1

	backup 2:
		backup_tree_root:	1144915836928	gen: 2734486	level: 1
		backup_chunk_root:	1144718917632	gen: 2708287	level: 1
		backup_extent_root:	1144753078272	gen: 2734486	level: 2
		backup_fs_root:		0	gen: 0	level: 0
		backup_dev_root:	1144771723264	gen: 2734486	level: 1
		backup_csum_root:	1144755093504	gen: 2734486	level: 2
		backup_total_bytes:	322120450048
		backup_bytes_used:	247510102016
		backup_num_devices:	1

	backup 3:
		backup_tree_root:	1144777555968	gen: 2734487	level: 1
		backup_chunk_root:	1144718917632	gen: 2708287	level: 1
		backup_extent_root:	1144777916416	gen: 2734487	level: 2
		backup_fs_root:		0	gen: 0	level: 0
		backup_dev_root:	1144771723264	gen: 2734486	level: 1
		backup_csum_root:	1144809537536	gen: 2734487	level: 2
		backup_total_bytes:	322120450048
		backup_bytes_used:	247510102016
		backup_num_devices:	1



--rehcsed-67aeeedb-f411-41fb-9c4b-42350dd75faf--

