Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111EA7AD3E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 10:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjIYI5m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 04:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjIYI5l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 04:57:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7160C0
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 01:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1tNQ13VzxwChrsKIHRsxGAp+ppXDudOujMZHipPtuyY=; b=xcNLHcx5kxsYCN92bUaAfe/kIG
        c8sJUwUR4o3elzpiNV2vgEYxGvkMLZla61Iu6v2pg3Y4IOdalSc9TR30O4Q1X/pYjakkJ6FfrzPj3
        YarEp0MOESICOXGkcf4CTZeelIYcjScqWX6btbsT171ZNKwa+Wl/sSrFWbyAsDphteQtuiM7gEbUq
        J6JollYiJ1kKkuhtLVLhaOqEwG4atBWzsiQIvrddYfCGiJACWOnca+IHkcmfFgehMpPYkVnVwix1m
        Atf/SLaWNuEjlaetBg/vVbSLBc8XdfwLcOJY0ZXECUJuvavTcWTYRKQNmdt6+iwSiusf6G2XOCoy/
        Hc2THEHQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qkhPJ-00DmyU-1R;
        Mon, 25 Sep 2023 08:57:33 +0000
Date:   Mon, 25 Sep 2023 01:57:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH] btrfs: fix a race which can lead to unreported write
 failure
Message-ID: <ZRFLfTSMBXs+JTkc@infradead.org>
References: <8bc4c2aaa8d32ad92838b3778a85660ba7c6bfa8.1695617943.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bc4c2aaa8d32ad92838b3778a85660ba7c6bfa8.1695617943.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 25, 2023 at 02:29:28PM +0930, Qu Wenruo wrote:
>                Thread A                |            Thread B
> ---------------------------------------+----------------------------------
>  btrfs_orig_write_end_io()             | btrfs_clone_write_end_io()
>  |  this bio failed                    | |  this bio failed
>  |                                     | |
>  |- atommic_inc(&bioc->error);         | |
>  |- atomic_read(&bioc->error)          | |
>  |  So far we only hit one error,      | |
>  |  thus can still consider the write  | |
>  |  succeeded                          | |
>  `- bio->bi_status = BLK_STS_OK;       | |
>                                        | `- atomic_inc(&bioc->error);

I don't think this scenario can happen.

btrfs_clone_write_end_io increments bioc->error before calling
bio_endio on the orig_bio, which is the earliest time
btrfs_orig_write_end_io will be called for this original bio due to
the earlier bio_inc_remaining.

