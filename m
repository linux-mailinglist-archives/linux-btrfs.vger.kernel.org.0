Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467695E7896
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 12:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiIWKpW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 06:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiIWKpV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 06:45:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D99255BA
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 03:45:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7FD101FA43;
        Fri, 23 Sep 2022 10:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663929918;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NjEEGNjKVMXh/BZWB6MD7GaClvoqtE7YXnd7mOlH2H0=;
        b=A2M0A9cs2iEWbkc5UA25xar31Th0N2pxZ1zHVxcfB/3Fa56qXKMWco5F+KiP4+HVmaKUk6
        h1C9yi74q3icI3MQdOXFL4CecA656vHmJPuYVhJcvxFb8Brn8cOqYOCUToHi/08HJ1QUav
        07wNFKyHT2G3Se+8ul0Zh3c0E6Ik2KE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663929918;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NjEEGNjKVMXh/BZWB6MD7GaClvoqtE7YXnd7mOlH2H0=;
        b=kU3HnpN+O+piUGx8JIdiH9j71sxBcvG8hj3Yk+yqS0p4QSjJjtwmNrCg7qdStwhMm5IlHq
        8FVF9ZZPg77smUCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DBCB13AA5;
        Fri, 23 Sep 2022 10:45:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2MDxFT6OLWNXRgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 23 Sep 2022 10:45:18 +0000
Date:   Fri, 23 Sep 2022 12:39:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: btrfstune: add -B option to convert back to
 extent tree
Message-ID: <20220923103945.GQ32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <18c52a4ae1bb038beb16ad6d011d6dbe10321922.1663917740.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18c52a4ae1bb038beb16ad6d011d6dbe10321922.1663917740.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 23, 2022 at 03:22:44PM +0800, Qu Wenruo wrote:
> With previous btrfstune support to convert to block group tree, it has
> implemented most of the infrastructure for bi-directional convert.
> 
> This patch will implement the remaining conversion support to go back to
> extent tree.
> 
> The modification includes:
> 
> - New convert_to_extent_tree() function in btrfstune.c
>   It's almost the same as convert_to_bg_tree(), but with small changes:
>   * No need to set extra features like NO_HOLES/FST.
>   * Need to delete the block group tree when everything finished.
> 
> - Update btrfs_delete_and_free_root() to handle non-global roots
>   Currently the function can only accept global roots (extent/csum/free
>   space trees)
> 
>   If we pass a non-global root into the function, we will screw up
>   global_roots_tree and crash.
> 
>   Since we're going to use btrfs_delete_and_free_root() to free block
>   group tree which is not a global tree, this is needed.
> 
> - New handling for half converted fs in get_last_converted_bg()
>   There are two cases need to be handled:
>   * The bg tree is already empty
>     We need to grab the first bg in extent tree.
>     Or at convertion function we will fail at grabbing the first bg.
> 
>   * The bg tree is not empty
>     Then we need to grab the last bg in extent tree.
> 
> - Extra root switching in involved functions
>   This involves:
>   * read_converting_block_groups()
>   * insert_block_group_item()
>   * update_block_group_item()
> 
>   We just need to update our target root according to the current
>   compat_ro and super flags.
> 
> - Various misc changes
>   Like introducing the new getopt() option and help strings/docs.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  Documentation/btrfstune.rst |   4 +
>  btrfstune.c                 | 154 +++++++++++++++++++++++++++++++++++-
>  kernel-shared/disk-io.c     |  11 ++-
>  kernel-shared/extent-tree.c |  93 ++++++++++++++++++----
>  4 files changed, 245 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/btrfstune.rst b/Documentation/btrfstune.rst
> index 01c59d6dbf3b..be2a43750b16 100644
> --- a/Documentation/btrfstune.rst
> +++ b/Documentation/btrfstune.rst
> @@ -29,6 +29,10 @@ OPTIONS
>          Enable block group tree feature (greatly reduce mount time),
>          enabled by mkfs feature *block-group-tree*.
>  
> +-B
> +        Disable block group tree feature,
> +        mostly for compatibility reasons.

Please use only long options, it's becoming unwieldy for btrfstune,
we'll need to add for the rest too. And maybe it's time to move it under
the main tool as there aren't only one-off actions. The big question is
how to organize it in the command hierarchy, I'll need to think about
that. Until then the btrfstune will be enhanced.
