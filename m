Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCA6194568
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 18:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgCZRZs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 13:25:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:56322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbgCZRZs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 13:25:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1973CAC91;
        Thu, 26 Mar 2020 17:25:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7AFFADA730; Thu, 26 Mar 2020 18:25:15 +0100 (CET)
Date:   Thu, 26 Mar 2020 18:25:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH] btrfs-progs: restore: Avoid SYMLINK messages
Message-ID: <20200326172515.GK5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200319151036.11723-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319151036.11723-1-marcos@mpdesouza.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 19, 2020 at 12:10:36PM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Some scripts can still rely in this message, so make it available only
> if --verbose was informed.
> 
> Fixes: #127
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  cmds/restore.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/cmds/restore.c b/cmds/restore.c
> index 8eaafd60..73a464c3 100644
> --- a/cmds/restore.c
> +++ b/cmds/restore.c
> @@ -898,7 +898,9 @@ static int copy_symlink(struct btrfs_root *root, struct btrfs_key *key,
>  			goto out;
>  		}
>  	}
> -	printf("SYMLINK: '%s' => '%s'\n", path_name, symlink_target);
> +
> +	if (verbose)

I've changed it to verbose >= 2, ie. it's printed with -vv. Patch added
to devel, thanks.
