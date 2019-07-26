Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5771E76B58
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 16:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfGZOSu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 10:18:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:41402 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727358AbfGZOSu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 10:18:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44458AE82;
        Fri, 26 Jul 2019 14:18:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C9770DA811; Fri, 26 Jul 2019 16:19:23 +0200 (CEST)
Date:   Fri, 26 Jul 2019 16:19:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix race leading to fs corruption after
 transaction abortion
Message-ID: <20190726141922.GC2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190725102704.11404-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725102704.11404-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 25, 2019 at 11:27:04AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When one transaction is finishing its commit, it is possible for another
> transaction to start and enter its initial commit phase as well. If the
> first ends up getting aborted, we have a small time window where the second
> transaction commit does not notice that the previous transaction aborted
> and ends up committing, writing a superblock that points to btrees that
> reference extent buffers (nodes and leafs) that were not persisted to disk.
> The consequence is that after mounting the filesystem again, we will be
> unable to load some btree nodes/leafs, either because the content on disk
> is either garbage (or just zeroes) or corresponds to the old content of a
> previouly COWed or deleted node/leaf, resulting in the well known error
> messages "parent transid verify failed on ...".
> The following sequence diagram illustrates how this can happen.
> 
>         CPU 1                                           CPU 2
> 
>  <at transaction N>
> 
>  btrfs_commit_transaction()
>    (...)
>    --> sets transaction state to
>        TRANS_STATE_UNBLOCKED
>    --> sets fs_info->running_transaction
>        to NULL
> 
>                                                     (...)
>                                                     btrfs_start_transaction()
>                                                       start_transaction()
>                                                         wait_current_trans()
>                                                           --> returns immediately
>                                                               because
>                                                               fs_info->running_transaction
>                                                               is NULL
>                                                         join_transaction()
>                                                           --> creates transaction N + 1
>                                                           --> sets
>                                                               fs_info->running_transaction
>                                                               to transaction N + 1
>                                                           --> adds transaction N + 1 to
>                                                               the fs_info->trans_list list
>                                                         --> returns transaction handle
>                                                             pointing to the new
>                                                             transaction N + 1
>                                                     (...)
> 
>                                                     btrfs_sync_file()
>                                                       btrfs_start_transaction()
>                                                         --> returns handle to
>                                                             transaction N + 1
>                                                       (...)
> 
>    btrfs_write_and_wait_transaction()
>      --> writeback of some extent
>          buffer fails, returns an
> 	 error
>    btrfs_handle_fs_error()
>      --> sets BTRFS_FS_STATE_ERROR in
>          fs_info->fs_state
>    --> jumps to label "scrub_continue"
>    cleanup_transaction()
>      btrfs_abort_transaction(N)
>        --> sets BTRFS_FS_STATE_TRANS_ABORTED
>            flag in fs_info->fs_state
>        --> sets aborted field in the
>            transaction and transaction
> 	   handle structures, for
>            transaction N only
>      --> removes transaction from the
>          list fs_info->trans_list
>                                                       btrfs_commit_transaction(N + 1)
>                                                         --> transaction N + 1 was not
> 							    aborted, so it proceeds
>                                                         (...)
>                                                         --> sets the transaction's state
>                                                             to TRANS_STATE_COMMIT_START
>                                                         --> does not find the previous
>                                                             transaction (N) in the
>                                                             fs_info->trans_list, so it
>                                                             doesn't know that transaction
>                                                             was aborted, and the commit
>                                                             of transaction N + 1 proceeds
>                                                         (...)
>                                                         --> sets transaction N + 1 state
>                                                             to TRANS_STATE_UNBLOCKED
>                                                         btrfs_write_and_wait_transaction()
>                                                           --> succeeds writing all extent
>                                                               buffers created in the
>                                                               transaction N + 1
>                                                         write_all_supers()
>                                                            --> succeeds
>                                                            --> we now have a superblock on
>                                                                disk that points to trees
>                                                                that refer to at least one
>                                                                extent buffer that was
>                                                                never persisted
> 
> So fix this by updating the transaction commit path to check if the flag
> BTRFS_FS_STATE_TRANS_ABORTED is set on fs_info->fs_state if after setting
> the transaction to the TRANS_STATE_COMMIT_START we do not find any previous
> transaction in the fs_info->trans_list. If the flag is set, just fail the
> transaction commit with -EROFS, as we do in other places. The exact error
> code for the previous transaction abort was already logged and reported.
> 
> Fixes: 49b25e0540904b ("btrfs: enhance transaction abort infrastructure")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

Queued for 5.3, thanks.
