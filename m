Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2346D110F
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 23:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjC3VuU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 17:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjC3VuT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 17:50:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D2DC173
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FU6IhdOG/UrFs0pUMeXRag0H4BvzrNeRrLtVEPykBIA=; b=r2wjBaDOyDwYy+f2KmscrBSJda
        +qetzcIlSlu2KDXkaIEzzbJxwYN3VrRAHL9EuEB+GXqidKP2A7JE0S9xFGyReHMEhN+FBbvjeQodz
        H0VN7IekZ3lDpUYjrCP4QSMspTKMtcaQJRyMXgaa7FTsU8w0izLj5mndG+EJ246tt53NgdM2igPDa
        gTzO/s1AEaZp/wwjM1uCcwRdAzQUyPSGXup+gUqd04dmy8z6e/tiaSUghe2nBTvwcg+s7BzsU93Mk
        sIrpjBPmdCVAmliQiG9xB9xCAjBogpQb5kvERgdglnUxGM3CgzfU8eex0tH/QJpk/tYf8PgYmaS3w
        Rm6FAMeQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pi09t-0059Qx-0Q;
        Thu, 30 Mar 2023 21:50:13 +0000
Date:   Thu, 30 Mar 2023 14:50:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v7 03/13] btrfs: introduce a new helper to submit read
 bio for scrub
Message-ID: <ZCYEFZpypvVu2Cqs@infradead.org>
References: <cover.1680047473.git.wqu@suse.com>
 <79a6604bc9ccb2a6e1355f9d897b45943c6bcca9.1680047473.git.wqu@suse.com>
 <ZCTKvcEccAreV+6g@infradead.org>
 <152b4cb0-db59-24d5-b7ee-4ecc57480fbc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152b4cb0-db59-24d5-b7ee-4ecc57480fbc@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 30, 2023 at 02:43:02PM +0800, Qu Wenruo wrote:
> > > 
> > > The repair part would be the same as non-RAID56, as we only need to try
> > > the next mirror.
> > 
> > Didn't we just agree that we do not need another magic helper?
> 
> I have changed the code in github repo so the read path just goes
> btrfs_submit_bio().
> 
> The patch adding bbio::fs_info and adds all the extra skips if bbio->inode
> is NULL:
> https://github.com/adam900710/linux/commit/23c5a1bf8ce98f205de574a15a0eb0518e56e80c

This seems to be a loose object in the repository.  I looked at
d8c93c7078fa8d75bd3e12f8a30df072831f1c47 on the scrub_stripe branch
instead.

This looks generally good to me.  A bunch of really minor nits:

In btrfs_check_read_bio the comment for the assert reads a little
strange to me, maybe

	/* Read-repair requires the inode field to be set by the submitter. */

In btrfs_end_bio_work I'd rework the check to check the inode first,
and add brances around the & check and test positively, i.e.

	if (bbio->inode && !(bbio->bio.bi_opf & REQ_META))
		btrfs_check_read_bio()
	else
		bbio->end_io(bbio);

as that reads easier.  It also matches what btrfs_raid56_end_io does.

In btrfs_submit_bio I'd add an empty line between the assert and
the while loop.

In alloc_new_bio I'd keep the setor initialization before the inode
and file_offset.

