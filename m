Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33946C9A43
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 05:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjC0Dgo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Mar 2023 23:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0Dgm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Mar 2023 23:36:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017CE199C
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Mar 2023 20:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hn2FXKgVJAgIPZE8PPUwZQbaTR4JsRAar0l6Pioz3Xs=; b=IjsQ6MMsymbdDfnQex1b46pQRj
        2iQDRgGnhKmbGStQqyw2XiG8dcAGODs+hUAZIAT65q6FB2YUKcrINBiMeEtNHkZTUw+OhDWR1mMOS
        GJa4j3VJLfAqZ0nX3aDlHc53Db+kfEUBwjCz1TG0PQzMK/eVMuYd5XdbCBMZC/ehxSON5TEPfuEfL
        tXBZXetpZPrey4eXp5eHdCJ3EFgs/W5/pIoL2JyWscncDdjTe41v2RH2BmBNmNiZrpBVsRxJu9Fqy
        sO0b1mzKZrDX8uz5lGxFfUnIfTYQMs093wFVs9odUTwlof6+W54bUo7u116QlmB635hiAlAhk4Ljf
        z8xLsORg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgdew-009fyJ-2H;
        Mon, 27 Mar 2023 03:36:38 +0000
Date:   Sun, 26 Mar 2023 20:36:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 02/12] btrfs: introduce a new helper to submit bio for
 scrub
Message-ID: <ZCEPRtYWYmTbUfWG@infradead.org>
References: <cover.1679278088.git.wqu@suse.com>
 <b61263cba690fd894e21d75442556ae2f150f095.1679278088.git.wqu@suse.com>
 <ZBmc3ZqDVzb/hVDD@infradead.org>
 <0ee1de5c-9cb2-cecf-c4be-02cc16bd505c@gmx.com>
 <ZB6sQGoP9dbsgvX7@infradead.org>
 <9581646d-380f-2b55-07ac-2abd37822577@gmx.com>
 <ZB6xcqST8tCA7zxK@infradead.org>
 <1698cfcc-8beb-7211-2e4f-2e8e5e363ece@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1698cfcc-8beb-7211-2e4f-2e8e5e363ece@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 25, 2023 at 04:48:40PM +0800, Qu Wenruo wrote:
> > I'd be tempted to just initialize it in the callers given that it's
> > an optional field now.  I wonder if the same might also make sense
> > for ->file_offset.
> 
> In that case, I'm not sure if adding more and more arguments while almost
> all of them can be optional is a good idea...
> 
> Shouldn't we only pass mandatory arguments, then let the caller to populate
> the optional ones?

Yes, that's what I tried to suggest above.  Right now inode and
file_offset are mandatory, but with your changes they stop being so,
so we should stop passing them to the allocation helpers.
