Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06FF51BB03
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 18:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbfEMQbR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 12:31:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:35662 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727774AbfEMQbR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 12:31:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ABB9FAF6E;
        Mon, 13 May 2019 16:31:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CB085DA851; Mon, 13 May 2019 18:32:16 +0200 (CEST)
Date:   Mon, 13 May 2019 18:32:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: prevent send failures and crashes due to
 concurrent relocation
Message-ID: <20190513163216.GF3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190422154409.16323-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422154409.16323-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 22, 2019 at 04:44:09PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -6869,9 +6869,23 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
>  	if (ret)
>  		goto out;
>  
> +	mutex_lock(&fs_info->balance_mutex);
> +	if (test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
> +		mutex_unlock(&fs_info->balance_mutex);
> +		btrfs_warn_rl(fs_info,
> +	      "Can not run send because a balance operation is in progress");
> +		ret = -EAGAIN;
> +		goto out;
> +	}
> +	fs_info->send_in_progress++;
> +	mutex_unlock(&fs_info->balance_mutex);

This would be better in a helper that hides that the balance mutex from
send.

eg.

	if (!btrfs_send_can_start(fs_info)
		return -EAGAIN;

> +
>  	current->journal_info = BTRFS_SEND_TRANS_STUB;
>  	ret = send_subvol(sctx);
>  	current->journal_info = NULL;
> +	mutex_lock(&fs_info->balance_mutex);
> +	fs_info->send_in_progress--;
> +	mutex_unlock(&fs_info->balance_mutex);

	btrfs_send_end();

>  	if (ret < 0)
>  		goto out;
>  
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index db934ceae9c1..8145b62e3912 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4203,6 +4203,14 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
>  			   get_raid_name(meta_index), get_raid_name(data_index));
>  	}
>  
> +	if (fs_info->send_in_progress) {
> +		btrfs_warn_rl(fs_info,
> +"Can not run balance while send operations are in progress (%d in progress)",
> +			      fs_info->send_in_progress);
> +		ret = -EAGAIN;
> +		goto out;
> +	}

Similar here.

As the operation compatibility is done on the filesystem level, it would
be better to hide all the logic in helpers, now that there's more than
the per-subvolume send_in_progress.
