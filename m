Return-Path: <linux-btrfs+bounces-5093-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D538C934E
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 May 2024 04:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C191F212AB
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 May 2024 02:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C359450;
	Sun, 19 May 2024 02:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd+73z4z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CF52114
	for <linux-btrfs@vger.kernel.org>; Sun, 19 May 2024 02:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716085029; cv=none; b=hj8sId9DU60NtFtUxgmSCr2dB5IsmqxgnRjWujgTGQpS5sj30oIStFTl2NXm/4lCafBAOaj1O5c49vaSyCT6wlwe2jiHG7FE3bTcgSbnZwuxiK+IlvSw94x43U40pDUa/hVJuQjyUTM7XjKdP7aBvJu6rtFwWpv7dULvWf6Qoxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716085029; c=relaxed/simple;
	bh=YiT9+W7zoFjQ2/Ty/al8tbTg1uR4OF1tcOOhU/4aWUw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cv7xiaEFCmkOYXglcOwIyMTY2hdg4rsZ1F7GY+2y50+zYBajmWDbTOXrgMo6PahqAy1Szlzv32Ysbud0bm3r91uEJQSSCdQSXMK/MnNGCTOsU6JzQKe6o41/2gY0jK1pHvkW1PatUwmkhXjAol7oPgh8cjLYnxeus7QU/vC+Hf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dd+73z4z; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-792c7704e09so160768485a.1
        for <linux-btrfs@vger.kernel.org>; Sat, 18 May 2024 19:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716085026; x=1716689826; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YiT9+W7zoFjQ2/Ty/al8tbTg1uR4OF1tcOOhU/4aWUw=;
        b=dd+73z4zBsoLDARVHnXRsUKiQWjKmsRIeYwoIBERkmiQBUdkFjhUndWACoAHUUd1Qq
         RjV5GHeGEjBrffu4l6wLVGbP/sKTmFziTY9t1pVd2CCo213l7WhMLndgQUEBz+WZn2w4
         +cwYLKQk5ZLolhT8nKacNdRv1zy82aY99nBwsOheYNRjQc70uloDWHSVsNWUa+NJp47f
         OgqEqN0A2IA5qEUmIzAgW5Tp7Xv0GGNvg/9FzWvFCaO6azCkxjxJbHhBfGlnLLeElL7b
         IRD6Detq0+XJ+CNUw0+EJ0RB6qJudYaQwRkLMHcNb80j9ofNCbFf63VGvwB29W1sTEcH
         SVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716085026; x=1716689826;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YiT9+W7zoFjQ2/Ty/al8tbTg1uR4OF1tcOOhU/4aWUw=;
        b=xACciZ/9c4CyUsoXdKXDisf5Y0TPjRh2n5UzH8DcPnjag1LGd2Dgi2m0vfUbRdaVRJ
         f7E7i++R5Bbghzqeua7CX1LkL75gMyL160a2PX4h56hvJOsW/sQz5nYNT9QaZH+qW0L9
         yuV6Igi1yIq/m8Ra0laXnb/VhYUmZh22NfU1n7bmik7vpr/I8PNm36vbESwJWrjwI93j
         xnumtBP1l6AHToK7sYzCqJtfYd4Rak1hhn1mMOYGeSbJZePkG/NPvkKr2nlkg41yco3A
         2byCwRW8a7IoIYxou0se5Nl0Co+cXbLhpOvkb2wTdY7GLa4LhrVLEfAGueaYcqVngqg0
         U1sQ==
X-Gm-Message-State: AOJu0YzSV3bdDbK2XNJZoo0ovuTdlb1xpQeqdLU0kI8tfngyqD/5/c6i
	Wuy+VcG8NHFbJmwIam6yB6Zkdcu6wZlbcLRsF876utfy4HWsK4Z1z9G8y47M
X-Google-Smtp-Source: AGHT+IFE2LNfJr1SlEJc4qP+E17kKl4WDvkm34hbNpmqS7QgYYpchUV1gcoUHGiyKof0prOQZIIRGw==
X-Received: by 2002:a05:620a:2708:b0:792:8df3:8be6 with SMTP id af79cd13be357-79470f2febdmr544010685a.33.1716085026071;
        Sat, 18 May 2024 19:17:06 -0700 (PDT)
Received: from ?IPv6:2600:4041:5b0d:f100:fec2:7085:7ce5:711c? ([2600:4041:5b0d:f100:fec2:7085:7ce5:711c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7930f124416sm243684585a.119.2024.05.18.19.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 19:17:05 -0700 (PDT)
Message-ID: <053ca275b81228acf1259047d6d8bac67efc256f.camel@gmail.com>
Subject: Re: system drive corruption, btrfs check failure
From: Jared Van Bortel <jared.e.vb@gmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date: Sat, 18 May 2024 22:17:05 -0400
In-Reply-To: <32ca8678-d0fd-44e4-b0a0-9b25383dc866@gmx.com>
References: 
	<CALsQ4_x-5+W_7NQR68nTiCM9aptigGf6+HD=jLftrxgXTOLyRA@mail.gmail.com>
	 <32ca8678-d0fd-44e4-b0a0-9b25383dc866@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-03-30 at 10:12 +1030, Qu Wenruo wrote:
>=20
>=20
> =E5=9C=A8 2024/3/30 04:00, Jared Van Bortel =E5=86=99=E9=81=93:
> > Hi,
> >=20
> > Yesterday I ran `pacman -Syu` to update my Arch Linux installation.
> > I
> > saw a lot of complaints from ldconfig, and programs started
> > crashing.
> > Thinking it was related to having only 7GiB of free space available,
> > I
> > tried deleting some large files and reinstalling the affected
> > packages. I saw no clear improvement from this, and eventually
> > decided
> > to shut my computer down.
>=20
> Do you have any dmesg of that incident?

Hi, sorry for the delay. I finally got around to running the lowmem
check on the old drives.

Firstly, there was nothing relevant in dmesg. When I first saw your
reply, I checked the system journal from the time of the incident and
there was nothing disk-related from the kernel between mount and
shutdown - medium errors, btrfs I/O errors, or anything like that.

>=20
> >=20
> > I booted memtest, and it completed a full pass without errors. I
> > then
> > booted a live USB and ran `btrfs check --readonly /dev/nvme0n1p2`,
> > and
> > saw a long list of errors, realizing my filesystem is most likely
> > beyond repair.
> >=20
> > Basic information (RAID1 metadata, single data):
> > ```
> > Label: 'System'=C2=A0 uuid: 76721faa-8c32-4e70-8a9e-859dece0aec1
> > Total devices 2 FS bytes used 2.18TiB
> > devid=C2=A0=C2=A0=C2=A0 1 size 422.63GiB used 422.63GiB path /dev/nvme0=
n1p2
> > devid=C2=A0=C2=A0=C2=A0 2 size 1.82TiB used 1.82TiB path /dev/nvme1n1
> > ```
> > The installed kernel is linux-zen 6.6.10 with a few patches. The
> > live
> > USB I'm using has the Arch Linux 6.4.7-arch1-1 kernel. Full `btrfs
> > check` log and smartctl information is attached.
> >=20
> > There are three main errors. One:
> > ```
> > ref mismatch on [1248293634048 16384] extent item 1, found 0
> > tree extent[1248293634048, 16384] parent 2368656916480 has no tree
> > block found
> > incorrect global backref count on 1248293634048 found 1 wanted 0
> > backpointer mismatch on [1248293634048 16384]
> > owner ref check failed [1248293634048 16384]
> > ```
> >=20
> > Two:
> > ```
> > ref mismatch on [1261902016512 4096] extent item 2, found 1
> > data extent[1261902016512, 4096] bytenr mimsmatch, extent item
> > bytenr
> > 1261902016512 file item bytenr 0
> > data extent[1261902016512, 4096] referencer count mismatch (parent
> > 2369673248768) wanted 1 have 0
> > backpointer mismatch on [1261902016512 4096]
> > ```
>=20
> Corrupted extent tree, this can lead to fs falling back to read-only
> halfway.

This fs actually still mounts writable without any issue, FWIW. Although
the error counters are not zeroed:

bdev /dev/nvme0n1p2 errs: wr 51, rd 0, flush 0, corrupt 0, gen 5

It's not clear to me when these errors occurred - wouldn't they have
been logged to dmesg at the time?

> >=20
> > Three:
> > ```
> > block group 1342751899648 has wrong amount of free space, free space
> > cache has 34193408 block group has 42893312
> > failed to load free space cache for block group 1342751899648
> > ```
>=20
> This is not that uncommon if extent=C2=A0 tree is already corrupted.
>=20
> But unfortunately, this may not be the direct/root cause of the
> corruption.
>=20
> Thus I'd prefer to have the initial dmesg.
>=20
> >=20
> > And this warning:
> > ```
> > [4/7] checking fs roots
> > warning line 3916
> > ```
> >=20
> > I bought some replacement disks that I can install alongside the old
> > ones, but I don't have a recent backup of the full FS. It seems to
> > mount readonly without issue.
>=20
> The fs tree is mostly fine, so you can mount it RO and grab your data.
>=20
> >=20
> > What's the best way to recover the data that's left? And is there
> > any
> > clue here as to what went wrong? I'm really not sure. If this is a
> > drive failure, it seems premature.
>=20
> It's hard to say. The old original mode check output is not that
> helpful
> to locate the root cause.
>=20
> Mind to run "btrfs check --mode=3Dlowmem" on that fs, and save both
> stderr
> and stdout?

Here is the output:

$ sudo btrfs check --mode=3Dlowmem /dev/nvme0n1p2
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p2
UUID: 76721faa-8c32-4e70-8a9e-859dece0aec1
[1/7] checking root items
[2/7] checking extents
ERROR: shared extent[1248293634048 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1248304054272 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1248304807936 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1248315129856 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1248324468736 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1248588103680 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1248685195264 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1248901791744 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1248939687936 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1248953860096 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1248962543616 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1248966279168 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1248966934528 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1248978468864 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1249032519680 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1249075806208 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1249310851072 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1249319256064 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1249401454592 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1249661976576 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1249796259840 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1249802420224 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1250339143680 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1250870542336 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1250975170560 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1251038543872 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1251216883712 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1251319889920 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1251321462784 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1251324887040 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1251325100032 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1253394546688 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1254622068736 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1255368310784 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1255986282496 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1255986331648 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1256068186112 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1256145797120 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1256190967808 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1256305262592 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1256650244096 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1256696086528 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1258225631232 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1258967351296 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1258967367680 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1258967400448 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1258967482368 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1258967515136 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1258967531520 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1258967564288 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1259028234240 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1259345543168 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1259767791616 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260607963136 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260611665920 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260611862528 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260617236480 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260620627968 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260707020800 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260716212224 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260718686208 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260725223424 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260836290560 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260837158912 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260838322176 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260840239104 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260841402368 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260841910272 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260842811392 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260843696128 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260848300032 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260850085888 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260851412992 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260852494336 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260854067200 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260856000512 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260856590336 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260857556992 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260859555840 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260861636608 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260861898752 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260863062016 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[1260863815680 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent 1284548759552 referencer lost (parent: 1252056268800)
ERROR: shared extent 1287628115968 referencer lost (parent: 1252056268800)
ERROR: shared extent 1287628156928 referencer lost (parent: 1252056268800)
ERROR: shared extent 1291874332672 referencer lost (parent: 1252056268800)
ERROR: shared extent 1291892744192 referencer lost (parent: 1252056268800)
ERROR: shared extent 1291893682176 referencer lost (parent: 1252056268800)
ERROR: shared extent 1302641364992 referencer lost (parent: 1252056268800)
ERROR: shared extent 1302646538240 referencer lost (parent: 1252056268800)
ERROR: shared extent 1302646906880 referencer lost (parent: 1252056268800)
ERROR: shared extent 1302725738496 referencer lost (parent: 1252056268800)
ERROR: shared extent 1307336536064 referencer lost (parent: 1252056268800)
ERROR: shared extent 1307421573120 referencer lost (parent: 1252056268800)
ERROR: shared extent 1318061346816 referencer lost (parent: 1252056268800)
ERROR: shared extent 1321886617600 referencer lost (parent: 1252056268800)
ERROR: shared extent 1548210819072 referencer lost (parent: 1252056268800)
ERROR: shared extent 1564826959872 referencer lost (parent: 1252056268800)
ERROR: shared extent 1609847508992 referencer lost (parent: 1252056268800)
ERROR: shared extent 1609915379712 referencer lost (parent: 1252056268800)
ERROR: shared extent 1611724808192 referencer lost (parent: 1252056268800)
ERROR: shared extent 1611749105664 referencer lost (parent: 1252056268800)
ERROR: shared extent 1611749363712 referencer lost (parent: 1252056268800)
ERROR: shared extent 1620880302080 referencer lost (parent: 1252056268800)
ERROR: shared extent 1620899688448 referencer lost (parent: 1252056268800)
ERROR: shared extent 1620944224256 referencer lost (parent: 1252056268800)
ERROR: shared extent 1623958888448 referencer lost (parent: 1252056268800)
ERROR: shared extent 1624013213696 referencer lost (parent: 1252056268800)
ERROR: shared extent 1624013307904 referencer lost (parent: 1252056268800)
ERROR: shared extent[2368230686720 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2368279707648 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2368409845760 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2368417906688 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2368656982016 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369673248768 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369795997696 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369801355264 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369801568256 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369801666560 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369807466496 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369807548416 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369808187392 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369808678912 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369808990208 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369809530880 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369809661952 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369809743872 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369811316736 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369811365888 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369811562496 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369811906560 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369811972096 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369812234240 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369812365312 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369813331968 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369813610496 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369814020096 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369816100864 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369816231936 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369816788992 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369817116672 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369817182208 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369817247744 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369817296896 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369817395200 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369817509888 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369817542656 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369817853952 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369818001408 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369818116096 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369818148864 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369818263552 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369818492928 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369818640384 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369818869760 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369819623424 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369819869184 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369821540352 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369821622272 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369821949952 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369822572544 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369823145984 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369823195136 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369823621120 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369824112640 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2369863860224 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2370334277632 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[2370373042176 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[4949035106304 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[4949037793280 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[4949039235072 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[4949053538304 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[4949401337856 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[4949457502208 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[4949804662784 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[4949804761088 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[4949804777472 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[4949804793856 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: shared extent[4949849210880 16384] lost its parent (parent: 23686569=
16480, level: 0)
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
block group 1342751899648 has wrong amount of free space, free space cache =
has 34193408 block group has 42893312
failed to load free space cache for block group 1342751899648
block group 1343825641472 has wrong amount of free space, free space cache =
has 23257088 block group has 25903104
failed to load free space cache for block group 1343825641472
block group 1351341834240 has wrong amount of free space, free space cache =
has 22396928 block group has 42348544
failed to load free space cache for block group 1351341834240
block group 1566090199040 has wrong amount of free space, free space cache =
has 48562176 block group has 50651136
failed to load free space cache for block group 1566090199040
block group 1572532649984 has wrong amount of free space, free space cache =
has 12173312 block group has 15945728
failed to load free space cache for block group 1572532649984
block group 1580048842752 has wrong amount of free space, free space cache =
has 29745152 block group has 33087488
failed to load free space cache for block group 1580048842752
block group 1584343810048 has wrong amount of free space, free space cache =
has 56512512 block group has 58601472
failed to load free space cache for block group 1584343810048
block group 1602597421056 has wrong amount of free space, free space cache =
has 87953408 block group has 90349568
failed to load free space cache for block group 1602597421056
block group 1744331341824 has wrong amount of free space, free space cache =
has 339968 block group has 393216
failed to load free space cache for block group 1744331341824
block group 2666675568640 has wrong amount of free space, free space cache =
has 602112 block group has 782336
failed to load free space cache for block group 2666675568640
block group 2909341220864 has wrong amount of free space, free space cache =
has 65536 block group has 151552
failed to load free space cache for block group 2909341220864
block group 3904699891712 has wrong amount of free space, free space cache =
has 172032 block group has 221184
failed to load free space cache for block group 3904699891712
block group 3941207113728 has wrong amount of free space, free space cache =
has 1728512 block group has 1826816
failed to load free space cache for block group 3941207113728
block group 4085088518144 has wrong amount of free space, free space cache =
has 5697536 block group has 5754880
failed to load free space cache for block group 4085088518144
block group 4241854824448 has wrong amount of free space, free space cache =
has 23293952 block group has 28966912
failed to load free space cache for block group 4241854824448
block group 4838855278592 has wrong amount of free space, free space cache =
has 86016 block group has 118784
failed to load free space cache for block group 4838855278592
block group 4847445213184 has wrong amount of free space, free space cache =
has 49152 block group has 110592
failed to load free space cache for block group 4847445213184
block group 4897911078912 has wrong amount of free space, free space cache =
has 7475200 block group has 7577600
failed to load free space cache for block group 4897911078912
block group 5010008178688 has wrong amount of free space, free space cache =
has 69632 block group has 106496
failed to load free space cache for block group 5010008178688
block group 5062655082496 has wrong amount of free space, free space cache =
has 5836800 block group has 5890048
failed to load free space cache for block group 5062655082496
block group 5268813512704 has wrong amount of free space, free space cache =
has 135168 block group has 221184
failed to load free space cache for block group 5268813512704
[4/7] checking fs roots
ERROR: root 259 EXTENT_DATA[1522634 4096] gap exists, expected: EXTENT_DATA=
[1522634 128]
ERROR: root 259 EXTENT_DATA[1522636 4096] gap exists, expected: EXTENT_DATA=
[1522636 128]
ERROR: root 407 EXTENT_DATA[398831 4096] gap exists, expected: EXTENT_DATA[=
398831 25]
ERROR: root 407 EXTENT_DATA[398973 4096] gap exists, expected: EXTENT_DATA[=
398973 25]
ERROR: root 407 EXTENT_DATA[398975 4096] gap exists, expected: EXTENT_DATA[=
398975 25]
ERROR: root 407 EXTENT_DATA[398976 4096] gap exists, expected: EXTENT_DATA[=
398976 25]
ERROR: root 407 EXTENT_DATA[418307 4096] gap exists, expected: EXTENT_DATA[=
418307 25]
ERROR: root 407 EXTENT_DATA[418316 4096] gap exists, expected: EXTENT_DATA[=
418316 25]
ERROR: root 407 EXTENT_DATA[418317 4096] gap exists, expected: EXTENT_DATA[=
418317 25]
ERROR: root 407 EXTENT_DATA[420660 4096] gap exists, expected: EXTENT_DATA[=
420660 25]
ERROR: root 407 EXTENT_DATA[420673 4096] gap exists, expected: EXTENT_DATA[=
420673 25]
ERROR: root 407 EXTENT_DATA[439382 4096] gap exists, expected: EXTENT_DATA[=
439382 25]
ERROR: root 407 EXTENT_DATA[439383 4096] gap exists, expected: EXTENT_DATA[=
439383 25]
ERROR: root 407 EXTENT_DATA[451252 4096] gap exists, expected: EXTENT_DATA[=
451252 25]
ERROR: root 407 EXTENT_DATA[451264 4096] gap exists, expected: EXTENT_DATA[=
451264 25]
ERROR: root 407 EXTENT_DATA[451265 4096] gap exists, expected: EXTENT_DATA[=
451265 25]
ERROR: root 407 EXTENT_DATA[452326 4096] gap exists, expected: EXTENT_DATA[=
452326 25]
ERROR: root 407 EXTENT_DATA[452332 4096] gap exists, expected: EXTENT_DATA[=
452332 25]
ERROR: root 407 EXTENT_DATA[452339 4096] gap exists, expected: EXTENT_DATA[=
452339 25]
ERROR: root 407 EXTENT_DATA[4293157 4096] gap exists, expected: EXTENT_DATA=
[4293157 25]
ERROR: root 407 EXTENT_DATA[4293570 4096] gap exists, expected: EXTENT_DATA=
[4293570 25]
ERROR: root 407 EXTENT_DATA[4293571 4096] gap exists, expected: EXTENT_DATA=
[4293571 25]
ERROR: root 407 EXTENT_DATA[4293572 4096] gap exists, expected: EXTENT_DATA=
[4293572 25]
ERROR: root 407 EXTENT_DATA[4302136 4096] gap exists, expected: EXTENT_DATA=
[4302136 25]
ERROR: root 407 EXTENT_DATA[4302148 4096] gap exists, expected: EXTENT_DATA=
[4302148 25]
ERROR: root 407 EXTENT_DATA[4302149 4096] gap exists, expected: EXTENT_DATA=
[4302149 25]
ERROR: root 407 EXTENT_DATA[4302150 4096] gap exists, expected: EXTENT_DATA=
[4302150 25]
ERROR: root 407 EXTENT_DATA[5970391 4096] gap exists, expected: EXTENT_DATA=
[5970391 25]
ERROR: errors found in fs roots
found 2397613547520 bytes used, error(s) found
total csum bytes: 1840478932
total tree bytes: 13337329664
total fs tree bytes: 10208378880
total extent tree bytes: 874070016
btree space waste bytes: 2240708820
file data blocks allocated: 24819271946240
 referenced 2695187488768


Hopefully that means something to you. I'm still curious to know to what
degree I should still trust these drives if I were to wipe the fs and
start over. I suppose I could run a SMART test or something, right?

Thanks,
Jared

>=20
> Thanks,
> Qu
>=20
> >=20
> > Thanks,
> > Jared


