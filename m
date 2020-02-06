Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFD35154A21
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 18:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgBFRRY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 12:17:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:59812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbgBFRRY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Feb 2020 12:17:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B4289AAA6;
        Thu,  6 Feb 2020 17:17:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A5712DA790; Thu,  6 Feb 2020 18:17:09 +0100 (CET)
Date:   Thu, 6 Feb 2020 18:17:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     qiwuchen55@gmail.com
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        trivial@kernel.org, linux-btrfs@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] btrfs: remove trivial nowait check
Message-ID: <20200206171709.GB2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, qiwuchen55@gmail.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, trivial@kernel.org,
        linux-btrfs@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
References: <1580529093-26170-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580529093-26170-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 01, 2020 at 11:51:33AM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Remove trivial nowait check for btrfs_file_write_iter(),
> since buffered writes will return -EINVAL if IOCB_NOWAIT
> passed in the follow-up function generic_write_checks().
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---
>  fs/btrfs/file.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index a16da27..320af95 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1896,10 +1896,6 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
>  	loff_t oldsize;
>  	int clean_page = 0;
>  
> -	if (!(iocb->ki_flags & IOCB_DIRECT) &&
> -	    (iocb->ki_flags & IOCB_NOWAIT))
> -		return -EOPNOTSUPP;

This returns a different error code for the condition than
generic_write_checks, and is checked without the inode lock. I'm not
sure if we should remove it, it's a fast-fail path for buffered+nowait,
that probably does not happen that often.
