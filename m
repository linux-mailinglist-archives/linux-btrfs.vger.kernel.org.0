Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BEB4D523D
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 20:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbiCJTeC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 14:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343614AbiCJTeA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 14:34:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FD013FAE5
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 11:32:58 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 30EAC1F385;
        Thu, 10 Mar 2022 19:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646940777;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EF1Mz6RSrZwNUQda6UrxqxsEARGaDB++D0mjlQPobLo=;
        b=yx07KLuooYHnG6PNcXkoF96S/NdokzLvpRViU4b6GhLDvAZsIftmYblb19v3X1jREExsW9
        0UAkMT3E71PrVgslL77I2aiH8s+2Blg2U3BWpvTHcBTj/CZ3Beo3S9bDCNJsxqmmquBsr9
        Xo/LtHjU6rciA2NNzoEZ4fvxkKcltEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646940777;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EF1Mz6RSrZwNUQda6UrxqxsEARGaDB++D0mjlQPobLo=;
        b=zmd83GINg1x/lVaJfw6MzMh6ztRBy+qzvDeYnNCP66R1RSzC9XBUG5kKnSQ6JRRpXuEy5O
        HjCUa61PCM8FqNDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 27EDAA3B81;
        Thu, 10 Mar 2022 19:32:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E3768DA7E1; Thu, 10 Mar 2022 20:29:00 +0100 (CET)
Date:   Thu, 10 Mar 2022 20:29:00 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: scrub: big renaming to address the page and
 sector difference
Message-ID: <20220310192900.GD12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1645530899.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645530899.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 22, 2022 at 08:09:35PM +0800, Qu Wenruo wrote:
> >From the ancient day, btrfs doesn't support sectorsize < PAGE_SIZE, thus
> a lot of the old code consider one page == one sector, not only the
> behavior, but also the naming.
> 
> This is no longer true after v5.16 since we have subpage support.
> 
> One of the worst location is scrub, we have tons of things named like
> scrub_page, scrub_block::pagev, scrub_bio::pagev.
> 
> Even scrub for subpage is supported, the naming is not touched yet.
> 
> This patchset will first do the rename, providing the basis for later
> scrub enhancement for subpage.
> 
> This patchset should not bring any behavior change.
> 
> Qu Wenruo (3):
>   btrfs: scrub: rename members related to scrub_block::pagev
>   btrfs: scrub: rename scrub_page to scrub_sector
>   btrfs: scrub: rename scrub_bio::pagev and related members

This conflicts with the scrub refactoring, but applies cleanly on
misc-next. I think the rename could go in first as it's a less risky
change and any fixups or fine tuning of the refactoring would not affect
it.
