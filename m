Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647B3390691
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 18:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhEYQZC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 12:25:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:50578 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232200AbhEYQZB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 12:25:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621959810;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1TwJ77aoSrIKHt+YYhTUhNCgRJxHRSGsYbOWq/ep6Po=;
        b=VwZVhomB8KvnHx9kWDcEdlnKbMcd2msZIcM7M3X7PZci+mGwzqAer66EkHSeYLcfvGtFWe
        YaR9BDQrB2vtCfybcuMm3e1cvQcrM3lupAC8umyQ+sSWvPL67PhsM9A7+fubjf5Qa3FmGF
        3fdIf5wpfc1UsslpQ6xAJRFzmRfHNK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621959810;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1TwJ77aoSrIKHt+YYhTUhNCgRJxHRSGsYbOWq/ep6Po=;
        b=PWxz5/zT1uV7lYYIHmBjqj/V84QAyb2YIMER6WzpsqLH2zkspcuizqyy71ExlrKAO8U+OM
        UxFInCU9+4VLJ7BQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6AC2AF38;
        Tue, 25 May 2021 16:23:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5B54BDA704; Tue, 25 May 2021 18:20:54 +0200 (CEST)
Date:   Tue, 25 May 2021 18:20:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com
Subject: Re: [PATCH] btrfs: Add new flag to rescan quota after subvolume
 creation
Message-ID: <20210525162054.GE7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com
References: <20210521143811.16227-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521143811.16227-1-mpdesouza@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 21, 2021 at 11:38:11AM -0300, Marcos Paulo de Souza wrote:
> Adding a new subvolume/snapshot makes the qgroup data inconsistent, so
> add a new flag to inform the subvolume ioctl to do a quota rescan right
> after the subvolume/snapshot creation.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> 
>  This is an attempt to help snapper to create snapshots with 'timeline'
>  cleanup-policy to keep the qgroup data consistent after a new snapshot is
>  created.

I'm not sure adding something like rescan into subvolume creation. It
can be started separately as a workaround. The problem I see is that
there are two big things happening and both can fail, but there's only
one return value and the user can tell which one failed.

> +	if (vol_args->flags & BTRFS_SUBVOL_QGROUP_RESCAN) {
> +		if (!capable(CAP_SYS_ADMIN)) {
> +			ret = -EPERM;

Eg. here, did the subvolume creation fail due to EPERM, or the rescan?

> +			goto free_args;
> +		}
> +
> +		quota_rescan = true;
> +	}
> +
>  	if (vol_args->flags & BTRFS_SUBVOL_RDONLY)
>  		readonly = true;
>  	if (vol_args->flags & BTRFS_SUBVOL_QGROUP_INHERIT) {
> @@ -1843,6 +1869,22 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
>  					subvol, readonly, inherit);
>  	if (ret)
>  		goto free_inherit;
> +
> +	if (quota_rescan) {
> +		ret = do_quota_rescan(file);
> +		/*
> +		 * EINVAL is returned if quota is not enabled. There is already
> +		 * a warning issued if quota rescan is started when quota is not
> +		 * enabled, so skip a warning here if it is the case.
> +		 */
> +		if (ret < 0 && ret != -EINVAL)
> +			btrfs_warn(btrfs_sb(file_inode(file)->i_sb),
> +		"Couldn't execute quota rescan after snapshot creation: %d",
> +					ret);
> +		else
> +			ret = 0;

That's another special case and the system error message is required to
interpret the error code but we've seen in the past that this is not a
good usability pattern.

> +#define BTRFS_SUBVOL_QGROUP_RESCAN	(1ULL << 5)
> +
>  #define BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED		\
>  			(BTRFS_SUBVOL_RDONLY |		\
>  			BTRFS_SUBVOL_QGROUP_INHERIT |	\
>  			BTRFS_DEVICE_SPEC_BY_ID |	\
> -			BTRFS_SUBVOL_SPEC_BY_ID)
> +			BTRFS_SUBVOL_SPEC_BY_ID |	\
> +			BTRFS_SUBVOL_QGROUP_RESCAN)

The idea of bits is to extend mode of operation of the ioctls, not to
proxy other functionality. What I'd see as reasonable would be something
like conditionally marking the quotas inconsistent by setting a bit
after snapshot creation and when quotas are enabled. But the snapshot
creation should do only snapshot creation.
