Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E7977F5C1
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 13:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350542AbjHQLyY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 07:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350548AbjHQLyT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 07:54:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50528E4C
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 04:54:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 018F02186F;
        Thu, 17 Aug 2023 11:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692273256;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jvpJ4YaKYFtrZ5jl+x6WqRnPnwTAO8blF/Bg2hfJ85Y=;
        b=0AksMRZDbl8p35Oj/TLNzGsE6/yo5Mk9zxW2cS/tcxFp7//b2YUb/mycCXgf4GPFwKzWJ7
        t/HfAB8lDjF4q7/p+Y5uCcXAdQ/rjpNi6jkm4Yz7tyvw2g6XhKsY0tyqBOcb40N29XPYLy
        H+b1w7mL88i/ouDvoqWxnmaA8QCQhPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692273256;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jvpJ4YaKYFtrZ5jl+x6WqRnPnwTAO8blF/Bg2hfJ85Y=;
        b=RGlbCNvlHEJaMIrjjHg3ECtiggp/yA1hzpF5SCW4NMq0OzuJoRoJxXekwxgcoc5hsuOum9
        D4zRwvFzomMVLhBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D80911358B;
        Thu, 17 Aug 2023 11:54:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 26D5M2cK3mS6SgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 17 Aug 2023 11:54:15 +0000
Date:   Thu, 17 Aug 2023 13:47:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: scrub: avoid unnecessary extent tree search
 for striped profiles
Message-ID: <20230817114747.GI2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c21b78ee8bcf22f373beeefb8ee47ee92dfe8f03.1692097289.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c21b78ee8bcf22f373beeefb8ee47ee92dfe8f03.1692097289.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 15, 2023 at 07:07:19PM +0800, Qu Wenruo wrote:
> [PROBLEM]
> Since commit 8557635ed2b0 ("btrfs: scrub: introduce dedicated helper to
> scrub simple-stripe based range"), the scrub speed of striped profiles
> (RAID0/RAID10/RAID5/RAID6) are degraded, if the block group is mostly
> empty or fragmented.
> 
> [CAUSE]
> In scrub_simple_stripe(), which is the responsible for RAID0/RAID10
> profiles, we just call scrub_simple_mirror() and increase our
> @cur_logical and @cur_physical.
> 
> The problem is, if there are no more extents inside the block group, or
> the next extent is far away from our current logical, we would call
> scrub_simple_mirror() for the empty ranges again and again, until we
> reach the next next.
> 
> This is completely a waste of CPU time, thus it greatly degrade the
> scrub performance for stripped profiles.
> 
> This is also affecting RAID56, as we rely on scrub_simple_mirror() for
> data stripes of RAID56.
> 
> [FIX]
> - Introduce scrub_ctx::found_next to record the next extent we found
>   This member would be updated by find_first_extent_item() calls inside
>   scrub_find_fill_first_stripe().
> 
> - Skip to the next stripe directly in scrub_simple_stripe()
>   If we detect sctx->found_next is beyond our current stripe, we just
>   skip to the full stripe which covers the target bytenr.
> 
> - Skip to the next full stripe covering sctx->found_next
>   Unlike RAID0/RAID10, we can not easily skip to the next stripe due to
>   rotation.
>   But we can still skip to the next full stripe, which can still save us
>   a lot of time.
> 
> Fixes: 8557635ed2b0 ("btrfs: scrub: introduce dedicated helper to scrub simple-stripe based range")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix a u64/u32 division not using the div_u64() helper
> 
> - Slightly change the advancement of logical/physical for RAID0 and
>   RAID56
>   Now logical/physical is always increased first, this removes one
>   if () branch.
> 
> This patch is based on the scrub_testing branch (which is misc-next +
> scrub performance fixes).
> 
> Thus there would be quite some conflicts for stable branches and would
> need manual backport.

Added to misc-next, thanks.
