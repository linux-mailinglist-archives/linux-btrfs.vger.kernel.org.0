Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D0F36DEC2
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 20:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243423AbhD1SFw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 14:05:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:41348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243398AbhD1SFw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 14:05:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2CD36ABE8;
        Wed, 28 Apr 2021 18:05:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 55295DA783; Wed, 28 Apr 2021 20:02:43 +0200 (CEST)
Date:   Wed, 28 Apr 2021 20:02:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: delete unneeded assignments in btrfs_defrag_file
Message-ID: <20210428180243.GS7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Tian Tao <tiantao6@hisilicon.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <1619488221-29490-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619488221-29490-1-git-send-email-tiantao6@hisilicon.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 27, 2021 at 09:50:21AM +0800, Tian Tao wrote:
> ret is assigned -EAGAIN at line 1455 and then reassigned defrag_count
> at line 1547 after exiting the while loop, but the btrfs_defrag_file
> function returns a negative number indicating that the execution failed
> because it does not make sense to reassign defrag_count to ret, so
> delete it.

The line references are fragile, so the 1455 is after defrag is
cancelled.

> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  fs/btrfs/ioctl.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index ee1dbab..2b3b228 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1544,8 +1544,6 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
>  		btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
>  	}
>  
> -	ret = defrag_count;

But this would change semantics of the whole function, after deleting
this line any stale value of 'ret' would be returned, it's used for some
intermediate return values in the whole while loop.

1597                 if (btrfs_defrag_cancelled(fs_info)) {
1598                         btrfs_debug(fs_info, "defrag_file cancelled");
1599                         ret = -EAGAIN;
1600                         break;
1601                 }

Jumping to the 'out_ra' label looks like a candidate fix but that also
jumps around all the incompat bit setting, so that could in some cases
miss to set them properly. And actually this is a problem with all the
other error cases.

I'm not yet sure what's the proper fix, but the errors from within the
while loop should be returned and incompat bits set.
