Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821EB378F9F
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 15:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbhEJNvJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 09:51:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:51552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241357AbhEJNor (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 09:44:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1CEF1AF33;
        Mon, 10 May 2021 13:43:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 49BE9DB226; Mon, 10 May 2021 15:41:02 +0200 (CEST)
Date:   Mon, 10 May 2021 15:41:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove redundant assignment to ret
Message-ID: <20210510134102.GV7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1620470329-27792-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620470329-27792-1-git-send-email-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 08, 2021 at 06:38:49PM +0800, Jiapeng Chong wrote:
> Variable ret is set to zero, but this value is never read as it is
> overwritten or not used later on, hence it is a redundant assignment
> and can be removed.
> 
> Clean up the following clang-analyzer warning:
> 
> fs/btrfs/extent_io.c:5357:4: warning: Value stored to 'ret' is never
> read [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/btrfs/extent_io.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 074a78a..cea58be 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5354,7 +5354,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>  				goto out_free;
>  			if (ret)
>  				flags |= FIEMAP_EXTENT_SHARED;
> -			ret = 0;

This leaves the scope where the value of 'ret' has been used for
something and it's reset to 0 for clarity. This is a pattern that we use
and will not change it just to silence clang analyzer.
