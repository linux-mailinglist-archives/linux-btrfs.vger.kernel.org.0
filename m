Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09449711AAF
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 01:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjEYXbg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 19:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjEYXbf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 19:31:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB51E7
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 16:31:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E516C1FD86;
        Thu, 25 May 2023 23:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685057492;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T+u4ZmwxgqPxKv1Kcy5npYVSuhMSmag0l/dssGjnMQY=;
        b=yecJOcqGopfyWCswd3wke4HEvAMlxJr+K1UOkn8TXZpadrQoYbFe73uGKCMmzIjTuLdYTM
        R0joNfGRXpZp2yiCrWVHu6DA+TTXA9VLjUNUZ9BM44GtoSr9Mh5KyMuQ9+bk1NdJ0AC7V7
        nRI89HL6BzjzpOZpQwpEYxwVrz1HHlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685057492;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T+u4ZmwxgqPxKv1Kcy5npYVSuhMSmag0l/dssGjnMQY=;
        b=CghFhFhn4QMSGtLQm7NJU/qi1WkytfKajqmRF5U6FFCX9zOgqXr56OTRt9mNhedYpF0J+D
        ItOhFAbUnLgTwHAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE28D134B2;
        Thu, 25 May 2023 23:31:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ntvELdTvb2TCXwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 25 May 2023 23:31:32 +0000
Date:   Fri, 26 May 2023 01:25:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 7/9] btrfs: drop NOFAIL from set_extent_bit allocation
 masks
Message-ID: <20230525232524.GO30909@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1684967923.git.dsterba@suse.com>
 <232abb666a6901f909aeb21dc6f5998f0250e073.1684967923.git.dsterba@suse.com>
 <ZG8k/ZMryufugSMN@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG8k/ZMryufugSMN@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 25, 2023 at 02:06:05AM -0700, Christoph Hellwig wrote:
> On Thu, May 25, 2023 at 01:04:34AM +0200, David Sterba wrote:
> > The __GFP_NOFAIL passed to set_extent_bit first appeared in 2010
> > (commit f0486c68e4bd9a ("Btrfs: Introduce contexts for metadata
> > reservation")), without any explanation why it would be needed.
> > 
> > Meanwhile we've updated the semantics of set_extent_bit to handle failed
> > allocations and do unlock, sleep and retry if needed.  The use of the
> > NOFAIL flag is also an outlier, we never want any of the set/clear
> > extent bit helpers to fail, they're used for many critical changes like
> > extent locking, besides the extent state bit changes.
> 
> Given how many of the callers do not check the return value, and that
> the trees store essential information, I think the right thing here
> is to always use __GFP_NOFAIL unless GFP_NOWAIT is passed.  In practice
> this won't make a difference as currently small slab allocations never
> fail, but that's an undocumented assumption.

Yeah, that "GFP_NOFS does not fail for < costly allocations" has been a
deal with the allocator but there was some pressure to stop doing that
eventually. Discussed at LSF/MM, __GFP_NOFAIL should be replaced by
proper error handling if possible and minimized. I'm not sure if adding
it for something that frequently done as the state bit changes is a good
idea wrt memory management but I agree there's practically no change how
things currently work.

Qu suggested another way how we could preallocate some memory that would
be used for extent holes and then reused for the cases where we need to
allocate to do insert/split. I'd like to try this approach first and also
check with MM guys that NOFAIL in this case is acceptable so we have
more options to choose from.
