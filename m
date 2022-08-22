Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41EC59C3A4
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 18:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiHVQEQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 12:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiHVQEP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 12:04:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF3322B2B
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 09:04:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C9E335113;
        Mon, 22 Aug 2022 16:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661184252;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y5ewjeDexQ5TXKTR4iMTjGiC6IeeTW0aoHZ+58uMEM4=;
        b=YpJYe716vWyKFlvSOBDXYTFxZcmKUxd76YCbkoVUhav3cBQaIpmlgNEwphNBI3r5THvANC
        8jOHpr4n0OV5KLmFY/+qqAGJ5DqAS0sPWXTxG7IgVfwS1JxYjOHx2byIhX0av4TEBZeO4q
        yBy9zsI/loSczGtjS8y+Fhwv8GOQSG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661184252;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y5ewjeDexQ5TXKTR4iMTjGiC6IeeTW0aoHZ+58uMEM4=;
        b=8EtrLLoN/YpkeeLxWWSkWkOK8DeaXP/V6RUetmWUubPRbqHZUIRFIJF6ffcVKaQmP6bXib
        7fffX+28hfqx7/Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C19713523;
        Mon, 22 Aug 2022 16:04:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +Ff1AfyoA2OsJwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 Aug 2022 16:04:12 +0000
Date:   Mon, 22 Aug 2022 17:58:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dylan Yudaken <dylany@fb.com>
Subject: Re: [PATCH] btrfs: don't allow large NOWAIT direct reads
Message-ID: <20220822155858.GA13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dylan Yudaken <dylany@fb.com>
References: <882730e60b58b8d970bd8bc3a670e598184eefef.1660924379.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <882730e60b58b8d970bd8bc3a670e598184eefef.1660924379.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 19, 2022 at 11:53:39AM -0400, Josef Bacik wrote:
> Dylan and Jens reported a problem where they had an io_uring test that
> was returning short reads, and bisected it to ee5b46a353af ("btrfs:
> increase direct io read size limit to 256 sectors").
> 
> The root cause is their test was doing larger reads via io_uring with
> NOWAIT and async.  This was triggering a page fault during the direct
> read, however the first page was able to work just fine and thus we
> submitted a 4k read for a larger iocb.
> 
> Btrfs allows for partial IO's in this case specifically because we don't
> allow page faults, and thus we'll attempt to do any io that we can,
> submit what we could, come back and fault in the rest of the range and
> try to do the remaining IO.
> 
> However for !is_sync_kiocb() we'll call ->ki_complete() as soon as the
> partial dio is done, which is incorrect.  In the sync case we can exit
> the iomap code, submit more io's, and return with the amount of IO we
> were able to complete successfully.
> 
> We were always doing short reads in this case, but for NOWAIT we were
> getting saved by the fact that we were limiting direct reads to
> sectorsize, and if we were larger than that we would return EAGAIN.
> 
> Fix the regression by simply returning EAGAIN in the NOWAIT case with
> larger reads, that way io_uring can retry and get the larger IO and have
> the fault logic handle everything properly.
> 
> This still leaves the AIO short read case, but that existed before this
> change.  The way to properly fix this would be to handle partial iocb
> completions, but that's a lot of work, for now deal with the regression
> in the most straightforward way possible.
> 
> Reported-by: Dylan Yudaken <dylany@fb.com>
> Fixes: ee5b46a353af ("btrfs: increase direct io read size limit to 256 sectors")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
