Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36D75BB856
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 17:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfIWPqz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 11:46:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:34638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726401AbfIWPqz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 11:46:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9348DADEC;
        Mon, 23 Sep 2019 15:46:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D7196DA871; Mon, 23 Sep 2019 17:47:14 +0200 (CEST)
Date:   Mon, 23 Sep 2019 17:47:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: tree-checker: Add check for INODE_REF
Message-ID: <20190923154714.GI2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190826074039.28517-1-wqu@suse.com>
 <20190826074039.28517-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826074039.28517-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 26, 2019 at 03:40:39PM +0800, Qu Wenruo wrote:
> For INODE_REF we will check:
> - Objectid (ino) against previous key
>   To detect missing INODE_ITEM.
> 
> - No overflow/padding in the data payload
>   Much like DIR_ITEM, but with less members to check.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/tree-checker.c | 53 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 636ce1b4566e..3ce447eb591c 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -842,6 +842,56 @@ static int check_inode_item(struct extent_buffer *leaf,
>  	return 0;
>  }
>  
> +#define inode_ref_err(fs_info, eb, slot, fmt, ...)		\
> +	inode_item_err(fs_info, eb, slot, fmt, __VA_ARGS__)

I've changed that to

#define inode_ref_err(fs_info, eb, slot, fmt, args...)		\
	inode_item_err(fs_info, eb, slot, fmt, ##args)

as this is the common style for the variable macro args used in btrfs.
