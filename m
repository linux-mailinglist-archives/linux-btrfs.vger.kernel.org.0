Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC936959A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Feb 2023 08:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjBNHG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Feb 2023 02:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjBNHGq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Feb 2023 02:06:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413BB1F5E9
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 23:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=88HFu22HRI7wTzrkPqwCQk8ExXD8eb38iPhl3X3wLjM=; b=DWBs0a1UuvnbmpV6bCkS5TCgbf
        KE2qwaWZQBeHNeSByUA76JUpCH0QQ/hI3fJiPXXp0tkOrPtk9MX3tmscK37K3h4w4oam3U+elofrV
        ySP0u9hP8wS08mBJe3seSvwcDXiGd58GqyJJFkeMj9+KO9rtMSaJWWbmDWUG4tu5SqzZ+1qiHLHt2
        rYH+UHcx8a5ffUqaio7CTlMeQyY1UOsnXRVrf+PgE/CBRGisA2V5Qu9QAZ8zc27zwC+NsHFsS3PEo
        YoRCsDJQBICTtO3hDW1F5ZeuWFNj9Nsu7vcjhV5HdobVRIUokj6xV0OEFWApjNS+4qt3V7Kk7mz9g
        JP7GpMRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRpOJ-0007gj-Ng; Tue, 14 Feb 2023 07:06:15 +0000
Date:   Mon, 13 Feb 2023 23:06:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Stefan Behrens <sbehrens@giantdisaster.de>
Subject: Re: [PATCH RFC] btrfs: do not use the replace target device as an
 extra mirror
Message-ID: <Y+sy5xHfz6S16/oc@infradead.org>
References: <2902738be4657ec16e5b5dd38eac1fb53aa5cc44.1675918006.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2902738be4657ec16e5b5dd38eac1fb53aa5cc44.1675918006.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 09, 2023 at 12:47:01PM +0800, Qu Wenruo wrote:
> Since the ancient time of btrfs, if a dev-replace is running, we can use
> that replace target as an extra mirror for read.

More specifically this seems to go back to:

Author: Stefan Behrens <sbehrens@giantdisaster.de>
Date:   Tue Nov 6 15:06:47 2012 +0100

    Btrfs: allow repair code to include target disk when searching mirrors

    Make the target disk of a running device replace operation
    available for reading. This is only used as a last ressort for
    the defect repair procedure. And it is dependent on the location
    of the data block to read, because during an ongoing device
    replace operation, the target drive is only partially filled
    with the filesystem data.

and

commit 30d9861ff9520e2a112eae71029bc9f7e915a441
Author: Stefan Behrens <sbehrens@giantdisaster.de>
Date:   Tue Nov 6 14:52:18 2012 +0100

    Btrfs: optionally avoid reads from device replace source drive        

    It is desirable to be able to configure the device replace
    procedure to avoid reading the source drive (the one to be
    copied) whenever possible. This is useful when the number of
    read errors on this disk is high, because it would delay the
    copy procedure alot. Therefore there is an option to avoid
    reading from the source disk unless the repair procedure
    really needs to access it. The regular read req asks for
    mapping the block with mirror_num == 0, in this case the
    source disk is avoided whenever possible. The repair code
    selects the mirror_num explicitly (mirror_num != 0), this
    case is not changed by this commit.

from which I father that the idea is that when a drive is replaced
due to a high number of read errors, it might be a better idea to
redirect it to the target device.

The questions is how much does this matter?  NAND storage has a concept
of read disturb, but we really should not be hitting it in practice.

> But there are some extra problems with that:
> 
> - No reliable checks on if that target device is even involved
>   For profiles like RAID0/RAID10, it's very possible that the replace
>   is happening on one device which is not involved in the stripe.
> 
>   E.g. a 4-disks RAID0, involving disk A~D, and disk A is being replaced.
>   In that case, if our read lands at disk B, there is no extra mirror to
>   start with.
> 
> - No indicator on whether the target device even contains correct data
>   Since dev-replace is running, the target device is progressively
>   filled with data from the source device.
> 
>   Thus if our read is beyond the currently replaced range, we may just
>   read out some garbage.
>   This can be extremely dangerous if the range doesn't have data
>   checksum, then we may silently trust the garbage.

Yes, the way this is done currently seems pretty broken.

But there was a clear intent behind it, event exposed to userspace using
the BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID flag.

So at very least the target should not be used unless a replace with the
BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID flag is in
progress.  I'm not really here to judge how useful that flag is, but
if you want to remove reading from the target entirely we'dd need to
remove that flag as well and print a warning for it, as it clearly won't
work any more.

