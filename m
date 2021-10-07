Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2A94251A9
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Oct 2021 13:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbhJGLGW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Oct 2021 07:06:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60968 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbhJGLGU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Oct 2021 07:06:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B33E0200AB;
        Thu,  7 Oct 2021 11:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633604666;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=crTA1ok5yHBVlIgMxkj0lTE8NoOc30MPW7Om4Hg6OmU=;
        b=M1F6JHAWOGZylYImUKqixtZ9m0Lf+zgaN9jgY3zW+Z+HRiRPvD0QiTVqMPwunvdqgJuE2N
        T108bgyieLWo58CiygpD4cNyusvPibcWL+n1+TCFBl1S0AtpUelkdpdZctV2SnXkIsJqhq
        l2b1NQTKm50dWXKLBOA7HWdU6iK7zjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633604666;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=crTA1ok5yHBVlIgMxkj0lTE8NoOc30MPW7Om4Hg6OmU=;
        b=z/FS1bKSYtOq13FEE+QUvzT8hrqqSsqyTYMGHjyyIbhALL1Ov/lmt3B1TUhQQKZrmSd1CZ
        RZYXin/P+Y2OY6Ag==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AC83EA3B8E;
        Thu,  7 Oct 2021 11:04:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EB2EADA7F3; Thu,  7 Oct 2021 13:04:05 +0200 (CEST)
Date:   Thu, 7 Oct 2021 13:04:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] btrfs: refactor how we handle btrfs_io_context
 and slightly reduce memory usage for both btrfs_bio and btrfs_io_context
Message-ID: <20211007110405.GZ9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210922082706.55650-1-wqu@suse.com>
 <20211006193826.GX9286@twin.jikos.cz>
 <945ebdbf-658e-5a36-87d8-9367e2f9a005@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <945ebdbf-658e-5a36-87d8-9367e2f9a005@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 07, 2021 at 10:24:27AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/10/7 03:38, David Sterba wrote:
> > On Wed, Sep 22, 2021 at 04:27:03PM +0800, Qu Wenruo wrote:
> >> Currently btrfs_io_context is utilized as both bio->bi_private for
> >> mirrored stripes, and stripes mapping for RAID56.
> >>
> >> This makes some members like btrfs_io_context::private to be there.
> >>
> >> But in fact, since almost all bios in btrfs have btrfs_bio structure
> >> appended, we don't really need to reuse bio::bi_private for mirrored
> >> profiles.
> >>
> >> So this patchset will:
> >>
> >> - Introduce btrfs_bio::bioc member
> >>    So that btrfs_io_context don't need to hold @private.
> >>    This modification is still a net increase for memory usage, just
> >>    a trade-off between btrfs_io_context and btrfs_bio.
> >>
> >> - Replace btrfs_bio::device with btrfs_bio::stripe_num
> >>    This reclaim the memory usage increase for btrfs_bio.
> >>
> >>    But unfortunately, due to the short life time of btrfs_io_context,
> >>    we don't have as good device status accounting as the old code.
> >>
> >>    Now for csum error, we can no longer distinguish source and target
> >>    device of dev-replace.
> >>
> >>    This is the biggest blockage, and that's why it's RFC.
> >>
> >> The result of the patchset is:
> >>
> >> btrfs_bio:		size: 240 -> 240
> >> btrfs_io_context:	size: 88 -> 80
> >>
> >> Although to really reduce btrfs_bio, the main target should be
> >> csum_inline.
> >>
> >> Qu Wenruo (3):
> >>    btrfs: add btrfs_bio::bioc pointer for further modification
> >>    btrfs: remove redundant parameters for submit_stripe_bio()
> >>    btrfs: replace btrfs_bio::device member with stripe_num
> >
> > Can you please refresh the patchset on top current misc-next?
> >
> 
> Please discard the patchset for now.
> 
> Unfortunately I have found one critical member abuses making such
> refactor unfeasible (at least for now).
> 
> - btrfs_bio::logical abuse
>    Direct IO uses btrfs_bio::logical as file_offset, while no other
>    call sites really utilize btrfs_bio::logical at all.
> 
>    This means, we can't simply rely on btrfs_map_bio() to verify if
>    btrfs_bio::logical is correctly initialized.
> 
>    This is a big alert, if we can't do ASSERT() to verify if one member
>    is properly initialized, then it's just going to happen.
> 
>    This also means, for direct IO, we can't use @mirror_num with @logical
>    to grab the device with IO failure.
> 
> So for now, although it may save 8 bytes, unless we solve the DIO mess,
> we can't continue.

Ok, thanks.
