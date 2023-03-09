Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D611A6B2CC0
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 19:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjCISRC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 13:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCISQ5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 13:16:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7DCF31EE
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 10:16:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 08AE7222A4;
        Thu,  9 Mar 2023 18:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678385815;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wJoXhHEbUWcpf8/S0Pj2BzBNvhWdkfzT93RghFS5z+E=;
        b=DGsMR3lNVZgoHOWMlugoGAoAOzHYtLz/wAuoLoIQAYCi6vw4FBvcjqOuhsgfe4t/SNXrlp
        S/2jOEa2G+6TKH4Ukk4dwffp6U1KmeHJVErmC+RuvfYuz7o+3NQZGFXXLuoJpfIIKTptXd
        5/5DaMvNHW1NuPtdzoH2144MQovZ3YM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678385815;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wJoXhHEbUWcpf8/S0Pj2BzBNvhWdkfzT93RghFS5z+E=;
        b=9wS1PZwxmobnHlRBhD1t/9b/qAZIqKQh04TR42R/3lIF4NKfGM6dJw69RYXgnzo6sXoOvE
        f3dAirFV57UQLcBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8A0C1391B;
        Thu,  9 Mar 2023 18:16:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zBb4M5YiCmS4MgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 09 Mar 2023 18:16:54 +0000
Date:   Thu, 9 Mar 2023 19:10:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/21] Lock extents before pages
Message-ID: <20230309181050.GK10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230302222506.14955-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302222506.14955-1-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 02, 2023 at 04:24:45PM -0600, Goldwyn Rodrigues wrote:
> The main idea is that instead of handling extent locks per page, lock
> the extents before handling the pages. This will help in calling iomap
> functions from within extent locks, so all page/folio handling is
> performed by iomap code.
> 
> The patch "debug extent locking" was added to debug this code to check
> where the locks were initiated in case of deadlock. No need to add
> this patch.
> 
> Changes since v1:
>  - qgroup flush reversal, instead pass nowait=true and handle
>    qgroup flush if qgroup reservations return EDQUOT
>  - relocation - locking extents before pages
>  - async code locking fix: async code deadlocked because parallel
>    writebacks could set HAS_ASYNC_EXTENTS flag while other thread was
>    performing a sync writeback. This required re-writing the async writeback
>    path
>  - incorporated lock range checks using WARN_ON(), though I must
>    admit locking during truncate still looks ugly
>  - added readahead_begin() for locking extents before calling readahead()
>    since readahead is called with pages locked.
> 
> Goldwyn Rodrigues (21):
>   fs: readahead_begin() to call before locking folio
>   btrfs: add WARN_ON() on incorrect lock range
>   btrfs: Add start < end check in btrfs_debug_check_extent_io_range()
>   btrfs: make btrfs_qgroup_flush() non-static
>   btrfs: Lock extents before pages for buffered write()
>   btrfs: wait ordered range before locking during truncate
>   btrfs: lock extents while truncating
>   btrfs: no need to lock extent while performing invalidate_folio()
>   btrfs: lock extents before folio for read()s
>   btrfs: lock extents before pages in writepages
>   btrfs: locking extents for async writeback
>   btrfs: lock extents before pages - defrag
>   btrfs: Perform memory faults under locked extent
>   btrfs: writepage fixup lock rearrangement
>   btrfs: lock extent before pages for encoded read ioctls
>   btrfs: lock extent before pages in encoded write
>   btrfs: btree_writepages lock extents before pages
>   btrfs: check if writeback pages exist before starting writeback
>   btrfs: lock extents before pages in relocation
>   btrfs: Add inode->i_count instead of calling ihold()
>   btrfs: debug extent locking

I've picked the branch from your git repository (applies on top of
misc-next) and will add it to for-next. We may need to keep it there for
some time, with this kind of core change it's not possible to do reverts
in case we find serious problems.

Optimistic plan is to get it stabilized during current dev cycle and
then one more cycle for stabilization once it's in the master branch.

A general comment for all patches is that the changes need more
explanation regarding the effects of the reversed locking for the
particular context. With the longer time span for the merge we can add
it as we find bugs or need to clarify things.
