Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F838C0A0D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2019 19:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfI0RK4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 13:10:56 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46175 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbfI0RK4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 13:10:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id 201so2526280qkd.13
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2019 10:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tSHr8aNuUBlgQwPT8sUUGjBZqE/xOJJzHkeEpE8Q6NE=;
        b=wy/Q7F2z0qhQQELFtkCyYLnjnV0++9kwfKfwKgjHMVVGVF/pUk3Mwhho7SHNV5qiyG
         eVDf6geg8R3VfKEAlhC+2dnalIE+QgDD1T9debSX4865PA1Ax3FYw3iZPWb1peneHJQD
         PCCkV1VVHre6Q/lW5IJ5RHddhWI71ztfJmPxZ9e8eA4iDtinpeb5NH1kECHgAH5Lj6Jz
         2QbcUt/IVoQY20MSGcswyHOlDg6Jlgr3gT896vLDMtYm5UbMZ6bBuZwoX6F7DvkbeSFA
         qjuxfd7Zl3VC5kVSumdZJDNttvqiLwX+0vxdZNnaftVEEDVoChUoYILdPDnUQecgA2Y5
         y0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tSHr8aNuUBlgQwPT8sUUGjBZqE/xOJJzHkeEpE8Q6NE=;
        b=dio8/MwZYXw1kdjAX4UJFggPnzaPyI4IIyeey+GjAC59HpBGwWQ0Tv/NzI8g8IWPhu
         wSPseo+xOXAOAMdKGDPfIHaFDq7Jh+PvDvq64mWpjKb/rH4YqJPP6rlhfS1ImTPRUcj+
         hWOs06jq4DzcKunyU/N2HUuYd/YIRfTHygmpIAhenptaIT8fm4TCgl2oWKZ5InMJFXgm
         kHnlVL4O4gsgkSXQ3QAHmgS3otmFlTpZtIUBT6HVHrXk6blqAzFCE8v8ZvWyYBadn6mf
         uQDAa9gF5Qw2lMqkJ7J8hQmkoB43bV4h5DSNpssKmMCeeW8L4kt0VChZEXgYD3N2c4bu
         ayMw==
X-Gm-Message-State: APjAAAWyboCCJDfd6dv62X8qKPQbQVnbJhbFYNwvRJ1qVq87u7llO9ER
        ydiSBvaLQB5QUjE27bYGUQFABg==
X-Google-Smtp-Source: APXvYqz0Rl3jlZ8NqsKtac9JF4EJOq3IdHeoGELiUTI9pO5abtgmTn4gQI0SWcypdEXfCRvrFRePhw==
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr5702217qkf.156.1569604255229;
        Fri, 27 Sep 2019 10:10:55 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::3d0f])
        by smtp.gmail.com with ESMTPSA id 200sm1673466qkf.65.2019.09.27.10.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 10:10:54 -0700 (PDT)
Date:   Fri, 27 Sep 2019 13:10:52 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] btrfs: Speed up btrfs_file_llseek
Message-ID: <20190927171051.bfkt575rhg36v4hm@macbook-pro-91.dhcp.thefacebook.com>
References: <20190927102318.12830-1-nborisov@suse.com>
 <20190927102318.12830-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927102318.12830-2-nborisov@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 27, 2019 at 01:23:16PM +0300, Nikolay Borisov wrote:
> Modifying the file position is done on a per-file basis. This renders
> holding the inode lock for writing useless and makes the performance of
> concurrent llseek's abysmal.
> 
> Fix this by holding the inode for read. This provides protection against
> concurrent truncates and find_desired_extent already includes proper
> extent locking for the range which ensures proper locking against
> concurrent writes. SEEK_CUR and SEEK_END can be done lockessly.
> The former is synchronized by file::f_lock spinlock. SEEK_END is not
> synchronized but atomic, but that's OK since there is not guarantee
> that SEEK_END will always be at the end of the file in the face of
> tail modifications.
> 
> This change brings ~82% performance improvement when doing a lot of
> parallel fseeks. The workload essentially does:
> 
>                     for (d=0; d<num_seek_read; d++)
>                       {
>                         /* offset %= 16777216; */
>                         fseek (f, 256 * d % 16777216, SEEK_SET);
>                         fread (buffer, 64, 1, f);
>                       }
> 
> Without patch:
> 
> num workprocesses = 16
> num fseek/fread = 8000000
> step = 256
> fork 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
> 
> real	0m41.412s
> user	0m28.777s
> sys	2m16.510s
> 
> With patch:
> 
> num workprocesses = 16
> num fseek/fread = 8000000
> step = 256
> fork 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
> 
> real	0m11.479s
> user	0m27.629s
> sys	0m21.040s
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/file.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 12688ae6e6f2..000b7bd89bf0 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3347,13 +3347,14 @@ static int find_desired_extent(struct inode *inode, loff_t *offset, int whence)
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct extent_map *em = NULL;
>  	struct extent_state *cached_state = NULL;
> +	loff_t i_size = inode->i_size;

We don't actually need to do all this now that we're holding the inode_lock
right?  Also I've gone through and looked at stuff and we're good with just a
shared lock here, the only thing that adjusts i_size outsize of the extent lock
is truncate, so we're safe.  Thanks,

Josef
