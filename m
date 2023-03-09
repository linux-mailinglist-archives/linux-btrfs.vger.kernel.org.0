Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E52F6B2CF2
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 19:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjCISgI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 13:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCISgH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 13:36:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC0FF31CE
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 10:36:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0DDDB21CC3;
        Thu,  9 Mar 2023 18:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678386963;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dZ2Rv5yaRyAQsb/q24/xavjU5MGnpvL+ozSd5a4tnEg=;
        b=deY+As0WGUgcgIYTkqKb72fPotBw2DBj0MZ5OIIj2qReiMcWgJQZfBd709Jy6qcdbxTgci
        jTj26Q5tvhyM7gkUTf7zZbZjwZBKEg4wmvTLwRBkWJ5o54OBBTAj20LFGtwnSK4ChxWSPQ
        rAd1cx/ZRv8HuDPfskb8Y0ICnqKg2SE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678386963;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dZ2Rv5yaRyAQsb/q24/xavjU5MGnpvL+ozSd5a4tnEg=;
        b=ixgw/ATXDR3UWNOwKUOJsSUjYJ50FcRZVe5gD2cpEbjS9oxt/pycPxu6eFwCkgAnZfVvWi
        m2b1S4t01vCGVBDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E68C61391B;
        Thu,  9 Mar 2023 18:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fRJENxInCmQUOwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 09 Mar 2023 18:36:02 +0000
Date:   Thu, 9 Mar 2023 19:29:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: refactor __btrfs_map_block()
Message-ID: <20230309182958.GL10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e7d711b6ea444e2f018516f4187f9a614e81af38.1677394468.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7d711b6ea444e2f018516f4187f9a614e81af38.1677394468.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 26, 2023 at 02:56:45PM +0800, Qu Wenruo wrote:
> This refactor mostly focuses on using a generic way to handle stripe
> selection, with minimal per-chunk-type special handling.

Could you please split the patch so the changes are more incremental?
The map block function refactoring is needed but it's a critical
functions and I don't consider replacing one code blob with another as a
good pattern. Anything that can be peeled off and is not directly
related to the profile calculations should be done separately. Ideally
the mapping changes per profile would be done separately but it may not
be possible as the function is the single point where everything gets
switched. Each profile has its own specialities and this is easy to miss
when it's done all at once.

The current code handling profiles still does the if/else series in some
places, in the past most of it has been converted to generic code using
values from the raid attribute table. The number of exceptions in newer
code should decrease, which is done in your patch but still makes me
wonder if we could get rid of that completely either by hiding complex
conditions to helpers or extending the raid table.
