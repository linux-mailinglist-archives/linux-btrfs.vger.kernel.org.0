Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9086CB2F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 03:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjC1BEv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 21:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjC1BEu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 21:04:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75241990
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 18:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QVtf4KXxoiqv9YFx0ZZcfqYPkJAShg4vyaKvP9QuS6Y=; b=uS/rPMxARyMq5uXcjuoDYZH4BM
        hRAVR8F1Lq0z8oRBGuplHCwGRZip1YuNQhN2VXku8N1zChvEEMiYbHbneKmT4dQp2WI+TRjp81lYK
        +DJgsMeaeoqROYxwxhheSC4TSLIcN5mIDYkvVy5d14CWzAnCBRPEXh66e3P5U3CUaKUb2e5KvlVip
        vGbsEAxIskT3hyGufVMGks2bFG6Wc6VDG7UWMHc4fYpEELDZANJWar0JlXqQkcH2wz9Y+vzGzCayb
        jy4AWnKWbOtITUjhKWE0Wd0BLDZWVo+AR5ckmw9pCNdI0KuXjYPf9LvQhR6L6LmjmpYb+Y96XOiBR
        LYSXKhGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgxlI-00ClNk-0X;
        Tue, 28 Mar 2023 01:04:32 +0000
Date:   Mon, 27 Mar 2023 18:04:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v5 03/13] btrfs: introduce a new helper to submit read
 bio for scrub
Message-ID: <ZCI9ILRIa2G8WzWE@infradead.org>
References: <cover.1679959770.git.wqu@suse.com>
 <79a6604bc9ccb2a6e1355f9d897b45943c6bcca9.1679959770.git.wqu@suse.com>
 <ZCIoQLysbLrQW0pX@infradead.org>
 <cd8a91ee-2e30-9829-b50d-599fab3fb490@suse.com>
 <ZCI0DXvc+h7DoZvB@infradead.org>
 <7ec722e8-d685-004c-6c24-6bdac7982e0b@gmx.com>
 <ZCI6hOjU+yrQ9SCE@infradead.org>
 <7aa553ab-b019-b5c6-235a-4c17a9cf3b4c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aa553ab-b019-b5c6-235a-4c17a9cf3b4c@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 28, 2023 at 09:01:57AM +0800, Qu Wenruo wrote:
> > Well, if did just call btrfs_submit_chunk, the RST lookup would ensure
> > you only get the length of the RST mapping, and you get the behavior
> > you want without duplication.  We'd need to make it non-static (and
> > document it), but I'd still be much happier about that than yet another
> > I/O submission interface.
> 
> But in that case, wouldn't we just error out?

btrfs_submit_chunk is greedy.  But yes, if there was no mapping at all
I guess it would error out and we'd need to find a way to handle that.
But that still seems better than duplicating the logic again.
