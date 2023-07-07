Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704EB74B001
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 13:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjGGLje (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 07:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjGGLjd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 07:39:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B41170F
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 04:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kLunh8+lzN2knQtURgn01VFkc/jLsCCQe3nDrrTYfy4=; b=LRRKkpUr6N8JtnUlb/YwhfqD95
        JfgQXlgVlLuQJyMxvoRAFhtm1LPFRJdA95VRh3qKq2aH5u+CB1hRDj+cDHxm3J14VntGv+ct6geBa
        s19OrofNaCunHqED2/A6MZBYDC7JId66+iV6d/eOk7xNYKl3FUZtJWdlt0UGeRmUqAqfU0t6HVb+4
        eYAiP1pcMx4ug9bnniV41QLAqeURcS+CUinKEYTHemw/nt4UGWNgFW+9jJEv00ecF/9/7XYN3VG6/
        WrQET/hRBDFgq63+MYf0GLIPNqND8Zxc6lQ/1pVH31lGC6Bjc0YuNQkJzluBMHvZJaJvrya0b0O4/
        hyoZGUGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHjoC-004X5i-1u;
        Fri, 07 Jul 2023 11:39:32 +0000
Date:   Fri, 7 Jul 2023 04:39:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add a debug accounting for eb pages contiguousness
Message-ID: <ZKf5dDGx0S1YAT6/@infradead.org>
References: <20230707084027.91022-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707084027.91022-1-wqu@suse.com>
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

On Fri, Jul 07, 2023 at 04:40:27PM +0800, Qu Wenruo wrote:
> !!! DO NOT MERGE !!!
> 
> Although the current folio interface is not yet providing a way to
> allocate a range of contiguous pages,

What do you mean?  Both folios and compound pages will allocate larger
than PAGE_SIZE objects if you as for it.

