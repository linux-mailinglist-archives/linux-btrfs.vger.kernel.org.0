Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECBF490053
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 03:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbiAQCsK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 21:48:10 -0500
Received: from eu-shark1.inbox.eu ([195.216.236.81]:54062 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiAQCsK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 21:48:10 -0500
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 070206C006CF;
        Mon, 17 Jan 2022 04:48:08 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1642387688; bh=fQtvSl2p9YhSDLeWKLtzVUD0IyTKQIMXbHKEBjtZCIY=;
        h=References:From:To:Subject:Date:In-reply-to:Message-ID:
         Content-Type:X-ESPOL:from:date;
        b=ibUrFKUbgAulVMahUeb0b8M6dEpFhk6bn/hl4lPMemJ8vF4+t3N2HuBTVjhyLalEK
         GTPigpruKSJzWaEhD89OtxnSte0Y88G3K91iI30diSMOClk1uhVz2GRlDrKWW+KCGM
         OpjgpIUi/vJ/kN9XjYMQDagZRQvHtyKjGc9VL074=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id EAFBF6C006DB;
        Mon, 17 Jan 2022 04:48:07 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id PYPamjnV6Iwv; Mon, 17 Jan 2022 04:48:07 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 907106C006CF;
        Mon, 17 Jan 2022 04:48:07 +0200 (EET)
References: <20220117023850.40337-1-wqu@suse.com>
 <20220117023850.40337-2-wqu@suse.com>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs-progs: check/lowmem: fix crash when
 METADATA_ITEM has invalid level
Date:   Mon, 17 Jan 2022 10:47:20 +0800
In-reply-to: <20220117023850.40337-2-wqu@suse.com>
Message-ID: <5yqjw00x.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +d1m7upSY16pi16iXXraBxg2qytXXu3s54XO3RxfnHr4OS2Fek4RMmO6n3AFM3H44X8X
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Mon 17 Jan 2022 at 10:38, Qu Wenruo <wqu@suse.com> wrote:

> [BUG]
> When running lowmem mode with METADATA_ITEM which has invalid 
> level, it
> will crash with the following backtrace:
>
>  (gdb) bt
>  #0  0x0000555555616b0b in btrfs_header_bytenr (eb=0x4)
>      at ./kernel-shared/ctree.h:2134
>  #1  0x0000555555620c78 in check_tree_block_backref (root_id=5,
>      bytenr=30457856, level=256) at check/mode-lowmem.c:3818
>  #2  0x0000555555621f6c in check_extent_item 
>  (path=0x7fffffffd9c0)
>      at check/mode-lowmem.c:4334
>  #3  0x00005555556235a5 in check_leaf_items 
>  (root=0x555555688e10,
>      path=0x7fffffffd9c0, nrefs=0x7fffffffda30, account_bytes=1)
>      at check/mode-lowmem.c:4835
>  #4  0x0000555555623c6d in walk_down_tree (root=0x555555688e10,
>      path=0x7fffffffd9c0, level=0x7fffffffd984, 
>      nrefs=0x7fffffffda30,
>      check_all=1) at check/mode-lowmem.c:4967
>  #5  0x000055555562494f in check_btrfs_root 
>  (root=0x555555688e10, check_all=1)
>      at check/mode-lowmem.c:5266
>  #6  0x00005555556254ee in check_chunks_and_extents_lowmem ()
>      at check/mode-lowmem.c:5556
>  #7  0x00005555555f0b82 in do_check_chunks_and_extents () at 
>  check/main.c:9114
>  #8  0x00005555555f50ea in cmd_check (cmd=0x55555567c640 
>  <cmd_struct_check>,
>      argc=3, argv=0x7fffffffdec0) at check/main.c:10892
>  #9  0x000055555556b2b1 in cmd_execute (argv=0x7fffffffdec0, 
>  argc=3,
>      cmd=0x55555567c640 <cmd_struct_check>) at 
>      cmds/commands.h:125
>
> [CAUSE]
> For function check_extent_item() it will go through inline 
> extent items
> and then check their backrefs.
>
> But for METADATA_ITEM, it doesn't really validate key.offset, 
> which is
> u64 and can contain value way larger than BTRFS_MAX_LEVEL 
> (mostly caused
> by bit flip).
>
> In that case, if we have a larger value like 256 in key.offset, 
> then
> later check_tree_block_backref() will use 256 as level, and 
> overflow
> path->nodes[level] and crash.
>
> [FIX]
> Just verify the level, no matter if it's from 
> btrfs_tree_block_level()
> (which is just u8), or it's from key.offset (which is u64).
>
> To do the check properly and detect higher bits corruption, also 
> change
> the type of @level from u8 to u64.
>
> Now lowmem mode can detect the problem properly:
>
>  ...
>  [2/7] checking extents
>  ERROR: tree block 30457856 has bad backref level, has 256 
>  expect [0, 7]
>  ERROR: extent[30457856 16384] level mismatch, wanted: 0, have: 
>  256
>  ERROR: errors found in extent allocation tree or chunk 
>  allocation
>  [3/7] checking free space tree
>  ...
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
Reviewed-by: Su Yue <l@damenly.su>

--
Su
> ---
>  check/mode-lowmem.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
> index cc6773cd4d0c..99f519631a50 100644
> --- a/check/mode-lowmem.c
> +++ b/check/mode-lowmem.c
> @@ -4242,7 +4242,7 @@ static int check_extent_item(struct 
> btrfs_path *path)
>  	u64 owner_offset;
>  	u64 super_gen;
>  	int metadata = 0;
> -	int level;
> +	u64 level;	/* To handle corrupted values in skinny 
> backref */
>  	struct btrfs_key key;
>  	int ret;
>  	int err = 0;
> @@ -4303,6 +4303,16 @@ static int check_extent_item(struct 
> btrfs_path *path)
>  		/* New METADATA_ITEM */
>  		level = key.offset;
>  	}
> +
> +	if (metadata && level >= BTRFS_MAX_LEVEL) {
> +		error(
> +	"tree block %llu has bad backref level, has %llu expect 
> [0, %u]",
> +		      key.objectid, level, BTRFS_MAX_LEVEL - 1);
> +		err |= BACKREF_MISMATCH;
> +		/* This is a critical error, exit right now */
> +		goto out;
> +	}
> +
>  	ptr_offset = ptr - (unsigned long)ei;
>
>  next:
