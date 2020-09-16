Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1678426BC9E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 08:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgIPGTv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 02:19:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:15482 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgIPGTl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 02:19:41 -0400
IronPort-SDR: I7pZWyAr58yozRiRusU62RH7bqG/Qw8DqiWv022M+QUiykfutqMalKUpf9ItLWU04PQnWIHDi2
 TpHmuiw7Tlug==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="220966689"
X-IronPort-AV: E=Sophos;i="5.76,431,1592895600"; 
   d="scan'208";a="220966689"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 23:19:39 -0700
IronPort-SDR: Ibqm5qpjKvhGIfFU6YdetdI7O1fjrxYMBGTiYKz+CtzGe8F5QejAWpM6LlYecQSS0jNKmZ1WBH
 Bjl05ADMU5lw==
X-IronPort-AV: E=Sophos;i="5.76,431,1592895600"; 
   d="scan'208";a="483162899"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 23:19:37 -0700
Date:   Wed, 16 Sep 2020 14:31:17 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [btrfs] 3b54a0a703:
 WARNING:at_fs/btrfs/inode.c:#btrfs_finish_ordered_io[btrfs]
Message-ID: <20200916063117.GB31649@xsang-OptiPlex-9020>
References: <20200909070857.GA25950@xsang-OptiPlex-9020>
 <29350c54-fb8e-433e-404c-d72c83f3989a@suse.com>
 <20200915055411.GC17463@xsang-OptiPlex-9020>
 <4ea5f2ba-df33-114a-3cfa-4d7dd35c04c3@suse.com>
 <4d3b8b3a-31b7-4476-e83c-e9894ceed0d3@suse.com>
 <20200916033233.GA31649@xsang-OptiPlex-9020>
 <15b3efac-3e69-a212-6fbe-179df3cc6a11@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15b3efac-3e69-a212-6fbe-179df3cc6a11@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 16, 2020 at 12:20:12PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/9/16 上午11:32, Oliver Sang wrote:
> > On Tue, Sep 15, 2020 at 04:00:40PM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2020/9/15 下午3:40, Qu Wenruo wrote:
> >>>
> >>>
> >>> On 2020/9/15 下午1:54, Oliver Sang wrote:
> >>>> On Wed, Sep 09, 2020 at 03:49:30PM +0800, Qu Wenruo wrote:
> >>>>>
> >>>>>
> >>>>> On 2020/9/9 下午3:08, kernel test robot wrote:
> >>>>>> Greeting,
> >>>>>>
> >>>>>> FYI, we noticed the following commit (built with gcc-9):
> >>>>>>
> >>>>>> commit: 3b54a0a703f17d2b1317d24beefcdcca587a7667 ("[PATCH v3 3/5] btrfs: Detect unbalanced tree with empty leaf before crashing btree operations")
> >>>>>> url: https://github.com/0day-ci/linux/commits/Qu-Wenruo/btrfs-Enhanced-runtime-defence-against-fuzzed-images/20200809-201720
> >>>>>> base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
> >>>>>>
> >>>>>> in testcase: fio-basic
> >>>>>> with following parameters:
> >>>>>>
> >>>>>> 	runtime: 300s
> >>>>>> 	disk: 1SSD
> >>>>>> 	fs: btrfs
> >>>>>> 	nr_task: 100%
> >>>>>> 	test_size: 128G
> >>>>>> 	rw: write
> >>>>>> 	bs: 4k
> >>>>>> 	ioengine: sync
> >>>>>> 	cpufreq_governor: performance
> >>>>>> 	ucode: 0x400002c
> >>>>>> 	fs2: nfsv4
> >>>>>>
> >>>>>> test-description: Fio is a tool that will spawn a number of threads or processes doing a particular type of I/O action as specified by the user.
> >>>>>> test-url: https://github.com/axboe/fio
> >>>>>>
> >>>>>>
> >>>>>> on test machine: 96 threads Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz with 128G memory
> >>>>>>
> >>>>>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >>>>>>
> >>>>>>
> >>>>>> +----------------------------------------------------------------------------+------------+------------+
> >>>>>> |                                                                            | 2703206ff5 | 3b54a0a703 |
> >>>>>> +----------------------------------------------------------------------------+------------+------------+
> >>>>>> | boot_successes                                                             | 9          | 0          |
> >>>>>> | boot_failures                                                              | 4          |            |
> >>>>>> | Kernel_panic-not_syncing:VFS:Unable_to_mount_root_fs_on_unknown-block(#,#) | 4          |            |
> >>>>>> +----------------------------------------------------------------------------+------------+------------+
> >>>>>>
> >>>>>>
> >>>>>> If you fix the issue, kindly add following tag
> >>>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
> >>>>>>
> >>>>>>
> >>>>>
> >>>>> According to the full dmesg, it's invalid nritems causing transaction abort.
> >>>>>
> >>>>> I'm not sure if it's caused by corrupts fs or something else.
> >>>>>
> >>>>> If intel guys can reproduce it reliably, would you please add such debug
> >>>>> diff to output extra info?
> >>>>
> >>>> Hi Qu, sorry for late. we double confirmed the issue can be reproduced reliably.
> >>>> The error will only occur on fbc but not parent commit.
> >>>>
> >>>> below from applying your path for extra info
> >>>> [   42.539443] [task_0]$
> >>>> [   42.539445]~$
> >>>> [   42.546125] rw=write$
> >>>> [   42.546126]~$
> >>>> [   42.551637] directory=/fs/nvme1n1p1$
> >>>> [   42.551638]~$
> >>>> [   42.559135] numjobs=96' | fio --output-format=json -$
> >>>> [   42.559136]~$
> >>>> [   42.574513] perf version 5.9.rc4.g34d4ddd359db$
> >>>> [   42.574518]~$
> >>>> [   56.152662] BTRFS error (device nvme1n1p1): invalid tree nritems, bytenr=13238272 owner=7 level=0 first_key=(18446744073709551606 128 96941895680) nritems=0
> >>>>  expect >0$
> >>>
> >>> Just as expected, this is indeed csum tree.
> >>> And it looks like it's indeed still valid.
> >>>
> >>> The csum root can still have its key from previous not emptry csum.
> >>
> >> Wait for a minute, if it's csum root empty, we shouldn't have first_key
> >> passed in.
> >>
> >> So this still has something wrong.
> >>
> >> Would you please try this diff to provide more debug info?
> >> (Better to remove the existing diff)
> > 
> > Hi Qu, please find the attached kmsg-debug-2.xz.
> > also since I found two identical section in 3b54a0a703,
> > so I applied below patch to both places.
> > I also attached the final patch as 0001-debug-version-2.patch,
> > for you to check if there's problem.
> 
> Oh, that's the problem.
> 
> The patch I submitted has a bug that the check should only be after that
> generation check.
> 
> For live tree blocks (newer than last committed) tree blocks can be
> empty temporary.
> 
> The upstream has already merged the correct fix 62fdaa52a3d0 ("btrfs:
> Detect unbalanced tree with empty leaf before crashing btree operations").
> 
> Sorry for the false alert and inconvience.

Thanks for information!

> 
> Thanks,
> Qu
> 
> 
> > 
> >>
> >> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> >> index 75bbe879ed18..6f29a3c38b56 100644
> >> --- a/fs/btrfs/disk-io.c
> >> +++ b/fs/btrfs/disk-io.c
> >> @@ -400,10 +400,17 @@ int btrfs_verify_level_key(struct extent_buffer
> >> *eb, int level,
> >>
> >>         /* We have @first_key, so this @eb must have at least one item */
> >>         if (btrfs_header_nritems(eb) == 0) {
> >> +               pr_info("%s: eb start=%llu gen=%llu last_committed=%llu\n",
> >> +                       __func__, eb->start, btrfs_header_generation(eb),
> >> +                       fs_info->last_trans_committed);
> >>                 btrfs_err(fs_info,
> >>                 "invalid tree nritems, bytenr=%llu nritems=0 expect >0",
> >>                           eb->start);
> >> -               WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> >> +               pr_info("%s: csum tree commit root:\n", __func__);
> >> +               btrfs_print_tree(fs_info->csum_root->commit_root, true);
> >> +               pr_info("%s: csum tree current root:\n", __func__);
> >> +               btrfs_print_tree(fs_info->csum_root->node, true);
> >> +               WARN_ON(1);
> >>                 return -EUCLEAN;
> >>         }
> >>
> >>
> >>>
> >>> In that case, the check is indeed too strict and causes false alert.
> >>>
> >>> I'll soon send out a fix with Intel reported-by.
> >>>
> >>> Thanks,
> >>> Qu
> >>>
> >>>> [   56.152664] BTRFS error (device nvme1n1p1): invalid tree nritems, bytenr=13238272 owner=7 level=0 first_key=(18446744073709551606 128 96941895680) nritems=0
> >>>>  expect >0$
> >>>> [   56.152666] ------------[ cut here ]------------$
> >>>> [   56.168263] BTRFS: error (device nvme1n1p1) in btrfs_finish_ordered_io:2687: errno=-117 Filesystem corrupted$
> >>>> [   56.168264] BTRFS info (device nvme1n1p1): forced readonly$
> >>>> [   56.205009] BTRFS: Transaction aborted (error -117)$
> >>>> [   56.210368] WARNING: CPU: 71 PID: 537 at fs/btrfs/inode.c:2687 btrfs_finish_ordered_io+0x70a/0x820 [btrfs]$
> >>>> [   56.220466] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfsd auth_rpcgss dm_mod dax_pmem_compat nd_pmem device_dax nd_btt dax_pmem_core btrfs blak
> >>>> e2b_generic sr_mod xor cdrom sd_mod zstd_decompress sg zstd_compress raid6_pq libcrc32c intel_rapl_msr intel_rapl_common skx_edac x86_pkg_temp_thermal intel_po
> >>>> werclamp coretemp kvm_intel ipmi_ssif kvm irqbypass ast drm_vram_helper crct10dif_pclmul drm_ttm_helper crc32_pclmul ttm crc32c_intel ghash_clmulni_intel rapl
> >>>> drm_kms_helper acpi_ipmi syscopyarea intel_cstate sysfillrect ahci sysimgblt nvme libahci fb_sys_fops intel_uncore mei_me nvme_core ioatdma t10_pi drm mei liba
> >>>> ta joydev ipmi_si dca wmi ipmi_devintf ipmi_msghandler nfit libnvdimm ip_tables$
> >>>> [   56.285795] CPU: 71 PID: 537 Comm: kworker/u193:28 Not tainted 5.8.0-rc7-00166-g6e85ab8532a52 #1$
> >>>> [   56.295218] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]$
> >>>> [   56.302044] RIP: 0010:btrfs_finish_ordered_io+0x70a/0x820 [btrfs]$
> >>>> [   56.308762] Code: 48 0a 00 00 02 72 25 41 83 ff fb 0f 84 f2 00 00 00 41 83 ff e2 0f 84 e8 00 00 00 44 89 fe 48 c7 c7 a0 9c 2c c1 e8 58 2e ec bf <0f> 0b 44 8
> >>>> 9 f9 ba 7f 0a 00 00 48 c7 c6 50 c7 2b c1 48 89 df e8 15$
> >>>> [   56.328846] RSP: 0018:ffffc90007babd58 EFLAGS: 00010282$
> >>>> [   56.334755] RAX: 0000000000000000 RBX: ffff888fb85984e0 RCX: 0000000000000000$
> >>>> [   56.342577] RDX: ffff8890401e82a0 RSI: ffff8890401d7f60 RDI: ffff8890401d7f60$
> >>>> [   56.350415] RBP: ffff889007e2e4c0 R08: 0000000001200000 R09: 0000000000000000$
> >>>> [   56.358255] R10: 0000000000000001 R11: ffffffffc00bd060 R12: 0000000010e7e000$
> >>>> [   56.366121] R13: 0000000010e7efff R14: ffff888fb86622a8 R15: 00000000ffffff8b$
> >>>> [   56.373983] FS:  0000000000000000(0000) GS:ffff8890401c0000(0000) knlGS:0000000000000000$
> >>>> [   56.382806] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033$
> >>>> [   56.389291] CR2: 00007fa44c4cc448 CR3: 0000005eac7c0006 CR4: 00000000007606e0$
> >>>> [   56.397176] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000$
> >>>> [   56.405065] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400$
> >>>> [   56.412952] PKRU: 55555554$
> >>>> [   56.416419] Call Trace:$
> >>>> [   56.419631]  ? update_curr+0xc0/0x200$
> >>>> [   56.424060]  ? newidle_balance+0x232/0x3e0$
> >>>> [   56.428958]  btrfs_work_helper+0xc9/0x400 [btrfs]$
> >>>> [   56.434441]  ? __schedule+0x378/0x860$
> >>>> [   56.438895]  process_one_work+0x1b5/0x3a0$
> >>>> [   56.443690]  worker_thread+0x50/0x3c0$
> >>>> [   56.446698] /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/
> >>>> lkp-csl-2sp3/fio-basic-4k-performance-1SSD-btrfs-nfsv4-sync-100%25-300s-write-128G-ucode=0x400002c-monitor=a122c70f-debian-10.4-x86_64-20200603-20200915-84129-
> >>>> 1i8kzyy-0.yaml&job_state=post_run -O /dev/null$
> >>>> [   56.446700]~$
> >>>> [   56.448144]  ? process_one_work+0x3a0/0x3a0$
> >>>> [   56.491886]  kthread+0x114/0x160$
> >>>> [   56.495986]  ? kthread_park+0xa0/0xa0$
> >>>> [   56.500522]  ret_from_fork+0x1f/0x30$
> >>>> [   56.504966] ---[ end trace fbe43e164e851f97 ]---$
> >>>> [   56.510432] BTRFS: error (device nvme1n1p1) in btrfs_finish_ordered_io:2687: errno=-117 Filesystem corrupted$
> >>>>
> >>>>
> >>>> I also attached full dmesg 'dmesg-with-debug' for your reference.
> >>>>
> >>>>>
> >>>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> >>>>> index b1a148058773..b050d6fcb90a 100644
> >>>>> --- a/fs/btrfs/disk-io.c
> >>>>> +++ b/fs/btrfs/disk-io.c
> >>>>> @@ -406,8 +406,9 @@ int btrfs_verify_level_key(struct extent_buffer *eb,
> >>>>> int level,
> >>>>>         /* We have @first_key, so this @eb must have at least one item */
> >>>>>         if (btrfs_header_nritems(eb) == 0) {
> >>>>>                 btrfs_err(fs_info,
> >>>>> -               "invalid tree nritems, bytenr=%llu nritems=0 expect >0",
> >>>>> -                         eb->start);
> >>>>> +               "invalid tree nritems, bytenr=%llu owner=%llu level=%d
> >>>>> first_key=(%llu %u %llu) nritems=0 expect >0",
> >>>>> +                         eb->start, btrfs_header_owner(eb),
> >>>>> btrfs_header_level(eb),
> >>>>> +                         first_key->objectid, first_key->type,
> >>>>> first_key->offset);
> >>>>>                 WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> >>>>>                 return -EUCLEAN;
> >>>>>         }
> >>>>>
> >>>>> Thanks,
> >>>>> Qu
> >>>>>
> >>>>>> [   50.226906] WARNING: CPU: 71 PID: 500 at fs/btrfs/inode.c:2687 btrfs_finish_ordered_io+0x70a/0x820 [btrfs]
> >>>>>> [   50.236913] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfsd auth_rpcgss dm_mod dax_pmem_compat nd_pmem device_dax nd_btt dax_pmem_core btrfs sr_mod blake2b_generic xor cdrom sd_mod zstd_decompress sg zstd_compress raid6_pq libcrc32c intel_rapl_msr intel_rapl_common skx_edac x86_pkg_temp_thermal ipmi_ssif intel_powerclamp coretemp kvm_intel kvm irqbypass ast crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel acpi_ipmi drm_ttm_helper ghash_clmulni_intel ttm rapl drm_kms_helper intel_cstate syscopyarea sysfillrect nvme sysimgblt intel_uncore fb_sys_fops nvme_core ahci libahci t10_pi drm mei_me ioatdma libata mei ipmi_si joydev dca wmi ipmi_devintf ipmi_msghandler nfit libnvdimm ip_tables
> >>>>>> [   50.301669] CPU: 71 PID: 500 Comm: kworker/u193:5 Not tainted 5.8.0-rc7-00165-g3b54a0a703f17 #1
> >>>>>> [   50.310904] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
> >>>>>> [   50.317626] RIP: 0010:btrfs_finish_ordered_io+0x70a/0x820 [btrfs]
> >>>>>> [   50.324255] Code: 48 0a 00 00 02 72 25 41 83 ff fb 0f 84 f2 00 00 00 41 83 ff e2 0f 84 e8 00 00 00 44 89 fe 48 c7 c7 70 1c 2b c1 e8 58 ae ed bf <0f> 0b 44 89 f9 ba 7f 0a 00 00 48 c7 c6 50 47 2a c1 48 89 df e8 15
> >>>>>> [   50.344116] RSP: 0018:ffffc90007a83d58 EFLAGS: 00010282
> >>>>>> [   50.349923] RAX: 0000000000000000 RBX: ffff888a93ca5ea0 RCX: 0000000000000000
> >>>>>> [   50.357656] RDX: ffff8890401e82a0 RSI: ffff8890401d7f60 RDI: ffff8890401d7f60
> >>>>>> [   50.365385] RBP: ffff8890300ab8a8 R08: 0000000000000bd4 R09: 0000000000000000
> >>>>>> [   50.373133] R10: 0000000000000001 R11: ffffffffc0714060 R12: 000000000f83e000
> >>>>>> [   50.381060] R13: 000000000f83ffff R14: ffff888fb6c39968 R15: 00000000ffffff8b
> >>>>>> [   50.388824] FS:  0000000000000000(0000) GS:ffff8890401c0000(0000) knlGS:0000000000000000
> >>>>>> [   50.397545] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>>> [   50.404300] CR2: 00007feacc500f98 CR3: 0000000f74422006 CR4: 00000000007606e0
> >>>>>> [   50.412477] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>>>>> [   50.420281] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>>>>> [   50.428082] PKRU: 55555554
> >>>>>> [   50.431451] Call Trace:
> >>>>>> [   50.434570]  ? update_curr+0xc0/0x200
> >>>>>> [   50.438919]  ? newidle_balance+0x232/0x3e0
> >>>>>> [   50.443700]  ? __wake_up_common+0x80/0x180
> >>>>>> [   50.448491]  btrfs_work_helper+0xc9/0x400 [btrfs]
> >>>>>> [   50.453880]  ? __schedule+0x378/0x860
> >>>>>> [   50.458218]  process_one_work+0x1b5/0x3a0
> >>>>>> [   50.462917]  worker_thread+0x50/0x3c0
> >>>>>> [   50.467262]  ? process_one_work+0x3a0/0x3a0
> >>>>>> [   50.472148]  kthread+0x114/0x160
> >>>>>> [   50.476084]  ? kthread_park+0xa0/0xa0
> >>>>>> [   50.480445]  ret_from_fork+0x1f/0x30
> >>>>>> [   50.484731] ---[ end trace cc096c1a2068030e ]---
> >>>>>>
> >>>>>>
> >>>>>> To reproduce:
> >>>>>>
> >>>>>>         git clone https://github.com/intel/lkp-tests.git
> >>>>>>         cd lkp-tests
> >>>>>>         bin/lkp install job.yaml  # job file is attached in this email
> >>>>>>         bin/lkp run     job.yaml
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Oliver Sang
> >>>>>>
> >>>>>
> >>
> 
