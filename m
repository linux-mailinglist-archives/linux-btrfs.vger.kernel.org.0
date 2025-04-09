Return-Path: <linux-btrfs+bounces-12925-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDBAA82C88
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 18:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59312189738B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 16:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF3D26E14A;
	Wed,  9 Apr 2025 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6WaxS2W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F601C5F23
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216314; cv=none; b=AbX+C4vGAdP5ZtOflPhE5/v39Jg9/yeO1ss1wLXebGLbPmHyLR8xeku+szWJiep79U4j1dIpD4I1+rmCdbm3iRQpzwgkFVIdqSTHDnD/+t14e9NRf4SdD7g2YNrtvkLnUzKp12c7VsiGlnlCOipvPPjtgz1F0tmy72SkpZPyJRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216314; c=relaxed/simple;
	bh=m0S23YdybXEorI1XM83WCmwrBidGPv6/ktbgJsXfTAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNt1S8C91R5zDNXtQG32iHnD7PUHRIt4BLlpDueKRcTv4sY2l+jZFsd4eG84oeAF2eTJc55v22J5hERd/0aDsVx6kY6IxoKOMvoTaKS2BGch/SYvUL9EE/N21zzD0DMO1XxAlRz9KhgsecHasdLvHs8XQpU25SB/xBKxS+Vx/rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6WaxS2W; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ecfbf1c7cbso117448686d6.2
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Apr 2025 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744216311; x=1744821111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EjCHKbcItcz3NX6Ya94sukZuUS9nd8G9Rf/5OtuyRYg=;
        b=C6WaxS2W0bA5bx58oS0/1LH4pH67GaLuG5EJThGw2nPTaUJs9AYeA9Z6LofAKljltH
         inZpBMd2WghYJdP7ZCgX7OLoMChheGBsptEvC9thO6wgFTCmeKJ9IaaWDWDaEecN4LmA
         cNvvAEvuCmQsy2mzbhQTFW6Ah4G1vNJbM+SjgqtR+1sHI0rIfbZrqmj2/VmavJre3Gs9
         qpsDE5/I238FeMI3gklACQDMcPgkYRFrGfRM14qqj5RmiKI/EXdAHD4L0nCcWXStPY9z
         5xgl2BAQ//xH9wByG/cm4BgQ9gH8BuWLufVm4InITwQSCW5K0TQbKp/K74Ms48JsWb1J
         ZYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744216311; x=1744821111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjCHKbcItcz3NX6Ya94sukZuUS9nd8G9Rf/5OtuyRYg=;
        b=rYZ0q1G7k5ny8i5Em3sWlTgTSSOBibpuih4fP8K4JaeHNKmywG51orMmVu7+Z46lxc
         v6Oje7JYovoB/RVnK22TxCqG8bIoUKCB3h0SsDIAlif8tZGLicIKRAX1UZbwyHZnypl2
         JhBSu/fxNeUdQPkA/XyzF+LNNmkcLDHNTST8nyHCizHZVi8cJB+BcYV/OCr7v4ugsgJj
         g8pkpBYID9w/8Ez1/l0vh3KoNFlIKZTddkG5LkNqvZdJVyZxX+LU+Sg+mbRxpjvwMPId
         wxogz4zNV6ajm9GnPgistGaR223TY2MktszZrkbm1BZ+Bx/5BbMHX2jl/4mAIGdYN50X
         8Abg==
X-Gm-Message-State: AOJu0YzDJEk0JrAP3SSGZSZi+s3S4u0UzwBv5hSh4ZreD74LBPZ6IV/B
	R83P4d8jNpGBKt07hjt6CgC+BGi0SRWuIsKhRBPFOkkTLhY+/X12SsiGjw9F+5U/tTDJu2icBF7
	uIHlnJEYoZAwOPlvwyl2C/7dgrrE=
X-Gm-Gg: ASbGnct/uo5v3HC+hcY/6ZhJmvUUNCkXq5B7XhfqrjgqWEi45FCfVZSQJ98zDH5SoI4
	/W2yTIaCdwMd/43+Orv+fWN49+AyYJJ4y4HJa0lZ9KlAWiIXwBSPRp8KqirW+9Tk3bnD14YYlgv
	wObbjZ6KM3RWR3dmvmCNENlcMCWk14aBChN8O72yTcHLB9D2VKguA41NJHMpW45fCE1g==
X-Google-Smtp-Source: AGHT+IHxPFw378MfWhkAJLJwKiHlJV+nzsorkNeAsqx+ZM905zq6F0ivC9X/sjkWOLTS6FpW0LgDJPPNtdmrLFkOAiQ=
X-Received: by 2002:a05:6214:202d:b0:6ed:1659:76b0 with SMTP id
 6a1803df08f44-6f0dd77b4c1mr43338476d6.20.1744216310953; Wed, 09 Apr 2025
 09:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1735748715.git.anand.jain@oracle.com>
In-Reply-To: <cover.1735748715.git.anand.jain@oracle.com>
From: Kai Krakow <hurikhan77+btrfs@gmail.com>
Date: Wed, 9 Apr 2025 18:31:24 +0200
X-Gm-Features: ATxdqUG2cx1I5hJrD-IPzBi_ubBbL_HMxjObAwkC2oJd10r4VKlj92RREyMBmMU
Message-ID: <CAMthOuMzzURcyMjbv49rkpzqc-PSPa76VkQG+FRCt0e9x_NQCA@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] raid1 balancing methods
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, Naohiro.Aota@wdc.com, 
	wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Content-Type: text/plain; charset="UTF-8"

Hi Anand!

Am Mi., 1. Jan. 2025 um 19:10 Uhr schrieb Anand Jain <anand.jain@oracle.com>:
>
> v5:
> Fixes based on review comments:
>   . Rewrite `btrfs_read_policy_to_enum()` using `sysfs_match_string()`
>     and `strncpy()`.
>   . Rewrite the round-robin method based on read counts.
>   . Fix the smatch indentation warning.
>  - Change the default minimum contiguous device read size for round-robin
>    from 256K to 192K, as the latter performs slightly better.
>  - Introduce a framework to track filesystem read counts. (New patch)
>  - Reran defrag performance numbers
>       $ xfs_io -f -d -c 'pwrite -S 0xab 0 1000000000' /btrfs/P6B
>       $ time -p btrfs filesystem defrag -r -f -c /btrfs
>
> |         | Time  | Read I/O Count  | gain  |
> |         | Real  | devid1 | devid2 | w-PID |
> |---------|-------|--------|--------|-------|
> | pid     | 11.14s| 3808   | 0      |  -    |
> | rotation|       |        |        |       |
> |   196608|  6.54s| 2532   | 1276   | 41.29%|
> |   262144|  8.42s| 1907   | 1901   | 24.41%|
> | devid:1 | 10.95s| 3807   | 0      | 1.70% |
>
> v4:
> Fixes based on review comments:
>   3/10: Use == 0 to check strlen(str); drop dynamic alloc for %param.
>   4/10: Add __maybe_unused for %value_str in btrfs_read_policy_to_enum().
>         Return int instead of enum btrfs_read_policy.
>   5/10: Fix change-log (: is part of optional [ ]).
>         Wrap btrfs_read_policy_name[] with ifdef for new methods.
>         Use IS_ALIGNED() for sector-size alignment check.
>         Roundup misaligned %value.
>         Use named constants: BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ, BTRFS_RAID1_MAX_MIRRORS.
>         Mark %s1 and %s2 in btrfs_cmp_devid() as const.
>         Add comments to btrfs_read_rr();
>         Use loop-local %i. Add space around /.
>         Use >> for sector-size division.
>         Prefix %min_contiguous_read with rr.
>   7/10: Move experimental to the top of the feature list.
>         Use experiment=on. Skip printing when off.
>
> v3:
> 1. Removed the latency-based RAID1 balancing patch. (Per David's review)
> 2. Renamed "rotation" to "round-robin" and set the per-set
>    min_contiguous_read to 256k. (Per David's review)
> 3. Added raid1-balancing module configuration for fstests testing.
>    raid1-balancing can now be configured through both module load
>    parameters and sysfs.
>
> The logic of individual methods remains unchanged, and performance metrics
> are consistent with v2.
>
> -----
> v2:
> 1. Move new features to CONFIG_BTRFS_EXPERIMENTAL instead of CONFIG_BTRFS_DEBUG.
> 2. Correct the typo from %est_wait to %best_wait.
> 3. Initialize %best_wait to U64_MAX and remove the check for 0.
> 4. Implement rotation with a minimum contiguous read threshold before
>    switching to the next stripe. Configure this, using:
>
>         echo rotation:[min_contiguous_read] > /sys/fs/btrfs/<uuid>/read_policy
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
>      $ fio --filename=/btrfs/foo --size=5Gi --direct=1 --rw=randrw --bs=4k \
>         --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 \
>         --time_based --group_reporting --name=iops-test-job --eta-newline=1
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
> While Latency is better during the failing/unstable block layer transport.
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
> Both techniques need independent testing across workloads, with the goal of
> eventually merging them into a unified approach? for the long term.
>
> Devid is a hands-on approach, provides manual or user-space script control.
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
> $ fio --filename=/btrfs/foo --size=10Gi --direct=1 --rw=randrw --bs=4k \
>   --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 --time_based \
>   --group_reporting --name=iops-test-job --eta-newline=1
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
>   btrfs: add read count tracking for filesystem stats
>   btrfs: introduce RAID1 round-robin read balancing
>   btrfs: add RAID1 preferred read device
>   btrfs: expose experimental mode in module information
>   btrfs: enable RAID1 balancing configuration via modprobe parameter
>   btrfs: modload to print RAID1 balancing status
>
>  fs/btrfs/bio.c     |   8 +++
>  fs/btrfs/disk-io.c |   4 ++
>  fs/btrfs/super.c   |  18 +++++
>  fs/btrfs/sysfs.c   | 168 ++++++++++++++++++++++++++++++++++++++++-----
>  fs/btrfs/sysfs.h   |   5 ++
>  fs/btrfs/volumes.c | 115 ++++++++++++++++++++++++++++++-
>  fs/btrfs/volumes.h |  22 +++++-
>  7 files changed, 317 insertions(+), 23 deletions(-)
>
> --
> 2.47.0

I've backported your patches to my LTS kernel to experiment with it a
bit. I've also included the latency-based policy for that reason.
Here's what I currently got:
https://github.com/kakra/linux/pull/36

I've added an idea to use a hybrid policy which combines round-robin
and latency into one combined policy. But it seems like over time, it
will just acts like round-robin. This is probably because the average
latency is calculated over the full history of requests. I think using
an EMA (exponential moving average) with an alpha of 1/8 or 1/16 could
work better. But this would require to sample each bio individually
and add fields to the device structs. Something like this:

s64 current_ema = atomic64_read(&device->avg_latency_ema);
s64 difference = (s64)current_latency - current_ema; // important:
signed difference!
s64 new_ema = current_ema + (difference >> N); // N = 3 or 4 (alpha 1/8 or 1/16)
atomic64_cmpxchg(&device->avg_latency_ema, current_ema, new_ema);

What do you think?

I'm currently not posting my patch series here because

(a) it's based/backported on LTS
(b) I'm not yet very familiar with doing that on the mailing list
(c) the code is not ready and contains some duplication

I hope that's okay.

So far, both the latency and round-robin policies work well in my
setup. The latency policy actually filters out a low-end desktop HDD
which is quite slow (according to fio) for individual short requests
and long sequential reading (acts more like 5400rpm in that case) but
is actually not that bad for typical random IO with larger block sizes
(actually competes well with my other 7200rpm disks). Combined with
bcache, this automatically optimizes the fastest disks into the cache,
avoiding the slower ones when using the latency policy.

Overall, loading times in some applications with random but massive IO
thus seem faster with the latency policy while sequential IO is faster
with the round-robin policy.

I think the hybrid approach could fit both scenarios but it currently
suffers from not adapting well to changes in IO patterns - which EMA
could solve.

Thanks
Kai

