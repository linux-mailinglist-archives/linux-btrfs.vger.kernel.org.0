Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DDA3D7174
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 10:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhG0Ish (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 04:48:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46372 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbhG0Isg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 04:48:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 64D1F1FE4C;
        Tue, 27 Jul 2021 08:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627375716;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kzXQTzvZ19SQpcjZGUaYl1m4UECT4FzjFnng4ZJVe0U=;
        b=DQl0oopbzM2xFD2+QTbaM7KeM8HKCvOVL+FnpyC6iQVGFcH2masxMSZHrYQpIStSEQhasJ
        jC7jIq1aO3APWIX44aPR1ebeCizK4efMdlabaoEUi9IgL+EsXvQT8HUjftZSlc8vrAdmS1
        v+fddxxCYXklWVH4XkGmfLQA/YKbOCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627375716;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kzXQTzvZ19SQpcjZGUaYl1m4UECT4FzjFnng4ZJVe0U=;
        b=moRQjEAUUApqnUN8kcjUQaQ7Kpo377NrZvMapa/DXOddcxyvMv+jkeoIqc+YfLktf+tSri
        GvyENxtQpKg03KBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5DA18A3B87;
        Tue, 27 Jul 2021 08:48:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2F8D0DA8CC; Tue, 27 Jul 2021 10:45:52 +0200 (CEST)
Date:   Tue, 27 Jul 2021 10:45:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 10/10] btrfs: add and use simple page/bio to
 inode/fs_info helpers
Message-ID: <20210727084552.GK5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1627300614.git.dsterba@suse.com>
 <4d3594dcca4dd8a8e58b134409922c2787b6a757.1627300614.git.dsterba@suse.com>
 <6cac34b2-39ba-f344-d601-b78a3f0c7698@gmx.com>
 <20210726150953.GG5047@twin.jikos.cz>
 <cc110ee1-c1bf-2b83-b5db-f70468b159f7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc110ee1-c1bf-2b83-b5db-f70468b159f7@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 06:26:47AM +0800, Qu Wenruo wrote:
> On 2021/7/26 下午11:09, David Sterba wrote:
> > On Mon, Jul 26, 2021 at 08:41:57PM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2021/7/26 下午8:15, David Sterba wrote:
> >>> We have lots of places where we want to obtain inode from page, fs_info
> >>> from page and open code the pointer chains.
> >>
> >> All those inode/fs_info grabbing from just a page is dangerous.
> >>
> >> If an anonymous page is passed in unintentionally, it can easily crash
> >> the system.
> >>
> >> Thus at least some ASSERT() here is a must to me.
> >
> > But we can only check if the pointer is valid, any page can have a valid
> > pointer but not our fs_info. If it crashes on an unexpected page than
> > what can we do in the code anyway?
> 
> What I mean is to check page->mapping for the page passed in.
> 
> Indeed we can't do anything when we hit a page with NULL mapping
> pointer, but that's a code bug.
> An ASSERT() would make us developer aware what's going wrong and to fix
> the bug.

The assert is a more verbose crash, so that's slightly more developer
friendly but I'm still not convinced it's worth the assert. Right now
the macros are not static inlines so they don't need full definitions of
page and mapping and the other types. Embedding the asserts into macros
would look like

  ({ ASSERT(page); ASSERT(page->mapping); page->mapping->host; })

Or perhaps also page with a temporary variable to avoid multiple
evaluations.

The helpers are used in a handful of places, if we really care about
consistency of the assertions, something like assert_page_ok(page) would
have to be in each function that gets the page from other subsystems.
