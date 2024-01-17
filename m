Return-Path: <linux-btrfs+bounces-1514-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB640830488
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 12:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52CCEB246E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 11:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E960F1DDFF;
	Wed, 17 Jan 2024 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgxjkdxU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210D01DDEA
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705490951; cv=none; b=g/1Ndim3rdxgDSmBs/rxE/ef7TifT/Hl7Yc3STJIW3Cs75FJsMB7Lgn2h1HPDwhsTAxLUodrA3ZC9xYeX/qGlY9VJiY24WszWrkJ5y4ZXEmLaY2jiwN5gxmA0HeFQLthlZNkALifP/+4pwQTE5pE7TlinS4+5BHijMx9+UxdvXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705490951; c=relaxed/simple;
	bh=TsWZmD3sXVS+AP5XgX7HT6nosAeSGrmNelCjluB0pUA=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=UUyE2DqQ4+dhlfSPeCyPakx2jVf1E5O2dnLm0oK6wNlEb8Stsw1wgfatzlFe3tyn/QlIgvcV9J6PjNtnyRh6uLEON+ic0kNsbtI3a4OmmySQ3i0Pss1vzEA6amaK25wXQaHDrct0yPHa+ulWeznRTdpMROLjj69X7CYdXu/06iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgxjkdxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8156C433C7
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 11:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705490950;
	bh=TsWZmD3sXVS+AP5XgX7HT6nosAeSGrmNelCjluB0pUA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SgxjkdxUG3piK/6ca9o686CcHM2h1kGMQbJafi1ezSUYGov55itWyOHuvlSni1aLY
	 uZS5+Z3q5OGUKuG7ewyIMMRnEusctZ/OU2U3SzwNGR6k1ma4Afd2X/VWtPKN5d42hr
	 5vUR21TfgmMAW7gtOEfYfuktOhWs9SEUkATBzAzb0hZ62DeZJ+qKU/xAIdBhNGEM3W
	 Rt6PwNoK8wxQOuY+uL0x/7t+VmNRY39lcZ9wDd5ENgGfZJENVqq4WlapiOUSn3zGA4
	 JMtKAi/qy2IpUjgiKnKIDTgEdKPgiHGBiaJfCVxqPAb3BYoTZW4vpcWdZ3/KtVby3v
	 ZsffDl6XmLHFA==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-557ad92cabbso10917605a12.0
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 03:29:10 -0800 (PST)
X-Gm-Message-State: AOJu0YxlnzEr9jbHG1vBoCNdzD1ChucePjyDVmQsvCeSp8m0RShtNuDv
	Jt3Q1cpdqzYhUyw6AZjVdtu2G5zC9yPbAuhHke4=
X-Google-Smtp-Source: AGHT+IFZkw8o4Mi/6MNyNNgsH5IHapRVnlr2B3rvUtpwOHcO+u760yjxjhnp/oXt8LhDvNUU+i6R2RhGtyGYC/K9058=
X-Received: by 2002:a17:907:2947:b0:a26:8919:f183 with SMTP id
 et7-20020a170907294700b00a268919f183mr1802863ejc.289.1705490949116; Wed, 17
 Jan 2024 03:29:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9cdbf0ca9cdda1b4c84e15e548af7d7f9f926382.camel@intelfx.name>
In-Reply-To: <9cdbf0ca9cdda1b4c84e15e548af7d7f9f926382.camel@intelfx.name>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 17 Jan 2024 11:28:32 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5UaYcAYHijBO+QTnnpruVQXvdirg05_X94KRKrKnXDZw@mail.gmail.com>
Message-ID: <CAL3q7H5UaYcAYHijBO+QTnnpruVQXvdirg05_X94KRKrKnXDZw@mail.gmail.com>
Subject: Re: [6.7 regression] [BISECTED] 28270e25c69a causes overallocation of
 metadata space
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 6:04=E2=80=AFAM Ivan Shapovalov <intelfx@intelfx.na=
me> wrote:
>
> Hi all,
>
> Starting from v6.7 I've noticed severe overallocation of metadata space
> on both of my btrfs root filesystems (both NVMe SSDs, both use
> snapshots):
>
> ```
> # mount | grep -w /
> rw,noatime,compress=3Dzstd:1,ssd,discard=3Dasync,space_cache=3Dv2,subvoli=
d=3D<...>
>
> # btrfs fi usage /
> <...>
>
> Data,single: Size:550.00GiB, Used:497.12GiB (90.39%)
>    /dev/mapper/root      550.00GiB
>
> Metadata,DUP: Size:72.00GiB, Used:8.38GiB (11.64%)
>    /dev/mapper/root      144.00GiB
>
> <...>
> ```
>
> Running a full metadata balance (`btrfs balance start -m /`) or a
> "staged" balance
> (e. g. `for u in {0..90..5}; do btrfs balance start -musage=3D$u /`)
> does not help / makes the overallocation worse.
>
> Bisect log:
> ```
> # bad: [0dd3ee31125508cd67f7e7172247f05b7fd1753a] Linux 6.7
> # good: [ffc253263a1375a65fa6c9f62a893e9767fbebfa] Linux 6.6
> git bisect start 'v6.7' 'v6.6'
> # bad: [deefd5024f0772cf56052ace9a8c347dc70bcaf3] Merge tag 'vfio-v6.7-rc=
1' of https://github.com/awilliam/linux-vfio
> git bisect bad deefd5024f0772cf56052ace9a8c347dc70bcaf3
> # bad: [5a6a09e97199d6600d31383055f9d43fbbcbe86f] Merge tag 'cgroup-for-6=
.7' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
> git bisect bad 5a6a09e97199d6600d31383055f9d43fbbcbe86f
> # good: [17047fbced563cf5abe5aa546f6a92af48900b69] bcachefs: Fix incorrec=
tly freeing btree_path in alloc path
> git bisect good 17047fbced563cf5abe5aa546f6a92af48900b69
> # good: [b827ac419721a106ae2fccaa40576b0594edad92] exportfs: Change bcach=
efs fid_type enum to avoid conflicts
> git bisect good b827ac419721a106ae2fccaa40576b0594edad92
> # bad: [9ab021a1b57007a22761f6f41d91eb4aae10d145] Merge tag 'x86_cache_fo=
r_6.7_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad 9ab021a1b57007a22761f6f41d91eb4aae10d145
> # good: [8b16da681eb0c9b9cb2f9abd0dade67559cfb48d] Merge tag 'nfsd-6.7' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
> git bisect good 8b16da681eb0c9b9cb2f9abd0dade67559cfb48d
> # bad: [07a274a8862dba86a270ced2a4c5ff3f7a01b66a] btrfs: remove redundant=
 root argument from btrfs_update_inode_item()
> git bisect bad 07a274a8862dba86a270ced2a4c5ff3f7a01b66a
> # good: [3ee56a58ad8921cb43c49d56347a8e270871844c] btrfs: reserve space f=
or delayed refs on a per ref basis
> git bisect good 3ee56a58ad8921cb43c49d56347a8e270871844c
> # bad: [9f9918a8017b7925da2fad16b4ccf6a14630f03e] btrfs: sysfs: announce =
presence of raid-stripe-tree
> git bisect bad 9f9918a8017b7925da2fad16b4ccf6a14630f03e
> # bad: [87463f7e0250d471fac41e7c9c45ae21d83b5f85] btrfs: zoned: factor ou=
t DUP bg handling from btrfs_load_block_group_zone_info
> git bisect bad 87463f7e0250d471fac41e7c9c45ae21d83b5f85
> # bad: [50564b651d01c19ce732819c5b3c3fd60707188e] btrfs: abort transactio=
n on generation mismatch when marking eb as dirty
> git bisect bad 50564b651d01c19ce732819c5b3c3fd60707188e
> # bad: [28270e25c69a2c76ea1ed0922095bffb9b9a4f98] btrfs: always reserve s=
pace for delayed refs when starting transaction
> git bisect bad 28270e25c69a2c76ea1ed0922095bffb9b9a4f98
> # good: [adb86dbe426f9a54843d70092819deca220a224d] btrfs: stop doing exce=
ssive space reservation for csum deletion
> git bisect good adb86dbe426f9a54843d70092819deca220a224d
> # first bad commit: [28270e25c69a2c76ea1ed0922095bffb9b9a4f98] btrfs: alw=
ays reserve space for delayed refs when starting transaction

This sounds like the generally more pessimistic metadata reservation
is triggering allocation of many metadata block groups
that never get used and then unused and therefore not
reclaimed/deleted. Not something impossible to happen before that,
but much more likely due to more reserved space.

I'll send some fixes.

Did you actually run into -ENOSPC issues?

Thanks.

> ```
>
> Thanks,
> --
> Ivan Shapovalov / intelfx /
>

