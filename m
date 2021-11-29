Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650DE461BA4
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 17:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344810AbhK2QSk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 11:18:40 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52126 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345410AbhK2QQk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 11:16:40 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6D7C91FCA1;
        Mon, 29 Nov 2021 16:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638202401;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rScVNxr4TVVnzusXkesoEKZZv5Q1aX4f/dKE5XP6q9c=;
        b=NTUHWH+tTUCSSrKe/soToE2DHJLnM3p0QqTYCB0AwpXSrMCyd6edcnqchWtTpCTa5syNVy
        NvNovnqlRSjxB+G/JsTH6DC17iydqeYPBbpAZMDzhPISqQgDwnXkMifZ81f5mRD+SEh9LH
        Fc4TJRX+5LUaaJOSE3lLb8PiMDHb0Dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638202401;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rScVNxr4TVVnzusXkesoEKZZv5Q1aX4f/dKE5XP6q9c=;
        b=f20q2Bc2DxqbbvaIvBu8b3E1YVjU3vt0yGrJ4QXEyo8+sVtHvUriNdL6VF8Od+UazIWLmV
        N3lLTYcGXEq9UpCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 663E6A3B83;
        Mon, 29 Nov 2021 16:13:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0C410DA735; Mon, 29 Nov 2021 17:13:10 +0100 (CET)
Date:   Mon, 29 Nov 2021 17:13:10 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Btrfs fixes for 5.16-rc3
Message-ID: <20211129161310.GE28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1637940049.git.dsterba@suse.com>
 <CAHk-=wia6jNRQDm51wNf2X2cNGeN+5Uz3DWQ2bgnGyVRK4LRJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wia6jNRQDm51wNf2X2cNGeN+5Uz3DWQ2bgnGyVRK4LRJA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 26, 2021 at 12:48:15PM -0800, Linus Torvalds wrote:
> On Fri, Nov 26, 2021 at 7:42 AM David Sterba <dsterba@suse.com> wrote:
> >
> > one more fix to the lzo code, a missing put_page causing memory leaks
> > when some error branches are taken.
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.16-rc2-tag
> 
> Hmm.
> 
> pr-tracker-bot didn't react to this one, and it wasn't obvious why.
> 
> Until I started looking closer. You claim:
> 
> > for you to fetch changes up to 504d851ab360dc00e2163acef2e200ea69ac800a:
> >
> >   btrfs: fix the memory leak caused in lzo_compress_pages() (2021-11-26 14:32:40 +0100)
> 
> but in fact it's commit daf87e953527, not as the pull request claims
> 504d851ab360..
> 
> And no, it's not the tag either, that was d0a295f521e2.
> 
> The diffstat and the shortlog matched, so I had pulled it without
> noticing. But something went wrong in there in the pull request.

Possible explanation: I had problems pushing to k.org repo from work
machine (ssh timeout, fetching worked) so I pushed it from a different
one. The branch to pull was recreated from the same commit, with id
daf87e953527b03c0b and pushed to k.org but I must have kept the previous
for-5.16-rc2 branch without update when preparing the pull request mail.
