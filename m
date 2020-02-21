Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E82167E4D
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 14:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgBUNSJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 08:18:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:51368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbgBUNSJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 08:18:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CF741B165;
        Fri, 21 Feb 2020 13:18:07 +0000 (UTC)
Message-ID: <7b553cc689aab3349caf2f0ba69a393127b37046.camel@suse.de>
Subject: Re: [PATCH 2/3] btrfs: use ioctl args support mask for subvolume
 create/delete
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Date:   Fri, 21 Feb 2020 10:21:08 -0300
In-Reply-To: <4b8a60420b7da2f62f04969541b3405fc14914e6.1582289899.git.dsterba@suse.com>
References: <cover.1582289899.git.dsterba@suse.com>
         <4b8a60420b7da2f62f04969541b3405fc14914e6.1582289899.git.dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 2020-02-21 at 14:02 +0100, David Sterba wrote:
> Using the defined mask instead of flag enumeration in the ioctl
> handler
> is preferred. No functional changes.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/ioctl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 7305e6770157..a7872cacd0aa 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1838,9 +1838,7 @@ static noinline int
> btrfs_ioctl_snap_create_v2(struct file *file,
>  		return PTR_ERR(vol_args);
>  	vol_args->name[BTRFS_SUBVOL_NAME_MAX] = '\0';
>  
> -	if (vol_args->flags &
> -	    ~(BTRFS_SUBVOL_CREATE_ASYNC | BTRFS_SUBVOL_RDONLY |
> -	      BTRFS_SUBVOL_QGROUP_INHERIT)) {
> +	if (vol_args->flags & ~BTRFS_SUBVOL_CREATE_ARGS_MASK) {
>  		ret = -EOPNOTSUPP;
>  		goto free_args;
>  	}

Looks good to me,
Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>

