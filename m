Return-Path: <linux-btrfs+bounces-14580-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7D6AD33CC
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 12:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5FB16D9C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 10:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9792228C87D;
	Tue, 10 Jun 2025 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeFdS/k6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDA828BA9A;
	Tue, 10 Jun 2025 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749551869; cv=none; b=FRS4HQWsdJ6qzHvhG4WBghIoEVvQoa8GWNs5UfX0vmOupSmW5WNtQkWxkdRZzQBLvjlv3oKIudvGgblJpowOFSDB2cn31fUJPSWFN4ww+J2g6MYU9hY1997aHCCDA05b5O3/bHUcJ/w88fNOJJJk9Cfg4j4WwJ0aZSMVe58oT9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749551869; c=relaxed/simple;
	bh=++aU2InB6SiZJTucJS6EQT6VGNkE2jTnTSY2DlMvFLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NqMjE+eXz+H/DQ0XaM1nIuJ29zu4rTkrgqdjfrZsU0JciuicmL7EcEq8iarszHDtTO4xzWTTNFKAPMps+KxfKC1f2ANEaNKXyM3kgBAAX07W/PAKj4FadnRLQ4FtmLWTXTDwYdfbWiMYWIlWLXFF1GqxyVosEQO56TZXzy/auCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeFdS/k6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31189C4CEEF;
	Tue, 10 Jun 2025 10:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749551869;
	bh=++aU2InB6SiZJTucJS6EQT6VGNkE2jTnTSY2DlMvFLU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OeFdS/k6ya5dU/xwBvy3W5gaveA2wJJtLwSmkcNkFKzfBImK2sri2SFLwWG9W/i8z
	 sOF40bC7P4UJ58t8SU3RKXn9ooXqiFWEK/dDONqaPd//zYVqKvbWo1TKMDmibWqMy5
	 L2l/EKHphQg+vZRKwIeWfQVIQhkJ0Qvjh2FOAerYh+XsNWG+allr7GuBUFtGaGwOOt
	 +FQEsDpxPPCR2c9v0OSYuTLG+TYXTgWYiJavXEQxyM20Nnkt9B/HolNl1FupwUHIKZ
	 2G5wkHI7ofY47atxZmU/xeLrEnj+rwPUeKzk7Gm2XXNFNXXQJ5lJVgvt9axq/hlPIP
	 6PZ0LKhhYmXww==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-adb2bb25105so841816866b.0;
        Tue, 10 Jun 2025 03:37:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUj3efMsD6lFUt+aWIcCSUH2BPscJ3dld5cYdTHDUt+66/TUNc9J9fh0qeGqk5m/Ml+7YTn+HnHQ7LoHg==@vger.kernel.org, AJvYcCXFm3xfIty1+AgjXT/b9pZ7JYkdYqoc/5xeCDpqYaeC1orUXKlC+rYa3hy2jZS/5/rGwM0qoyDm/XyZDxYm@vger.kernel.org
X-Gm-Message-State: AOJu0YyxBqmcc4iHDoI1NPPfUfSb459tb5gB3ZFsBozIM65wBbL5DxUh
	asxGFBnaIvlFlZU4mequCL0U//CKOze4Bh89WLyzNRpvbpWQWkg7zjQm1HyzNCyGe7waLDtvzG9
	+R7PacS62f4NSTjbM+fdydA+pipotf80=
X-Google-Smtp-Source: AGHT+IGHUIjT5eklknt4Iq55pB0ZIJQqxcD2QWN25olYdFLPSvtu6G6eN8Wa1TRfA/xZtUA4PBiRtvBXe6DdOGXAN60=
X-Received: by 2002:a17:907:c22:b0:ad8:87a0:62aa with SMTP id
 a640c23a62f3a-ade1aab90f1mr1682968166b.27.1749551867598; Tue, 10 Jun 2025
 03:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202506101357.7ada85f6-lkp@intel.com>
In-Reply-To: <202506101357.7ada85f6-lkp@intel.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 10 Jun 2025 11:37:10 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5XJbK-mscTqKbUJwrbKNR0mCjCOHjTigNWVCFupKt=Vw@mail.gmail.com>
X-Gm-Features: AX0GCFu1xH6C4qRFXcL-FZ3FOQfr698F7q-fhZ7z8AgMpzXcSAirIaBuc-u0s_k
Message-ID: <CAL3q7H5XJbK-mscTqKbUJwrbKNR0mCjCOHjTigNWVCFupKt=Vw@mail.gmail.com>
Subject: Re: [linus:master] [btrfs] 5e85262e54: stress-ng.fallocate.ops_per_sec
 40.7% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: Filipe Manana <fdmanana@suse.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>, 
	Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 7:05=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed a 40.7% regression of stress-ng.fallocate.ops_p=
er_sec on:
>
>
> commit: 5e85262e542d6da8898bb8563a724ad98f6fc936 ("btrfs: fix fsync of fi=
les with no hard links not persisting deletion")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

This is expected. Before an fsync of a file with 0 links did nothing,
now it logs the inode and syncs the log.

Back in 2019 I made the fsync of files with 0 links do nothing and you
reported a +12461.6% gain for this test:

https://lore.kernel.org/all/20191027045312.GE29418@shao2-debian/

It was a correct change from the point of view of O_TMPFILE files, but
otherwise incorrect for non O_TMPFILE files.
But even the case fixed recently by 5e85262e542d ("btrfs: fix fsync of
files with no hard links not persisting deletion") did not work back
then, due to missing the flushing of the delayed inode.

So nothing unexpected here.


>
> [still regression on linus/master      4cb6c8af8591135ec000fbe4bb474139ce=
ec595d]
> [still regression on linux-next/master 3a83b350b5be4b4f6bd895eecf9a920802=
00ee5d]
>
> testcase: stress-ng
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ =
2.60GHz (Ice Lake) with 128G memory
> parameters:
>
>         nr_threads: 100%
>         disk: 1HDD
>         testtime: 60s
>         fs: btrfs
>         test: fallocate
>         cpufreq_governor: performance
>
>
> In addition to that, the commit also has significant impact on the follow=
ing tests:
>
> +------------------+-----------------------------------------------------=
-------------------------------------------+
> | testcase: change | stress-ng: stress-ng.copy-file.ops_per_sec  33.6% re=
gression                                   |
> | test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358=
 CPU @ 2.60GHz (Ice Lake) with 128G memory |
> | test parameters  | cpufreq_governor=3Dperformance                      =
                                             |
> |                  | disk=3D1HDD                                         =
                                             |
> |                  | fs=3Dbtrfs                                          =
                                             |
> |                  | nr_threads=3D100%                                   =
                                             |
> |                  | test=3Dcopy-file                                    =
                                             |
> |                  | testtime=3D60s                                      =
                                             |
> +------------------+-----------------------------------------------------=
-------------------------------------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202506101357.7ada85f6-lkp@intel.=
com
>
>
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250610/202506101357.7ada85f6-lk=
p@intel.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/te=
st/testcase/testtime:
>   gcc-12/performance/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-202=
40206.cgz/lkp-icl-2sp4/fallocate/stress-ng/60s
>
> commit:
>   846b534075 ("btrfs: fix typo in space info explanation")
>   5e85262e54 ("btrfs: fix fsync of files with no hard links not persistin=
g deletion")
>
> 846b534075f45d5b 5e85262e542d6da8898bb8563a7
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>       6816 =C4=85  3%     +54.4%      10526 =C4=85  4%  uptime.idle
>  8.564e+09            -8.8%  7.813e+09        cpuidle..time
>     358855 =C4=85  2%     +40.2%     503142        cpuidle..usage
>      36.53            +3.3%      37.75        boot-time.boot
>      27.16            +3.6%      28.15        boot-time.dhcp
>       4346            +3.3%       4489        boot-time.idle
>      26.69 =C4=85  8%    +173.5%      72.99 =C4=85  8%  iostat.cpu.idle
>      72.51 =C4=85  3%     -65.0%      25.36 =C4=85 22%  iostat.cpu.iowait
>       0.47 =C4=85  4%    +170.8%       1.27 =C4=85 17%  iostat.cpu.system
>    1260573 =C4=85  8%     -36.7%     798065 =C4=85  4%  numa-numastat.nod=
e0.local_node
>    1333347 =C4=85  7%     -35.6%     859241 =C4=85  5%  numa-numastat.nod=
e0.numa_hit
>    1310625 =C4=85  8%     -43.1%     745116 =C4=85  4%  numa-numastat.nod=
e1.local_node
>    1370277 =C4=85  7%     -40.4%     816368 =C4=85  5%  numa-numastat.nod=
e1.numa_hit
>      72.60 =C4=85 10%     -36.6%      46.00 =C4=85 22%  perf-c2c.DRAM.loc=
al
>      76.80 =C4=85 11%    +328.5%     329.10 =C4=85 30%  perf-c2c.DRAM.rem=
ote
>      36.50 =C4=85 19%    +864.1%     351.90 =C4=85 29%  perf-c2c.HITM.loc=
al
>      31.00 =C4=85 15%    +522.3%     192.90 =C4=85 31%  perf-c2c.HITM.rem=
ote
>    4718134           -11.1%    4195454        meminfo.Cached
>     325934           -84.9%      49200 =C4=85 24%  meminfo.Dirty
>     977794           -54.8%     442223 =C4=85 15%  meminfo.Inactive
>     977794           -54.8%     442223 =C4=85 15%  meminfo.Inactive(file)
>     114582           +16.1%     133034        meminfo.Shmem
>     414480           -53.3%     193720 =C4=85 23%  meminfo.Writeback
>      26.65 =C4=85  8%    +173.9%      72.98 =C4=85  8%  vmstat.cpu.id
>      72.54 =C4=85  3%     -64.9%      25.47 =C4=85 23%  vmstat.cpu.wa
>     107799           -37.1%      67824        vmstat.io.bo
>     117.81           -72.1%      32.92 =C4=85 23%  vmstat.procs.b
>       3650 =C4=85  2%     +78.2%       6506        vmstat.system.cs
>       6900 =C4=85  3%     +70.7%      11777 =C4=85  7%  vmstat.system.in
>      24.55 =C4=85  9%     +47.7       72.22 =C4=85  8%  mpstat.cpu.all.id=
le%
>      74.66 =C4=85  3%     -48.5       26.12 =C4=85 22%  mpstat.cpu.all.io=
wait%
>       0.02 =C4=85  5%      +0.0        0.03 =C4=85  4%  mpstat.cpu.all.ir=
q%
>       0.02 =C4=85  2%      +0.0        0.03 =C4=85  5%  mpstat.cpu.all.so=
ft%
>       0.41 =C4=85  5%      +0.8        1.22 =C4=85 18%  mpstat.cpu.all.sy=
s%
>       0.34            +0.0        0.38 =C4=85  2%  mpstat.cpu.all.usr%
>       2.00          +445.0%      10.90 =C4=85 59%  mpstat.max_utilization=
.seconds
>     158860 =C4=85  7%     -85.3%      23387 =C4=85 26%  numa-meminfo.node=
0.Dirty
>     474882 =C4=85  5%     -52.9%     223821 =C4=85 14%  numa-meminfo.node=
0.Inactive
>     474882 =C4=85  5%     -52.9%     223821 =C4=85 14%  numa-meminfo.node=
0.Inactive(file)
>     201670 =C4=85  5%     -52.3%      96112 =C4=85 20%  numa-meminfo.node=
0.Writeback
>     166889 =C4=85  6%     -84.6%      25642 =C4=85 28%  numa-meminfo.node=
1.Dirty
>     502047 =C4=85  5%     -56.4%     218867 =C4=85 17%  numa-meminfo.node=
1.Inactive
>     502047 =C4=85  5%     -56.4%     218867 =C4=85 17%  numa-meminfo.node=
1.Inactive(file)
>     212352 =C4=85  5%     -54.0%      97712 =C4=85 29%  numa-meminfo.node=
1.Writeback
>     906.60           -43.5%     512.00        stress-ng.fallocate.ops
>      14.30           -40.7%       8.48        stress-ng.fallocate.ops_per=
_sec
>      65.75            -8.0%      60.48        stress-ng.time.elapsed_time
>      65.75            -8.0%      60.48        stress-ng.time.elapsed_time=
.max
>   14854172           -42.8%    8502297        stress-ng.time.file_system_=
outputs
>     750.40 =C4=85  5%    +130.1%       1727 =C4=85  9%  stress-ng.time.in=
voluntary_context_switches
>      40.40 =C4=85  6%    +263.4%     146.80 =C4=85 20%  stress-ng.time.pe=
rcent_of_cpu_this_job_got
>      26.79 =C4=85  6%    +231.8%      88.89 =C4=85 20%  stress-ng.time.sy=
stem_time
>      46451 =C4=85  4%    +190.9%     135122 =C4=85  2%  stress-ng.time.vo=
luntary_context_switches
>     197148            +2.7%     202432        proc-vmstat.nr_active_anon
>    1859510           -42.8%    1064284        proc-vmstat.nr_dirtied
>      81387           -84.9%      12287 =C4=85 26%  proc-vmstat.nr_dirty
>    1179517           -11.0%    1049203        proc-vmstat.nr_file_pages
>     244166           -54.7%     110697 =C4=85 15%  proc-vmstat.nr_inactiv=
e_file
>      43062            +1.4%      43664        proc-vmstat.nr_mapped
>      28656           +15.9%      33198        proc-vmstat.nr_shmem
>     103481 =C4=85  2%     -53.2%      48448 =C4=85 23%  proc-vmstat.nr_wr=
iteback
>    1855961           -42.8%    1062406        proc-vmstat.nr_written
>     197148            +2.7%     202432        proc-vmstat.nr_zone_active_=
anon
>     244166           -54.7%     110697 =C4=85 15%  proc-vmstat.nr_zone_in=
active_file
>     184834           -67.1%      60733 =C4=85 23%  proc-vmstat.nr_zone_wr=
ite_pending
>    2705223           -38.0%    1677261        proc-vmstat.numa_hit
>    2572798           -40.0%    1544833        proc-vmstat.numa_local
>    2754538           -37.3%    1726600        proc-vmstat.pgalloc_normal
>    2722111           -39.5%    1645913 =C4=85  3%  proc-vmstat.pgfree
>    7427330           -42.0%    4306316        proc-vmstat.pgpgout
>     908534 =C4=85  5%     -40.5%     540322        numa-vmstat.node0.nr_d=
irtied
>      39714 =C4=85  7%     -85.3%       5835 =C4=85 26%  numa-vmstat.node0=
.nr_dirty
>     118740 =C4=85  5%     -52.7%      56112 =C4=85 14%  numa-vmstat.node0=
.nr_inactive_file
>      50433 =C4=85  5%     -52.3%      24033 =C4=85 20%  numa-vmstat.node0=
.nr_writeback
>     906619 =C4=85  5%     -40.5%     539353        numa-vmstat.node0.nr_w=
ritten
>     118740 =C4=85  5%     -52.7%      56112 =C4=85 14%  numa-vmstat.node0=
.nr_zone_inactive_file
>      90132 =C4=85  5%     -66.9%      29866 =C4=85 21%  numa-vmstat.node0=
.nr_zone_write_pending
>    1333077 =C4=85  7%     -35.5%     859486 =C4=85  5%  numa-vmstat.node0=
.numa_hit
>    1260303 =C4=85  8%     -36.7%     798310 =C4=85  4%  numa-vmstat.node0=
.numa_local
>     950974 =C4=85  5%     -44.9%     523966        numa-vmstat.node1.nr_d=
irtied
>      41787 =C4=85  6%     -84.6%       6454 =C4=85 29%  numa-vmstat.node1=
.nr_dirty
>     125464 =C4=85  5%     -56.2%      55001 =C4=85 17%  numa-vmstat.node1=
.nr_inactive_file
>      52957 =C4=85  5%     -53.9%      24413 =C4=85 29%  numa-vmstat.node1=
.nr_writeback
>     948799 =C4=85  5%     -44.9%     523041        numa-vmstat.node1.nr_w=
ritten
>     125464 =C4=85  5%     -56.2%      55001 =C4=85 17%  numa-vmstat.node1=
.nr_zone_inactive_file
>      94729 =C4=85  5%     -67.4%      30867 =C4=85 28%  numa-vmstat.node1=
.nr_zone_write_pending
>    1369690 =C4=85  7%     -40.4%     815898 =C4=85  5%  numa-vmstat.node1=
.numa_hit
>    1310039 =C4=85  8%     -43.2%     744646 =C4=85  4%  numa-vmstat.node1=
.numa_local
>       2.21            -8.8%       2.02 =C4=85  4%  perf-stat.i.MPKI
>    6.4e+08           +15.0%  7.358e+08 =C4=85  3%  perf-stat.i.branch-ins=
tructions
>       2.82            +0.9        3.76        perf-stat.i.branch-miss-rat=
e%
>   28372748           +15.8%   32852598        perf-stat.i.branch-misses
>      13.29            -3.9        9.40 =C4=85  2%  perf-stat.i.cache-miss=
-rate%
>   22292540           +32.9%   29636364        perf-stat.i.cache-reference=
s
>       3470           +84.5%       6402        perf-stat.i.context-switche=
s
>       0.96          +106.4%       1.99 =C4=85  4%  perf-stat.i.cpi
>  3.473e+09 =C4=85  2%    +100.3%  6.957e+09 =C4=85 14%  perf-stat.i.cpu-c=
ycles
>     176.57           +32.0%     233.00 =C4=85  2%  perf-stat.i.cpu-migrat=
ions
>     885.32 =C4=85  3%    +109.0%       1850 =C4=85  8%  perf-stat.i.cycle=
s-between-cache-misses
>  3.127e+09           +13.2%  3.541e+09 =C4=85  3%  perf-stat.i.instructio=
ns
>       1.17           -32.0%       0.79        perf-stat.i.ipc
>       4118            +6.8%       4398        perf-stat.i.minor-faults
>       4118            +6.8%       4398        perf-stat.i.page-faults
>       0.96            -7.9%       0.88 =C4=85  3%  perf-stat.overall.MPKI
>      13.47            -2.9       10.56 =C4=85  2%  perf-stat.overall.cach=
e-miss-rate%
>       1.11 =C4=85  2%     +77.0%       1.96 =C4=85 11%  perf-stat.overall=
.cpi
>       1153 =C4=85  2%     +92.8%       2225 =C4=85 13%  perf-stat.overall=
.cycles-between-cache-misses
>       0.90 =C4=85  2%     -42.8%       0.52 =C4=85 11%  perf-stat.overall=
.ipc
>  6.293e+08           +14.9%  7.231e+08 =C4=85  3%  perf-stat.ps.branch-in=
structions
>   27913642           +15.6%   32280223        perf-stat.ps.branch-misses
>   21928606           +32.8%   29130512        perf-stat.ps.cache-referenc=
es
>       3413           +84.3%       6292        perf-stat.ps.context-switch=
es
>  3.407e+09 =C4=85  2%    +100.9%  6.847e+09 =C4=85 14%  perf-stat.ps.cpu-=
cycles
>     173.70           +31.8%     229.01 =C4=85  2%  perf-stat.ps.cpu-migra=
tions
>  3.075e+09           +13.2%   3.48e+09 =C4=85  3%  perf-stat.ps.instructi=
ons
>       4028            +6.6%       4295        perf-stat.ps.minor-faults
>       4028            +6.6%       4295        perf-stat.ps.page-faults
>       0.04 =C4=85 56%    -100.0%       0.00        perf-sched.sch_delay.a=
vg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_ext=
ent_bit.btrfs_dirty_folio
>       0.09 =C4=85 10%     -90.6%       0.01 =C4=85299%  perf-sched.sch_de=
lay.avg.ms.__cond_resched.submit_bio_noacct.btrfs_submit_chunk.btrfs_submit=
_bbio.submit_one_bio
>       0.17 =C4=85 33%    -100.0%       0.00        perf-sched.sch_delay.a=
vg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs=
_sync_file.do_fsync
>       0.03 =C4=85 53%    +311.8%       0.11 =C4=85  3%  perf-sched.sch_de=
lay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btr=
fs_tree_read_lock_nested
>       0.01 =C4=85286%   +1043.8%       0.11 =C4=85  2%  perf-sched.sch_de=
lay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.b=
trfs_tree_lock_nested
>       0.12 =C4=85 15%     -91.4%       0.01 =C4=85300%  perf-sched.sch_de=
lay.max.ms.__cond_resched.extent_write_cache_pages.btrfs_writepages.do_writ=
epages.filemap_fdatawrite_wbc
>       0.07 =C4=85 51%    -100.0%       0.00        perf-sched.sch_delay.m=
ax.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_ext=
ent_bit.btrfs_dirty_folio
>       0.14 =C4=85 24%     -93.7%       0.01 =C4=85299%  perf-sched.sch_de=
lay.max.ms.__cond_resched.submit_bio_noacct.btrfs_submit_chunk.btrfs_submit=
_bbio.submit_one_bio
>       0.91 =C4=85 29%    -100.0%       0.00        perf-sched.sch_delay.m=
ax.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs=
_sync_file.do_fsync
>       0.09 =C4=85 46%   +3267.9%       3.02 =C4=85230%  perf-sched.sch_de=
lay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btr=
fs_tree_read_lock_nested
>       0.01 =C4=85277%   +6419.2%       0.65 =C4=85123%  perf-sched.sch_de=
lay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.b=
trfs_tree_lock_nested
>       0.18 =C4=85 11%     +40.1%       0.25 =C4=85 13%  perf-sched.sch_de=
lay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>     311.05 =C4=85  4%     -79.9%      62.61 =C4=85  2%  perf-sched.total_=
wait_and_delay.average.ms
>       6694 =C4=85  3%    +331.4%      28884 =C4=85  2%  perf-sched.total_=
wait_and_delay.count.ms
>     310.98 =C4=85  4%     -79.9%      62.51 =C4=85  2%  perf-sched.total_=
wait_time.average.ms
>     258.61 =C4=85 12%    -100.0%       0.00        perf-sched.wait_and_de=
lay.avg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.=
btrfs_sync_file.do_fsync
>      31.59 =C4=85  7%    -100.0%       0.00        perf-sched.wait_and_de=
lay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_=
call
>       0.25 =C4=85  8%    -100.0%       0.00        perf-sched.wait_and_de=
lay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e
>     517.55 =C4=85  4%    -100.0%       0.00        perf-sched.wait_and_de=
lay.avg.ms.io_schedule.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit=
_bio
>      61.81 =C4=85 21%     -96.4%       2.24 =C4=85 62%  perf-sched.wait_a=
nd_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__fi=
lemap_fdatawait_range
>       4.06          -100.0%       0.00        perf-sched.wait_and_delay.a=
vg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
>       0.85 =C4=85  4%    -100.0%       0.00        perf-sched.wait_and_de=
lay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.ker=
nel_clone
>      16.81 =C4=85  7%     -40.1%      10.06 =C4=85  5%  perf-sched.wait_a=
nd_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       0.08 =C4=85  7%    -100.0%       0.00        perf-sched.wait_and_de=
lay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
>      71.10 =C4=85  7%    -100.0%       0.00        perf-sched.wait_and_de=
lay.count.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.b=
trfs_sync_file.do_fsync
>     124.00          -100.0%       0.00        perf-sched.wait_and_delay.c=
ount.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
>      93.80 =C4=85  3%    -100.0%       0.00        perf-sched.wait_and_de=
lay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
>     816.00 =C4=85  3%    -100.0%       0.00        perf-sched.wait_and_de=
lay.count.io_schedule.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit_=
bio
>     896.30 =C4=85 20%     -53.8%     414.40 =C4=85 31%  perf-sched.wait_a=
nd_delay.count.io_schedule.folio_wait_bit_common.folio_wait_writeback.__fil=
emap_fdatawait_range
>      44.40 =C4=85 10%    -100.0%       0.00        perf-sched.wait_and_de=
lay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
>      87.00          -100.0%       0.00        perf-sched.wait_and_delay.c=
ount.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_cl=
one
>     283.50 =C4=85  6%     +59.7%     452.70 =C4=85  4%  perf-sched.wait_a=
nd_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>      36.00          -100.0%       0.00        perf-sched.wait_and_delay.c=
ount.wait_for_partner.fifo_open.do_dentry_open.vfs_open
>       2195 =C4=85  2%     -42.3%       1266 =C4=85  6%  perf-sched.wait_a=
nd_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       1312 =C4=85 25%    -100.0%       0.00        perf-sched.wait_and_de=
lay.max.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.=
btrfs_sync_file.do_fsync
>       1503 =C4=85 32%    -100.0%       0.00        perf-sched.wait_and_de=
lay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_=
call
>       0.93 =C4=85 21%    -100.0%       0.00        perf-sched.wait_and_de=
lay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e
>       1775 =C4=85 14%    -100.0%       0.00        perf-sched.wait_and_de=
lay.max.ms.io_schedule.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit=
_bio
>       1699 =C4=85 13%     -92.7%     123.85 =C4=85 56%  perf-sched.wait_a=
nd_delay.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__fi=
lemap_fdatawait_range
>       5.24 =C4=85 32%    -100.0%       0.00        perf-sched.wait_and_de=
lay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
>       1.94 =C4=85  9%    -100.0%       0.00        perf-sched.wait_and_de=
lay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.ker=
nel_clone
>       0.18 =C4=85 18%    -100.0%       0.00        perf-sched.wait_and_de=
lay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
>     520.63 =C4=85 38%     -99.6%       2.04 =C4=85300%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.extent_write_cache_pages.btrfs_writepages.do_writ=
epages.filemap_fdatawrite_wbc
>      12.11 =C4=85297%    -100.0%       0.00        perf-sched.wait_time.a=
vg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_ext=
ent_bit.btrfs_dirty_folio
>     550.61 =C4=85 26%     -99.8%       0.86 =C4=85300%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.submit_bio_noacct.btrfs_submit_chunk.btrfs_submit=
_bbio.submit_one_bio
>     258.43 =C4=85 12%    -100.0%       0.00        perf-sched.wait_time.a=
vg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs=
_sync_file.do_fsync
>     517.46 =C4=85  4%     -98.8%       6.46 =C4=85116%  perf-sched.wait_t=
ime.avg.ms.io_schedule.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit=
_bio
>      61.80 =C4=85 21%     -96.4%       2.22 =C4=85 62%  perf-sched.wait_t=
ime.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap=
_fdatawait_range
>       6.98 =C4=85198%    +503.0%      42.09 =C4=85  4%  perf-sched.wait_t=
ime.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btr=
fs_tree_read_lock_nested
>       0.11 =C4=85298%   +5798.7%       6.59 =C4=85 16%  perf-sched.wait_t=
ime.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.b=
trfs_tree_lock_nested
>      16.72 =C4=85  7%     -40.3%       9.98 =C4=85  5%  perf-sched.wait_t=
ime.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       1160 =C4=85 36%     -99.8%       2.04 =C4=85300%  perf-sched.wait_t=
ime.max.ms.__cond_resched.extent_write_cache_pages.btrfs_writepages.do_writ=
epages.filemap_fdatawrite_wbc
>      36.11 =C4=85298%    -100.0%       0.00        perf-sched.wait_time.m=
ax.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_ext=
ent_bit.btrfs_dirty_folio
>       1344 =C4=85 25%     -99.9%       0.86 =C4=85300%  perf-sched.wait_t=
ime.max.ms.__cond_resched.submit_bio_noacct.btrfs_submit_chunk.btrfs_submit=
_bbio.submit_one_bio
>       1312 =C4=85 25%    -100.0%       0.00        perf-sched.wait_time.m=
ax.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs=
_sync_file.do_fsync
>       1775 =C4=85 14%     -96.5%      62.99 =C4=85153%  perf-sched.wait_t=
ime.max.ms.io_schedule.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit=
_bio
>       1699 =C4=85 13%     -92.7%     123.76 =C4=85 56%  perf-sched.wait_t=
ime.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap=
_fdatawait_range
>      87.05 =C4=85203%    +562.4%     576.63 =C4=85 58%  perf-sched.wait_t=
ime.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btr=
fs_tree_read_lock_nested
>       0.11 =C4=85297%  +2.5e+05%     276.17 =C4=85 46%  perf-sched.wait_t=
ime.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.b=
trfs_tree_lock_nested
>
>
> *************************************************************************=
**************************
> lkp-icl-2sp4: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ =
2.60GHz (Ice Lake) with 128G memory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/te=
st/testcase/testtime:
>   gcc-12/performance/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-202=
40206.cgz/lkp-icl-2sp4/copy-file/stress-ng/60s
>
> commit:
>   846b534075 ("btrfs: fix typo in space info explanation")
>   5e85262e54 ("btrfs: fix fsync of files with no hard links not persistin=
g deletion")
>
> 846b534075f45d5b 5e85262e542d6da8898bb8563a7
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>     823946           -46.9%     437583 =C4=85  2%  cpuidle..usage
>       8144 =C4=85  5%     +24.5%      10135 =C4=85  2%  uptime.idle
>    2739200 =C4=85 13%     -35.9%    1754761 =C4=85  4%  numa-numastat.nod=
e0.local_node
>    2802155 =C4=85 12%     -35.3%    1811817 =C4=85  4%  numa-numastat.nod=
e0.numa_hit
>      45.55 =C4=85 11%     +52.7%      69.54 =C4=85  3%  iostat.cpu.idle
>      53.51 =C4=85  9%     -47.1%      28.33 =C4=85  8%  iostat.cpu.iowait
>       0.58 =C4=85  2%    +205.6%       1.76 =C4=85  8%  iostat.cpu.system
>     214.90 =C4=85 10%     -33.1%     143.70 =C4=85  9%  perf-c2c.DRAM.loc=
al
>     309.50 =C4=85 17%     +44.9%     448.40 =C4=85 17%  perf-c2c.DRAM.rem=
ote
>     141.70 =C4=85 19%     +79.3%     254.00 =C4=85 21%  perf-c2c.HITM.rem=
ote
>    4909242 =C4=85 16%     -38.3%    3030044 =C4=85  5%  numa-meminfo.node=
0.Inactive
>    4909242 =C4=85 16%     -38.3%    3030044 =C4=85  5%  numa-meminfo.node=
0.Inactive(file)
>      14849 =C4=85 14%     -77.3%       3372 =C4=85 19%  numa-meminfo.node=
0.Writeback
>       4951 =C4=85 24%     +55.6%       7704 =C4=85  5%  numa-meminfo.node=
1.Dirty
>       8065 =C4=85 24%     -58.9%       3316 =C4=85 21%  numa-meminfo.node=
1.Writeback
>      45.59 =C4=85 11%     +52.6%      69.57 =C4=85  3%  vmstat.cpu.id
>      53.47 =C4=85  9%     -47.1%      28.30 =C4=85  8%  vmstat.cpu.wa
>     112259           -32.6%      75701        vmstat.io.bo
>     119.44           -68.2%      37.98 =C4=85 15%  vmstat.procs.b
>       6317           -13.9%       5436 =C4=85  2%  vmstat.system.cs
>      14212           -14.9%      12092 =C4=85  3%  vmstat.system.in
>   11915567           -21.0%    9413763        meminfo.Cached
>      13350 =C4=85  2%     +22.6%      16366 =C4=85  3%  meminfo.Dirty
>    8170490           -30.6%    5668142        meminfo.Inactive
>    8170490           -30.6%    5668142        meminfo.Inactive(file)
>   14292973           -15.2%   12125438        meminfo.Memused
>      22993           -70.2%       6859 =C4=85 19%  meminfo.Writeback
>   14412570           -14.6%   12307953        meminfo.max_used_kB
>      43.84 =C4=85 12%     +24.8       68.62 =C4=85  3%  mpstat.cpu.all.id=
le%
>      55.23 =C4=85  9%     -26.0       29.23 =C4=85  8%  mpstat.cpu.all.io=
wait%
>       0.05 =C4=85  3%      -0.0        0.03 =C4=85  2%  mpstat.cpu.all.ir=
q%
>       0.05 =C4=85  6%      -0.0        0.03 =C4=85  5%  mpstat.cpu.all.so=
ft%
>       0.45 =C4=85  2%      +1.3        1.72 =C4=85  9%  mpstat.cpu.all.sy=
s%
>       1.00         +6100.0%      62.00        mpstat.max_utilization.seco=
nds
>       3.66 =C4=85  2%     +94.2%       7.10 =C4=85 30%  mpstat.max_utiliz=
ation_pct
>       0.59          +217.1%       1.87 =C4=85  7%  stress-ng.copy-file.MB=
_per_sec_copy_rate
>      18179           -33.4%      12113        stress-ng.copy-file.ops
>     302.23           -33.6%     200.60        stress-ng.copy-file.ops_per=
_sec
>   14350748           -33.0%    9617412        stress-ng.time.file_system_=
outputs
>       1420 =C4=85  8%    +484.5%       8300 =C4=85  6%  stress-ng.time.in=
voluntary_context_switches
>      41.30 =C4=85  2%    +407.0%     209.40 =C4=85  9%  stress-ng.time.pe=
rcent_of_cpu_this_job_got
>      24.57 =C4=85  2%    +415.4%     126.64 =C4=85  9%  stress-ng.time.sy=
stem_time
>      89786 =C4=85  2%     -17.3%      74281 =C4=85  5%  stress-ng.time.vo=
luntary_context_switches
>    1160907 =C4=85 13%     -45.0%     638139 =C4=85  3%  numa-vmstat.node0=
.nr_dirtied
>    1213548 =C4=85 16%     -37.3%     761371 =C4=85  5%  numa-vmstat.node0=
.nr_inactive_file
>       3666 =C4=85 14%     -76.8%     852.16 =C4=85 15%  numa-vmstat.node0=
.nr_writeback
>    1156044 =C4=85 13%     -45.0%     635340 =C4=85  3%  numa-vmstat.node0=
.nr_written
>    1213551 =C4=85 16%     -37.3%     761371 =C4=85  5%  numa-vmstat.node0=
.nr_zone_inactive_file
>       5755 =C4=85 13%     -47.1%       3041 =C4=85  5%  numa-vmstat.node0=
.nr_zone_write_pending
>    2803191 =C4=85 12%     -35.4%    1810577 =C4=85  4%  numa-vmstat.node0=
.numa_hit
>    2740236 =C4=85 13%     -36.0%    1753521 =C4=85  4%  numa-vmstat.node0=
.numa_local
>       1244 =C4=85 24%     +56.9%       1953 =C4=85  5%  numa-vmstat.node1=
.nr_dirty
>       1981 =C4=85 24%     -59.4%     804.96 =C4=85 14%  numa-vmstat.node1=
.nr_writeback
>    1799013           -32.9%    1206900        proc-vmstat.nr_dirtied
>       3360 =C4=85  2%     +21.6%       4086 =C4=85  3%  proc-vmstat.nr_di=
rty
>    2971433           -20.8%    2353137        proc-vmstat.nr_file_pages
>   29348580            +1.8%   29883631        proc-vmstat.nr_free_pages
>   29282199            +1.9%   29836480        proc-vmstat.nr_free_pages_b=
locks
>    2034863           -30.4%    1416458        proc-vmstat.nr_inactive_fil=
e
>      38408            -6.3%      36004        proc-vmstat.nr_slab_reclaim=
able
>       5706           -70.1%       1708 =C4=85 15%  proc-vmstat.nr_writeba=
ck
>    1790881           -32.9%    1201249        proc-vmstat.nr_written
>    2034863           -30.4%    1416458        proc-vmstat.nr_zone_inactiv=
e_file
>       8998           -35.6%       5795 =C4=85  2%  proc-vmstat.nr_zone_wr=
ite_pending
>    4444162           -23.1%    3416163        proc-vmstat.numa_hit
>    4311404           -23.8%    3283749        proc-vmstat.numa_local
>     566.30 =C4=85 89%   +1255.8%       7678 =C4=85247%  proc-vmstat.numa_=
pte_updates
>    4505726           -22.8%    3477149        proc-vmstat.pgalloc_normal
>    7184379           -32.4%    4859319        proc-vmstat.pgpgout
>       2.68 =C4=85  2%     -25.7%       1.99 =C4=85  4%  perf-stat.i.MPKI
>  7.342e+08            +6.6%  7.826e+08        perf-stat.i.branch-instruct=
ions
>       3.45            -0.7        2.77 =C4=85  2%  perf-stat.i.branch-mis=
s-rate%
>   33462192            -4.2%   32070836        perf-stat.i.branch-misses
>      10.22            +3.1       13.35        perf-stat.i.cache-miss-rate=
%
>    5043813 =C4=85  2%     -14.9%    4291664        perf-stat.i.cache-miss=
es
>   50234628           -34.5%   32914395        perf-stat.i.cache-reference=
s
>       5523 =C4=85  3%      -8.1%       5077        perf-stat.i.context-sw=
itches
>       1.15          +236.5%       3.88 =C4=85  6%  perf-stat.i.cpi
>  3.417e+09          +149.6%  8.527e+09 =C4=85  6%  perf-stat.i.cpu-cycles
>     196.17           +12.1%     219.94 =C4=85  2%  perf-stat.i.cpu-migrat=
ions
>     615.76          +229.7%       2030 =C4=85  7%  perf-stat.i.cycles-bet=
ween-cache-misses
>       0.97           -58.0%       0.41 =C4=85  5%  perf-stat.i.ipc
>       1.39 =C4=85  2%     -18.2%       1.14        perf-stat.overall.MPKI
>       4.56            -0.5        4.10 =C4=85  2%  perf-stat.overall.bran=
ch-miss-rate%
>      10.03            +3.0       13.04        perf-stat.overall.cache-mis=
s-rate%
>       0.94          +140.0%       2.27 =C4=85  6%  perf-stat.overall.cpi
>     677.89          +193.3%       1988 =C4=85  6%  perf-stat.overall.cycl=
es-between-cache-misses
>       1.06           -58.2%       0.44 =C4=85  6%  perf-stat.overall.ipc
>  7.214e+08            +6.6%  7.691e+08        perf-stat.ps.branch-instruc=
tions
>   32880299            -4.1%   31516354        perf-stat.ps.branch-misses
>    4956935 =C4=85  2%     -14.9%    4218155        perf-stat.ps.cache-mis=
ses
>   49395581           -34.5%   32356624        perf-stat.ps.cache-referenc=
es
>       5429 =C4=85  3%      -8.1%       4992        perf-stat.ps.context-s=
witches
>  3.359e+09          +149.7%  8.387e+09 =C4=85  6%  perf-stat.ps.cpu-cycle=
s
>     192.84           +12.1%     216.24 =C4=85  2%  perf-stat.ps.cpu-migra=
tions
>       0.09 =C4=85 14%    +156.9%       0.23 =C4=85 61%  perf-sched.sch_de=
lay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.foli=
o_alloc_noprof.__filemap_get_folio
>       0.11 =C4=85 30%   +1780.8%       2.08 =C4=85170%  perf-sched.sch_de=
lay.avg.ms.__cond_resched.__filemap_get_folio.prepare_one_folio.constprop.0
>       0.09 =C4=85 28%   +4092.1%       3.64 =C4=85235%  perf-sched.sch_de=
lay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__set_=
extent_bit.set_extent_bit
>       0.11 =C4=85 37%     -71.8%       0.03 =C4=85153%  perf-sched.sch_de=
lay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.start_transaction.btrfs_d=
irty_inode.touch_atime
>       0.23 =C4=85 68%     -60.2%       0.09 =C4=85  3%  perf-sched.sch_de=
lay.avg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.=
btrfs_remap_file_range.vfs_copy_file_range
>       0.22 =C4=85 85%    -100.0%       0.00        perf-sched.sch_delay.a=
vg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs=
_sync_file.do_fsync
>       0.04 =C4=85 17%    +268.7%       0.15 =C4=85175%  perf-sched.sch_de=
lay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.b=
trfs_tree_lock_nested
>       0.16 =C4=85 24%     -79.4%       0.03 =C4=85154%  perf-sched.sch_de=
lay.max.ms.__cond_resched.kmem_cache_alloc_noprof.start_transaction.btrfs_d=
irty_inode.touch_atime
>       0.11 =C4=85 38%  +44277.4%      48.59 =C4=85284%  perf-sched.sch_de=
lay.max.ms.__cond_resched.lock_delalloc_folios.find_lock_delalloc_range.wri=
tepage_delalloc.extent_writepage
>      80.59 =C4=85124%    -100.0%       0.00        perf-sched.sch_delay.m=
ax.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs=
_sync_file.do_fsync
>     154.78 =C4=85  4%     +15.1%     178.11 =C4=85  4%  perf-sched.total_=
wait_and_delay.average.ms
>     154.67 =C4=85  4%     +15.1%     177.96 =C4=85  4%  perf-sched.total_=
wait_time.average.ms
>      41.27 =C4=85207%    +533.8%     261.54 =C4=85 17%  perf-sched.wait_a=
nd_delay.avg.ms.__cond_resched.lock_delalloc_folios.find_lock_delalloc_rang=
e.writepage_delalloc.extent_writepage
>     200.09 =C4=85  3%     -68.0%      64.08 =C4=85 14%  perf-sched.wait_a=
nd_delay.avg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_r=
ange.btrfs_remap_file_range.vfs_copy_file_range
>     198.42 =C4=85  3%    -100.0%       0.00        perf-sched.wait_and_de=
lay.avg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.=
btrfs_sync_file.do_fsync
>      37.96 =C4=85 14%    +150.7%      95.16 =C4=85 22%  perf-sched.wait_a=
nd_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__fi=
lemap_fdatawait_range
>      18.02 =C4=85 24%    +270.4%      66.75 =C4=85 16%  perf-sched.wait_a=
nd_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_rea=
d.btrfs_tree_read_lock_nested
>       8.29 =C4=85 68%    +438.3%      44.64 =C4=85 25%  perf-sched.wait_a=
nd_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_wr=
ite.btrfs_tree_lock_nested
>       7.15 =C4=85 11%    +199.9%      21.45 =C4=85  2%  perf-sched.wait_a=
nd_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>     170.75 =C4=85 10%     +46.2%     249.63 =C4=85 10%  perf-sched.wait_a=
nd_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       0.50 =C4=85204%  +26480.0%     132.90 =C4=85 28%  perf-sched.wait_a=
nd_delay.count.__cond_resched.lock_delalloc_folios.find_lock_delalloc_range=
.writepage_delalloc.extent_writepage
>       1243 =C4=85  5%     -35.0%     808.80 =C4=85  7%  perf-sched.wait_a=
nd_delay.count.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_ra=
nge.btrfs_remap_file_range.vfs_copy_file_range
>       1210 =C4=85  3%    -100.0%       0.00        perf-sched.wait_and_de=
lay.count.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.b=
trfs_sync_file.do_fsync
>       3079           -30.7%       2134        perf-sched.wait_and_delay.c=
ount.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdata=
wait_range
>     379.00 =C4=85 22%    +107.1%     784.90 =C4=85 11%  perf-sched.wait_a=
nd_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read=
.btrfs_tree_read_lock_nested
>      83.70 =C4=85 60%    +349.1%     375.90 =C4=85 10%  perf-sched.wait_a=
nd_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_wri=
te.btrfs_tree_lock_nested
>     673.70 =C4=85 11%     -67.7%     217.30 =C4=85  3%  perf-sched.wait_a=
nd_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>      74.87 =C4=85216%    +687.0%     589.20 =C4=85 10%  perf-sched.wait_a=
nd_delay.max.ms.__cond_resched.lock_delalloc_folios.find_lock_delalloc_rang=
e.writepage_delalloc.extent_writepage
>     422.52 =C4=85 20%     -45.8%     229.04 =C4=85 12%  perf-sched.wait_a=
nd_delay.max.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_r=
ange.btrfs_remap_file_range.vfs_copy_file_range
>     501.20 =C4=85 18%    -100.0%       0.00        perf-sched.wait_and_de=
lay.max.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.=
btrfs_sync_file.do_fsync
>      28.77 =C4=85 66%   +1173.7%     366.39 =C4=85 21%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.foli=
o_alloc_noprof.__filemap_get_folio
>      43.62 =C4=85 74%    +685.2%     342.46 =C4=85 10%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.__filemap_get_folio.prepare_one_folio.constprop.0
>      38.14 =C4=85 71%    +829.9%     354.72 =C4=85 18%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.btrfs_buffered_write.btrfs_do_write_iter.vfs_writ=
e.ksys_write
>      36.28 =C4=85 66%    +515.5%     223.32 =C4=85 17%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.extent_write_cache_pages.btrfs_writepages.do_writ=
epages.filemap_fdatawrite_wbc
>      38.49 =C4=85 69%    +694.7%     305.87 =C4=85 17%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__set_=
extent_bit.set_extent_bit
>      53.67 =C4=85110%     -96.4%       1.94 =C4=85297%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.kmem_cache_alloc_noprof.start_transaction.btrfs_d=
irty_inode.touch_atime
>      52.47 =C4=85158%    +397.0%     260.79 =C4=85 16%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.lock_delalloc_folios.find_lock_delalloc_range.wri=
tepage_delalloc.extent_writepage
>     199.86 =C4=85  3%     -68.0%      63.99 =C4=85 14%  perf-sched.wait_t=
ime.avg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.=
btrfs_remap_file_range.vfs_copy_file_range
>     198.21 =C4=85  3%    -100.0%       0.00        perf-sched.wait_time.a=
vg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs=
_sync_file.do_fsync
>      37.86 =C4=85 14%    +150.9%      94.99 =C4=85 22%  perf-sched.wait_t=
ime.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap=
_fdatawait_range
>      17.94 =C4=85 24%    +271.5%      66.66 =C4=85 16%  perf-sched.wait_t=
ime.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btr=
fs_tree_read_lock_nested
>      10.87 =C4=85 37%    +309.3%      44.50 =C4=85 24%  perf-sched.wait_t=
ime.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.b=
trfs_tree_lock_nested
>       7.06 =C4=85 11%    +202.8%      21.37 =C4=85  2%  perf-sched.wait_t=
ime.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>     170.68 =C4=85 10%     +46.2%     249.55 =C4=85 10%  perf-sched.wait_t=
ime.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>     225.30 =C4=85 43%    +146.1%     554.37 =C4=85 15%  perf-sched.wait_t=
ime.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.foli=
o_alloc_noprof.__filemap_get_folio
>     179.96 =C4=85 58%    +225.3%     585.39 =C4=85 12%  perf-sched.wait_t=
ime.max.ms.__cond_resched.extent_write_cache_pages.btrfs_writepages.do_writ=
epages.filemap_fdatawrite_wbc
>     243.25 =C4=85 38%    +140.0%     583.77 =C4=85 10%  perf-sched.wait_t=
ime.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__set_=
extent_bit.set_extent_bit
>     108.35 =C4=85100%     -98.2%       1.98 =C4=85297%  perf-sched.wait_t=
ime.max.ms.__cond_resched.kmem_cache_alloc_noprof.start_transaction.btrfs_d=
irty_inode.touch_atime
>     119.47 =C4=85140%    +393.1%     589.11 =C4=85 10%  perf-sched.wait_t=
ime.max.ms.__cond_resched.lock_delalloc_folios.find_lock_delalloc_range.wri=
tepage_delalloc.extent_writepage
>     422.43 =C4=85 20%     -45.8%     228.95 =C4=85 12%  perf-sched.wait_t=
ime.max.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.=
btrfs_remap_file_range.vfs_copy_file_range
>     501.11 =C4=85 18%    -100.0%       0.00        perf-sched.wait_time.m=
ax.ms.btrfs_start_ordered_extent_nowriteback.btrfs_wait_ordered_range.btrfs=
_sync_file.do_fsync
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

