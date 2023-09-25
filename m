Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410F97AD463
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 11:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjIYJUW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 05:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjIYJUV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 05:20:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F84BAB
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 02:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4aWhzqurUcZsCBtRMlL5q5BzhBYNB67cRIjVqkUoTOg=; b=4Vf/320xjnUCJhJ4VNTs1JCSmt
        vtU45qehz0DPPhuwDi9KbVaFbv9aVZmYKhU1FxRAxjabwpVKi93z3jLvKnPQJp8GrwsKUXsthxJcD
        9pW+iOXmjEUT2Bz4d9u5MoY2dTISlLYz5WpxZkHeo6Uugu4DtqANFo2qJMb5utegAex+p7Plv+/zE
        RjHGO/ZbQYuqWrr7uuSxsZcr/fYWOXsBmSlbas2OWgLZ7Ste5iDsxUCbj747vLZVhosNT3RxLJ5eo
        qti3dL8+Ob/aTAHUJlhlPKj3sSRadF3q97HiJhp1icG+Kw5twouuHXMCnrjdx1dTGCZ+v+wz5zZkn
        HzlEklGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qkhlF-00Dpma-20;
        Mon, 25 Sep 2023 09:20:13 +0000
Date:   Mon, 25 Sep 2023 02:20:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix a race which can lead to unreported write
 failure
Message-ID: <ZRFQzT/Gro1OmnLI@infradead.org>
References: <8bc4c2aaa8d32ad92838b3778a85660ba7c6bfa8.1695617943.git.wqu@suse.com>
 <ZRFLfTSMBXs+JTkc@infradead.org>
 <ff3e9fc1-3c22-4645-8442-b08212a6c67f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff3e9fc1-3c22-4645-8442-b08212a6c67f@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 25, 2023 at 06:47:50PM +0930, Qu Wenruo wrote:
> Sorry, I couldn't find out a hard guarantee to make
> btrfs_orig_write_end_io() to always be executed after
> btrfs_clone_write_end_io().

That is how bio_inc_remaining works.  For each call to it you need
an additional bio_endio call to counter it before ->end_io is called.

So no matter how fast orig_bio is executed by the underlying
driver/hardware, btrfs_orig_write_end_io will only be called once
both orig_bio itself and any clone has completed.
