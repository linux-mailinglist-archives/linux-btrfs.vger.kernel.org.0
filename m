Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E46915FF48
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Feb 2020 17:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgBOQs4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Feb 2020 11:48:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgBOQs4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Feb 2020 11:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=slgBsI4plI94iOglVT4BsHYQjTMG4T3P89/fn56nl+8=; b=OjmTT9SpoP+ZZy51vrLmY0HZe4
        BP7bGgPSgL6rMxDwVBIJHdedsIknWJz6Yc4rhRK3WQBRLf9PVj+BX5IBPG+liXLRprFbG28KNABsT
        TmmPty01VDQCQXS7NsoYBAhMHztG6C2kUKnwbV10UkAQImuGVipe0P42f0AsJXcQBxZGH4OTpCogG
        WJVxsbayPM1qRbujQX1Qjam6rDvQ96geiJBRUTRbWLAaaW6hyhGJnkwdxX0uYUyWmwe6kacgaaCg6
        ZEk1LSPIlvAiXQAHuDDytWEgtgnd02Nr/tUOd7Jg0A6f6TKrMNOhRLOQpiBKe1b4BDLKr/D/bJs7H
        petUEZGQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j30ch-0006iS-VJ; Sat, 15 Feb 2020 16:48:55 +0000
Date:   Sat, 15 Feb 2020 08:48:55 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Missing unread page handling in readpages
Message-ID: <20200215164855.GH7778@bombadil.infradead.org>
References: <20200215051554.GF7778@bombadil.infradead.org>
 <CAL3q7H7Z182t+qKk4UcN0_10FEe9dEsVehUvtFb7YsLpMzibHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7Z182t+qKk4UcN0_10FEe9dEsVehUvtFb7YsLpMzibHw@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 15, 2020 at 11:16:46AM +0000, Filipe Manana wrote:
> On Sat, Feb 15, 2020 at 5:22 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> >
> > As part of my rewrite of the readahead code, I think I spotted a hole
> > in btrfs' handling of errors in the current readpages code.
> >
> > btrfs_readpages() calls extent_readpages() calls (a number of things)
> > then finishes up by calling submit_one_bio().  If submit_one_bio()
> > returns an error, I believe btrfs never unlocks the pages which were in
> > that bio.
> 
> So, the pages are unlocked at end_bio_extent_readpage().
> 
> The bio created by extent_readpages() (more specifically at
> __do_readpage()) has its ->bi_end_io set to end_bio_extent_readpage().
> Then submit_one_bio() calls btrfs_submit_bio_hook() or
> btree_submit_bio_hook(). When these functions return an error, they
> set the bio's ->bi_status to an error and then call bio_endio(), which
> results in end_bio_extent_readpage() being called, and that will
> unlock the pages, call SetPageError(), and do all necessary error
> handling.

Thanks!  I missed that call to bio_endio().  Now, the reason I started
down this track is that submit_one_bio() is marked as __must_check.
In the readahead code, there's really nothing to be done with an error.
So I can shut up the check by doing something like:

        if (bio) { 
                if (submit_one_bio(bio, 0, bio_flags)) 
                        return;
        }

but that's kind of crappy.  Can we acknowledge there is legitimately
nothing to do on an error for this user and remove the __must_check
from submit_one_bio()?
