Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE226BF62F
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Mar 2023 00:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjCQXWW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Mar 2023 19:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQXWU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Mar 2023 19:22:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470C526874
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Mar 2023 16:22:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C334421AAC;
        Fri, 17 Mar 2023 23:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679095337;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l3EDvOgS4MwdxiS/Wg3eoREoUIirI8k56dRJWmOG7I4=;
        b=lV3Q9U3U8jNsF8meJQNKZLzN+qRklcdwUeYrPewk1LR0SDWjDtUP21EhBK5Wvw3uZtZwei
        58bAhnvyX8OtpSkyAZlm+gKwYgt7wTsPWVV322KZXvEcRO5T4JYNSER1WNP5tGNt2ksqVT
        vcScYeAvvtmJ9N5zwv0Y2fz+/fXFIZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679095337;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l3EDvOgS4MwdxiS/Wg3eoREoUIirI8k56dRJWmOG7I4=;
        b=tYJV5JtFtX3AuvV0xFCdAfUs4o+Lb5xfp/HejAJD/yd2CjHu2Q/FewKY6o7xrSiiKSfvZW
        kTE3juwQa17ejqDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8DA821346F;
        Fri, 17 Mar 2023 23:22:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZFuRISn2FGTfYwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 17 Mar 2023 23:22:17 +0000
Date:   Sat, 18 Mar 2023 00:16:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/20] btrfs: always read the entire extent_buffer
Message-ID: <20230317231609.GE10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-5-hch@lst.de>
 <d2f3a67e-cd76-5d02-e7f1-9e7cab1a31ec@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2f3a67e-cd76-5d02-e7f1-9e7cab1a31ec@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 09, 2023 at 11:29:54AM +0000, Johannes Thumshirn wrote:
> On 09.03.23 10:07, Christoph Hellwig wrote:
> > Currently read_extent_buffer_pages skips pages that are already uptodate
> > when reading in an extent_buffer.  While this reduces the amount of data
> > read, it increases the number of I/O operations as we now need to do
> > multiple I/Os when reading an extent buffer with one or more uptodate
> > pages in the middle of it.  On any modern storage device, be that hard
> > drives or SSDs this actually decreases I/O performance.  Fortunately
> > this case is pretty rare as the pages are always initially read together
> > and then aged the same way.  Besides simplifying the code a bit as-is
> > this will allow for major simplifications to the I/O completion handler
> > later on.
> > 
> > Note that the case where all pages are uptodate is still handled by an
> > optimized fast path that does not read any data from disk.
> 
> Can someone smarter than me explain why we need to iterate eb->pages four
> times in this function? This doesn't look super efficient to me.

I remember one bug that was solved by splitting the first loop into two,
one locking all pages first and then checking the uptodate status, the
comment is explaining that.

2571e739677f ("Btrfs: fix memory leak in reading btree blocks")

As you can see in the changelog it's a bit convoluted race, the number
of loops should not matter if they're there for correctness reasons. I
haven't checked the final code but I doubt it's equivalent and may
introduce subtle bugs.
