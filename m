Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554DD3D259E
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 16:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhGVNlK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 09:41:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54286 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbhGVNlG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 09:41:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 884CC2267B;
        Thu, 22 Jul 2021 14:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626963700;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vIpvj1ePFb55MShHENGLszn1uUoFKFjaQ3UhN3czTJ8=;
        b=Wta+6SX6qNxZMfeQ9zJf16b4oofr9KAQp8uUxnp6FJovbb5dOJfpCOVwD0/mTfcvHiFgSk
        73kWiMvFJJhGh3wDImOEUHI1RWfPdFXityIVQZCRGqaFBSJEbmwo8DXOFoACOQYroUvAzi
        wBhhIMAR81CGKyP6juZu0/2wZd2Ccaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626963700;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vIpvj1ePFb55MShHENGLszn1uUoFKFjaQ3UhN3czTJ8=;
        b=w5tbMxekbPqBI2XWAK2uq121PngfIj6f6J6hHxC2ihuBtQ3a9FGKMNZRK0RF+nb8snRBMj
        zcBtIk0dvHNPUxAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7FDCDA4EB3;
        Thu, 22 Jul 2021 14:21:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D81FADAF95; Thu, 22 Jul 2021 16:18:58 +0200 (CEST)
Date:   Thu, 22 Jul 2021 16:18:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: make __extent_writepage() not return error if the
 page is marked error
Message-ID: <20210722141858.GX19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210720114548.322356-1-wqu@suse.com>
 <e50266bf-db30-9387-9b1a-f3d042d5230a@toxicpanda.com>
 <d9024a88-f072-690e-d9d4-806e0135677e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9024a88-f072-690e-d9d4-806e0135677e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 22, 2021 at 05:18:19AM +0800, Qu Wenruo wrote:
> >> For subpage case, we can have multiple sectors inside a page, this makes
> >> it possible for __extent_writepage() to have part of its page submitted
> >> before returning.
> >>
> >> In btrfs/160, we are using dm-dust to emulate write error, this means
> >> for certain pages, we could have everything running fine, but at the end
> >> of __extent_writepage(), one of the submitted bios fails due to dm-dust.
> >>
> >> Then the page is marked Error, and we change @ret from 0 to -EIO.
> >>
> >> This makes the caller extent_write_cache_pages() to error out, without
> >> submitting the remaining pages.
> >>
> >> Furthermore, since we're erroring out for free space cache, it doesn't
> >> really care about the error and will update the inode and retry the
> >> writeback.
> >>
> >> Then we re-run the delalloc range, and will try to insert the same
> >> delalloc range while previous delalloc range is still hanging there,
> >> triggering the above error.
> >
> > This seems like the real bug.
> 
> That's true.
> 
> >  We should do the proper cleanup for the
> > range in this case, not ignore errors during writeback.  Thanks,
> 
> But if you change the view point, __extent_writepage() is only
> submitting the pages to bio.
> It shouldn't bother the bio error, but only care the error that affects
> the bio submission.
> 
> This PageError() check makes the behavior different between subpage and
> regular page size, thus this can be considered as a quick fix for subpage.
> 
> For a proper fix for both subpage and non-subpage case, I'm trying a
> completely different way, and will send out a RFC for comment later.

I tend to agree with Josef, the change is conunter intuitive. The proper
fix would be probably bigger than just a line removing the 'ret'
updates, so at least a comment explaining what's going on should be
there incase we decie to take this patch first.

I assume that for non-subpage case it's working as before.
