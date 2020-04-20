Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36091B19D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 00:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgDTW5d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 18:57:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:56794 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgDTW5d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 18:57:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D6236AD94;
        Mon, 20 Apr 2020 22:57:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 626ADDA72D; Tue, 21 Apr 2020 00:56:50 +0200 (CEST)
Date:   Tue, 21 Apr 2020 00:56:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, osandov@osandov.com
Subject: Re: [PATCH v3] btrfs-progs: Remove support for
 BTRFS_SUBVOL_CREATE_ASYNC
Message-ID: <20200420225650.GJ18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, osandov@osandov.com
References: <20200402123147.18894-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402123147.18894-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 02, 2020 at 03:31:47PM +0300, Nikolay Borisov wrote:
> Kernel has removed support for this feature in 5.7 so let's remove
> support from progs as well.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> ---
> Changelog V3:
>  * Deleted unnecessary function documentation (Omar)
>  * Decapitalize some words (Omar)
> 
> Changelog v2:
>  * Removed async mentions in README.md
>  * Changed docs in libbtrfsutil/btrfsutil.h to mention async is unused.
>  * Removed tests using async_
>  * Changed python module's doc to mention the async_ parameter is unused.
>  ioctl.h                                     |  4 +--
>  libbtrfsutil/README.md                      | 14 ++------
>  libbtrfsutil/btrfs.h                        |  4 +--
>  libbtrfsutil/btrfsutil.h                    | 23 +++++--------
>  libbtrfsutil/python/module.c                |  6 ++--
>  libbtrfsutil/python/tests/test_subvolume.py | 12 ++-----
>  libbtrfsutil/subvolume.c                    | 38 ++++++---------------
>  7 files changed, 29 insertions(+), 72 deletions(-)
> 
> diff --git a/ioctl.h b/ioctl.h
> index ade6dcb91044..b63391f904c4 100644
> --- a/ioctl.h
> +++ b/ioctl.h
> @@ -49,15 +49,13 @@ BUILD_ASSERT(sizeof(struct btrfs_ioctl_vol_args) == 4096);
> 
>  #define BTRFS_DEVICE_PATH_NAME_MAX 1024
> 
> -#define BTRFS_SUBVOL_CREATE_ASYNC	(1ULL << 0)

We got the report that removing the symbol breaks compilation, and ioctl.h is
exported to libbtrfs. I'm not aware of any 3rd party tool using this symbol, we
may want to make it more relaxed and keep the definition, but warn if is
used in any of the public interfaces.
