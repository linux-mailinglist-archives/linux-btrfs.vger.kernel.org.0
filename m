Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650986C8C53
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Mar 2023 09:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCYIJm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Mar 2023 04:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYIJm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Mar 2023 04:09:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE911BF2
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Mar 2023 01:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CEN/thh5ibaJCUSMvlFlUIYY08SZSw5yaRtp6FemWwA=; b=D36rAMdyFl789fFpkzCBvH9LXO
        9x0yam6nlar6S/LzgWgHdsxbcAGc0VLMG50f+FfhqGHnWwkUcrvQ9s2SO18CTWviVcBDGTcnfTc4R
        KXh0/gKtVWEG65YnWzrO70Mo8f9aRhaD7ZOx0EMAeuooWxSoJa/Yno6TOHac0EZu8+dVOZSmAj4pO
        Gx79E3Emo2wdC4c2aLGoeKBNkl8VKAOCW465kDD4xbWLXPZjubJj5MU4KbFlFMJ8a0PbphFKXQRzJ
        Y7kz2yCcfqUSexEW7+GQJlyOQrjYIQ7v+eruE6zpf8X26O901OOnxje5BuaWPDGJR+8zW6lI0u4I9
        VC6wQsbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfyy0-006Q8K-2G;
        Sat, 25 Mar 2023 08:09:36 +0000
Date:   Sat, 25 Mar 2023 01:09:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 02/12] btrfs: introduce a new helper to submit bio for
 scrub
Message-ID: <ZB6sQGoP9dbsgvX7@infradead.org>
References: <cover.1679278088.git.wqu@suse.com>
 <b61263cba690fd894e21d75442556ae2f150f095.1679278088.git.wqu@suse.com>
 <ZBmc3ZqDVzb/hVDD@infradead.org>
 <0ee1de5c-9cb2-cecf-c4be-02cc16bd505c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ee1de5c-9cb2-cecf-c4be-02cc16bd505c@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 24, 2023 at 05:58:57PM +0800, Qu Wenruo wrote:
> I have updated the branch, with a dedicated btrfs_bio::fs_info,
> btrfs_scrub_bio_alloc() and always populate that new fs_info.
> 
> Mind to have a pre-check?
> 
> https://github.com/adam900710/linux/commit/0f6a419f035787546eec6f51b0430a05a345d4c5

I'd prefer to just pass a fs_info to btrfs_bio_init and btrfs_bio_alloc
instead of duplicating the allocator.  With my "simplify extent_buffer
reading and writing" series and another tiny change we'll only need the
inode for data inodes.  But given that we've not made too much
progress on getting that series merged I guess we'll have to add
the duplicate allocator for now and just revert it later.

I'd drop the ASSERT in btrfs_submit_bio - all allocators initialize
the field, no need for the extra check.

> Although the next two patches are also slightly updated to take the
> advantage of that always populated fs_info:

I think you wanted to add links here, but they are missing.

> Since the modification, I'm a little more dependent on that always populated
> fs_info now, thus not sure if going back to a union and conditionally
> grabbing that fs_info is a good idea.

I don't think the union is a good idea at all.  Maybe in the future
we can move the inode into a union, but right now the csum for data
read is the upper bound on the btrfs_bio, so I'm not sure we'll
ever get to a point where that would help.

> Although I'm more interested why there is a super big gap between work and
> bio (32 bytes), while the compiler still refuses to put the pointer into
> that hole...

I don't think there is one.  pahole just reports structs strangely
sometimes.
