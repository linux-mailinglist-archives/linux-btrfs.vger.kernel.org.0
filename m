Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A652435AD1
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 08:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhJUGXy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 02:23:54 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:56042 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJUGXy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 02:23:54 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 109D16C006CD;
        Thu, 21 Oct 2021 09:21:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1634797290; bh=FScA/KnjGiriRhVyBb10xbgAWT+Kq+9K+S0ax8D61bg=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=J/JbwEaaRNyNnopeCrlugMnLICKd9KpbaCYxF/LcIgGgkVAXArGVmmYBtC1G+0l2m
         Zq/M+75FGtSwcGFNQ+5fjmTDH3myigUjcwRHdikPYXIirhPfE//nQ8imlVV21dQpWs
         /HFH7jodI74jwnH0jTDD4vPBw7BU7ox8lUdgDlTM=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 00EEA6C006CC;
        Thu, 21 Oct 2021 09:21:30 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id J3b4Ch1sY00B; Thu, 21 Oct 2021 09:21:29 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 8A5836C006CA;
        Thu, 21 Oct 2021 09:21:29 +0300 (EEST)
Received: from nas (unknown [117.62.172.224])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 963E41BE0ABD;
        Thu, 21 Oct 2021 09:21:27 +0300 (EEST)
References: <20211014152939.5E10.409509F4@e16-tech.com>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: fstest/btrfs/220 tigger a check-integrity warning
Date:   Thu, 21 Oct 2021 14:13:11 +0800
In-reply-to: <20211014152939.5E10.409509F4@e16-tech.com>
Message-ID: <pmryhp99.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +d1m5/RSY16pi1+mXX3cGwcwrTRLXun5mZO30RtZnXnyMi+AeFR+Lh33wixqLw+1vCM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Thu 14 Oct 2021 at 15:29, Wang Yugui <wangyugui@e16-tech.com> 
wrote:

> Hi,
>
> xfstest/btrfs/220 tigger check-integrity warning.
>
> btrfs source:  5.15.0-0.rc5 with btrfs pull for rc6
>
> btrfs kernel config:
> CONFIG_BTRFS_FS=m
> CONFIG_BTRFS_FS_POSIX_ACL=y
> CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> # CONFIG_BTRFS_DEBUG is not set
> CONFIG_BTRFS_ASSERT=y
> CONFIG_BTRFS_FS_REF_VERIFY=y
>
> reproduce frequency: 100%
>
> [ 1917.552758] btrfs: attempt to write superblock which 
> references block M
> @5242880 (sdb2/5242880/0) which is not flushed out of disk's 
> write cache (block
> flush_gen=1, dev->flush_gen=0)!
>
Anything special about /dev/sdb? I can reproduce if test device is 
zram
since zram seems to handle FUA in its way.
For normal device backing by file/disk, the test always passed on 
my side.

--
Su
> [ 1917.555092] ------------[ cut here ]------------
> [ 1917.556238] WARNING: CPU: 28 PID: 843680 at 
> fs/btrfs/check-integrity.c:2196 
> btrfsic_process_written_superblock+0x22a/0x2a0 [btrfs]
> [ 1917.557507] Modules linked in: dm_dust dm_flakey loop 
> rpcsec_gss_krb5 nfsv4
> dns_resolver nfs fscache netfs xt_conntrack xt_MASQUERADE 
> nf_conntrack_netlink
> nft_counter xt_addrtype nft_compat nft_chain_nat nf_nat 
> nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink br_netfilter 
> bridge stp llc
> rfkill overlay ib_core intel_rapl_msr intel_rapl_common sb_edac
> x86_pkg_temp_thermal intel_powerclamp coretemp 
> snd_hda_codec_realtek
> snd_hda_codec_generic kvm_intel ledtrig_audio snd_hda_codec_hdmi 
> snd_hda_intel
> snd_intel_dspcfg iTCO_wdt snd_intel_sdw_acpi mei_wdt kvm 
> snd_hda_codec
> iTCO_vendor_support dcdbas snd_hda_core dell_smm_hwmon snd_hwdep 
> irqbypass
> snd_seq snd_seq_device rapl snd_pcm intel_cstate intel_uncore 
> pcspkr mei_me
> i2c_i801 snd_timer i2c_smbus snd mei soundcore lpc_ich nfsd 
> auth_rpcgss nfs_acl
> lockd grace ip_tables x_tables ext4 mbcache jbd2 btrfs xor 
> zstd_compress
> raid6_pq zstd_decompress sd_mod sr_mod cdrom sg radeon 
> i2c_algo_bit
> drm_kms_helper syscopyarea sysfillrect
> [ 1917.557579] sysimgblt fb_sys_fops cec bnx2x drm_ttm_helper 
> nvme_tcp ttm
> nvme_fabrics drm mpt3sas ahci crct10dif_pclmul libahci 
> crc32_pclmul crc32c_intel
> nvme libata e1000e ghash_clmulni_intel mdio nvme_core raid_class
> scsi_transport_sas t10_pi wmi dm_multipath sunrpc dm_mirror 
> dm_region_hash
> dm_log dm_mod i2c_dev fuse
> [ 1917.570654] CPU: 28 PID: 843680 Comm: umount Not tainted 
> 5.15.0-0.rc5.39.el8.x86_64 #1
> [ 1917.572078] Hardware name: Dell Inc. Precision T7610/0NK70N, 
> BIOS A18 09/11/2019
> [ 1917.573510] RIP: 
> 0010:btrfsic_process_written_superblock+0x22a/0x2a0 [btrfs]
> [ 1917.575014] Code: 44 24 1c 83 f8 03 0f 85 7e fe ff ff 4c 8b 
> 74 24 08 31 d2 48
> 89 ef 4c 89 f6 e8 82 f1 ff ff 89 c2 31 c0 83 fa ff 75 a1 89 04 
> 24 <0f> 0b 48 89
> ef e8 36 3f 01 00 8b 04 24 eb 8f 48 8b 40 60 48 89 04
> [ 1917.578044] RSP: 0018:ffffb642afb47940 EFLAGS: 00010246
> [ 1917.579569] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 
> 0000000000000000
> [ 1917.581101] RDX: 00000000ffffffff RSI: ffff8b722fc97d00 RDI: 
> ffff8b722fc97d00
> [ 1917.582645] RBP: ffff8b5601c00000 R08: 0000000000000000 R09: 
> c0000000ffff7fff
> [ 1917.584188] R10: 0000000000000001 R11: ffffb642afb476f8 R12: 
> ffffffffffffffff
> [ 1917.585737] R13: ffffb642afb47974 R14: ffff8b5499254c00 R15: 
> 0000000000000003
> [ 1917.587287] FS:  00007f00a06d4080(0000) 
> GS:ffff8b722fc80000(0000) knlGS:0000000000000000
> [ 1917.588846] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1917.590410] CR2: 00007fff5cff5ff0 CR3: 00000001c0c2a006 CR4: 
> 00000000001706e0
> [ 1917.591989] Call Trace:
> [ 1917.593549]  btrfsic_process_written_block+0x2f7/0x850 
> [btrfs]
> [ 1917.595154]  __btrfsic_submit_bio.part.19+0x310/0x330 [btrfs]
> [ 1917.596754]  ? bio_associate_blkg_from_css+0xa4/0x2c0
> [ 1917.598309]  btrfsic_submit_bio+0x18/0x30 [btrfs]
> [ 1917.599918]  write_dev_supers+0x81/0x2a0 [btrfs]
> [ 1917.601525]  ? find_get_pages_range_tag+0x219/0x280
> [ 1917.603090]  ? pagevec_lookup_range_tag+0x24/0x30
> [ 1917.604642]  ? __filemap_fdatawait_range+0x6d/0xf0
> [ 1917.606199]  ? 
> __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
> [ 1917.607782]  ? find_first_extent_bit+0x9b/0x160 [btrfs]
> [ 1917.609406]  ? 
> __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
> [ 1917.610996]  write_all_supers+0x1b3/0xa70 [btrfs]
> [ 1917.612625]  ? 
> __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
> [ 1917.614213]  btrfs_commit_transaction+0x59d/0xac0 [btrfs]
> [ 1917.615851]  close_ctree+0x11d/0x339 [btrfs]
> [ 1917.617507]  generic_shutdown_super+0x71/0x110
> [ 1917.619102]  kill_anon_super+0x14/0x30
> [ 1917.620695]  btrfs_kill_super+0x12/0x20 [btrfs]
> [ 1917.622329]  deactivate_locked_super+0x31/0x70
> [ 1917.623922]  cleanup_mnt+0xb8/0x140
> [ 1917.625515]  task_work_run+0x6d/0xb0
> [ 1917.627108]  exit_to_user_mode_prepare+0x1f0/0x200
> [ 1917.628702]  syscall_exit_to_user_mode+0x12/0x30
> [ 1917.630294]  do_syscall_64+0x46/0x80
> [ 1917.631863]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 1917.633424] RIP: 0033:0x7f009f711dfb
> [ 1917.634951] Code: 20 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 
> 90 f3 0f 1e fa 31
> f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 
> 05 <48> 3d 01 f0
> ff ff 73 01 c3 48 8b 0d 5d 20 2c 00 f7 d8 64 89 01 48
> [ 1917.638123] RSP: 002b:00007fff5cff7928 EFLAGS: 00000246 
> ORIG_RAX: 00000000000000a6
> [ 1917.639711] RAX: 0000000000000000 RBX: 000055b68c6c9970 RCX: 
> 00007f009f711dfb
> [ 1917.641286] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 
> 000055b68c6c9b50
> [ 1917.642863] RBP: 0000000000000000 R08: 000055b68c6ca900 R09: 
> 00007f009f795580
> [ 1917.644424] R10: 0000000000000000 R11: 0000000000000246 R12: 
> 000055b68c6c9b50
> [ 1917.645960] R13: 00007f00a04bf184 R14: 0000000000000000 R15: 
> 00000000ffffffff
> [ 1917.647501] ---[ end trace 2c4b82abcef9eec4 ]---
> [ 1917.649018] S-65536(sdb2/65536/1)
> [ 1917.649019]  -->
> [ 1917.650492] M-1064960(sdb2/1064960/1)
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/10/14
