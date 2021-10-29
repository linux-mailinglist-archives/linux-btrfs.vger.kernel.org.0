Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952B543FE26
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Oct 2021 16:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhJ2OOL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 10:14:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36014 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbhJ2OOC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 10:14:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A63D9218B5;
        Fri, 29 Oct 2021 14:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635516693;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0oRTQWHjL1RtGYkheghx2UVZL9ALbf1vkKjDXHi6rZI=;
        b=fLwYTSMAPHRF3j+dASrB2Vl4ciQhs3Rj6+6kkqn0p0JlMm2oKRZsJ1fd9LMH5FdKqB2QBc
        Pt5DTjisQVTj40a/nNyipu2d64OpO0pK5g307Gtazkji1KYbnZWtDTwNfq2uA1ZoqJu1hR
        yclUzEiEb4sX/+7bGgevNxWAoapN9WU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635516693;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0oRTQWHjL1RtGYkheghx2UVZL9ALbf1vkKjDXHi6rZI=;
        b=k413uCsPS9PVi5bgZA7O73v0I4b42rQungRrw2GHWBMM9eeWqjVoK+GSZHSAcDJN1MW8ky
        QtfASNXlu4gViNCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9F7BEA3B8F;
        Fri, 29 Oct 2021 14:11:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6898EDA7A9; Fri, 29 Oct 2021 16:11:00 +0200 (CEST)
Date:   Fri, 29 Oct 2021 16:11:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: use ilog2() to replace if () branches for
 btrfs_bg_flags_to_raid_index()
Message-ID: <20211029141059.GC20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211027052859.44507-1-wqu@suse.com>
 <20211027052859.44507-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027052859.44507-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 27, 2021 at 01:28:59PM +0800, Qu Wenruo wrote:
> +#define BTRFS_RAID_SHIFT	(ilog2(BTRFS_BLOCK_GROUP_RAID0) - 1)
> +
>  enum btrfs_raid_types {
> -	BTRFS_RAID_RAID10,
> -	BTRFS_RAID_RAID1,
> -	BTRFS_RAID_DUP,
> -	BTRFS_RAID_RAID0,
> -	BTRFS_RAID_SINGLE,
> -	BTRFS_RAID_RAID5,
> -	BTRFS_RAID_RAID6,
> -	BTRFS_RAID_RAID1C3,
> -	BTRFS_RAID_RAID1C4,
> +	BTRFS_RAID_SINGLE  = 0,
> +	BTRFS_RAID_RAID0   = ilog2(BTRFS_BLOCK_GROUP_RAID0 >> BTRFS_RAID_SHIFT),
> +	BTRFS_RAID_RAID1   = ilog2(BTRFS_BLOCK_GROUP_RAID1 >> BTRFS_RAID_SHIFT),
> +	BTRFS_RAID_DUP     = ilog2(BTRFS_BLOCK_GROUP_DUP >> BTRFS_RAID_SHIFT),
> +	BTRFS_RAID_RAID10  = ilog2(BTRFS_BLOCK_GROUP_RAID10 >> BTRFS_RAID_SHIFT),
> +	BTRFS_RAID_RAID5   = ilog2(BTRFS_BLOCK_GROUP_RAID5 >> BTRFS_RAID_SHIFT),
> +	BTRFS_RAID_RAID6   = ilog2(BTRFS_BLOCK_GROUP_RAID6 >> BTRFS_RAID_SHIFT),
> +	BTRFS_RAID_RAID1C3 = ilog2(BTRFS_BLOCK_GROUP_RAID1C3 >> BTRFS_RAID_SHIFT),
> +	BTRFS_RAID_RAID1C4 = ilog2(BTRFS_BLOCK_GROUP_RAID1C4 >> BTRFS_RAID_SHIFT),

Please use const_ilog2 in case all the terms in the expression are
constants that can be evaluated at the enum definition time.

I agree that deriving the indexes from the flags is safe but all the
magic around that scares me a bit.
