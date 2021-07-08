Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EC33C1590
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 17:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhGHPCk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 11:02:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36062 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhGHPCk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 11:02:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7EBA8201E8;
        Thu,  8 Jul 2021 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625756397;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DXJe/zv8j+p7Sg0wqBCi+lNUc6fbXchuhBe6zva+y8Q=;
        b=dLMnC0Cll80oHhUd4fBVSrMwg2kNtExPvuhF6SbQm76gwSD+/2xhpQvYwjVBevlZvkvKFu
        tmJ/uy29ZZXVGFBiPyJ0Aj8TaosJgwrn0zqZkC6Z44w6/HtY0b7vOSqJxbvPZaofA8GtkY
        vg+BpHy24Z8ZOrJNJHD+V0+3CnkHTRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625756397;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DXJe/zv8j+p7Sg0wqBCi+lNUc6fbXchuhBe6zva+y8Q=;
        b=lzmvWgRTdg7JvxSljnJ8Nw2g5UTfqw2+0ddG7DpWtS0kAWHzizQWd2TdIvDXKKk+3avvdM
        rjavvEjvg58zOODw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7DC38A3B84;
        Thu,  8 Jul 2021 14:59:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 47DD4DAF79; Thu,  8 Jul 2021 16:57:22 +0200 (CEST)
Date:   Thu, 8 Jul 2021 16:57:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 1/3] block: fix arg type of bio_trim()
Message-ID: <20210708145722.GD2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20210708131057.259327-1-naohiro.aota@wdc.com>
 <20210708131057.259327-2-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708131057.259327-2-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 08, 2021 at 10:10:55PM +0900, Naohiro Aota wrote:
> From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> 
> The function bio_trim has offset and size arguments that are declared
> as int.
> 
> The callers of this function uses sector_t type when passing the offset
> and size e,g. drivers/md/raid1.c:narrow_write_error() and
> drivers/md/raid1.c:narrow_write_error().
> 
> Change offset & size arguments to sector_t type for bio_trim().
> 
> Tested-by: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  block/bio.c         | 2 +-
>  include/linux/bio.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 44205dfb6b60..d342ce84f6cf 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1465,7 +1465,7 @@ EXPORT_SYMBOL(bio_split);
>   * @offset:	number of sectors to trim from the front of @bio
>   * @size:	size we want to trim @bio to, in sectors
>   */
> -void bio_trim(struct bio *bio, int offset, int size)
> +void bio_trim(struct bio *bio, sector_t offset, sector_t size)

sectort_t seems to be the right one, there are << 9 in the function so
that could lead to some bugs if the offset and size are at the boundary.

>  {
>  	/* 'bio' is a cloned bio which we need to trim to match
>  	 * the given offset and size.
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index a0b4cfdf62a4..fb663152521e 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -379,7 +379,7 @@ static inline void bip_set_seed(struct bio_integrity_payload *bip,
>  
>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>  
> -extern void bio_trim(struct bio *bio, int offset, int size);
> +void bio_trim(struct bio *bio, sector_t offset, sector_t size);

You may want to keep the extern for consistency in that file, though
it's not necessary for the prototype.

The patch is simple I can take it through the btrfs tree with the other
fixes unless there are objections.
