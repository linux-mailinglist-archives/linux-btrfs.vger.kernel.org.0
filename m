Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0C66FD335
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 02:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjEJAEu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 20:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbjEJAEr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 20:04:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D58113
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 17:04:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C94A11F388;
        Wed, 10 May 2023 00:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683677083;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4RVaGQbEidjGsIj6AWy2/iIO6qq1Wm+22iBGN2Z+KFg=;
        b=XXgeGoRXYlr2EZob9OtT+6WhHxkSX/c18LOz1XtsGI86/3OdGU0ltox7TTfRNOEkPaf1w1
        og3Djb1hhavFQJuFZ0SiOh9aM7dYHyUfHlZZf2nJxf7YwS+Kso1xnYxhoAgSlL474ErNII
        +BV6dJ9ghvlFHSUtKFmBlvXJ9fV84aA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683677083;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4RVaGQbEidjGsIj6AWy2/iIO6qq1Wm+22iBGN2Z+KFg=;
        b=xnC0tYgJUwOJRwRh8ZNAFg1v32GzBBuQuh2ZcbZysnZcUcLozxxd87fe/Y/YjiybGMv/HB
        9+2uZp//90KAxYDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9056513499;
        Wed, 10 May 2023 00:04:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A2FsIpvfWmSiGwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 10 May 2023 00:04:43 +0000
Date:   Wed, 10 May 2023 01:58:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Boris Burkov <boris@bur.io>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/9] btrfs: track original extent subvol in a new inline
 ref
Message-ID: <20230509235844.GO32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1683075170.git.boris@bur.io>
 <7a4b78e240d2f26eb3d7be82d4c0b8ddaa409519.1683075170.git.boris@bur.io>
 <c10a17cb-506a-2540-eb19-c79c6c00f788@gmx.com>
 <ZFPaf/la4nhbWK7q@devvm9258.prn0.facebook.com>
 <e92837ae-0a14-21ee-1d2e-699165391ff2@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e92837ae-0a14-21ee-1d2e-699165391ff2@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 05, 2023 at 05:49:00AM +0800, Qu Wenruo wrote:
> On 2023/5/5 00:17, Boris Burkov wrote:
> > On Wed, May 03, 2023 at 11:17:12AM +0800, Qu Wenruo wrote:
> >> On 2023/5/3 08:59, Boris Burkov wrote:
> >>> In order to implement simple quota groups, we need to be able to
> >>> associate a data extent with the subvolume that created it. Once you
> >>> account for reflink, this information cannot be recovered without
> >>> explicitly storing it. Options for storing it are:
> >>> - a new key/item
> >>> - a new extent inline ref item
> >>>
> >>> The former is backwards compatible, but wastes space, the latter is
> >>> incompat, but is efficient in space and reuses the existing inline ref
> >>> machinery, while only abusing it a tiny amount -- specifically, the new
> >>> item is not a ref, per-se.
> >>
> >> Even we introduce new extent tree items, we can still mark the fs compat_ro.
> >>
> >> As long as we don't do any writes, we can still read the fs without any
> >> compatibility problem, and the enable/disable should be addressed by
> >> btrfstune/mkfs anyway.
> > 
> > Unfortunately, I don't believe compat_ro is possible with this design.
> > Because of how inline ref items are implemented, there is a lot of code
> > that makes assumptions about the extent item size, and the inline ref
> > item size based on their type. The best example that definitely breaks
> > things rather than maybe just warning is check_extent in tree-checker.c
> 
> IIRC if it's compat_ro, older kernel would reject the block group items 
> read.
> 
> If we expand that behavior to reject the whole extent tree, it can stay 
> compat_ro.
> Although you may need to do extra backports.
> 
> > 
> > With a new unparseable ref item inserted in the sequence of refs, that
> > code will either overflow or detect padding. The size calculation comes
> > up 0, etc. Perhaps there is a clever way to trick it, but I have not
> > seen it yet.
> > 
> > I was able to make it compat_ro by introducing an entirely new item for
> > the owner ref, but that comes with a per extent disk usage tradeoff that
> > is fairly steep for storing just a single u64.
> 
> If it's only to glue the original ref to an extent, I guess a new key 
> without an item would be enough.
> Although that's still quite expensive.

I consider allocating a new key as a high cost, it's worth for new
feature like verity or encryption where we require a fine grained
tracking of some new information. The number space is 255 values wide
and there are some ranges that are relatively ordered so the placement
in the logical b-tree space is good. We still have enough free values
but the gaps get smaller each time so I'd rather consider other options
first.

One drawback with features defined by keys is that it can't be easily
seen from superblock if the feature is present or not. Like extended
refs, no holes, lzo/zstd compressed extents. We always need to add the
compat bit. In case we would add a new key just to store little data and
still need to add the incompat bit it's time to think again if we could
get away with just the incompat bit. With some loss of backward
compatibility.

Right now I don't know what would be the best way forward but I'm
leaning more towards less backward compatibility and saving space in
structures. We get new incompat features "regularly" and people move to
newer kernels eventually after some period where we have time to iron
out bugs and explore the use case.

The simple quotas should fill the gap that qgroups can't so it makes
sense and people have been asking for something like that.
