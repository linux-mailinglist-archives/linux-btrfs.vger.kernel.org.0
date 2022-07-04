Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B22256550C
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 14:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbiGDMUV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 08:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiGDMUI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 08:20:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B91D73
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 05:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29E89B80EF8
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 12:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85313C341CF;
        Mon,  4 Jul 2022 12:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656937179;
        bh=wMC7lB8I8SU/m78uMMAqBXjdRKzRBLYU/47UDlGj69M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8y3pxeXFMiWQMRiL4wIPjuuem4zy/AUU1iuMKeBjPE8n+Be86qpaFMHzV1K53ouf
         LACL5YzkGBlJsZgzhQ2bFesZPBcMTRxvYq2MyhnBO/Rpoe3RI0UqRyDUSMjjjMv/Ic
         kQLumi3BjWh2hqF06DDiOfuEHvY6+9bdDyglrk8oJ6Eej+QcEhh2yTyV2lo9KfWsTv
         XGj7V0m7ZlzDHk/4VwL90anAPtZZmtQ6wlEIsWR6tkCnF6FwDTftq1QY9QL80Q4MLE
         zWRFyq3f+uxobGapYKKJ99z9Ti+nFxJiZUPGQWy9xYcqsmOhN3hCWlZ2DKxNGzjZM7
         gzVqjnHjkAjgw==
Date:   Mon, 4 Jul 2022 13:19:36 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: don't fallback to buffered IO for NOWAIT
 direct IO writes
Message-ID: <20220704121936.GA656399@falcondesktop>
References: <cover.1656934419.git.fdmanana@suse.com>
 <1a7080444b73f8ca1481a7786e52bdf405193be9.1656934419.git.fdmanana@suse.com>
 <YsLWTuUF0nq+sFKw@infradead.org>
 <20220704121114.GA655122@falcondesktop>
 <YsLZLBPM4KkvpN5v@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsLZLBPM4KkvpN5v@infradead.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 04, 2022 at 05:12:28AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 04, 2022 at 01:11:14PM +0100, Filipe Manana wrote:
> > We generally don't mind about going beyond 80 characters as long as it's not too
> > much (83 here is reasonable), given that the new limit was changed to 100 characters
> > some time ago. And this applies to comments and code.
> 
> The limit is for individual lines where that benefits readability.
> That's never the case for block comments by definition.

First time I'm hearing it, and never had complaints before.

> 
> > > > +	 * and may block there for many reasons (reserving space for example).
> > > > +	 */
> > > > +	if (iocb->ki_flags & IOCB_NOWAIT) {
> > > > +		err = -EAGAIN;
> > > > +		goto out;
> > > > +	}
> > > 
> > > but more importantly, shouldn't this be above the buffered label? The
> > > only places that jumps to it is the alignment check, and if the
> > > alignment is incorrect now, it won't get any better in a workqueue
> > > context.
> > 
> > It was intentionally placed there not only because of that single goto but
> > to make it less error prone in case we get more gotos into that label in
> > the future.
> 
> But it does the wrong thing for the only use of the goto right now..

Why is it wrong? The purpose it to never fallback directly to buffered IO if
it's a NOWAIT write. Moving the check to above the label, would make the
non-aligned case fallback directly to buffered IO under NOWAIT.
