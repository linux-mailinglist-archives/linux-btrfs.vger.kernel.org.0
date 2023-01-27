Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EB767E7B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 15:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjA0OEC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 09:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjA0ODo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 09:03:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF97D8624A
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 06:02:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DDD391FEEF;
        Fri, 27 Jan 2023 14:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674828112;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XlRwzvh6tNvMpxbcpsqQieLxiM02emqgqmCr/deCEgY=;
        b=dumSeE27CRz7R/ENBk4x8AgNdO4k4zK1udiuguHy8OshrYP7p3IVxLHajJI/hGmKyOjDzm
        vPZL48Cw7HTQDFkdlcMF5oH/CXMTQy+bhZWN8RNyrGv2eBY1JX6i5evURK4+ZMuNYvWIjm
        PYJqKB0x0K2964VnI5CUwDsnSfLNop8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674828112;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XlRwzvh6tNvMpxbcpsqQieLxiM02emqgqmCr/deCEgY=;
        b=Qpn6HXcoKTIRN4awrBqq3NogXMt2LPxL9RiaHBbtuui3SBN0OPIkkclHfUlN0G7uZ/Gijh
        5Ga135/7luzG7UAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4C62138E3;
        Fri, 27 Jan 2023 14:01:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QXSaKlDZ02PrNQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 27 Jan 2023 14:01:52 +0000
Date:   Fri, 27 Jan 2023 14:56:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: raid56: concurrency fix and a very tiny
 optimization
Message-ID: <20230127135609.GC11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1674285037.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674285037.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 21, 2023 at 04:06:10PM +0800, Qu Wenruo wrote:
> We have a unprotected concurrency updateing rbio::error_bitmap.
> The first patch is going to fix it.
> 
> While we are at rbio_update_error_bitmap(), there is also a tiny
> optimization we can do for calculating the bio size.
> Since we only care about the size of the bio, bio_for_each_bvec_all() is
> much better than bio_for_each_segment_all(), as the former one can
> handle multi-page bvec directly to reduce the loop.
> 
> Changelog:
> v2:
> - Use set_bit() in a loop instead of an asymmetrical spinlock.
>   Since only endio can have concurrency accessing the bitmap, while
>   the main thread only access them in a single thread, we will have
>   asymmetrical spinlock schema, which is not ideal.
>   Instead go set_bit() in a loop.
> 
> - Add a tiny optimization to calculate bio length in
>   rbio_update_error_bitmap()
>   
> 
> Qu Wenruo (2):
>   btrfs: raid56: make error_bitmap update atomic
>   btrfs: raid56: reduce the overhead to calculate the bio length

Added to misc-next, thank.
