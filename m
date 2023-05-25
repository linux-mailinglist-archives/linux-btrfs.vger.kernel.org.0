Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E9F711A75
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 01:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjEYXGo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 19:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjEYXGn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 19:06:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74AEBB
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 16:06:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B2ACD21C49;
        Thu, 25 May 2023 23:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685055996;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uyvr7IXpWy2Uv1DnbAxZe5snWLs9V+8YS1+sA/461T0=;
        b=rK90bErf6GZc+IiZmxHiMdE7ypKiXmJ6FYNh1JQ3TMluz3cFoHG/1H9Huhkwg9JnYvfj/s
        9G99DeKCWJA+pGeVqIllmwFKIRZs5PUu1VzLiZcfV/pmetOSttqqb5Q84TFZ/udYJEH57w
        +9YveYgwO7UNVpl/+VRlUP77xjxNKJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685055996;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uyvr7IXpWy2Uv1DnbAxZe5snWLs9V+8YS1+sA/461T0=;
        b=haMkEEo/SYzit5i1gM99KRh485hsbSQXi6svEqvBYbH3RVtBGw3AxD0vlKaIteXrOQVIQb
        b2AqMgBQO/LdzLBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 924ED13356;
        Thu, 25 May 2023 23:06:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9nIEI/zpb2QMVgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 25 May 2023 23:06:36 +0000
Date:   Fri, 26 May 2023 01:00:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 7/9] btrfs: drop NOFAIL from set_extent_bit allocation
 masks
Message-ID: <20230525230028.GL30909@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1684967923.git.dsterba@suse.com>
 <232abb666a6901f909aeb21dc6f5998f0250e073.1684967923.git.dsterba@suse.com>
 <58561722-bb40-ffd5-0154-b466810c4cf0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58561722-bb40-ffd5-0154-b466810c4cf0@gmx.com>
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

On Thu, May 25, 2023 at 06:38:51PM +0800, Qu Wenruo wrote:
> On 2023/5/25 07:04, David Sterba wrote:
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
> As I mentioned in the cover letter, if we really want to set/clear bits
> to not fail, and can accept the extra memory usage (as high as twice the
> number of extent states), then we should really consider the following
> changes:
> 
> - Introduce hole extent_state
>    For ranges without any bit set, there still needs to be an
>    extent_state.
> 
> - Make callers to pre-allocate 2 extent_state and pass them as mandatory
>    parameters to set/clear bits
> 
> - Make set/clear bits to use the preallocated 2 extent states
> 
> By this, we should be able to completely get rid of the memory
> allocation inside the extent io tree set/clear calls.

I did not understand what you mean from the cover letter comment but now
I see it. The size of extent_state is 72 bytes on release build, which
is not that much, doubling that size is still in acceptable range even
if we'd never utilize the preallocated memory at some point. That we
dont't see any failures now is 1) GFP_NOFS does not fail 2) we're using
a slab cache and the objects get reused within the same allocated space
due to frequent state changes. Even if 1) wasn't true we'd still have to
hit a hard memory allocation error, i.e. no available pages for a slab
extension.

If the preallocation prevents any failure due to memory allocations then
we can keep the current way of dealing with extent bit change error
handling, i.e. none because we rely on the allocator.
