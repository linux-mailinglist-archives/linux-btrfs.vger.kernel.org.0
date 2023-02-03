Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CBD688F99
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Feb 2023 07:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjBCGTn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Feb 2023 01:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjBCGTm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Feb 2023 01:19:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C905018AA1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Feb 2023 22:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RwvYHZ9HQqy/IeMmqFwlAGsnZUX6Xta3mxCb4N18zD4=; b=lcbBxbNK3fpzo+5+fpypJM8l0Z
        1V/7ClgRRmJNpZYrETWWDwYrj7zES3NnopRVF97ukcvBqJH4t49wFcO82XN57oRQSaNFZ+rX6O5eL
        C39joTh83s78ucH3V5V2X6LEJiw5tpEVDexrcNnBi2acv8PEprcpFEOOmpg8hZDTvtppU4pqCSJhu
        23sTjD3OHZ5iQtZSEkS+/7JMclcQkECLidHdWUQPCAzCIwy4xjYpE+q3GjU9P6PTE80E0rfydvNyy
        jnxRRIHDOFLuNuNYPf+sXs50Tw8tlrTVWUkXwf2HXbmjXojfSD37K+b+jJC8U24gVe9PVk+5OBFJ1
        6K6tJ7Wg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNpQ9-000YN1-9K; Fri, 03 Feb 2023 06:19:37 +0000
Date:   Thu, 2 Feb 2023 22:19:37 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: small improvement for btrfs_io_context
 structure
Message-ID: <Y9yneQhuePjT/92P@infradead.org>
References: <cover.1674893735.git.wqu@suse.com>
 <a02fc8daecc6973fc928501c4bc2554062ff43e7.1674893735.git.wqu@suse.com>
 <5195283e-7e3d-6de1-75f4-d7f635bfc0ab@oracle.com>
 <61d2d841-778b-ca13-cc41-ca115b5ed287@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61d2d841-778b-ca13-cc41-ca115b5ed287@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 02, 2023 at 02:47:13PM +0800, Qu Wenruo wrote:
> Because the tgtdev_map would soon get completely removed in the next patch.
> 
> Just to mention, I don't like the current way to allocate memory at all.
> 
> If there is more feedback, I can convert the allocation to the same way as
> alloc_rbio() of raid56.c, AKA, use dedicated kcalloc() calls for those
> arrays.

The real elephant in the room is that the io_context needs to use a
mempool anyway to be deadlock safe.  Which means we'll need to size
for the worst case (per file system?) here.  Fortunately the read
fast path now doesn't use the io_context at all which helps with
the different sizing optimizations.
