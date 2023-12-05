Return-Path: <linux-btrfs+bounces-672-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D587805ECB
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 20:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD4E1C20FD2
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 19:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F0B6ABA9;
	Tue,  5 Dec 2023 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQ6zNJmZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874DF6AB8B;
	Tue,  5 Dec 2023 19:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8CCC433C7;
	Tue,  5 Dec 2023 19:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701805841;
	bh=xcrAZTBXnUwk73IiUzyWwKsoxLSG00h7H6Qc8EGSjts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sQ6zNJmZFcrLdqkVcETYwTad10wYDqiIt7OgSBQ/aMuUcXWXzh1zqeZ6C08eKGQOq
	 9g+bIeg/8EIf67ftHpgqOqDm4O7sZ2Y/pFdrW2ah/isfHbIy/B4RsPjmD8NANg3+KG
	 5+YH8IgFKStKkRwZq1//iRX0GvUDy+4fovo3SkgsQ+zvLyBzp5GWCIwQgxT5pl2uTb
	 +xiIga+3n7s85S71PR4ig3n6v1ho95iXC25sOAMch6EXpekOYrv2kI0PV3QugeVvfn
	 GoBqusiumxm5DI4HDaeZYU+kKIDhXLpqzr0aLbDQaf2duoXJdbx8OQIc5TmBMGwAO/
	 ReRXIfXtmt+kg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a1ceae92ab6so6132266b.0;
        Tue, 05 Dec 2023 11:50:40 -0800 (PST)
X-Gm-Message-State: AOJu0YyMYw7LkLUPUq3or4lg7nukT+QV/eyHNutfIdzLJLWVmZksqLJn
	6d4G2nHZ0Kkmc0JL3JZq59MRd6O+gy+PcSQcov4=
X-Google-Smtp-Source: AGHT+IEmel214zAmbqvtlgVIpNyt4Xv4SGR0RYXpBHAKkjvOIhFWLhzMyScfegGb8Rx5oO3LmQo0R4v/DTu0zcVw00M=
X-Received: by 2002:a17:906:2616:b0:a17:8181:4f3 with SMTP id
 h22-20020a170906261600b00a17818104f3mr4923831ejc.49.1701805839347; Tue, 05
 Dec 2023 11:50:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205-btrfs-raid-v3-0-0e857a5439a2@wdc.com>
In-Reply-To: <20231205-btrfs-raid-v3-0-0e857a5439a2@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 5 Dec 2023 19:50:02 +0000
X-Gmail-Original-Message-ID: <CAL3q7H56L7+m6-SX6oqoaDu89u-QNVR-0F=G3bSt+g4S-uSBPg@mail.gmail.com>
Message-ID: <CAL3q7H56L7+m6-SX6oqoaDu89u-QNVR-0F=G3bSt+g4S-uSBPg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] fstests: add tests for btrfs' raid-stripe-tree feature
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>, 
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 5:47=E2=80=AFPM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Add tests for btrfs' raid-stripe-tree feature. All of these test work by
> writing a specific pattern to a newly created filesystem and afterwards
> using `btrfs inspect-internal -t raid-stripe $SCRATCH_DEV_POOL` to verify
> the placement and the layout of the metadata.
>
> The md5sum of each file will be compared as well after a re-mount of the
> filesystem.
>
> ---
> Changes in v3:
> - added 'raid-stripe-tree' to mkfs options, as only zoned raid gets it
>   automatically
> - Rename test cases as btrfs/302 and btrfs/303 already exist upstream
> - Link to v2: https://lore.kernel.org/r/20231205-btrfs-raid-v2-0-25f80eea=
345b@wdc.com
>
> Changes in v2:
> - Re-ordered series so the newly introduced group is added before the
>   tests
> - Changes Filipe requested to the tests.
> - Link to v1: https://lore.kernel.org/r/20231204-btrfs-raid-v1-0-b254eb1b=
cff8@wdc.com
>
> ---
> Johannes Thumshirn (7):
>       fstests: doc: add new raid-stripe-tree group
>       common: add filter for btrfs raid-stripe dump
>       btrfs: add fstest for stripe-tree metadata with 4k write
>       btrfs: add fstest for 8k write spanning two stripes on raid-stripe-=
tree
>       btrfs: add fstest for writing to a file at an offset with RST
>       btrfs: add fstests to write 128k to a RST filesystem
>       btrfs: add fstest for overwriting a file partially with RST

Just one more thing, and sorry I didn't notice before. All the tests fail
when running with compression enabled, for example:

root 19:41:12 /home/fdmanana/git/hub/xfstests > MOUNT_OPTIONS=3D"-o
compress" ./check btrfs/305
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian0 6.7.0-rc3-btrfs-next-143+ #1 SMP
PREEMPT_DYNAMIC Mon Dec  4 11:01:37 WET 2023
MKFS_OPTIONS  -- /dev/sdb
MOUNT_OPTIONS -- -o compress /dev/sdb /home/fdmanana/btrfs-tests/scratch_1

btrfs/305 1s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/305.out.bad)
    --- tests/btrfs/305.out 2023-12-05 19:35:00.986326843 +0000
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/305.out.bad
2023-12-05 19:43:31.098623435 +0000
    @@ -14,15 +14,12 @@
     checksum calced <CHECKSUM>
     fs uuid <UUID>
     chunk uuid <UUID>
    - item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 24
    + item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
      encoding: RAID0
      stripe 0 devid 1 physical XXXXXXXXX
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/305.out
/home/fdmanana/git/hub/xfstests/results//btrfs/305.out.bad'  to see
the entire diff)
Ran: btrfs/305
Failures: btrfs/305
Failed 1 of 1 tests

Also, they all fail when the free space tree is disabled, like this:

root 19:45:30 /home/fdmanana/git/hub/xfstests > MKFS_OPTIONS=3D"-O
^free-space-tree" ./check btrfs/304
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian0 6.7.0-rc3-btrfs-next-143+ #1 SMP
PREEMPT_DYNAMIC Mon Dec  4 11:01:37 WET 2023
MKFS_OPTIONS  -- -O ^free-space-tree /dev/sdb
MOUNT_OPTIONS -- /dev/sdb /home/fdmanana/btrfs-tests/scratch_1

btrfs/304 1s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/304.out.bad)
    --- tests/btrfs/304.out 2023-12-05 19:34:01.040411746 +0000
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/304.out.bad
2023-12-05 19:45:36.242621419 +0000
    @@ -15,6 +15,156 @@
      item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
      encoding: RAID0
      stripe 0 devid 1 physical XXXXXXXXX
    + item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
    + encoding: RAID0
    + stripe 0 devid 1 physical XXXXXXXXX
    + item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/304.out
/home/fdmanana/git/hub/xfstests/results//btrfs/304.out.bad'  to see
the entire diff)
Ran: btrfs/304
Failures: btrfs/304
Failed 1 of 1 tests

And with nodatacow, only one of them fails:

root 19:46:16 /home/fdmanana/git/hub/xfstests > MOUNT_OPTIONS=3D"-o
nodatacow" ./check btrfs/304 btrfs/305 btrfs/306 btrfs/307 btrfs/308
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian0 6.7.0-rc3-btrfs-next-143+ #1 SMP
PREEMPT_DYNAMIC Mon Dec  4 11:01:37 WET 2023
MKFS_OPTIONS  -- /dev/sdb
MOUNT_OPTIONS -- -o nodatacow /dev/sdb /home/fdmanana/btrfs-tests/scratch_1

btrfs/304 1s ...  1s
btrfs/305 1s ...  1s
btrfs/306 1s ...  1s
btrfs/307 1s ...  1s
btrfs/308 0s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/308.out.bad)
    --- tests/btrfs/308.out 2023-12-05 19:37:38.379355089 +0000
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/308.out.bad
2023-12-05 19:46:33.716457540 +0000
    @@ -28,9 +28,6 @@
      item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
      encoding: RAID0
      stripe 0 devid 1 physical XXXXXXXXX
    - item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 24
    - encoding: RAID0
    - stripe 0 devid 1 physical XXXXXXXXX
     total bytes XXXXXXXX
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/308.out
/home/fdmanana/git/hub/xfstests/results//btrfs/308.out.bad'  to see
the entire diff)
Ran: btrfs/304 btrfs/305 btrfs/306 btrfs/307 btrfs/308
Failures: btrfs/308
Failed 1 of 5 tests

For the compression, we can just add a "_require_no_compress".
We should also skip them when free space tree is not enabled or
nodatacow is enabled for 308 (don't recall if we already have helpers
for that).

Other than that, everything looks good to me.

Thanks.


>
>  common/filter.btrfs |  14 +++++++
>  doc/group-names.txt |   1 +
>  tests/btrfs/304     |  53 ++++++++++++++++++++++++++
>  tests/btrfs/304.out |  58 ++++++++++++++++++++++++++++
>  tests/btrfs/305     |  58 ++++++++++++++++++++++++++++
>  tests/btrfs/305.out |  82 ++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/306     |  56 +++++++++++++++++++++++++++
>  tests/btrfs/306.out |  75 +++++++++++++++++++++++++++++++++++++
>  tests/btrfs/307     |  53 ++++++++++++++++++++++++++
>  tests/btrfs/307.out |  65 ++++++++++++++++++++++++++++++++
>  tests/btrfs/308     |  56 +++++++++++++++++++++++++++
>  tests/btrfs/308.out | 106 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  12 files changed, 677 insertions(+)
> ---
> base-commit: 5649843ef186de89f58bc69b04a8dc86adf8f1ae
> change-id: 20231204-btrfs-raid-75975797f97d
>
> Best regards,
> --
> Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
>

