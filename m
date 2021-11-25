Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F024C45DD96
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 16:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhKYPlT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 10:41:19 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48378 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbhKYPjT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 10:39:19 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2C22F1FD34;
        Thu, 25 Nov 2021 15:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637854567;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uzfrdU2YsnBv9TMMgErYAagu0toS7PlDlRUx9pIHOzQ=;
        b=tp8P5zFaBFDa4WuD3Ubk0iu86XYU6ZuLC1UT7ZI+M7+kfjWWWQiNgr0blszsfghzUD/SRN
        7r9syp1wkTWwhlcBu+NUzII6M5RsHjOL5FcnXHLMOI4Sxakvi9HRltviOCQYLd5q13aEdn
        LQLtzqqc/tApTd4g8VDrTpUrJXL3ek8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637854567;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uzfrdU2YsnBv9TMMgErYAagu0toS7PlDlRUx9pIHOzQ=;
        b=ka/OBS3+t85Qt4JFScnttNHDAmabc7AgKoQfkd2JMv2dfxYy/KUqswIOE1AqpyctslqCYt
        bHwKVQesK9Gds/DQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 251C4A3B83;
        Thu, 25 Nov 2021 15:36:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E5356DA735; Thu, 25 Nov 2021 16:35:58 +0100 (CET)
Date:   Thu, 25 Nov 2021 16:35:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/3] btrfs: introduce BTRFS_EXCLOP_BALANCE_PAUSED
 exclusive state
Message-ID: <20211125153558.GZ28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211125091443.762092-1-nborisov@suse.com>
 <20211125091443.762092-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125091443.762092-2-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 25, 2021 at 11:14:41AM +0200, Nikolay Borisov wrote:
> Current set of exclusive operation states is not sufficient to handle all
> practical use cases. In particular there is a need to be able to add a
> device to a filesystem that have paused balance. Currently there is no
> way to distinguish between a running and a paused balance. Fix this by
> introducing BTRFS_EXCLOP_BALANCE_PAUSED which is going to be set in 2
> occasions:
> 
> 1. When a filesystem is mounted with skip_balance and there is an
>    unfinished balance it will now be into BALANCE_PAUSED instead of
>    simply BALANCE state.
> 
> 2. When a running balance is paused.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/ctree.h   |  4 ++++
>  fs/btrfs/ioctl.c   | 23 +++++++++++++++++++++++
>  fs/btrfs/volumes.c | 10 ++++++++--
>  3 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 5e29f3fc527d..79a873c6d186 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -613,6 +613,7 @@ enum {
>   */
>  enum btrfs_exclusive_operation {
>  	BTRFS_EXCLOP_NONE,
> +	BTRFS_EXCLOP_BALANCE_PAUSED,
>  	BTRFS_EXCLOP_BALANCE,
>  	BTRFS_EXCLOP_DEV_ADD,
>  	BTRFS_EXCLOP_DEV_REMOVE,
> @@ -3316,6 +3317,9 @@ bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
>  				 enum btrfs_exclusive_operation type);
>  void btrfs_exclop_start_unlock(struct btrfs_fs_info *fs_info);
>  void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
> +void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
> +			  enum btrfs_exclusive_operation op);
> +
>  
>  /* file.c */
>  int __init btrfs_auto_defrag_init(void);
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 5263f991ffff..ffe33e853bfa 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -414,6 +414,28 @@ void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
>  	sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_operation");
>  }
>  
> +void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
> +			  enum btrfs_exclusive_operation op)
> +{
> +	switch (op) {
> +	case BTRFS_EXCLOP_BALANCE_PAUSED:
> +		spin_lock(&fs_info->super_lock);
> +		ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
> +		       fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD);
> +		fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE_PAUSED;
> +		spin_unlock(&fs_info->super_lock);
> +		break;
> +	case BTRFS_EXCLOP_BALANCE:
> +		spin_lock(&fs_info->super_lock);
> +		ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
> +		fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE;
> +		spin_unlock(&fs_info->super_lock);
> +		break;
> +	default:
> +		WARN(1, "BTRFS: invalid balance operation requested\n");

As the fs_info is available, this shoud use btrfs_warn because it also
prints the uuid/device of the filesytem, otherwise the message is
useless. Also it could contain the number of the operation. I'll fix
that.
