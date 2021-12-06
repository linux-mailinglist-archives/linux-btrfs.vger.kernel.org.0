Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8BE46A378
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 18:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344539AbhLFRwe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 12:52:34 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59214 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344408AbhLFRwa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 12:52:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3DB181FE04;
        Mon,  6 Dec 2021 17:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638812941;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DI75RRGTuYAUmwltrNtOcByAzqGNJnO1YQgFxF3NthY=;
        b=iGHFGKPvNMlsSBsAs4r9AXS9HrPnFvhP31+ZJr3f1sghzlDnhn9MnwCYZd8XqSeExub9+x
        05dcppbT/7eUyAlql3u7kifPd9/OQOSL8QuYylkw92F9+9xQO4uCZy/tRo/DXEUgY9nXZZ
        SFJA77kRakrr+W2ZOPVKRzqR5IGh9F4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638812941;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DI75RRGTuYAUmwltrNtOcByAzqGNJnO1YQgFxF3NthY=;
        b=76oA9PnwQdsGPdJL9G765NG9T7J9PduL/UExjutYg2k9Gr5gXHUvQPRjh/RUdTD69pKltF
        s412MwGor71EdrBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0A14AA3B87;
        Mon,  6 Dec 2021 17:49:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D54B1DA799; Mon,  6 Dec 2021 18:48:46 +0100 (CET)
Date:   Mon, 6 Dec 2021 18:48:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: free exchange changeset on failures
Message-ID: <20211206174846.GO28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
References: <95ce11234dd6911a433b1a016e4d4194856212b5.1638523623.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ce11234dd6911a433b1a016e4d4194856212b5.1638523623.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 03, 2021 at 02:55:33AM -0800, Johannes Thumshirn wrote:
> Fstests runs on my VMs have show several kmemleak reports like the following.
> 
>   unreferenced object 0xffff88811ae59080 (size 64):
>     comm "xfs_io", pid 12124, jiffies 4294987392 (age 6.368s)
>     hex dump (first 32 bytes):
>       00 c0 1c 00 00 00 00 00 ff cf 1c 00 00 00 00 00  ................
>       90 97 e5 1a 81 88 ff ff 90 97 e5 1a 81 88 ff ff  ................
>     backtrace:
>       [<00000000ac0176d2>] ulist_add_merge+0x60/0x150 [btrfs]
>       [<0000000076e9f312>] set_state_bits+0x86/0xc0 [btrfs]
>       [<0000000014fe73d6>] set_extent_bit+0x270/0x690 [btrfs]
>       [<000000004f675208>] set_record_extent_bits+0x19/0x20 [btrfs]
>       [<00000000b96137b1>] qgroup_reserve_data+0x274/0x310 [btrfs]
>       [<0000000057e9dcbb>] btrfs_check_data_free_space+0x5c/0xa0 [btrfs]
>       [<0000000019c4511d>] btrfs_delalloc_reserve_space+0x1b/0xa0 [btrfs]
>       [<000000006d37e007>] btrfs_dio_iomap_begin+0x415/0x970 [btrfs]
>       [<00000000fb8a74b8>] iomap_iter+0x161/0x1e0
>       [<0000000071dff6ff>] __iomap_dio_rw+0x1df/0x700
>       [<000000002567ba53>] iomap_dio_rw+0x5/0x20
>       [<0000000072e555f8>] btrfs_file_write_iter+0x290/0x530 [btrfs]
>       [<000000005eb3d845>] new_sync_write+0x106/0x180
>       [<000000003fb505bf>] vfs_write+0x24d/0x2f0
>       [<000000009bb57d37>] __x64_sys_pwrite64+0x69/0xa0
>       [<000000003eba3fdf>] do_syscall_64+0x43/0x90
> 
> In case brtfs_qgroup_reserve_data() or btrfs_delalloc_reserve_metadata()
> fail the allocated extent_changeset will not be freed.
> 
> So in btrfs_check_data_free_space() and btrfs_delalloc_reserve_space()
> free the allocated extent_changeset to get rid of the allocated memory.
> 
> Cc: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to devel with Filipe's comment, thanks.
