Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819EC75FA4A
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 17:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjGXPAG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 11:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGXPAF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 11:00:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C40E56
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 08:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=InB7KEyV9HSNKAo2YOsACoe1PSxsiZxh5JGtpzObSy4=; b=Q5ccNU1g6S2rZds+OOB325na2J
        IDU275lnaHwIxmQqzBxI5kbgnmmAKuM3fcQBYbEBUV82jD3LATpkFcWsSwgiC/P6iNeRxW19XSayn
        epY1AeeYeAe5AkVI4jtGVSvCVIRHWG//CaDlAUpg9Y5G61kIgMZltl781NxByEJMzFnNW7FExUpdI
        MdEs/oJvO/ntxmWzAea46/NHu8P3fLUES7a5sURZc2qKmBdCZ8eZtzBJUA2d6S7KiBfyASo89T7Zk
        6mi3nTCqGpqYETrQwh6EM+GQqbSXiNiGlMqrXe1qjunlaV3/FaqKaVPibllpbb20k40ifa66LjDrR
        fu+xWkOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qNx2a-004fFD-1G;
        Mon, 24 Jul 2023 15:00:04 +0000
Date:   Mon, 24 Jul 2023 08:00:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/8] btrfs: zoned: introduce block_group context for
 submit_eb_page()
Message-ID: <ZL6R9OwFlwwmrcKo@infradead.org>
References: <cover.1690171333.git.naohiro.aota@wdc.com>
 <d20226362b9b193d85f63e81ee128ef3062e2203.1690171333.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d20226362b9b193d85f63e81ee128ef3062e2203.1690171333.git.naohiro.aota@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 01:18:30PM +0900, Naohiro Aota wrote:
> For metadata write out on the zoned mode, we call
> btrfs_check_meta_write_pointer() to check if an extent buffer to be written
> is aligned to the write pointer.
> 
> We lookup for a block group containing the extent buffer for every extent
> buffer, which take unnecessary effort as the writing extent buffers are
> mostly contiguous.
> 
> Introduce "bg_context" to cache the block group working on.

As someone who already found the eb_context naming and handling in the
existing code highly confusing, I wonder if we should first add a new
eb_write_context structure, which initially contains the wbc
and eb_context pointers, and which also would grow the bg.  This
should make argument passing a little simpler, but most importantly
removes all the dealing with the double pointers that need a lot
of checking and clearing.

> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 5e4285ae112c..58bd2de4026d 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1751,27 +1751,33 @@ bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
>  				    struct extent_buffer *eb,
>  				    struct btrfs_block_group **cache_ret)
>  {
>
>
> -	struct btrfs_block_group *cache;
> -	bool ret = true;
> +	struct btrfs_block_group *cache = NULL;

.. and independent of the above comment, I also found the "cache" and
"cache_ret" namings here very highly confusing.  What speaks again
using a bg-based naming that makes it clear what we're dealing with?
