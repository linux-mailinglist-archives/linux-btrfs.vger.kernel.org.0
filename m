Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8CE4C43C5
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Feb 2022 12:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240186AbiBYLk1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Feb 2022 06:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240179AbiBYLk0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Feb 2022 06:40:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9501B01BA
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Feb 2022 03:39:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5925961976
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Feb 2022 11:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CEAC340EF;
        Fri, 25 Feb 2022 11:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645789192;
        bh=+Ow84BmFB2F6OFZzSz7+C7lGO1cCtrZIh0VcF8UP0aE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AMdtqrTLHuLKixd6Kr72ORXrhnU2dNQZUEw+mfrw/a30KvYNKkrJHs+68JZrclyK9
         uJo9q+FcywNzKL3BH70SXv8cb8Nq8AwxA505OIMAQ04XtJ9HQyGGkgOLtabEmsdGM1
         rhMdIxqtkyGnYp7CVW2wvaNyoIss67Hzjkf7iggYgtjeLy57bN8Oo6E0oZ/TV85dJh
         ZUIKDTJkOmo9YtStQllD6Wz0w6wFCQ06XgaotnxfgoNTWnudEzcRS2Iluzx4eXR15v
         rsyKHWx99BLyVJ4+zZ3DQtp9wFaGHz54BcITgDCaWd30cXspemx9rwuvTC/rvYjRkP
         O91jxujOGVQXg==
Date:   Fri, 25 Feb 2022 11:39:49 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        naohiro.aota@wdc.com
Subject: Re: Seed device is broken, again.
Message-ID: <YhjABVTN5rT0Ikel@debian9.Home>
References: <88176dfc-2500-1e9c-bac0-5e293b2c0b5c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88176dfc-2500-1e9c-bac0-5e293b2c0b5c@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 25, 2022 at 06:08:20PM +0800, Qu Wenruo wrote:
> Hi,
> 
> The very basic seed device usage is broken again:
> 
> 	mkfs.btrfs -f $dev1 > /dev/null
> 	btrfstune -S 1 $dev1
> 	mount $dev1 $mnt
> 	btrfs dev add $dev2 $mnt
> 	umount $mnt
> 
> 
> I'm not sure how many guys are really using seed device.
> 
> But I see a lot of weird operations, like calling a definite write operation
> (device add) on a RO mounted fs.
> 
> Can we make at least the seed sprouting part into btrfs-progs instead?
> 
> And can seed device even support the upcoming extent-tree-v2?
> 
> Personally speaking I prefer to mark seed device deprecated completely.
> 
> The call trace:
> 
>  assertion failed: sb_write_started(fs_info->sb), in fs/btrfs/volumes.c:3244

I think you are overreacting a bit about it being broken.

This is a new assertion recently added by Aota, and it's also failing when
balance is resumed on mount, see:

https://lore.kernel.org/linux-btrfs/cover.1645157220.git.naohiro.aota@wdc.com/

Adding him to cc, so that he's aware of this other case.
This only affects misc-next and not any release.

>  ------------[ cut here ]------------
>  kernel BUG at fs/btrfs/ctree.h:3556!
>  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 11 PID: 626 Comm: btrfs Not tainted 5.17.0-rc5-custom+ #2
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>  RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
>  Code: 87 ff ff 4c 89 e1 4c 89 ea 48 c7 c6 68 5f b2 c0 eb e4 89 f1 48 c7 c2
> 8f cb b1 c0 48 89 fe 48 c7 c7 90 5f b2 c0 e8 c8 cd e0 c8 <0f> 0b 49 8b 85 28
> 11 00 00 48 c7 c6 00 60 b2 c0 4c 89 ef 8b 90 fc
>  RSP: 0018:ffffbaa04148bc78 EFLAGS: 00010246
>  RAX: 000000000000004b RBX: ffff97cb45671000 RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: ffff97cbbd0e1aa0 RDI: ffff97cbbd0e1aa0
>  RBP: ffff97cb4478c000 R08: 0000000000000000 R09: ffffbaa04148bab0
>  R10: ffffbaa04148baa8 R11: ffffffff8a4e6968 R12: 0000000000000002
>  R13: 0000000021d00000 R14: ffff97cb4478dfe0 R15: ffff97cb44dfc770
>  FS:  00007fc02f8fb2c0(0000) GS:ffff97cbbd0c0000(0000)
> knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000056327627ac88 CR3: 0000000008938000 CR4: 0000000000750ee0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   btrfs_relocate_chunk.cold+0x42/0x67 [btrfs]
>   btrfs_init_new_device+0x11e5/0x1780 [btrfs]
>   ? btrfs_ioctl+0x1f20/0x32c0 [btrfs]
>   btrfs_ioctl+0x1f20/0x32c0 [btrfs]
>   ? find_held_lock+0x2b/0x80
>   ? mntput_no_expire+0x7c/0x480
>   ? lock_release+0xca/0x2d0
>   ? __x64_sys_ioctl+0x82/0xb0
>   __x64_sys_ioctl+0x82/0xb0
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>  RIP: 0033:0x7fc02f9fc59b
>  Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66
> 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff
> 73 01 c3 48 8b 0d a5 a8 0c 00 f7 d8 64 89 01 48
>  RSP: 002b:00007fffc2620878 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
>  RAX: ffffffffffffffda RBX: 0000556ccf6be870 RCX: 00007fc02f9fc59b
>  RDX: 00007fffc26208d0 RSI: 000000005000940a RDI: 0000000000000003
>  RBP: 00007fffc26208d0 R08: 0000000000000010 R09: 00007fffc261e6c0
>  R10: 0000000000000031 R11: 0000000000000202 R12: 00007fffc2621a90
>  R13: 00007fffc2621a98 R14: 0000000000000000 R15: 0000000000000000
>   </TASK>
>  Modules linked in: target_core_user uio target_core_mod btrfs
> blake2b_generic xor intel_rapl_msr iTCO_wdt raid6_pq iTCO_vendor_support
> snd_hda_codec_generic snd_hda_intel intel_rapl_common snd_intel_dspcfg
> crct10dif_pclmul snd_hda_codec crc32_pclmul ghash_clmulni_intel snd_hwdep
> aesni_intel nls_iso8859_1 snd_hda_core crypto_simd cryptd joydev vfat
> snd_pcm fat psmouse mousedev snd_timer pcspkr i2c_i801 snd i2c_smbus
> soundcore lpc_ich intel_agp intel_gtt qemu_fw_cfg agpgart drm fuse ip_tables
> x_tables xfs libcrc32c crc32c_generic dm_mod virtio_rng virtio_scsi
> virtio_blk rng_core virtio_console virtio_balloon virtio_net net_failover
> failover crc32c_intel serio_raw virtio_pci virtio_pci_legacy_dev
> virtio_pci_modern_dev usbhid
>  Dumping ftrace buffer:
>     (ftrace buffer empty)
>  ---[ end trace 0000000000000000 ]---
> 
> Thanks,
> Qu
> 
