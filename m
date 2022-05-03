Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3375187CB
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 17:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbiECPGx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 11:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbiECPGv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 11:06:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4B13A19B
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 08:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Ri1mCOdk2PBHhZ/rwoR9MKmZuAMk24N56dvHy3BdWM=; b=ukclAIQatKaYJh1nojj/7nD/VC
        CPtvgJkrTcfbQcbdZQqKfOjW5NBXeqPLY3LO86+zZQEuOLeeEItRpm1mydVxtwPT2okYHZGkSCG6o
        LFzunAy/YT9s34zTxA7NXCi42uCiypnTU3lRaN/HC6En4urJeLqxjdVqzzzWdynbPwTJQzFzkVX6o
        ZT/y0qiI0RbNWnhEXyQOp2lMXF1qPaKMRa0+gCYYidbbXhFpaehmPg3jKGeJLC65TgGrmpYjahAHH
        hwL8qaGGpgPCZdtpHbjSiVramMcSIJ6bIwK6KUThAh7NrQI0niioeSbVcbJn/Q8qQbfC5+mMC5lbK
        SHw8H2fQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlu3Y-006OfV-I2; Tue, 03 May 2022 15:03:16 +0000
Date:   Tue, 3 May 2022 08:03:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/13] btrfs: introduce a pure data checksum checking
 helper
Message-ID: <YnFENPsSt4owgvx2@infradead.org>
References: <cover.1651559986.git.wqu@suse.com>
 <c46edf2e09f5924d00174bed98ad1d8a78c80d81.1651559986.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c46edf2e09f5924d00174bed98ad1d8a78c80d81.1651559986.git.wqu@suse.com>
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

> +/*
> + * Verify the checksum for a single sector without any extra action that
> + * depend on the type of I/O.
> + */
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
> +	kaddr = kmap_local_page(page) + pgoff;
> +	shash->tfm = fs_info->csum_shash;
> +
> +	crypto_shash_digest(shash, kaddr, len, csum);
> +	kunmap_local(kaddr);

Nit: the ->tfm assignment can move out of the kmap section.  Otherwise
this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
