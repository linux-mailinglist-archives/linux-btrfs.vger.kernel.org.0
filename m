Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAECC49085B
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 13:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbiAQMLE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 07:11:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38120 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbiAQMLC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 07:11:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 396D961173
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 12:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A4AC36AE7;
        Mon, 17 Jan 2022 12:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642421461;
        bh=8uMpT3Y/Hw9OyGn5cB3o+q4KU+uNBf9/M8lmzvvZEzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SOH+KVee6GWhLvnMDcYiVUrB0prwdknB6T2Pl5OdmlwHi5wvXt9giwnKm1ES49suy
         +qseItXnZt9Mab6N4X6Wq9/3ERQwKVdBpmgDUWFC/KpdkEop0rJYlaMmkx7C2aJmcn
         7Jrm7J6HxrAtmbcCOrMnCDN0dlH5XRzLzqfCJTU8FV8WNoHD8inNcgyX4ZwOUzFBq9
         YXtk3TgGWYCYfMfzPZ+KAnBCcnM6cojDwyzPTv+qqugNadLNSyXZjnkmPopn/gyzPm
         yknDZTkPYGVgUZZoYcpGkgoBCJbynPtyAKQpaN2X3oW98PHOqUttXPumIXcC5eOdKF
         RodkrxU3KfR5Q==
Date:   Mon, 17 Jan 2022 12:10:58 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Anthony Ruhier <aruhier@mailbox.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs fi defrag hangs on small files, 100% CPU thread
Message-ID: <YeVc0r7lLtns0Bch@debian9.Home>
References: <0a269612-e43f-da22-c5bc-b34b1b56ebe8@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a269612-e43f-da22-c5bc-b34b1b56ebe8@mailbox.org>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 16, 2022 at 08:15:37PM +0100, Anthony Ruhier wrote:
> Hi,
> Since I upgraded from linux 5.15 to 5.16, `btrfs filesystem defrag -t128K`
> hangs on small files (~1 byte) and triggers what it seems to be a loop in
> the kernel. It results in one CPU thread running being used at 100%. I
> cannot kill the process, and rebooting is blocked by btrfs.
> It is a copy of the bug https://bugzilla.kernel.org/show_bug.cgi?id=215498
> 
> Rebooting to linux 5.15 shows no issue. I have no issue to run a defrag on
> bigger files (I filter out files smaller than 3.9KB).
> 
> I had a conversation on #btrfs on IRC, so here's what we debugged:
> 
> I can replicate the issue by copying a file impacted by this bug, by using
> `cp --reflink=never`. I attached one of the impacted files to this bug,
> named README.md.
> 
> Someone told me that it could be a bug due to the inline extent. So we tried
> to check that.
> 
> filefrag shows that the file Readme.md is 1 inline extent. I tried to create
> a new file with random text, of 18 bytes (slightly bigger than the other
> file), that is also 1 inline extent. This file doesn't trigger the bug and
> has no issue to be defragmented.
> 
> I tried to mount my system with `max_inline=0`, created a copy of README.md.
> `filefrag` shows me that the new file is now 1 extent, not inline. This new
> file also triggers the bug, so it doesn't seem to be due to the inline
> extent.
> 
> Someone asked me to provide the output of a perf top when the defrag is
> stuck:
> 
>     28.70%  [kernel]          [k] generic_bin_search
>     14.90%  [kernel]          [k] free_extent_buffer
>     13.17%  [kernel]          [k] btrfs_search_slot
>     12.63%  [kernel]          [k] btrfs_root_node
>      8.33%  [kernel]          [k] btrfs_get_64
>      3.88%  [kernel]          [k] __down_read_common.llvm
>      3.00%  [kernel]          [k] up_read
>      2.63%  [kernel]          [k] read_block_for_search
>      2.40%  [kernel]          [k] read_extent_buffer
>      1.38%  [kernel]          [k] memset_erms
>      1.11%  [kernel]          [k] find_extent_buffer
>      0.69%  [kernel]          [k] kmem_cache_free
>      0.69%  [kernel]          [k] memcpy_erms
>      0.57%  [kernel]          [k] kmem_cache_alloc
>      0.45%  [kernel]          [k] radix_tree_lookup
> 
> I can reproduce the bug on 2 different machines, running 2 different linux
> distributions (Arch and Gentoo) with 2 different kernel configs.
> This kernel is compiled with clang, the other with GCC.
> 
> Kernel version: 5.16.0
> Mount options:
>     Machine 1:
> rw,noatime,compress-force=zstd:2,ssd,discard=async,space_cache=v2,autodefrag
>     Machine 2: rw,noatime,compress-force=zstd:3,nossd,space_cache=v2
> 
> When the error happens, no message is shown in dmesg.

This is very likely the same issue as reported at this thread:

https://lore.kernel.org/linux-btrfs/YeVawBBE3r6hVhgs@debian9.Home/T/#ma1c8a9848c9b7e4edb471f7be184599d38e288bb

Are you able to test the patch posted there?

Thanks.

> 
> Thanks,
> Anthony Ruhier
> 

>  




