Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E83499365
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 21:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356979AbiAXUdd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 15:33:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54466 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381908AbiAXUYw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 15:24:52 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6C9381F380;
        Mon, 24 Jan 2022 20:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643055891;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y9iPlWAqAXxpIPqrho+ImGwsNKoJBSd5oVR9lKv0kgw=;
        b=Vj5+OSr/kKTH4I6WqfgFRXk+ruCIhDmRZCmACohdSZEv31gmguo87v7woe5fELYK0fAyO5
        R+puitQEIcaXB5GTlFLBJioPseNiYMH8A7KoxasbKWYIC5UGS80h7LQlnbUgU6lyyULDE2
        fEp4FMygxxxQ/wQNku7J/is7UnDE+zY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643055891;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y9iPlWAqAXxpIPqrho+ImGwsNKoJBSd5oVR9lKv0kgw=;
        b=I6wLiX6EYsGYzT6sLN3H8q3nJ926HK2NbCBBjlrZpLm3Ena/sjr4niVLs9KByivEMk7qTf
        9tcX0y0c40xL0ABQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 61DBBA3B8E;
        Mon, 24 Jan 2022 20:24:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 78B9DDA7A3; Mon, 24 Jan 2022 21:24:11 +0100 (CET)
Date:   Mon, 24 Jan 2022 21:24:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH 0/4] btrfs: refactor scrub entrances for each profile
Message-ID: <20220124202411.GJ14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220107023430.28288-1-wqu@suse.com>
 <12e31a86-79b6-d806-f232-51e9bb0a7e07@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12e31a86-79b6-d806-f232-51e9bb0a7e07@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 19, 2022 at 01:52:25PM +0800, Qu Wenruo wrote:
> Hi David,
> 
> Any plan to merge this patchset?
> 
> And if you need, I can merge all these refactors into one branch for you 
> to fetch.
> 
> I know this sounds terrifying especially after the autodefrag "refactor" 
> disaster, but unlike autodefrag, scrub/replace has existing test case 
> coverage and this time it's really refactor, no behavior change (at 
> least no intentional one).

Well, exactly because of the same change pattern that was done in the
defrag code I'm hesistant to merge it, even if there is test coverage.

Nevertheless, I will put it to for-next.

> I hope to get a stable base for the incoming scrub_page/scrub_bio 
> structure cleanup.
> 
> As there is some plan to make scrub to use page::index for those 
> anonymous pages, so they don't need to rely on bi_private to get their 
> logical bytenr, and hopefully just one structure, scrub_range, to 
> replace the scrub_page/scrub_bio things.

I don't think there's any other potential use of the page::index member
so feel free to use it.
