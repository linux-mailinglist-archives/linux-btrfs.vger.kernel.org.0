Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955B6EC5CD
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2019 16:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfKAPpa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 11:45:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:59786 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726951AbfKAPpa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Nov 2019 11:45:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 72AE2AE48;
        Fri,  1 Nov 2019 15:45:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D49ADDA7AF; Fri,  1 Nov 2019 16:45:36 +0100 (CET)
Date:   Fri, 1 Nov 2019 16:45:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Meng Xu <mengxu.gatech@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: Re: potential data race on `delayed_rsv->full`
Message-ID: <20191101154536.GW3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Meng Xu <mengxu.gatech@gmail.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com
References: <CAAwBoOJDjei5Hnem155N_cJwiEkVwJYvgN-tQrwWbZQGhFU=cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAwBoOJDjei5Hnem155N_cJwiEkVwJYvgN-tQrwWbZQGhFU=cA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 15, 2019 at 02:33:11PM -0400, Meng Xu wrote:
> I am reporting a potential data race around the `delayed_rsv->full` field.

Thanks for the report.

> [thread 1] mount a btrfs image, a kernel thread of uuid_rescan will be created
> 
> btrfs_uuid_rescan_kthread
>   btrfs_end_transaction
>     __btrfs_end_transaction
>       btrfs_trans_release_metadata
>         btrfs_block_rsv_release
>           __btrfs_block_rsv_release
>             --> [READ] else if (block_rsv != global_rsv && !delayed_rsv->full)
>                                                             ^^^^^^^^^^^^^^^^^
> 
> 
> [thread 2] do a mkdir syscall on the mounted image
> 
> __do_sys_mkdir
>   do_mkdirat
>     vfs_mkdir
>       btrfs_mkdir
>         btrfs_new_inode
>           btrfs_insert_empty_items
>             btrfs_cow_block
>               __btrfs_cow_block
>                 alloc_tree_block_no_bg_flush
>                   btrfs_alloc_tree_block
>                     btrfs_add_delayed_tree_ref
>                       btrfs_update_delayed_refs_rsv
>                         --> [WRITE] delayed_rsv->full = 0;
>                                     ^^^^^^^^^^^^^^^^^^^^^
> 
> 
> I could confirm that this is a data race by manually adding and adjusting
> delays before the read and write statements although I am not very sure
> about the implication of such a data race (e.g., crashing btrfs or causing
> violations of assumptions). I would appreciate if you could help check on
> this potential bug and advise whether this is a harmful data race or it
> is intended.

The race is there, as the access is unprotected, but it does not seem to
have serious implications. The race is for space, which happens all the
time, and if the reservations cannot be satisfied there goes ENOSPC.

In this particular case I wonder if the uuid thread is important or if
this would happen with anything that calls btrfs_end_transaction.

Depending on the value of ->full, __btrfs_block_rsv_release decides
where to return the reservation, and block_rsv_release_bytes handles a
NULL pointer for block_rsv and if it's not NULL then it double checks
the full status under a lock.

So the unlocked and racy access is only advisory and in the worst case
the block reserve is found !full and becomes full in the meantime,
but properly handled.

I've CCed Josef to review the analysis.
