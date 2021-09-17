Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BB340F6CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 13:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241905AbhIQLlD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 07:41:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48078 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbhIQLlD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 07:41:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5640D22412;
        Fri, 17 Sep 2021 11:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631878780;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q5L9sCXcBGekSpBU3LtR+k1FtWqhK+L5ARWqF7dvTAg=;
        b=kgBLOfcyXop1Hv6YrCgJk74PBnGp9yR7KRXQsm56JiuO7wYmPgo7K5RhRMjUwRSCj9ZD8p
        +Q92nuDFoWtj6a42IR12XM4wCSVkQJMR4gAMAv/4vrJrj9VCm3OAyiFlG0g7rAV+AKutra
        uwgc70a1/279dO63jjIe1rD7ELGbYbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631878780;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q5L9sCXcBGekSpBU3LtR+k1FtWqhK+L5ARWqF7dvTAg=;
        b=2g3yiUjO16PrreZZ4kFsx0Ed3xkHpKIwhsjX68WHdXCgDQr/PeWdcMXXuvE3BHAILqieFp
        ML9a8oeoyZYYmMBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4EEADA3B93;
        Fri, 17 Sep 2021 11:39:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C021BDA781; Fri, 17 Sep 2021 13:39:30 +0200 (CEST)
Date:   Fri, 17 Sep 2021 13:39:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/3]  btrfs: btrfs_bio and btrfs_io_bio rename
Message-ID: <20210917113930.GR9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210915071718.59418-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915071718.59418-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 15, 2021 at 03:17:15PM +0800, Qu Wenruo wrote:
> The branch can be fetched from github, and is the preferred way to grab
> the code, as this patchset changed quite a lot of code.
> https://github.com/adam900710/linux/tree/chunk_refactor
> 
> There are two structure, btrfs_io_bio and btrfs_bio, which have very
> similar names but completely different meanings.
> 
> Btrfs_io_bio mostly works at logical bytenr layer (its
> bio->bi_iter.bi_sector points to btrfs logical bytenr), and just
> contains extra info like csum and mirror_num.
> 
> And btrfs_io_bio is in fact the most utilized bio, as all data/metadata
> IO is using btrfs_io_bio.
> 
> While btrfs_bio is completely a helper structure for mirrored IO
> submission (utilized by SINGLE/DUP/RAID1/RAID10), and contains RAID56
> maps for RAID56 (it doesn't utilize this structure for IO submission
> tracking).
> 
> Such naming is completely anti-human.
> 
> So this patchset will do the following renaming:
> 
> - btrfs_bio -> btrfs_io_context
>   Since it's not really used by all bios (only mirrored profiles utilize
>   it), and it contains extra info for RAID56, it's not proper to name it
>   with _bio suffix.
> 
>   Later we can integrate btrfs_io_context pointer into the new
>   btrfs_bio.
> 
> - btrfs_io_bio -> btrfs_logical_bio
>   It is intentional not to reuse "btrfs_bio", which could cause
>   confusion for later backport.
> 
> Changelog:
> v2:
> - Rename btrfs_bio to btrfs_io_context (bioc)
> - Rename btrfs_io_bio to btrfs_bio
>   Both suggested by Nikolay
> 
> v3:
> - Fixes whiespace problems
>   Caused by "dwi" vim commands
> 
> - Update several modified comments
> 
> - Rename btrfs_io_bio to btrfs_logical_bio
>   To avoid backport confusion.
> 
> Qu Wenruo (3):
>   btrfs: rename btrfs_bio to btrfs_io_context
>   btrfs: remove btrfs_bio_alloc() helper
>   btrfs: rename struct btrfs_io_bio to btrfs_logical_bio

Added to misc-next, thanks.
