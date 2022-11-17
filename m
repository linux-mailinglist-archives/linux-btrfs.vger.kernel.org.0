Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89C262D388
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Nov 2022 07:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKQGhx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Nov 2022 01:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKQGhv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Nov 2022 01:37:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26766A6BB
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 22:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f8o0KrJ8u+BR3EbPG1bikt9b7n4jq5sgaSfx2Nam4KU=; b=q8eSkQnMHWQDOMa2PF0g2xsHuC
        bl7ciizLwNX9tnu91W1pcu2WXfzjjBC0Hiq8+5SjTib9jl48jJPH2FjGEXzGx4olapLJns+7ciWW1
        QBkOUYpxNgwLBJcYJ5hBqVFcuwRrVXn9z6ZEqg+HHfLMdGed5RJjues5VUEluj8ULYXb5+TbcSRQB
        vVlXlucynV4TggA1VDwf+fhiAFdsDWdWK2w5IYS7FFjzUY0KIgbTvddpX7easeAN/H3U3YiEJDgDG
        kmljoTH+qfDa3upwId+/4YUl9GBRGEPgolUiasq50lTwjjPqy1xfl9ewOZ2uFKOSNQxxYqI4HAxPB
        rTb0TjUg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovYX0-00AsvU-Ho; Thu, 17 Nov 2022 06:37:50 +0000
Date:   Wed, 16 Nov 2022 22:37:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: check the superblock to ensure the fs is not
 modified at thaw time
Message-ID: <Y3XWvjr/lISvY8E+@infradead.org>
References: <41c43c7d6aa25af13391905061e2d203f7853382.1660199812.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41c43c7d6aa25af13391905061e2d203f7853382.1660199812.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 11, 2022 at 02:36:56PM +0800, Qu Wenruo wrote:
> [REPRODUCER]
> We can emulate the situation using the following small script:

Can you wire this tst up for xfstests?
