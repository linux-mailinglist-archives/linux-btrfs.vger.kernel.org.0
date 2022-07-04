Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B31D56543C
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 14:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiGDMAP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 08:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiGDMAO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 08:00:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7556411810
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 05:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5wkWcfZrReTGK0IVrxFNbYUiNOZl4DMKcLd+W3JqIN8=; b=U7lzFI/DjfkjRRDcek8kf9okfE
        BpD5xNXGMWhx69YwFOHSzfq9uFGHGRd2q6r/tezdJAEEPWa3I2ey/5zqQBGhqdqUD+4YH9w7yHEtt
        UhKValjUjf2mhYNLnzfaUpT8cAveXBipOiOXlMReJd86cbzWgxyxBjRHgdXZwnUrqRImvXsktcYoS
        Y87lmlsZZyzWwCkSYgfofMtlR8T5Bvm9dgLxtq1kv6wQIRNLzUVRayPKKaM3OJqxKOr6+AwpTG0On
        sRooQ/guATTWA8YhVSF43Ycv3n36tAoChIjwrSA81cq0P7+CgbnwY5qXvmPpsmJZ9m23cKz8+AnmV
        KyfYwrDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8KkQ-008IFS-3R; Mon, 04 Jul 2022 12:00:14 +0000
Date:   Mon, 4 Jul 2022 05:00:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: don't fallback to buffered IO for NOWAIT
 direct IO writes
Message-ID: <YsLWTuUF0nq+sFKw@infradead.org>
References: <cover.1656934419.git.fdmanana@suse.com>
 <1a7080444b73f8ca1481a7786e52bdf405193be9.1656934419.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a7080444b73f8ca1481a7786e52bdf405193be9.1656934419.git.fdmanana@suse.com>
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

>  buffered:
> +	/*
> +	 * If we are in a NOWAIT context, then return -EAGAIN to signal the caller
> +	 * it must retry the operation in a context where blocking is acceptable,
> +	 * since we currently don't have NOWAIT semantics support for buffered IO

.. more overly long comments here.

> +	 * and may block there for many reasons (reserving space for example).
> +	 */
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		err = -EAGAIN;
> +		goto out;
> +	}

but more importantly, shouldn't this be above the buffered label? The
only places that jumps to it is the alignment check, and if the
alignment is incorrect now, it won't get any better in a workqueue
context.
