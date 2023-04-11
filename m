Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479816DE47B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Apr 2023 21:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjDKTJl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Apr 2023 15:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDKTJj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Apr 2023 15:09:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC06040D5
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 12:09:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 62ECD21A06;
        Tue, 11 Apr 2023 19:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681240177;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WBRtDVJTnT3WnCZUp8Jhcq+cC7wVXGDTJ45ClhdUEEU=;
        b=YLRDTc8J4paooMo0LBetjJb9lFKEfRUp0/8spZfN1kLR6ueOrYfYMAPT/Ucj8P7TvkvOXB
        bKaq3bkUHmB06fXbQIUUtGV2GXLfWjO6e3yHCmnJoO2ThMwJwxjrigRVk4iHoe+FuLx8G0
        mrLWYWq+lqx01AIIY3IIdLtEJh5/klo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681240177;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WBRtDVJTnT3WnCZUp8Jhcq+cC7wVXGDTJ45ClhdUEEU=;
        b=rc8ofpLErjqf264UXY68Xdhzobwoc4IpTm8wnM8YxiNP1s4L5vhb1+QU1vIONx8ySxPQcl
        OHsB/w8Opx9p9nCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B1B713638;
        Tue, 11 Apr 2023 19:09:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QkTGCXGwNWTIagAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Apr 2023 19:09:37 +0000
Date:   Tue, 11 Apr 2023 21:09:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Sterba <dsterba@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: don't offload CRCs generation to helpers if it is fast
Message-ID: <20230411190931.GB19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230329001308.1275299-1-hch@lst.de>
 <20230405231455.GO19619@twin.jikos.cz>
 <ZC5XPqC9+us0sLPX@infradead.org>
 <ZDREvSPL3ePYAx4X@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDREvSPL3ePYAx4X@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 10, 2023 at 10:17:49AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 05, 2023 at 10:23:10PM -0700, Christoph Hellwig wrote:
> > On Thu, Apr 06, 2023 at 01:14:55AM +0200, David Sterba wrote:
> > > > This series implements that and also tidies up various lose ends around
> > > > that.
> > > 
> > > I've picked patch 1 as it's a standalone fix and should go to stable
> > > trees, the rest is in for-next and still queued for 6.4.
> > 
> > So the usual question:
> > 
> >  - should I resend the series with a commit log that you're prefer?
> >  - or just deliver a new commit log?
> >  - or are you just going to fix it up?
> 
> Dave, can you help me on how you want me to proceed here?

Please update the changelog of patch 2. I fix trivial things or do minor
rewording/spelling fixes, when the changelog does not match the code I'd
rather let the original author to write it and me take the second look.

It's getting close to the merge window and there was Easter holiday here
so adding the rest of the patches will be moved to 6.5, also it might be
actually better to group all the workqueue changes together.
