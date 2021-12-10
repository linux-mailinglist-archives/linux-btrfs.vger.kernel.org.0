Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EBD470056
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Dec 2021 12:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbhLJLx5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Dec 2021 06:53:57 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47566 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbhLJLxz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Dec 2021 06:53:55 -0500
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out2.suse.de (Postfix) with ESMTP id D2C1B1F387;
        Fri, 10 Dec 2021 11:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639137019;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OCsq5pT5Azw+v4Pmrowio5eIjlfN22z9PSVDV2kfaYg=;
        b=m4lPhHB8H1s3FXcXAK4nNA/HVeBx7KqCd27+0/VIohFEuoI8nMQ0LKEIxqRwL5GIHoFyA0
        r+8O9bHRUoh05j3tDIqyKogFZ8XkCfvsBPvcQE3YmnPonSg67/o244+XNhzFa/4sCE7lWo
        zj4a4LJNXjaQDS3pDg4SnIFuo5Pi5bw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639137019;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OCsq5pT5Azw+v4Pmrowio5eIjlfN22z9PSVDV2kfaYg=;
        b=QflEKKR3XgCRPQP+jvUZ2aij93uOxHBryU1jjJcL0jfY7vT2P74mtc2HfYWwJMIlSKPXcu
        PjrlVvLtgxvPiUDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id 9B9BF25CB4;
        Fri, 10 Dec 2021 11:50:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 08F1FDA799; Fri, 10 Dec 2021 12:44:32 +0100 (CET)
Date:   Fri, 10 Dec 2021 12:44:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-btrfs@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] btrfs: zoned: fix leak of zone_info in
 btrfs_get_dev_zone_info
Message-ID: <20211210114432.GO28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-btrfs@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <8a54e85cf93d2042f1a2e29517f8f91fce56f6ab.1639135880.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a54e85cf93d2042f1a2e29517f8f91fce56f6ab.1639135880.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 10, 2021 at 03:32:00AM -0800, Johannes Thumshirn wrote:
> Some error paths of  btrfs_get_dev_zone_info do not free zone_info,
> so assign zone_info to device->zone_info as soon as we've successfully
> allocated it, so it wiill get freed by the error handling.
> 
> a411e32badc4 ("btrfs: zoned: cache reported zone during mount")

As this patch is still in misc-next I'll fold the fixup, thanks.
