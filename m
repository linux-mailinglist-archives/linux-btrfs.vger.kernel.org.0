Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D88C45AD77
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 21:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhKWUmY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 15:42:24 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36046 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhKWUmW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 15:42:22 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 836231FD65;
        Tue, 23 Nov 2021 20:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637699953;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VtL6xcbIdGrr4/jQ/6ibye6jhHk1QYcGtT0VmUUtRMk=;
        b=v996ZhNVxI+4GWDdGXnz5uF54frGUCkIq0oMRhGvhT//FmRqaXO8RpXLzaiVOAWOq7FAoV
        jb4OlIXm08ib+rwc/yI/HLK/7aE6ET+bOojEwJJ+36EUuPk1YzVlrgOSJD8XS4bcU6paS/
        M/hSH/jQJFMGC8D+oeBIKYR378Ndfq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637699953;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VtL6xcbIdGrr4/jQ/6ibye6jhHk1QYcGtT0VmUUtRMk=;
        b=L93mD8l3Cq3ZNpjt0h8o58c/c598vxdPh+HcPp8rLHt6XDgSGC1IMcSjceugI4royZst77
        MjbKrJKac4/2wABw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7EBEDA3B87;
        Tue, 23 Nov 2021 20:39:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 10B55DA735; Tue, 23 Nov 2021 21:39:05 +0100 (CET)
Date:   Tue, 23 Nov 2021 21:39:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Misc freespace cache cleanups
Message-ID: <20211123203905.GS28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211123124422.5830-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123124422.5830-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 23, 2021 at 02:44:18PM +0200, Nikolay Borisov wrote:
> Here's an assortment of freespace cache cleanups. 2 patches to consolidated some 
> functions and 2 other to simplify/clarify arguments of called functions. This 
> all results in a nice reduction of lines of code as well as code size: 
> 
> $./scripts/bloat-o-meter fs/btrfs/free-space-cache.o free-space-cache.patched
> add/remove: 0/0 grow/shrink: 0/8 up/down: 0/-549 (-549)
> Function                                     old     new   delta
> __btrfs_add_free_space                      1124    1123      -1
> btrfs_find_space_for_alloc                  1042    1039      -3
> btrfs_remove_free_space                      648     644      -4
> do_trimming                                  550     530     -20
> btrfs_add_free_space                          75      55     -20
> btrfs_add_free_space_async_trimmed            79      57     -22
> try_merge_free_space                         602     505     -97
> steal_from_bitmap                           1522    1140    -382
> Total: Before=29299, After=28750, chg -1.87%
> 
> 
> Nikolay Borisov (4):
>   btrfs: consolidate bitmap_clear_bits/__bitmap_clear_bits
>   btrfs: consolidate unlink_free_space/__unlink_free_space functions
>   btrfs: make __btrfs_add_free_space take just block group reference
>   btrfs: change name and type of private member of btrfs_free_space_ctl

Added to misc-next, thanks.
