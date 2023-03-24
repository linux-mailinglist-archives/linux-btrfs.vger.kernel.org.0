Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02276C88FD
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Mar 2023 00:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjCXXGo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Mar 2023 19:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCXXGn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Mar 2023 19:06:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F311DB85
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 16:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qGQfcYtfzIDBy+ACQrXi7a0hHy6KfpgUFdBIdSr4XBw=; b=iIWd4i6mRojaJvRdP7ckPVlU2U
        aAGgWHDcYgkgFXARgSHQxEmxJDDEee0qdKuGmBjybU5EODa5MDmM78WaEZ8AU1X/QtACLlv/LRNYM
        DGB8aMd4OCxoAdoB4lyjM1wQXxbzeRxsURbLptrtwA5cgB7FfzP7qscirDJxw9oG0qbUc51Vrd9Pz
        sTSfsDyOwhKy55PB6aH5ClcNJ4Ah+oO9Y2/5k1GH9xYivIKh1KYZ3hJO523E8ZooPrdyFoEgtGdXK
        oq1881bk221etOroyWnar1WleLH4hp14mzjGeLw0X8K/h6SP3vwUsetXFgHl1bSDq6nP+m8UZg562
        tVUhbOFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfqUa-005n74-0d;
        Fri, 24 Mar 2023 23:06:40 +0000
Date:   Fri, 24 Mar 2023 16:06:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Ryskalczyk <david@rysk.us>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Kernel panic due to stack recursion when copying data from a
 damaged filesystem
Message-ID: <ZB4tAMxl+efjhCxv@infradead.org>
References: <E567648E-DEE9-49EB-8B01-3CE403E4E87C@rysk.us>
 <b9ed921a-2cd2-411a-4374-c7682b56c45e@gmx.com>
 <ZBwC7n9crUsk4Pfi@infradead.org>
 <9628f5a7-2752-4f74-70e1-f8efd345bdc7@gmx.com>
 <ZBwJQcvt2TcqoCRh@infradead.org>
 <2F36C097-7549-49D8-8C70-C254A93FAC74@rysk.us>
 <ZBz2hvO/NRqVZhvQ@infradead.org>
 <F634B09D-A746-4FE6-851D-7C26CDB00819@rysk.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F634B09D-A746-4FE6-851D-7C26CDB00819@rysk.us>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 24, 2023 at 07:44:20AM -0400, David Ryskalczyk wrote:
> On Mar 23, 2023, at 9:01 PM, Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > Any chance you could try 6.3-rc3 or the latest Linus tree on this
> > file system?
> 
> This issue no longer occurs for me on 6.3-rc3.

In that case it seems like the sole problem is that the recursion
in the old repair code is bad enough for just four copies.  I don't
think there's much we can do as the new repair code is way to invasive
to backport.
