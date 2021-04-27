Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9133D36C8E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Apr 2021 17:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbhD0Ptn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 11:49:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:60440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhD0Ptn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 11:49:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0DC47B121;
        Tue, 27 Apr 2021 15:48:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D2E8FDA732; Tue, 27 Apr 2021 17:46:36 +0200 (CEST)
Date:   Tue, 27 Apr 2021 17:46:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 04/26] btrfs-progs: zoned: add new ZONED feature flag
Message-ID: <20210427154636.GK7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
 <c222a684214512e36fc721ee23ded5145bf9d89c.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c222a684214512e36fc721ee23ded5145bf9d89c.1619416549.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 26, 2021 at 03:27:20PM +0900, Naohiro Aota wrote:
> With the zoned feature enabled, a zoned block device-aware btrfs allocates
> block groups aligned to the device zones and always write in sequential
> zones at the zone write pointer position.
> 
> It also supports "emulated" zoned mode on a non-zoned device. In the
> emulated mode, btrfs emulates conventional zones by slicing the device with
> a fixed size.
> 
> We don't support conversion from the ext4 volume with the zoned feature
> because we can't be sure all the converted block groups are aligned to zone
> boundaries.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  common/fsfeatures.c        | 8 ++++++++
>  common/fsfeatures.h        | 3 ++-
>  kernel-shared/ctree.h      | 4 +++-
>  kernel-shared/print-tree.c | 1 +
>  4 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 569208a9e5b1..c0793339b531 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -100,6 +100,14 @@ static const struct btrfs_feature mkfs_features[] = {
>  		NULL, 0,
>  		NULL, 0,
>  		"RAID1 with 3 or 4 copies" },
> +#ifdef BTRFS_ZONED
> +	{ "zoned", BTRFS_FEATURE_INCOMPAT_ZONED,
> +		"zoned",
> +		NULL, 0,
> +		NULL, 0,
> +		NULL, 0,
> +		"support Zoned devices" },
> +#endif
>  	/* Keep this one last */
>  	{ "list-all", BTRFS_FEATURE_LIST_ALL, NULL }
>  };
> diff --git a/common/fsfeatures.h b/common/fsfeatures.h
> index 74ec2a21caf6..1a7d7f62897f 100644
> --- a/common/fsfeatures.h
> +++ b/common/fsfeatures.h
> @@ -25,7 +25,8 @@
>  		| BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
>  
>  /*
> - * Avoid multi-device features (RAID56) and mixed block groups
> + * Avoid multi-device features (RAID56), mixed block groups, and zoned
> + * btrfs
>   */
>  #define BTRFS_CONVERT_ALLOWED_FEATURES				\
>  	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF			\

Looks like BTRFS_FEATURE_INCOMPAT_ZONED should be here.
