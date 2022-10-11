Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06EC5FB2DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 15:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJKNGo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 09:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJKNGn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 09:06:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7C17FFAB
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 06:06:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5EBC822901;
        Tue, 11 Oct 2022 13:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665493601;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xA/m1GliuK3FB5jliTkWgvmJ98lDZ6J2dhTtnynaMZs=;
        b=LsmREe9+f0zAwuaS7JCEHw+G+l+3bF6R/G3lh//C8H8K7Wc1ZO7jMcIMkh14KUaik4aMxI
        AEr68jvIBm+EMs5acA2ApsBHCZrXS6MZyfxNzQKE8saBkQjNF/pMgxZ44NYte3hfxxDEyh
        OV4ih6kmaJWsKWbeJPruGTp7fdtLwQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665493601;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xA/m1GliuK3FB5jliTkWgvmJ98lDZ6J2dhTtnynaMZs=;
        b=ULfJ5PZATtb5y01TMTY/VaMG8SIwp8kEv3feBJTF7dwnWHvdTpePDhTf5ALmgLMMLEHo6o
        p2AGG90qQSKU+EAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29ED613AAC;
        Tue, 11 Oct 2022 13:06:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kSM3CWFqRWOqYgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Oct 2022 13:06:41 +0000
Date:   Tue, 11 Oct 2022 15:06:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/5] btrfs: data block group size classes
Message-ID: <20221011130635.GT13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1664999303.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1664999303.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 05, 2022 at 12:49:17PM -0700, Boris Burkov wrote:
> This patch set introduces the notion of size classes to the block group
> allocator for data block groups. This is specifically useful because the
> first fit allocator tends to perform poorly when large extents free up
> in older block groups and small writes suddenly shift there. Generally,
> it should lead to slightly more predictable allocator behavior as the
> gaps left by frees will be used by allocations of a similar size.
> 
> Details about the changes and performance testing are in the individual
> commit messages.
> 
> The last two patches constitute the business of the change. One adds the
> size classes and the other handles the fact that we don't want to
> persist the size class, so we don't know it when we first load a block
> group.
> 
> Boris Burkov (5):
>   btrfs: 1G falloc extents
>   btrfs: use ffe_ctl in btrfs allocator tracepoints
>   btrfs: add more ffe tracepoints
>   btrfs: introduce size class to block group allocator
>   btrfs: load block group size class when caching

I'll merge patches 2 and 3 extending the tracepoints as it's
independent, I think you wanted to benchmark again the patchset as the
first patch gets dropped.
