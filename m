Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 169FC1918A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 19:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgCXSJ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 14:09:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:41412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbgCXSJ0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 14:09:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B7E28AAB8;
        Tue, 24 Mar 2020 18:09:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 241C9DA704; Tue, 24 Mar 2020 19:08:54 +0100 (CET)
Date:   Tue, 24 Mar 2020 19:08:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: check/lowmem: Fix access on uninitialized
 memory
Message-ID: <20200324180854.GR12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200324030855.29245-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324030855.29245-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 24, 2020 at 11:08:55AM +0800, Qu Wenruo wrote:
> [BUG]
> There are some reports on fsck/001 test segfault failure with lowmem mode.
> 
> While I failed to reproduce it, valgrind still catches it with the
> following output:
> 
>   Delete backref in extent [12845056 1048576]
>   ERROR: file extent [257, 0] has unaligned disk bytenr: 755944791, should be aligned to 4096
>   ERROR: file extent[257 0] root 5 owner 5 backref lost
>   Deleted root 5 item[257, 108, 0]
>   ==29080== Conditional jump or move depends on uninitialised value(s)
>   ==29080==    at 0x1A81D7: btrfs_release_path (ctree.c:97)
>   ==29080==    by 0x192C33: repair_extent_data_item (mode-lowmem.c:3330)
>   ==29080==    by 0x1962FF: check_leaf_items (mode-lowmem.c:4696)
>   ==29080==    by 0x196ABF: walk_down_tree (mode-lowmem.c:4858)
>   ==29080==    by 0x197762: check_btrfs_root (mode-lowmem.c:5157)
>   ==29080==    by 0x198335: check_chunks_and_extents_lowmem (mode-lowmem.c:5450)
>   ==29080==    by 0x166414: do_check_chunks_and_extents (main.c:8829)
>   ==29080==    by 0x169CF7: cmd_check (main.c:10313)
>   ==29080==    by 0x11CDC6: cmd_execute (commands.h:125)
>   ==29080==    by 0x11D712: main (btrfs.c:386)
>   ==29080==
> 
> [CAUSE]
> In repair_extent_data_item() if we find unaligned file extent, we just
> delete it and kick in hole punch procedure.
> 
> The problem is, file extent deletion is done before initializing @path.
> And when the deletion is done without problem, we will goto out tag,
> which will release @path, containing uninitialized values, and
> triggering segfault.
> 
> [FIX]
> Don't try to abort trans nor free path if we're going through file
> extent deletion routine.
> 
> Fixes: 0617bde3bc15 ("btrfs-progs: lowmem: delete unaligned bytes extent data under repair")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
