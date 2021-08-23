Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B6C3F47EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 11:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhHWJwi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 05:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhHWJwh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 05:52:37 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C17DC061757;
        Mon, 23 Aug 2021 02:51:54 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 22so18549539qkg.2;
        Mon, 23 Aug 2021 02:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=LtT/Uv8SXTH1L/U6VVHj4tFsuImFgdrwQqFN3otDE/Q=;
        b=m+OAH4Hk07mS3+W5TRYqn0YJSBqMk1qnUCu21AChXWuYbu7t2Ra3nwuAD6+5L4KWJR
         xylqG3Ap4Y1rL3x6T75Ro5ga6hqLTX2n6WCtS7reNmRxoX5bw3Un9hmf59680r2hLRM6
         +mcCdYeL7fvpTZkp6nl/w5/zk3EtL+CW97WGsHb2//51u4YCwImFG5GZDAxkYJZXcgtf
         lE4Hta/VluH98V9xbdDQ4uuOViSjiIhBiby7QCDwitHVNMKjiiy/41w6RBrfoK9lxJFy
         jgH/3Rcckcamb3a/mAI4f63XyZK0wYKlqyNRAbisnnIFrupUDC1FNht+VfBJrTkqkR+g
         yChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=LtT/Uv8SXTH1L/U6VVHj4tFsuImFgdrwQqFN3otDE/Q=;
        b=FiSIqf63E8Z8NXBlTIF9O5yYlLN90L90kSSHZo2Z5B4IuLyUDFl5P6ndqFHMoqcLL5
         J10qGybIwVMAJy+S/IKk5Ou9gCeukNIO5UI1JhaDM0rgr8Gzyrcsz2LmPHigpM3d1E1e
         vy9bSP3s+LgDNAY7jFZYfzVqUZSvQF1s4UNVU7fdOhy8X8npEF/1Dx+NWirnG/9B5g7i
         rBdq6mrQcAqfeEsdwExu72h2ktL9rUzycnVannX2B5DqGOEh/S5gEfDJcR2fYlphEVv/
         NV0LdCFospZRcowu4JM8W9DxjrUpxvHJrBP058NvQz0IJ5d45Ljs/B7XoL+NZ/HyqBbu
         JPOw==
X-Gm-Message-State: AOAM5303tWYs//XQ1/8u5r0DojkDTult7zyPAtwB0VnlWfZR4hgmZ1+d
        PA/dMtoKwdrT4u86ZK76Cmaruud5N5HCEIDkSeg=
X-Google-Smtp-Source: ABdhPJzxrFWnyi49zRgCLuj17ny5wQS4/MsoL1AZveHzcFIkV96izZkWv74QoRUQxQPZAc//2VVCPxA+FngkKhSNbaQ=
X-Received: by 2002:a37:607:: with SMTP id 7mr20886452qkg.0.1629712313565;
 Mon, 23 Aug 2021 02:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210808134519.GC27482@xsang-OptiPlex-9020> <CAL3q7H6=M_E1THSOfYXCKpT-i0yJnR_vZq5webBY0Qe9z-UOHw@mail.gmail.com>
In-Reply-To: <CAL3q7H6=M_E1THSOfYXCKpT-i0yJnR_vZq5webBY0Qe9z-UOHw@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 23 Aug 2021 10:51:42 +0100
Message-ID: <CAL3q7H4T+AjDsVScdWs6FJd2CNjbVPwfbZyrQphWew10wbBnZQ@mail.gmail.com>
Subject: Re: [btrfs] ecc64fab7d: stress-ng.link.ops_per_sec -81.7% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kbuild test robot <lkp@intel.com>,
        Huang Ying <ying.huang@intel.com>, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 8, 2021 at 6:36 PM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Sun, Aug 8, 2021 at 2:30 PM kernel test robot <oliver.sang@intel.com> =
wrote:
> >
> >
> >
> > Greeting,
> >
> > FYI, we noticed a -81.7% regression of stress-ng.link.ops_per_sec due t=
o commit:
> >
> >
> > commit: ecc64fab7d49c678e70bd4c35fe64d2ab3e3d212 ("btrfs: fix lost inod=
e on log replay after mix of fsync, rename and inode eviction")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> The following patch, which was part of the same patchset, but it's not
> yet in Linus' tree, helps on restoring most of the performance:
>
> https://lore.kernel.org/linux-btrfs/307aaa44d39ad115e299bfe7d1f7e3eb4e991=
374.1627379796.git.fdmanana@suse.com/

Ok, so yesterday's report for that patch confirms that it more than
restores the performance drop from the bug fix:

https://lore.kernel.org/linux-btrfs/20210822150411.GA29963@xsang-OptiPlex-9=
020/

Thanks.


>
> There will be two more to reduce logging work during link and rename
> operations, but I'll only send them out after coming back from
> vacations.
>
> Thanks.
>
> >
> >
> > in testcase: stress-ng
> > on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ =
2.10GHz with 512G memory
> > with following parameters:
> >
> >         nr_threads: 10%
> >         disk: 1HDD
> >         testtime: 60s
> >         fs: btrfs
> >         class: filesystem
> >         test: link
> >         cpufreq_governor: performance
> >         ucode: 0x5003006
> >
> >
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> >
> >
> > Details are as below:
> > -----------------------------------------------------------------------=
--------------------------->
> >
> >
> > To reproduce:
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp install                job.yaml  # job file is attached=
 in this email
> >         bin/lkp split-job --compatible job.yaml  # generate the yaml fi=
le for lkp run
> >         bin/lkp run                    generated-yaml-file
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_=
group/test/testcase/testtime/ucode:
> >   filesystem/gcc-9/performance/1HDD/btrfs/x86_64-rhel-8.3/10%/debian-10=
.4-x86_64-20200603.cgz/lkp-csl-2sp7/link/stress-ng/60s/0x5003006
> >
> > commit:
> >   240246f6b9 ("btrfs: mark compressed range uptodate only if all bio su=
cceed")
> >   ecc64fab7d ("btrfs: fix lost inode on log replay after mix of fsync, =
rename and inode eviction")
> >
> > 240246f6b913b0c2 ecc64fab7d49c678e70bd4c35fe
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >     227.57 =C4=85  2%     -81.9%      41.14 =C4=85 10%  stress-ng.link.=
ops
> >       3.75 =C4=85  2%     -81.7%       0.69 =C4=85 10%  stress-ng.link.=
ops_per_sec
> >     949188 =C4=85  2%   +4871.8%   47192178 =C4=85  6%  stress-ng.time.=
file_system_outputs
> >    8737302 =C4=85  3%     +18.5%   10352864 =C4=85  5%  stress-ng.time.=
voluntary_context_switches
> >       6.96            -4.9%       6.62        iostat.cpu.system
> >       4659 =C4=85 27%     -73.6%       1228 =C4=85 73%  numa-meminfo.no=
de0.Dirty
> >       3435 =C4=85 39%     -69.5%       1048 =C4=85 95%  numa-meminfo.no=
de1.Dirty
> >      11008 =C4=85  7%     -10.6%       9835 =C4=85  6%  softirqs.CPU4.S=
CHED
> >      11489 =C4=85  5%     -14.1%       9871 =C4=85 10%  softirqs.CPU49.=
SCHED
> >       4721 =C4=85  5%     -87.1%     610.86 =C4=85 23%  vmstat.io.bo
> >    2817765           +21.3%    3416713        vmstat.memory.cache
> >       2663            +3.5%       2757        turbostat.Bzy_MHz
> >    8407573 =C4=85  4%     +15.4%    9703225 =C4=85  6%  turbostat.C1
> >     158.73            +4.0%     165.10        turbostat.PkgWatt
> >       9517 =C4=85  6%     -88.6%       1088 =C4=85 19%  interrupts.315:=
PCI-MSI.376832-edge.ahci[0000:00:17.0]
> >       5890 =C4=85 49%     -68.2%       1875 =C4=85 68%  interrupts.CPU2=
1.CAL:Function_call_interrupts
> >     471.14 =C4=85 57%    +124.1%       1056 =C4=85 41%  interrupts.CPU7=
5.NMI:Non-maskable_interrupts
> >     471.14 =C4=85 57%    +124.1%       1056 =C4=85 41%  interrupts.CPU7=
5.PMI:Performance_monitoring_interrupts
> >       0.29 =C4=85  5%      -0.2        0.04 =C4=85 20%  mpstat.cpu.all.=
iowait%
> >       0.90 =C4=85  8%      -0.2        0.74 =C4=85  3%  mpstat.cpu.all.=
irq%
> >       0.07 =C4=85  5%      -0.0        0.06 =C4=85  2%  mpstat.cpu.all.=
soft%
> >       0.18 =C4=85  2%      -0.0        0.14 =C4=85  2%  mpstat.cpu.all.=
usr%
> >     292111 =C4=85  2%    +207.8%     898999        meminfo.Active
> >     285313 =C4=85  2%    +212.7%     892049        meminfo.Active(file)
> >    2689046           +22.4%    3291841        meminfo.Cached
> >       8096 =C4=85  2%     -72.1%       2259 =C4=85  6%  meminfo.Dirty
> >       7347 =C4=85  5%     -46.4%       3938 =C4=85 40%  meminfo.Inactiv=
e(file)
> >    4474242           +13.7%    5086026        meminfo.Memused
> >    4500587           +14.5%    5152537        meminfo.max_used_kB
> >      47198 =C4=85 34%   +3147.3%    1532689 =C4=85 78%  numa-vmstat.nod=
e0.nr_dirtied
> >       1163 =C4=85 27%     -73.6%     306.86 =C4=85 73%  numa-vmstat.nod=
e0.nr_dirty
> >      13644 =C4=85 34%     -82.6%       2373 =C4=85 58%  numa-vmstat.nod=
e0.nr_written
> >       1192 =C4=85 29%     -74.2%     307.71 =C4=85 74%  numa-vmstat.nod=
e0.nr_zone_write_pending
> >     858.29 =C4=85 39%     -69.6%     260.71 =C4=85 96%  numa-vmstat.nod=
e1.nr_dirty
> >       8345 =C4=85 58%     -81.8%       1514 =C4=85101%  numa-vmstat.nod=
e1.nr_written
> >     870.29 =C4=85 38%     -69.8%     262.71 =C4=85 95%  numa-vmstat.nod=
e1.nr_zone_write_pending
> >      71331 =C4=85  2%    +212.7%     223017        proc-vmstat.nr_activ=
e_file
> >     159852 =C4=85  2%   +3593.0%    5903385 =C4=85  6%  proc-vmstat.nr_=
dirtied
> >       2023 =C4=85  2%     -72.0%     566.00 =C4=85  7%  proc-vmstat.nr_=
dirty
> >     672525           +22.4%     823223        proc-vmstat.nr_file_pages
> >       1836 =C4=85  5%     -46.5%     983.00 =C4=85 40%  proc-vmstat.nr_=
inactive_file
> >      43756 =C4=85  5%     -87.1%       5658 =C4=85 24%  proc-vmstat.nr_=
written
> >      71331 =C4=85  2%    +212.7%     223017        proc-vmstat.nr_zone_=
active_file
> >       1836 =C4=85  5%     -46.5%     983.00 =C4=85 40%  proc-vmstat.nr_=
zone_inactive_file
> >       2055 =C4=85  3%     -72.3%     570.00 =C4=85  6%  proc-vmstat.nr_=
zone_write_pending
> >     617463           +17.3%     724326        proc-vmstat.numa_hit
> >     530828           +20.1%     637670        proc-vmstat.numa_local
> >      49518 =C4=85  2%     +47.9%      73219 =C4=85 16%  proc-vmstat.pga=
ctivate
> >     648782           +15.4%     748934        proc-vmstat.pgalloc_norma=
l
> >     358760            -3.4%     346576        proc-vmstat.pgfree
> >     308332 =C4=85  6%     -87.5%      38626 =C4=85 24%  proc-vmstat.pgp=
gout
> >  2.142e+09           -15.7%  1.806e+09 =C4=85  2%  perf-stat.i.branch-i=
nstructions
> >   18232988 =C4=85  3%     -17.5%   15041745 =C4=85  3%  perf-stat.i.bra=
nch-misses
> >       2.02 =C4=85  3%     +14.5%       2.31        perf-stat.i.cpi
> >  2.129e+10            -4.8%  2.026e+10        perf-stat.i.cpu-cycles
> >       0.02 =C4=85 36%      -0.0        0.00 =C4=85 34%  perf-stat.i.dTL=
B-load-miss-rate%
> >     385230 =C4=85 32%     -72.5%     105867 =C4=85 28%  perf-stat.i.dTL=
B-load-misses
> >  2.742e+09           -17.8%  2.253e+09        perf-stat.i.dTLB-loads
> >   1.11e+09 =C4=85  2%     -23.2%  8.532e+08 =C4=85  2%  perf-stat.i.dTL=
B-stores
> >      32.05            -3.7       28.32        perf-stat.i.iTLB-load-mis=
s-rate%
> >    3835461 =C4=85  2%     -26.6%    2816654 =C4=85  3%  perf-stat.i.iTL=
B-load-misses
> >    8289183 =C4=85  3%     -12.0%    7292203 =C4=85  3%  perf-stat.i.iTL=
B-loads
> >  1.069e+10           -16.6%  8.923e+09        perf-stat.i.instructions
> >       2913 =C4=85  2%     +13.8%       3316 =C4=85  5%  perf-stat.i.ins=
tructions-per-iTLB-miss
> >       0.52 =C4=85  3%     -12.9%       0.45        perf-stat.i.ipc
> >       0.22            -4.8%       0.21        perf-stat.i.metric.GHz
> >      62.64           -18.1%      51.27        perf-stat.i.metric.M/sec
> >      92.36           -23.1       69.23 =C4=85  6%  perf-stat.i.node-sto=
re-miss-rate%
> >      98872 =C4=85  6%    +764.1%     854357 =C4=85 10%  perf-stat.i.nod=
e-stores
> >      22849           -71.6%       6482 =C4=85  6%  perf-stat.i.page-fau=
lts
> >       1.99 =C4=85  2%     +14.0%       2.27        perf-stat.overall.cp=
i
> >       0.01 =C4=85 32%      -0.0        0.00 =C4=85 27%  perf-stat.overa=
ll.dTLB-load-miss-rate%
> >      31.64            -3.8       27.87        perf-stat.overall.iTLB-lo=
ad-miss-rate%
> >       2789 =C4=85  2%     +13.7%       3172 =C4=85  4%  perf-stat.overa=
ll.instructions-per-iTLB-miss
> >       0.50 =C4=85  2%     -12.3%       0.44        perf-stat.overall.ip=
c
> >      95.08           -26.8       68.28 =C4=85  6%  perf-stat.overall.no=
de-store-miss-rate%
> >  2.108e+09           -15.7%  1.777e+09 =C4=85  2%  perf-stat.ps.branch-=
instructions
> >   17956331 =C4=85  3%     -17.5%   14821238 =C4=85  3%  perf-stat.ps.br=
anch-misses
> >  2.095e+10            -4.8%  1.994e+10        perf-stat.ps.cpu-cycles
> >     379273 =C4=85 32%     -72.5%     104229 =C4=85 28%  perf-stat.ps.dT=
LB-load-misses
> >  2.698e+09           -17.8%  2.218e+09        perf-stat.ps.dTLB-loads
> >  1.093e+09 =C4=85  2%     -23.1%  8.398e+08 =C4=85  2%  perf-stat.ps.dT=
LB-stores
> >    3774726 =C4=85  2%     -26.6%    2772418 =C4=85  3%  perf-stat.ps.iT=
LB-load-misses
> >    8157708 =C4=85  3%     -12.0%    7176458 =C4=85  3%  perf-stat.ps.iT=
LB-loads
> >  1.052e+10           -16.6%  8.783e+09        perf-stat.ps.instructions
> >      97299 =C4=85  6%    +763.6%     840325 =C4=85 10%  perf-stat.ps.no=
de-stores
> >      22491           -71.6%       6381 =C4=85  6%  perf-stat.ps.page-fa=
ults
> >  6.702e+11           -17.1%  5.556e+11        perf-stat.total.instructi=
ons
> >       5395 =C4=85  2%      -9.6%       4876 =C4=85  3%  slabinfo.Acpi-S=
tate.active_objs
> >       5395 =C4=85  2%      -9.6%       4876 =C4=85  3%  slabinfo.Acpi-S=
tate.num_objs
> >     485.57 =C4=85  5%     -55.8%     214.86 =C4=85  8%  slabinfo.biovec=
-128.active_objs
> >     485.57 =C4=85  5%     -55.8%     214.86 =C4=85  8%  slabinfo.biovec=
-128.num_objs
> >     516.43 =C4=85 12%     -23.6%     394.43 =C4=85  9%  slabinfo.biovec=
-64.active_objs
> >     516.43 =C4=85 12%     -23.6%     394.43 =C4=85  9%  slabinfo.biovec=
-64.num_objs
> >     392.71 =C4=85  8%     -49.5%     198.43 =C4=85 12%  slabinfo.biovec=
-max.active_objs
> >     407.86 =C4=85  7%     -49.3%     206.71 =C4=85 11%  slabinfo.biovec=
-max.num_objs
> >       7325 =C4=85  3%     -55.1%       3287 =C4=85  6%  slabinfo.btrfs_=
delayed_tree_ref.active_objs
> >     187.43 =C4=85  3%     -55.3%      83.86 =C4=85  6%  slabinfo.btrfs_=
delayed_tree_ref.active_slabs
> >       7325 =C4=85  3%     -55.1%       3287 =C4=85  6%  slabinfo.btrfs_=
delayed_tree_ref.num_objs
> >     187.43 =C4=85  3%     -55.3%      83.86 =C4=85  6%  slabinfo.btrfs_=
delayed_tree_ref.num_slabs
> >       8208           -51.2%       4004 =C4=85  8%  slabinfo.btrfs_exten=
t_map.active_objs
> >       8208           -51.2%       4004 =C4=85  8%  slabinfo.btrfs_exten=
t_map.num_objs
> >     903.14 =C4=85  6%     -77.0%     207.29 =C4=85 33%  slabinfo.btrfs_=
ordered_extent.active_objs
> >     903.14 =C4=85  6%     -77.0%     207.29 =C4=85 33%  slabinfo.btrfs_=
ordered_extent.num_objs
> >       9693 =C4=85  3%     -17.3%       8017 =C4=85  7%  slabinfo.fsnoti=
fy_mark_connector.active_objs
> >       9693 =C4=85  3%     -17.3%       8017 =C4=85  7%  slabinfo.fsnoti=
fy_mark_connector.num_objs
> >      13523 =C4=85  6%     -37.0%       8525 =C4=85  6%  slabinfo.kmallo=
c-128.active_objs
> >     425.29 =C4=85  6%     -36.6%     269.57 =C4=85  6%  slabinfo.kmallo=
c-128.active_slabs
> >      13629 =C4=85  6%     -36.6%       8642 =C4=85  6%  slabinfo.kmallo=
c-128.num_objs
> >     425.29 =C4=85  6%     -36.6%     269.57 =C4=85  6%  slabinfo.kmallo=
c-128.num_slabs
> >      17162 =C4=85  6%     -33.9%      11351 =C4=85  5%  slabinfo.kmallo=
c-192.active_objs
> >     411.71 =C4=85  6%     -34.0%     271.71 =C4=85  5%  slabinfo.kmallo=
c-192.active_slabs
> >      17307 =C4=85  6%     -34.0%      11430 =C4=85  5%  slabinfo.kmallo=
c-192.num_objs
> >     411.71 =C4=85  6%     -34.0%     271.71 =C4=85  5%  slabinfo.kmallo=
c-192.num_slabs
> >      23093 =C4=85  9%     -64.0%       8304 =C4=85  6%  slabinfo.kmallo=
c-rcl-96.active_objs
> >     549.43 =C4=85  9%     -64.1%     197.29 =C4=85  6%  slabinfo.kmallo=
c-rcl-96.active_slabs
> >      23095 =C4=85  9%     -64.0%       8304 =C4=85  6%  slabinfo.kmallo=
c-rcl-96.num_objs
> >     549.43 =C4=85  9%     -64.1%     197.29 =C4=85  6%  slabinfo.kmallo=
c-rcl-96.num_slabs
> >       2224 =C4=85  4%     -31.9%       1514 =C4=85  7%  slabinfo.mnt_ca=
che.active_objs
> >       2224 =C4=85  4%     -31.9%       1514 =C4=85  7%  slabinfo.mnt_ca=
che.num_objs
> >       8352 =C4=85  2%     +79.5%      14992 =C4=85  6%  slabinfo.pool_w=
orkqueue.active_objs
> >     261.71 =C4=85  2%     +79.3%     469.14 =C4=85  6%  slabinfo.pool_w=
orkqueue.active_slabs
> >       8381 =C4=85  2%     +79.2%      15022 =C4=85  6%  slabinfo.pool_w=
orkqueue.num_objs
> >     261.71 =C4=85  2%     +79.3%     469.14 =C4=85  6%  slabinfo.pool_w=
orkqueue.num_slabs
> >      29474           +13.4%      33417 =C4=85  2%  slabinfo.radix_tree_=
node.active_objs
> >      29474           +13.4%      33429 =C4=85  2%  slabinfo.radix_tree_=
node.num_objs
> >     612.57 =C4=85  9%     -35.3%     396.43 =C4=85 11%  slabinfo.skbuff=
_fclone_cache.active_objs
> >     612.57 =C4=85  9%     -35.3%     396.43 =C4=85 11%  slabinfo.skbuff=
_fclone_cache.num_objs
> >      30.52 =C4=85  3%     -28.4        2.16 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >      30.35 =C4=85  3%     -28.2        2.15 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_aft=
er_hwframe
> >      30.28 =C4=85  3%     -28.1        2.15 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.btrfs_unlink.vfs_unlink.do_unlinkat.do_syscall_64.entry_S=
YSCALL_64_after_hwframe
> >      29.86 =C4=85  3%     -27.7        2.11 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.btrfs_unlink_inode.btrfs_unlink.vfs_unlink.do_unlinkat.do=
_syscall_64
> >      29.86 =C4=85  3%     -27.7        2.11 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.__btrfs_unlink_inode.btrfs_unlink_inode.btrfs_unlink.vfs_=
unlink.do_unlinkat
> >      19.65 =C4=85  4%     -18.3        1.36 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.btrfs_add_link.btrfs_link.vfs_link.do_linkat.__x64_sys_li=
nk
> >      18.68 =C4=85  3%     -17.4        1.26 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.btrfs_del_inode_ref.__btrfs_unlink_inode.btrfs_unlink_ino=
de.btrfs_unlink.vfs_unlink
> >      17.74 =C4=85  3%     -16.5        1.20 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.btrfs_search_slot.btrfs_del_inode_ref.__btrfs_unlink_inod=
e.btrfs_unlink_inode.btrfs_unlink
> >      15.15 =C4=85  3%     -14.1        1.03 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.btrfs_lock_root_node.btrfs_search_slot.btrfs_del_inode_re=
f.__btrfs_unlink_inode.btrfs_unlink_inode
> >      15.10 =C4=85  3%     -14.1        1.02 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot.=
btrfs_del_inode_ref.__btrfs_unlink_inode
> >      14.92 =C4=85  3%     -13.9        1.01 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_lock_ro=
ot_node.btrfs_search_slot.btrfs_del_inode_ref
> >      12.51 =C4=85  4%     -11.6        0.88 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.btrfs_insert_inode_ref.btrfs_add_link.btrfs_link.vfs_link=
.do_linkat
> >      10.73 =C4=85  4%     -10.0        0.76 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.btrfs_insert_empty_items.btrfs_insert_inode_ref.btrfs_add=
_link.btrfs_link.vfs_link
> >      10.23 =C4=85  4%      -9.5        0.72 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.btrfs_search_slot.btrfs_insert_empty_items.btrfs_insert_i=
node_ref.btrfs_add_link.btrfs_link
> >       9.38 =C4=85  4%      -8.8        0.62 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.btrfs_lookup_dir_item.__btrfs_unlink_inode.btrfs_unlink_i=
node.btrfs_unlink.vfs_unlink
> >       9.34 =C4=85  4%      -8.7        0.62 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_dir_item.__btrfs_unlink_in=
ode.btrfs_unlink_inode.btrfs_unlink
> >       7.85 =C4=85  4%      -7.3        0.52 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.btrfs_lock_root_node.btrfs_search_slot.btrfs_lookup_dir_i=
tem.__btrfs_unlink_inode.btrfs_unlink_inode
> >       7.82 =C4=85  4%      -7.3        0.51 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot.=
btrfs_lookup_dir_item.__btrfs_unlink_inode
> >       7.72 =C4=85  4%      -7.2        0.51 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_lock_ro=
ot_node.btrfs_search_slot.btrfs_lookup_dir_item
> >       7.65 =C4=85  4%      -7.1        0.52 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.btrfs_lock_root_node.btrfs_search_slot.btrfs_insert_empty=
_items.btrfs_insert_inode_ref.btrfs_add_link
> >       7.62 =C4=85  4%      -7.1        0.52 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot.=
btrfs_insert_empty_items.btrfs_insert_inode_ref
> >       6.93 =C4=85  4%      -6.5        0.46 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.btrfs_insert_dir_item.btrfs_add_link.btrfs_link.vfs_link.=
do_linkat
> >       6.16 =C4=85  4%      -5.8        0.41 =C4=85158%  perf-profile.ca=
lltrace.cycles-pp.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link=
.btrfs_link.vfs_link
> >       6.15 =C4=85  4%      -5.7        0.41 =C4=85159%  perf-profile.ca=
lltrace.cycles-pp.btrfs_insert_empty_items.insert_with_overflow.btrfs_inser=
t_dir_item.btrfs_add_link.btrfs_link
> >       5.67 =C4=85  4%      -5.3        0.38 =C4=85159%  perf-profile.ca=
lltrace.cycles-pp.btrfs_search_slot.btrfs_insert_empty_items.insert_with_ov=
erflow.btrfs_insert_dir_item.btrfs_add_link
> >      28.95 =C4=85  3%      -2.8       26.20 =C4=85  6%  perf-profile.ca=
lltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.__btrfs_tree_lock.btrf=
s_lock_root_node.btrfs_search_slot
> >       0.00            +0.6        0.58 =C4=85  8%  perf-profile.calltra=
ce.cycles-pp.btrfs_read_lock_root_node.btrfs_search_slot.btrfs_insert_empty=
_items.copy_items.btrfs_log_inode
> >       0.00            +0.6        0.61 =C4=85 11%  perf-profile.calltra=
ce.cycles-pp.btrfs_search_forward.btrfs_log_inode.log_new_dir_dentries.btrf=
s_log_inode_parent.btrfs_log_new_name
> >       0.00            +0.7        0.69 =C4=85 13%  perf-profile.calltra=
ce.cycles-pp.setup_items_for_insert.btrfs_insert_empty_items.copy_items.btr=
fs_log_inode.log_new_dir_dentries
> >       0.00            +1.0        1.00 =C4=85 17%  perf-profile.calltra=
ce.cycles-pp.btrfs_search_slot.btrfs_log_inode.log_new_dir_dentries.btrfs_l=
og_inode_parent.btrfs_log_new_name
> >       0.00            +1.2        1.21 =C4=85 15%  perf-profile.calltra=
ce.cycles-pp.btrfs_search_forward.log_new_dir_dentries.btrfs_log_inode_pare=
nt.btrfs_log_new_name.btrfs_link
> >       0.00            +1.6        1.60 =C4=85 18%  perf-profile.calltra=
ce.cycles-pp.btrfs_search_slot.overwrite_item.log_dir_items.log_directory_c=
hanges.btrfs_log_inode
> >       0.00            +2.0        2.01 =C4=85 18%  perf-profile.calltra=
ce.cycles-pp.overwrite_item.log_dir_items.log_directory_changes.btrfs_log_i=
node.btrfs_log_inode_parent
> >       0.00            +2.1        2.14 =C4=85 18%  perf-profile.calltra=
ce.cycles-pp.log_dir_items.log_directory_changes.btrfs_log_inode.btrfs_log_=
inode_parent.btrfs_log_new_name
> >       0.00            +2.1        2.14 =C4=85 18%  perf-profile.calltra=
ce.cycles-pp.log_directory_changes.btrfs_log_inode.btrfs_log_inode_parent.b=
trfs_log_new_name.btrfs_link
> >       0.00            +2.4        2.43 =C4=85 17%  perf-profile.calltra=
ce.cycles-pp.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_new_name.btrf=
s_link.vfs_link
> >       0.00            +2.7        2.66 =C4=85 44%  perf-profile.calltra=
ce.cycles-pp.split_leaf.btrfs_search_slot.btrfs_insert_empty_items.copy_ite=
ms.btrfs_log_inode
> >       0.00            +2.9        2.85 =C4=85 75%  perf-profile.calltra=
ce.cycles-pp.btrfs_del_leaf.btrfs_del_items.drop_objectid_items.btrfs_log_i=
node.log_new_dir_dentries
> >       0.00            +3.8        3.83 =C4=85 58%  perf-profile.calltra=
ce.cycles-pp.btrfs_del_items.drop_objectid_items.btrfs_log_inode.log_new_di=
r_dentries.btrfs_log_inode_parent
> >      11.90 =C4=85  5%      +4.3       16.20 =C4=85  6%  perf-profile.ca=
lltrace.cycles-pp.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_lock_ro=
ot_node.btrfs_search_slot.btrfs_insert_empty_items
> >       0.00           +15.6       15.57 =C4=85 13%  perf-profile.calltra=
ce.cycles-pp.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot.btrfs=
_insert_empty_items.copy_items
> >       0.00           +15.6       15.62 =C4=85 13%  perf-profile.calltra=
ce.cycles-pp.btrfs_lock_root_node.btrfs_search_slot.btrfs_insert_empty_item=
s.copy_items.btrfs_log_inode
> >       0.00           +15.7       15.73 =C4=85 14%  perf-profile.calltra=
ce.cycles-pp.rwsem_down_write_slowpath.__btrfs_tree_lock.btrfs_lock_root_no=
de.btrfs_search_slot.drop_objectid_items
> >       0.00           +15.9       15.87 =C4=85 14%  perf-profile.calltra=
ce.cycles-pp.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot.drop_=
objectid_items.btrfs_log_inode
> >       0.00           +15.9       15.93 =C4=85 14%  perf-profile.calltra=
ce.cycles-pp.btrfs_lock_root_node.btrfs_search_slot.drop_objectid_items.btr=
fs_log_inode.log_new_dir_dentries
> >       0.00           +17.3       17.26 =C4=85 14%  perf-profile.calltra=
ce.cycles-pp.btrfs_search_slot.drop_objectid_items.btrfs_log_inode.log_new_=
dir_dentries.btrfs_log_inode_parent
> >       0.00           +20.1       20.15 =C4=85 15%  perf-profile.calltra=
ce.cycles-pp.btrfs_search_slot.btrfs_insert_empty_items.copy_items.btrfs_lo=
g_inode.log_new_dir_dentries
> >       0.00           +20.9       20.86 =C4=85 14%  perf-profile.calltra=
ce.cycles-pp.btrfs_insert_empty_items.copy_items.btrfs_log_inode.log_new_di=
r_dentries.btrfs_log_inode_parent
> >       0.00           +21.7       21.73 =C4=85 16%  perf-profile.calltra=
ce.cycles-pp.drop_objectid_items.btrfs_log_inode.log_new_dir_dentries.btrfs=
_log_inode_parent.btrfs_log_new_name
> >       0.00           +21.8       21.77 =C4=85 14%  perf-profile.calltra=
ce.cycles-pp.copy_items.btrfs_log_inode.log_new_dir_dentries.btrfs_log_inod=
e_parent.btrfs_log_new_name
> >      21.17 =C4=85  4%     +29.7       50.85 =C4=85  8%  perf-profile.ca=
lltrace.cycles-pp.__x64_sys_link.do_syscall_64.entry_SYSCALL_64_after_hwfra=
me
> >      21.17 =C4=85  4%     +29.7       50.85 =C4=85  8%  perf-profile.ca=
lltrace.cycles-pp.do_linkat.__x64_sys_link.do_syscall_64.entry_SYSCALL_64_a=
fter_hwframe
> >      20.22 =C4=85  4%     +30.6       50.78 =C4=85  8%  perf-profile.ca=
lltrace.cycles-pp.vfs_link.do_linkat.__x64_sys_link.do_syscall_64.entry_SYS=
CALL_64_after_hwframe
> >      20.17 =C4=85  4%     +30.6       50.78 =C4=85  8%  perf-profile.ca=
lltrace.cycles-pp.btrfs_link.vfs_link.do_linkat.__x64_sys_link.do_syscall_6=
4
> >       0.00           +45.5       45.51 =C4=85 14%  perf-profile.calltra=
ce.cycles-pp.btrfs_log_inode.log_new_dir_dentries.btrfs_log_inode_parent.bt=
rfs_log_new_name.btrfs_link
> >       0.00           +46.9       46.92 =C4=85 13%  perf-profile.calltra=
ce.cycles-pp.log_new_dir_dentries.btrfs_log_inode_parent.btrfs_log_new_name=
.btrfs_link.vfs_link
> >       0.00           +49.4       49.36 =C4=85 12%  perf-profile.calltra=
ce.cycles-pp.btrfs_log_new_name.btrfs_link.vfs_link.do_linkat.__x64_sys_lin=
k
> >       0.00           +49.4       49.36 =C4=85 12%  perf-profile.calltra=
ce.cycles-pp.btrfs_log_inode_parent.btrfs_log_new_name.btrfs_link.vfs_link.=
do_linkat
> >      30.52 =C4=85  3%     -28.4        2.16 =C4=85158%  perf-profile.ch=
ildren.cycles-pp.do_unlinkat
> >      30.35 =C4=85  3%     -28.2        2.15 =C4=85158%  perf-profile.ch=
ildren.cycles-pp.vfs_unlink
> >      30.28 =C4=85  3%     -28.1        2.15 =C4=85158%  perf-profile.ch=
ildren.cycles-pp.btrfs_unlink
> >      29.86 =C4=85  3%     -27.8        2.11 =C4=85158%  perf-profile.ch=
ildren.cycles-pp.btrfs_unlink_inode
> >      29.86 =C4=85  3%     -27.7        2.11 =C4=85158%  perf-profile.ch=
ildren.cycles-pp.__btrfs_unlink_inode
> >      19.65 =C4=85  4%     -18.3        1.36 =C4=85158%  perf-profile.ch=
ildren.cycles-pp.btrfs_add_link
> >      18.68 =C4=85  3%     -17.4        1.31 =C4=85158%  perf-profile.ch=
ildren.cycles-pp.btrfs_del_inode_ref
> >      12.52 =C4=85  4%     -11.6        0.88 =C4=85158%  perf-profile.ch=
ildren.cycles-pp.btrfs_insert_inode_ref
> >       9.38 =C4=85  4%      -8.7        0.64 =C4=85158%  perf-profile.ch=
ildren.cycles-pp.btrfs_lookup_dir_item
> >       6.93 =C4=85  4%      -6.5        0.46 =C4=85158%  perf-profile.ch=
ildren.cycles-pp.btrfs_insert_dir_item
> >       6.17 =C4=85  4%      -5.8        0.41 =C4=85158%  perf-profile.ch=
ildren.cycles-pp.insert_with_overflow
> >      29.64 =C4=85  3%      -3.0       26.61 =C4=85  6%  perf-profile.ch=
ildren.cycles-pp.osq_lock
> >       3.23 =C4=85 10%      -2.9        0.30 =C4=85117%  perf-profile.ch=
ildren.cycles-pp.ret_from_fork
> >       3.23 =C4=85 10%      -2.9        0.30 =C4=85117%  perf-profile.ch=
ildren.cycles-pp.kthread
> >       0.63 =C4=85 11%      -0.4        0.20 =C4=85 51%  perf-profile.ch=
ildren.cycles-pp.poll_idle
> >       0.73 =C4=85  3%      -0.4        0.32 =C4=85 26%  perf-profile.ch=
ildren.cycles-pp.btrfs_set_token_32
> >       0.50 =C4=85  7%      -0.4        0.11 =C4=85 55%  perf-profile.ch=
ildren.cycles-pp.__btrfs_release_delayed_node
> >       1.06 =C4=85  5%      -0.4        0.68 =C4=85 19%  perf-profile.ch=
ildren.cycles-pp.unlock_up
> >       0.65 =C4=85  8%      -0.4        0.28 =C4=85 28%  perf-profile.ch=
ildren.cycles-pp.btrfs_get_token_32
> >       0.50 =C4=85 10%      -0.2        0.27 =C4=85 24%  perf-profile.ch=
ildren.cycles-pp.check_setget_bounds
> >       1.02 =C4=85  7%      -0.2        0.79 =C4=85 17%  perf-profile.ch=
ildren.cycles-pp.setup_items_for_insert
> >       0.39 =C4=85  6%      -0.2        0.19 =C4=85 17%  perf-profile.ch=
ildren.cycles-pp.memmove
> >       0.45 =C4=85  8%      -0.2        0.28 =C4=85 24%  perf-profile.ch=
ildren.cycles-pp.down_write
> >       0.32 =C4=85  8%      -0.2        0.15 =C4=85 34%  perf-profile.ch=
ildren.cycles-pp.up_write
> >       0.31 =C4=85  7%      -0.1        0.17 =C4=85 14%  perf-profile.ch=
ildren.cycles-pp.memmove_extent_buffer
> >       0.21 =C4=85  9%      -0.1        0.07 =C4=85 61%  perf-profile.ch=
ildren.cycles-pp.mutex_lock
> >       0.18 =C4=85 11%      -0.1        0.10 =C4=85 26%  perf-profile.ch=
ildren.cycles-pp.__list_del_entry_valid
> >       0.17 =C4=85  6%      -0.1        0.09 =C4=85 27%  perf-profile.ch=
ildren.cycles-pp.kmem_cache_alloc
> >       0.14 =C4=85 10%      -0.1        0.07 =C4=85 29%  perf-profile.ch=
ildren.cycles-pp.__might_sleep
> >       0.15 =C4=85 10%      -0.1        0.08 =C4=85 25%  perf-profile.ch=
ildren.cycles-pp.___might_sleep
> >       0.12 =C4=85 11%      -0.1        0.07 =C4=85 15%  perf-profile.ch=
ildren.cycles-pp.btrfs_reserve_metadata_bytes
> >       0.12 =C4=85 10%      -0.0        0.07 =C4=85 13%  perf-profile.ch=
ildren.cycles-pp.__reserve_bytes
> >       0.07 =C4=85  9%      +0.0        0.11 =C4=85 11%  perf-profile.ch=
ildren.cycles-pp.leaf_space_used
> >       0.15 =C4=85  8%      +0.1        0.20 =C4=85 11%  perf-profile.ch=
ildren.cycles-pp.btrfs_get_32
> >       0.00            +0.1        0.06 =C4=85 12%  perf-profile.childre=
n.cycles-pp.fill_inode_item
> >       0.00            +0.1        0.07 =C4=85 19%  perf-profile.childre=
n.cycles-pp.btrfs_release_extent_buffer_pages
> >       0.00            +0.1        0.07 =C4=85 26%  perf-profile.childre=
n.cycles-pp.btree_read_extent_buffer_pages
> >       0.00            +0.1        0.08 =C4=85 27%  perf-profile.childre=
n.cycles-pp.insert_dir_log_key
> >       0.03 =C4=85 86%      +0.1        0.11 =C4=85 16%  perf-profile.ch=
ildren.cycles-pp.btrfs_buffer_uptodate
> >       0.10 =C4=85 10%      +0.1        0.18 =C4=85 16%  perf-profile.ch=
ildren.cycles-pp.btrfs_bin_search
> >       0.24 =C4=85 10%      +0.1        0.32 =C4=85  7%  perf-profile.ch=
ildren.cycles-pp.btrfs_comp_cpu_keys
> >       0.00            +0.1        0.09 =C4=85 19%  perf-profile.childre=
n.cycles-pp.tree_search_offset
> >       0.00            +0.1        0.09 =C4=85 18%  perf-profile.childre=
n.cycles-pp.btrfs_use_block_rsv
> >       0.00            +0.1        0.09 =C4=85 25%  perf-profile.childre=
n.cycles-pp.xas_load
> >       0.00            +0.1        0.09 =C4=85 13%  perf-profile.childre=
n.cycles-pp.btrfs_commit_inode_delayed_inode
> >       0.00            +0.1        0.10 =C4=85 22%  perf-profile.childre=
n.cycles-pp.fixup_low_keys
> >       0.00            +0.1        0.11 =C4=85 23%  perf-profile.childre=
n.cycles-pp.del_ptr
> >       0.00            +0.1        0.11 =C4=85 25%  perf-profile.childre=
n.cycles-pp.insert_ptr
> >       0.00            +0.1        0.13 =C4=85 23%  perf-profile.childre=
n.cycles-pp.try_merge_free_space
> >       0.09 =C4=85 22%      +0.1        0.24 =C4=85 12%  perf-profile.ch=
ildren.cycles-pp.release_extent_buffer
> >       0.00            +0.2        0.17 =C4=85 23%  perf-profile.childre=
n.cycles-pp.btree_clear_page_dirty
> >       0.13 =C4=85  8%      +0.2        0.31 =C4=85 15%  perf-profile.ch=
ildren.cycles-pp.__radix_tree_lookup
> >       0.00            +0.2        0.19 =C4=85 20%  perf-profile.childre=
n.cycles-pp.pagecache_get_page
> >       0.18 =C4=85  9%      +0.2        0.37 =C4=85 19%  perf-profile.ch=
ildren.cycles-pp.btrfs_get_64
> >       0.00            +0.2        0.20 =C4=85 22%  perf-profile.childre=
n.cycles-pp.__set_page_dirty_nobuffers
> >       0.00            +0.2        0.23 =C4=85 23%  perf-profile.childre=
n.cycles-pp.clear_extent_buffer_dirty
> >       0.10 =C4=85  6%      +0.3        0.38 =C4=85 31%  perf-profile.ch=
ildren.cycles-pp.__push_leaf_left
> >       0.07 =C4=85 18%      +0.3        0.39 =C4=85 18%  perf-profile.ch=
ildren.cycles-pp.set_extent_buffer_dirty
> >       0.10 =C4=85 10%      +0.3        0.43 =C4=85 17%  perf-profile.ch=
ildren.cycles-pp.btrfs_mark_buffer_dirty
> >       0.00            +0.4        0.35 =C4=85 19%  perf-profile.childre=
n.cycles-pp.read_tree_block
> >       0.12 =C4=85  7%      +0.4        0.55 =C4=85 30%  perf-profile.ch=
ildren.cycles-pp.push_leaf_left
> >       0.09 =C4=85 13%      +0.6        0.64 =C4=85 16%  perf-profile.ch=
ildren.cycles-pp.alloc_extent_buffer
> >       0.00            +0.6        0.59 =C4=85 30%  perf-profile.childre=
n.cycles-pp.copy_for_split
> >       0.00            +0.6        0.59 =C4=85 14%  perf-profile.childre=
n.cycles-pp.btrfs_read_node_slot
> >       0.56 =C4=85  8%      +0.6        1.17 =C4=85 14%  perf-profile.ch=
ildren.cycles-pp.generic_bin_search
> >       0.00            +0.8        0.82 =C4=85 20%  perf-profile.childre=
n.cycles-pp.copy_extent_buffer
> >       0.00            +0.9        0.91 =C4=85 19%  perf-profile.childre=
n.cycles-pp.btrfs_unlock_up_safe
> >       0.09 =C4=85 10%      +1.0        1.10 =C4=85 16%  perf-profile.ch=
ildren.cycles-pp.read_extent_buffer
> >       0.00            +1.0        1.05 =C4=85 99%  perf-profile.childre=
n.cycles-pp.find_free_extent
> >       0.00            +1.1        1.07 =C4=85 98%  perf-profile.childre=
n.cycles-pp.btrfs_reserve_extent
> >       0.05 =C4=85 43%      +1.6        1.67 =C4=85 64%  perf-profile.ch=
ildren.cycles-pp.btrfs_alloc_tree_block
> >       0.49 =C4=85  8%      +1.8        2.31 =C4=85 83%  perf-profile.ch=
ildren.cycles-pp.native_queued_spin_lock_slowpath
> >       0.00            +1.8        1.83 =C4=85 13%  perf-profile.childre=
n.cycles-pp.btrfs_search_forward
> >       0.00            +2.0        2.01 =C4=85 18%  perf-profile.childre=
n.cycles-pp.overwrite_item
> >       0.00            +2.1        2.14 =C4=85 18%  perf-profile.childre=
n.cycles-pp.log_directory_changes
> >       0.00            +2.1        2.14 =C4=85 18%  perf-profile.childre=
n.cycles-pp.log_dir_items
> >       0.55 =C4=85  5%      +2.2        2.72 =C4=85 41%  perf-profile.ch=
ildren.cycles-pp.split_leaf
> >       0.25 =C4=85 16%      +2.6        2.87 =C4=85 75%  perf-profile.ch=
ildren.cycles-pp.btrfs_del_leaf
> >       1.14 =C4=85  5%      +2.8        3.92 =C4=85 54%  perf-profile.ch=
ildren.cycles-pp.btrfs_del_items
> >      17.66 =C4=85  4%      +4.7       22.37 =C4=85  6%  perf-profile.ch=
ildren.cycles-pp.btrfs_insert_empty_items
> >       0.00           +21.9       21.87 =C4=85 16%  perf-profile.childre=
n.cycles-pp.drop_objectid_items
> >       0.00           +21.9       21.90 =C4=85 14%  perf-profile.childre=
n.cycles-pp.copy_items
> >      21.17 =C4=85  4%     +29.7       50.85 =C4=85  8%  perf-profile.ch=
ildren.cycles-pp.__x64_sys_link
> >      21.17 =C4=85  4%     +29.7       50.85 =C4=85  8%  perf-profile.ch=
ildren.cycles-pp.do_linkat
> >      20.22 =C4=85  4%     +30.6       50.78 =C4=85  8%  perf-profile.ch=
ildren.cycles-pp.vfs_link
> >      20.17 =C4=85  4%     +30.6       50.78 =C4=85  8%  perf-profile.ch=
ildren.cycles-pp.btrfs_link
> >       0.00           +46.9       46.92 =C4=85 13%  perf-profile.childre=
n.cycles-pp.log_new_dir_dentries
> >       0.00           +47.9       47.94 =C4=85 13%  perf-profile.childre=
n.cycles-pp.btrfs_log_inode
> >       0.00           +49.4       49.36 =C4=85 12%  perf-profile.childre=
n.cycles-pp.btrfs_log_new_name
> >       0.00           +49.4       49.36 =C4=85 12%  perf-profile.childre=
n.cycles-pp.btrfs_log_inode_parent
> >      29.45 =C4=85  3%      -3.0       26.45 =C4=85  6%  perf-profile.se=
lf.cycles-pp.osq_lock
> >       0.60 =C4=85 11%      -0.4        0.19 =C4=85 54%  perf-profile.se=
lf.cycles-pp.poll_idle
> >       0.55 =C4=85  4%      -0.3        0.24 =C4=85 25%  perf-profile.se=
lf.cycles-pp.btrfs_set_token_32
> >       0.53 =C4=85  8%      -0.3        0.22 =C4=85 28%  perf-profile.se=
lf.cycles-pp.btrfs_get_token_32
> >       0.92 =C4=85  5%      -0.3        0.62 =C4=85  9%  perf-profile.se=
lf.cycles-pp._raw_spin_lock
> >       0.38 =C4=85  6%      -0.2        0.18 =C4=85 20%  perf-profile.se=
lf.cycles-pp.memmove
> >       0.34 =C4=85  5%      -0.2        0.14 =C4=85 36%  perf-profile.se=
lf.cycles-pp.find_extent_buffer_nolock
> >       0.41 =C4=85  9%      -0.2        0.23 =C4=85 25%  perf-profile.se=
lf.cycles-pp.check_setget_bounds
> >       0.31 =C4=85  7%      -0.2        0.14 =C4=85 35%  perf-profile.se=
lf.cycles-pp.up_write
> >       0.17 =C4=85  9%      -0.1        0.05 =C4=85 96%  perf-profile.se=
lf.cycles-pp.mutex_lock
> >       0.31 =C4=85  6%      -0.1        0.20 =C4=85 24%  perf-profile.se=
lf.cycles-pp.down_write
> >       0.18 =C4=85  9%      -0.1        0.10 =C4=85 25%  perf-profile.se=
lf.cycles-pp.__list_del_entry_valid
> >       0.14 =C4=85 10%      -0.1        0.06 =C4=85 47%  perf-profile.se=
lf.cycles-pp.__might_sleep
> >       0.14 =C4=85  9%      -0.1        0.08 =C4=85 25%  perf-profile.se=
lf.cycles-pp.___might_sleep
> >       0.04 =C4=85 41%      +0.1        0.10 =C4=85 10%  perf-profile.se=
lf.cycles-pp.unlock_up
> >       0.00            +0.1        0.07 =C4=85 17%  perf-profile.self.cy=
cles-pp.alloc_extent_buffer
> >       0.10 =C4=85 10%      +0.1        0.18 =C4=85 16%  perf-profile.se=
lf.cycles-pp.btrfs_bin_search
> >       0.00            +0.1        0.08 =C4=85 12%  perf-profile.self.cy=
cles-pp.btrfs_read_node_slot
> >       0.23 =C4=85  9%      +0.1        0.31 =C4=85  8%  perf-profile.se=
lf.cycles-pp.btrfs_comp_cpu_keys
> >       0.00            +0.1        0.08 =C4=85 23%  perf-profile.self.cy=
cles-pp.xas_load
> >       0.00            +0.1        0.09 =C4=85 19%  perf-profile.self.cy=
cles-pp.tree_search_offset
> >       0.00            +0.1        0.10 =C4=85 22%  perf-profile.self.cy=
cles-pp.btrfs_buffer_uptodate
> >       0.06 =C4=85 15%      +0.1        0.18 =C4=85 15%  perf-profile.se=
lf.cycles-pp.set_extent_buffer_dirty
> >       0.00            +0.1        0.13 =C4=85 24%  perf-profile.self.cy=
cles-pp.pagecache_get_page
> >       0.13 =C4=85  5%      +0.1        0.28 =C4=85 17%  perf-profile.se=
lf.cycles-pp.btrfs_get_64
> >       0.12 =C4=85  9%      +0.2        0.30 =C4=85 14%  perf-profile.se=
lf.cycles-pp.__radix_tree_lookup
> >       0.00            +0.2        0.18 =C4=85 17%  perf-profile.self.cy=
cles-pp.btrfs_search_forward
> >       0.34 =C4=85 10%      +0.5        0.85 =C4=85 17%  perf-profile.se=
lf.cycles-pp.generic_bin_search
> >       0.09 =C4=85 11%      +1.0        1.09 =C4=85 16%  perf-profile.se=
lf.cycles-pp.read_extent_buffer
> >       0.49 =C4=85  8%      +1.8        2.27 =C4=85 83%  perf-profile.se=
lf.cycles-pp.native_queued_spin_lock_slowpath
> >
> >
> >
> >                          stress-ng.time.file_system_outputs
> >
> >   6e+07 +--------------------------------------------------------------=
-----+
> >         |               O                                              =
     |
> >   5e+07 |-+ O    O O  O        O     OO   O O  O     O                 =
     |
> >         |      O            O                 O  O     OO              =
     |
> >         |    O       O    O  O     O    O          O                   =
     |
> >   4e+07 |-O                      O                                     =
     |
> >         |                                                              =
     |
> >   3e+07 |-+                                                            =
     |
> >         |                                                              =
     |
> >   2e+07 |-+                                                            =
     |
> >         |                                                              =
     |
> >         |                                                              =
     |
> >   1e+07 |-+                                                            =
     |
> >         |                                                              =
     |
> >       0 +--------------------------------------------------------------=
-----+
> >
> >
> >                                 stress-ng.link.ops
> >
> >   250 +----------------------------------------------------------------=
-----+
> >       |   +.++.+.+.+.+. +. .+.+. .++.+.+.+.+.+.+ .+.+.+.+.++.+. .+.+.++=
   +.|
> >       |                +  +     +               +              +       =
     |
> >   200 |-+                                                              =
     |
> >       |                                                                =
     |
> >       |                                                                =
     |
> >   150 |-+                                                              =
     |
> >       |                                                                =
     |
> >   100 |-+                                                              =
     |
> >       |                                                                =
     |
> >       |                                                                =
     |
> >    50 |-+    O                    O    O     O      O O O              =
     |
> >       | O O O  O O O O OO O O O O  O O   O O   OO O                    =
     |
> >       |                                                                =
     |
> >     0 +----------------------------------------------------------------=
-----+
> >
> >
> >                             stress-ng.link.ops_per_sec
> >
> >   4.5 +----------------------------------------------------------------=
-----+
> >       |                                                                =
     |
> >     4 |.+.+.++.+.+.+.+. +. .+.   .+ .+.+.+.+.      .+.+.+.++.+.     .+ =
.+.+.|
> >   3.5 |-+              +  +   +.+  +         +.++.+            +.+.+  +=
     |
> >       |                                                                =
     |
> >     3 |-+                                                              =
     |
> >   2.5 |-+                                                              =
     |
> >       |                                                                =
     |
> >     2 |-+                                                              =
     |
> >   1.5 |-+                                                              =
     |
> >       |                                                                =
     |
> >     1 |-+                                                              =
     |
> >   0.5 |-+ O OO O O O O OO O O O O OO O O O O O OO O O O O              =
     |
> >       | O                                                              =
     |
> >     0 +----------------------------------------------------------------=
-----+
> >
> >
> > [*] bisect-good sample
> > [O] bisect-bad  sample
> >
> >
> >
> > Disclaimer:
> > Results have been estimated based on internal Intel analysis and are pr=
ovided
> > for informational purposes only. Any difference in system hardware or s=
oftware
> > design or configuration may affect actual performance.
> >
> >
> > ---
> > 0DAY/LKP+ Test Infrastructure                   Open Source Technology =
Center
> > https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corpo=
ration
> >
> > Thanks,
> > Oliver Sang
> >
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
