Return-Path: <linux-btrfs+bounces-9738-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CF99CF4CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 20:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CE8AB2C38F
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 19:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D371D90AE;
	Fri, 15 Nov 2024 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auJxVQZJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF151CEE97
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731698245; cv=none; b=Onz0hNk1Z7bRDFckFZL4ehxK30tCssjUgIPUUAKbi1nLMsgWctyJjSnWZNl4EuYd7Br4Md5MRdE8t1kUeQXqbF2oLHBKH8gPaqe9fUpIzhFO84XT17KfHG170TBeOh5iys+J3gBAJwUHacSk2d6CFEe0qbGoC3IMo9JlpZUZke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731698245; c=relaxed/simple;
	bh=djKS5m7UsB5NOqcqCRt358iGjMmrAu+44a5u7CzbLrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIlQsC8RLwevZ5AQpasB98f09hgMTZfSC98IHPdq0aUzhAmNV/E3+CwlAkxzUqQU+qsVAgsiN1Wl4jwpk+xEKgtUwKPdE2BvmUXtR09w22xFEp6RKkOVRA+yrDnTY4v7hdoGkifn1RK1W2WxkQAeP3UU2UUjGTl9UPvCkcexkCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auJxVQZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2ACC4CED6
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 19:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731698245;
	bh=djKS5m7UsB5NOqcqCRt358iGjMmrAu+44a5u7CzbLrY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=auJxVQZJaHXr6jUL+smWN/iGlkgmGc6NI8+f/FcaBm6iAZMGvImbZ9KSeO0D5LAD0
	 6bie3k28YbgErTcuQlkFSmIpMLoi3vKFJ/pmNTOSGjEUrWijdSeUjAqlSg+HiiLo2q
	 Ho7HdEV897xOdiMAaQ2m0BMQk6cMvCT5tvVrtapqQ3kRa24UOXtfgjs/9/U7wqAfkf
	 hySBsAoFq9EsIlhFSbCpWN3xHUX7d0J2wZLMp9jV3juXdE6Ryf9tz5uGZoHzF/j2FJ
	 E+PW1OFY8qN7WrXHXTNBpCGU7AqulSbWNfjllAEc0mRdsvg9RppIHMI73D8zRZHsA5
	 OzhQVmJ4RH7BQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cf6f804233so1529814a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 11:17:25 -0800 (PST)
X-Gm-Message-State: AOJu0Yz7EkpMOMrsLu5gHlCTZyXWGCye410V85htCE5FXf4x8LVpXVXe
	GrD6q4qwUKEywQn8Xe+HFWe5VixpbaZouNIyAa8LobMMA5yIUZxGoK5zWPDY8PYsSToDU6UtvaR
	cTDN8dcafixhkCwtml+fpY8dh5UM=
X-Google-Smtp-Source: AGHT+IFx7f7I6Pjy0GyN3tXWmK00B8dhyVq0yOuNyCqCf/7hw8iwSfVpLy9uo0wVRydGZorrAtJ3CR1i77xH6wqKxYY=
X-Received: by 2002:a17:907:2d90:b0:aa3:5ca5:2ca4 with SMTP id
 a640c23a62f3a-aa483441d9cmr344440466b.25.1731698243921; Fri, 15 Nov 2024
 11:17:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731076425.git.anand.jain@oracle.com>
In-Reply-To: <cover.1731076425.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 15 Nov 2024 19:16:47 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4PjErPf0XxBwLgK_2Sm1ABen4Xb-bi2Bj_+zM7uB7YCA@mail.gmail.com>
Message-ID: <CAL3q7H4PjErPf0XxBwLgK_2Sm1ABen4Xb-bi2Bj_+zM7uB7YCA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] raid1 balancing methods
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, 
	waxhead@dirtcellar.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 2:55=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> v3:
> 1. Removed the latency-based RAID1 balancing patch. (Per David's review)
> 2. Renamed "rotation" to "round-robin" and set the per-set
>    min_contiguous_read to 256k. (Per David's review)
> 3. Added raid1-balancing module configuration for fstests testing.
>    raid1-balancing can now be configured through both module load
>    parameters and sysfs.
>
> The logic of individual methods remains unchanged, and performance metric=
s
> are consistent with v2.
>
> -----
> v2:
> 1. Move new features to CONFIG_BTRFS_EXPERIMENTAL instead of CONFIG_BTRFS=
_DEBUG.
> 2. Correct the typo from %est_wait to %best_wait.
> 3. Initialize %best_wait to U64_MAX and remove the check for 0.
> 4. Implement rotation with a minimum contiguous read threshold before
>    switching to the next stripe. Configure this, using:
>
>         echo rotation:[min_contiguous_read] > /sys/fs/btrfs/<uuid>/read_p=
olicy
>
>    The default value is the sector size, and the min_contiguous_read
>    value must be a multiple of the sector size.
>
> 5. Tested FIO random read/write and defrag compression workloads with
>    min_contiguous_read set to sector size, 192k, and 256k.
>
>    RAID1 balancing method rotation is better for multi-process workloads
>    such as fio and also single-process workload such as defragmentation.
>
>      $ fio --filename=3D/btrfs/foo --size=3D5Gi --direct=3D1 --rw=3Drandr=
w --bs=3D4k \
>         --ioengine=3Dlibaio --iodepth=3D256 --runtime=3D120 --numjobs=3D4=
 \
>         --time_based --group_reporting --name=3Diops-test-job --eta-newli=
ne=3D1
>
>
> |         |            |            | Read I/O count  |
> |         | Read       | Write      | devid1 | devid2 |
> |---------|------------|------------|--------|--------|
> | pid     | 20.3MiB/s  | 20.5MiB/s  | 313895 | 313895 |
> | rotation|            |            |        |        |
> |     4096| 20.4MiB/s  | 20.5MiB/s  | 313895 | 313895 |
> |   196608| 20.2MiB/s  | 20.2MiB/s  | 310152 | 310175 |
> |   262144| 20.3MiB/s  | 20.4MiB/s  | 312180 | 312191 |
> |  latency| 18.4MiB/s  | 18.4MiB/s  | 272980 | 291683 |
> | devid:1 | 14.8MiB/s  | 14.9MiB/s  | 456376 | 0      |
>
>    rotation RAID1 balancing technique performs more than 2x better for
>    single-process defrag.
>
>       $ time -p btrfs filesystem defrag -r -f -c /btrfs
>
>
> |         | Time  | Read I/O Count  |
> |         | Real  | devid1 | devid2 |
> |---------|-------|--------|--------|
> | pid     | 18.00s| 3800   | 0      |
> | rotation|       |        |        |
> |     4096|  8.95s| 1900   | 1901   |
> |   196608|  8.50s| 1881   | 1919   |
> |   262144|  8.80s| 1881   | 1919   |
> | latency | 17.18s| 3800   | 0      |
> | devid:2 | 17.48s| 0      | 3800   |
>
> Rotation keeps all devices active, and for now, the Rotation RAID1
> balancing method is preferable as default. More workload testing is
> needed while the code is EXPERIMENTAL.
> While Latency is better during the failing/unstable block layer transport=
.
> As of now these two techniques, are needed to be further independently
> tested with different worloads, and in the long term we should be merge
> these technique to a unified heuristic.
>
> Rotation keeps all devices active, and for now, the Rotation RAID1
> balancing method should be the default. More workload testing is needed
> while the code is EXPERIMENTAL.
>
> Latency is smarter with unstable block layer transport.
>
> Both techniques need independent testing across workloads, with the goal =
of
> eventually merging them into a unified approach? for the long term.
>
> Devid is a hands-on approach, provides manual or user-space script contro=
l.
>
> These RAID1 balancing methods are tunable via the sysfs knob.
> The mount -o option and btrfs properties are under consideration.
>
> Thx.
>
> --------- original v1 ------------
>
> The RAID1-balancing methods helps distribute read I/O across devices, and
> this patch introduces three balancing methods: rotation, latency, and
> devid. These methods are enabled under the `CONFIG_BTRFS_DEBUG` config
> option and are on top of the previously added
> `/sys/fs/btrfs/<UUID>/read_policy` interface to configure the desired
> RAID1 read balancing method.
>
> I've tested these patches using fio and filesystem defragmentation
> workloads on a two-device RAID1 setup (with both data and metadata
> mirrored across identical devices). I tracked device read counts by
> extracting stats from `/sys/devices/<..>/stat` for each device. Below is
> a summary of the results, with each result the average of three
> iterations.
>
> A typical generic random rw workload:
>
> $ fio --filename=3D/btrfs/foo --size=3D10Gi --direct=3D1 --rw=3Drandrw --=
bs=3D4k \
>   --ioengine=3Dlibaio --iodepth=3D256 --runtime=3D120 --numjobs=3D4 --tim=
e_based \
>   --group_reporting --name=3Diops-test-job --eta-newline=3D1
>
> |         |            |            | Read I/O count  |
> |         | Read       | Write      | devid1 | devid2 |
> |---------|------------|------------|--------|--------|
> | pid     | 29.4MiB/s  | 29.5MiB/s  | 456548 | 447975 |
> | rotation| 29.3MiB/s  | 29.3MiB/s  | 450105 | 450055 |
> | latency | 21.9MiB/s  | 21.9MiB/s  | 672387 | 0      |
> | devid:1 | 22.0MiB/s  | 22.0MiB/s  | 674788 | 0      |
>
> Defragmentation with compression workload:
>
> $ xfs_io -f -d -c 'pwrite -S 0xab 0 1G' /btrfs/foo
> $ sync
> $ echo 3 > /proc/sys/vm/drop_caches
> $ btrfs filesystem defrag -f -c /btrfs/foo
>
> |         | Time  | Read I/O Count  |
> |         | Real  | devid1 | devid2 |
> |---------|-------|--------|--------|
> | pid     | 21.61s| 3810   | 0      |
> | rotation| 11.55s| 1905   | 1905   |
> | latency | 20.99s| 0      | 3810   |
> | devid:2 | 21.41s| 0      | 3810   |
>
> . The PID-based balancing method works well for the generic random rw fio
>   workload.
> . The rotation method is ideal when you want to keep both devices active,
>   and it boosts performance in sequential defragmentation scenarios.
> . The latency-based method work well when we have mixed device types or
>   when one device experiences intermittent I/O failures the latency
>   increases and it automatically picks the other device for further Read
>   IOs.
> . The devid method is a more hands-on approach, useful for diagnosing and
>   testing RAID1 mirror synchronizations.
>
> Anand Jain (10):
>   btrfs: initialize fs_devices->fs_info earlier
>   btrfs: simplify output formatting in btrfs_read_policy_show
>   btrfs: add btrfs_read_policy_to_enum helper and refactor read policy
>     store
>   btrfs: handle value associated with raid1 balancing parameter
>   btrfs: introduce RAID1 round-robin read balancing
>   btrfs: add RAID1 preferred read device
>   btrfs: pr CONFIG_BTRFS_EXPERIMENTAL status
>   btrfs: fix CONFIG_BTRFS_EXPERIMENTAL migration

Why are these two patches, which are fixes unrelated to the raid
balancing feature, in the middle of this patchset?
These should go as a separate patchset...

Also for the second patch, there's already a fix from yesterday and in for-=
next:

https://lore.kernel.org/linux-btrfs/c7b550091f427a79ec5a9aa6c5ac6b5efbdb4e8=
f.1731605782.git.fdmanana@suse.com/

Thanks.

>   btrfs: enable RAID1 balancing configuration via modprobe parameter
>   btrfs: modload to print RAID1 balancing status
>
>  fs/btrfs/disk-io.c |   1 +
>  fs/btrfs/super.c   |  22 +++++-
>  fs/btrfs/sysfs.c   | 181 ++++++++++++++++++++++++++++++++++++++++-----
>  fs/btrfs/sysfs.h   |   5 ++
>  fs/btrfs/volumes.c |  86 ++++++++++++++++++++-
>  fs/btrfs/volumes.h |  14 ++++
>  6 files changed, 286 insertions(+), 23 deletions(-)
>
> --
> 2.46.1
>
>

