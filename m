Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EFF71083A
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 11:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbjEYJCf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 05:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbjEYJCe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 05:02:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DAEA7
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 02:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HKMBMhU8tfqn+8/E5oMqty+ckcj0lJCFKph6P7IU2qQ=; b=BFTqr/rViOyI0QVqMpik/FhsNO
        bEB7MUAsaRCT7eNUSdECFWnQDCJfFS9aoqI1MH/N96NYbmZKXBovStGmk67UNrxVuX8F8TREqTVzw
        qGfYQpO4VWiGV/PM0luULMGJ2fOwFdO2cSUgI2AB0ucD6kI32i+74cuVF1FAexes8OqriGS6K2/CN
        vk/wlNmhc/OqVmbzUytkdK4c94f05gIvBdbtusaTWB3UT6mYyRg4jaxsTrh0RWbKD7i/HoAZJ9a1z
        70W01nyBxhF0j381P24Gbh2XU3g0MHpJ9r6A1ocRDVqKnUzFXohfJitvHd0jEZOUPN6E+7GjGby3Q
        95jDzVyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q26rh-00G5AG-0C;
        Thu, 25 May 2023 09:02:33 +0000
Date:   Thu, 25 May 2023 02:02:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/9] btrfs: open code set_extent_bits_nowait
Message-ID: <ZG8kKU16PA8SF3Pg@infradead.org>
References: <cover.1684967923.git.dsterba@suse.com>
 <a497320d91b1e08e0766f44844746e235478630e.1684967923.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a497320d91b1e08e0766f44844746e235478630e.1684967923.git.dsterba@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The change itself looks ok to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

.. but:

> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index bda301a55cbe..b82a350c4c59 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1611,8 +1611,8 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
>  	memzero_extent_buffer(eb, 0, eb->len);
>  	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
>  	set_extent_buffer_dirty(eb);
> -	set_extent_bits_nowait(&trans->dirty_pages, eb->start,
> -			       eb->start + eb->len - 1, EXTENT_DIRTY);
> +	set_extent_bit(&trans->dirty_pages, eb->start, eb->start + eb->len - 1,
> +			EXTENT_DIRTY, NULL, GFP_NOWAIT);

.. there is no point in even using GFP_NOWAIT here, as we are always
called in a context that can sleep, set_extent_buffer_dirty relies on
that as well as it calls lock_page.
