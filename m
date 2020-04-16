Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38AF1AC0EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 14:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635293AbgDPMTd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 08:19:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:46208 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635182AbgDPMTR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 08:19:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F30B7AC6D;
        Thu, 16 Apr 2020 12:19:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EC09BDA727; Thu, 16 Apr 2020 14:18:35 +0200 (CEST)
Date:   Thu, 16 Apr 2020 14:18:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Make btrfs_read_disk_super return struct
 btrfs_disk_super
Message-ID: <20200416121835.GI5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200416112608.8095-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416112608.8095-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 16, 2020 at 02:26:08PM +0300, Nikolay Borisov wrote:
> Instead of returning both the page and the super block structure, make
> btrfs_read_disk_super just return a pointer to struct btrfs_disk_super.
> As a result the function signature is simplified.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.

> @@ -1337,8 +1336,9 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
>  	if (IS_ERR(bdev))
>  		return ERR_CAST(bdev);
> 
> -	if (btrfs_read_disk_super(bdev, bytenr, &page, &disk_super)) {
> -		device = ERR_PTR(-EINVAL);
> +	disk_super = btrfs_read_disk_super(bdev, bytenr);
> +	if (IS_ERR(disk_super)) {
> +		device = disk_super;

With the ERR_CAST fixup.

>  		goto error_bdev_put;
>  	}
> 
> --
> 2.17.1
