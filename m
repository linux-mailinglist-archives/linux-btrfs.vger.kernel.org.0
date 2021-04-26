Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0183236BAA1
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 22:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241722AbhDZUWg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 16:22:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:49682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238112AbhDZUWf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 16:22:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6A5AAEB6;
        Mon, 26 Apr 2021 20:21:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B7D30DA7F9; Mon, 26 Apr 2021 22:19:29 +0200 (CEST)
Date:   Mon, 26 Apr 2021 22:19:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Khaled ROMDHANI <khaledromdhani216@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH-next] fs/btrfs: Fix uninitialized variable
Message-ID: <20210426201929.GI7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Khaled ROMDHANI <khaledromdhani216@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20210423124201.11262-1-khaledromdhani216@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423124201.11262-1-khaledromdhani216@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 23, 2021 at 01:42:01PM +0100, Khaled ROMDHANI wrote:
> The variable 'zone' is uninitialized which
> introduce some build warning.
> 
> It is not always set or overwritten within
> the function. So explicitly initialize it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
> ---
>  fs/btrfs/zoned.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 432509f4b3ac..42f99b25127f 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -136,7 +136,7 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
>   */
>  static inline u32 sb_zone_number(int shift, int mirror)
>  {
> -	u64 zone;
> +	u64 zone = 0;

This is exactly same as v1
https://lore.kernel.org/linux-btrfs/20210413130604.11487-1-khaledromdhani216@gmail.com/

It does fix the build warning but does not make sense in the code
because it would would silently let mirror == 4 pass. I think there was
enough feedback under the previous posts how to fix that properly.
