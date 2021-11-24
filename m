Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1645D45CB0C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 18:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhKXRd1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 12:33:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58708 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbhKXRdK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 12:33:10 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ED4BA2191A;
        Wed, 24 Nov 2021 17:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637774998;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JJsxRuPiT/X7NNcrm5DThx0hXOWXE14RCqnxMMgr+IQ=;
        b=olSQPeA8UfWjLr/NKmgCA5VovoccyqNRCVZnz7GJVKuAyRRW/NBOaz5jmnCFeqJk9DdaVp
        N/5bd+dybsgcOckL7UsC2OsHqDO41TByZut5PzYgxMjXdeV4NkfWaSl6F0EWjaMZIFel7q
        qd8KJVDGA7x6gFDcPZ4s8V7ousGd5B8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637774998;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JJsxRuPiT/X7NNcrm5DThx0hXOWXE14RCqnxMMgr+IQ=;
        b=NFup356tQtM1imWa+kfRPpBHhXUcQ1p5SqVeeWzDdCFUkq+/zWuotlwTBPofWS8UfhOG3U
        xPC0RPOttN8wUrDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BF391A3B81;
        Wed, 24 Nov 2021 17:29:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0D518DA735; Wed, 24 Nov 2021 18:29:50 +0100 (CET)
Date:   Wed, 24 Nov 2021 18:29:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 03/21] btrfs: zoned: sink zone check into
 btrfs_repair_one_zone
Message-ID: <20211124172950.GU28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
 <8c38c2f9d1bee46ded4ec491e16398f2f5764200.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c38c2f9d1bee46ded4ec491e16398f2f5764200.1637745470.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 24, 2021 at 01:30:29AM -0800, Johannes Thumshirn wrote:
> Sink zone check into btrfs_repair_one_zone() so we don't need to do it in
> all callers.
> 
> Also as btrfs_repair_one_zone() doesn't return a sensible error, just
> make it a void function.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/extent_io.c |  3 +--
>  fs/btrfs/scrub.c     |  4 ++--
>  fs/btrfs/volumes.c   | 13 ++++++++-----
>  fs/btrfs/volumes.h   |  2 +-
>  4 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1654c611d2002..96c2e40887772 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2314,8 +2314,7 @@ static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
>  	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
>  	BUG_ON(!mirror_num);
>  
> -	if (btrfs_is_zoned(fs_info))
> -		return btrfs_repair_one_zone(fs_info, logical);
> +	btrfs_repair_one_zone(fs_info, logical);

This changes the flow, is that intended? Previously in zoned mode the
function would end here and won't go down to allocate bio etc, now it
would.

>  	bio = btrfs_bio_alloc(1);
>  	bio->bi_iter.bi_size = 0;
