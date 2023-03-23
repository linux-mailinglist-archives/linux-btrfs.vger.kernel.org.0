Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1386C7256
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 22:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCWV3m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 17:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjCWV3l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 17:29:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C2711EB4
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 14:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ODew+flbbTIknuZWnrDaW3l1+lwISBbW85J2IexmAOo=; b=vD43eHJAHJD1W+Q0XHDxJEFkGv
        vOXcVsCQ4i52bXAz8EmJD8NRvZW4w8GEKKjXz+2o8w7HbtjlX/iQavCXuWhzeod3xY0vqJV4N2Bxm
        Pu0HYQeKt4Mh8V5XVEwmc11WNbUmgqq1/x/ToJckhdVQLP/HZ4EEs61kup5k1tCkPU1Q3vhgf493/
        lbFYoPOud5gsWS89FkYuRTu4DrYIFJZbgA5LNm+BaL2qgiNe4wwLDOZbde79WcadhV545+vQ5JkcN
        YWTuiRFSM+HiE1Ah+R7LzZQ3ujpYHWErspmIela/NtmDs17QVD9mOwVJnsCHupHou10O0xJYsLzxj
        nsXulpgA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfSV9-00314P-2U;
        Thu, 23 Mar 2023 21:29:39 +0000
Date:   Thu, 23 Mar 2023 14:29:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Boris Burkov <boris@bur.io>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v5 3/5] btrfs: return ordered_extent splits from bio
 extraction
Message-ID: <ZBzEw4gy8lhNYgo7@infradead.org>
References: <cover.1679512207.git.boris@bur.io>
 <cf69fdbd608338aaa7916736ac50e2cfdc3d4338.1679512207.git.boris@bur.io>
 <ZBwSIGXZipuob/61@infradead.org>
 <20230323161529.GA8070@zen>
 <20230323170006.GA28317@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323170006.GA28317@zen>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 10:00:06AM -0700, Boris Burkov wrote:
> Your branch as-is does not pass the existing tests, It's missing a fix
> from my V5. We need to avoid splitting partial OEs when doing NOCOW dio
> writes, because iomap_begin() does not create a fresh pinned em in that
> case, since it reuses the existing extent.

Oops, yes, that got lost.  I can add this as another patch attributed
to you.

That beeing said, I'm a bit confused about:

 1) if we need this split call at all for the non-zoned case as we don't
    need to record a different physical disk address
 2) how we clean up this on-disk logical to physical mapping at all on
    a write failure

Maybe we should let those dragons sleep for now and just do the minimal
fix, though.

I just woke up on an airplane, so depending on my jetlag I might have
a new series ready with the minimal fix for varying definitions of
"in a few hours".

> 
> e.g.,
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8cb61f4daec0..bbc89a0872e7 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7719,7 +7719,7 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
>          * cancelled in iomap_end to avoid a deadlock wherein faulting the
>          * remaining pages is blocked on the outstanding ordered extent.
>          */
> -       if (iter->flags & IOMAP_WRITE) {
> +       if (iter->flags & IOMAP_WRITE && !test_bit(BTRFS_ORDERED_NOCOW, &dio_data->ordered->flags)) {
>                 int err;
> 
>                 err = btrfs_extract_ordered_extent(bbio, dio_data->ordered);

I think the BTRFS_ORDERED_NOCOW should be just around the
split_extent_map call.  That matches your series, and without
that we wouldn't split the ordered_extent for nowcow writes and thus
only fix the original problem for non-nocow writes.
