Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBF03D587A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 13:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhGZKrr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 06:47:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52182 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhGZKrr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 06:47:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 26E221FD4B;
        Mon, 26 Jul 2021 11:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627298895;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8G9NG5Jkw//WXn01eQ8Bdg5Vu1Cye3ki4bF9raXI720=;
        b=Tq94JmMy+bmPae3pW56Kuqn4NBLiMZliFpD5tFW5wMEp5o97GqtkP3O/+p5sgnJ5fLur9S
        YJ+vv1iw17CVS1xq5I74OWIyhKm/DenbYOiqb6u5Fdbv+I2l3LRblpkEhXWW4O/b37MhD7
        77BzyFuJg5NA1ztC1LM6qBMFYLOb8Ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627298895;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8G9NG5Jkw//WXn01eQ8Bdg5Vu1Cye3ki4bF9raXI720=;
        b=CWy7bGv9lD1YDQno6bNvPgaa+bsR+u1CrmQlbzsP2wD7WgBzRtpHxQgL1K6FWFdXHuWmuD
        L3u7nXG7snQdXyBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1D9C6A4F38;
        Mon, 26 Jul 2021 11:28:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 647D4DA8CA; Mon, 26 Jul 2021 13:25:31 +0200 (CEST)
Date:   Mon, 26 Jul 2021 13:25:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: cmds: Fix build for using NAME_MAX
Message-ID: <20210726112531.GC5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        Sidong Yang <realwakka@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210724074642.68771-1-realwakka@gmail.com>
 <2305182b-1e12-df9c-320c-7a7eedba860d@gmx.com>
 <20210724082356.GA68829@realwakka>
 <czr7w180.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <czr7w180.fsf@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 25, 2021 at 10:54:05AM +0800, Su Yue wrote:
> 
> On Sat 24 Jul 2021 at 16:23, Sidong Yang <realwakka@gmail.com> 
> wrote:
> 
> > On Sat, Jul 24, 2021 at 03:50:25PM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2021/7/24 下午3:46, Sidong Yang wrote:
> >> > There is some code that using NAME_MAX but it doesn't include 
> >> > header
> >> > that is defined. This patch adds a line that includes 
> >> > linux/limits.h
> >> > which defines NAME_MAX.
> >>
> >> I guess it's related to this issue?
> >>
> >> https://github.com/kdave/btrfs-progs/issues/386
> >
> > Yeah, It seems that there is no patch for this yet. So I sent 
> > this
> > patch. Is this too minor patch?
> >
> Good fix. But there is one PR before the issue creation:
> https://github.com/kdave/btrfs-progs/pull/385

Ah I got an email about the musl failure but was not able to find it so
I created #386 to keep track of it. While the pull request comes with a
patch it should really be linux/limits.h because it's a linux-specific
limit. Including limits.h also works but I'd prefer to pull the one that
defines it.
