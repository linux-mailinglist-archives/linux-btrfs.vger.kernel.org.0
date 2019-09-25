Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3AA8BDF97
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 16:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407156AbfIYOAC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 10:00:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:54850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407066AbfIYOAC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 10:00:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41C3AAE89;
        Wed, 25 Sep 2019 14:00:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8D4B8DA835; Wed, 25 Sep 2019 16:00:21 +0200 (CEST)
Date:   Wed, 25 Sep 2019 16:00:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Murphy <lists@colorremedies.com>
Subject: Re: [PATCH] btrfs: Fix a regression which we can't convert to SINGLE
 profile
Message-ID: <20190925140021.GH2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Chris Murphy <lists@colorremedies.com>
References: <20190925021327.90095-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925021327.90095-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 25, 2019 at 10:13:27AM +0800, Qu Wenruo wrote:
> [BUG]
> With v5.3 kernel, we just can't convert to SINGLE profile by all means:
>   # btrfs balance start -f -dconvert=single $mnt
>   ERROR: error during balancing '/mnt/btrfs': Invalid argument
>   # dmesg -t | tail
>   validate_convert_profile: data profile=0x1000000000000 allowed=0x20 is_valid=1 final=0x1000000000000 ret=1
>   BTRFS error (device dm-3): balance: invalid convert data profile single
> 
> [CAUSE]
> With the extra debug output added, it shows that the @allowed bit is
> lacking the special in-memory only SINGLE profile bit.
> 
> Thus we fail at that (profile & ~allowed) check.
> 
> This regression is caused by commit 081db89b13cb ("btrfs: use raid_attr
> to get allowed profiles for balance conversion") and the fact that we
> don't use any bit to indicate SINGLE profile on-disk, but uses special
> in-memory only bit to help distinguish different profiles.
> 
> [FIX]
> Add that BTRFS_AVAIL_ALLOC_BIT_SINGLE to @allowed, so the code should be
> the same as it was and fix the regression.
> 
> Reported-by: Chris Murphy <lists@colorremedies.com>
> Fixes: 081db89b13cb ("btrfs: use raid_attr to get allowed profiles for balance conversion")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
