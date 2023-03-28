Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAE76CCE21
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 01:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjC1XhL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 19:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjC1XhJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 19:37:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0E1199
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 16:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ezS0bjX6jxNz6VRKQ1AC7wlxIFe6eBWAkYw/IrXcKBg=; b=lLkhrlHtbt0fiXjy3IAEnmtwny
        TqiZvDvJpEYTNmHstuQGfHhUcEiuixt/CMQoDsfA8QyaUil6BSQcBFSTfuth1qaccTzO9x6Do4JgM
        GELCeNFc1hbxV17SUI4xSYqDK7p4vE4/D73WGkD48IfBqrDyokcMlYN47uaJPus6biNFGwyDzXvZA
        EiBt55k/MSawxnN5rwAm/ABWP6o3MmWHczKgWQEKuPuFLTDShYZDgxRfpJr5J920eiXuWb4O3X+v9
        Govqq7ZWh95NTlvhTog5rS8Sp+PqX+F/bOVShupwkNQwq3Xgqt3lwxaQY3Tj4fydiAUBW5brZ6i0M
        Ny82MeTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phIsE-00G873-1t;
        Tue, 28 Mar 2023 23:37:06 +0000
Date:   Tue, 28 Mar 2023 16:37:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/12] btrfs: scrub: use a more reader friendly code
 to implement scrub_simple_mirror()
Message-ID: <ZCN6Itm8dkY8w9P/@infradead.org>
References: <cover.1678777941.git.wqu@suse.com>
 <ZBF5M5R3pDdp/075@infradead.org>
 <2dfc49ef-e041-3efd-1c55-3685df22acb6@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dfc49ef-e041-3efd-1c55-3685df22acb6@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 28, 2023 at 05:34:03PM +0800, Qu Wenruo wrote:
> Currently I just do a single patch to cleanup, the result is super aweful:
> 
>  fs/btrfs/scrub.c | 2513 +---------------------------------------------
>  fs/btrfs/scrub.h |    4 -
>  2 files changed, 5 insertions(+), 2512 deletions(-)

To me this looks perfect.  A patch that just removes a lot of code is
always good.
