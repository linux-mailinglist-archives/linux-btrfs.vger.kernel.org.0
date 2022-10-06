Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEE45F6A6A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Oct 2022 17:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiJFPST (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Oct 2022 11:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiJFPSR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Oct 2022 11:18:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1ECA6C34
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 08:18:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 51F4D1F8C3;
        Thu,  6 Oct 2022 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665069494;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VK65Nxwzw56+Y1JQdZrGm3RRGtlSjSWyQus3h2udxFg=;
        b=Xtnzh8lTbdP7/6pwbqIYAeIH5p4PYQxxIZulF3nHjZ2ZQ8NlRl/EVv1Wnrn2AYl89l8By2
        DL2rUUmrGguxMqEjQ7FrauJ3uoU81jjyIfBCc7X27X8gh/6UiWEu2hQ8OuDmYsmd+lVdpI
        TxTDQO/t1a+4ER+vvBsxWFtVGIFgYMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665069494;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VK65Nxwzw56+Y1JQdZrGm3RRGtlSjSWyQus3h2udxFg=;
        b=hh0ILqRSA+4bxrA52YY7VqDbfC79xxuah0dbYT50Z5yhhxI2Wgjz3r1pSMzwDzEGtEibhL
        Y4P47WHl52WDD8AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B2221376E;
        Thu,  6 Oct 2022 15:18:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id il/jCLbxPmNeAwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 06 Oct 2022 15:18:14 +0000
Date:   Thu, 6 Oct 2022 17:18:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4] btrfs-progs: fsfeatures: properly merge -O and -R
 options
Message-ID: <20221006151811.GM13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6df72bf7175552fb966a9529783febdf62bce971.1664934441.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6df72bf7175552fb966a9529783febdf62bce971.1664934441.git.wqu@suse.com>
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

On Wed, Oct 05, 2022 at 09:48:07AM +0800, Qu Wenruo wrote:
> [BUG]
> Commit "btrfs-progs: prepare merging compat feature lists" tries to
> merged "-O" and "-R" options, as they don't correctly represents
> btrfs features.
> 
> But that commit caused the following bug during mkfs for experimental
> build:
> 
>   $ mkfs.btrfs -f -O block-group-tree  /dev/nvme0n1
>   btrfs-progs v5.19.1
>   See http://btrfs.wiki.kernel.org for more information.
> 
>   ERROR: superblock magic doesn't match
>   ERROR: illegal nodesize 16384 (not equal to 4096 for mixed block group)
> 
> [CAUSE]
> Currently btrfs_parse_fs_features() will return a u64, and reuse the
> same u64 for both incompat and compat RO flags for experimental branch.
> 
> This can easily leads to conflicts, as
> BTRFS_FEATURE_INCOMPAT_MIXED_BLOCK_GROUP and
> BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE both share the same bit
> (1 << 2).
> 
> Thus for above case, mkfs.btrfs believe it has set MIXED_BLOCK_GROUP
> feature, but what we really want is BLOCK_GROUP_TREE.
> 
> [FIX]
> Instead of incorrectly re-using the same bits in btrfs_feature, split
> the old flags into 3 flags:
> 
> - incompat_flag
> - compat_ro_flag
> - runtime_flag
> 
> The first two flags are easy to understand, the corresponding flag of
> each feature.
> The last runtime_flag is to compensate features which doesn't have any
> on-disk flag set, like QUOTA and LIST_ALL.
> 
> And since we're no longer using a single u64 as features, we have to
> introduce a new structure, btrfs_mkfs_features, to contain above 3
> flags.
> 
> This also mean, things like default mkfs features must be converted to
> use the new structure, thus those old macros are all converted to
> const static structures:
> 
> - BTRFS_MKFS_DEFAULT_FEATURES + BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES
>   -> btrfs_mkfs_default_features
> 
> - BTRFS_CONVERT_ALLOWED_FEATURES -> btrfs_convert_allowed_features
> 
> And since we're using a structure, it's not longer as easy to implement
> a disallowed mask.
> 
> Thus functions with @mask_disallowed are all changed to using
> an @allowed structure pointer (which can be NULL).
> 
> Finally if we have experimental features enabled, all features can be
> specified by -O options, and we can output a unified feature list,
> instead of the old split ones.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix convert test failure due to missing allowed features
> 
> v3:
> - Fix a bug that we can not unset free-space-tree for non-experimental
>   build
> 
> - Fix a bug that free-space-tree compat RO flags are not properly set
>   for non-experimental build
> 
> v4:
> - Address David's concern of new BTRFS_FEATURE_GENERIC_* defines
>   By introducing a new btrfs_mkfs_features structure, so we don't need
>   extra re-definitions.
> 
>   The amount of code change is still the same as v3, since we have a
>   larger interface change.

Thanks, this version looks good to me and maybe even better than what I
intended to implement myself. The amount of changed lines is high but
the core changes are clear and the rest is API update. Added to devel.
