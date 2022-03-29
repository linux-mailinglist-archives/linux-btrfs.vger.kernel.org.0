Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396764EA7BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 08:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiC2GSr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 02:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiC2GSq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 02:18:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC65247C37
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 23:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BSkGc0s+wsQxmxv3a9HbCr2VNWxpF+Bli0hF4kRC81A=; b=jmQ+ZsSsUZyM/K1mOmNdhFIoNm
        pqM2VoEkKm+0OsXOMlEC3OEp90LhfTozQmYpjUUX0j2kAAPWs+PGkzif3HCuwn81px7zQ6oGhxTKL
        GNtqlPtCbteSi782Q8YRaG3HeC9zuK7AIGCVGdt/OLfCgop4H+EiOe9m0w5ESCEcHoCA3Pwd/OiNP
        ffORS6EkO7pzlr6mo+h9uKVIOWWZVIFNT8rcqoIEroiWtIzWnY5EkdKiSZdVsasc9ilIlHWK5mRud
        +OCnwMq2SIXZ9OrBJFXhJ8WU/UJz1CCm3wv7PBTFbTnPlh5nJULQV25mn0aPMsKtblezEcdasqJB4
        Mn/CmxAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZ5A0-00BBHd-5s; Tue, 29 Mar 2022 06:16:56 +0000
Date:   Mon, 28 Mar 2022 23:16:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Christoph Hellwig <hch@infradead.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] btrfs: do data read repair in synchronous mode
Message-ID: <YkKkWBZ90mLnMM0V@infradead.org>
References: <cover.1648201268.git.wqu@suse.com>
 <1b796a483efa008ba5e2090621161684b3c4109b.1648201268.git.wqu@suse.com>
 <Yj2ZALUKtblRSaxP@infradead.org>
 <dd03a779-f996-4e45-e06e-f75acea97ff7@gmx.com>
 <ba5e64e0-8761-3cc3-e3e6-c78f02ab4788@dorminy.me>
 <84178851-8c88-dea1-1d0e-844b6ba7bb7c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84178851-8c88-dea1-1d0e-844b6ba7bb7c@gmx.com>
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

On Sat, Mar 26, 2022 at 08:13:33AM +0800, Qu Wenruo wrote:
> > I'm not understanding the reason why each bvec can only have one page...
> > as far as I know, a bvec could have any number of contiguous pages,
> > making it infeasible for x86_64 too, but maybe I'm missing some
> > constraint in their construction to make it one-to-one.
> 
> Btrfs doesn't utilize that multi-page bvec at all.

That is not true.  multi-page bvec are automatically created by
bio_add_page which is used by btrfs everywhere.
