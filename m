Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C950D3F613A
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 17:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbhHXPD5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 11:03:57 -0400
Received: from twin.jikos.cz ([91.219.245.39]:53581 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237850AbhHXPD5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 11:03:57 -0400
X-Greylist: delayed 2543 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Aug 2021 11:03:56 EDT
Received: from twin.jikos.cz (dave@localhost [127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id 17OEKesL020440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 24 Aug 2021 16:20:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=jikos.cz; s=twin;
        t=1629814841; bh=5oC3j61GgfVtana9NgmpGjiH+IXnwg7m16uQTDBjP40=;
        h=Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:
         Mail-Followup-To:References:MIME-Version:Content-Type:
         Content-Disposition:In-Reply-To:User-Agent; b=5goMg8HFPfij943WgCqD
        eGv8IZ0QGHRiRCSxEhlay1XbG749oU9IecUy6hczA1rcpze5QaWrt3O+BBFwoS++DBE
        a3sx7cheQSTtjdUtvWHakqV3+x0V+ZCxovN2UJi+d61jkbqoaoHRQ5mtOsq7Vh0o/no
        t7zDzRLvRaMIKcDd8=
Received: (from dave@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) id 17OEKens020438;
        Tue, 24 Aug 2021 16:20:40 +0200
Date:   Tue, 24 Aug 2021 16:20:40 +0200
From:   David Sterba <dave@jikos.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 4/4] btrfs: subpage: pack all subpage bitmaps into a
 larger bitmap
Message-ID: <20210824142040.GC24212@twin.jikos.cz>
Reply-To: dave@jikos.cz
Mail-Followup-To: Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210817093852.48126-1-wqu@suse.com>
 <20210817093852.48126-5-wqu@suse.com>
 <20210823165746.GH5047@twin.jikos.cz>
 <4a9947e2-f92f-0b69-01e5-67cc8dc5bea5@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a9947e2-f92f-0b69-01e5-67cc8dc5bea5@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 24, 2021 at 07:16:49AM +0800, Qu Wenruo wrote:
> >>   	spin_lock_irqsave(&subpage->lock, flags);
> >> -	subpage->uptodate_bitmap |= tmp;
> >> -	if (subpage->uptodate_bitmap == U16_MAX)
> >> +	bitmap_set(subpage->bitmaps, start_bit,
> >> +		   len >> fs_info->sectorsize_bits);
> >
> > All the bitmap_* calls like this and the parameter fit one line.
> >
> But that's over 80 chars.
> 
> I understand now our standard no longer requires 80 chars as hard limit,
> but isn't it seill recommended to keep inside the 80 chars limit?

If a slight overflow does not harm readability, like if word
'sectorsize' crosses 80 chars by like 4  I take it as reasonable and
join the lines if I see it. The 80 char limit is still there, because
merging patches sometimes requires 3 files next to each other so that is
really helpful.

As a visual clue where's the 80 boundary I have the following in .vimrc

let &colorcolumn="81,91,101,+0"

the +0 is for textwidth setting.
