Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5575E865C
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Sep 2022 01:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiIWXnC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 19:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIWXnB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 19:43:01 -0400
Received: from out20-25.mail.aliyun.com (out20-25.mail.aliyun.com [115.124.20.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CCF118B12
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 16:42:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0610312-0.00159809-0.937371;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.PN-vBqQ_1663976575;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.PN-vBqQ_1663976575)
          by smtp.aliyun-inc.com;
          Sat, 24 Sep 2022 07:42:55 +0800
Date:   Sat, 24 Sep 2022 07:43:00 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: fstests btrfs/042 triggle 'qgroup reserved space leaked'
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-Id: <20220924074257.A1D6.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

fstests btrfs/042 triggle 'qgroup reserved space leaked'

kernel source: btrfs misc-next 
kernel config:
	memory debug: CONFIG_KASAN/CONFIG_DEBUG_KMEMLEAK/...
	lock debug: CONFIG_PROVE_LOCKING/...

dmesg output:

[15788.980873] run fstests btrfs/042 at 2022-09-24 00:40:24
[15803.880347] BTRFS info (device sdb1): using crc32c (crc32c-intel) checksum algorithm
[15803.897721] BTRFS info (device sdb1): using free space tree
[15803.932525] BTRFS info (device sdb1): enabling ssd optimizations
[15818.525145] BTRFS: device fsid b255009c-2a39-49ed-b230-b4e26befd321 devid 1 transid 6 /dev/sdb2 scanned by systemd-udevd (310493)
[15818.791882] BTRFS info (device sdb2): using crc32c (crc32c-intel) checksum algorithm
[15818.808805] BTRFS info (device sdb2): using free space tree
[15818.837770] BTRFS info (device sdb2): enabling ssd optimizations
[15818.847176] BTRFS info (device sdb2): checking UUID tree
[15818.911997] BTRFS info (device sdb2): qgroup scan completed (inconsistency flag cleared)
[15838.397073] BTRFS warning (device sdb2): qgroup 1/1 has unreleased space, type 0 rsv 12288
[15838.406954] BTRFS warning (device sdb2): qgroup 0/260 has unreleased space, type 0 rsv 4096
[15838.416728] BTRFS warning (device sdb2): qgroup 0/259 has unreleased space, type 0 rsv 4096
[15838.426511] BTRFS warning (device sdb2): qgroup 0/257 has unreleased space, type 0 rsv 4096
[15838.436351] ------------[ cut here ]------------
[15838.442380] WARNING: CPU: 0 PID: 310592 at fs/btrfs/disk-io.c:4668 close_ctree (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/include/trace/events/btrfs.h:749 (discriminator 14)) btrfs

fs/btrfs/disk-io.c:4668
    if (btrfs_check_quota_leak(fs_info)) {
L4668        WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
        btrfs_err(fs_info, "qgroup reserved space leaked");
    }

[15838.452948] Modules linked in: ext4 mbcache jbd2 loop rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache netfs rfkill ib_core sunrpc dm_multipath amdgpu iommu_v2 gpu_sched drm_buddy intel_rapl_msr intel_rapl_common btrfs sb_edac snd_hda_codec_realtek x86_pkg_temp_thermal snd_hda_codec_generic radeon intel_powerclamp snd_hda_codec_hdmi ledtrig_audio coretemp blake2b_generic snd_hda_intel xor dcdbas kvm_intel mei_wdt raid6_pq snd_intel_dspcfg i2c_algo_bit iTCO_wdt iTCO_vendor_support zstd_compress dell_smm_hwmon snd_intel_sdw_acpi drm_display_helper kvm snd_hda_codec cec snd_hda_core drm_ttm_helper irqbypass snd_hwdep rapl ttm intel_cstate snd_seq dm_mod snd_seq_device drm_kms_helper intel_uncore snd_pcm pcspkr syscopyarea mei_me snd_timer sysfillrect i2c_i801 snd sysimgblt i2c_smbus lpc_ich mei fb_sys_fops soundcore fuse drm xfs sd_mod t10_pi sr_mod cdrom sg crct10dif_pclmul crc32_pclmul bnx2x crc32c_intel ahci libahci ghash_clmulni_intel mdio libata mpt3sas e10
 00e
[15838.453270]  raid_class scsi_transport_sas wmi i2c_dev ipmi_devintf ipmi_msghandler
[15838.551107] Unloaded tainted modules: acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
[15838.560649]  pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 fjes():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 fjes():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 fjes():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 fjes():1 pcc_cpufreq():1 acpi_cpufreq():1 fjes():1 pcc_cpufreq():1 acpi_cpufreq():1
[15838.659255]  pcc_cpufreq():1 acpi_cpufreq():1 fjes():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 fjes():1 fjes():1 fjes():1 fjes():1 fjes():1 fjes():1
[15838.779406] CPU: 0 PID: 310592 Comm: umount Not tainted 6.0.0-7.0.debug.el7.x86_64 #1
[15838.789287] Hardware name: Dell Inc. Precision T7610/0NK70N, BIOS A18 09/11/2019
[15838.798748] RIP: 0010:close_ctree (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/include/trace/events/btrfs.h:749 (discriminator 14)) btrfs
[15838.805988] Code: c7 00 9b 2f c3 e8 1c e7 ff ff 48 8b 3c 24 be 08 00 00 00 e8 2f 78 70 db f0 41 80 4f 10 02 4c 89 ff e8 31 46 f4 ff 84 c0 74 11 <0f> 0b 48 c7 c6 60 9b 2f c3 4c 89 ff e8 b0 8c ff ff 4c 89 ff 49 8d
All code
========
   0:	c7 00 9b 2f c3 e8    	movl   $0xe8c32f9b,(%rax)
   6:	1c e7                	sbb    $0xe7,%al
   8:	ff                   	(bad)  
   9:	ff 48 8b             	decl   -0x75(%rax)
   c:	3c 24                	cmp    $0x24,%al
   e:	be 08 00 00 00       	mov    $0x8,%esi
  13:	e8 2f 78 70 db       	callq  0xffffffffdb707847
  18:	f0 41 80 4f 10 02    	lock orb $0x2,0x10(%r15)
  1e:	4c 89 ff             	mov    %r15,%rdi
  21:	e8 31 46 f4 ff       	callq  0xfffffffffff44657
  26:	84 c0                	test   %al,%al
  28:	74 11                	je     0x3b
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	48 c7 c6 60 9b 2f c3 	mov    $0xffffffffc32f9b60,%rsi
  33:	4c 89 ff             	mov    %r15,%rdi
  36:	e8 b0 8c ff ff       	callq  0xffffffffffff8ceb
  3b:	4c 89 ff             	mov    %r15,%rdi
  3e:	49                   	rex.WB
  3f:	8d                   	.byte 0x8d

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	48 c7 c6 60 9b 2f c3 	mov    $0xffffffffc32f9b60,%rsi
   9:	4c 89 ff             	mov    %r15,%rdi
   c:	e8 b0 8c ff ff       	callq  0xffffffffffff8cc1
  11:	4c 89 ff             	mov    %r15,%rdi
  14:	49                   	rex.WB
  15:	8d                   	.byte 0x8d
[15838.829023] RSP: 0018:ffff88810b7bfb98 EFLAGS: 00010202
[15838.836422] RAX: 0000000000000001 RBX: ffff88828ee54d58 RCX: 0000000000000000
[15838.845734] RDX: 1ffff11064bd1ad3 RSI: 0000000000000008 RDI: ffff888325e8d6a0
[15838.855015] RBP: ffff88828ee54fd0 R08: ffffed13f39c7a21 R09: 0000000000000000
[15838.864347] R10: ffffed1418ee9840 R11: ffff88a0c774c200 R12: ffff88824b4487b0
[15838.873690] R13: ffff88828ee55130 R14: ffff88819ea76ec0 R15: ffff88828ee54000
[15838.883005] FS:  00007f41e8aaa500(0000) GS:ffff889f9ce00000(0000) knlGS:0000000000000000
[15838.893294] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[15838.901224] CR2: 00007fa141b622d8 CR3: 00000001e2a34003 CR4: 00000000001706f0
[15838.910553] Call Trace:
[15838.915219]  <TASK>
[15838.919527] ? fsnotify_destroy_marks (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/notify/mark.c:839) 
[15838.926367] ? btrfs_cleanup_one_transaction.cold.75 (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/include/linux/perf_event.h:1189 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/include/trace/events/btrfs.h:720) btrfs
[15838.935255] ? fsnotify_sb_delete (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/arch/x86/include/asm/atomic64_64.h:22 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/include/linux/atomic/atomic-long.h:29 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/include/linux/atomic/atomic-instrumented.h:1266 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/notify/fsnotify.c:95) 
[15838.941822] ? __fsnotify_vfsmount_delete (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/notify/fsnotify.c:91) 
[15838.948905] ? evict_inodes (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/inode.c:713) 
[15838.954918] ? dispose_list (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/inode.c:713) 
[15838.960947] ? btrfs_sync_fs (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/btrfs/super.c:1570) btrfs
[15838.967745] generic_shutdown_super (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/super.c:491) 
[15838.974445] kill_anon_super (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/super.c:1072 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/super.c:1086) 
[15838.980345] btrfs_kill_super (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/btrfs/super.c:2551) btrfs
[15838.987130] deactivate_locked_super (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/super.c:332) 
[15838.993736] cleanup_mnt (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/namespace.c:1187) 
[15838.999417] task_work_run (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/task_work.c:177 (discriminator 1)) 
[15839.005185] exit_to_user_mode_prepare (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/include/linux/resume_user_mode.h:49 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/entry/common.c:169 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/entry/common.c:201) 
[15839.012112] syscall_exit_to_user_mode (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/entry/common.c:128 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/entry/common.c:296) 
[15839.018875] do_syscall_64 (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/arch/x86/entry/common.c:87) 
[15839.024600] ? lockdep_hardirqs_on_prepare (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/locking/lockdep.c:4260 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/locking/lockdep.c:4319 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/locking/lockdep.c:4271) 
[15839.031881] ? do_syscall_64 (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/arch/x86/entry/common.c:87) 
[15839.037753] ? lockdep_hardirqs_on_prepare (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/locking/lockdep.c:4260 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/locking/lockdep.c:4319 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/locking/lockdep.c:4271) 
[15839.045010] entry_SYSCALL_64_after_hwframe (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/arch/x86/entry/entry_64.S:120) 
[15839.052194] RIP: 0033:0x7f41e8953a6b
[15839.057913] Code: 0f 1e fa 48 89 fe 31 ff e9 72 08 00 00 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 89 63 0a 00 f7 d8
All code
========
   0:	0f 1e fa             	nop    %edx
   3:	48 89 fe             	mov    %rdi,%rsi
   6:	31 ff                	xor    %edi,%edi
   8:	e9 72 08 00 00       	jmpq   0x87f
   d:	66 90                	xchg   %ax,%ax
   f:	f3 0f 1e fa          	endbr64 
  13:	31 f6                	xor    %esi,%esi
  15:	e9 05 00 00 00       	jmpq   0x1f
  1a:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1f:	f3 0f 1e fa          	endbr64 
  23:	b8 a6 00 00 00       	mov    $0xa6,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 05                	ja     0x37
  32:	c3                   	retq   
  33:	0f 1f 40 00          	nopl   0x0(%rax)
  37:	48 8b 15 89 63 0a 00 	mov    0xa6389(%rip),%rdx        # 0xa63c7
  3e:	f7 d8                	neg    %eax

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 05                	ja     0xd
   8:	c3                   	retq   
   9:	0f 1f 40 00          	nopl   0x0(%rax)
   d:	48 8b 15 89 63 0a 00 	mov    0xa6389(%rip),%rdx        # 0xa639d
  14:	f7 d8                	neg    %eax
[15839.081093] RSP: 002b:00007fff313c23d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[15839.090894] RAX: 0000000000000000 RBX: 000055d74a755540 RCX: 00007f41e8953a6b
[15839.100242] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055d74a75a550
[15839.109546] RBP: 000055d74a755310 R08: 0000000000000000 R09: 000055d74a754010
[15839.118783] R10: 00007f41e89faaa0 R11: 0000000000000246 R12: 0000000000000000
[15839.128016] R13: 000055d74a75a550 R14: 000055d74a755420 R15: 000055d74a755310
[15839.137246]  </TASK>
[15839.141444] irq event stamp: 36915
[15839.146842] hardirqs last enabled at (36929): __up_console_sem (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/arch/x86/include/asm/irqflags.h:45 (discriminator 1) /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/arch/x86/include/asm/irqflags.h:80 (discriminator 1) /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/arch/x86/include/asm/irqflags.h:138 (discriminator 1) /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/printk/printk.c:264 (discriminator 1)) 
[15839.157472] hardirqs last disabled at (36942): __up_console_sem (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/printk/printk.c:262 (discriminator 1)) 
[15839.168059] softirqs last enabled at (34740): __do_softirq (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/arch/x86/include/asm/preempt.h:27 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/softirq.c:415 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/softirq.c:600) 
[15839.178441] softirqs last disabled at (34701): irq_exit_rcu (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/softirq.c:445 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/softirq.c:650 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/softirq.c:662) 
[15839.188788] ---[ end trace 0000000000000000 ]---
[15839.195355] BTRFS error (device sdb2): qgroup reserved space leaked
[15839.544913] BTRFS info (device sdb2): using crc32c (crc32c-intel) checksum algorithm
[15839.563333] BTRFS info (device sdb2): using free space tree
[15839.597640] BTRFS info (device sdb2): enabling ssd optimizations


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/09/24


