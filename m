Return-Path: <linux-btrfs+bounces-14627-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE405AD71CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 15:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D38118999FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 13:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2FE246BBE;
	Thu, 12 Jun 2025 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQXNQLgO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561D12512E5;
	Thu, 12 Jun 2025 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734263; cv=none; b=WKiCBn23821654uy0EZ0ZubaqbyQIOF8nty5wMpKJ/gs956SzWj6Isgl+4OZAzv8COgi7MqFvNEEKrNfYdULK9Svfx1PvWg9wBnEelw1OwfVTNTQoavo53HdFzBy+8e3VFq7YbCzTD8QKQi+JU+lkisb7+jsVrP/UY6B46brllY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734263; c=relaxed/simple;
	bh=hEkt86vm4xQzj3we8H8ZsbWjyEVrNuFlKfyPkT+ZTDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZ22m8SPo/f7midF/mxDET/LnAzGXXvD6DSFMdyUYKwAazKQ1sr6N6DZJR9//UWwsNCJ5W69LZpVfq2GLIs7k9QaG8xKfFblLSy9pyvW6ff0nfftrIM2ge4jc/3DT3wzWFxCFefWI7pkBjEL5HfOU3qn7MQ+HX/zWKsnWs0uSIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQXNQLgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF84C4CEF1;
	Thu, 12 Jun 2025 13:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734262;
	bh=hEkt86vm4xQzj3we8H8ZsbWjyEVrNuFlKfyPkT+ZTDc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vQXNQLgOAd2g2uX0+hnckcQzagtQGAVIkBgRRheF5imlVjE1jKZSY4rWfQ4KpkiL9
	 bYeSzHkPLjX/WY8qDgtqSmdnxP/NC9bDspZY4yOjtUZU5yyGboHn6GseqvcmXmgC0b
	 AUhA+N/X8Gq0JaFFm28LlGrxCjKKVHjVpHjvJ//1NbJ/YBftiIrydxYO9KyuAuBWuC
	 uJhOx/Y4HPRAOXn2XW685d57AhScoIZWLV6k9edDDA1DeZJ/iVwogIiaEgx0HYKHl9
	 SPrhkXRizhMenziBni1p13PvpHmVUu0N/WeclDY/RieGA0eIKaYa26ezxoAo3ot1MN
	 1ejBKDKGw9sng==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6084dfb4cd5so3620909a12.0;
        Thu, 12 Jun 2025 06:17:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYlmz/rkBta3ADQLoPt6dgrhCKp/62/xX2nmJAwH2yXDb1Zqyn2yCuhAIA9GKI3J0br/xtX6HTtHt8pw==@vger.kernel.org, AJvYcCWiKInU0btZP62E+1OM0XhykVOc9pCnlSXvyMPl+PqLx6Zu2a/QiyMSgs4mwLkFETPhd7yH2/WwH6sfePcn@vger.kernel.org
X-Gm-Message-State: AOJu0YxXViFRN6X5spXh26muFfJKBphQdrudE2K8Y2kWLy5QCMyMMUJP
	RIoJ31lo2pJAf60HMfbB0ZuK9mqeJBL2FsyehEORc2o8LXonfL5SrTnLiC6q6GIHlCFzIsvD1jh
	Wx5MNB7lXQy8v0TSXxM739bXg3dUmz+c=
X-Google-Smtp-Source: AGHT+IFDonCFrnwH7QpeA/YWtaVaGIwsMHMbVBVU2XNBu8QAxXIked81SPQ3g0Y3+zUeUYr4DdsRCLqmYOE3PEqo+10=
X-Received: by 2002:a17:907:3d12:b0:ad5:6cfc:e519 with SMTP id
 a640c23a62f3a-adea55be570mr397151066b.11.1749734261013; Thu, 12 Jun 2025
 06:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202506121329.9d1f4d50-lkp@intel.com>
In-Reply-To: <202506121329.9d1f4d50-lkp@intel.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 12 Jun 2025 14:17:03 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Vk_Szvy2W66ZLikqkVEdvyLPuqpvcBdYcGKD5-gEzvA@mail.gmail.com>
X-Gm-Features: AX0GCFtWjQ_ZVrGf3xAM1_fZxqUqx11yLVtrTlvjR8OL3kePAri0rronz7kG2Jc
Message-ID: <CAL3q7H6Vk_Szvy2W66ZLikqkVEdvyLPuqpvcBdYcGKD5-gEzvA@mail.gmail.com>
Subject: Re: [linus:master] [btrfs] 32c523c578: reaim.jobs_per_min 16.1% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: Filipe Manana <fdmanana@suse.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 7:26=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed a 16.1% regression of reaim.jobs_per_min on:
>
>
> commit: 32c523c578e8489f55663ce8a8860079c8deb414 ("btrfs: allow folios to=
 be released while ordered extent is finishing")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [still regression on linus/master      5abc7438f1e9d62e91ad775cc83c9594c4=
8d2282]
> [still regression on linux-next/master 911483b25612c8bc32a706ba940738cc43=
299496]
>
> testcase: reaim
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10G=
Hz (Ice Lake) with 256G memory
> parameters:
>
>         runtime: 300s
>         nr_task: 100%
>         disk: 1HDD
>         fs: btrfs
>         test: disk
>         cpufreq_governor: performance
>
>
> In addition to that, the commit also has significant impact on the follow=
ing tests:
>
> +------------------+-----------------------------------------------------=
--------------------------------------+
> | testcase: change | reaim: reaim.jobs_per_min  5.3% regression          =
                                      |

Here it says 5.3% regression instead of 16.1%.

The phrasing right above suggests it's a different test, but it's
confusing since there's nothing here in the table description (test
parameters) that differs from the test details above.
It's the same test but on a different machine IIUC.

> | test machine     | 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @=
 3.50GHz (Ivy Bridge) with 16G memory |
> | test parameters  | cpufreq_governor=3Dperformance                      =
                                        |
> |                  | disk=3D1HDD                                         =
                                        |
> |                  | fs=3Dbtrfs                                          =
                                        |
> |                  | nr_task=3D100%                                      =
                                        |
> |                  | runtime=3D300s                                      =
                                        |
> |                  | test=3Ddisk                                         =
                                        |
> +------------------+-----------------------------------------------------=
--------------------------------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202506121329.9d1f4d50-lkp@intel.=
com
>
>
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250612/202506121329.9d1f4d50-lk=
p@intel.com

Following the instructions from the 'reproduce' file, it fails to
install the job:

fdmanana 13:28:49 ~/git/hub/lkp-tests (master)> sudo ./bin/lkp install job.=
yaml
distro=3Ddebian
version=3D13
Use: /home/fdmanana/git/hub/lkp-tests/distro/installer/debian install
bc debianutils gawk gzip kmod numactl rsync time automake bison
build-essential bzip2 ca-certificates cpio fakeroot flex git
libarchive-tools libc6-dev:i386 libc6-dev-x32 libipc-run-perl
libklibc-dev libssl-dev libtool linux-cpupower linux-libc-dev:i386
linux-perf openssl patch rsync ruby ruby-dev wget
Hit:1 http://deb.debian.org/debian testing InRelease
Reading package lists... Done
Reading package lists...
Building dependency tree...
Reading state information...
(...)
Reading state information...
E: Unable to locate package libpython2
E: Unable to locate package libpython3
Cannot install some packages of perf-c2c depends
fdmanana 13:29:05 ~/git/hub/lkp-tests (master)>

Alternatively, tried to run reaim directly following the script from
https://download.01.org/0day-ci/archive/20250612/202506121329.9d1f4d50-lkp@=
intel.com/repro-script

The problem is I can't find debian packages for reaim, and going to
sourceforge to get the source, and the latest is
osdl-aim-7.0.1.13.tar.gz (from 2004!), it doesn't compile, there are
tons on warnings and errors.
Applying the patch from lkp at
lkp-tests/programs/reaim/pkg/reaim.patch doesn't help either.




>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/disk/fs/kconfig/nr_task/rootfs/runtime/tbox_gro=
up/test/testcase:
>   gcc-12/performance/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-202=
40206.cgz/300s/lkp-icl-2sp7/disk/reaim
>
> commit:
>   cbfb4cbf45 ("btrfs: update comment for try_release_extent_state()")
>   32c523c578 ("btrfs: allow folios to be released while ordered extent is=
 finishing")
>
> cbfb4cbf459d9be4 32c523c578e8489f55663ce8a88
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>      71009           -14.7%      60593        meminfo.Shmem
>  2.344e+10           -10.8%   2.09e+10        cpuidle..time
>    6491212           -20.8%    5141230        cpuidle..usage
>      93.14            -1.5%      91.75        iostat.cpu.idle
>       5.81           +24.8%       7.24        iostat.cpu.iowait
>     419.83            -9.5%     380.03        uptime.boot
>      24988           -10.7%      22325        uptime.idle
>     584.67 =C4=85  3%     -23.6%     446.83 =C4=85  5%  perf-c2c.DRAM.rem=
ote
>     551.00 =C4=85 10%     -19.1%     445.50 =C4=85  9%  perf-c2c.HITM.loc=
al
>     407.83 =C4=85  5%     -25.4%     304.17 =C4=85  6%  perf-c2c.HITM.rem=
ote
>       5.84            +1.5        7.29        mpstat.cpu.all.iowait%
>       0.09            -0.0        0.07        mpstat.cpu.all.irq%
>       0.53            -0.1        0.46        mpstat.cpu.all.sys%
>       0.36 =C4=85  2%      +0.0        0.40 =C4=85  4%  mpstat.cpu.all.us=
r%
>    2110659 =C4=85  3%     -22.4%    1638521 =C4=85  3%  numa-numastat.nod=
e0.local_node
>    2132066 =C4=85  3%     -21.5%    1673684 =C4=85  3%  numa-numastat.nod=
e0.numa_hit
>    2054843 =C4=85  4%     -16.8%    1709588 =C4=85  2%  numa-numastat.nod=
e1.local_node
>    2099801 =C4=85  3%     -17.1%    1740752 =C4=85  2%  numa-numastat.nod=
e1.numa_hit
>      61.66          +186.4%     176.60        vmstat.io.bi
>      17553           -16.2%      14712        vmstat.io.bo
>       3.91 =C4=85  3%     +25.7%       4.92 =C4=85  4%  vmstat.procs.b
>       9668           -12.3%       8476        vmstat.system.cs
>      13868           -10.9%      12357        vmstat.system.in
>     521965 =C4=85  4%     -27.8%     376885 =C4=85  2%  numa-vmstat.node0=
.nr_dirtied
>     500007 =C4=85  4%     -27.9%     360465 =C4=85  2%  numa-vmstat.node0=
.nr_written
>    2131472 =C4=85  3%     -21.5%    1673240 =C4=85  3%  numa-vmstat.node0=
.numa_hit
>    2110065 =C4=85  3%     -22.4%    1638077 =C4=85  3%  numa-vmstat.node0=
.numa_local
>     423228 =C4=85  4%     -21.9%     330636 =C4=85  4%  numa-vmstat.node1=
.nr_dirtied
>     405391 =C4=85  4%     -21.9%     316667 =C4=85  4%  numa-vmstat.node1=
.nr_written
>    2099495 =C4=85  4%     -17.1%    1739892 =C4=85  2%  numa-vmstat.node1=
.numa_hit
>    2054537 =C4=85  4%     -16.8%    1708728 =C4=85  2%  numa-vmstat.node1=
.numa_local
>       4262           -16.1%       3575        reaim.jobs_per_min
>      66.61           -16.1%      55.87        reaim.jobs_per_min_child
>       4305           -15.6%       3635        reaim.max_jobs_per_min
>      90.09           +19.2%     107.42        reaim.parent_time
>       1.07 =C4=85  4%     -15.8%       0.90 =C4=85  3%  reaim.std_dev_per=
cent
>     369.06           -10.9%     328.84        reaim.time.elapsed_time
>     369.06           -10.9%     328.84        reaim.time.elapsed_time.max
>      45840          +155.6%     117178        reaim.time.file_system_inpu=
ts
>    5943434           -25.9%    4401353        reaim.time.file_system_outp=
uts
>      18556           -29.3%      13119        reaim.time.involuntary_cont=
ext_switches
>    3738859           -25.0%    2804459        reaim.time.minor_page_fault=
s
>      28.83           -16.8%      24.00        reaim.time.percent_of_cpu_t=
his_job_got
>      93.94           -24.8%      70.62        reaim.time.system_time
>    1061461           -24.9%     797506        reaim.time.voluntary_contex=
t_switches
>      25600           -25.0%      19200        reaim.workload
>     187046            -1.3%     184574        proc-vmstat.nr_active_anon
>     945195           -25.1%     707517        proc-vmstat.nr_dirtied
>    1133127            -1.6%    1115274        proc-vmstat.nr_file_pages
>     214899            -7.1%     199637        proc-vmstat.nr_inactive_fil=
e
>      17745           -14.7%      15145        proc-vmstat.nr_shmem
>     905398           -25.2%     677133        proc-vmstat.nr_written
>     187046            -1.3%     184574        proc-vmstat.nr_zone_active_=
anon
>     214899            -7.1%     199637        proc-vmstat.nr_zone_inactiv=
e_file
>    4233781           -19.3%    3415500        proc-vmstat.numa_hit
>    4167415           -19.6%    3349180        proc-vmstat.numa_local
>    4401990           -19.1%    3559895        proc-vmstat.pgalloc_normal
>    4837041           -21.2%    3813117        proc-vmstat.pgfault
>    4058646           -20.7%    3220351        proc-vmstat.pgfree
>      22920          +155.6%      58589        proc-vmstat.pgpgin
>    6526981           -25.2%    4881946        proc-vmstat.pgpgout
>      48196            -8.6%      44072 =C4=85  3%  proc-vmstat.pgreuse
>       2.95            +0.1        3.06        perf-stat.i.branch-miss-rat=
e%
>    9010149            +3.5%    9323057        perf-stat.i.branch-misses
>   15272312            -6.6%   14260618        perf-stat.i.cache-reference=
s
>       9701           -12.3%       8509        perf-stat.i.context-switche=
s
>       1.97            -1.7%       1.94        perf-stat.i.cpi
>  2.028e+09            -3.4%  1.958e+09        perf-stat.i.cpu-cycles
>     345.48           -12.7%     301.68        perf-stat.i.cpu-migrations
>       1061            +2.2%       1083        perf-stat.i.cycles-between-=
cache-misses
>       0.53            +2.0%       0.54        perf-stat.i.ipc
>       3.86 =C4=85  2%     -20.1%       3.09 =C4=85  3%  perf-stat.i.major=
-faults
>      12520           -11.9%      11027        perf-stat.i.minor-faults
>      12524           -11.9%      11030        perf-stat.i.page-faults
>       3.66            +0.1        3.81        perf-stat.overall.branch-mi=
ss-rate%
>      16.24 =C4=85  5%      +1.2       17.46 =C4=85  6%  perf-stat.overall=
.cache-miss-rate%
>       1.64            -3.2%       1.59        perf-stat.overall.cpi
>       0.61            +3.3%       0.63        perf-stat.overall.ipc
>   17792434           +18.5%   21081619        perf-stat.overall.path-leng=
th
>    8979944            +3.5%    9292382        perf-stat.ps.branch-misses
>   15229067            -6.6%   14216663        perf-stat.ps.cache-referenc=
es
>       9674           -12.3%       8483        perf-stat.ps.context-switch=
es
>  2.022e+09            -3.5%  1.953e+09        perf-stat.ps.cpu-cycles
>     344.62           -12.7%     300.82        perf-stat.ps.cpu-migrations
>       3.85 =C4=85  2%     -20.2%       3.08 =C4=85  4%  perf-stat.ps.majo=
r-faults
>      12486           -12.0%      10993        perf-stat.ps.minor-faults
>      12490           -12.0%      10996        perf-stat.ps.page-faults
>  4.555e+11           -11.1%  4.048e+11        perf-stat.total.instruction=
s
>      24864 =C4=85  2%     -18.6%      20241 =C4=85  6%  sched_debug.cfs_r=
q:/.avg_vruntime.avg
>       9646 =C4=85  3%     -32.1%       6545 =C4=85 11%  sched_debug.cfs_r=
q:/.avg_vruntime.min
>      88.62 =C4=85  7%     +17.8%     104.42 =C4=85  6%  sched_debug.cfs_r=
q:/.load_avg.avg
>     165.70 =C4=85  8%     +21.4%     201.23 =C4=85  6%  sched_debug.cfs_r=
q:/.load_avg.stddev
>      24864 =C4=85  2%     -18.6%      20241 =C4=85  6%  sched_debug.cfs_r=
q:/.min_vruntime.avg
>       9646 =C4=85  3%     -32.1%       6545 =C4=85 11%  sched_debug.cfs_r=
q:/.min_vruntime.min
>       7.59 =C4=85 18%     +40.4%      10.66 =C4=85  7%  sched_debug.cfs_r=
q:/.util_est.avg
>     197.81 =C4=85 13%     +32.3%     261.71 =C4=85 17%  sched_debug.cfs_r=
q:/.util_est.max
>      31.28 =C4=85 12%     +30.3%      40.77 =C4=85 10%  sched_debug.cfs_r=
q:/.util_est.stddev
>     229863           -17.2%     190282 =C4=85  7%  sched_debug.cpu.clock.=
avg
>     229868           -17.2%     190287 =C4=85  7%  sched_debug.cpu.clock.=
max
>     229857           -17.2%     190276 =C4=85  7%  sched_debug.cpu.clock.=
min
>     229303           -17.2%     189808 =C4=85  7%  sched_debug.cpu.clock_=
task.avg
>     229667           -17.2%     190143 =C4=85  7%  sched_debug.cpu.clock_=
task.max
>     219476           -17.8%     180349 =C4=85  7%  sched_debug.cpu.clock_=
task.min
>     749.88 =C4=85 29%     -28.8%     533.95 =C4=85 14%  sched_debug.cpu.c=
urr->pid.avg
>      32645           -29.7%      22956 =C4=85  8%  sched_debug.cpu.curr->=
pid.max
>       4481 =C4=85 10%     -29.9%       3143 =C4=85 10%  sched_debug.cpu.c=
urr->pid.stddev
>      29063           -30.0%      20341 =C4=85  9%  sched_debug.cpu.nr_swi=
tches.avg
>      83586 =C4=85  2%     -29.8%      58716 =C4=85  7%  sched_debug.cpu.n=
r_switches.max
>      22149 =C4=85  2%     -33.0%      14831 =C4=85 11%  sched_debug.cpu.n=
r_switches.min
>       7977 =C4=85  2%     -25.6%       5937 =C4=85  5%  sched_debug.cpu.n=
r_switches.stddev
>      92.43 =C4=85 28%     -47.8%      48.21 =C4=85 10%  sched_debug.cpu.n=
r_uninterruptible.max
>      25.24 =C4=85  8%     -26.2%      18.62 =C4=85  9%  sched_debug.cpu.n=
r_uninterruptible.stddev
>     229859           -17.2%     190278 =C4=85  7%  sched_debug.cpu_clk
>     229148           -17.3%     189567 =C4=85  7%  sched_debug.ktime
>     230484           -17.2%     190908 =C4=85  7%  sched_debug.sched_clk
>       0.00 =C4=85136%    +392.6%       0.02 =C4=85 80%  perf-sched.sch_de=
lay.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
>       0.03 =C4=85114%     -56.9%       0.01 =C4=85  5%  perf-sched.sch_de=
lay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btr=
fs_tree_read_lock_nested
>       0.25 =C4=85209%     -95.1%       0.01 =C4=85 13%  perf-sched.sch_de=
lay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.o=
pen_last_lookups
>       0.21 =C4=85 40%     -38.8%       0.13 =C4=85 11%  perf-sched.sch_de=
lay.max.ms.wait_current_trans.start_transaction.btrfs_attach_transaction_ba=
rrier.btrfs_sync_fs
>       0.07 =C4=85 42%    +126.0%       0.16 =C4=85 72%  perf-sched.sch_de=
lay.max.ms.wait_extent_bit.__lock_extent.lock_extents_for_read.constprop.0
>      26708 =C4=85  2%      -9.5%      24158 =C4=85  3%  perf-sched.total_=
wait_and_delay.count.ms
>       3.20 =C4=85  9%     +25.5%       4.02 =C4=85 11%  perf-sched.wait_a=
nd_delay.avg.ms.btrfs_commit_transaction.iterate_supers.ksys_sync.__x64_sys=
_sync
>       7.26 =C4=85 15%     +50.7%      10.94 =C4=85 19%  perf-sched.wait_a=
nd_delay.avg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_run_ordered_ex=
tent_work.btrfs_work_helper.process_one_work
>      19.16 =C4=85 29%     -65.5%       6.61 =C4=85142%  perf-sched.wait_a=
nd_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_wa=
it_ordered_roots
>       0.02 =C4=85 59%    +188.1%       0.05 =C4=85 63%  perf-sched.wait_a=
nd_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_wr=
ite.sync_inodes_sb
>      15.73 =C4=85 19%     +50.8%      23.72 =C4=85 10%  perf-sched.wait_a=
nd_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_stat=
e.kernel_clone
>     256.17 =C4=85 15%     +34.5%     344.47 =C4=85 13%  perf-sched.wait_a=
nd_delay.avg.ms.wait_current_trans.start_transaction.btrfs_create_common.lo=
okup_open.isra
>      78.54 =C4=85  8%     +18.1%      92.78 =C4=85 11%  perf-sched.wait_a=
nd_delay.avg.ms.wait_for_commit.btrfs_commit_transaction.iterate_supers.ksy=
s_sync
>      67.31 =C4=85  3%     +12.5%      75.72 =C4=85  5%  perf-sched.wait_a=
nd_delay.avg.ms.wait_for_commit.btrfs_wait_for_commit.btrfs_attach_transact=
ion_barrier.btrfs_sync_fs
>     805.00 =C4=85 11%     -21.9%     629.00 =C4=85 11%  perf-sched.wait_a=
nd_delay.count.btrfs_commit_transaction.iterate_supers.ksys_sync.__x64_sys_=
sync
>     833.33 =C4=85  5%     -29.6%     586.50 =C4=85 13%  perf-sched.wait_a=
nd_delay.count.btrfs_start_ordered_extent_nowriteback.btrfs_run_ordered_ext=
ent_work.btrfs_work_helper.process_one_work
>       2990 =C4=85  5%     -16.5%       2498 =C4=85  3%  perf-sched.wait_a=
nd_delay.count.io_schedule.folio_wait_bit_common.folio_wait_writeback.__fil=
emap_fdatawait_range
>     151.17 =C4=85  6%     -70.6%      44.50 =C4=85141%  perf-sched.wait_a=
nd_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_wai=
t_ordered_roots
>     553.50 =C4=85  5%     -26.3%     407.67 =C4=85  9%  perf-sched.wait_a=
nd_delay.count.schedule_timeout.__wait_for_common.btrfs_wait_ordered_extent=
s.btrfs_wait_ordered_roots
>     618.50 =C4=85  9%     -25.4%     461.17 =C4=85 12%  perf-sched.wait_a=
nd_delay.count.wait_current_trans.start_transaction.btrfs_sync_file.btrfs_d=
o_write_iter
>     955.00 =C4=85  8%     -27.5%     692.17 =C4=85  8%  perf-sched.wait_a=
nd_delay.count.wait_log_commit.btrfs_sync_log.btrfs_sync_file.btrfs_do_writ=
e_iter
>     551.40 =C4=85 10%     +33.8%     737.66 =C4=85  8%  perf-sched.wait_a=
nd_delay.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__fi=
lemap_fdatawait_range
>     251.59 =C4=85 18%     +74.5%     438.99 =C4=85 14%  perf-sched.wait_a=
nd_delay.max.ms.wait_current_trans.start_transaction.btrfs_attach_transacti=
on_barrier.btrfs_sync_fs
>      11.70 =C4=85 99%    -100.0%       0.00 =C4=85223%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.btree_write_cache_pages.do_writepages.filemap_fda=
tawrite_wbc.__filemap_fdatawrite_range
>      44.61 =C4=85189%    +762.7%     384.84 =C4=85 81%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mm=
ap
>       3.19 =C4=85  9%     +25.6%       4.00 =C4=85 11%  perf-sched.wait_t=
ime.avg.ms.btrfs_commit_transaction.iterate_supers.ksys_sync.__x64_sys_sync
>       7.24 =C4=85 15%     +50.9%      10.93 =C4=85 19%  perf-sched.wait_t=
ime.avg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_run_ordered_extent_=
work.btrfs_work_helper.process_one_work
>       1.69 =C4=85 79%    +178.9%       4.71 =C4=85 62%  perf-sched.wait_t=
ime.avg.ms.io_schedule.folio_wait_bit_common.extent_write_cache_pages.btrfs=
_writepages
>      15.72 =C4=85 19%     +50.9%      23.71 =C4=85 10%  perf-sched.wait_t=
ime.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.ker=
nel_clone
>      20.99 =C4=85  2%     +38.2%      29.02 =C4=85 15%  perf-sched.wait_t=
ime.avg.ms.schedule_timeout.btrfs_sync_log.btrfs_sync_file.btrfs_do_write_i=
ter
>      12.97 =C4=85 13%     +49.0%      19.32 =C4=85 16%  perf-sched.wait_t=
ime.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.barrier_a=
ll_devices
>     256.15 =C4=85 15%     +34.5%     344.45 =C4=85 13%  perf-sched.wait_t=
ime.avg.ms.wait_current_trans.start_transaction.btrfs_create_common.lookup_=
open.isra
>      10.94 =C4=85 25%     +84.6%      20.19 =C4=85 24%  perf-sched.wait_t=
ime.avg.ms.wait_extent_bit.__lock_extent.lock_and_cleanup_extent_if_need.co=
py_one_range
>      78.51 =C4=85  8%     +18.1%      92.75 =C4=85 11%  perf-sched.wait_t=
ime.avg.ms.wait_for_commit.btrfs_commit_transaction.iterate_supers.ksys_syn=
c
>      67.26 =C4=85  3%     +12.5%      75.66 =C4=85  5%  perf-sched.wait_t=
ime.avg.ms.wait_for_commit.btrfs_wait_for_commit.btrfs_attach_transaction_b=
arrier.btrfs_sync_fs
>      19.50 =C4=85128%    -100.0%       0.00 =C4=85223%  perf-sched.wait_t=
ime.max.ms.__cond_resched.btree_write_cache_pages.do_writepages.filemap_fda=
tawrite_wbc.__filemap_fdatawrite_range
>      83.75 =C4=85187%    +516.6%     516.38 =C4=85 68%  perf-sched.wait_t=
ime.max.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mm=
ap
>     551.39 =C4=85 10%     +33.8%     737.64 =C4=85  8%  perf-sched.wait_t=
ime.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap=
_fdatawait_range
>     251.57 =C4=85 18%     +74.5%     438.95 =C4=85 14%  perf-sched.wait_t=
ime.max.ms.wait_current_trans.start_transaction.btrfs_attach_transaction_ba=
rrier.btrfs_sync_fs
>      86.74 =C4=85 14%     -27.4%      62.97 =C4=85 11%  perf-sched.wait_t=
ime.max.ms.wait_extent_bit.__lock_extent.lock_and_cleanup_extent_if_need.co=
py_one_range
>
>
> *************************************************************************=
**************************
> lkp-ivb-d01: 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz=
 (Ivy Bridge) with 16G memory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/disk/fs/kconfig/nr_task/rootfs/runtime/tbox_gro=
up/test/testcase:
>   gcc-12/performance/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-202=
40206.cgz/300s/lkp-ivb-d01/disk/reaim
>
> commit:
>   cbfb4cbf45 ("btrfs: update comment for try_release_extent_state()")
>   32c523c578 ("btrfs: allow folios to be released while ordered extent is=
 finishing")
>
> cbfb4cbf459d9be4 32c523c578e8489f55663ce8a88
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>      22777          +101.6%      45913 =C4=85 13%  proc-vmstat.pgpgin
>      12134 =C4=85  4%     +18.9%      14426 =C4=85  7%  sched_debug.cpu.n=
r_switches.stddev
>      80.30            -1.8%      78.89        iostat.cpu.idle
>      17.77            +8.1%      19.21        iostat.cpu.iowait
>      54.02          +101.9%     109.06        vmstat.io.bi
>       4061            -5.0%       3856        vmstat.io.bo
>       2.60            +2.2%       2.65        reaim.child_systime
>     348.91            -5.3%     330.27        reaim.jobs_per_min
>      43.61            -5.3%      41.28        reaim.jobs_per_min_child
>     356.27            -5.4%     336.88        reaim.max_jobs_per_min
>     137.64            +5.6%     145.41        reaim.parent_time
>      45554          +101.6%      91826 =C4=85 13%  reaim.time.file_system=
_inputs
>       0.17 =C4=85 25%      -0.1        0.09 =C4=85 31%  perf-profile.chil=
dren.cycles-pp.select_task_rq_fair
>       0.16 =C4=85 29%      -0.1        0.10 =C4=85 33%  perf-profile.chil=
dren.cycles-pp.vfs_fstatat
>       0.21 =C4=85 16%      -0.1        0.15 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.___perf_sw_event
>       0.06 =C4=85 79%      +0.1        0.16 =C4=85 33%  perf-profile.chil=
dren.cycles-pp.vms_complete_munmap_vmas
>       0.07 =C4=85 72%      +0.1        0.18 =C4=85 16%  perf-profile.chil=
dren.cycles-pp.vms_clear_ptes
>       0.19 =C4=85 18%      -0.1        0.12 =C4=85 19%  perf-profile.self=
.cycles-pp.___perf_sw_event
>       0.15 =C4=85 30%      +0.1        0.23 =C4=85 33%  perf-profile.self=
.cycles-pp.x86_pmu_disable
>       0.04 =C4=85  9%     +21.8%       0.05 =C4=85 11%  perf-sched.sch_de=
lay.avg.ms.__cond_resched.__wait_for_common.barrier_all_devices.write_all_s=
upers.btrfs_sync_log
>       0.05 =C4=85  4%     +18.7%       0.06 =C4=85  4%  perf-sched.sch_de=
lay.avg.ms.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_sync_lo=
g
>       0.04 =C4=85 69%    -100.0%       0.00        perf-sched.sch_delay.a=
vg.ms.wait_extent_bit.__lock_extent.lock_and_cleanup_extent_if_need.copy_on=
e_range
>       0.05 =C4=85 69%    -100.0%       0.00        perf-sched.sch_delay.m=
ax.ms.wait_extent_bit.__lock_extent.lock_and_cleanup_extent_if_need.copy_on=
e_range
>      19.30 =C4=85  9%     +17.0%      22.59 =C4=85  6%  perf-sched.wait_a=
nd_delay.avg.ms.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_sy=
nc_log
>      19.25 =C4=85  9%     +17.0%      22.53 =C4=85  6%  perf-sched.wait_t=
ime.avg.ms.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_sync_lo=
g
>      15.74 =C4=85107%    -100.0%       0.00        perf-sched.wait_time.a=
vg.ms.wait_extent_bit.__lock_extent.lock_and_cleanup_extent_if_need.copy_on=
e_range
>      22.16 =C4=85 79%    -100.0%       0.00        perf-sched.wait_time.m=
ax.ms.wait_extent_bit.__lock_extent.lock_and_cleanup_extent_if_need.copy_on=
e_range
>       4.44            +1.9%       4.53        perf-stat.i.MPKI
>       8.16            +0.2        8.41        perf-stat.i.branch-miss-rat=
e%
>       2313            +1.6%       2350        perf-stat.i.context-switche=
s
>       2.25            +1.9%       2.29        perf-stat.i.cpi
>      73.48 =C4=85  3%      -6.6%      68.61        perf-stat.i.cpu-migrat=
ions
>       1972            -2.1%       1931        perf-stat.i.minor-faults
>       1972            -2.1%       1931        perf-stat.i.page-faults
>       2308            +1.6%       2344        perf-stat.ps.context-switch=
es
>      73.31 =C4=85  3%      -6.6%      68.45        perf-stat.ps.cpu-migra=
tions
>       1967            -2.1%       1926        perf-stat.ps.minor-faults
>       1968            -2.1%       1926        perf-stat.ps.page-faults
>
>
>
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are prov=
ided
> for informational purposes only. Any difference in system hardware or sof=
tware
> design or configuration may affect actual performance.
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>

