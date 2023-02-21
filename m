Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6270369E44D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 17:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjBUQMs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 11:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjBUQMq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 11:12:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2B12B2AD
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 08:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LXqgofw87+dg8YWJldgiHxw+gwXgxDNLFzvTmql9SUs=; b=BzszA2QqX/zGsqDIi+8Mn5iOLT
        hC8vaZ3PjF8K/P1o1egNLpSc/xwP3zNDAskSMeMNzQT2UQwAb9HaTXzIjC0WXORRfFVXypSe2yjhD
        m1/dQNxdy+2TijS4guZXsVoRzdtIhDWeHX1gDY6eeuJ7s4BbDIvWGjJ1qUSindDkE2XGT9zxZ+uMd
        myzU7/zH+pGwiJjA/dY27HxJRDDVxf70Rs9VQsl45ST3xyqaCyO2tAgS315zdaF7/pdgXyUkDnThn
        sg0qu5dWFD0OsxqhjSDL57v4q6ncsIL4o4+BpyKV3sc1f+TC7FjpwNZNnKWHgylPIRt/32pAxqWrv
        JBjYrpOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUVFz-008tt8-LO; Tue, 21 Feb 2023 16:12:43 +0000
Date:   Tue, 21 Feb 2023 08:12:43 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: reflow calc_bio_boundaries
Message-ID: <Y/TteydTe9jHLtXv@infradead.org>
References: <9509878ff5631eb2563855c0de694f296e23e0f2.1676985912.git.johannes.thumshirn@wdc.com>
 <Y/TUjwJCkzcoAEac@infradead.org>
 <99957e0d-674b-5799-2f12-d2986c6ef669@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99957e0d-674b-5799-2f12-d2986c6ef669@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 21, 2023 at 04:00:41PM +0000, Johannes Thumshirn wrote:
> Another approach would be sinking calc_bio_boundaries into 
> alloc_new_bio() altogether:

I like that.
