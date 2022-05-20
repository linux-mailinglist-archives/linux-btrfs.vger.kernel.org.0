Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13BB52EF22
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 17:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350394AbiETPZp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 11:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346598AbiETPZo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 11:25:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540EB17857B
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 08:25:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 73B7D68AFE; Fri, 20 May 2022 17:25:38 +0200 (CEST)
Date:   Fri, 20 May 2022 17:25:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 12/15] btrfs: add new read repair infrastructure
Message-ID: <20220520152538.GA21215@lst.de>
References: <20220517145039.3202184-1-hch@lst.de> <20220517145039.3202184-13-hch@lst.de> <e2c4e54c-548b-2221-3bf7-31f6c14a03ee@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2c4e54c-548b-2221-3bf7-31f6c14a03ee@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 18, 2022 at 07:04:22AM +0800, Qu Wenruo wrote:
> A big NONO here.
>
> Function btrfs_repair_read_bio() will only return true if all of its
> data matches csum.
>
> Consider the following case:
>
> Profile RAID1C3, 2 sectors to read, the initial mirror is 1.
>
> Mirror 1:	|X|X|
> Mirror 2:	|X| |
> Mirror 3:	| |X|
>
> Now we will got -EIO, but in reality, we can repair the read by using
> the first sector from mirror 3 and the 2nd sector from mirror 2.
>
> This is a behavior regression.

Now that I've written tests and code to treat this properly I have to
say that at least on x86 I can't actually trigger this behavior
regression and had to add instrumentation to see a low-level change
in behavior.

Why?

For some reason (and I'd love to see an explanation for it!), btrfs
limits direct I/O reads to a single sector, so for direct I/O is is
impossible to hit this case as all bios (and thus repair bios) are
limited to a single sector.

For buffered I/O we can hit this case, but all ->readahead error are
ignored and the pages actually needed are eventually retried using
->readpage.  And ->reapage is limit to a single sector.   But given
that btrfs does not seem to support sub-4K sector sizes I can't
actually test the sub-sector code here - I assume this might be
an issue on larger page size systems.
