Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178E8374B45
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 May 2021 00:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhEEWdr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 May 2021 18:33:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:52236 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhEEWdr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 May 2021 18:33:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2A222B0D7;
        Wed,  5 May 2021 22:32:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7F3E7DB223; Thu,  6 May 2021 00:30:22 +0200 (CEST)
Date:   Thu, 6 May 2021 00:30:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs: zoned: sanity check zone type
Message-ID: <20210505223022.GQ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20210504083024.28072-1-johannes.thumshirn@wdc.com>
 <20210504083024.28072-2-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504083024.28072-2-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 04, 2021 at 10:30:23AM +0200, Johannes Thumshirn wrote:
> +		if (zone.type == BLK_ZONE_TYPE_CONVENTIONAL) {
> +			btrfs_err(fs_info,
> +				  "zoned: unexpected conventional zone: %llu on device %s (devid %llu)",

Message looks in line with others in zoned.c, I just noticed that this
also requires the rcu wrapper, ie. btrfs_err_in_rcu becausse
rcu_str_deref would complain.

> +				  zone.start << SECTOR_SHIFT,
> +				  rcu_str_deref(device->name), device->devid);
> +			ret = -EIO;
> +			goto out;
> +		}
> +
>  		switch (zone.cond) {
>  		case BLK_ZONE_COND_OFFLINE:
>  		case BLK_ZONE_COND_READONLY:
> -- 
> 2.31.1
