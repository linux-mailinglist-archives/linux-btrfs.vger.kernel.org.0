Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816885A60AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Aug 2022 12:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiH3KXT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 06:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiH3KWw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 06:22:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B4C74B88;
        Tue, 30 Aug 2022 03:22:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 729FE614C3;
        Tue, 30 Aug 2022 10:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8471C433D6;
        Tue, 30 Aug 2022 10:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661854940;
        bh=mttadZTY30pjSdXU9ij3tsEtiy8cJl4Ly46BtNIgMy0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=axBKZaYxl3mnHQ18lzeYwnj/4nQzRUI2cWYqb/dXS5AcmWPqOJxVczRpdPM9tvkut
         V9pyAPbRJ0on6bm7jYLs+S0UJ38hrJptUzseqPmzK8JsjjMW0mIwkO3vUfQIzqDJON
         VTc5GQDnqp/hiI16nLRKvLjByR/nKjGAVr0F3bD6K3P38Yn0DAfDIAWQg6gSe3WJiJ
         Yj3CnplXfRJbJpZXwTgqktCFVs7wgaphFSpHms/NxMSbEPLDSpzfBM8EvQZyUas0lI
         geL0sMS2F7bmlGUX2nIsKNhTcTcYsBjspTx4clsxOyT8uA8QTNzBF/PUOPL7o/Si0I
         2B9rYs/upZ8pQ==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-11f34610d4aso4800769fac.9;
        Tue, 30 Aug 2022 03:22:20 -0700 (PDT)
X-Gm-Message-State: ACgBeo334jwTL33+JLryJvz6VgunywYb15PgUZYOUinkfPifSM4L4xfx
        KwkA+jVCYQtY5Kp7y8YQiCK5TQbKETx3Z20FJrA=
X-Google-Smtp-Source: AA6agR5KRkyvyNBA/tBvmc34DnNOV0R2u0XV7KmXfZxmWWYNv7oxUwEH3ruESPuiZD3Vt84WBA4QYasR7/MH5saZc1s=
X-Received: by 2002:a05:6870:538c:b0:11b:e64f:ee1b with SMTP id
 h12-20020a056870538c00b0011be64fee1bmr9634439oan.92.1661854940036; Tue, 30
 Aug 2022 03:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220830030032.GA2884@inn2.lkp.intel.com> <eb352106-5a3c-63fe-2409-494cf0a31bfc@intel.com>
 <4b5d1c96-44c5-e8bb-01d8-9f9c72621d0d@intel.com>
In-Reply-To: <4b5d1c96-44c5-e8bb-01d8-9f9c72621d0d@intel.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 30 Aug 2022 11:21:43 +0100
X-Gmail-Original-Message-ID: <CAL3q7H78qPSp4O=ZrCCNFwX+6L4gZgn-A5q3VydvhTfkVDEUDQ@mail.gmail.com>
Message-ID: <CAL3q7H78qPSp4O=ZrCCNFwX+6L4gZgn-A5q3VydvhTfkVDEUDQ@mail.gmail.com>
Subject: Re: [LKP] [btrfs] ca6dee6b79: fxmark.ssd_btrfs_MWRM_72_bufferedio.works/sec
 -8.4% regression
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     Filipe Manana <fdmanana@suse.com>, lkp@lists.01.org, lkp@intel.com,
        David Sterba <dsterba@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        fengwei.yin@intel.com, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 30, 2022 at 7:58 AM Yujie Liu <yujie.liu@intel.com> wrote:
>
> Hi Filipe,
>
> We noticed that this case was reported when the patch was in linux-next.
> Thanks for your comment that it is an expected result due to heavy rename=
.
>
> https://lore.kernel.org/all/Ysb4T7Z8hKgdvPRk@xsang-OptiPlex-9020/
>
> This report is due to the patch being merged into mainline, if it is stil=
l
> the same case, please ignore this duplicate report. Sorry for the inconve=
nience.

Yes, it's the same.
Thanks Yujie.

>
> --
> Thanks,
> Yujie
>
> On 8/30/2022 11:17, kernel test robot wrote:
> > Greeting,
> >
> > FYI, we noticed a -8.4% regression of fxmark.ssd_btrfs_MWRM_72_buffered=
io.works/sec due to commit:
> >
> >
> > commit: ca6dee6b7946794fa340a7290ca399a50b61705f ("btrfs: balance btree=
 dirty pages and delayed items after a rename")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > in testcase: fxmark
> > on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 C=
PU @ 2.60GHz (Ice Lake) with 128G memory
> > with following parameters:
> >
> >      disk: 1SSD
> >      media: ssd
> >      test: MWRM
> >      fstype: btrfs
> >      directio: bufferedio
> >      cpufreq_governor: performance
> >      ucode: 0xd000363
> >
> > test-description: FxMark is a filesystem benchmark that test multicore =
scalability.
> > test-url: https://github.com/sslab-gatech/fxmark
> >
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbo=
x_group/test/testcase/ucode:
> >    gcc-11/performance/bufferedio/1SSD/btrfs/x86_64-rhel-8.3/ssd/debian-=
11.1-x86_64-20220510.cgz/lkp-icl-2sp5/MWRM/fxmark/0xd000363
> >
> > commit:
> >    b8bea09a45 ("btrfs: add trace event for submitted RAID56 bio")
> >    ca6dee6b79 ("btrfs: balance btree dirty pages and delayed items afte=
r a rename")
> >
> > b8bea09a456fc31a ca6dee6b7946794fa340a7290ca
> > ---------------- ---------------------------
> >           %stddev     %change         %stddev
> >               \          |                \
> >     1821853           -13.9%    1568247 =C2=B1  3%  fxmark.ssd_btrfs_MW=
RM_36_bufferedio.works
> >       36436           -13.9%      31362 =C2=B1  3%  fxmark.ssd_btrfs_MW=
RM_36_bufferedio.works/sec
> >     1675102           -14.0%    1439994 =C2=B1  7%  fxmark.ssd_btrfs_MW=
RM_54_bufferedio.works
> >       33497           -14.0%      28796 =C2=B1  7%  fxmark.ssd_btrfs_MW=
RM_54_bufferedio.works/sec
> >     1572332            -8.4%    1440600 =C2=B1  6%  fxmark.ssd_btrfs_MW=
RM_72_bufferedio.works
> >       31445            -8.4%      28809 =C2=B1  6%  fxmark.ssd_btrfs_MW=
RM_72_bufferedio.works/sec
> >      356010           +80.0%     640832        fxmark.time.involuntary_=
context_switches
> >       68.50           -24.1%      52.00        fxmark.time.percent_of_c=
pu_this_job_got
> >      630.47           -24.0%     479.23        fxmark.time.system_time
> >   1.335e+10           +49.8%      2e+10        cpuidle..time
> >        1045 =C2=B1  4%     +11.8%       1168        uptime.idle
> >       31.54           +50.2%      47.37        iostat.cpu.idle
> >       64.16           -24.7%      48.29        iostat.cpu.system
> >       31.17           +50.3%      46.83        vmstat.cpu.id
> >       12.83 =C2=B1  5%     -55.8%       5.67 =C2=B1  8%  vmstat.procs.r
> >       32.13           +15.8       47.95        mpstat.cpu.all.idle%
> >        0.47 =C2=B1  7%      +0.1        0.53 =C2=B1  3%  mpstat.cpu.all=
.iowait%
> >       63.37           -16.1       47.31        mpstat.cpu.all.sys%
> >       10.04 =C2=B1  3%     +13.5%      11.39 =C2=B1  3%  perf-stat.i.me=
tric.K/sec
> >      869.81 =C2=B1 10%     -16.2%     728.74 =C2=B1 15%  perf-stat.i.no=
de-loads
> >      871.23 =C2=B1 10%     -16.2%     730.49 =C2=B1 15%  perf-stat.ps.n=
ode-loads
> >        3004 =C2=B1  8%     -52.1%       1440 =C2=B1  6%  numa-meminfo.n=
ode0.Active(anon)
> >     1218568           -10.8%    1086453        numa-meminfo.node0.Inact=
ive
> >      351812 =C2=B1  3%     -29.0%     249640 =C2=B1 12%  numa-meminfo.n=
ode0.Inactive(anon)
> >      120150           -79.3%      24861 =C2=B1  3%  numa-meminfo.node0.=
Shmem
> >        3489 =C2=B1  8%     -45.0%       1919 =C2=B1  2%  meminfo.Active=
(anon)
> >      492107           -19.0%     398809        meminfo.Committed_AS
> >      382253           -24.6%     288151        meminfo.Inactive(anon)
> >      124727           -76.8%      28886 =C2=B1  2%  meminfo.Shmem
> >        2050 =C2=B1  4%     -10.5%       1834 =C2=B1  5%  meminfo.Writeb=
ack
> >      750.83 =C2=B1  8%     -52.1%     360.00 =C2=B1  6%  numa-vmstat.no=
de0.nr_active_anon
> >       87951 =C2=B1  3%     -29.0%      62408 =C2=B1 12%  numa-vmstat.no=
de0.nr_inactive_anon
> >       30038           -79.3%       6216 =C2=B1  3%  numa-vmstat.node0.n=
r_shmem
> >      750.83 =C2=B1  8%     -52.1%     360.00 =C2=B1  6%  numa-vmstat.no=
de0.nr_zone_active_anon
> >       87951 =C2=B1  3%     -29.0%      62408 =C2=B1 12%  numa-vmstat.no=
de0.nr_zone_inactive_anon
> >     7554028 =C2=B1  3%     -71.2%    2174126 =C2=B1  5%  sched_debug.cf=
s_rq:/.min_vruntime.avg
> >     7640393 =C2=B1  3%     -70.5%    2254050 =C2=B1  5%  sched_debug.cf=
s_rq:/.min_vruntime.max
> >     7291209 =C2=B1  3%     -73.6%    1926973 =C2=B1  5%  sched_debug.cf=
s_rq:/.min_vruntime.min
> >      873.62 =C2=B1  7%     -19.2%     705.68 =C2=B1 10%  sched_debug.cf=
s_rq:/.runnable_avg.avg
> >      790.32 =C2=B1  7%     -21.4%     621.34 =C2=B1 12%  sched_debug.cf=
s_rq:/.runnable_avg.min
> >      747.11 =C2=B1  3%     -22.7%     577.37 =C2=B1  3%  sched_debug.cf=
s_rq:/.util_avg.avg
> >      670.92 =C2=B1  5%     -25.2%     501.70 =C2=B1  2%  sched_debug.cf=
s_rq:/.util_avg.min
> >      409.44 =C2=B1  9%     -35.1%     265.80 =C2=B1 21%  sched_debug.cf=
s_rq:/.util_est_enqueued.avg
> >      789.44 =C2=B1  3%     -20.1%     630.53 =C2=B1  5%  sched_debug.cf=
s_rq:/.util_est_enqueued.max
> >        0.00 =C2=B1 13%     -67.3%       0.00 =C2=B1 22%  sched_debug.cp=
u.next_balance.stddev
> >      872.67 =C2=B1  8%     -45.0%     479.83 =C2=B1  2%  proc-vmstat.nr=
_active_anon
> >     1801345            -1.7%    1771330        proc-vmstat.nr_file_page=
s
> >       95550           -24.6%      72037        proc-vmstat.nr_inactive_=
anon
> >        8752            -3.7%       8426        proc-vmstat.nr_mapped
> >       31169           -76.8%       7221 =C2=B1  2%  proc-vmstat.nr_shme=
m
> >      872.67 =C2=B1  8%     -45.0%     479.83 =C2=B1  2%  proc-vmstat.nr=
_zone_active_anon
> >       95550           -24.6%      72037        proc-vmstat.nr_zone_inac=
tive_anon
> >        9553 =C2=B1 10%     -16.8%       7950 =C2=B1  3%  proc-vmstat.nu=
ma_hint_faults
> >    18886391            -3.6%   18207624        proc-vmstat.numa_hit
> >    18770999            -3.6%   18091363        proc-vmstat.numa_local
> >     7398756            -4.0%    7105675        proc-vmstat.pgactivate
> >    18885154            -3.6%   18206666        proc-vmstat.pgalloc_norm=
al
> >     7248262            -4.3%    6933915 =C2=B1  2%  proc-vmstat.pgdeact=
ivate
> >    18894473            -3.4%   18243898        proc-vmstat.pgfree
> >     7829962            -3.0%    7596447 =C2=B1  2%  proc-vmstat.pgrotat=
ed
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <yujie.liu@intel.com>
> >
> >
> > To reproduce:
> >
> >          git clone https://github.com/intel/lkp-tests.git
> >          cd lkp-tests
> >          sudo bin/lkp install job.yaml           # job file is attached=
 in this email
> >          bin/lkp split-job --compatible job.yaml # generate the yaml fi=
le for lkp run
> >          sudo bin/lkp run generated-yaml-file
> >
> >          # if come across any failure that blocks the test,
> >          # please remove ~/.lkp and /lkp dir to run from a clean state.
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
> > #regzbot introduced: ca6dee6b79
> >
> >
> >
> > _______________________________________________
> > LKP mailing list -- lkp@lists.01.org
> > To unsubscribe send an email to lkp-leave@lists.01.org
