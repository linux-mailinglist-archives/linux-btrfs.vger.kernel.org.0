Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106CA6B724F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Mar 2023 10:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCMJQs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Mar 2023 05:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCMJQr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Mar 2023 05:16:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627EDB746
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 02:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nX1eiH+G6boRidapCZ3Unsw4f4m5RwNl70tMijVMaGg=; b=hysoVNO3xBX9zo6fyA8qtHLt1O
        5+MPe67apatCGW0alKgnXfVbQ6uttNCU0ZOxJIHMacrjTWNKw7vpyC7DCt7X3nyBSsEpdJA6D3Lit
        NIQ5MMmruqt3fj68NTQdL1exr6AQO/TCu7BOPzqCm+A5jpUYuEHz/94BvoEc5lmLPUh7cH+ImTVCo
        iP308YE5RhGYwwCOaeKDzO/reAKDsd3xmmkXqiQWAoLkonyFsf8aXV4eCKWuQc1QZ//e3igPmH/mJ
        O7omOEfmesm0HdXfB8p5G+GfwJvxUmHAOCE+bEN94cTygOwbzdjwfhFtl9OAlykrtWbPgbq1g9O4l
        HAWMTktA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbeIM-004x5E-5Z; Mon, 13 Mar 2023 09:16:42 +0000
Date:   Mon, 13 Mar 2023 02:16:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 00/21] Lock extents before pages
Message-ID: <ZA7p+uuc7G7gG6QE@infradead.org>
References: <20230302222506.14955-1-rgoldwyn@suse.de>
 <20230309181050.GK10580@twin.jikos.cz>
 <ZArhR3v+Nl/Rq/Nw@infradead.org>
 <20230310163828.guqukqexmx2pqmy7@kora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310163828.guqukqexmx2pqmy7@kora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 10, 2023 at 10:38:28AM -0600, Goldwyn Rodrigues wrote:
> > I am really worried about the i_count hack.  It is fundamentlly wrong
> > and breaks inode lifetime rules.  Furthermore there is no attempt
> > at understanding why it happens (or even if it is new with this series).
> 
> So this (another version) patch which first added working with i_count is:
> 8180ef8894fa ("Btrfs: keep inode pinned when compressing writes")
> 
> For async, inode is still referenced until all the pages
> are written back and cleared in end_compressed_writeback().
> evict() waits for all writeback to be completed. Josef, is this
> correct?
> 
> I removed the ihold() and delayed iput sequence and shifted
> unlock_extent() immediately after submit_compressed_extents(). It is
> working fine with no crashes for compress tests. But since this is a
> race condition I need to be sure if it is the correct thing to do. I
> have updated the git [1] but it needs more testing.

I think the import thing to remember here is:

 1) an inode is not getting fred as long as it has pages under writeback
 2) as long as you don't reference the inode after clearing the last
    PageWriteback bit, using the inode without an extra reference
    in the writeback code is fine

So I think we can just remove the extra referene after making sure that
the inode is not referenced after dropping the last writeback bit.
And handling of the writeback bit is quite funny in btrfs in a few
places.  Maybe I'll be able to find some time to dig into it while
you're away.

