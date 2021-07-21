Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD843D090B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 08:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhGUF5h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 01:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhGUF5W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 01:57:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317B3C061574;
        Tue, 20 Jul 2021 23:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XYeBKSl9pF1jy3vtrjCu+kIPIp8ICH8F1p/bMzcagKs=; b=YPTD1oSDMQ1tqkeq4zo2uX9zjo
        XAzfqnrxfDYo/qWpdOxsmXM14GEqxAzpFjUhG3a64UQuaiihyFyO+bjrrRbOqzo17tmN1kSHPhubx
        lCtR/G3qnIcXm/tbiJDDp0JB8s7FfYg9tHPzbTWIFGm/BKTCLDr9u8Bqk6lqhtxnr+jH9m8pv1JFk
        mOa5jAOcCj0znZcMrZIYiVmJ0hwBimK9G8x3coK6W+C25rfCW2q0au1bHVzrO3rodWo8RUBTxLVVb
        0XQ2LiqisLcoCFufVMKzckKnFYneDTQ/4JsWVdWPsH42mOdjWB6dUQBQYIcqP/V7XPdddbuYsvhqN
        Zf8qZH4w==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m65rY-008svf-Bd; Wed, 21 Jul 2021 06:37:50 +0000
Date:   Wed, 21 Jul 2021 07:37:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH v2 2/3] btrfs: fix argument type of
 btrfs_bio_clone_partial()
Message-ID: <YPfAvDXlikV4t3zA@infradead.org>
References: <cover.1626848677.git.naohiro.aota@wdc.com>
 <c69cf6f0b81a28dd04b62537e3b8b4f46bd36e1e.1626848677.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c69cf6f0b81a28dd04b62537e3b8b4f46bd36e1e.1626848677.git.naohiro.aota@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 21, 2021 at 03:26:59PM +0900, Naohiro Aota wrote:
>  	btrfs_bio = btrfs_io_bio(bio);
>  	btrfs_io_bio_init(btrfs_bio);
>  
> -	bio_trim(bio, offset >> 9, size >> 9);
> +	bio_trim(bio, (sector_t)offset >> 9, (sector_t)size >> 9);

No need for the casts when shifting down.
