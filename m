Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3187B565497
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 14:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiGDMMz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 08:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiGDMMo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 08:12:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D260C11A12
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 05:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mTCZg5Ul9aTT+bAxpxBFWFiZ/m98DlNTiaKVnYcTQsA=; b=xRB5ws6MQ07hs4QSdYpF3INLLb
        5bnqCI/2CV9QBcvNHIPwkHnrjUsaze3F6Ox0a+QqfCkhDT2gtgqnDIHlj+KP/a519ivQA7rbG8V8/
        j58UROjZL5DFA29xrpzJpEJlIzjPZ2kdQ9LyTPCa1mfa5F6eq0qF4dTATIVSWobVcYvjV640zQoH9
        3S5xW/NAKh9q/yuWuK6I3aBNkPiOpK2Vp/iS5jU3elq4cdQlH2yBzVoX0/1UVvWGNNPTlDSdTgEVh
        jBhrEem/vFbYikERl0kXmed29CdJQlPlVIz5bwOmcs8kQvYtSrGkoXmWxMvsA3GU3/F4tmRjD2gwq
        1MivsjaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8KwG-008dwi-Cu; Mon, 04 Jul 2022 12:12:28 +0000
Date:   Mon, 4 Jul 2022 05:12:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: don't fallback to buffered IO for NOWAIT
 direct IO writes
Message-ID: <YsLZLBPM4KkvpN5v@infradead.org>
References: <cover.1656934419.git.fdmanana@suse.com>
 <1a7080444b73f8ca1481a7786e52bdf405193be9.1656934419.git.fdmanana@suse.com>
 <YsLWTuUF0nq+sFKw@infradead.org>
 <20220704121114.GA655122@falcondesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704121114.GA655122@falcondesktop>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 04, 2022 at 01:11:14PM +0100, Filipe Manana wrote:
> We generally don't mind about going beyond 80 characters as long as it's not too
> much (83 here is reasonable), given that the new limit was changed to 100 characters
> some time ago. And this applies to comments and code.

The limit is for individual lines where that benefits readability.
That's never the case for block comments by definition.

> > > +	 * and may block there for many reasons (reserving space for example).
> > > +	 */
> > > +	if (iocb->ki_flags & IOCB_NOWAIT) {
> > > +		err = -EAGAIN;
> > > +		goto out;
> > > +	}
> > 
> > but more importantly, shouldn't this be above the buffered label? The
> > only places that jumps to it is the alignment check, and if the
> > alignment is incorrect now, it won't get any better in a workqueue
> > context.
> 
> It was intentionally placed there not only because of that single goto but
> to make it less error prone in case we get more gotos into that label in
> the future.

But it does the wrong thing for the only use of the goto right now..
