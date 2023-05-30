Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F81771551D
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 07:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjE3Fm6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 01:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjE3Fmf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 01:42:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D161984
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 22:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/q9jL3NgIl4dxTgbAYkewXN7PmXpb6NB5sLlP1fxubY=; b=kERyPoRZiiQqcsfSqz5WIpYfGm
        rPS81YYKeAYuxOKINIFPHUJELgAiFk916QJx6/04+ZZgvs8S/sORc3DClV5xlGbP3aTdGFeGdeUcM
        IZmGS4dRdL9qeUu8ou6SuRz0SeUdGalyAFCE6eF/ZLMpiJ5XSLORSSdhNGuih+waI7sQt0uf5JGJg
        kr6POWYsfzE5Xpkz95FHL18u7CRovBtLm4M0bcOjhBMIikphpYWqjsS++VfT1XMwrTgBaXmszAGtS
        DkZvR4/9sg4Ne/yXnAMULcOUC8jg/qOHLAtDQDqx9AiP1tGqoZinSO5NsWNMt+ekZR3705+Ij0kc3
        FBiEXoQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q3s6t-00CUqg-1N;
        Tue, 30 May 2023 05:41:31 +0000
Date:   Mon, 29 May 2023 22:41:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] btrfs: make alloc_extent_buffer() handle
 previously uptodate range more efficient for subpage
Message-ID: <ZHWMi0N0r3i+ruGc@infradead.org>
References: <cover.1685411033.git.wqu@suse.com>
 <dcacf1177cd31b969bb61910e49ed3397d796ee3.1685411033.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcacf1177cd31b969bb61910e49ed3397d796ee3.1685411033.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 30, 2023 at 09:45:27AM +0800, Qu Wenruo wrote:
> Currently alloc_extent_buffer() would make the extent buffer uptodate if
> the corresponding pages are also uptodate.
> 
> But this check is only checking PageUptodate, which is fine for regular
> cases, but not for subpage cases, as we can have multiple extent buffers
> in the same page.
> 
> So here we go btrfs_page_test_uptodate() instead.
> 
> The old code doesn't cause any problem, but not efficient, as it would
> cause extra metadata read even if the range is already uptodate.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
