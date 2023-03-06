Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862946ACCF0
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Mar 2023 19:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCFSra (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Mar 2023 13:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCFSr3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Mar 2023 13:47:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0C26BC17
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Mar 2023 10:47:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 47D411FDE4;
        Mon,  6 Mar 2023 18:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678128440;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8I+lU6n/oK8p0i8qSJe+VsxKvEcakDntBHl9pftuYgY=;
        b=zxYDQBSgMQLqx3mPSwVTQZUv2IowndxZ+oASo0sFNnnW+7Yoh0rHfFIdJ74fz5hlc145A7
        mF0Y+3Jqdy/ZCKpBMW9h+iSF1HDL7SKAR8vYm4KpQSQnbjW4cnYdwsuEGmKscsXwLLbeiD
        2DJkS0zBfGh1aKHYoW1glRnSvkXSHlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678128440;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8I+lU6n/oK8p0i8qSJe+VsxKvEcakDntBHl9pftuYgY=;
        b=qK56+RMfG2CbRsBxzupK3+XeOBxY/fYg8MzGj8FLcycVM6O7Hm/Mopy1UgCSPNQVtglRPY
        ZTniMY1fNHO2IqDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21F6613A66;
        Mon,  6 Mar 2023 18:47:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xy5NBzg1BmQ/HQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 06 Mar 2023 18:47:20 +0000
Date:   Mon, 6 Mar 2023 19:41:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix block group item corruption after inserting
 new block group
Message-ID: <20230306184117.GD10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <257397e78b93bcb888daec01c1e02be87cd4dee7.1678097398.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <257397e78b93bcb888daec01c1e02be87cd4dee7.1678097398.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 06, 2023 at 10:13:34AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We can often end up inserting a block group item, for a new block group,
> with a wrong value for the used bytes field.
> 
> This happens if for the new allocated block group, in the same transaction
> that created the block group, we have tasks allocating extents from it as
> well as tasks removing extents from it.
> 
> For example:
> 
> 1) Task A creates a metadata block group X;
> 
> 2) Two extents are allocated from block group X, so its "used" field is
>    updated to 32K, and its "commit_used" field remains as 0;
> 
> 3) Transaction commit starts, by some task B, and it enters
>    btrfs_start_dirty_block_groups(). There it tries to update the block
>    group item for block group X, which currently has its "used" field with
>    a value of 32K. But that fails since the block group item was not yet
>    inserted, and so on failure update_block_group_item() sets the
>    "commit_used" field of the block group back to 0;
> 
> 4) The block group item is inserted by task A, when for example
>    btrfs_create_pending_block_groups() is called when releasing its
>    transaction handle. This results in insert_block_group_item() inserting
>    the block group item in the extent tree (or block group tree), with a
>    "used" field having a value of 32K, but without updating the
>    "commit_used" field in the block group, which remains with value of 0;
> 
> 5) The two extents are freed from block X, so its "used" field changes
>    from 32K to 0;
> 
> 6) The transaction commit by task B continues, it enters
>    btrfs_write_dirty_block_groups() which calls update_block_group_item()
>    for block group X, and there it decides to skip the block group item
>    update, because "used" has a value of 0 and "commit_used" has a value
>    of 0 too.
> 
>    As a result, we end up with a block item having a 32K "used" field but
>    no extents allocated from it.
> 
> When this issue happens, a btrfs check reports an error like this:
> 
>    [1/7] checking root items
>    [2/7] checking extents
>    block group [1104150528 1073741824] used 39796736 but extent items used 0
>    ERROR: errors found in extent allocation tree or chunk allocation
>    (...)
> 
> Fix this by making insert_block_group_item() update the block group's
> "commit_used" field.
> 
> Fixes: 7248e0cebbef ("btrfs: skip update of block group item if used bytes are the same")
> CC: stable@vger.kernel.org # 6.2+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
