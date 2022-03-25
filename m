Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B837F4E7909
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 17:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239020AbiCYQjy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 12:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240578AbiCYQjx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 12:39:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A099DF1C
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 09:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jK478wm8MCnJEYasf85auldQDgCapFmjHfc40fBxnmo=; b=HfnQRo+PSz6uCeZwNe4n6FTA1J
        RpKnrtGHS4IGgjBex+3LLkEdBYnNdvciM4i8LVF8KReAPrYXxcZSdTFp3zqxsvdf5EqkYNiJs4wV1
        d6NcJB8iEs+aqKA286pizdw7DiCz01qGe4HsJQzJ75MQUtqkmLGU3/NZue9DW5YuT8EBG/KlskeDM
        FTg7WZpK/NiE1K/LH/Zrm0yrbsPXaLS/2OJmBJxWn8UJAP0ezx7DHAhaWlhB55wKl0LcnAoVGR6hj
        +Ca8Zc9UY0yMScGI027zodlVRgkqHQXtm5jbeJIpWvZiO7uuR1rqmtZfPL4VNtTwyoYXJgtRAq0AG
        X6xAXmFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXmx6-002ct3-K5; Fri, 25 Mar 2022 16:38:16 +0000
Date:   Fri, 25 Mar 2022 09:38:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Message-ID: <Yj3v+MnFOXeeAU9d@infradead.org>
References: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
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

On Fri, Mar 25, 2022 at 05:37:59PM +0800, Qu Wenruo wrote:
> -	u32 len = fs_info->sectorsize;
> +	const u32 len = fs_info->sectorsize;

Why the spurious and rather pointless const annotation that is unrelated
to the rest of the patch?

>  					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
> -	memset(kaddr + pgoff, 1, len);
> +	memzero_page(page, pgoff, len);
>  	flush_dcache_page(page);

memzero_page already takes care of the flush_dcache_page.
