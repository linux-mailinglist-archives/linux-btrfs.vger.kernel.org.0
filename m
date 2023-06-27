Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE16740048
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 18:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjF0QDN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjF0QDI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 12:03:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60862D5E
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 09:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kDerNSgaQ1VkiUf2NHr6XOPn/o9xoESWwmN66rAR3vM=; b=hTDkW18dDBUz9vSx0/ZlJxp3pM
        TJnXBoF2mRZggQzBKSQ/NtygrJOFVTH32b191sNsFxvk3WQXG5tLDnrmYDCKATlfZ5NfhwKJzos3O
        T6XEhVi3SfmOrtOGJb8v/RrU/nSsUB9H++5hykwKeGksbhQEpROeAy08k5zYQtJC+HtLuxtcLmqkW
        jt+qxjuDsB9fBNCJG9IPQ40wDoZ7MRolQ/QJ/hnHhaW5KiOLd43O2rtpY/H0D8oH/xGDKb2wm4fiq
        lPkYeFTm9Wn2sq4h0vqCuSxSaDMBMpKi3b+2+brbLdgV24kOQYCnQkwuFsITWkM2o9yOHPnTKZzXS
        f/1tc1qg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qEB9n-00Daa3-2F;
        Tue, 27 Jun 2023 16:03:07 +0000
Date:   Tue, 27 Jun 2023 09:03:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: avoid duplicated chunk lookup during
 btrfs_map_block()
Message-ID: <ZJsIO81Qa8oZnJC+@infradead.org>
References: <c063726e0bdcf99226ba474f93b56f9fd2f939f3.1687848314.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c063726e0bdcf99226ba474f93b56f9fd2f939f3.1687848314.git.wqu@suse.com>
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

On Tue, Jun 27, 2023 at 02:45:18PM +0800, Qu Wenruo wrote:
> +	num_copies = map_num_copies(map);
> +
> +	if (mirror_num > num_copies) {

num_copies is only used for this single comparism, so I think we'd be
better off just dropping the variable and writing this as:

	if (mirror_num > map_num_copies(map)) {

> +		free_extent_map(em);
> +		return -EINVAL;

And I'd probably add a free_extent_map label to the end of the
function and jump to that to avoid extra error returns.

