Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE5746BE34
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 15:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbhLGO5R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 09:57:17 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45230 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLGO5Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 09:57:16 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D9E55218A8;
        Tue,  7 Dec 2021 14:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638888825;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/eEe6EbCI+acX/NcC+wasEBFe2FkoMl2I7jCe/DH7cA=;
        b=GaNjLZJgG6MccE7xGuttkoTDjZiz1jfSp1M+2TbpkDcpigo6Z5Ci4uUEdlFmB7l2BsbjJs
        BpioQsjC+HyCtU5+Ue1tPJOE5CaIEZ2CaflF8E+/b4O/FFuzsvJEh1UzVX9xKcgNo2bDCW
        ENqi9M2tUCIMRQibFjc8MAZ7pH0obr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638888825;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/eEe6EbCI+acX/NcC+wasEBFe2FkoMl2I7jCe/DH7cA=;
        b=r2oxQ8hUiozj27E53KArkSBCSSE0bPqGqLQKp4EhiTkHWQOZ569rmCXAkVZD73oOWLJcOe
        ozaR9QszSooT5YBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D2376A3B83;
        Tue,  7 Dec 2021 14:53:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D6C62DA799; Tue,  7 Dec 2021 15:53:30 +0100 (CET)
Date:   Tue, 7 Dec 2021 15:53:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Filipe Manana <fdmanana@kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] btrfs: remove the metadata readahead mechanism
Message-ID: <20211207145329.GW28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20211207074400.63352-1-wqu@suse.com>
 <Ya8/NpvxmCCouKqg@debian9.Home>
 <e019c8d6-4d59-4559-b56a-73dd2276903c@gmx.com>
 <Ya9L2qSe+XKgtesq@debian9.Home>
 <a91e60a4-7f5a-43eb-3c10-af2416aade9f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a91e60a4-7f5a-43eb-3c10-af2416aade9f@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 07, 2021 at 08:01:04PM +0800, Qu Wenruo wrote:
> On 2021/12/7 19:56, Filipe Manana wrote:
> > On Tue, Dec 07, 2021 at 07:43:49PM +0800, Qu Wenruo wrote:
> >> On 2021/12/7 19:02, Filipe Manana wrote:
> >>> On Tue, Dec 07, 2021 at 03:43:58PM +0800, Qu Wenruo wrote:
> >>>> This is originally just my preparation for scrub refactors, but when the
> >>>> readahead is involved, it won't just be a small cleanup.
> >>>>
> >>>> The metadata readahead code is introduced in 2011 (surprisingly, the
> >>>> commit message even contains changelog), but now only one user for it,
> >>>> and even for the only one user, the readahead mechanism can't provide
> >>>> much help in fact.
> >>>>
> >>>> Scrub needs readahead for commit root, but the existing one can only do
> >>>> current root readahead.
> >>>
> >>> If support for the commit root is added, is there a noticeable speedup?
> >>> Have you tested that?
> >>
> >> Will craft a benchmark for that.
> >>
> >> Although I don't have any HDD available for benchmark, thus would only
> >> have result from SATA SSD.

I'm doing some tests, in a VM on a dedicated HDD.
