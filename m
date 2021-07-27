Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8585A3D732E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbhG0K1E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:27:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38558 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236186AbhG0K1D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:27:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8DA7E22106;
        Tue, 27 Jul 2021 10:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627381622;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2J1vvQnuK4OxW13k6f1sOfNlJO798Dt9sJ4NL4uBUSs=;
        b=Zgulgd+kK/nUK4XPpBxarCoQWPEMlguGED6SLpwpgPIPmcO2YwhT9JC+ZUjoxgBhdRn61c
        MybPoYcD1TZ7a48g3Ryhq52yfv+35ytCZQjsrmzqcC4c8zvUPHOorqYfY2TBFs1kzBwYnO
        mCqcUVEgM3bACYMli6GblGe2cdTY+mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627381622;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2J1vvQnuK4OxW13k6f1sOfNlJO798Dt9sJ4NL4uBUSs=;
        b=E7+Rx9W5ZGysbYO6Ropusbd+/dHsJGNhqIgkSOKF7Y4VXdnr/t7dmkmzw+iH2sY7pt7bH6
        5xR9NqgeZmXfD5BA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 86D24A3B84;
        Tue, 27 Jul 2021 10:27:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4CE60DA8CC; Tue, 27 Jul 2021 12:24:18 +0200 (CEST)
Date:   Tue, 27 Jul 2021 12:24:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove the unused @start and @end parameter for
 btrfs_run_delalloc_range()
Message-ID: <20210727102417.GQ5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210727054132.164462-1-wqu@suse.com>
 <20210727101509.GP5047@twin.jikos.cz>
 <1c41b21e-4900-eab2-8f01-8e54245a570e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c41b21e-4900-eab2-8f01-8e54245a570e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 06:25:07PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/27 下午6:15, David Sterba wrote:
> > On Tue, Jul 27, 2021 at 01:41:32PM +0800, Qu Wenruo wrote:
> >> Since commit d75855b4518b ("btrfs: Remove
> >> extent_io_ops::writepage_start_hook") removes the writepage_start_hook()
> >> and added btrfs_writepage_cow_fixup() function, there is no need to
> >> follow the old hook parameters.
> >>
> >> This patch just remove the @start and @end hook, since currently the
> >> fixup check is full page check, it doesn't need @start and @end hook.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >
> > Then at least start can be removed from __extent_writepage_io too with
> > the following
> >
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -3828,9 +3828,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
> >                                   int *nr_ret)
> >   {
> >          struct btrfs_fs_info *fs_info = inode->root->fs_info;
> > -       u64 start = page_offset(page);
> > -       u64 end = start + PAGE_SIZE - 1;
> > -       u64 cur = start;
> > +       u64 cur = page_offset(page);
> > +       u64 end = cur + PAGE_SIZE - 1;
> >          u64 extent_offset;
> >          u64 block_start;
> >          struct extent_map *em;
> > ---
> >
> > There's no warning because start is set and used.
> >
> Awesome finding!
> 
> Will update the patch to also include this one.

Hold on, that's just a small fixup but I'm not yet sure about the
nrwritten removal correctness.
