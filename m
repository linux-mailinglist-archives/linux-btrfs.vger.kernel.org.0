Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101CA549C20
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 20:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239972AbiFMStC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 14:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345641AbiFMSsd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 14:48:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1656B7D0
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 08:46:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 538D71F38A;
        Mon, 13 Jun 2022 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655135200;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kVBiUS6IqYLp/6XPtcI/TFCy7DpJQUGIzEt5vWQmFkc=;
        b=Tkjvi4YmLD5M8RyWBAC7/ywbX8B7YndeSffqbG+viiSDCH93tnMDyZjiYXstQcEAXpVUE7
        qMCFRLyaO+ssLlV4y0sQMbLQWvSUg2uRs7v3PCwLNUgopH9fmrR9c+pmQk00M91y88zLi2
        fU/PtUKIUunRwzAPUyXu9Te8sz1WUJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655135200;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kVBiUS6IqYLp/6XPtcI/TFCy7DpJQUGIzEt5vWQmFkc=;
        b=297lQfPCJiYoom/Wfk4b+mKTw9HNOGPGkfAkGwQaFW1pLnC4s/MHUtnqBMG4dhXbCqzIPW
        Zrady/yAnKBJSqDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A7C2134CF;
        Mon, 13 Jun 2022 15:46:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3jhkCeBbp2KQYgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 13 Jun 2022 15:46:40 +0000
Date:   Mon, 13 Jun 2022 17:42:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: properly record errors for super block writeback
Message-ID: <20220613154207.GB20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <6726644169a9f4affbb6894a8a560c96072be9cf.1654841347.git.wqu@suse.com>
 <b479101f-400e-1f16-c5d0-1775b7ea1698@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b479101f-400e-1f16-c5d0-1775b7ea1698@suse.com>
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

On Fri, Jun 10, 2022 at 04:22:17PM +0800, Qu Wenruo wrote:
> On 2022/6/10 14:09, Qu Wenruo wrote:
> > Although function write_dev_supers() will report error, it only report
> > things like failed to grab the page, all those errors before we submit
> > the bio.
> > 
> > But if our bio really failed, due to real IO error, we just set the page
> > error, output an error message, and call it a day.
> > 
> > This makes btrfs to completely ignore super block writeback error.
> > 
> > Thankfully, this is not that a big deal, as normally we should got error
> > when flushing the device before we reached super block writeback.
> > 
> > Anyway we should make write_dev_supers() to include the IO errors.
> > 
> > This patch will enhance the error reporting by:
> > 
> > - Introduce a new on-stack structure to record all errors including IO
> >    errors
> >    The new strucuture, super_block_io_status, will have a wait queue and
> >    accounting for flying bios along with errors we hit so far.
> > 
> > - Output a human readable error message
> >    Instead of something like:
> > 
> >     lost page write due to IO error on dm-1 (-5)
> > 
> >    Now we will have:
> > 
> >     failed to write super block at 65536 on dm-1 (-5)
> > 
> > - Wait for all super block IO finished before returning
> >    write_dev_supers()
> >    So now write_dev_supers() will wait for all flying bios to finish, and
> >    use real number of errors to determine if the write failed.
> 
> My bad, I didn't check the later wait_dev_supers() call, which uses 
> PageError to detect if our previous write failed.
> 
> So please drop this patch.
> 
> Although it looks like we don't even need to bother the parallel 
> submission, since in super block writeback, we're already in 
> TRANS_STATE_UNBLOCKED status, thus we're fine to do the work in serial.

The discussions about the super block writes are scattered in several
places, so the parallelism of IO will stay.
