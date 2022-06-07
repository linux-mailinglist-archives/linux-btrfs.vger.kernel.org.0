Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171AB53F675
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 08:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbiFGGph (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 02:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiFGGph (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 02:45:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134E552E7E
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 23:45:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5FCA368AFE; Tue,  7 Jun 2022 08:45:31 +0200 (CEST)
Date:   Tue, 7 Jun 2022 08:45:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, dsterba@suse.cz,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: simple synchronous read repair v2
Message-ID: <20220607064530.GA9562@lst.de>
References: <20220527084320.2130831-1-hch@lst.de> <20220606212500.GI20633@twin.jikos.cz> <dcddfea0-ca0b-c59a-187b-34534509c538@gmx.com> <20220607061622.GA9258@lst.de> <14810ca4-9af6-3bc0-429e-aeddb341aae4@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14810ca4-9af6-3bc0-429e-aeddb341aae4@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 07, 2022 at 02:34:02PM +0800, Qu Wenruo wrote:
> As currently, we only write the recovered data back to *previous*
> corrupted mirror, it doesn't ensure our initial mirror get repaired.

Yes.  So it leaves the file system in a degraded state and reduces
redundancy.

> And in fact, only writing back to the initial mirror is also going to
> make recovery faster and easier, as now we only need to do one
> synchronous writeback.

It does make recovery faster by not doing most of it.  By that logic we
should stop repairing in the I/O path at all.  Which, thinking about it,
might actually not be a bad idea.  Instead of doing synchronous repair
from the I/O path, just serve the actual I/O with reads and instead
kick of a background scrub process to fix it.  This removes code
duplication between read repair and scrub, speeds up the reads
themselves, including reducing the amount of I/O we might be doing
under memory pressure and allows the scrube code to actually do the
right thing everywhere, including rebuilding parity in the RAID6
case, something that the read repair (both old and new) do not handle
at all.
