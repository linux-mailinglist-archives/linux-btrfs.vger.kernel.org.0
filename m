Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5A36B37C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 08:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCJHuj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 02:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCJHue (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 02:50:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73644D623
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 23:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4icqb/lNoQecAYXNytBEHuwXaxkfkuQu5GDZiMKzXXo=; b=smhh/tyy3T+LjWRJISRuZBOp2C
        pwAJV4rlXXZQY/6SEcZ7pG49cU5D0W6rdYAIjEhHl76E/je3pKk/EhQgdIGo5J+3/CepHYibXr4ks
        jZabewqSBUw6Z5L0r9RUU1fMXLmL3FGOAOnYB5ks3S0UKaqtg+Fyod+4hlDRB7tkZ+fNOMAOP//ub
        LtoGRxUsGDzt2BNyUrW/t7pYSyEDjuX/jhEZtnayMH05O+5+KzahZN4ks141LmOYlux8Gt/jwkwRP
        Gb6S0hPh03aSsDGT8kk3HYlxCZZjlVfSA7PFpK3AMS+W+gF8ESeeE8CWuvtQyRk2oshJivgH/f9hx
        ddZdRSJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paXWJ-00DTD1-6z; Fri, 10 Mar 2023 07:50:31 +0000
Date:   Thu, 9 Mar 2023 23:50:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/21] Lock extents before pages
Message-ID: <ZArhR3v+Nl/Rq/Nw@infradead.org>
References: <20230302222506.14955-1-rgoldwyn@suse.de>
 <20230309181050.GK10580@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309181050.GK10580@twin.jikos.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 09, 2023 at 07:10:51PM +0100, David Sterba wrote:
> I've picked the branch from your git repository (applies on top of
> misc-next) and will add it to for-next. We may need to keep it there for
> some time, with this kind of core change it's not possible to do reverts
> in case we find serious problems.

I am really worried about the i_count hack.  It is fundamentlly wrong
and breaks inode lifetime rules.  Furthermore there is no attempt
at understanding why it happens (or even if it is new with this series).

> 
> Optimistic plan is to get it stabilized during current dev cycle and
> then one more cycle for stabilization once it's in the master branch.

It is going to clash with quite a bit of other work going in this area
I fear.
