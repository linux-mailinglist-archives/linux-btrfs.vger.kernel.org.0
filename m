Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45A322B62E
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2019 15:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfE0NUs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 May 2019 09:20:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:59458 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbfE0NUr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 May 2019 09:20:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D89B2AE78
        for <linux-btrfs@vger.kernel.org>; Mon, 27 May 2019 13:20:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1AA0EDA85C; Mon, 27 May 2019 15:21:41 +0200 (CEST)
Date:   Mon, 27 May 2019 15:21:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reloc: Also queue orphan reloc tree for cleanup
 to avoid BUG_ON()
Message-ID: <20190527132140.GI15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190522083311.32105-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522083311.32105-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 22, 2019 at 04:33:11PM +0800, Qu Wenruo wrote:
> [BUG]
> When a fs has orphan reloc tree along with unfinished balance:
>   ...
>         item 16 key (TREE_RELOC ROOT_ITEM FS_TREE) itemoff 12090 itemsize 439
>                 generation 12 root_dirid 256 bytenr 300400640 level 1 refs 0 <<<
>                 lastsnap 8 byte_limit 0 bytes_used 1359872 flags 0x0(none)
>                 uuid 7c48d938-33a3-4aae-ab19-6e5c9d406e46
>         item 17 key (BALANCE TEMPORARY_ITEM 0) itemoff 11642 itemsize 448
>                 temporary item objectid BALANCE offset 0
>                 balance status flags 14
> 
> Then at mount time, we can hit the following kernel BUG_ON():
>   BTRFS info (device dm-3): relocating block group 298844160 flags metadata|dup
>   ------------[ cut here ]------------
>   kernel BUG at fs/btrfs/relocation.c:1413!
>   invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 1 PID: 897 Comm: btrfs-balance Tainted: G           O      5.2.0-rc1-custom #15
>   RIP: 0010:create_reloc_root+0x1eb/0x200 [btrfs]
>   Call Trace:
>    btrfs_init_reloc_root+0x96/0xb0 [btrfs]
>    record_root_in_trans+0xb2/0xe0 [btrfs]
>    btrfs_record_root_in_trans+0x55/0x70 [btrfs]
>    select_reloc_root+0x7e/0x230 [btrfs]
>    do_relocation+0xc4/0x620 [btrfs]
>    relocate_tree_blocks+0x592/0x6a0 [btrfs]
>    relocate_block_group+0x47b/0x5d0 [btrfs]
>    btrfs_relocate_block_group+0x183/0x2f0 [btrfs]
>    btrfs_relocate_chunk+0x4e/0xe0 [btrfs]
>    btrfs_balance+0x864/0xfa0 [btrfs]
>    balance_kthread+0x3b/0x50 [btrfs]
>    kthread+0x123/0x140
>    ret_from_fork+0x27/0x50
> 
> [CAUSE]
> In btrfs, reloc trees are used to record swapped tree blocks during
> balance.
> Reloc tree either get merged (replace old tree blocks of its parent
> subvolume) in next transaction if its ref is 1 (fresh).
> Or is already merged and will be cleaned up if its ref is 0 (orphan).
> 
> After commit d2311e698578 ("btrfs: relocation: Delay reloc tree deletion
> after merge_reloc_roots"), reloc tree cleanup is delayed until one block
> group is balanced.
> 
> Since fresh reloc roots are recorded during merge, as long as there
> is no power loss, those orphan reloc roots converted from fresh ones are
> handled without problem.
> 
> However when power loss happens, orphan reloc roots can be recorded
> on-disk, thus at next mount time, we will have orphan reloc roots from
> on-disk data directly, and ignored by clean_dirty_subvols() routine.
> 
> Then when background balance starts to balance another block group, and
> needs to create new reloc root for the same root, btrfs_insert_item()
> returns -EEXIST, and trigger that BUG_ON().
> 
> [FIX]
> For orphan reloc roots, also queue them to rc->dirty_subvol_roots, so
> all reloc roots no matter orphan or not, can be cleaned up properly and
> avoid above BUG_ON().
> 
> And to cooperate with above change, clean_dirty_subvols() will check if
> the queued root is a reloc root or a subvol root.
> For a subvol root, do the old work, and for a orphan reloc root, clean it
> up.
> 
> Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I've hit that BUG_ON too on my work machine too. Thanks for the fix,
queued for 5.2-rc.
