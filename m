Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E83749F0B
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 16:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjGFObm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jul 2023 10:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjGFObm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jul 2023 10:31:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B9A1BC3
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jul 2023 07:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GW+N3x8WzrCYanucM4VlK6S233mEzWg5JfXmRk4Hmws=; b=oD32JtwQ/EQ1PQJAlb/Rx/zBfM
        zQomzK+/0vE3+ECKChDCVr5flUx/yyYRqjiNOpOLnCr/s5D78zM3oWIceS/D6xsoMVQ/78e2i2eRH
        0qUB7SceumaH2kVM0/WfbZfUmMOmMSHUztctrTqqFOCDKyReqDljGZP8N+1vVHiY6/Cu6cX7NEptV
        vgvt+myM+yUwYKFYWxnrcNCFOCM1NVQ31tSgTdY+O8uik0BlnQkGLpu1lu61VJQQj2fN4aTdRXnvX
        1JJMk2mhkL9uG4gLRBAWiI9Wj9UtHT8ffQ4iA//G2T8HrIcrWANqkp1cG8aONg+Ia2tkNV9cOPASH
        sZ+tF9qw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHQ1F-001sWr-1b;
        Thu, 06 Jul 2023 14:31:41 +0000
Date:   Thu, 6 Jul 2023 07:31:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs-progs: set the proper minimum size for a zoned
 file system
Message-ID: <ZKbQTd+EJf6wS6Sn@infradead.org>
References: <cover.1688648758.git.josef@toxicpanda.com>
 <5e89618345f65a3aa4f89c4b7894d28767ea8c42.1688648758.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e89618345f65a3aa4f89c4b7894d28767ea8c42.1688648758.git.josef@toxicpanda.com>
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

On Thu, Jul 06, 2023 at 09:06:57AM -0400, Josef Bacik wrote:
> +	if (opt_zoned && block_count && block_count < 7 * zone_size(file)) {
>  		error("size %llu is too small to make a usable filesystem",
>  			block_count);
>  		error("minimum size for a zoned btrfs filesystem is %llu",
> -			5 * zone_size(file));
> +			7 * zone_size(file));

Wouldn't it be useful to have a helper for this?  Yes, open coding it
only twice and right next to each other is probably ok, but I fear
we'll grow more uses.  And a helper is a really nice way to document
the details anyway.

