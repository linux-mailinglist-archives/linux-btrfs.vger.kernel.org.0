Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4AF3BA103
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 15:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhGBNQ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 09:16:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58962 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhGBNQY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jul 2021 09:16:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 946E820566;
        Fri,  2 Jul 2021 13:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625231631;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZsAQmBcFPuP7ZfRETCDQsISvfzq2KIZ2ja4ebbd6bC8=;
        b=b98QOFA3zN2q0Xf14lWYp2/zNqrQM1Owv4j2nx/MoAvmLryb2pPlgbEWuah5mUIX7k+tzu
        tpcJ8nucq5oR1fxZ9tSecwfRPJSqGYNCZD+aSZG4F3FUldqs5jbtw04SeliU1UliUrkGsw
        8d2V4aJ8KctvdFQuA+MXAollG9N2Iws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625231631;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZsAQmBcFPuP7ZfRETCDQsISvfzq2KIZ2ja4ebbd6bC8=;
        b=4W3LE7+OHb18SeprKkYiTOdklX6JWpokRfaQMukC/uXd/toEruvqAtB+1tT2yeKDutb5xY
        Jt/pdRfH4Iw6ECCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8AABFA3B8C;
        Fri,  2 Jul 2021 13:13:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8200DDA6FD; Fri,  2 Jul 2021 15:11:20 +0200 (CEST)
Date:   Fri, 2 Jul 2021 15:11:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v3] btrfs: zoned: revert "btrfs: zoned: fail mount if the
 device does not support zone append"
Message-ID: <20210702131120.GG2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <2069666c4c5f68fafe0cfefdbc880fa6b4969217.1625225912.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2069666c4c5f68fafe0cfefdbc880fa6b4969217.1625225912.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 02, 2021 at 08:38:51PM +0900, Johannes Thumshirn wrote:
> Now that commit f34ee1dce642 ("dm crypt: Fix zoned block device support")
> is merged in master, the device-mapper code can fully emulate zone append.
> So there's no need for this check anymore.
> 
> This reverts commit 1d68128c107a ("btrfs: zoned: fail mount if the device
> does not support zone append").
> 
> Cc: Naohiro  Aota <naohiro.aota@wdc.com>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/zoned.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 297c0b1c0634..e4087a2364a2 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -354,13 +354,6 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>  	if (!IS_ALIGNED(nr_sectors, zone_sectors))
>  		zone_info->nr_zones++;
>  
> -	if (bdev_is_zoned(bdev) && zone_info->max_zone_append_size == 0) {

As it's using the max_zone_append_size it got removed as part of the
other patch "btrfs: zoned: remove max_zone_append_size logic".

This is a cleanup patch and I was not not considering it for 5.14 at the
moment but if this dm-crypt workaround gets removed I'll probably do
that.
