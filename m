Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A2B4165E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 21:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242796AbhIWTTq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 15:19:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48724 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242833AbhIWTTp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 15:19:45 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id C22C5223A2;
        Thu, 23 Sep 2021 19:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632424692;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pfGTTnK0+0fgfsyDXvrPIQMWD6RYt60ejXQT1/xoz1s=;
        b=yTGZZPF/1agDrWDpSa5oBmzpyXPE2ieF+PcH3Dnts+4kBIVfir2G4VVURF/G70WpO5Z8Lp
        V/kV8wgAfrdJ63ToyTgnDs+8lNudh0E/JrmA1yEwzm/bq+6znVoWXPxRfn+VqRGyjjRjBn
        kC93jDuUwsM8oc/MU2L+KXJU+w/cbGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632424692;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pfGTTnK0+0fgfsyDXvrPIQMWD6RYt60ejXQT1/xoz1s=;
        b=dMGAEL1aE5M8TsdYJD4k1QUnkMwvx/FNHVO7vMvaWtWGnJ8eB57u2ddiSB0Z4hQG7XEBZ0
        Nj+ygT6kKcVzp3Bw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id BBDF925D40;
        Thu, 23 Sep 2021 19:18:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A846CDA799; Thu, 23 Sep 2021 21:17:59 +0200 (CEST)
Date:   Thu, 23 Sep 2021 21:17:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Remove support for BTRFS_SUBVOL_CREATE_ASYNC
Message-ID: <20210923191759.GW9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210923124127.119119-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923124127.119119-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 23, 2021 at 03:41:27PM +0300, Nikolay Borisov wrote:
> Kernel has removed support for this feature in 5.7 so let's remove
> support from progs as well.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> This has been languishing on my local branch, let's merge it and be done with
> it once for all.
> 
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
> index 5ce47c838b0e..aad3e9772908 100644
> --- a/ioctl.h
> +++ b/ioctl.h
> @@ -49,15 +49,13 @@ BUILD_ASSERT(sizeof(struct btrfs_ioctl_vol_args) == 4096);
> 
>  #define BTRFS_DEVICE_PATH_NAME_MAX 1024
> 
> -#define BTRFS_SUBVOL_CREATE_ASYNC	(1ULL << 0)

We had the problem in kernel, fixed by 34c51814b2b87cb2e, we can't just
remove things from public interfaces.
