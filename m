Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631223F4F02
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 19:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhHWRJX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 13:09:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49252 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhHWRJU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 13:09:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 02A751FFCC;
        Mon, 23 Aug 2021 17:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629738517;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wkw7/ZAUft+GihjClVKjv7OQAI8DysG/ktO4yFg9bnc=;
        b=URUH7gz1HLQzLxPaupWAXrXUEGh5jr1zJ5FPni63Vyb1KQlGHv6D5j+/xZ65h+tywIJ2t/
        yyyshBNfvQm5hT11MYJ7LxvHJmqc8FBrHG8wSjPdjWDpQpA/I09RDZb5INPV9rbYXYjfoC
        SP1PimKvENDh06W+QCjpvnlaebChdl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629738517;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wkw7/ZAUft+GihjClVKjv7OQAI8DysG/ktO4yFg9bnc=;
        b=aTXuA6IF1T7m0ilbD66cQpU+Mi4ymXdwVBlGWY9sBvbN5LgvPdVgy9KRLjmYEfR6Qckjg7
        pmruqs3JKsbOBoBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F020FA3BBA;
        Mon, 23 Aug 2021 17:08:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 69697DA725; Mon, 23 Aug 2021 19:05:37 +0200 (CEST)
Date:   Mon, 23 Aug 2021 19:05:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: subpage: pack all subpage bitmaps into a
 larger bitmap
Message-ID: <20210823170537.GJ5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210817093852.48126-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817093852.48126-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 17, 2021 at 05:38:48PM +0800, Qu Wenruo wrote:
> Currently we use u16 bitmap to make 4k sectorsize work for 64K page
> size.
> 
> But this u16 bitmap is not large enough to contain larger page size like
> 128K, nor is space efficient for 16K page size.
> 
> To handle both cases, here we pack all subpage bitmaps into a larger
> bitmap, now btrfs_subpage::bitmaps[] will be the ultimate bitmap for
> subpage usage.
> 
> This is the first step towards more page size support.
> 
> Although to really enable extra page size like 16K and 128K, we need to
> rework the metadata alignment check.
> Which will happen in another patchset.
> 
> Changelog:
> v2:
> - Add two refactor patches to make btrfs_alloc_subpage() more readable
> - Fix a break inside two loops bug
> - Rename subpage_info::*_start to subpage_info::*_offset
> - Add extra comment on what each subpage_info::*_offset works
> 
> 
> Qu Wenruo (4):
>   btrfs: only call btrfs_alloc_subpage() when sectorsize is smaller than
>     PAGE_SIZE
>   btrfs: make btrfs_alloc_subpage() to return struct btrfs_subpage *
>     directly
>   btrfs: introduce btrfs_subpage_bitmap_info
>   btrfs: subpage: pack all subpage bitmaps into a larger bitmap

With a few fixups added to misc-next, thanks. I haven't tested it on
subpage config.
