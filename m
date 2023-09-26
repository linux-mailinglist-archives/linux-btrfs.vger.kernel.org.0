Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB3B7AE9CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 12:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjIZKAE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 06:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbjIZKAD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 06:00:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B37310C
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 02:59:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFA5C433C9;
        Tue, 26 Sep 2023 09:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695722395;
        bh=8ZtQ8TjIoxSFHl51BAg60sx+vXPDoIsWMMDEIV9RZkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRPuJYbtpjb1VAbwZMv0qBQIXHm7m9hhlABgxQvsFCejw1BJkFm7tN04q1k86jsus
         hgDLeYwnesYAVYOyJ67VCwh5zE7jMSPjqKnGcqB7HnOmwTdIazpLvBVE5N7V8kCLCt
         jK2qqXZ4QpAGdO4Q7VWS4JKj7NASlWV17cdRsW9WbDAKxrOIKgxZoLKA/jCyQHIzx4
         O/rUXYGtK2SYqw4t2N+MvSFjlsA+ZbHu9RKjb/PngP1xXeoLaDrY//vmNp1Dv5SUfV
         4jw9TsDu8VIWFSerlUSPCojxCcxlImENC/emZK8zZCtDjvVI1QMDr49eM0LGxPGd/B
         EhvIN18P0J27w==
Date:   Tue, 26 Sep 2023 11:59:50 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RESEND] btrfs: use the super_block as holder when
 mounting file systems
Message-ID: <20230926-sehkraft-duldung-6b4ef0ddbb74@brauner>
References: <20230921121945.4701-1-jack@suse.cz>
 <20230921-wettrennen-warfen-1067d17aef27@brauner>
 <20230925161327.GP13697@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230925161327.GP13697@twin.jikos.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> > Next time we will ensure that a vfs triggered conversion must go through
> > a vfs tree as this half converted state with forgotten patches is not
> > something that we should repeat.
> 
> Taking this as an example, I really don't want to let such patches go
> through VFS git. I understand there are API-level cleanups done in
> VFS that require reorganizing code in the filesystems but IMO the
> conversions must be done in the filesystems first and the VFS cleanups
> as a followup.

Whether or not this order is possible depends on the patchset. If we do
VFS level conversions that impact all filesystems we will do changes to
all filesystems in one go if the changes need to be done all at the same
time as we have done many times in the past. There's really nothing new.

> there's a change regarding the reviews or merge.

We'll likely end pulling in the required btrfs changes from you anyway
so Jan's series isn't blocked indefinitely from getting testing in
-next.
