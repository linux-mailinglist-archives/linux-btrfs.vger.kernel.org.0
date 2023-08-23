Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE36785EEF
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 19:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbjHWRsV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 13:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbjHWRsT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 13:48:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052A210CC
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 10:48:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B93B3221A1;
        Wed, 23 Aug 2023 17:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692812894;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FwKe9yR4YogipIeip8jgoJ4hoS6kA0C6X4RXFzZb3iE=;
        b=So+lpP12Mv1mhNa13sP1WlV1VkNDDS7nOY9DqBS2bdCipQa+VsIe8wLB+yOozbjiI3KMxi
        6e25+f5Oj3ipcph6DeZyQSY5mSGIQc+nTRiby/svv2kGTk7DHt2GSLoTR9kQf20W0uYkY3
        GBvmCCA2zc6qNCY5O4LKTMtKMNt7yv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692812894;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FwKe9yR4YogipIeip8jgoJ4hoS6kA0C6X4RXFzZb3iE=;
        b=P0lKMAQ1fvgFDasvxPHCoWjQSIjmuGIif5MES1hHabX+jcj3d46ZNYRWH0GLNEm4TfKbJB
        k8SmRTvko8pcgjBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 928C313458;
        Wed, 23 Aug 2023 17:48:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3Q/UIl5G5mRMZwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 23 Aug 2023 17:48:14 +0000
Date:   Wed, 23 Aug 2023 19:41:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/38] btrfs-progs: sync ctree.c into btrfs-progs
Message-ID: <20230823174142.GJ2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
>   btrfs-progs: sync ctree.c from kernel

I've skimmed the series, there maybe some minor things to fix up so I'll
apply it soon. The last patch is however too big, I get that you did not
want to split it further but I think it's still better to do it in
smaller batches grouped by functionality or a helper. Also there's the
copyright notice change, this hasn't been decided what to do with that
in userspace. I'll take another look.
