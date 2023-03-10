Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9646B3E78
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 12:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCJLzI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 06:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCJLyp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 06:54:45 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6B9E7ED1
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 03:54:20 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 61D1568AFE; Fri, 10 Mar 2023 12:54:16 +0100 (CET)
Date:   Fri, 10 Mar 2023 12:54:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 17/20] btrfs: don't check for uptodate pages in
 read_extent_buffer_pages
Message-ID: <20230310115415.GC19861@lst.de>
References: <20230309090526.332550-1-hch@lst.de> <20230309090526.332550-18-hch@lst.de> <fa92c65c-fb11-938a-20a0-4e0d7965b3f3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa92c65c-fb11-938a-20a0-4e0d7965b3f3@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 10, 2023 at 05:08:17PM +0800, Qu Wenruo wrote:
>> The only place that reads in pages and thus marks them uptodate for
>> the btree inode is read_extent_buffer_pages.  Which means that either
>> pages are already uptodate from an old buffer when creating a new
>> one in alloc_extent_buffer, or they will be updated by ca call
>> to read_extent_buffer_pages.  This means the checks for uptodate
>> pages in read_extent_buffer_pages and read_extent_buffer_subpage are
>> superflous and can be removed.
>
> Can we rely completely on EXTENT_BUFFER_UPTODATE flag and getting rid of 
> PateUptodate for metadata?
>
> Or the PageUptodate would be shared by some other common routines like 
> readahead?

That's a good question.  Not maintaining PageUptodate would simplify
a lot of things.  As btree_aops has no ->readpage or ->readahead,
the filemap read code is never used, which the biggest dependency
on PageUptodate in the core pagecache code.

So right now I can't think of anything requiring it, but I'd have
to carefully look into that.
