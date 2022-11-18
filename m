Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E5062F9DF
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Nov 2022 17:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbiKRQDL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Nov 2022 11:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiKRQDK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Nov 2022 11:03:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9654F62C3
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Nov 2022 08:03:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5866F1FCFC;
        Fri, 18 Nov 2022 16:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668787388;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nd6Y/oHc3AB14wKO1vXQjBlP2xqkmVviyUJVWmVMAGQ=;
        b=qoyyw2rLiG3V/n0fmV5uniNPKX0rp+d0XIb5A6oqnRaCtg8leNIaVWb8Gs1fBObSrQkPo3
        nUHvX0EgrLtjb+FO3CVzY9S2VuLT41n9q4VLymsXqCBJuxJULjpQ7h5ysrW/aIpmDG3oDv
        uEVCDh2RCJPrb1V3zYDfRQPXYq5K9f4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668787388;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nd6Y/oHc3AB14wKO1vXQjBlP2xqkmVviyUJVWmVMAGQ=;
        b=NuL8t8SnxjVeved/IQolFzB1FdrH2wYFUu2AegMSgwARr3g1WMS11yFu+j389Z6CygHP2H
        pgKc/RWKAUgUU+Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A80913A66;
        Fri, 18 Nov 2022 16:03:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jk9eDbysd2MMegAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 18 Nov 2022 16:03:08 +0000
Date:   Fri, 18 Nov 2022 17:02:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/11] btrfs: a variety of header file cleanups
Message-ID: <20221118160240.GR5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1668526429.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1668526429.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 11:16:09AM -0500, Josef Bacik wrote:
> Hello,
> 
> While syncing accessors.[ch] I ran into a variety of oddities between what we do
> in the kernel vs what we do in btrfs-progs.  Some of these things are just
> differently named helpers, some are helpers we need in progs but don't have in
> the kernel, and some of these are extent tree v2 stuff that was done in
> btrfs-progs but not yet merged into the kernel. I kept the v2 stuff very simple,
> it's mostly just updating helpers to take an extent_buffer.
> 
> Additionally I cleaned up how we do leaf manipulation, because those helpers are
> a little wonky and you have to understand how the leaves are laid out.  I'm not
> in love with what I came up with, but it makes the code a little cleaner, and
> then it made the cleanups easier as there are only 4 sites that needed to be
> updated instead of 32.
> 
> I made these changes in tandem with the btrfs-progs sync of accessors.[ch], and
> then sync'ed the copy based on these changes.  I can obviously update them both
> if there are changes required, but this is why the accessors.h looks different
> in my btrfs-progs patchset, because it's actually a copy of that file with these
> changes applied.  Thanks,
> 
> Josef
> 
> Josef Bacik (11):
>   btrfs: move root helpers back into ctree.h
>   btrfs: move leaf_data_end into ctree.c
>   btrfs: move file_extent_item helpers into file-item.h
>   btrfs: move eb offset helpers into extent_io.h
>   btrfs: move the csum helpers into ctree.h
>   btrfs: pass the extent buffer for the btrfs_item_nr helpers
>   btrfs: add eb to btrfs_node_key_ptr_offset
>   btrfs: add helpers for manipulating leaf items and data
>   btrfs: remove BTRFS_LEAF_DATA_OFFSET
>   btrfs: add nr_global_roots to the super block definition
>   btrfs: add stack helpers for a few btrfs items

Added to misc-next, thanks.
