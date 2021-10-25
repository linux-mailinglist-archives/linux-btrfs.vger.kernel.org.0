Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8434A439825
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 16:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhJYOL4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 10:11:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40598 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbhJYOLs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 10:11:48 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EC1B71FD40;
        Mon, 25 Oct 2021 14:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635170965;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cKXaKvAGA7tQqZMva7lq9bNiBcDbYKs5HH6G4uyOqtc=;
        b=IRnI0HP6EfLfyi+qAZTmR0qZT47zauhhB6EyV7B4ZmCdGigZMjtxJe5+cFE8D4xpFQVgxB
        oCzYv8CJjNHw3H3ES1++K70K3VVzHAC1v7NjZVG9kvYusaUjARBSqrHbG6eDZB0hm9j6LD
        Jt6lbWQO/vifQGgXcmKWHSHPpML+sXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635170965;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cKXaKvAGA7tQqZMva7lq9bNiBcDbYKs5HH6G4uyOqtc=;
        b=TD+GLnjRNLtEk5fANL9Yr99xH1nZms4MWmP4X7bqCQzxeCFHJPjuXLZxVVQOZkwPNyyyKC
        vH85Hm1LeHYRkaDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E44E1A3B89;
        Mon, 25 Oct 2021 14:09:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DA0C4DA7A9; Mon, 25 Oct 2021 16:08:54 +0200 (CEST)
Date:   Mon, 25 Oct 2021 16:08:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Diego Calleja <diegocg@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: btrfs.wiki.k.org and git-based update workflow
Message-ID: <20211025140854.GP20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Diego Calleja <diegocg@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20211022141200.GK20319@twin.jikos.cz>
 <12904812.uLZWGnKmhe@arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12904812.uLZWGnKmhe@arch>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 22, 2021 at 06:36:33PM +0200, Diego Calleja wrote:
> El viernes, 22 de octubre de 2021 16:12:00 (CEST) David Sterba escribió:
> > Current status is quite unpleasant, the number of active editors is 1
> > (me), with other occasional contributions. I somehow feel that the wiki
> > concept as community editing does not work, specifically for our wiki,
> > or maybe in general, anymore.
> 
> I would like to mention that I have tried to edit the wiki a couple of times
> along the years, and somehow I was not able to get an account,  log in, or
> recover my account (if I ever created one). Perhaps it's just me and others
> can use it just fine.

There were problems with the accounts, some people did not receive the
confirmation email. Otherwise there's some odd behaviour after login and
editing pages it suddenly drops to some local account (shown as address
10.220.*) and page is not updated. Such things get annoying.

> In any case, it's worth noticing that the ext4 and xfs wikis are in worse 
> shape, but with the improvements to the kernel doc infrastructure,
> at least ext4 maintains some great documentation there instead of at the
> wiki (eg https://www.kernel.org/doc/html/latest/filesystems/ext4/index.html)

I think docs in kernel tree are not suitable for user documentation, so
it's probably fine for some internal design docs or on-disk structure
description, but otherwise I'd rather have something not connected to
the kernel git tree, if not only because of the different release
schedule and update path.

> It is also worth noting that while the kernel wikis are not very active, lots 
> of semi-official content are generated in other places (eg the arch wiki).

I'm aware of that and see it as a problem. One part is the 'official'
and reliability level of the information. I've seen to much copy&paste
from similar sources just repeating old and invalid advice, or
mentioning bugs that have been fixed or some bad usecase suggestions
that could do damage.

The other part is that there _are_ active editors and people able to
publish good docs, but how to lure them to edit the main community
wiki? :)
