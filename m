Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8180E27DA3C
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 23:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgI2Vid (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 17:38:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:57860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbgI2Vid (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 17:38:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 151C1AC97;
        Tue, 29 Sep 2020 21:38:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B798DDA701; Tue, 29 Sep 2020 23:37:12 +0200 (CEST)
Date:   Tue, 29 Sep 2020 23:37:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: subvolume: Add warning on deleting default
 subvolume
Message-ID: <20200929213712.GK6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20200928150729.2239-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928150729.2239-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 28, 2020 at 03:07:29PM +0000, Sidong Yang wrote:
> This patch add warning messages when user try to delete default
> subvolume. When deleting default subvolume, kernel will not allow and
> make error message on syslog. but there is only message that permission
> denied on userspace. User can be noticed the reason by this warning message.
> 
> This patch implements github issue.
> https://github.com/kdave/btrfs-progs/issues/274
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Thanks.

> ---
>  cmds/subvolume.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> index 2020e486..0cdf7a68 100644
> --- a/cmds/subvolume.c
> +++ b/cmds/subvolume.c
> @@ -264,6 +264,7 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
>  	struct seen_fsid *seen_fsid_hash[SEEN_FSID_HASH_SIZE] = { NULL, };
>  	enum { COMMIT_AFTER = 1, COMMIT_EACH = 2 };
>  	enum btrfs_util_error err;
> +	uint64_t default_subvol_id = 0, target_subvol_id = 0;
>  
>  	optind = 0;
>  	while (1) {
> @@ -360,6 +361,25 @@ again:
>  		goto out;
>  	}
>  
> +	err = btrfs_util_get_default_subvolume_fd(fd, &default_subvol_id);
> +	if (fd < 0) {
> +		ret = 1;
> +		goto out;
> +	}
> +
> +	if (subvolid > 0)
> +		target_subvol_id = subvolid;
> +	else {
> +		err = btrfs_util_subvolume_id(path, &target_subvol_id);
> +		if (fd < 0) {
> +			ret = 1;
> +			goto out;
> +		}
> +	}
> +
> +	if (target_subvol_id == default_subvol_id)
> +		warning("trying to delete default subvolume.");

I've changed that to skip the deletion and added id and path to the
message, otherwise it's not clear which one it was. Also I've added a
test.
