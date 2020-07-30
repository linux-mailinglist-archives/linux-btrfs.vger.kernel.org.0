Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594C4233719
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jul 2020 18:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgG3Qr2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 12:47:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:37666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3Qr2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 12:47:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF793AC79;
        Thu, 30 Jul 2020 16:47:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8A469DA842; Thu, 30 Jul 2020 18:46:57 +0200 (CEST)
Date:   Thu, 30 Jul 2020 18:46:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: handle errors from async submission
Message-ID: <20200730164657.GJ3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20200728112541.3401-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728112541.3401-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 28, 2020 at 08:25:41PM +0900, Johannes Thumshirn wrote:
> Btrfs' async submit mechanism is able to handle errors in the submission
> path and the meta-data async submit function correctly passes the error
> code to the caller.
> 
> In btrfs_submit_bio_start() and btrfs_submit_bio_start_direct_io() we're
> not handling the errors returned by btrfs_csum_one_bio() correctly though
> and simply call BUG_ON(). This is unnecessary as the caller of these two
> functions - run_one_async_start - correctly checks for the return values
> and sets the status of the async_submit_bio. The actual bio submission
> will be handled later on by run_one_async_done only if
> async_submit_bio::status is 0, so the data won't be written if we
> encountered an error in the checksum process.
> 
> Simply return the error from btrfs_csum_one_bio() to the async submitters,
> like it's done in btree_submit_bio_start().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to misc-next, thanks.
> @@ -2154,11 +2154,8 @@ static blk_status_t btrfs_submit_bio_start(void *private_data, struct bio *bio,
>  				    u64 bio_offset)
>  {
>  	struct inode *inode = private_data;
> -	blk_status_t ret = 0;
>  
> -	ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
> -	BUG_ON(ret); /* -ENOMEM */
> -	return 0;
> +	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);

The submit bio hooks have become a trivial indirect call to two
functions, so we might get rid of the indirection eventually.
