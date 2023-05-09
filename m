Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4416FD296
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 00:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbjEIWUp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 18:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbjEIWUl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 18:20:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EB493;
        Tue,  9 May 2023 15:20:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 79A8521B2D;
        Tue,  9 May 2023 22:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683670838;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=80L/Azr9a4wuTEfafdhWkl5MgE7v/mjgawwz+h+Ju/M=;
        b=wxOdYK8Mcn41ku4Wc7WPHaKx9JjJz5bsMzmZR22tdos0kYMhgi0sHDAKrRPqQZRlLBUXq8
        pCyqvViRlBGcDzc7PIfVy2a3qh+euPfXJRnoEUq93qb4cn4Tj83/ahIZ3TFk2Ax0KzGzJ1
        v7Kxxfg2CiMjWH5Tt/4TKvRShuBfGn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683670838;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=80L/Azr9a4wuTEfafdhWkl5MgE7v/mjgawwz+h+Ju/M=;
        b=ouBi0nc9E4cW1yP50MT3u6vigQK9EOLWRWD+vuRkgnKo5deJmAtnqOVrQhWSP6ecQthDZ3
        NUxkqUq6qlHE7EAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 417ED13581;
        Tue,  9 May 2023 22:20:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wss+DzbHWmRRcAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 09 May 2023 22:20:38 +0000
Date:   Wed, 10 May 2023 00:14:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, git@vladimir.panteleev.md,
        Filipe Manana <fdmanana@suse.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: fix backref walking not returning all inode
 refs
Message-ID: <20230509221439.GG32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e58fb16de072382873edcc02c74366cbcb202499.1683632777.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e58fb16de072382873edcc02c74366cbcb202499.1683632777.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 09, 2023 at 12:50:02PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When using the logical to ino ioctl v2, if the flag to ignore offsets of
> file extent items (BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET) is given, the
> backref walking code ends up not returning references for all file offsets
> of an inode that point to the given logical bytenr. This happens since
> kernel 6.2, commit 6ce6ba534418 ("btrfs: use a single argument for extent
> offset in backref walking functions") because:
> 
> 1) It mistakenly skipped the search for file extent items in a leaf that
>    point to the target extent if that flag is given. Instead it should
>    only skip the filtering done by check_extent_in_eb() - that is, it
>    should not avoid the calls to that function (or find_extent_in_eb(),
>    which uses it).
> 
> 2) It was also not building a list of inode extent elements (struct
>    extent_inode_elem) if we have multiple inode references for an extent
>    when the ignore offset flag is given to the logical to ino ioctl - it
>    would leave a single element, only the last one that was found.
> 
> These stem from the confusing old interface for backref walking functions
> where we had an extent item offset argument that was a pointer to a u64
> and another boolean argument that indicated if the offset should be
> ignored, but the pointer could be NULL. That NULL case is used by
> relocation, qgroup extent accounting and fiemap, simply to avoid building
> the inode extent list for each reference, as it's not necessary for those
> use cases and therefore avoids memory allocations and some computations.
> 
> Fix this by adding a boolean argument to the backref walk context
> structure to indicate that the inode extent list should not be built,
> make relocation set that argument to true and fix the backref walking
> logic to skip the calls to check_extent_in_eb() and find_extent_in_eb()
> only if this new argument is true, instead of 'ignore_extent_item_pos'
> being true.
> 
> A test case for fstests will be added soon, to provide cover not only
> for these cases but to the logical to ino ioctl in general as well, as
> currently we do not have a test case for it.
> 
> Fixes: 6ce6ba534418 ("btrfs: use a single argument for extent offset in backref walking functions")
> Reported-by: Vladimir Panteleev <git@vladimir.panteleev.md>
> Link: https://lore.kernel.org/linux-btrfs/CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com/
> Tested-by: Vladimir Panteleev <git@vladimir.panteleev.md>
> CC: stable@vger.kernel.org # 6.2+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Remove wrong check for a non-zero extent item offset.
>     Apply the same logic at find_parent_nodes(), that is, search for file
>     extent items on a leaf if the ignore flag is given - the filtering
>     will be done later at check_extent_in_eb(). Spotted by Vladimir Panteleev
>     in the thread mentioned above.
> 
> V3: Also fix the condition to decide if we should add an inode element to the
>     list of inode elements built before. Also rework the fix based on that
>     missing part.

Added to misc-next. As this is a user visible bug I'll submit it in
another batch for rc2, but there will be a few days before that in case
you'd need another update. Thanks.
