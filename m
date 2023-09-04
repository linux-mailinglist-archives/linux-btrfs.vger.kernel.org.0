Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABF4791F0C
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Sep 2023 23:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbjIDVid (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Sep 2023 17:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjIDVic (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Sep 2023 17:38:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346DB1B4
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Sep 2023 14:38:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A9DA8211CE;
        Mon,  4 Sep 2023 21:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693863506;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I4C1lVM05As/R49CYYvwaW/bkIJckmbw/0qtm3zDtwY=;
        b=D47BoLHWYt7+376sFc1HxDyWybXlhRxLWb5qsoHhrXrBRr/Fo6MorcvlJJkGMLU2Qxvuxz
        NqSvsPmL9m1T/+FfxSbJpsAZzZr4rEgbT9Lg6xUaxui1zeN0lfi+4espc3UVkOBFb4+Eg9
        J8N5klEBzDjvqrjyy6NHZRgxMwGRzT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693863506;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I4C1lVM05As/R49CYYvwaW/bkIJckmbw/0qtm3zDtwY=;
        b=8gWsK/iATRn+zSfkdYVaai1aU+dQZwmL7PfdobDPUgbVq/mFeyHHVmrAC+usYRT2C3Tbnm
        EUxGGSN81ItOl4Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FDAA13425;
        Mon,  4 Sep 2023 21:38:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q9VbHlJO9mQ+dQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 04 Sep 2023 21:38:26 +0000
Date:   Mon, 4 Sep 2023 23:31:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix race between finishing block group creation
 and its item update
Message-ID: <20230904213147.GN14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f5eda1ba8b7a776d3407d30939078b63d02aaff4.1693825574.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5eda1ba8b7a776d3407d30939078b63d02aaff4.1693825574.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 04, 2023 at 12:10:31PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Commit 675dfe1223a6 ("btrfs: fix block group item corruption after
> inserting new block group") fixed one race that resulted in not persisting
> a block group's item when its "used" bytes field decreases to zero.
> However there's another race that can happen in a much shorter time window
> that results in the same problem. The following sequence of steps explains
> how it can happen:
> 
> 1) Task A creates a metadata block group X, its "used" and "commit_used"
>    fields are initialized to 0;
> 
> 2) Two extents are allocated from block group X, so its "used" field is
>    updated to 32K, and its "commit_used" field remains as 0;
> 
> 3) Transaction commit starts, by some task B, and it enters
>    btrfs_start_dirty_block_groups(). There it tries to update the block
>    group item for block group X, which currently has its "used" field with
>    a value of 32K and its "commited_used" field with a value of 0. However
>    that fails since the block group item was not yet inserted, so at
>    update_block_group_item(), the btrfs_search_slot() call returns 1, and
>    then we set 'ret' to -ENOENT. Before jumping to the label 'fail'...
> 
> 4) The block group item is inserted by task A, when for example
>    btrfs_create_pending_block_groups() is called when releasing its
>    transaction handle. This results in insert_block_group_item() inserting
>    the block group item in the extent tree (or block group tree), with a
>    "used" field having a value of 32K and setting "commit_used", in struct
>    btrfs_block_group, to the same value (32K);
> 
> 5) Task B jumps to the 'fail' label and then resets the "commit_used"
>    field to 0. At btrfs_start_dirty_block_groups(), because -ENOENT was
>    returned from update_block_group_item(), we add the block group again
>    to the list of dirty block groups, so that we will try again in the
>    critical section of the transaction commit when calling
>    btrfs_write_dirty_block_groups();
> 
> 6) Later the two extents from block group X are freed, so its "used" field
>    becomes 0;
> 
> 7) If no more extents are allocated from block group X before we get into
>    btrfs_write_dirty_block_groups(), then when we call
>    update_block_group_item() again for block group X, we will not update
>    the block group item to reflect that it has 0 bytes used, because the
>    "used" and "commit_used" fields in struct btrfs_block_group have the
>    same value, a value of 0.
> 
>    As a result after committing the transaction we have an empty block
>    group with its block group item having a 32K value for its "used" field.
>    This will trigger errors from fsck ("btrfs check" command) and after
>    mounting again the fs, the cleaner kthread will not automatically delete
>    the empty block group, since its "used" field is not 0. Possibly there
>    are other issues due to this incosistency.
> 
>    When this issue happens, the error reported by fsck is like this:
> 
>      [1/7] checking root items
>      [2/7] checking extents
>      block group [1104150528 1073741824] used 39796736 but extent items used 0
>      ERROR: errors found in extent allocation tree or chunk allocation
>      (...)
> 
> So fix this by not resetting the "commit_used" field of a block group when
> we don't find the block group item at update_block_group_item().
> 
> Fixes: 7248e0cebbef ("btrfs: skip update of block group item if used bytes are the same")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
