Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE56178909B
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 23:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjHYVmf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 17:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjHYVmI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 17:42:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEB426AF
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 14:42:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 14E722212A;
        Fri, 25 Aug 2023 21:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692999722;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RP6DG9XHkiu3A5bMNzgvKKm7HF4aFTgmdIuO0VvGGEc=;
        b=LKbs5Ysd6GJngBS/cN+8+r0tr1CPXmWHzURpXnbGR9PVctsxANiUe+6T+9qGKmnyqPnktC
        Vq+eJ2Hl1CME8cLQhuqMqIIEWvRd6XzzLoggL+ROWFCbHO8J/0byJAE9+nGt1MSLJDk25U
        2FTRW8NN9vg0rJ+oEuT4JoXLSs48BNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692999722;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RP6DG9XHkiu3A5bMNzgvKKm7HF4aFTgmdIuO0VvGGEc=;
        b=R2oflmSS3Rksc9Irrw/D7np6/4Qa84rQPpe6DoqJNDwx+uqacEBvtTcGu8qVDEZIbB1bCh
        0dPLqxCvksvnHwCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5C711340A;
        Fri, 25 Aug 2023 21:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q7PUMikg6WR+SQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 25 Aug 2023 21:42:01 +0000
Date:   Fri, 25 Aug 2023 23:35:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/38] btrfs-progs: sync ctree.c into btrfs-progs
Message-ID: <20230825213527.GA14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 23, 2023 at 10:32:26AM -0400, Josef Bacik wrote:
> Hello,
> 
> I started back up my extent tree v2 work and noticed not all my ctree.c sync
> patches made it in the last submission as I missed some comments.
> 
> This patchset is much larger than what was left, as I broke up the changes more
> discreetly.  In my original submission I had ignored some of the tree wide
> changes in favor of expediency, and had modified ctree.c more to match what we
> had in btrfs-progs.
> 
> This time I've updated everything that was different in ctree.c in the rest of
> btrfs-progs to make the actual sync'ing of ctree.c more straightforward.  I had
> to modify a few things in ctree.c, but they are very small and specific, no more
> updates of any of the global functions we depend on.
> 
> The downside is this patchset is massive.  The upside is the patches are small
> and self contained, with the obvious exception of the actual ctree.c sync.
> 
> This also will make subsequent sync'ing of other source files much easier, as
> I've changed a good deal of the very common helpers to match what exists in the
> kernel.
> 
> This passes all the tests.  There are a few behavior changes, but for the most
> part it's just updating helpers to match kernel definitions and moving code
> around.  Thanks,
> 
> Josef
> 
> Josef Bacik (38):
>   btrfs-progs: stop using add_root_to_dirty_list in check
>   btrfs-progs: remove useless add_root_to_dirty_list call in mkfs
>   btrfs-progs: remove add_root_to_dirty_list call when creating free
>     space tree
>   btrfs-progs: make add_root_to_dirty_list static and unexport it
>   btrfs-progs: pass btrfs_trans_handle through btrfs_clear_buffer_dirty
>   btrfs-progs: update read_node_slot to match the kernel definition
>   btrfs-progs: update btrfs_bin_search to match the kernel definition
>   btrfs-progs: update btrfs_set_item_key_safe to match kernel definition
>   btrfs-progs: update btrfs_print_leaf to match the kernel definition
>   btrfs-progs: update btrfs_truncate_item to match the kernel definition
>   btrfs-progs: update btrfs_extend_item to match the kernel definition
>   btrfs-progs: sync memcpy_extent_buffer from the kernel
>   btrfs-progs: drop btrfs_init_path
>   btrfs-progs: move btrfs_set_item_key_unsafe to check/
>   btrfs-progs: move btrfs_record_file_extent and code into a new file
>   btrfs-progs: make a local copy of btrfs_next_sibling_block in
>     print-tree.c
>   btrfs-progs: don't set the ->commit_root in btrfs_create_tree
>   btrfs-progs: remove btrfs_create_root
>   btrfs-progs: move btrfs_uuid_tree_add into mkfs/main.c
>   btrfs-progs: make btrfs_del_ptr a void
>   btrfs-progs: replace blocksize with parent argument for
>     btrfs_alloc_tree_block
>   btrfs-progs: use path->search_for_extension
>   btrfs-progs: init new tree blocks in btrfs_alloc_tree_block
>   btrfs-progs: add dwarves to the package list for ci
>   btrfs-progs: add kerncompat helpers for ctree.c sync
>   btrfs-progs: add trans_lock to fs_info
>   btrfs-progs: add commit_root_sem to btrfs_fs_info
>   btrfs-progs: update btrfs_cow_block to match the in-kernel definition
>   btrfs-progs: update btrfs_insert_empty_items to match the kernel
>   btrfs-progs: update btrfs_insert_empty_item to match the kernel
>   btrfs-progs: update btrfs_del_ptr to match the kernel
>   btrfs-progs: update btrfs_insert_item to match the kernel
>   btrfs-progs: update btrfs_leaf_free_space to match the kernel
>   btrfs-progs: use btrfs_tree_parent_check for btrfs_read_extent_buffer
>   btrfs-progs: update read_tree_block to take a btrfs_parent_tree_check
>   btrfs-progs: inline btrfs_name_hash and btrfs_extref_hash
>   btrfs-progs: update btrfs_split_item to match the in-kernel definition

1-37 applied, with some minor fixups, thanks. This change granularity is
good.
