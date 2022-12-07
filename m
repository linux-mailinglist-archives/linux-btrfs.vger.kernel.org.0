Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AFB645462
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 08:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLGHJZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 02:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLGHJZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 02:09:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E162DC8
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 23:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iot1OqgiSKhSanzWmdYXH2FiIczMCyuAEe6cJGiNvaQ=; b=zWPZ1CYpcD7FgTPfse3Rp6cFVp
        SxIYYsGxs/DLIceX9C2+UvbBI1zb8k89udh8Nyw+8OZWu/WwOY+A4quV7dVY86BKlk4XODKzEpXfA
        54xCUqegZ3SZZv4kqW8p/dtIqCan6pZrt2SEzwlJf6JRdaiWDKTGM0tbYKcf9Jt6KHLlD84lpIUt2
        ye5jZKwBgN2XzKaP75VQVjQknEVqtRTi+rrpupY761cKf7n71Go7biEi/gfx1/pKyv+/T3SJUWQ3I
        0EyUjRMSaex28FHg6BtSZRUpzviyH+ngyhAM+sRNjNv3MV60Y1KF2aIZNB6GwnN1Dpm+PL97YFhuK
        rEST/k0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2oYT-00Dtdx-Cf; Wed, 07 Dec 2022 07:09:21 +0000
Date:   Tue, 6 Dec 2022 23:09:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: make btrfs_get_io_geometry() to return void
Message-ID: <Y5A8IWC6z/LZHRcI@infradead.org>
References: <b3d2350ae3920a475a43dba6f979731420859dc8.1670390031.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3d2350ae3920a475a43dba6f979731420859dc8.1670390031.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 07, 2022 at 01:13:54PM +0800, Qu Wenruo wrote:
> Since commit 420343131970 ("btrfs: let callers of btrfs_get_io_geometry
> pass the em"), btrfs_get_io_geometry() no longer calls
> btrfs_get_chunk_map(), thus there is no more source of errors.
> (The remaining ASSERT()s are really for careless developers)

My btrfs-bio-split series removes btrfs_get_io_geometry entirely.  Can
we avoid spurious cleanups for now until that series is merged?
