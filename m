Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937EA4FC2D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 19:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344369AbiDKRCs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 13:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348783AbiDKRCd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 13:02:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F95B5F5F
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CKOfGGHdUsrvcGUkN3l+u1i76VC+mj6K5qxExCGc/Gs=; b=ECFqzZlFD/vpHABSRsVmbA+fQz
        wcjPwccQrv7eUi2pHXh7zcT0HKB7j7mJr1C54XBJL8yGHzl0td2XpENFEDB2AHH4/xICFfbOvgEVS
        b9OINwN9n4hudW/py+2bB4b5xH5doA9SglHhvX9u7zNd9BYFspvATIgbl6Lqarg5LlU+uGehItJka
        bbVOrmzQv4IfOlHOVZhif+MU0Lkr3O27x34LzReD0ZJilEBlaoN7WbrGvkoX+3GViSFJCPhOqQtIo
        +fGNsuRRmQGq9zDNjlMIuaDkObx/ogc19/Vik0GunqsjdqJtYHBZCGL/Dg2IdETmXG1Artw+bMer+
        faFCxHxA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndxOg-009p3d-V0; Mon, 11 Apr 2022 17:00:14 +0000
Date:   Mon, 11 Apr 2022 10:00:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/16] btrfs: make finish_rmw() subpage compatible
Message-ID: <YlRentZd9vVt1Ff2@infradead.org>
References: <cover.1648807440.git.wqu@suse.com>
 <911628d0221328e4e5c0bdff58313c0c64485315.1648807440.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <911628d0221328e4e5c0bdff58313c0c64485315.1648807440.git.wqu@suse.com>
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

On Fri, Apr 01, 2022 at 07:23:24PM +0800, Qu Wenruo wrote:
> The trick involved is how we call kunmap_local(), as now the pointers[]
> only store the address with @pgoff added, thus they can not be directly
> used for kunmap_local().

Yes, they can. kumap_local only needs a pointer somewhere into the
mapped page, not the return value from kmap_local_page:

 * @__addr can be any address within the mapped page.  Commonly it is the
 * address return from kmap_local_page(), but it can also include offsets.

> For the cleanup, we have to re-grab all the sectors and reduce the
> @pgoff from pointers[], then call kunmap_local().

No need for that.
