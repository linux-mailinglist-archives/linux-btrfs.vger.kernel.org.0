Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8961E7191EE
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 06:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjFAEkm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 00:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFAEkk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 00:40:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A5E101
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 21:40:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CD89768BFE; Thu,  1 Jun 2023 06:40:34 +0200 (CEST)
Date:   Thu, 1 Jun 2023 06:40:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: new scrub code vs zoned file systems
Message-ID: <20230601044034.GA21827@lst.de>
References: <20230531125224.GB27468@lst.de> <546fad79-f436-c561-8b9b-0d9a7db09522@wdc.com> <20230531132032.GA30016@lst.de> <821003e3-b457-90ba-e733-8c2fdd0c3b3c@wdc.com> <20230531133038.GA30855@lst.de> <a59b2274-9d64-f11e-f726-9283f560a495@wdc.com> <20230531141739.GA2160@lst.de> <134e56ed-1139-a71c-54d7-b4cbc27834a9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <134e56ed-1139-a71c-54d7-b4cbc27834a9@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 01, 2023 at 10:09:24AM +0800, Qu Wenruo wrote:
> So far the various wrapper around the write operations work as expected,
> and hide the detailed well enough that most of us didn't even notice.
>
> E.g. all the zoned code is already handled in scrub_write_sectors().
>
> The crash itself is caused by the fact that end io part is relying on
> the inode pointer, that itself is a simple fix.

But the reason why it is relying on the inode pointer is that it needs
to record the actual written LBA after I/O completion.  So it's not
just a case of just add a NULL check, it needs a way to adjust the
logical to physical mapping from the dummy added before the I/O.

> But I'm more concerned about why we have a full zone before that crash.

I think this is happening because we can't account for the zone filling
without the proper context.

>>   b) don't create a new relocation thread per zone, but run it from
>>      the scrub context.
>>
>
> That's a little too complex, the problem is that relocation is a
> completely different beast, too different from the scrub code.
>
> But I agree the repair part for zoned needs some rework, it's not
> working from the day 1 of zoned support, but shouldn't need that a huge
> change.
>
> E.g. we just record that we need to relocate the bg, then after the
> scrub of that bg is fully finished, queue a relocation for it.

Yes.  That's what the read repair already does, and also the scrub
code, although in a somewhat sub-optimal way.

>
> Thanks,
> Qu
---end quoted text---
