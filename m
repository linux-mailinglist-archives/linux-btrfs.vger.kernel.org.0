Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3221F692E
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 15:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgFKNkH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 09:40:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:49538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgFKNkH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 09:40:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 19682AE82;
        Thu, 11 Jun 2020 13:40:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A6EE8DA82A; Thu, 11 Jun 2020 15:39:59 +0200 (CEST)
Date:   Thu, 11 Jun 2020 15:39:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/15] btrfs-progs: introduce raid profile table for
 chunk allocation
Message-ID: <20200611133959.GN27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
 <20200610123258.12382-7-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610123258.12382-7-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 10, 2020 at 09:32:49PM +0900, Johannes Thumshirn wrote:
> Introduce a table holding the paramenters for chunk allocation per RAID
> profile.
> 
> Also convert all assignments of hardcoded numbers to table lookups in this
> process. Further changes will reduce code duplication even more.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  volumes.c | 95 +++++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 79 insertions(+), 16 deletions(-)
> 
> diff --git a/volumes.c b/volumes.c
> index 04bc3d19a025..fc14283db2bb 100644
> --- a/volumes.c
> +++ b/volumes.c
> @@ -1005,6 +1005,68 @@ error:
>  				- 2 * sizeof(struct btrfs_chunk))	\
>  				/ sizeof(struct btrfs_stripe) + 1)
>  
> +static const struct btrfs_raid_profile {
> +	int	num_stripes;
> +	int	max_stripes;
> +	int	min_stripes;
> +	int	sub_stripes;
> +} btrfs_raid_profile_table[BTRFS_NR_RAID_TYPES] = {
> +	[BTRFS_RAID_RAID10] = {
> +		.num_stripes = 0,
> +		.max_stripes = 0,
> +		.min_stripes = 4,
> +		.sub_stripes = 2,
> +	},
...

This duplicates btrfs_raid_array values, the member variable names don't
match so this makes it hard to compare. I wouldn't mind to create this
table as an intermediate step to clean up the code but in the end we
really don't want to keep btrfs_raid_profile, in the same file even.
