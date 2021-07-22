Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12D63D25E6
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 16:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhGVN4s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 09:56:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59818 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhGVN4q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 09:56:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7BA19203D0
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jul 2021 14:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626964640;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S2gS7VMotWLogdiyCLbWGIAJfb51N0kjbh/TIewBl2c=;
        b=LRS0LHAxEVYa5CxMBBqVvu0E7Uk9c1EZOYtVbX5wY29+kBOb6LEVhOfI+NOiblWVgZwvhD
        Psy7cxTE2oLoBEXyngyk16h9QllnVWVoNt99i9iJpEdiyumyskd8U0DLxFagz64H39PE3u
        Xl80g6Ro2rAjFnIF/w3hwG3VQSxN0MM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626964640;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S2gS7VMotWLogdiyCLbWGIAJfb51N0kjbh/TIewBl2c=;
        b=MGHCwvONgLGgOtkpjoeHhMFA5N5ZmMydCjjFSp7t5oM9EapWLHaMTp4fGG4fjzjJqCVCey
        8RUSyTg8iHiNZpCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 74FE9A51EB;
        Thu, 22 Jul 2021 14:37:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CE659DAF95; Thu, 22 Jul 2021 16:34:38 +0200 (CEST)
Date:   Thu, 22 Jul 2021 16:34:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: mark compressed range uptodate only if all bio
 succeed
Message-ID: <20210722143438.GZ19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org
References: <20210709162922.udxjidc3kgxkgzx3@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709162922.udxjidc3kgxkgzx3@fiona>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 09, 2021 at 11:29:22AM -0500, Goldwyn Rodrigues wrote:
> In compression write endio sequence, the range which the compressed_bio
> writes is marked as uptodate if the last bio of the compressed (sub)bios
> is completed successfully. There could be previous bio which may
> have failed which is recorded in cb->errors.
> 
> Set the writeback range as uptodate only if cb->errors is zero, as opposed
> to checking only the last bio's status.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/compression.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 9a023ae0f98b..30d82cdf128c 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -352,7 +352,7 @@ static void end_compressed_bio_write(struct bio *bio)
>  	btrfs_record_physical_zoned(inode, cb->start, bio);
>  	btrfs_writepage_endio_finish_ordered(BTRFS_I(inode), NULL,
>  			cb->start, cb->start + cb->len - 1,
> -			bio->bi_status == BLK_STS_OK);
> +			!cb->errors);

Right, that would only test the last bio. Have been able to reproduce
it?

Anyway, added to misc-next, thanks.
