Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8D045CB20
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 18:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbhKXRkG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 12:40:06 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58990 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhKXRkG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 12:40:06 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7441121958;
        Wed, 24 Nov 2021 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637775415;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z55J7WvBzjF3VpTkPkEXhp04aqZz3z/txr7VYRagib0=;
        b=JFDn3PHyOMIPl6M1nOc79nOAYY0KhpPMN2LwgexP5zfYeGIIcK298Blf6NcAqCEHesxSxT
        SAS6Uthbsxtt0wg4R8Sq1jFeqhZRykPwhN3yFtv/UoTRulvZkQuXQ8lf4k6W7TIrFhprKx
        ERGI/uOc6/1+Zk2Uzzi5QgkL82gVx04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637775415;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z55J7WvBzjF3VpTkPkEXhp04aqZz3z/txr7VYRagib0=;
        b=SL5zhLqDw8b6l78O6j8DTnbjEnS02tNRL3S3Zb4B4FXm0neYQEXjeJFcjcf8u+A4arMYZ7
        sx0Tfesh1noSxEAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4274FA3B88;
        Wed, 24 Nov 2021 17:36:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7251EDA735; Wed, 24 Nov 2021 18:36:47 +0100 (CET)
Date:   Wed, 24 Nov 2021 18:36:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 05/21] btrfs: zoned: move compatible fs flags check to
 zoned code
Message-ID: <20211124173647.GW28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
 <dd096a7fac48e8314eb43b3f4a17fa5e4ca56c53.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd096a7fac48e8314eb43b3f4a17fa5e4ca56c53.1637745470.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 24, 2021 at 01:30:31AM -0800, Johannes Thumshirn wrote:
> check_fsflags_compatible() is only used in zoned filesystems, so move it
> to zoned code.

The function logically belongs to the ioctl, it is supposed to verify
that the flags requested by user are compatible with current filesystem
state.

> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/ioctl.c | 12 ++----------
>  fs/btrfs/zoned.h |  9 +++++++++
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 05c77a1979a9f..d7f710e57890e 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -49,6 +49,7 @@
>  #include "delalloc-space.h"
>  #include "block-group.h"
>  #include "subpage.h"
> +#include "zoned.h"
>  
>  #ifdef CONFIG_64BIT
>  /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
> @@ -192,15 +193,6 @@ static int check_fsflags(unsigned int old_flags, unsigned int flags)
>  	return 0;
>  }
>  
> -static int check_fsflags_compatible(struct btrfs_fs_info *fs_info,
> -				    unsigned int flags)
> -{
> -	if (btrfs_is_zoned(fs_info) && (flags & FS_NOCOW_FL))
> -		return -EPERM;

The intention of the function is "verify anything that's relevant", so
checking the zoned condition here is IMHO appropriate and expected as
there can be more such checks in the future. Although we don't have any
yet moving the helper to zoned.c disconnects it from the ioctl.
