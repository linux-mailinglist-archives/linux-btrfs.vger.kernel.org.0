Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B8A564FA4
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 10:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiGDIXq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 04:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiGDIXp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 04:23:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1025762E2
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 01:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tqtH+tKbGqUtXf7ZcU473v5xPBvRZWZX+ympKxzAl30=; b=gTjyJZjhiAy3u7j1jlvbeMcQFf
        z4FBEGwiWM4BHKczdnLarVUBPZjLZNPlNMQFOouxODWR7HoXgY5qhIjKWa6rZA5a0CpA5Yq6Dx/F7
        bhAQriXOE9/5oSUFXKQ5VW0wlTHe+mCJ4ea7FJWdojCVqJOd14ayEw99DKF3B3tC8mZFQ+He448s6
        HVFAOEFbpBOz30vw6qytUcWPB+aUynNMXkBJ9Vf90yk+Cxe/CXf9t+qOCLfEAIetY1tgrnvF+uNPv
        9sIeNOgJN0LbFDCYZuOUArwMNZNpL8LMlN8WmIsIEtSPkEJ5U+/DvDdLFh1ufW5nszpcSqaeIuk0d
        xGay8ptQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8HMu-00637Z-K0; Mon, 04 Jul 2022 08:23:44 +0000
Date:   Mon, 4 Jul 2022 01:23:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/13] block: add bdev_max_segments() helper
Message-ID: <YsKjkIGBeUV/h6eD@infradead.org>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
 <a3eed5d77f1cd3c7768780356f1528f9ce6e540a.1656909695.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3eed5d77f1cd3c7768780356f1528f9ce6e540a.1656909695.git.naohiro.aota@wdc.com>
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

Please Cc the block list.

On Mon, Jul 04, 2022 at 01:58:05PM +0900, Naohiro Aota wrote:
> Add bdev_max_segments() like other queue parameters.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  include/linux/blkdev.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 2f7b43444c5f..62e3ff52ab03 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1206,6 +1206,11 @@ bdev_max_zone_append_sectors(struct block_device *bdev)
>  	return queue_max_zone_append_sectors(bdev_get_queue(bdev));
>  }
>  
> +static inline unsigned int bdev_max_segments(struct block_device *bdev)
> +{
> +	return queue_max_segments(bdev_get_queue(bdev));
> +}
> +
>  static inline unsigned queue_logical_block_size(const struct request_queue *q)
>  {
>  	int retval = 512;
> -- 
> 2.35.1
> 
---end quoted text---
