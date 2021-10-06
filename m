Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10456423D7F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 14:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbhJFMQI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 08:16:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56054 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238105AbhJFMQI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 08:16:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 784C51FEB0;
        Wed,  6 Oct 2021 12:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633522455;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s5Y/zBPnZTO09FaWXmZyBQzjWcBigp4xpQ/L0SBc1m0=;
        b=HKe5NM6WzxprDrAgLLiJqnVdUyxEOuwJ3WGDIYSvD9Hi+42auseUJ+4h2D9s8R+iJHaQjc
        5kCoPv+hDbwbJk1lB6YzLyMxDuz+B97ZgJGjUL07gOr/1h7k336FF3XNSgps8t5vOfXOjU
        yxv3/cKZYHUoBsxv87mhP/G4BThsyY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633522455;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s5Y/zBPnZTO09FaWXmZyBQzjWcBigp4xpQ/L0SBc1m0=;
        b=LXsYE0tsb9ZNsjx9z14DBPzBHEgcs0tAnkIrXSV/ir/YoXu8rRSMnhEfmH9i05Zi0yM0Ve
        2Q0VZczYwJVTjIBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 703DDA3B83;
        Wed,  6 Oct 2021 12:14:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 351ACDA7F3; Wed,  6 Oct 2021 14:13:55 +0200 (CEST)
Date:   Wed, 6 Oct 2021 14:13:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     wqu@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [bug report] btrfs: refactor submit_compressed_extents()
Message-ID: <20211006121354.GL9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dan Carpenter <dan.carpenter@oracle.com>,
        wqu@suse.com, linux-btrfs@vger.kernel.org
References: <20211006085424.GA11818@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006085424.GA11818@kili>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 06, 2021 at 11:54:24AM +0300, Dan Carpenter wrote:
> Hello Qu Wenruo,
> 
> The patch 36976f50745d: "btrfs: refactor submit_compressed_extents()"
> from Sep 27, 2021, leads to the following Smatch static checker
> warning:
> 
> 	fs/btrfs/inode.c:1066 submit_compressed_extents()
> 	error: dereferencing freed memory 'async_extent'
> 
> fs/btrfs/inode.c
>     1050 static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
>     1051 {
>     1052         struct btrfs_inode *inode = BTRFS_I(async_chunk->inode);
>     1053         struct btrfs_fs_info *fs_info = inode->root->fs_info;
>     1054         struct async_extent *async_extent;
>     1055         u64 alloc_hint = 0;
>     1056         int ret = 0;
>     1057 
>     1058         while (!list_empty(&async_chunk->extents)) {
>     1059                 async_extent = list_entry(async_chunk->extents.next,
>     1060                                           struct async_extent, list);
>     1061                 list_del(&async_extent->list);
>     1062 
>     1063                 ret = submit_one_async_extent(inode, async_chunk, async_extent,
>                                                                            ^^^^^^^^^^^^
> Freed here.
> 
>     1064                                               &alloc_hint);
>     1065                 /* Just for developer */
> --> 1066                 btrfs_debug(fs_info,
>     1067 "async extent submission failed root=%lld inode=%llu start=%llu len=%llu ret=%d",
>     1068                             inode->root->root_key.objectid,
>     1069                             btrfs_ino(inode), async_extent->start,
>                                                        ^^^^^^^^^^^^^^^^^^^
> 
>     1070                             async_extent->ram_size, ret);
>                                      ^^^^^^^^^^^^^^^^^^^^^^
> Use after free.

Thanks for the report, fix on the way.
