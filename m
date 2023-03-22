Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC666C452E
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 09:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjCVIiu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 04:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCVIit (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 04:38:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD063527B
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 01:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EG+7LordkRHpR5uhHeSEb0P0yx1Z21UB61C1gfuQScQ=; b=G5fV4nA74ELtZE4stXwQxO0Cva
        p3FAwG0MXYLbW+PkUQkxidtzaEPjR9p+Swt4S4DHwnhUt64TQcOLAZQvFwhTQoyKGa54oMNQoDVUO
        Q1UNSZqIagQwQ/YsxbwW4C63ttYszoKda4A1p3mZFJEYNIo7GGMqvCUB77gGqauOm9m93L5kMDA/1
        pA7SGj3KI+brd/fLTRjFN007Jf2dA0wU0INnFIv7O47zT4qCu6X4zxe0NWGFHwbwZsmAoISpHqQjC
        kZoDCPzD5q/hh7VFatyPapdRMC5B0Iq1N3tcUnbgKdxbHnCvBe25f92251t4ghVCAOuJDy4a7fY/V
        +JeI2rLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1petzW-00FDaS-0H;
        Wed, 22 Mar 2023 08:38:42 +0000
Date:   Wed, 22 Mar 2023 01:38:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christopher Price <pricechrispy@gmail.com>, slyich@gmail.com,
        anand.jain@oracle.com, boris@bur.io, clm@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, regressions@leemhuis.info,
        regressions@lists.linux.dev
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Message-ID: <ZBq+ktWm2gZR/sgq@infradead.org>
References: <CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com>
 <CAEzrpqeOAiYCeHCuU2O8Hg5=xMwW_Suw1sXZtQ=f0f0WWHe9aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqeOAiYCeHCuU2O8Hg5=xMwW_Suw1sXZtQ=f0f0WWHe9aw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 21, 2023 at 05:26:49PM -0400, Josef Bacik wrote:
> We got the defaults based on our testing with our workloads inside of
> FB.  Clearly this isn't representative of a normal desktop usage, but
> we've also got a lot of workloads so figured if it made the whole
> fleet happy it would probably be fine everywhere.
> 
> That being said this is tunable for a reason, your workload seems to
> generate a lot of free'd extents and discards.  We can probably mess
> with the async stuff to maybe pause discarding if there's no other
> activity happening on the device at the moment, but tuning it to let
> more discards through at a time is also completely valid.  Thanks,

FYI, discard performance differs a lot between different SSDs.
It used to be pretty horrible for most devices early on, and then a
certain hyperscaler started requiring decent performance for enterprise
drives, so many of them are good now.  A lot less so for the typical
consumer drive, especially at the lower end of the spectrum.

And that jut NVMe, the still shipping SATA SSDs are another different
story.  Not helped by the fact that we don't even support ranged
discards for them in Linux.
