Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1496F5582
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 12:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjECKAt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 06:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjECKAr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 06:00:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD441A7
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 03:00:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3487E22591;
        Wed,  3 May 2023 10:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683108045;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DPofwE9/o4fUq9wDCD4LwbI36BLlJMz5bt/fs2b1Oww=;
        b=cXJOgZzRaf2MxyTkQgIehj1E6p3ORE26l2jXwz+ttDdF1XDqRw0oNEanp2JVvH+qeZZH9K
        yFkC+mI9MrOxOsnn6nkWFRMp6FOIqy7K2aPXyW0t1hI3Mg399LPx4d94eNxwo3GYGoVzDc
        Oep6mK4NI8HeyiKbWM1mDUh4VZ9RFdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683108045;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DPofwE9/o4fUq9wDCD4LwbI36BLlJMz5bt/fs2b1Oww=;
        b=jcMOXDX8Zjd9/W4zh4EGFR8omr9ZdQwwiksZi4ZiUJpRAjq+frhkgP9etfto2Y37LrAOqP
        fgiN6CcY408H7fBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A10F1331F;
        Wed,  3 May 2023 10:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4YGDBc0wUmRGJwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 03 May 2023 10:00:45 +0000
Date:   Wed, 3 May 2023 11:54:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/10] btrfs-progs: prep work for syncing ctree.c
Message-ID: <20230503095449.GU8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1681939107.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681939107.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 19, 2023 at 05:20:40PM -0400, Josef Bacik wrote:
> Hello,
> 
> These patches update a lot of the different ctree.c related helpers that have
> diverged from the kernel in order to make ite easier syncing ctree.c directly.
> This also syncs locking.[ch], but this is to just stub out the locking.  This
> will make it easier to sync ctree.c as well since there's locking in the kernel
> that didn't exist when we had this in btrfs-progs.
> 
> This series depends on
> 
> 	btrfs-progs: prep work for syncing files into kernel-shared
> 	btrfs-progs: sync basic code from the kernel
> 
> Thanks,
> 
> Josef
> 
> Josef Bacik (10):
>   btrfs-progs: const-ify the extent buffer helpers
>   btrfs-progs: bring root->state into btrfs-progs
>   btrfs-progs: rename btrfs_alloc_free_block to btrfs_alloc_tree_block
>   btrfs-progs: sync locking.h and stub out all the helpers
>   btrfs-progs: add btrfs_locking_nest to btrfs_alloc_tree_block
>   btrfs-progs: add some missing extent buffer helpers
>   btrfs-progs: rename btrfs_set_block_flags ->
>     btrfs_set_disk_extent_flags
>   btrfs-progs: cleanup args for btrfs_set_disk_extent_flags
>   btrfs-progs: rename clear_extent_buffer_dirty =>
>     btrfs_clear_buffer_dirty
>   btrfs-progs: make __btrfs_cow_block static

Added to devel. However, this fails build on Centos7 image with warnings
like

    [CC]     kernel-shared/backref.o
In file included from ./kernel-shared/ctree.h:30:0,
                 from kernel-shared/volumes.h:23,
                 from btrfs.c:24:
./kernel-shared/accessors.h: In function 'btrfs_device_total_bytes':
./kernel-shared/accessors.h:118:58: error: expected ',' before ')' token
         sizeof(((struct btrfs_dev_item *)0))->total_bytes);
                                                          ^
./kernel-shared/accessors.h: In function 'btrfs_set_device_total_bytes':
./kernel-shared/accessors.h:132:58: error: expected ',' before ')' token
         sizeof(((struct btrfs_dev_item *)0))->total_bytes);
                                                          ^

The code is same as in kernel e.g.

 114 static inline u64 btrfs_device_total_bytes(const struct extent_buffer *eb,
 115                                            struct btrfs_dev_item *s)
 116 {
 117         static_assert(sizeof(u64) ==
 118                       sizeof(((struct btrfs_dev_item *)0))->total_bytes);
 119         return btrfs_get_64(eb, s, offsetof(struct btrfs_dev_item,
 120                                             total_bytes));
 121 }
