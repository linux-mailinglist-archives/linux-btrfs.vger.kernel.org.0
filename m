Return-Path: <linux-btrfs+bounces-1074-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F34F819966
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 08:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A961C21E1C
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 07:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5E5156E0;
	Wed, 20 Dec 2023 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRtZjG/k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E5A18647
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Dec 2023 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cc694f9776so9982701fa.1
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Dec 2023 23:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057089; x=1703661889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cppmZ7+B+1vATktZl46nqEgqaHsTR6vB+xThXUyewjI=;
        b=fRtZjG/kG+vDe9XEPKTthx6dxWPcpkLUHLtA80B3TrDPYOAPCc7mUbKIbHFPGnJAlS
         5RQHfqHvyeYwwVSbJ6Co/FoYNjJ9sWd1hbdLZymwaUaifTousi5gT1uJkjIze4wfpQor
         h92h+OFUk5z5dazYPxyFOb1iplgffN7qktKlXw/8p1pNfQH6JkE4Tki1nay9F9p0si3Z
         eWbVkJJRcgoIGabLqO8RSaHq/UR2Tl9BH/wRWAGej88833pmHt7i9Ki7b22T+DBkbzDE
         xO20370/TCHN3mGB1IJWXndc2RTKB1y+zQWHB+M6nQUV0viA/CvL6VumYcTGa9cSlGCY
         AKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057089; x=1703661889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cppmZ7+B+1vATktZl46nqEgqaHsTR6vB+xThXUyewjI=;
        b=dI1H3fglJ80e/bjREZ2TcqVcjayr1eDhV4rM8DPCk6Jpb+ElXsMjGQNM500CcyBxOn
         M9v19MBtEbNRQZRfCr2OQ5AOZT5oNUMI1RdK/bmUHenfzrDKFpTqjXYabFhwY2zyOzEp
         58z0eGMDZuarFo8t+RhQo3FBXYYejpatj5E2fzZ/wGqDqUsVXeJgeTh+y8lkHjYzHSAo
         hmZ0Yhpiwg/mBoZXX/NvlVehpCw2UdJoMfvCIAtLtCgELVEuXTmQ4rooQ7KvpayjCdBI
         FZ1G168hYK9t4ALb4vuUkDW/FMtEQTMUejsyWRGOrLZVRtZbI8985mpI7/ipH+I+JE32
         UtWw==
X-Gm-Message-State: AOJu0YyIR51AAkL2NTGaVJCfG/A1wjypT6hPKBxOcOh6sEoPKj1D/WFx
	5EyQubXYqA/VhqmX1R1l4UfXEpd7W86R4LLyRELFAihsnWc=
X-Google-Smtp-Source: AGHT+IHOHY/TF+k0Epeo229MqOKukYuyWRBdHxZrOQSs1zka6YnLPbLEKOtvOOWcTYwTI6PaamtkWGKG5ENIdSAaQoo=
X-Received: by 2002:a05:651c:1050:b0:2cc:9276:b84b with SMTP id
 x16-20020a05651c105000b002cc9276b84bmr323439ljm.4.1703057088554; Tue, 19 Dec
 2023 23:24:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000b01da326e$b054cdb0$10fe6910$@cdac.in> <0f6ab509-2403-4ab6-af3f-d5beb559b450@gmx.com>
In-Reply-To: <0f6ab509-2403-4ab6-af3f-d5beb559b450@gmx.com>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Wed, 20 Dec 2023 10:24:37 +0300
Message-ID: <CAA91j0XoJ9JTqvFpeSJ+SKbhHc=QrX49SNJ0yJo+j8TjzGTsRw@mail.gmail.com>
Subject: Re: Logical to Physical Address Mapping/Translation in Btrfs
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: saranyag@cdac.in, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 1:20=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> On 2023/12/19 21:59, saranyag@cdac.in wrote:
> > Hi,
> >
> > May I know how the logical address is translated to the physical addres=
s in
> > Btrfs?
>
> This is documented in btrfs-dev-docs/chunks.txt:
>
> https://github.com/btrfs/btrfs-dev-docs/blob/master/chunks.txt
>

I tried to read it three times and I still do not understand it.

It starts with showing two chunks - metadata and data

--><--
item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 4593811456) itemoff 15863 itemsize =
112
length 268435456 owner 2 stripe_len 65536 type METADATA|RAID1
io_align 65536 io_width 65536 sector_size 4096
num_stripes 2 sub_stripes 1
stripe 0 devid 2 offset 2425356288
dev_uuid a7963b67-1277-49ff-bb1d-9d81c5605f1b
stripe 1 devid 1 offset 2446327808
dev_uuid 5f8b54f0-2a35-4330-a06b-9c8fd935bc36

item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 2446327808) itemoff 15975 itemsize =
112
length 2147483648 owner 2 stripe_len 65536 type DATA|RAID0
io_align 65536 io_width 65536 sector_size 4096
num_stripes 2 sub_stripes 1
stripe 0 devid 2 offset 1351614464
dev_uuid a7963b67-1277-49ff-bb1d-9d81c5605f1b
stripe 1 devid 1 offset 1372585984
dev_uuid 5f8b54f0-2a35-4330-a06b-9c8fd935bc36
--><--

Then it apparently talks about writing into metadata chunk, judging by
the logical address

--><--
Consider we want to write 2m at at 4596957184 - that's 3m past the start of
the data chunk in the previous example. In order to see where in the physic=
al
stripe this write will go into we need to derive the following values:

block group offset =3D [address within block group] -  [start address of
block group]
block_group_offset =3D 4596957184 - 4593811456 =3D 3145728 =3D> 3m
--><--

The chunk start 4593811456 is metadata. But when talking about
physical location it suddenly takes address of the device extent of
the data chunk

--><--
physical_address =3D [physical stripe start] + [logical_stripe] *
[logical stripe_size]
physical_address =3D 1351614464 + 48 * 64k =3D 1351614464 + 3145728 =3D 135=
4760192
--><--

1351614464 is the address of the stripe 0 of the data chunk. It is
completely unclear whether it is intentional or not.

Nor does it explain how the device extent (physical stripe) is
selected and how it jumps from the block_group_offset to the
(physical) stripe number.

Intermixing "chunk" and "block group" does not help in understanding it eit=
her.

And I suspect RAID5/6 is something entirely different ...

