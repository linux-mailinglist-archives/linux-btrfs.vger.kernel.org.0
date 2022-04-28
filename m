Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DC2513510
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 15:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244483AbiD1NaG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 09:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347364AbiD1NaD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 09:30:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17315B18A0
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 06:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=owf15afuIjlwd/z3v9l+JM9oT8X2Iqc4Z5z40Qb3gg4=; b=ohmhpK5OJTnABkf/a3Aetptk3a
        4iKr8wPGUu0n0MQ6ESlmY1GwG4s0ZLUxI0IE5gw0RYiURGTJamXXB6SZDg0rr8b2JTJ9uUC6LzbaM
        U/VrT3+gyKRw40oHjFxAvJVoicWs6ur0gjKqx+lW8flNpJgw7cVJgCNQbskNCBT+NtZBt77DOn0NU
        gz80f5s7iq03/Y8VOsucx1xfRQm5ODmom2xOtCGS97PZD9i57xJ47dw8bMREp33fW5HMm2KORqVbD
        0U3yq8qotuVbda5ZMwrWp5uQl8ZkUL6493u469M+Dg+p3GaYRifU4ycBnT+Ghy5kA9UsKM57lMa7P
        +J8xGaWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk4AS-00722X-NO; Thu, 28 Apr 2022 13:26:48 +0000
Date:   Thu, 28 Apr 2022 06:26:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC v2 01/12] btrfs: introduce a pure data checksum
 checking helper
Message-ID: <YmqWGG/mcVvHY3tT@infradead.org>
References: <cover.1651043617.git.wqu@suse.com>
 <552b8ca1c4757a9b1fe85c2545d951d12422dfd8.1651043617.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552b8ca1c4757a9b1fe85c2545d951d12422dfd8.1651043617.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> +/*
> + * Just verify one sector of csum, without any extra handling.
> + *
> + * Functions like btrfs_verify_data_csum() have extra handling like setting
> + * page flags which is not suitable for call sites like direct IO.
> + *
> + * This pure csum checking allows us to utilize it for call sites which need
> + * to handle page for both buffered and direct IO.
> + */

I think this is way too much historic context that's probably soon
rather irrelevant.

I'd simplify it down to something like:

/*
 * Verify the checksum for a single sector without any extra action that
 * depend on the type of I/O.
 */

> +int btrfs_check_data_sector(struct btrfs_fs_info *fs_info, struct page *page,
> +			    u32 pgoff, u8 *csum_expected)
> +{
> +	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> +	char *kaddr;
> +	const u32 len = fs_info->sectorsize;
> +	const u32 csum_size = fs_info->csum_size;
> +	u8 csum[BTRFS_CSUM_SIZE];
> +
> +	ASSERT(pgoff + len <= PAGE_SIZE);
> +
> +	kaddr = kmap_atomic(page);

Please switch to kmap_local_page while you touch this.
