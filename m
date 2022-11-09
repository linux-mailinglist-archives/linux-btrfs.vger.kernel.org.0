Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A78622A71
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 12:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiKILZv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 06:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiKILZo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 06:25:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840701902B
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Nov 2022 03:25:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3786F1F8BA;
        Wed,  9 Nov 2022 11:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667993142;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CfkvkcaCQuynyQ3oTmlzzo+U1Y+xyBFxX3QZhyj3U7E=;
        b=b+dpHGmxL2Oba0/QivCgjB3h00pX88lFDakY6qYhn1FwW0B0DDNWmW4LZ+a8V86H94UDvx
        4G9r1tPc/pegrlCx9P4+gPowUQw6HpTmb/aAaKja+MLdtp+Uz5pXXvPLjd/mIwt58QR7D0
        p7tM9ganxhv6Pukl5SOY2c3rkJnVhXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667993142;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CfkvkcaCQuynyQ3oTmlzzo+U1Y+xyBFxX3QZhyj3U7E=;
        b=MD+OT3D9Hyk1SQYlyHX4BVxAeqv1VxPKH8veRxCtEmq3xVnwvmc0lhH2JhzXed0GceQN7H
        14OOkL9RCWME84AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E9BC41331F;
        Wed,  9 Nov 2022 11:25:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KVYoODWOa2N4OgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 09 Nov 2022 11:25:41 +0000
Date:   Wed, 9 Nov 2022 12:25:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [linux-stable-rc:linux-5.4.y] [btrfs]  85dc4aac7e:
 WARNING:at_fs/btrfs/delayed-inode.c:#btrfs_assert_delayed_root_empty[btrfs]
Message-ID: <20221109112519.GD5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <202211082152.a27f6bb4-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211082152.a27f6bb4-oliver.sang@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 08, 2022 at 10:00:45PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed WARNING:at_fs/btrfs/delayed-inode.c:#btrfs_assert_delayed_root_empty[btrfs] due to commit (built with gcc-11):
> 
> commit: 85dc4aac7e99eace884f697c208cc2424cd2cca8 ("btrfs: check the root node for uptodate before returning it")
> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> 
> in testcase: xfstests
> version: xfstests-x86_64-c1144bf-1_20220822
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: btrfs
> 	test: generic-group-04
> 
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> 
> on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz (Ivy Bridge) with 16G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202211082152.a27f6bb4-oliver.sang@intel.com
> 
> 
> [   42.423075][ T2510] ------------[ cut here ]------------
> [   42.423209][ T2510] WARNING: CPU: 5 PID: 2510 at fs/btrfs/delayed-inode.c:1399 btrfs_assert_delayed_root_empty+0x3a/0x80 [btrfs]

1397 void btrfs_assert_delayed_root_empty(struct btrfs_fs_info *fs_info)                                                                                                                                             
1398 {                                                                                                                                                                                                               
1399         WARN_ON(btrfs_first_delayed_node(fs_info->delayed_root));                                                                                                                                               
1400 }

> [   42.423404][ T2510] Modules linked in: dm_snapshot dm_bufio dm_mod netconsole btrfs xor zstd_decompress zstd_compress raid6_pq libcrc32c intel_rapl_msr in
> tel_rapl_common sd_mod sg x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_int
> el rapl i915 ipmi_devintf ahci ipmi_msghandler intel_gtt intel_cstate libahci intel_uncore drm_kms_helper firewire_ohci libata syscopyarea firewire_core sysf
> illrect crc_itu_t sysimgblt fb_sys_fops mxm_wmi video wmi drm fuse ip_tables
> [   42.424195][ T2510] CPU: 5 PID: 2510 Comm: xfs_io Not tainted 5.4.173-00261-g85dc4aac7e99 #1
> [   42.424344][ T2510] Hardware name:  /DZ77BH-55K, BIOS BHZ7710H.86A.0097.2012.1228.1346 12/28/2012
> [   42.424523][ T2510] RIP: 0010:btrfs_assert_delayed_root_empty+0x3a/0x80 [btrfs]
> [   42.424656][ T2510] Code: 48 89 fb 48 81 c7 40 ce 00 00 48 89 fa 48 c1 ea 03 80 3c 02 00 75 17 48 8b bb 40 ce 00 00 e8 cd d4 ff ff 48 85 c0 75 02 5b c3 <0
> f> 0b 5b c3 e8 fd 33 34 e0 eb e2 66 66 2e 0f 1f 84 00 00 00 00 00
> [   42.424969][ T2510] RSP: 0018:ffff88831e3078d8 EFLAGS: 00010286
> [   42.425078][ T2510] RAX: ffff888412bc0178 RBX: ffff88831ebd0000 RCX: ffffffff832a1f01
> [   42.425214][ T2510] RDX: 1ffff1106696c091 RSI: 0000000000000004 RDI: ffff888334b60480
> [   42.425353][ T2510] RBP: ffff88831ebd0000 R08: ffff888412bc0178 R09: ffffed1063c60f0d
> [   42.425489][ T2510] R10: 0000000000000003 R11: 0000000000000001 R12: ffff88831ebd0010
> [   42.425627][ T2510] R13: ffff88831ebd0398 R14: ffff88831ebdc938 R15: ffff88831ebd0000
> [   42.425765][ T2510] FS:  00007f967a342700(0000) GS:ffff88835de80000(0000) knlGS:0000000000000000
> [   42.425917][ T2510] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   42.426031][ T2510] CR2: 000055fd413c6bb0 CR3: 000000041d20e004 CR4: 00000000001606e0
> [   42.426169][ T2510] Call Trace:
> [   42.426255][ T2510]  btrfs_cleanup_transaction+0x4ef/0x700 [btrfs]
> [   42.426380][ T2510]  ? __cancel_work_timer+0x1bd/0x400
> [   42.426475][ T2510]  ? try_to_grab_pending+0x500/0x500
> [   42.426589][ T2510]  ? btrfs_cleanup_one_transaction+0x5c0/0x5c0 [btrfs]
> [   42.426713][ T2510]  ? _raw_spin_lock+0x81/0x100
> [   42.426800][ T2510]  ? _raw_spin_trylock_bh+0x140/0x140
> [   42.426913][ T2510]  close_ctree+0x508/0x740 [btrfs]

unmount time

> [   42.427027][ T2510]  ? btrfs_cleanup_transaction+0x700/0x700 [btrfs]
> [   42.427152][ T2510]  ? fsnotify_grab_connector+0x8f/0x100
> [   42.427260][ T2510]  ? fsnotify_destroy_marks+0x62/0x200
> [   42.427357][ T2510]  ? fsnotify_clear_marks_by_group+0x4c0/0x4c0
> [   42.427479][ T2510]  ? btrfs_sync_fs+0x9a/0x2c0 [btrfs]
> [   42.427599][ T2510]  generic_shutdown_super+0x12e/0x340
> [   42.427695][ T2510]  kill_anon_super+0x36/0x80
> [   42.427793][ T2510]  btrfs_kill_super+0x3d/0x2c0 [btrfs]
> [   42.427893][ T2510]  deactivate_locked_super+0x89/0x100
> [   42.427990][ T2510]  deactivate_super+0x11c/0x140
> [   42.428077][ T2510]  ? deactivate_locked_super+0x100/0x100
> [   42.428177][ T2510]  cleanup_mnt+0x355/0x540
> [   42.428260][ T2510]  task_work_run+0x116/0x1c0
> [   42.428344][ T2510]  do_exit+0x556/0xd40
