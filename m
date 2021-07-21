Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAF23D0902
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 08:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhGUF4L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 01:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbhGUFzs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 01:55:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D517FC061574;
        Tue, 20 Jul 2021 23:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TbetRsKmJc4IgD/wnR8skOFHfIgN2EmIYkeFzfwMtwE=; b=FzU9XxYcf8Q7kjO/1HTYSIzGg3
        0Q9Pbl+gGc8RIppnpiCw2Dld12vkhsRDiGtzeQO7+Oo7vcV73isvt6D/Ldjat1pdYN2+JBiQDd1Zk
        Z6VYe1gEQrr3PzU83XiFqJGlhgi9fZgHVL0JFt5mofrd2CWO/MskD+ex2O78CNq/0pnhiqItebIqa
        WteWReKXWpzKJS2DIy16YOsqam6lOKxgoI/y5tKTAG68P1+I5uuYEZaGfb3+DsoWwlhA9ubzgTMqa
        WbXd7Z1Z0NvGtAhnKp9IJQvpRADzHCM59icCcLHNzaDdADssm4AZJFsaRwKJZjLNhGFvBNNMnUY+j
        ZLM+cxUw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m65pt-008sny-FX; Wed, 21 Jul 2021 06:36:09 +0000
Date:   Wed, 21 Jul 2021 07:36:05 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH v2 1/3] block: fix arg type of bio_trim()
Message-ID: <YPfAVSlYdM+TAe2z@infradead.org>
References: <cover.1626848677.git.naohiro.aota@wdc.com>
 <6bd02746905e41dfee04f2500d6d15f9b9b73fc9.1626848677.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bd02746905e41dfee04f2500d6d15f9b9b73fc9.1626848677.git.naohiro.aota@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 21, 2021 at 03:26:58PM +0900, Naohiro Aota wrote:
> +void bio_trim(struct bio *bio, sector_t offset, sector_t size)
>  {
> +	const sector_t uint_max_sectors = UINT_MAX >> SECTOR_SHIFT;

I'd make this a #define and keep it close to the struct bio definition
named something like BIO_MAX_SECTORS

> +
> +	/*
> +	 * 'bio' is a cloned bio which we need to trim to match the given
> +	 * offset and size.
>  	 */

This should go into the kernel doc comment.

Something like:

/**
 * bio_trim - trim a bio to the given offset and size
 * @bio:        bio to trim
 * @offset:     number of sectors to trim from the front of @bio
 * @size:       size we want to trim @bio to, in sectors
 *
 * This function is typically used for bios that are cloned and
 * submitted to the underlying device in parts.
 */


> +	/* sanity check */
> +	if (WARN_ON(offset > uint_max_sectors || size > uint_max_sectors ||
> +		    offset + size > bio->bi_iter.bi_size))
> +		return;

No real need for the comment. WARN_ON pretty much implies a sanity
check.  I'd make this a WARN_ON_ONCE as otherwise you'll probably
drown in these warnings if they ever hit.

> -extern void bio_trim(struct bio *bio, int offset, int size);
> +extern void bio_trim(struct bio *bio, sector_t offset, sector_t size);

Please drop the extern while you're at it.
