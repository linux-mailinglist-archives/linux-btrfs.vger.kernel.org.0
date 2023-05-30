Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1D571555D
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 08:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjE3GJk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 02:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjE3GJV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 02:09:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63EEFE
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 23:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ryBTP/1JqhGdvCpqfA9DxacZB2p/gDHlN9GZRt/+L3o=; b=MmeDjKztw6vcq1yKROIIfI6HfW
        Uiqn0GyTGIfsLar/6kmHk3mRbUXgrlcnfMSkFGHpz4O/BMCnXNAVl0GN/ROxEdz7H61ByGCb9cePN
        thzfJ2dMYElRuGzeIl2ScCFUzeuHH+wVZ9GRUg8sjx6UWiJrjwGSzhqLyBvNjNa27C1iv+iAubm0l
        KHIxse8Bcib9n2uz4UZN4n1iDDyYqY+zwGk3F84OZeaj5Lus4Dnq4JZZdA5sT1YsoySgwCvvcUnrJ
        AinH5ctwynyJn/KqK/e47xmfseRo63Wl31Y1DWzRzzil6UeaKYE5yHMFrBMK8SiZWECyLC6/OQ8ID
        4Uom80vQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q3sX8-0060fe-8A; Tue, 30 May 2023 06:08:38 +0000
Date:   Tue, 30 May 2023 07:08:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 08/16] btrfs: stop setting PageError in the data I/O path
Message-ID: <ZHWS5nOm++6zCNkE@casper.infradead.org>
References: <20230523081322.331337-1-hch@lst.de>
 <20230523081322.331337-9-hch@lst.de>
 <20230529175210.GL575@twin.jikos.cz>
 <20230530054547.GA5825@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530054547.GA5825@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 30, 2023 at 07:45:47AM +0200, Christoph Hellwig wrote:
> On Mon, May 29, 2023 at 07:52:10PM +0200, David Sterba wrote:
> > On Tue, May 23, 2023 at 10:13:14AM +0200, Christoph Hellwig wrote:
> > > PageError is not used by the VFS/MM and deprecated.
> > 
> > Is there some reference other than code? I remember LSF/MM talks about
> > writeback, reducing page flags but I can't find anything that would say
> > that PageError is not used anymore. For such core changes in the
> > neighboring subysystems I kind of rely on lwn.net, hearsay or accidental
> > notice on fsdevel.
> > 
> > Removing the Error bit handling looks overall good but I'd also need to
> > refresh my understanding of the interactions with writeback.
> 
> willy is the driving force behind the PageErro removal, so maybe he
> has a coherent writeup.  But the basic idea is:
> 
>  - page flag space availability is limited, and killing any one we can
>    easily is a good thing
>  - PageError is not well defined and not part of any VM or VFS contract,
>    so in addition to freeing up space it also generally tends to remove
>    confusion.

I don't think I have a coherent writeup.  Basically:

 - The VFS and VM do not check the error flag

   $ git grep folio_test_error
   fs/gfs2/lops.c: if (folio_test_error(folio))
   mm/migrate.c:   if (folio_test_error(folio))

   (the use in mm/migrate.c replicates the error flag on migration)

   A similar grep -w PageError finds only tests in filesystems and
   comments.

 - We do not document clearly under what circumstances the error flag
   is set or cleared

If we can remove all uses of testing the error flag, then we can remove
everywhere that sets or clears the flag.  This is usually a simple
matter of checking folio_test_uptodate() instead of !PageError(),
since the folio will not be marked uptodate if there is a read error.
Write errors are not normally tracked on a per-folio basis.  Instead they
are tracked through mapping_set_error().

I did a number of these conversions about a year ago; I'm happy Christoph
is making progress with btrfs here.  See 'git log 6e8e79fc8443' for many
of them.
