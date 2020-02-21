Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F40D0167E45
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 14:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgBUNRo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 08:17:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:51078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgBUNRo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 08:17:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7AB72AE9E;
        Fri, 21 Feb 2020 13:17:43 +0000 (UTC)
Message-ID: <e1a17a295fdf2fd1269e8234e2b7348727b10a8a.camel@suse.de>
Subject: Re: [PATCH 1/3] btrfs: define support masks for ioctl volume args v2
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Date:   Fri, 21 Feb 2020 10:20:42 -0300
In-Reply-To: <c25c2e84ebc5ef31227ae23d44e09ddc8c343a7b.1582289899.git.dsterba@suse.com>
References: <cover.1582289899.git.dsterba@suse.com>
         <c25c2e84ebc5ef31227ae23d44e09ddc8c343a7b.1582289899.git.dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 2020-02-21 at 14:02 +0100, David Sterba wrote:
> The ioctl data for devices or subvolumes can be passed via
> btrfs_ioctl_vol_args or btrfs_ioctl_vol_args_v2. The latter is more
> versatile and needs some caution as some of the flags make sense only
> for some ioctls.
> 
> As we're going to extend the flags, define support masks for each
> ioctl
> class separately.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  include/uapi/linux/btrfs.h | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index 7a8bc8b920f5..49ed71df5e94 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -97,16 +97,26 @@ struct btrfs_ioctl_qgroup_limit_args {
>  };
>  
>  /*
> - * flags for subvolumes
> + * Arguments for specification of subvolumes or devices, supporting
> by-name or
> + * by-id and flags
>   *
> - * Used by:
> - * struct btrfs_ioctl_vol_args_v2.flags
> + * The set of supported flags depends on the ioctl
>   *
>   * BTRFS_SUBVOL_RDONLY is also provided/consumed by the following
> ioctls:
>   * - BTRFS_IOC_SUBVOL_GETFLAGS
>   * - BTRFS_IOC_SUBVOL_SETFLAGS
>   */
>  
> +/* Supported flags for BTRFS_IOC_RM_DEV_V2 */
> +#define BTRFS_DEVICE_REMOVE_ARGS_MASK				
> 	\
> +	(BTRFS_DEVICE_SPEC_BY_ID)
> +
> +/* Supported flags for BTRFS_IOC_SNAP_CREATE_V2 and
> BTRFS_IOC_SUBVOL_CREATE_V2 */
> +#define BTRFS_SUBVOL_CREATE_ARGS_MASK				
> 	\
> +	(BTRFS_SUBVOL_CREATE_ASYNC |					
> \
> +	 BTRFS_SUBVOL_RDONLY |						
> \
> +	 BTRFS_SUBVOL_QGROUP_INHERIT)
> +
>  struct btrfs_ioctl_vol_args_v2 {
>  	__s64 fd;
>  	__u64 transid;

Looks good to me,
Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>

