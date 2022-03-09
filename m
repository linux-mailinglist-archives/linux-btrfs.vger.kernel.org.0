Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC874D26A7
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 05:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiCIDTs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 8 Mar 2022 22:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiCIDTr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 22:19:47 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5846CA705
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 19:18:49 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 4861A244A76; Tue,  8 Mar 2022 22:18:47 -0500 (EST)
Date:   Tue, 8 Mar 2022 22:18:47 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: list_del corruption splat in 5.10.104
Message-ID: <Yigcl1ib4uTJ+ikY@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is during a mount after a crash.  The crash was due to the "dedupe"
lockup reported at

	https://lore.kernel.org/linux-btrfs/Ybz4JI+Kl2J7Py3z@hungrycats.org/T/#m182b8102cce5a7687912e9b7ba0c976c4c16c066

and balance was running at the time of the crash.

Mounting on 5.10.103 was OK.

	[  180.281774][T16199] list_del corruption. prev->next should be ffff9dd19132ca40, but was 0000000000000000
	[  180.281794][T16199] ------------[ cut here ]------------
	[  180.281796][T16199] kernel BUG at lib/list_debug.c:51!
	[  180.282003][T16199] invalid opcode: 0000 [#1] SMP NOPTI
	[  180.282112][T16199] CPU: 1 PID: 16199 Comm: mount Not tainted 5.10.104-zb64-14ea246c73c7+ #12
	[  180.282235][T16199] Hardware name: System manufacturer System Product Name/PRIME X570-PRO, BIOS 4021 08/09/2021
	[  180.282372][T16199] RIP: 0010:__list_del_entry_valid.cold+0x31/0x47
	[  180.282487][T16199] Code: 9b b4 86 e8 c1 0e fe ff 0f 0b 48 c7 c7 f0 9b b4 86 e8 b3 0e fe ff 0f 0b 48 89 f2 48 89 fe 48 c7 c7 b0 9b b4 86 e8 9f 0e fe ff <0f> 0b 48 89 fe 4c 89 c2 48 c7 c7 78 9b b4 86 e8 8b 0e fe ff 0f 0b
	[  180.282667][T16199] RSP: 0018:ffffb25581fdbae8 EFLAGS: 00010246
	[  180.282771][T16199] RAX: 0000000000000054 RBX: ffff9dd19132ca40 RCX: 0000000000000000
	[  180.282902][T16199] RDX: 0000000000000000 RSI: ffff9deee65f22d0 RDI: ffff9deee65f22d0
	[  180.283029][T16199] RBP: ffffb25581fdbae8 R08: 0000000000000001 R09: 0000000000000001
	[  180.283156][T16199] R10: 0000000000000001 R11: 0000000000000000 R12: ffff9dd19132c000
	[  180.283284][T16199] R13: ffff9dd191343000 R14: ffff9dd0c009e640 R15: ffff9dd191337000
	[  180.283405][T16199] FS:  00007f7453925840(0000) GS:ffff9deee6400000(0000) knlGS:0000000000000000
	[  180.283533][T16199] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[  180.283645][T16199] CR2: 0000557c4af8f12c CR3: 0000000364d5a000 CR4: 0000000000750ee0
	[  180.283774][T16199] PKRU: 55555554
	[  180.283878][T16199] Call Trace:
	[  180.283982][T16199]  clean_dirty_subvols+0x57/0x140
	[  180.284089][T16199]  btrfs_recover_relocation+0x592/0x5d0
	[  180.284198][T16199]  open_ctree+0x13a0/0x17fc
	[  180.284303][T16199]  btrfs_mount_root.cold+0x12/0xeb
	[  180.284412][T16199]  ? rcu_read_lock_sched_held+0x46/0x80
	[  180.284521][T16199]  legacy_get_tree+0x34/0x60
	[  180.284626][T16199]  vfs_get_tree+0x2d/0xc0
	[  180.284731][T16199]  vfs_kern_mount.part.0+0x78/0xc0
	[  180.284835][T16199]  vfs_kern_mount+0x13/0x20
	[  180.284955][T16199]  btrfs_mount+0x11f/0x3c0
	[  180.285060][T16199]  ? rcu_read_lock_sched_held+0x46/0x80
	[  180.285169][T16199]  legacy_get_tree+0x34/0x60
	[  180.285276][T16199]  vfs_get_tree+0x2d/0xc0
	[  180.285380][T16199]  path_mount+0x494/0xd20
	[  180.285483][T16199]  __x64_sys_mount+0x108/0x140
	[  180.285588][T16199]  do_syscall_64+0x38/0x90
	[  180.285692][T16199]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[  180.285803][T16199] RIP: 0033:0x7f7453b659ea
	[  180.285904][T16199] Code: 48 8b 0d a9 f4 0b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 f4 0b 00 f7 d8 64 89 01 48
	[  180.286086][T16199] RSP: 002b:00007ffd42f27758 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
	[  180.286206][T16199] RAX: ffffffffffffffda RBX: 00007f7453c88264 RCX: 00007f7453b659ea
	[  180.286333][T16199] RDX: 0000561821e02060 RSI: 0000561821dfad20 RDI: 0000561821dfad00
	[  180.286461][T16199] RBP: 0000561821dfa960 R08: 0000561821dfac40 R09: 0000561821dfa010
	[  180.286589][T16199] R10: 000000000000040e R11: 0000000000000246 R12: 0000000000000000
	[  180.286717][T16199] R13: 0000561821dfad00 R14: 0000561821e02060 R15: 0000561821dfa960
	[  180.286844][T16199] Modules linked in: nf_conntrack_netlink softdog cpufreq_userspace cpufreq_powersave cpufreq_conservative binfmt_misc nfsd auth_rpcgss nfs_acl nfs lockd grace nfs_ssc fscache sunrpc nbd tcp_cubic sch_fq_codel nls_iso8859_1 nls_cp437 vfat fat nct6775 jc42 netconsole hwmon_vid k8temp dummy amd64_edac_mod edac_mce_amd kvm_amd kvm snd_hda_codec_realtek irqbypass snd_hda_codec_generic eeepc_wmi rapl ledtrig_audio snd_hda_codec_hdmi asus_wmi battery snd_hda_intel sparse_keymap snd_intel_dspcfg rfkill ftdi_sio soundwire_intel mxm_wmi k10temp sp5100_tco input_leds soundwire_generic_allocation wmi_bmof usbserial soundwire_cadence snd_hda_codec ccp snd_hda_core snd_hwdep snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_pcm snd_timer snd soundcore sg evdev acpi_cpufreq nft_chain_nat xt_nat nf_nat xt_tcpudp xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_log_ipv4 nf_log_common nft_counter nft_limit xt_LOG xt_limit nft_compat x_tables nf_tables
	[  180.287619][T16199] ---[ end trace c17ef41aec92d1c1 ]---

	clean_dirty_subvols+0x57/0x140:

	clean_dirty_subvols at include/linux/list.h:132
	 127            entry->prev = NULL;
	 128    }
	 129    
	 130    static inline void __list_del_entry(struct list_head *entry)
	 131    {
	>132<           if (!__list_del_entry_valid(entry))
	 133                    return;
	 134    
	 135            __list_del(entry->prev, entry->next);
	 136    }
	 137    

	btrfs_recover_relocation+0x592/0x5d0:

	btrfs_recover_relocation at fs/btrfs/relocation.c:3881
	 3876                   err = PTR_ERR(trans);
	 3877                   goto out_clean;
	 3878           }
	 3879           err = btrfs_commit_transaction(trans);
	 3880   out_clean:
	>3881<          ret = clean_dirty_subvols(rc);
	 3882           if (ret < 0 && !err)
	 3883                   err = ret;
	 3884   out_unset:
	 3885           unset_reloc_control(rc);
	 3886           free_reloc_control(rc);

