Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA706CCE37
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 01:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjC1XvL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 19:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjC1XvK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 19:51:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7332D47
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 16:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rf0i3Hx3Ehzoe72CAg0C58+n/MAWqC4CMGqWmLMKTaQ=; b=H/23p6qwFiLqjK3P/mOzVaH6OG
        vTfM+6Ko/AQSM6K3qTYRO/1WrhorhJOgw9DfZ+pMp9LPL5i/Breu+T1xvZsXDc4Zn37PVtYq/SIco
        ibXN0GJtuxHNFRQdhiyMoFekysyoeP0hsTIqlR7MWX1FxZyUrOuEBLMJ6QegF6X7Vw4Ts9zymtjWp
        rLvUy8mLyEw4QyCY36jsJ42GB6KCpz9fU35H4xc4wdYifQ4KRz+mEhzd73PVInE1RLilVwBS7Z/Q5
        EfApye7HxHTaozoXqq6KX9jkp8dIAE77STeeHkdloneN9yw7CDGLgeyy8EcxsH3n6UVIa/8NTBnbu
        GqURggbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phJ5a-00G93R-2r;
        Tue, 28 Mar 2023 23:50:54 +0000
Date:   Tue, 28 Mar 2023 16:50:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/12] btrfs: scrub: use a more reader friendly code
 to implement scrub_simple_mirror()
Message-ID: <ZCN9Xs7Cw75mc+jB@infradead.org>
References: <cover.1678777941.git.wqu@suse.com>
 <ZBF5M5R3pDdp/075@infradead.org>
 <2dfc49ef-e041-3efd-1c55-3685df22acb6@gmx.com>
 <ZCN6Itm8dkY8w9P/@infradead.org>
 <c7ad6682-a3e0-ba70-b3f6-eed85388595f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7ad6682-a3e0-ba70-b3f6-eed85388595f@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 29, 2023 at 07:44:59AM +0800, Qu Wenruo wrote:
> Isn't the patch split also important?
> 
> Anyway I will try some different methods to split that.

I'll have to defer to David as btrfs is sometimes a little different
from the rest of the kernel in it's requirements, but everywhere
else a patch that just removes code can be as big as it gets.
