Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA1769854F
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 21:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBOUNq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 15:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBOUNp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 15:13:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1567A2597E
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 12:13:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B59FA33952;
        Wed, 15 Feb 2023 20:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676492022;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rt1vLtRWM6vT9y3wjHGyIYGt0aBlbGPKMNzuoVxBKVo=;
        b=UdlemQy7kwNPaWvU+AVAvvhQI7T3ywymORsoKUibvmS1HjvOUTgtJABjqUConHthz9oPp+
        9isKD0uC4nUodkdHwFj/pUJQLsbEHGYskiSkOI4X8BSJng04X0V1M9SC3wvU8YYumYWv3U
        kHAzKjBqZzhgwJMpZo3+Xr/XLNR2z88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676492022;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rt1vLtRWM6vT9y3wjHGyIYGt0aBlbGPKMNzuoVxBKVo=;
        b=m2M09c1o75GC4K8OZyOIzEgxfobrMlYiRiIp+fF1eeggVT/sPvY1hzhkRMO6akk9YoEMMg
        2DK6IvfqyRkfmrDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D82F134BA;
        Wed, 15 Feb 2023 20:13:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9xvEIfY87WNpGQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 15 Feb 2023 20:13:42 +0000
Date:   Wed, 15 Feb 2023 21:07:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] btrfs: reduce the memory usage for
 btrfs_io_context, and reduce its variable sized members
Message-ID: <20230215200749.GX28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1675743217.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675743217.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 07, 2023 at 12:26:11PM +0800, Qu Wenruo wrote:
> Changelog:
> v2:
> - Address the comments on various grammar errors
> 
> - Further reduce the memory used for replace
>   Now instead of two s16, it's just one s16 now.
> 
> - Replace raid_map with a single u64
>   This not only reduce the memory usage, but also makes btrfs_io_context
>   to only have one variable sized member (stripes), simplify the
>   allocation function
> 
>   This also removes the need to bubble sort the stripes.
> 
> 
> In btrfs_io_context, we have two members dedicated to replace, and one
> extra array for raid56
> 
> - num_tgtdevs
>   This is straight-forward, just the number of extra stripes for replace
>   usage.
> 
> - tgtdev_map[]
>   This is a little complex, it represents the mapping between the
>   original stripes and dev-replace stripes.
> 
>   This is mostly for RAID56, as only in RAID56 the stripes contain
>   different contents, thus it's important to know the mapping.
> 
>   It goes like this:
> 
>     num_stripes = 4 (3 + 1 for replace)
>     stripes[0]:		dev = devid 1, physical = X
>     stripes[1]:		dev = devid 2, physical = Y
>     stripes[2]:		dev = devid 3, physical = Z
>     stripes[3]:		dev = devid 0, physical = Y
> 
>     num_tgtdevs = 1
>     tgtdev_map[0] = 0	<- Means stripes[0] is not involved in replace.
>     tgtdev_map[1] = 3	<- Means stripes[1] is involved in replace,
> 			   and it's duplicated to stripes[3].
>     tgtdev_map[2] = 0	<- Means stripes[2] is not involved in replace.
> 
>   Thus most space is wasted, and the more devices in the array, the more
>   space wasted.
> 
> - raid_map[]
>   A sorted array where the first one is always the logical bytenr of
>   the full stripe
> 
>   But the truth is, since it's always sorted, we don't need it at all.
>   We can use a single u64 to indicate the full stripe start.
> 
>   Currently we're reusing the array mostly to re-order our stripes for
>   RAID56, which is not ideal, because we can get it down right just in
>   one go.
> 
> All these tgdev_map[] and raid_map[] designs are  wasting quite some
> space, and making alloc_btrfs_io_context() to do very complex and
> dangerous pointer juggling.
> 
> This patch will replace those members by:
> 
> - num_tgtdevs -> replace_nr_stripes
>   Just a rename
> 
> - tgtdev_map[] -> replace_stripe_src
>   It's changed to a single s16 to indicate where the source stripe is.
>   This single s16 is enough for RAID56. For DUP, they don't care the
>   source as all stripes share the same content.
> 
> - raid_map[] -> full_stripe_logical
>   We remove the sort_parity_stripes(), and get the stripes selection
>   done correctly in RAID56 routines.
> 
>   So we only need to record the logical bytenr of the full stripe start.
>   Existing call sites checking the type of stripe can compare with
>   their data stripes number to do the same work.
> 
> This not only saved some space for btrfs_io_context structure, but also
> allows the following cleanups:
> 
> - Streamline handle_ops_on_dev_replace()
>   We go a common path for both WRITE and GET_READ_MIRRORS, and only
>   for DUP and GET_READ_MIRRORS, we shrink the bioc to keep the same
>   old behavior.
> 
> - Remove some unnecessary variables
> 
> - Remove variable sized members
>   Now there is only one variable sized member, stripes.
> 
> Although the series still increases the number of lines, the net
> increase mostly comes from comments, in fact around 100 lines of comments
> are added around the replace related members.
> 
> Qu Wenruo (4):
>   btrfs: simplify the @bioc argument for handle_ops_on_dev_replace()
>   btrfs: small improvement for btrfs_io_context structure
>   btrfs: use a more space efficient way to represent the source of
>     duplicated stripes
>   btrfs: replace btrfs_io_context::raid_map[] with a fixed u64 value

With some fixups added to for-next as topic branch, thanks.
