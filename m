Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B62F7185123
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCMV22 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:28:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:42470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgCMV22 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:28:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5F285AD61;
        Fri, 13 Mar 2020 21:28:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3604FDA7A7; Fri, 13 Mar 2020 22:28:01 +0100 (CET)
Date:   Fri, 13 Mar 2020 22:28:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: Remove BTRFS_SUBVOL_CREATE_ASYNC support
Message-ID: <20200313212801.GR12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200313152320.22723-1-nborisov@suse.com>
 <20200313152320.22723-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313152320.22723-2-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 13, 2020 at 05:23:18PM +0200, Nikolay Borisov wrote:
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -36,7 +36,6 @@ struct btrfs_ioctl_vol_args {
>  #define BTRFS_DEVICE_PATH_NAME_MAX	1024
>  #define BTRFS_SUBVOL_NAME_MAX 		4039
>  
> -#define BTRFS_SUBVOL_CREATE_ASYNC	(1ULL << 0)

Removing it completely is probably fine but the 1st bit must not be
reused anytime soon, so at least some comment should be left here.

>  #define BTRFS_SUBVOL_RDONLY		(1ULL << 1)
>  #define BTRFS_SUBVOL_QGROUP_INHERIT	(1ULL << 2)
>  
> @@ -45,8 +44,7 @@ struct btrfs_ioctl_vol_args {
>  #define BTRFS_SUBVOL_SPEC_BY_ID	(1ULL << 4)
>  
>  #define BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED		\
> -			(BTRFS_SUBVOL_CREATE_ASYNC |	\
> -			BTRFS_SUBVOL_RDONLY |		\
> +			(BTRFS_SUBVOL_RDONLY |		\
>  			BTRFS_SUBVOL_QGROUP_INHERIT |	\
>  			BTRFS_DEVICE_SPEC_BY_ID |	\
>  			BTRFS_SUBVOL_SPEC_BY_ID)
> @@ -116,8 +114,7 @@ struct btrfs_ioctl_qgroup_limit_args {
>  
>  /* Supported flags for BTRFS_IOC_SNAP_CREATE_V2 and BTRFS_IOC_SUBVOL_CREATE_V2 */
>  #define BTRFS_SUBVOL_CREATE_ARGS_MASK					\
> -	(BTRFS_SUBVOL_CREATE_ASYNC |					\
> -	 BTRFS_SUBVOL_RDONLY |						\
> +	 (BTRFS_SUBVOL_RDONLY |						\

So this would catch any potential use of the flag and the ioctl can
simply remove all the related code. Ok.
