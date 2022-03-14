Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE254D7945
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 03:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbiCNCHa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Mar 2022 22:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiCNCH3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Mar 2022 22:07:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B6828C;
        Sun, 13 Mar 2022 19:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647223579; x=1678759579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r3sZfCZm9mu1N3FBM5WuBHBi36hfhm+Yw29Ajcju/k8=;
  b=EdyxXGyN5KeIlAk0dqfdMGd2nMSevabWWQHSuA3vzvy2c4QeSnvepaOa
   JAR3wt36O19UBEaU9ZR9Pjv25y12lSDFW+xY0IrgB57u6jfHRyoVy5fK+
   sogFBqWMFtw8eRuqpUvKE99g6lKDBZbCmygz9NFuqoOpRTKAFc5MIlO5M
   yAOig4QpMf7EgBxEkhXV9556noeUcFc1aeUg7Oyiuaq0RXzSVx+/b3JZN
   UcJTZ+gd0kHqKDAkmcM6igznwfk0Ys7edNc4FN93YhdhWs8CJ8MLjx2vb
   9+MeT3aYDaiHoSBkRAiiekgRImx8hlgnS0skvpgF80E5r+fhzDFcFOW/x
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="254747729"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="xz'?scan'208";a="254747729"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 19:06:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="xz'?scan'208";a="645616698"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 19:06:15 -0700
Date:   Mon, 14 Mar 2022 10:05:49 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, linux-btrfs@vger.kernel.org
Subject: Re: [btrfs] 3626a285f8: divide_error:#[##]
Message-ID: <20220314020549.GA24245@xsang-OptiPlex-9020>
References: <20220301063026.GB13547@xsang-OptiPlex-9020>
 <e55fb58e-bb3a-ce51-b485-6302415b34e4@gmx.com>
 <20220302084435.GA28137@xsang-OptiPlex-9020>
 <dbc84dd2-7e6d-95b0-d7bc-373f897a7063@gmx.com>
 <20220309074954.GB22223@xsang-OptiPlex-9020>
 <c28efa5a-e2ae-486b-6a51-5e063086937c@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <c28efa5a-e2ae-486b-6a51-5e063086937c@gmx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Qu,

On Wed, Mar 09, 2022 at 04:42:41PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/3/9 15:49, Oliver Sang wrote:
> > Hi Qu,
> > 
> > On Fri, Mar 04, 2022 at 03:26:19PM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2022/3/2 16:44, Oliver Sang wrote:
> > > > Hi Qu,
> > > > 
> > > > On Tue, Mar 01, 2022 at 03:47:38PM +0800, Qu Wenruo wrote:
> > > > > 
> > > > > 
> > > > > This is weird, the code is from simple_stripe_full_stripe_len(), which
> > > > > means the chunk map must be RAID0 or RAID10.
> > > > > 
> > > > > In that case, their sub_stripes should be either 1 or 2, why we got 0 there?
> > > > > 
> > > > > In fact, from volumes.c, all sub_stripes is from btrfs_raid_array[],
> > > > > which all have either 1 or 2 sub_stripes.
> > > > > 
> > > > > 
> > > > > Although the code is old, not the latest version, it should still not
> > > > > cause such problem.
> > > > > 
> > > > > Mind to retest with my branch to see if it can be reproduced?
> > > > > https://github.com/adam900710/linux/tree/refactor_scrub
> > > > 
> > > > we tested head of this branch:
> > > >     d6e3a8c42f2fad btrfs: scrub: rename scrub_bio::pagev and related members
> > > > and:
> > > >     fdad4a9615f180 btrfs: introduce dedicated helper to scrub simple-stripe based range
> > > > on this branch.
> > > > 
> > > > by attached config.
> > > > 
> > > > still reproduce the same issue.
> > > > 
> > > > attached dmesgs FYI.
> > > 
> > > Still failed to reproduce here.
> > > 
> > > Those btrfs/07[0123] tests are already in scrub/replace group, thus I
> > > ran them almost hourly during the development.
> > > 
> > > 
> > > Although there are some ASSERT()s doing extra sanity checks, they should
> > > not affect the result anyway.
> > > 
> > > Thus I pushed a branch with more explicit BUG_ON()s to catch the
> > > possible divide by zero bugs.
> > > (https://github.com/adam900710/linux/tree/refactor_scrub_testing)
> > > 
> > > Mind to give it a try?
> > 
> > 
> > in our tests, it seems one BUG_ON you added is triggered
> > (full dmesg attached):
> 
> What the heck...
> 
> It's indeed some weird extent mapping has its sub-stripes as 0...
> 
> I must be insane or there is something fundamental wrong.
> 
> Mind to try that branch again? I have updated the branch, now it will
> trigger BUG_ON() as soon as it finds a chunk mapping with sub_stripes == 0.
> 
> I'm wondering if it's old btrfs-progs involved (which may not properly
> initialize btrfs_chunk::sub_stripes) now.

below BUG print was caught by your new patch (detail dmesg attached):

[   44.577527][ T1980] ------------[ cut here ]------------
[   44.583552][  T335]
[   44.583990][  T337] 512+0 records out
[   44.583997][  T337]
[   44.593932][ T1980] kernel BUG at fs/btrfs/volumes.c:7157!
[   44.593940][ T1980] invalid opcode: 0000 [#1] SMP KASAN PTI
[   44.598832][  T335]   Data:             single            8.00MiB
[   44.603293][ T1980] CPU: 5 PID: 1980 Comm: mount Not tainted 5.17.0-rc4-00095-g7f159e82828e #1
[   44.603297][ T1980] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
[   44.603299][ T1980] RIP: 0010:read_one_chunk+0xa02/0xc80 [btrfs]
[   44.605509][  T335]
[   44.609168][ T1980] Code: 03 0f b6 14 02 4c 89 f0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 14 01 00 00 48 8b 44 24 10 8b 50 1c 85 d2 0f 85 19 fb ff ff <0f> 0b 4c
89 c7 e8 f4 b0 fa ff 31 c0 e9 4d ff ff ff 48 8b 7c 24 78
[   44.609171][ T1980] RSP: 0018:ffffc90002be76c8 EFLAGS: 00010246
[   44.609175][ T1980] RAX: ffff888102c98e00 RBX: 0000000000000000 RCX: 0000000000000000
[   44.609178][ T1980] RDX: 0000000000000000 RSI: 0000000000000008 RDI: fffff5200057ce75
[   44.612227][  T335]   Metadata:         DUP               1.00GiB
[   44.616871][ T1980] RBP: 000000000000033c R08: 000000000000005e R09: ffffed1034dd6791
[   44.616873][ T1980] R10: ffff8881a6eb3c87 R11: ffffed1034dd6790 R12: ffff888214586b40
[   44.616874][ T1980] R13: ffff888102c98e18 R14: ffff888102c98e1c R15: 0000000000000022
[   44.616876][ T1980] FS:  00007fad1bd12100(0000) GS:ffff8881a6e80000(0000) knlGS:0000000000000000
[   44.622475][  T335]
[   44.628578][ T1980] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.628580][ T1980] CR2: 00007fff9d90df68 CR3: 00000001407fc003 CR4: 00000000001706e0
[   44.628583][ T1980] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   44.628585][ T1980] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   44.628588][ T1980] Call Trace:
[   44.638095][  T335]   System:           DUP               8.00MiB
[   44.645166][ T1980]  <TASK>
[   44.645168][ T1980]  ? _raw_spin_lock+0x81/0x100
[   44.651206][  T335]
[   44.653388][ T1980]  ? _raw_spin_lock_bh+0x100/0x100
[   44.653395][ T1980]  ? __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
[   44.673370][  T335] SSD detected:       no
[   44.678876][ T1980]  ? add_missing_dev+0x3c0/0x3c0 [btrfs]
[   44.686756][  T335]
[   44.694598][ T1980]  ? btrfs_get_token_64+0x700/0x700 [btrfs]
[   44.701187][  T335] Zoned device:       no
[   44.708574][ T1980]  ? memcpy+0x39/0x80
[   44.708581][ T1980]  ? write_extent_buffer+0x192/0x240 [btrfs]
[   44.716449][  T335]
[   44.724294][ T1980]  btrfs_read_sys_array+0x2c7/0x380 [btrfs]
[   44.734138][  T335] Incompat features:  extref, skinny-metadata, no-holes
[   44.735313][ T1980]  ? read_one_dev+0x13c0/0x13c0 [btrfs]
[   44.741786][  T335]
[   44.749628][ T1980]  ? mutex_lock+0x80/0x100
[   44.749634][ T1980]  ? __mutex_lock_slowpath+0x40/0x40
[   44.758164][  T335] Runtime features:   free-space-tree
[   44.765352][ T1980]  ? btrfs_init_workqueues+0x4c1/0x7ba [btrfs]
[   44.768515][  T335]
[   44.774620][ T1980]  open_ctree+0x16ac/0x2656 [btrfs]
[   44.777966][  T335] Checksum:           crc32c
[   44.782064][ T1980]  btrfs_mount_root.cold+0x13/0x192 [btrfs]
[   44.784268][  T335]
[   44.789241][ T1980]  ? arch_stack_walk+0x9e/0x100
[   44.789247][ T1980]  ? parse_rescue_options+0x300/0x300 [btrfs]
[   44.796977][  T335] Number of devices:  1
[   44.800614][ T1980]  ? vfs_parse_fs_param_source+0x3b/0x1c0
[   44.806131][  T335]
[   44.808314][ T1980]  ? legacy_parse_param+0x6a/0x7c0
[   44.808320][ T1980]  ? parse_rescue_options+0x300/0x300 [btrfs]
[   44.814273][  T335] Devices:
[   44.818205][ T1980]  legacy_get_tree+0xef/0x200
[   44.818210][ T1980]  vfs_get_tree+0x84/0x2c0
[   44.822077][  T335]
[   44.827928][ T1980]  fc_mount+0xf/0x80
[   44.827934][ T1980]  vfs_kern_mount+0x71/0xc0
[   44.830557][  T335]    ID        SIZE  PATH
[   44.835890][ T1980]  btrfs_mount+0x1fc/0xa40 [btrfs]
[   44.842730][  T335]
[   44.848134][ T1980]  ? kasan_save_stack+0x1e/0x40
[   44.848149][ T1980]  ? kasan_set_track+0x21/0x40
[   44.850862][  T335]     1   300.00GiB  /dev/sdb4
[   44.854618][ T1980]  ? kasan_set_free_info+0x20/0x40
[   44.854624][ T1980]  ? btrfs_show_options+0xf00/0xf00 [btrfs]
[   44.859803][  T335]
[   44.865032][ T1980]  ? __x64_sys_mount+0x12c/0x1c0
[   44.865036][ T1980]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
[   44.871101][  T335]
[   44.873263][ T1980]  ? terminate_walk+0x203/0x4c0
[   44.873268][ T1980]  ? vfs_parse_fs_param_source+0x3b/0x1c0
[   44.878354][  T335]
[   44.882803][ T1980]  ? legacy_parse_param+0x6a/0x7c0
[   44.882808][ T1980]  ? vfs_parse_fs_string+0xd7/0x140
[   44.889280][  T335] 2022-03-14 01:34:21 mkdir -p /fs/sdb1
[   44.890770][ T1980]  ? btrfs_show_options+0xf00/0xf00 [btrfs]
[   44.895501][  T335]
[   44.901430][ T1980]  ? legacy_get_tree+0xef/0x200
[   44.901435][ T1980]  legacy_get_tree+0xef/0x200
[   44.901448][ T1980]  ? security_capable+0x56/0xc0
[   44.905612][  T335]  btrfs
[   44.911057][ T1980]  vfs_get_tree+0x84/0x2c0
[   44.911062][ T1980]  ? ns_capable_common+0x57/0x100
[   44.913278][  T335]
[   44.918247][ T1980]  path_mount+0x7fc/0x1a40
[   44.918252][ T1980]  ? kasan_set_track+0x21/0x40
[   44.925201][  T335] 2022-03-14 01:34:21 mount -t btrfs /dev/sdb1 /fs/sdb1
[   44.927087][ T1980]  ? finish_automount+0x600/0x600
[   44.927092][ T1980]  ? kmem_cache_free+0xa1/0x400
[   44.931642][  T335]
[   44.935926][ T1980]  do_mount+0xca/0x100
[   44.935931][ T1980]  ? path_mount+0x1a40/0x1a40
[   44.935933][ T1980]  ? _copy_from_user+0x94/0x100
[   44.938799][  T335] 2022-03-14 01:34:21 mkdir -p /fs/sdb2
[   44.941885][ T1980]  ? memdup_user+0x4e/0x80
[   44.941890][ T1980]  __x64_sys_mount+0x12c/0x1c0
[   44.941893][ T1980]  do_syscall_64+0x3b/0xc0
[   44.946884][  T335]
[   44.951068][ T1980]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   44.951074][ T1980] RIP: 0033:0x7fad1bf10fea
[   44.951077][ T1980] Code: 48 8b 0d a9 0e 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 76 0e 0c 00 f7 d8 64 89 01 48
[   44.956197][  T335]  btrfs
[   44.958245][ T1980] RSP: 002b:00007fff9d90f878 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[   44.958249][ T1980] RAX: ffffffffffffffda RBX: 00005628efc57970 RCX: 00007fad1bf10fea
[   44.958251][ T1980] RDX: 00005628efc57b80 RSI: 00005628efc57bc0 RDI: 00005628efc57ba0
[   44.958263][ T1980] RBP: 00007fad1c25e1c4 R08: 0000000000000000 R09: 00005628efc5a890
[   44.958264][ T1980] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   44.962993][  T335]
[   44.967613][ T1980] R13: 0000000000000000 R14: 00005628efc57ba0 R15: 00005628efc57b80
[   44.967616][ T1980]  </TASK>
[   44.967617][ T1980] Modules linked in: dm_mod btrfs blake2b_generic xor raid6_pq
[   44.973257][  T335] 2022-03-14 01:34:21 mount -t btrfs /dev/sdb2 /fs/sdb2
[   44.977243][ T1980]  zstd_compress libcrc32c sd_mod t10_pi sg
[   44.983019][  T335]
[   44.985203][ T1980]  ipmi_devintf ata_generic ipmi_msghandler intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel
[   44.990720][  T335] 2022-03-14 01:34:21 mkdir -p /fs/sdb3
[   44.995962][ T1980]  i915 kvm intel_gtt ttm drm_kms_helper irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel syscopyarea sysfillrect
[   44.998174][  T335]
[   45.002882][ T1980]  sysimgblt rapl mei_wdt fb_sys_fops ata_piix intel_cstate libata drm mei_me mei intel_uncore video ip_tables
[   45.002919][ T1980] ---[ end trace 0000000000000000 ]---


> 
> Thanks,
> Qu
> 
> > 
> > 
> > [   75.279958][ T3602] ------------[ cut here ]------------
> > [   75.285221][ T3602] kernel BUG at fs/btrfs/scrub.c:3387!
> > [   75.290490][ T3602] invalid opcode: 0000 [#1] SMP KASAN PTI
> > [   75.296010][ T3602] CPU: 2 PID: 3602 Comm: btrfs Not tainted 5.17.0-rc4-00095-g6b837d4c40d5 #1
> > [   75.304521][ T3602] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
> > [   75.312344][ T3602] RIP: 0010:scrub_stripe+0xed3/0x1340 [btrfs]
> > [   75.318250][ T3602] Code: 90 00 00 00 e8 0e f9 96 c0 e9 98 f3 ff ff e8 c4 f9 96 c0 e9 26 f3 ff ff 48 8b bc 24 80 00 00 00 e8 f2 f8 96 c0 e9 3b f4 ff ff <0f> 0b 0f
> > 0b 4c 8d a4 24 b8 01 00 00 31 f6 4c 8d bd 20 02 00 00 4c
> > [   75.337480][ T3602] RSP: 0018:ffffc9000b47f550 EFLAGS: 00010246
> > [   75.343340][ T3602] RAX: 0000000000000007 RBX: ffff88810231d600 RCX: ffff88810231d61c
> > [   75.351074][ T3602] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8881023a2458
> > [   75.358807][ T3602] RBP: ffff8881097ad800 R08: 0000000000000001 R09: ffffed102828100d
> > [   75.366550][ T3602] R10: ffff888141408063 R11: ffffed102828100c R12: 0000000000000000
> > [   75.374282][ T3602] R13: 0000000000100000 R14: ffff888141408000 R15: ffff888129c9c000
> > [   75.382016][ T3602] FS:  00007f94c24ec8c0(0000) GS:ffff8881a6d00000(0000) knlGS:0000000000000000
> > [   75.390691][ T3602] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   75.397054][ T3602] CR2: 00007ffe454aa8e8 CR3: 000000020a796004 CR4: 00000000001706e0
> > [   75.404785][ T3602] Call Trace:
> > [   75.407886][ T3602]  <TASK>
> > [   75.410645][ T3602]  ? btrfs_wait_ordered_extents+0x9a1/0xe40 [btrfs]
> > [   75.417049][ T3602]  ? scrub_raid56_parity+0x5c0/0x5c0 [btrfs]
> > [   75.422853][ T3602]  ? btrfs_remove_ordered_extent+0xbc0/0xbc0 [btrfs]
> > [   75.429341][ T3602]  ? mutex_unlock+0x80/0x100
> > [   75.433733][ T3602]  ? __wake_up_common_lock+0xe3/0x140
> > [   75.438897][ T3602]  ? __lookup_extent_mapping+0x215/0x300 [btrfs]
> > [   75.445037][ T3602]  scrub_chunk+0x294/0x480 [btrfs]
> > [   75.449984][ T3602]  scrub_enumerate_chunks+0x643/0x1340 [btrfs]
> > [   75.455962][ T3602]  ? scrub_chunk+0x480/0x480 [btrfs]
> > [   75.461083][ T3602]  ? __scrub_blocked_if_needed+0xb9/0x200 [btrfs]
> > [   75.467317][ T3602]  ? scrub_checksum_data+0x4c0/0x4c0 [btrfs]
> > [   75.473121][ T3602]  ? down_read+0x137/0x240
> > [   75.477339][ T3602]  ? mutex_unlock+0x80/0x100
> > [   75.481726][ T3602]  ? __mutex_unlock_slowpath+0x300/0x300
> > [   75.487743][ T3602]  ? btrfs_find_device+0xac/0x240 [btrfs]
> > [   75.493285][ T3602]  btrfs_scrub_dev+0x535/0xc00 [btrfs]
> > [   75.498578][ T3602]  ? scrub_enumerate_chunks+0x1340/0x1340 [btrfs]
> > [   75.504812][ T3602]  ? btrfs_apply_pending_changes+0x80/0x80 [btrfs]
> > [   75.511120][ T3602]  ? btrfs_record_root_in_trans+0x4d/0x180 [btrfs]
> > [   75.517428][ T3602]  ? finish_wait+0x280/0x280
> > [   75.521819][ T3602]  btrfs_dev_replace_by_ioctl.cold+0x62c/0x720 [btrfs]
> > [   75.528483][ T3602]  ? btrfs_finish_block_group_to_copy+0x3c0/0x3c0 [btrfs]
> > [   75.535440][ T3602]  ? __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
> > [   75.542575][ T3602]  btrfs_ioctl+0x37ee/0x51c0 [btrfs]
> > [   75.547691][ T3602]  ? fput_many+0xaa/0x140
> > [   75.551823][ T3602]  ? filp_close+0xef/0x140
> > [   75.556041][ T3602]  ? __x64_sys_close+0x2d/0x80
> > [   75.560600][ T3602]  ? do_syscall_64+0x3b/0xc0
> > [   75.564991][ T3602]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [   75.570838][ T3602]  ? btrfs_ioctl_get_supported_features+0x40/0x40 [btrfs]
> > [   75.577756][ T3602]  ? _raw_spin_lock_irq+0x82/0xd2
> > [   75.582572][ T3602]  ? _raw_spin_lock+0x100/0x100
> > [   75.587218][ T3602]  ? fiemap_prep+0x200/0x200
> > [   75.591607][ T3602]  ? lockref_put_or_lock+0xc4/0x1c0
> > [   75.596600][ T3602]  ? do_sigaction+0x4b3/0x840
> > [   75.601075][ T3602]  ? __x64_sys_pidfd_send_signal+0x600/0x600
> > [   75.606837][ T3602]  ? __might_fault+0x4d/0x80
> > [   75.611226][ T3602]  ? __x64_sys_rt_sigaction+0x1d0/0x240
> > [   75.616558][ T3602]  ? __ia32_sys_signal+0x140/0x140
> > [   75.621461][ T3602]  ? __fget_light+0x57/0x540
> > [   75.625854][ T3602]  __x64_sys_ioctl+0x127/0x1c0
> > [   75.630414][ T3602]  do_syscall_64+0x3b/0xc0
> > [   75.634633][ T3602]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [   75.640307][ T3602] RIP: 0033:0x7f94c25df427
> > [   75.644533][ T3602] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01
> > f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
> > [   75.663771][ T3602] RSP: 002b:00007ffd06a4acc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > [   75.671937][ T3602] RAX: ffffffffffffffda RBX: 000055d51e9f72a0 RCX: 00007f94c25df427
> > [   75.679671][ T3602] RDX: 00007ffd06a4b108 RSI: 00000000ca289435 RDI: 0000000000000004
> > [   75.687404][ T3602] RBP: 00000000ffffffff R08: 0000000000000000 R09: 000055d51e9fa580
> > [   75.695137][ T3602] R10: 0000000000000008 R11: 0000000000000246 R12: 00007ffd06a4e97a
> > [   75.702868][ T3602] R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000005
> > [   75.710600][ T3602]  </TASK>
> > [   75.713445][ T3602] Modules linked in: dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c sd_mod t10_pi sg ata_generic ipmi_devintf ipmi_msghandler
> > intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp i915 kvm_intel kvm intel_gtt ttm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel
> > ghash_clmulni_intel drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops rapl ata_piix mei_wdt intel_cstate drm libata mei_me intel_uncore mei video ip_tables
> > [   75.756460][ T3602] ---[ end trace 0000000000000000 ]---
> > 
> > 
> > > 
> > > Thanks,
> > > Qu
> > > 

--tThc/1wpZn/ma/RB
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
ZnwAAdLWAdz4CLarh3SxxGf7AgAAAAAEWVo=

--tThc/1wpZn/ma/RB--
