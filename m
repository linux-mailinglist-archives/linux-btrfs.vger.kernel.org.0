Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B59514ECC
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 17:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377725AbiD2PQP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 11:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiD2PQO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 11:16:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89445D447C
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 08:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AnVpib+N/9oR4R907B1WRB3p9rU5ohvmNd2HSih7kyc=; b=UyX2qQnUW5OyQrzntkwFzGhK2U
        3bd0r6oHSJnxnO/zUSmipWBfpnwlT8DaBi9GVhbI4nrcUC9VBiPMAw/Bzu1GffvbaVSrJXIGg99Lz
        7hQDH2KVQ8uVfpnwHh/uvgS5ibjdSOuSsMQXj3e+JsxjsuM+hCA3dKUfPR6kyFpxAx2D71Z+WGZLE
        9oZiPXHKfHNWOmQdgCubogO4DK4GbmyJ2ePRm2LiJOeO7b80muPvwfmyIlpbmG8qPDAbDKfOC1PMw
        PW6V5T7l1T2UiVodPsrwjegb3lZEju3i6QO0GhjpZIhAIQAvAtxdDK09pfQwl6SqUDORCw725/lRC
        nkL2WuCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkSIf-00Bj2o-63; Fri, 29 Apr 2022 15:12:53 +0000
Date:   Fri, 29 Apr 2022 08:12:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC v2 04/12] btrfs: add btrfs_read_repair_ctrl to record
 corrupted sectors
Message-ID: <YmwAdTZxe5o516pV@infradead.org>
References: <cover.1651043617.git.wqu@suse.com>
 <ad61ab273c5f591cb4963f348c4b34302f705705.1651043617.git.wqu@suse.com>
 <YmqYm+iFDSRTbV5W@infradead.org>
 <b27d0b0f-89de-13a5-013b-323e03d7cc40@gmx.com>
 <c3aeca2d-61bc-9a00-dcca-61aa6bf99c45@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3aeca2d-61bc-9a00-dcca-61aa6bf99c45@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 29, 2022 at 08:09:38AM +0800, Qu Wenruo wrote:
> On the other hand, we're already allocating memory inside endio
> function, for a long long time.
> 
> Check endio_readpage_release_extent(), they all need to pre-allocate
> memory for extent tree update (although using mostly ATOMIC gfp flags).
> 
> I guess it's an abuse and we would like to remove it in the long run?

Yes, we should handle it.  In practice small GFP_ATOMIC allocations do
not fail, so this probably hasn't been much of an issue.

Allocations that can be rather larger like the bitmaps on the other
hand do have a real chance of failing under enough memory pressure.
