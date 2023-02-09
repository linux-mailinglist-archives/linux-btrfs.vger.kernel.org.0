Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE8269120A
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Feb 2023 21:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjBIUTr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Feb 2023 15:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBIUTr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Feb 2023 15:19:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E682687
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 12:19:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E6FD437B1E;
        Thu,  9 Feb 2023 20:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675973983;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VWOgs56opCbasNulVKj0mgO0Kvq9gZ7ohsAgBzEU28s=;
        b=T62fkb9YEThy7GgPwbX8EJKf7eUgHnic/XcNMAHoTDcDFf7Fc/TcWerbmCVsKGFKKEqRyU
        TBaq/fRzqWQrmG6UK7P5dR6Q2hVC6W1aTShpHQZASDnlJj6fOoJASCNpiBFuB1hEYomUh4
        sRkiCLPEF7FxZICuxOb0HUqNRjQHRFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675973983;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VWOgs56opCbasNulVKj0mgO0Kvq9gZ7ohsAgBzEU28s=;
        b=AVb1XBZFz7ehMAaqQlQAWZCwUrF7em6baKcWsb0Y0z+QJgz6WFJHn6Ai/OYmae10uHWis+
        tFMcF2eWJnPf+1Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A49471339E;
        Thu,  9 Feb 2023 20:19:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z/YoJ19V5WOzSQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 09 Feb 2023 20:19:43 +0000
Date:   Thu, 9 Feb 2023 21:13:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: small btrfs-zoned fixlets and optimizations
Message-ID: <20230209201353.GQ28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221212073724.12637-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212073724.12637-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 12, 2022 at 08:37:17AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this fixes a minor correctness issue and adds some minor
> optimizations to the btrfs zoned code.
> 
> It sits on top of the
> 
>   "consolidate btrfs checksumming, repair and bio splitting v2"
> 
> series.
> 
> Diffstat:
>  fs/btrfs/bio.c                    |    2 -
>  fs/btrfs/block-group.c            |    9 +-----
>  fs/btrfs/block-group.h            |    3 --
>  fs/btrfs/extent_io.c              |   10 ++----
>  fs/btrfs/inode.c                  |   22 +++++++-------
>  fs/btrfs/ordered-data.c           |   10 +++---
>  fs/btrfs/ordered-data.h           |    3 --
>  fs/btrfs/relocation.c             |    2 -
>  fs/btrfs/tests/extent-map-tests.c |    2 -
>  fs/btrfs/zoned.c                  |   56 +++++++++++++++++++++-----------------
>  fs/btrfs/zoned.h                  |    4 +-
>  include/trace/events/btrfs.h      |    2 -
>  12 files changed, 61 insertions(+), 64 deletions(-)

Added to misc-next, thanks. Patch 2 was skipped (the rename from
disk_bytenr to logical) to keep the on-disk naming in the structures.
