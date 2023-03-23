Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D966C614F
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 09:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCWIJn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 04:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCWIJm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 04:09:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC343ABA
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 01:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tGzc5+bZh4zvrYQgKdSe/s/59Cd1uWOwt+nWyqCAWv8=; b=xWqjrFlXBxE94q5BHtlyP/6v+W
        aUAQ86s1Wz6e971udPGc9eHwZrA/yEaaLxMh0/XXMJ3wnRurC6ozkDUrbMODzp2tuFdJfDkdo01X9
        kV4QsrS3C3FeQdeDTNbYo5Uy10Puyka+qodbb0ef8h4xLWgnQ2hfkkPFGGVGvx+e5IVVMLdL493AO
        5gTUZyxWbFfmgDm2+ZTbbfWbYwH6UQABZH2rXGyygKfUWjDM+ORrN64tIkToRkPY6JpEjeDmv54/d
        zCWUoL9QX3p8cekEfIP7NvsY6G6T2t9WXUwRWEW1aMjZYjG/iCRA3zK5lNFyICJ1y8UiU0jTJ54v9
        DWXSZsiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfG0v-001Dih-2I;
        Thu, 23 Mar 2023 08:09:37 +0000
Date:   Thu, 23 Mar 2023 01:09:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Ryskalczyk <david@rysk.us>, linux-btrfs@vger.kernel.org
Subject: Re: Kernel panic due to stack recursion when copying data from a
 damaged filesystem
Message-ID: <ZBwJQcvt2TcqoCRh@infradead.org>
References: <E567648E-DEE9-49EB-8B01-3CE403E4E87C@rysk.us>
 <b9ed921a-2cd2-411a-4374-c7682b56c45e@gmx.com>
 <ZBwC7n9crUsk4Pfi@infradead.org>
 <9628f5a7-2752-4f74-70e1-f8efd345bdc7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9628f5a7-2752-4f74-70e1-f8efd345bdc7@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 03:57:57PM +0800, Qu Wenruo wrote:
> It's metadata, but that's not the cause of the stack recursion.
> 
> If you go with the frames with certainty, the stack would look like this:
> 
> btrfs_search_slot (fs/btrfs/ctree.c:2225) btrfs
> btrfs_lookup_csum (fs/btrfs/file-item.c:221) btrfs
> btrfs_lookup_bio_sums (fs/btrfs/file-item.c:315 fs/btrfs/file-item.c:484)
> btrfs
> btrfs_submit_data_read_bio (fs/btrfs/inode.c:2787) btrfs
> btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
> end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
> btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
> end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
> btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
> end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
> btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
> end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
> btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
> ...
> 
> Thus it's still data repair path causing the stack recursion, the metadata
> is just the unfortunately one triggered it.

I still think it is a similar issue, and endless recursion trying
to call back into repair without ever breaking out of that loop.

The interesting reason is why we'll never hit the

	if (failrec->this_mirror == failrec->failed_mirror) {

case and break out of the recursion.

Note that in 6.3-rc with the new repair code we'd at least not recurse,
although I suspect that whatever causes this endless loop would still
be present.

