Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9669D564FA8
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 10:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiGDIYg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 04:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbiGDIYf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 04:24:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C22A645D
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 01:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HW7q/c6zXFORCmpsHoKz4b3tflQK/sO1nqBaR3gY5nU=; b=sefo16tPnl+EW1EbA3GUOw1uig
        +JjRQFY4IPBtrWSfGHg6P9o9WXJkQdKG5vpdnoF+utLmR4kjdsI87um5gEAZ1lOaV29RDhj5N6w0p
        832anuDDP8VaZf8NDACFFq9uA0JibzFRpyQ5ppB63uOu9AL1NsEenIuf86Hy2rH6xQC0b28s+5kAY
        qWxvL+sCunDmUc84btJZ64B1gRQHzRSe+tohYajIog5Hp+JpEDCLVM2y53H8lX17wLdLR2gOVIGY5
        7QIaOd3lz+IlX2DR5i8420x5HTIyh87L5p3w8AkMlTkTGLIXSIE8T9JvSszumvQkzrt2XGinQWBkT
        VizxlYig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8HNi-0063M9-72; Mon, 04 Jul 2022 08:24:34 +0000
Date:   Mon, 4 Jul 2022 01:24:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/13] btrfs: zoned: revive max_zone_append_bytes
Message-ID: <YsKjwoyGZOiu9+d0@infradead.org>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
 <687ec8ab8c61a9972d6936cdf189dc5756299051.1656909695.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <687ec8ab8c61a9972d6936cdf189dc5756299051.1656909695.git.naohiro.aota@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 7a0f8fa44800..271b8b8fd4d0 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -415,6 +415,9 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>  	nr_sectors = bdev_nr_sectors(bdev);
>  	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
>  	zone_info->nr_zones = nr_sectors >> ilog2(zone_sectors);
> +	zone_info->max_zone_append_size =
> +		min_t(u64, (u64)bdev_max_zone_append_sectors(bdev) << SECTOR_SHIFT,
> +		      (u64)bdev_max_segments(bdev) << PAGE_SHIFT);

This assumes each segment is just page sized, so you probably want to
document how you arrived at that assumption.
