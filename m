Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975896C2643
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 01:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCUAPf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 20:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCUAPe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 20:15:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA371BC8
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 17:15:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 04A2921AC1;
        Tue, 21 Mar 2023 00:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679357728;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0KwR6kaNloz2nWyfxLtqSFMHoGo40pVszTuP8OH7dZM=;
        b=AroXaOSNA3hJ6BZhRNKpYR2GfD/wus2pcT2X9km/+PHcmoWA9xxtAtaMtnD/VsERkfruQ9
        5uvl+t28y/MRXAE/a0SMML/Y937+hynXOZD6daTxinbhanq2isVD+PwXn+6YLhlfxvzVF7
        KIdxSZ5ZWbrhCUsjAL1IBBzcL+rw9TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679357728;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0KwR6kaNloz2nWyfxLtqSFMHoGo40pVszTuP8OH7dZM=;
        b=oQlhyaEFoVUs4Fp4zkzVdMji66FRiffd6Yliug4+JWE9Mq/yKebUEOHaeM/dicDGcYGQAI
        njV9dAkIbYvFUZDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCBD913451;
        Tue, 21 Mar 2023 00:15:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WSF0MB/3GGR6RQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Mar 2023 00:15:27 +0000
Date:   Tue, 21 Mar 2023 01:09:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 00/12] btrfs: scrub: use a more reader friendly code
 to implement scrub_simple_mirror()
Message-ID: <20230321000918.GI10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1679278088.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679278088.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 20, 2023 at 10:12:46AM +0800, Qu Wenruo wrote:
> [TODO]
> 
> - More testing on zoned devices
>   Now the patchset can already pass all scrub/replace groups with
>   regular devices.

I think I noticed some disparity in the old and new code for the zoned
devices. This should be found by testing so I'd add this series to
for-next and see.

> - More cleanup on RAID56 path
>   Now RAID56 still uses some old facility, resulting things like
>   scrub_sector and scrub_bio can not be fully cleaned up.

We can do that incrementally, as long as the raid56 scrub works the
cleanups can be done later, the series changes a lot of code already.

> Qu Wenruo (12):
>   btrfs: scrub: use dedicated super block verification function to scrub
>     one super block
>   btrfs: introduce a new helper to submit bio for scrub
>   btrfs: introduce a new helper to submit write bio for scrub
>   btrfs: scrub: introduce the structure for new BTRFS_STRIPE_LEN based
>     interface
>   btrfs: scrub: introduce a helper to find and fill the sector info for
>     a scrub_stripe
>   btrfs: scrub: introduce a helper to verify one metadata
>   btrfs: scrub: introduce a helper to verify one scrub_stripe
>   btrfs: scrub: introduce the main read repair worker for scrub_stripe
>   btrfs: scrub: introduce a writeback helper for scrub_stripe
>   btrfs: scrub: introduce error reporting functionality for scrub_stripe
>   btrfs: scrub: introduce the helper to queue a stripe for scrub
>   btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe
>     infrastructure

The whole series follows the pattern to first introduce the individual
helpers that can be reviewed separately and then does the switch in one
patch. As the whole scrub IO path is reworked I don't think we can do
much better so clearly separating the old and new logic sounds OK.

One comment I have, the functional switch in the last patch should not
be mixed with deleting of the unused code. As the last patch activates
code from all the previous patches it would also show up in any
bisection as the cause so it would help to narrow the focus only on the
real changes.

There are some minor coding style issues I'll point out under the
patches. I'm assuming that the scrub structure won't change again soon
(the old code is from 3.x times) so let's use this opportunity to make
the style most up to date.
