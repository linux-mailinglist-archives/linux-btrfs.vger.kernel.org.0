Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C115D2CA967
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Dec 2020 18:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgLARSm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Dec 2020 12:18:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:53736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgLARSl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Dec 2020 12:18:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE518AF06;
        Tue,  1 Dec 2020 17:18:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A511ADA6E1; Tue,  1 Dec 2020 18:16:28 +0100 (CET)
Date:   Tue, 1 Dec 2020 18:16:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: mkfs: refactor how we handle sectorsize
 override
Message-ID: <20201201171628.GN6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201013010602.11605-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013010602.11605-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 13, 2020 at 09:06:02AM +0800, Qu Wenruo wrote:
> There are several problems for current sectorsize check:
> - No check at all for sectorsize
>   This means you can even specify "-s 62k".
> 
> - No way to specify sectorsize smaller than page size
> 
> Fix all these problems by:
> - Introduce btrfs_check_sectorsize()
>   To do:
>   * power of 2 check for sectorsize
>   * lower and upper boundary check for sectorsize
>   * warn about sectorsize mismatch with page size
> 
> - Remove the max() between page size and sectorsize
>   This allows us to override the sectorsize for 64K page systems.
> 
> - Make nodesize calculation based on sectorsize
>   No need to use page size any more.
>   Users who specify sectorsize manually really know what they are doing,
>   and we have warned them already.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

> +int btrfs_check_sectorsize(u32 sectorsize)
> +{
> +	u32 page_size = (u32)sysconf(_SC_PAGESIZE);
> +
> +	if (!is_power_of_2(sectorsize)) {
> +		error("illegal sectorsize %u, expect value power of 2",
> +		      sectorsize);
> +		return -EUCLEAN;

This should be EINVAL, updated

> +	}
> +	if (sectorsize < SZ_4K || sectorsize > SZ_64K) {
> +		error("illegal sectorsize %u, expect range [4K, 64K]",
> +		      sectorsize);
> +		return -EUCLEAN;
> +	}
> +	if (page_size != sectorsize)
> +		warning(
> +"the fs may not be mountable, sectorsize %u doesn't match page size %u",
> +			sectorsize, page_size);
> +	return 0;
> +}
