Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BFC565498
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 14:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiGDMMs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 08:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbiGDMMg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 08:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCD8218A
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 05:11:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A00E60F91
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 12:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A10C3411E;
        Mon,  4 Jul 2022 12:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656936677;
        bh=58LhDtVXOhSOCJ1TOl0/DBgBuQFSbrxIUwLeWRHN700=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oVF3LoFidjq2gxydH1hCMvGYnSPoZJPvowBTGdMZeWI8lMLVsBTIx+hqNsDMkXZTm
         I3cOq1z0BWR9IJV6TH72R0agYUoNW6zZwfDMWuusq3GuroxhX7cH0/JSzhkKDes2DX
         7I5kYh4Gi3InnB2mAviAFTbYzZemrj0VFSYstgOcF1u+pdnCHY7EMmA4npSPYE2SzA
         9Ftj/OhnI90tGEudN0kV/dpYE0LblvCmHjUCOClDV2denI6BEYn5x0zgEkqt1aPqs6
         QF7u7edWEz6LaKdDo48uMTm1ZCpFI8lJ2vwe/MGSF4+0I6J8PXZOoBbL+W6olH/hT9
         Um0Elkx6LKPIw==
Date:   Mon, 4 Jul 2022 13:11:14 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: don't fallback to buffered IO for NOWAIT
 direct IO writes
Message-ID: <20220704121114.GA655122@falcondesktop>
References: <cover.1656934419.git.fdmanana@suse.com>
 <1a7080444b73f8ca1481a7786e52bdf405193be9.1656934419.git.fdmanana@suse.com>
 <YsLWTuUF0nq+sFKw@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsLWTuUF0nq+sFKw@infradead.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 04, 2022 at 05:00:14AM -0700, Christoph Hellwig wrote:
> >  buffered:
> > +	/*
> > +	 * If we are in a NOWAIT context, then return -EAGAIN to signal the caller
> > +	 * it must retry the operation in a context where blocking is acceptable,
> > +	 * since we currently don't have NOWAIT semantics support for buffered IO
> 
> .. more overly long comments here.

We generally don't mind about going beyond 80 characters as long as it's not too
much (83 here is reasonable), given that the new limit was changed to 100 characters
some time ago. And this applies to comments and code.

> 
> > +	 * and may block there for many reasons (reserving space for example).
> > +	 */
> > +	if (iocb->ki_flags & IOCB_NOWAIT) {
> > +		err = -EAGAIN;
> > +		goto out;
> > +	}
> 
> but more importantly, shouldn't this be above the buffered label? The
> only places that jumps to it is the alignment check, and if the
> alignment is incorrect now, it won't get any better in a workqueue
> context.

It was intentionally placed there not only because of that single goto but
to make it less error prone in case we get more gotos into that label in
the future.

Thanks.
