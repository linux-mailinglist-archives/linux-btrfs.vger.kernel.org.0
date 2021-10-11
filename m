Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227F0429247
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 16:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242650AbhJKOnn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 10:43:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55494 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244272AbhJKOmp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 10:42:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3936621DA0;
        Mon, 11 Oct 2021 14:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633963234;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wp1AuD1Yof7R4YLHe97neYhto4bQncc5OtzHVBPhRMc=;
        b=jJhez8eChhOhVJConyW66WoaRF7utJGt/YOY+kbvu5gbj2z3FL27TqOXozdhe5FCZmZQMb
        MGpwgciytqBxBqv+WC3HmLX3fDJ2henvK8BloX0ofZSsiE4FO5mMj2Y8sMsDHoyZuSYEdZ
        VSb1H8PaFK89d6yiYWRONR63rNK+7SM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633963234;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wp1AuD1Yof7R4YLHe97neYhto4bQncc5OtzHVBPhRMc=;
        b=oGfhZ9MoTX+Jq2f5nPlMwR5vCp7OusEIEgZDVb9vTQDr0jxfdAnpVTyGUsc7JNJqBdWP7e
        dbjTpUzMkG5N5KBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 32A8CA3B90;
        Mon, 11 Oct 2021 14:40:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 347F9DA781; Mon, 11 Oct 2021 16:40:11 +0200 (CEST)
Date:   Mon, 11 Oct 2021 16:40:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs-progs: mkfs: make sure we can clean up all
 temporary chunks
Message-ID: <20211011144010.GM9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211011120650.179017-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011120650.179017-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 11, 2021 at 08:06:47PM +0800, Qu Wenruo wrote:
> There is a bug report that with certain mkfs options, mkfs.btrfs may
> fail to cleanup some temporary chunks, leading to "btrfs filesystem df"
> warning about multiple profiles:
> 
>   WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
>   WARNING:   Metadata: single, raid1 
> 
> The easiest way to reproduce is "mkfs.btrfs -f -R free-space-tree -m dup
> -d dup".
> 
> It turns out that, the old _recow_root() can not handle tree levels > 0,
> while with newer free space tree creation timing, the free space tree
> can reach level 1 or higher.
> 
> To fix the problem, Patch 2 will do the proper full tree re-CoW, with
> extra transaction commitment to make sure all free space tree get
> re-CoWed.
> 
> The 3rd patch will do the extra verification during mkfs-tests.
> 
> The first patch is just to fix a confusing parameter which also caused
> u64 -> int width reduction and can be problematic in the future.
> 
> Changelog:
> v2:
> - Remove a duplicated recow_roots() call in create_raid_groups()
>   This call makes no difference as we will later commit transaction
>   and manually call recow_roots() again.
>   Remove such duplicated call to save some time.
> 
> - Replace the btrfs_next_sibling_tree_block() with btrfs_next_leaf()
>   Since we're always handling leaves, there is no need for
>   btrfs_next_sibling_tree_block()
> 
> - Work around a kernel bug which may cause false alerts
>   For single device RAID0, btrfs kernel is not respecting it, and will
>   allocate new chunks using SINGLE instead.
>   This can be very noisy and cause false alerts, and not always
>   reproducible, depending on how fast kernel creates new chunks.
> 
>   Work around it by mounting the RO before calling "btrfs fi df".
> 
>   The kernel bug needs to be investigated and fixed.
> 
> 
> Qu Wenruo (3):
>   btrfs-progs: rename @data parameter to @profile in extent allocation
>     path
>   btrfs-progs: mkfs: recow all tree blocks properly
>   btrfs-progs: mfks-tests: make sure mkfs.btrfs cleans up temporary
>     chunks

I've replaced patches 2 and 3, thanks. No need to resend with the fixes
I mentioned, that's for future patches.
