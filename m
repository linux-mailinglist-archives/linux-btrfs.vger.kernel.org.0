Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCE148792F
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 15:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239560AbiAGOov (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 09:44:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51982 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbiAGOou (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jan 2022 09:44:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 887501F3A3;
        Fri,  7 Jan 2022 14:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641566689;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Tsma8Wdq5uV+jsD8f8JQ9+uNIgJQ0uTtNloEocTxCU=;
        b=qObfoLZDSpfhnNIHMoUdzKY3HZ7HohDL40NkF+KFk6e3fLnJjgHI4Cx8qTG8uPEO8w/coy
        io+/JsMQdjzHqvp9DtxuDVWQJP57w34BkYh8IGrN20PmQVZE8xuMhXlvEus5smZrvt0a60
        fduZM3+5bC8ZgyOrN+HnBop0DsjGxfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641566689;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Tsma8Wdq5uV+jsD8f8JQ9+uNIgJQ0uTtNloEocTxCU=;
        b=JV4PkVkgaEWTwLXoZcasdDuL8DjWFPc3jh7DJ5VyRVlyfgLfg+HNs1cV6iOUNB1Aioh+Kn
        Tl/nKlUbY0vVhZDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 834BBA3B84;
        Fri,  7 Jan 2022 14:44:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 93FACDA7A9; Fri,  7 Jan 2022 15:44:18 +0100 (CET)
Date:   Fri, 7 Jan 2022 15:44:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: refactor scrub entrances for each profile
Message-ID: <20220107144418.GJ14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220107023430.28288-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107023430.28288-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 07, 2022 at 10:34:26AM +0800, Qu Wenruo wrote:
> The branch is based on several recent submitted small cleanups, thus
> it's better to fetch the branch from github:
> 
> https://github.com/adam900710/linux/tree/refactor_scrub
> 
> [CRAP-BUT-IT-WORKS(TM)]
> 
> Scrub is one of the area we seldom touch because:
> 
> - It's a mess
>   Just check scrub_stripe() function.
>   It's a function scrubbing a stripe for *all* profiles.
> 
>   It's near 400 lines for a single complex function, with double while()
>   loop and several different jumps inside the loop.
> 
>   Not to mention the lack of comments for various structures.
> 
>   This should and will never happen under our current code standard.
> 
> - It just works
>   I have hit more than 10 bugs during development, and I just want to
>   give up the refactor, as even the code is crap, it works, passing the
>   existing scrub/replace group.
>   While no matter how small code change I'm doing, it always fails to pass
>   the same tests.
> 
> [REFACTOR-IDEA]
> 
> The core idea here, is to get rid of one-fit-all solution for
> scrub_stripe().
> 
> Instead, we explicitly separate the scrub into 3 groups (the idea is
> from my btrfs-fuse project):
> 
> - Simple-mirror based profiles
>   This includes SINGLE/DUP/RAID1/RAID1C* profiles.
>   They have no stripe, and their repair is purely mirror based.
> 
> - Simple-stripe based profiles
>   This includes RAID0/RAID10 profiles.
>   They are just simple stripe (without P/Q nor rotation), with extra
>   mirrors to support their repair.
> 
> - RAID56
>   The most complex profiles, they have extra P/Q, and have rotation.
> 
> [REFACTOR-IMPLEMENTATION]
> 
> So we have 3 entrances for all those supported profiles:
> 
> - scrub_simple_mirror()
>   For SINGLE/DUP/RAID1/RAID1C* profiles.
>   Just go through each extent and scrub the extent.
> 
> - scrub_simple_stripe()
>   For RAID0/RAID10 profiles.
>   Instead we go each data stripe first, then inside each data stripe, we
>   can call scrub_simple_mirror(), since after stripe split, RAID0 is
>   just SINGLE and RAID10 is just RAID1.
> 
> - scrub_stripe() untouched for RAID56
>   RAID56 still has all the complex things to do, but they can still be
>   split into two types (already done by the original code)
> 
>   * data stripes
>     They are no different in the verification part, RAID56 is just
>     SINGLE if we ignore the repair path.
>     It's only in repair path that our path divides.
> 
>     So we can reuse scrub_simple_mirror() again.
> 
>   * P/Q stripes
>     They already have a dedicated function handling the case.
> 
> With all these refactors, although we have several more functions, we
> get rid of:
> 
> - A double while () loop
> - Several jumps inside the double loop
> - Complex calculation to try to fit all profiles
> 
> And we get:
> 
> - Better comments
> - More dedicated functions
> - A better basis for further refactors
> 
> [INCOMING CLEANUPS]
> 
> - Use find_first_extent_item() to cleanup the RAID56 code
>   This part itself can be as large this patchset already, thus will be
>   in its own patchset.
> 
> - Refactor scrub_pages/scrub_parity/... structures

I've paged through the patches and read the above to get an overall
idea, yeah, I think we have to do some radical cuts in the scrub code
along the lines you suggest. Small incremental changes don't seem to be
feasible when the design has to be changed. Splitting by the redundancy
and parity of the profile sounds reasonable, we have the definitions in
the raid table so no more enumerations by profile etc.
