Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05E18251CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 16:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfEUOWD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 10:22:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:34360 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727534AbfEUOWC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 10:22:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BE0D7AE0C;
        Tue, 21 May 2019 14:22:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6D0C5DA86B; Tue, 21 May 2019 16:22:59 +0200 (CEST)
Date:   Tue, 21 May 2019 16:22:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 11/13] btrfs: directly call into crypto framework for
 checsumming
Message-ID: <20190521142259.GD15290@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190516084803.9774-1-jthumshirn@suse.de>
 <20190516084803.9774-12-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516084803.9774-12-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 16, 2019 at 10:48:01AM +0200, Johannes Thumshirn wrote:
> Currently btrfs_csum_data() relied on the crc32c() wrapper around the crypto
> framework for calculating the CRCs.
> 
> As we have our own crypto_shash structure in the fs_info now, we can
> directly call into the crypto framework without going trough the wrapper.
> 
> This way we can even remove the btrfs_csum_data() and btrfs_csum_final()
> wrappers.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> 
> ---
> Changes to v1:
> - merge with 'btrfs: pass in an fs_info to btrfs_csum_{data,final}()'
> - Remove btrfs_csum_data() and btrfs_csum_final() alltogether
> - don't use LIBCRC32C but CRYPTO_CRC32C in KConfig
> ---
>  fs/btrfs/Kconfig           |  2 +-
>  fs/btrfs/check-integrity.c | 12 +++++++----
>  fs/btrfs/compression.c     | 19 +++++++++++------
>  fs/btrfs/disk-io.c         | 51 +++++++++++++++++++++++++---------------------
>  fs/btrfs/disk-io.h         |  2 --
>  fs/btrfs/file-item.c       | 18 ++++++++--------
>  fs/btrfs/inode.c           | 24 ++++++++++++++--------
>  fs/btrfs/scrub.c           | 37 +++++++++++++++++++++++++--------
>  8 files changed, 104 insertions(+), 61 deletions(-)
> 
> diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> index 23537bc8c827..8f48c3be709e 100644
> --- a/fs/btrfs/Kconfig
> +++ b/fs/btrfs/Kconfig
> @@ -2,7 +2,7 @@
>  
>  config BTRFS_FS
>  	tristate "Btrfs filesystem support"
> -	select LIBCRC32C
> +	select CRYPTO_CRC32C

This reverts changed done in 9678c54388b6a6b309ff7ee5c8d23fa9eba7c06f,
using LIBCRC32C adds the module dependency so this is automatically picked
when building the initrd. CRYPTO_CRC32C needed workarounds to manually
pick crc32c when btrfs was detected.

But we'll need some way to add the dependencies for all the other crypto
modules, that do not have the lib.
