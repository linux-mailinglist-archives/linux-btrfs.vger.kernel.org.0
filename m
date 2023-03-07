Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BBD6AE800
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Mar 2023 18:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCGRL4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Mar 2023 12:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjCGRL2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Mar 2023 12:11:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAE99F211
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Mar 2023 09:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eXDku7izujPJrUySzt0XDBl0NC/70wjiSscTHUhcjMc=; b=j/YGHxBNkGJAKLyij54RkkNywb
        b49ciPzZfpzeryaz0Il1yjXL2ZDJw/gpWmbgpgOqFg6UjC1XPBKypfmC+HWbjYqHJ2z0DuwMgY6iR
        T73w34l4SAkxQPavapQy72p2IQsgbT0YP/mGB1K4DfcLOuVm4MAMecyGlFU57x2E1n4FdYNCYxr7d
        Rklf8mEe0vvPODNv5FSQ3M9VzsuxnfFDbV3/hKUZDBudlBcb2KV+q08NBK4s7ZPsZDb0t2LhludcE
        Z05EcTgbjo+giZrGPMLxGFvtWhRtqvJjjVWDA5ePJuO6OmM+tIwUPgQXebQBLXYURLQIvddRHBV7b
        1tqxgf2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZalF-001jnd-0J; Tue, 07 Mar 2023 17:06:01 +0000
Date:   Tue, 7 Mar 2023 09:06:00 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 20/21] btrfs: Add inode->i_count instead of calling
 ihold()
Message-ID: <ZAdu+C8AMlcUOBhH@infradead.org>
References: <cover.1677793433.git.rgoldwyn@suse.com>
 <c201e92c0a69df45a8f1c4651028ccfb30aebdd2.1677793433.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c201e92c0a69df45a8f1c4651028ccfb30aebdd2.1677793433.git.rgoldwyn@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 02, 2023 at 04:25:05PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> I am not sure of this patch, but put it to avoid the WARN_ON() in
> ihold().  I am not sure why the i_count would drop below one at this
> point of time since this is still called within writepages context.
> 
> Perhaps, there is a better way to solve this?

How do you trigger the warning?  Basically i_count could only be
0 when doing writeback from inode evication, and just incrementing
i_count blindly will do the wrong thing there.
