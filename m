Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EFE76D1B0
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 17:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbjHBPVX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 11:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbjHBPVK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 11:21:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8D85FFC
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 08:17:53 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B3A1F68AA6; Wed,  2 Aug 2023 17:16:43 +0200 (CEST)
Date:   Wed, 2 Aug 2023 17:16:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: small writeback fixes v2
Message-ID: <20230802151643.GA2229@lst.de>
References: <20230724132701.816771-1-hch@lst.de> <20230727170622.GH17922@twin.jikos.cz> <20230801152911.GA12035@lst.de> <20230802124956.GA2070826@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802124956.GA2070826@perftesting>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 02, 2023 at 08:49:56AM -0400, Josef Bacik wrote:
> I ran this through the CI

Thanks a lot!

> [ 3461.147888] assertion failed: block_group->io_ctl.inode == NULL, in
> fs/btrfs/block-group.c:4256

Hmm, this looks so unrelated that it leaves me puzzled.  How confident
are you that this is a new issue based on the overall test setup?

> I also got an EBUSY trying to umount $SCRATCH_MNT with generic/475 with

> on an ARM machine with 64kib pagesize.  Though I'm pretty sure you're not to
> blame for that last failure.  Thanks,

Yes, I've seen EBUSY in 475 quite regulary even without the changes,
I think I also mentioned it in reply to the other 475-related discussion
we had.  I tried to debug it for a while but didn't manage to get far.

