Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C418F58D55F
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 10:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiHIIaI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Aug 2022 04:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbiHIIaF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Aug 2022 04:30:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA16321814
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 01:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M+p9oJoytZG6k9F07sqRy4UNGV3+j8Ifwvb7Eg1kEr8=; b=FrzUVRn3/VB+KUddjDLKm406ZZ
        S39n/gPW57o5BNl0a2NcyL6MXZWz6gPg7FI0ixJMz2Veu9ywZ4yCp76VKpWf8M15xh2IKSwuBrbjG
        J2yd1MH3L8dzBx/mY/UWSDusn7P1zPwp2smpOPCyGddQL4GYRMStJQamGs+ydSrSd1XtjneTO/mBc
        zcIKDZgtO6/OWOOf+8hP0iDba8Zzs9eJQLEFCBcXU6s4A4KIGGKzNhGQTXvkM6C8gzkyLtHXLHUEF
        8y0k0uxTtdDyIazmnFudHhRKdt1k/xYnGMe6KaGT21aQ7T5ZvGcLJhkkwlds3awnm+vSDJ1Amw1wM
        /MxQ0N5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oLKch-002lpp-K4; Tue, 09 Aug 2022 08:29:59 +0000
Date:   Tue, 9 Aug 2022 01:29:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: misc-next and for-next: kernel BUG at fs/btrfs/extent_io.c:2350!
 during raid5 recovery
Message-ID: <YvIbB5l4gtG4f/S9@infradead.org>
References: <YvHVJ8t5vzxH9fS9@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvHVJ8t5vzxH9fS9@hungrycats.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 08, 2022 at 11:31:51PM -0400, Zygo Blaxell wrote:
> There is now a BUG_ON arising from this test case:
> 
> 	[  241.051326][   T45] btrfs_print_data_csum_error: 156 callbacks suppressed
> 	[  241.100910][   T45] ------------[ cut here ]------------
> 	[  241.102531][   T45] kernel BUG at fs/btrfs/extent_io.c:2350!

This

        BUG_ON(!mirror_num);

so repair_io_failure gets called with a mirror_num of 0..

> 	[  241.128354][   T45]  clean_io_failure+0x21a/0x260

.. from clean_io_failure.  Which starts from failrec->this_mirror and
tries to go back to failrec->failed_mirror using the prev_mirror
helper.  prev_mirror looks like:

static int prev_mirror(const struct io_failure_record *failrec, int cur_mirror)
{
        if (cur_mirror == 1)
		return failrec->num_copies;
	return cur_mirror - 1;
}

So the only way we could end up with a mirror = 0 is if
failrec->num_copies is 0.  -failrec->num_copies is initialized
in btrfs_get_io_failure_record by doing:

        failrec->num_copies = btrfs_num_copies(fs_info, failrec->logical, sectorsize);

just adter allocating the failrec.  I can't see any obvious way how
btrfs_num_copies would return 0, though, as for raid5 it just copies
from btrfs_raid_array.

Any chance you could share a script for your reproducer?

