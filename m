Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659092268C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jul 2020 18:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388684AbgGTQUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jul 2020 12:20:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:58740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731669AbgGTQKL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jul 2020 12:10:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 929A4B5F7;
        Mon, 20 Jul 2020 16:10:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 67619DA781; Mon, 20 Jul 2020 18:09:45 +0200 (CEST)
Date:   Mon, 20 Jul 2020 18:09:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Christian Zangl <coralllama@gmail.com>
Subject: Re: [PATCH 1/2] btrfs-progs: convert: Prevent bit overflow for
 cctx->total_bytes
Message-ID: <20200720160945.GH3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Christian Zangl <coralllama@gmail.com>
References: <20200720125109.93970-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720125109.93970-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 20, 2020 at 08:51:08PM +0800, Qu Wenruo wrote:
> --- a/convert/source-ext2.c
> +++ b/convert/source-ext2.c
> @@ -87,7 +87,8 @@ static int ext2_open_fs(struct btrfs_convert_context *cctx, const char *name)
>  	cctx->fs_data = ext2_fs;
>  	cctx->blocksize = ext2_fs->blocksize;
>  	cctx->block_count = ext2_fs->super->s_blocks_count;
> -	cctx->total_bytes = ext2_fs->blocksize * ext2_fs->super->s_blocks_count;
> +	cctx->total_bytes = (u64)ext2_fs->blocksize *
> +			    (u64)ext2_fs->super->s_blocks_count;

Do you need to cast both? Once one of the types is wide enough for the
result, there should be no loss.
