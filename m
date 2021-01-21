Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8272FF035
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 17:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733299AbhAUQ1e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jan 2021 11:27:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:36212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbhAUQ0j (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jan 2021 11:26:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5969DAB7A;
        Thu, 21 Jan 2021 16:25:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CB8FDDA6E3; Thu, 21 Jan 2021 17:23:58 +0100 (CET)
Date:   Thu, 21 Jan 2021 17:23:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 03/14] btrfs: Fix function description format
Message-ID: <20210121162358.GB6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210120102526.310486-1-nborisov@suse.com>
 <20210120102526.310486-4-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120102526.310486-4-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 20, 2021 at 12:25:15PM +0200, Nikolay Borisov wrote:
> This fixes following W=1 warnings:
> 
> fs/btrfs/file-item.c:27: warning: Cannot understand  * @inode:  the inode we want to update the disk_i_size for
>  on line 27 - I thought it was a doc line
> fs/btrfs/file-item.c:65: warning: Cannot understand  * @inode - the inode we're modifying
>  on line 65 - I thought it was a doc line
> fs/btrfs/file-item.c:91: warning: Cannot understand  * @inode - the inode we're modifying
>  on line 91 - I thought it was a doc line
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/file-item.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 6ccfc019ad90..fedb200c39ca 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -24,8 +24,10 @@
>  				       PAGE_SIZE))
>  
>  /**
> - * @inode - the inode we want to update the disk_i_size for
> - * @new_i_size - the i_size we want to set to, 0 if we use i_size
> + * btrfs_inode_safe_disk_i_size_write

Have you not read
https://lore.kernel.org/linux-btrfs/20210119224353.GU6430@twin.jikos.cz/
?

Updating the whole comment is fine in one patch even if there are more
types of changes, no point to do that in separate patches like for code.
