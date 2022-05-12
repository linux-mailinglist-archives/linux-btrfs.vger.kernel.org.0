Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D39525357
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 May 2022 19:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351262AbiELRNQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 May 2022 13:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243585AbiELRNP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 May 2022 13:13:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A588FF95
        for <linux-btrfs@vger.kernel.org>; Thu, 12 May 2022 10:13:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4639221B23;
        Thu, 12 May 2022 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652375593;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bgo0i/F7ORP3h99SI9Db31r0q5FPO1pujq585xqbXzo=;
        b=l1UEbCR5mNe1XPdO+MATN7yfe3fpl+5sP0bsSM2IaMQSYfzZZnfRSzyYeEw7yBt61KtoaC
        N7X4LcdegKG8mTvn/Qv3SWJK0QJNxUMIzHOGBJbrcceORAcYUyg/9Xr3ot+0qwmtNqxTmF
        Gte7ZaHtUjrp6ymC1kcbky2xro7GA1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652375593;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bgo0i/F7ORP3h99SI9Db31r0q5FPO1pujq585xqbXzo=;
        b=n85bIZTbvq3Zekdj+EH+kW/QoYxYGg6aRuyu41Z16PD6wrXVIbl8WeksnzoU3j20pZGGoa
        w39YcAeii5waIFCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2812613ABE;
        Thu, 12 May 2022 17:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aqXNCClAfWLBHwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 12 May 2022 17:13:13 +0000
Date:   Thu, 12 May 2022 19:08:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/13] btrfs: make read repair work in synchronous mode
Message-ID: <20220512170857.GS18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1651559986.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651559986.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 03, 2022 at 02:49:44PM +0800, Qu Wenruo wrote:
 
> By this we can:
> - Remove the re-entry behavior of endio function
>   Now everything is handled inside end_bio_extent_readpage().
> 
> - Remove the io_failure_tree completely
>   As we don't need to record which mirror has failed.
> 
> - Slightly reduced overhead on read repair
>   Now we won't call btrfs_map_bio() for each corrupted sector, as we can
>   merge the sectors into a much larger bio.

I thake this as the summary points for the whole patchset and frankly I
don't see it justified given all the new problems with the preallocation
and shuffling with the structures. What we have now is not perfect and I
would like to get rid of the io_failure_tree too, yet it works.

The main point is probably to stop reentering the functions, though the
idea of having a single tree that tracks the repair state and there are
callbacks dealing with that is not IMHO bad design. The alternative is
to complicate data structures and endio handler. I'm not sure if it's
worth the risk.
