Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769403F97DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Aug 2021 12:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244774AbhH0KMe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Aug 2021 06:12:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60080 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244751AbhH0KMe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Aug 2021 06:12:34 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D45F020200;
        Fri, 27 Aug 2021 10:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630059104;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+OTgdgW2SrktEgxEy/9/egwkL2lOewLGrxED7wwzKE=;
        b=gqVc9R0Wjyw5KUZogMvZGKtLTdW6A0x1FLsKltrthLNVAy/f7NMMyiYTiyC7DtF9RUkfxL
        /2Lmz8d4LuDdHHOjrkcTs3hDw+FTmv+xIT3IHBJUvVMQUJlFQ/P9+E4I/jzsUZ1g0Hjtw0
        /crd7wbV3XflsE2fQQUybzMuLaX2URE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630059104;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+OTgdgW2SrktEgxEy/9/egwkL2lOewLGrxED7wwzKE=;
        b=FiHgB41Nfu+28SMCjBzVfN1e2UU7aUEbjm7834FjCdiF/35uUBjpfMy45J4AYp4GkfPzbg
        i2LfjHlLCV0flbCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B6800A3B91;
        Fri, 27 Aug 2021 10:11:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 347C7DA7F3; Fri, 27 Aug 2021 12:08:56 +0200 (CEST)
Date:   Fri, 27 Aug 2021 12:08:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Forza <forza@tnonline.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Support for compressed inline extents
Message-ID: <20210827100855.GV3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Forza <forza@tnonline.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <afa2742.c084f5d6.17b6b08dffc@tnonline.net>
 <20210822054549.GC29026@hungrycats.org>
 <1097af0f-fb9e-3c68-24b9-2232748ed77c@tnonline.net>
 <20210822083356.GE29026@hungrycats.org>
 <ca2452a6-3f5d-76df-e91b-dff2dcb53052@tnonline.net>
 <20210823202329.GG29026@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823202329.GG29026@hungrycats.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 23, 2021 at 04:23:29PM -0400, Zygo Blaxell wrote:
> On Mon, Aug 23, 2021 at 09:34:27PM +0200, Forza wrote:
> > Further up you showed that we can read encoded inlined data. What is missing
> > for that we can read encoded inlined data that decode to >page_size in size?
> 
> In uncompress_inline():
> 
> 	// decoded length of extent on disk...
> 	max_size = btrfs_file_extent_ram_bytes(leaf, item);
> 
> 	...
> 
> 	// ...can never be more than one page because of this line(*)
> 	max_size = min_t(unsigned long, PAGE_SIZE, max_size);
> 
> There might be further constraints around this code (e.g. the caller
> only fills in structures for one page, or doesn't bother to call this
> function at all for offsets above PAGE_SIZE).
> 
> All the restrictions would need to be removed in the kernel and support
> for reading multi-page inline extents added where necessary.  There would
> have to be an incompat bit on the filesystem to prevent old kernels from
> trying (and failing) to read longer inline extents.  The disk format is
> already technically capable of specifying a longer inline extent (up to
> min(UINT32_MAX, metadata_page_size)) but that was never the problem.

Regarding the idea of compressed inline extents, I'm not much in favor
of increasing the limit beyond one page (or sector). The metadata space
is more precious and that's also the motivation behind low default
max_inline. Another thing is mixing data and metadata with potentially
different block group profiles.

The inline files is IMO a nice little optimization and helps when the
size is below certain limit to avoid wasting data blocks and the
indirection.
