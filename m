Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A3374F953
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jul 2023 22:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjGKUsL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 16:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjGKUsI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 16:48:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C891F10C2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 13:48:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7CECC1FEEC;
        Tue, 11 Jul 2023 20:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689108485;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AGwQP4QjpDTndF3e5DTvyXQYHIRHHydWrw5qpAKxy4U=;
        b=Bn96pZR6cXhyZnJiNmjxxHpJQRP9xtX5KEDuMJ7keHWhAd4bCfLIW4X3jeTDM54umwChx8
        XfrvRcb01jldwoRFTblMRB0QENQLhzncPaWOa+buZcfsq9Ny0wtfTfPXXuWfvrdSmZpugk
        +4SU7tnIYu2PjRS8BpLBBmVMzAa3H3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689108485;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AGwQP4QjpDTndF3e5DTvyXQYHIRHHydWrw5qpAKxy4U=;
        b=LlV51zxeFsRIVMp+CNmsJR8WQfjtaOM03B0nUjEXFu374Q8Vl7+8C4fdL1cWjvkTZfRxDm
        ZjJsyDxHSwYrzCCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 573841390F;
        Tue, 11 Jul 2023 20:48:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MT9eFAXArWRRKQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Jul 2023 20:48:05 +0000
Date:   Tue, 11 Jul 2023 22:41:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: raid56: always verify the P/Q contents for scrub
Message-ID: <20230711204130.GF30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9874fb351e4374c925d00f9cc1b56730f5d64067.1688086590.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9874fb351e4374c925d00f9cc1b56730f5d64067.1688086590.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 30, 2023 at 08:56:40AM +0800, Qu Wenruo wrote:
> [REGRESSION]
> Commit 75b470332965 ("btrfs: raid56: migrate recovery and scrub recovery
> path to use error_bitmap") changed the behavior of scrub_rbio().
> 
> Initially if we have no error reading the raid bio, we will assign
> @need_check to true, then finish_parity_scrub() would later verify the
> content of P/Q stripes before writeback.
> 
> But after that commit we never verify the content of P/Q stripes and
> just writeback them.
> 
> This can lead to unrepaired P/Q stripes during scrub, or already
> corrupted P/Q copied to the dev-replace target.
> 
> [FIX]
> The situation is more complex than the regression, in fact the initial
> behavior is not 100% correct either.
> 
> If we have the following rare case, it can still lead to the same
> problem using the old behavior:
> 
> 		0	16K	32K	48K	64K
> 	Data 1:	|IIIIIII|                       |
> 	Data 2:	|				|
> 	Parity:	|	|CCCCCCC|		|
> 
> Where "I" means IO error, "C" means corruption.
> 
> In the above case, we're scrubbing the parity stripe, then read out all
> the contents of Data 1, Data 2, Parity stripes.
> 
> But found IO error in Data 1, which leads to rebuild using Data 2 and
> Parity and got the correct data.
> 
> In that case, we would not verify if the Pairty is correct for range
> [16K, 32K).
> 
> So here we have to always verify the content of Parity no matter if we
> did recovery or not.
> 
> This patch would remove the @need_check parameter of
> finish_parity_scrub() completely, and would always do the P/Q
> verification before writeback.
> 
> Fixes: 75b470332965 ("btrfs: raid56: migrate recovery and scrub recovery path to use error_bitmap")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
