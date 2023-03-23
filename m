Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450056C7133
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 20:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjCWTlm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 15:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCWTll (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 15:41:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEC42212A
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 12:41:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 45C761FE3D;
        Thu, 23 Mar 2023 19:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679600499;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xmK3fadbc2e+bOGlyvvPpJeZhzvLztefHYTnX5M83C4=;
        b=ME4sLKE3h0lxr3T96z11mcS9wHwd7Q8h3e7uC5Pq8au/Nx32acO9RVMPH1SdpeAiEuFEKr
        wXzDiCjgKhqJKjJRv6D25G3A6EQBQklwxQ01U4FmAznOh146tlUvjPxgb54HQGxiY82Eic
        StuRnwblDjMkG4uj8qqj57DnnDph0Y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679600499;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xmK3fadbc2e+bOGlyvvPpJeZhzvLztefHYTnX5M83C4=;
        b=LlxiwZDKKVirvqm385Ciw5ogbCE8gjHVv8v+n3hAbSir4PNdWY7fH6kKCB0uBys+JiN/Mg
        9jhm5zW/nhWebdCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 252A6132C2;
        Thu, 23 Mar 2023 19:41:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /ukcCHOrHGT+MQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 23 Mar 2023 19:41:39 +0000
Date:   Thu, 23 Mar 2023 20:35:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/24] btrfs: cleanups and small fixes mostly around
 block reserves
Message-ID: <20230323193527.GC10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1679326426.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679326426.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 21, 2023 at 11:13:36AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A set of cleanups and small fixes that started as part of a larger work,
> mostly around block reserves and space reservation, but as they are mostly
> trivial and independent of the rest of that work, I'm sending them out
> separately. More details on the individual changelogs.
> 
> Filipe Manana (24):
>   btrfs: pass a bool to btrfs_block_rsv_migrate() at evict_refill_and_join()
>   btrfs: pass a bool size update argument to btrfs_block_rsv_add_bytes()
>   btrfs: remove check for NULL block reserve at btrfs_block_rsv_check()
>   btrfs: update documentation for BTRFS_RESERVE_FLUSH_EVICT flush method
>   btrfs: update flush method assertion when reserving space
>   btrfs: initialize ret to -ENOSPC at __reserve_bytes()
>   btrfs: simplify btrfs_should_throttle_delayed_refs()
>   btrfs: collapse should_end_transaction() into btrfs_should_end_transaction()
>   btrfs: remove bytes_used argument from btrfs_make_block_group()
>   btrfs: count extents before taking inode's spinlock when reserving metadata
>   btrfs: remove redundant counter check at btrfs_truncate_inode_items()
>   btrfs: simplify btrfs_block_rsv_refill()
>   btrfs: remove obsolete delayed ref throttling logic when truncating items
>   btrfs: don't throttle on delayed items when evicting deleted inode
>   btrfs: calculate the right space for a single delayed ref when refilling
>   btrfs: accurately calculate number of delayed refs when flushing
>   btrfs: constify fs_info argument of the metadata size calculation helpers
>   btrfs: constify fs_info argument for the reclaim items calculation helpers
>   btrfs: add helper to calculate space for delayed references
>   btrfs: calculate correct amount of space for delayed reference when evicting
>   btrfs: fix calculation of the global block reserve's size
>   btrfs: use a constant for the number of metadata units needed for an unlink
>   btrfs: calculate the right space for delayed refs when updating global reserve
>   btrfs: simplify exit paths of btrfs_evict_inode()

Added to misc-next, thanks.
