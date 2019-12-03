Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03EA61103ED
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 19:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLCSBT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 13:01:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46067 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCSBS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Dec 2019 13:01:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so2206240pfg.12
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Dec 2019 10:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=54Sa2FMo9AOiRwAQTSG4qVcNG3E4YpB88X4kv1LkOjc=;
        b=Bw6IaVzATr+h/x2AnMJ98YtBvRF78SZ6U61Qf36WZgSiFZDkw5egKyMFoRFZHOfr6o
         hPCFnW7CsWywQktb4phxMv6EVoOTK7cw9nYzkrii2c4dAJB+SY+w+WspUBbhbiKb1V7V
         7MU3Xtkm2jEOzvO9jNo9Shted6DumdGU8eQ4lcAVR7k6BI/XJEe3Y44BUojzGK3XlcTV
         q7epOEGpspV/z80sYEsdgY6M4WeYrvQOGX9CQBa0MP2rM+aVdBv0Pi6qwD7xtmLomlkN
         j+G4MPZjcq4NY8ynzPhrNZP/D72nZ9tSlThCLqogY2uf1LlMmAOa8R/AQE29pwwuSdhv
         RPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=54Sa2FMo9AOiRwAQTSG4qVcNG3E4YpB88X4kv1LkOjc=;
        b=LQt5FjSqd4/VA/7Z31X1DK4nNHEwF6xBjVXv5uBMfLec8bTlyLdbddwhEhap561Esr
         PUPWLFVVYwfrn3xTiyuhR3lLyrSWluIH9vhR1D9U4hjqoasvvxFT2exMxiEdfaKwtoAm
         QfY8jlJ3ZpFxou8yS/LwNT749a+BVciZsR21T/JZm+MM2lg+95y1upPq0b33axq+R14O
         TeQxFzx731tRV+TEeBkj1XiSXEn/YU8IWIbGFt2NccKJ2/Skq4gPJahpF+AdBR27A3Pf
         IUjFD51yyeS6JzKVpjXenn9dVOniE96JoTPYg7PSJeoseMtoA6fQy8g/SqHjQFRHd1C7
         a3sg==
X-Gm-Message-State: APjAAAUiZsMDx6S3HPg5xozlSjqyuZcee6gbgoOjXHwPCBUVi6RW+NZz
        CI49vk8AcSiSm9N1bOOyzMkz7g==
X-Google-Smtp-Source: APXvYqyi/FtQFHzvotkbDAZxOEgM4dh1F3O2o8dTsOO//76zv2J2oPVUiyfuvsrF7VCkk0daEngKdQ==
X-Received: by 2002:a63:770c:: with SMTP id s12mr6960232pgc.25.1575396076879;
        Tue, 03 Dec 2019 10:01:16 -0800 (PST)
Received: from vader ([2620:10d:c090:200::3:c979])
        by smtp.gmail.com with ESMTPSA id o12sm3759366pjf.19.2019.12.03.10.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 10:01:16 -0800 (PST)
Date:   Tue, 3 Dec 2019 10:01:13 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 9/9] btrfs: remove struct find_free_extent.ram_bytes
Message-ID: <20191203180113.GA831548@vader>
References: <cover.1575336815.git.osandov@fb.com>
 <e86fb919694d8c57612c5690be77b27313325232.1575336816.git.osandov@fb.com>
 <20191203132713.GI21721@Johanness-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203132713.GI21721@Johanness-MacBook-Pro.local>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 03, 2019 at 02:27:13PM +0100, Johannes Thumshirn wrote:
> On Mon, Dec 02, 2019 at 05:34:25PM -0800, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > This hasn't been used since it was first introduced in commit
> > b4bd745d1230 ("btrfs: Introduce find_free_extent_ctl structure for later
> > rework").
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  fs/btrfs/extent-tree.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 18df434bfe52..40c000269232 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -3437,7 +3437,6 @@ btrfs_release_block_group(struct btrfs_block_group *cache,
> >   */
> >  struct find_free_extent_ctl {
> >  	/* Basic allocation info */
> > -	u64 ram_bytes;
> >  	u64 num_bytes;
> >  	u64 empty_size;
> >  	u64 flags;
> > @@ -3809,7 +3808,6 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
> >  
> >  	WARN_ON(num_bytes < fs_info->sectorsize);
> >  
> > -	ffe_ctl.ram_bytes = ram_bytes;
> >  	ffe_ctl.num_bytes = num_bytes;
> >  	ffe_ctl.empty_size = empty_size;
> >  	ffe_ctl.flags = flags;
> 
> Either that or pass in a find_free_extent_ctl to btrfs_add_reserved_bytes() as
> ram_bytes, num_bytes and delalloc are set in ffe_ctl. I personally would
> favour passing in ffe_ctl to btrfs_add_reserved_bytes() as well as others like
> btrfs_add_free_space(), btrfs_free_reserved_bytes() and so on.

That might be more convenient but it feels a little icky and layer
violating to me. It'd be nice to keep the space_info code separate from
find_free_extent.
