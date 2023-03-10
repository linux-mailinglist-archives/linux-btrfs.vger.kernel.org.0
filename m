Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC176B4D52
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 17:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjCJQlW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 11:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjCJQk7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 11:40:59 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95412B74A
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 08:38:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A3F1E1FD82;
        Fri, 10 Mar 2023 16:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678466295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LtoPOvVZU0z2EcQ9WmU8WIoqf+IwSN+01/kb+Kbd6QA=;
        b=N3zSBuiJdgVjR8DyXBy/JbgrE2Axb5NxFrorSqKBfcmqZdQCtX4sbQmhwh/5XUsuq4y0HG
        6IcaK3bx0U6fpSDmgF0fkjeiX6ghnHfAqoJ8Xzb3nNPk7llCs7WjF5saOICiEX9mUEIHjw
        i1GT29BYbPewWAQZl1cQifFPKr7m+bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678466295;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LtoPOvVZU0z2EcQ9WmU8WIoqf+IwSN+01/kb+Kbd6QA=;
        b=w1L+LySiPWb7cR3N/7O04AtiZ/xw58OScG6VsQRtaOANEvHKHwMg7QvxDtm93jTvEalrqM
        2n5kYVtstikL1gCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F0AD134F7;
        Fri, 10 Mar 2023 16:38:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zvj4D/dcC2SPKQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Fri, 10 Mar 2023 16:38:15 +0000
Date:   Fri, 10 Mar 2023 10:38:28 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 00/21] Lock extents before pages
Message-ID: <20230310163828.guqukqexmx2pqmy7@kora>
References: <20230302222506.14955-1-rgoldwyn@suse.de>
 <20230309181050.GK10580@twin.jikos.cz>
 <ZArhR3v+Nl/Rq/Nw@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZArhR3v+Nl/Rq/Nw@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23:50 09/03, Christoph Hellwig wrote:
> On Thu, Mar 09, 2023 at 07:10:51PM +0100, David Sterba wrote:
> > I've picked the branch from your git repository (applies on top of
> > misc-next) and will add it to for-next. We may need to keep it there for
> > some time, with this kind of core change it's not possible to do reverts
> > in case we find serious problems.
> 
> I am really worried about the i_count hack.  It is fundamentlly wrong
> and breaks inode lifetime rules.  Furthermore there is no attempt
> at understanding why it happens (or even if it is new with this series).

So this (another version) patch which first added working with i_count is:
8180ef8894fa ("Btrfs: keep inode pinned when compressing writes")

For async, inode is still referenced until all the pages
are written back and cleared in end_compressed_writeback().
evict() waits for all writeback to be completed. Josef, is this
correct?

I removed the ihold() and delayed iput sequence and shifted
unlock_extent() immediately after submit_compressed_extents(). It is
working fine with no crashes for compress tests. But since this is a
race condition I need to be sure if it is the correct thing to do. I
have updated the git [1] but it needs more testing.

In any case, there is another issue with scrubbing which I need to
resolve: btrfs/06[0-3]. I am on vacation next week and the earliest I
can get back to it is March 20.


> 
> > 
> > Optimistic plan is to get it stabilized during current dev cycle and
> > then one more cycle for stabilization once it's in the master branch.
> 
> It is going to clash with quite a bit of other work going in this area
> I fear.

[1] https://github.com/goldwynr/linux/tree/lock-rearrange

-- 
Goldwyn
