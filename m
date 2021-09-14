Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773E340B542
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 18:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhINQvL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 12:51:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58540 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhINQvK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 12:51:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4935C21E94;
        Tue, 14 Sep 2021 16:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631638192;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w5bMakjVgNlFcAcUzRDUEaHzv8ev3xIbfliLgGmLHvA=;
        b=ALK5zBL8ejfNUQD+KwIWWLJNkk2r7FtRN6aKERrGnzFcBKYpS1lc7jBwziC3L0xaQdSzfC
        ysCMQouYDurnDyQLrg6doeOTROm0pgsSEEDtoEUERGfJIoJ+efJkR20b7qmLadWDdZEVlV
        imG34RfFfIfnBFwB9YP1YJw6dzGF+bQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631638192;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w5bMakjVgNlFcAcUzRDUEaHzv8ev3xIbfliLgGmLHvA=;
        b=E6r2dgjQsaz8qS5cUwZ1YPaBXj5bCyC8P4zkux02pKERIhgG2pd8DOOiI7uq2x/6kTPoIr
        +yBwjMngrBBQDKBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4332CA3B88;
        Tue, 14 Sep 2021 16:49:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 413D5DA781; Tue, 14 Sep 2021 18:49:44 +0200 (CEST)
Date:   Tue, 14 Sep 2021 18:49:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] btrfs: rename struct btrfs_io_bio to btrfs_bio
Message-ID: <20210914164944.GH9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210914012543.12746-1-wqu@suse.com>
 <20210914012543.12746-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914012543.12746-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 14, 2021 at 09:25:43AM +0800, Qu Wenruo wrote:
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1423,7 +1423,7 @@ static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_info,
>  	if (!first_page->dev->bdev)
>  		goto out;
>  
> -	bio = btrfs_io_bio_alloc(BIO_MAX_VECS);
> +	bio = btrfs_bio_alloc(BIO_MAX_VECS);

As BIO_MAX_VECS is the default value, this should take 0 so it's
consistent with the rest.

>  	bio_set_dev(bio, first_page->dev->bdev);
>  
>  	for (page_num = 0; page_num < sblock->page_count; page_num++) {
