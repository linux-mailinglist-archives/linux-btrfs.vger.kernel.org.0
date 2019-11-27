Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C38F10B5B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 19:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfK0S0z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 13:26:55 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34171 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0S0z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 13:26:55 -0500
Received: by mail-qk1-f195.google.com with SMTP id d202so12078953qkb.1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2019 10:26:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0uRlc0b8wibx4TB5HA6Kci7E6XGVkvvZhN4p8gxkcGg=;
        b=EGz5MgkhTo2ruy0fFt3cXku6P9NgCJYF05X5xawEtbVU5DJYMNyRfMZCRdODbpUUjJ
         F+sXDYN1pMgTXdMCsGh3w4chSzxeWnucnMCZd6LENa7C1kHFmYW2OcVl2CHB+Of09XCz
         xzgz15gc68kvjd/MYZCx/tpzetZNROR7w8s8i5erIf7nVxHco0pZLqsVMT8T2yN07f54
         9pPM+u7mRIDaSqWQEU/9FHftW3DGUhw2VwmfA35P+7z9u5CM159wp+WBTSuTjFQIyC6M
         I+m6yp1BqgWWsh3UHNF1/LHsUAvTbBfMrk9Hb+8cBHMUNWlkW6ZArXZ1WxEEeHFfGbeT
         X8Cw==
X-Gm-Message-State: APjAAAWCsz1vPqdAMb7iectaSEYGzy2Y2Ixb00reWE53cp7sr8tRuWEZ
        VXwbmbmVdlBOnAusoxMBUg8=
X-Google-Smtp-Source: APXvYqzGIWMoLG2EZpaOckgLrrl7wb0oqY4HKmhvYi0oOWCWCRims8zmCyJf1BXi2TGcobL+Bqfo1w==
X-Received: by 2002:a37:8285:: with SMTP id e127mr6059101qkd.62.1574879214752;
        Wed, 27 Nov 2019 10:26:54 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::3:5762])
        by smtp.gmail.com with ESMTPSA id f25sm6981763qkh.93.2019.11.27.10.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 10:26:54 -0800 (PST)
Date:   Wed, 27 Nov 2019 13:26:52 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Dennis Zhou <dennis@kernel.org>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 00/22] btrfs: async discard support
Message-ID: <20191127182652.GA53864@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1574709825.git.dennis@kernel.org>
 <20191126215204.GP2734@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126215204.GP2734@twin.jikos.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 26, 2019 at 10:52:04PM +0100, David Sterba wrote:
> On Mon, Nov 25, 2019 at 02:46:40PM -0500, Dennis Zhou wrote:
> > Hello,
> > 
> > v3 [1] had 2 minor issues which are fixed:
> >  - I was generically dividing u64 which made 32 bit arches unhappy. [2]
> >  - Uninitialized use of trim_state local variable [3]
> 
> I've started fstests (misc-5.5 + v4) with some debugging options
> compiled in and MOUNT_OPTIONS -o discard=async:
> 
> btrfs/003:
> 
> [   57.263321] BTRFS info (device vdb): relocating block group 30408704 flags metadata|dup
> [   57.321441] BTRFS info (device vdb): found 8 extents
> [   57.352217] list_add corruption. prev->next should be next (ffff89b6b157f1e0), but was 6b6b6b6b6b6b6b6b. (prev=ffff89b6b3cc59f0).
> [   57.355426] ------------[ cut here ]------------
> [   57.356895] kernel BUG at lib/list_debug.c:26!
> [   57.358303] invalid opcode: 0000 [#1] SMP
> [   57.359522] CPU: 1 PID: 19415 Comm: btrfs Not tainted 5.4.0-rc8-default+ #878
> [   57.361334] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-rebuilt.opensuse.org 04/01/2014
> [   57.364468] RIP: 0010:__list_add_valid+0x5e/0x70
> [   57.369959] RSP: 0018:ffff90cbc4c7f8d0 EFLAGS: 00010246
> [   57.371475] RAX: 0000000000000075 RBX: ffff89b6b3d04000 RCX: 0000000000000006
> [   57.372930] RDX: 0000000000000000 RSI: ffff89b6b2314030 RDI: ffff89b6b2313740
> [   57.374893] RBP: ffff89b6b157f0d0 R08: 0000000d5aa62d0d R09: 0000000000000000
> [   57.376970] R10: 0000000000000000 R11: 0000000000000000 R12: ffff89b6b3d041f0
> [   57.378961] R13: ffff89b6b3cc59f0 R14: ffff89b6b157f190 R15: ffff89b6b157f1e0
> [   57.381012] FS:  00007f551b41d8c0(0000) GS:ffff89b6bd800000(0000) knlGS:0000000000000000
> [   57.383531] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   57.385264] CR2: 0000563d526212d8 CR3: 0000000073dd3004 CR4: 0000000000160ee0
> [   57.387223] Call Trace:
> [   57.388250]  btrfs_add_to_discard_unused_list+0xa2/0xe0 [btrfs]
> [   57.389804]  btrfs_discard_queue_work+0x3a/0x60 [btrfs]
> [   57.390961]  __btrfs_add_free_space+0xe2/0x400 [btrfs]
> [   57.401053]  ? do_raw_spin_unlock+0x4b/0xc0
> [   57.402419]  ? _raw_spin_unlock+0x24/0x30
> [   57.403791]  ? find_first_extent_bit+0xdc/0x120 [btrfs]
> [   57.405312]  add_new_free_space+0xd1/0xf0 [btrfs]
> [   57.406723]  btrfs_make_block_group+0x9f/0x2e0 [btrfs]
> [   57.408222]  __btrfs_alloc_chunk+0x705/0xf00 [btrfs]
> [   57.409786]  btrfs_chunk_alloc+0x1a9/0x3f0 [btrfs]
> [   57.411354]  btrfs_inc_block_group_ro+0x16d/0x190 [btrfs]
> [   57.412897]  btrfs_relocate_block_group+0x60/0x300 [btrfs]
> [   57.414430]  btrfs_relocate_chunk+0x32/0xd0 [btrfs]
> [   57.415747]  __btrfs_balance+0x41c/0xcc0 [btrfs]
> [   57.417084]  btrfs_balance+0x56e/0xa40 [btrfs]
> [   57.418361]  ? kmem_cache_alloc_trace+0x281/0x2c0
> [   57.419448]  btrfs_ioctl_balance+0x298/0x350 [btrfs]
> [   57.420568]  ? mem_cgroup_throttle_swaprate+0xcb/0x2a8
> [   57.422306]  btrfs_ioctl+0x466/0x2570 [btrfs]
> [   57.423648]  ? __handle_mm_fault+0x499/0x740
> [   57.425008]  ? kvm_sched_clock_read+0x14/0x30
> [   57.426311]  ? sched_clock+0x5/0x10
> [   57.427480]  ? sched_clock_cpu+0x10/0x120
> [   57.428856]  ? __handle_mm_fault+0x499/0x740
> [   57.430314]  ? do_raw_spin_unlock+0x4b/0xc0
> [   57.431695]  ? _raw_spin_unlock+0x24/0x30
> [   57.432997]  ? __handle_mm_fault+0x499/0x740
> [   57.434370]  ? do_vfs_ioctl+0x405/0x730
> [   57.435920]  do_vfs_ioctl+0x405/0x730
> [   57.437439]  ? do_user_addr_fault+0x1f1/0x3c0
> [   57.439096]  ksys_ioctl+0x3a/0x70
> [   57.440518]  ? trace_hardirqs_off_thunk+0x1a/0x20
> [   57.442159]  __x64_sys_ioctl+0x16/0x20
> [   57.443315]  do_syscall_64+0x50/0x1f0
> [   57.444252]  entry_SYSCALL_64_after_hwframe+0x49/0xbek

Sigh, I'm sorry about these issues with the series. I think this is
being racy in btrfs_delete_unused_bgs(). I'm working on setting up the
reproducer and fixing it.

Thanks,
Dennis
