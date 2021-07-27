Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E2F3D786B
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 16:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhG0O0Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 10:26:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48022 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbhG0O0X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 10:26:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E0BEB221E7;
        Tue, 27 Jul 2021 14:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627395982;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HC5ONAg2yYRZt2zW9acSUEGmX3FDz45BOcTIByRSZG8=;
        b=EjBTK/xYJh2pUZ+nTQiXYIdlMErjE0SQP9RVh1bQduE9NdjhWWBg83CfSKMtvDu6fzDkqU
        /dwoVfzMBFyQ0xy5aMJNLlf771g30bIaCXcwixsPyMA7FSCgXk0jMVieiD7yVFyu2cTe27
        ipStDls/PrwR65iLAEGS6NDC1ooPGiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627395982;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HC5ONAg2yYRZt2zW9acSUEGmX3FDz45BOcTIByRSZG8=;
        b=YWAJMlp8oZ4T8PsK1yJ1ZFPpE/B32MNShDxs2rHk6LIi5nSbKWzBw94S8bsp9wzezZo8bS
        1jz2bpWnZn+ZGnDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DB930A3B92;
        Tue, 27 Jul 2021 14:26:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5720DDA8CC; Tue, 27 Jul 2021 16:23:38 +0200 (CEST)
Date:   Tue, 27 Jul 2021 16:23:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: change the set_page_extent_mapped() call into an
 ASSERT()
Message-ID: <20210727142338.GR5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210727013942.83531-1-wqu@suse.com>
 <68e6284c-3bac-8fb8-af82-1f717bffd3dc@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68e6284c-3bac-8fb8-af82-1f717bffd3dc@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 06:29:08PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/27 上午9:39, Qu Wenruo wrote:
> > Btrfs uses set_page_extent_mapped() to properly setup a page.
> > 
> > That function would set PagePrivate, and populate needed structure for
> > subpage.
> > The timing of calling set_page_extent_mapped() happens before reading a
> > page or dirtying a page.
> > Thus when we got a page to write back, if it doesn't have PagePrivate,
> > it is a big problem in code logic.
> > 
> > Calling set_page_extent_mapped() for such page would just mask the
> > problem.
> > Furthermore, for subpage case, we call subpage error helper to clear the
> > page error bit before calling set_page_extent_mapped().
> > If we really got a page without Private bit, it can call kernel NULL
> > pointer dereference.
> > 
> > So change the set_page_extent_mapped() call to an ASSERT(), and move the
> > check before any page status update call.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Please discard the patch.
> 
> Although I haven't hit any problem testing the patch, it's still 
> possible that we have a special page that would need cow fixup.
> 
> Such page will be:
> 
> - Dirty
> 
> - Not Private
>    Thus no page->private, this could still cause problem for subpage case
>    though
> 
> - No EXTENT_DELALLOC flags set for any range inside the page
>    Thus writepage_delalloc() will not find a delalloc range inside the
>    page.
> 
> Such page will be caught by btrfs_writepage_cow_fixup(), but it will 
> trigger the ASSERT() added by this patch.

Hm yeah the mismatch between dirty/private/delalloc sounds exactly like
work for the cow fixup.
