Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C025549C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 14:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiFVJPG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 05:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348349AbiFVJOw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 05:14:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97810FC1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 02:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D6A0619D6
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 09:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B40C34114;
        Wed, 22 Jun 2022 09:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655889239;
        bh=oW47ot2JR0RJdGDO76GrJ1HzG0hDq7YWgsY6UUSnByY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSwYOqy2DSGiqIhij6KeTIb9PkmJV/ruTfqRnhtRSrbWl5h2gTMonM33biMqy+8SL
         FxHufZyBt8YsSQDQGk0x2lbOyHYah75W3qNrdMbuzH/mEiFOSb8pdqV0QEs9GE6eIZ
         6jgklJZQmuDiaYUx0Ue9FF3FoLtNpz69C3eruJN2gBufmdd9BLRPONOPSN3gSLLfug
         21SF5HmO9mNJ+v9HSw6G7cmCa7DKQMTzu9yDeg8ECnYLCWQTv5YwuldipJU/8/aHIL
         AfNeyErPCVpAZ37ZnB4sXH//xmDxl5dvV+mi8FgoGGCPfg3qQhl7JxCgKWtyefZzdr
         PZ2eJPW3cnHYA==
Date:   Wed, 22 Jun 2022 10:13:56 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] btrfs: fix error handling of fallbacked
 uncompress write
Message-ID: <20220622091356.GA81185@falcondesktop>
References: <cover.1655791781.git.naohiro.aota@wdc.com>
 <7347f1de449c3a3f36690b816c2ded133508c5c2.1655791781.git.naohiro.aota@wdc.com>
 <20220621150414.GA23327@falcondesktop>
 <20220622005625.egeljuu2o423wv6y@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622005625.egeljuu2o423wv6y@naota-xeon>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 22, 2022 at 12:56:25AM +0000, Naohiro Aota wrote:
> On Tue, Jun 21, 2022 at 04:04:14PM +0100, Filipe Manana wrote:
> > On Tue, Jun 21, 2022 at 03:41:01PM +0900, Naohiro Aota wrote:
> > > When cow_file_range() fails in the middle of the allocation loop, it
> > > unlocks the pages but leaves the ordered extents intact. Thus, we need to
> > > call btrfs_cleanup_ordered_extents() to finish the created ordered extents.
> > > 
> > > Also, we need to call end_extent_writepage() if locked_page is available
> > > because btrfs_cleanup_ordered_extents() never process the region on the
> > > locked_page.
> > > 
> > > Furthermore, we need to set the mapping as error if locked_page is
> > > unavailable before unlocking the pages, so that the errno is properly
> > > propagated to the userland.
> > > 
> > > CC: stable@vger.kernel.org # 5.18+
> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > ---
> > > I choose 5.18+ as the target as they are after refactoring and we can apply
> > > the series cleanly. Technically, older versions potentially have the same
> > > issue, but it might not happen actually. So, let's choose easy targets to
> > > apply.
> > > ---
> > >  fs/btrfs/inode.c | 17 +++++++++++++++--
> > >  1 file changed, 15 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > > index 326150552e57..38d8e6d78e77 100644
> > > --- a/fs/btrfs/inode.c
> > > +++ b/fs/btrfs/inode.c
> > > @@ -933,8 +933,18 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
> > >  		goto out;
> > >  	}
> > >  	if (ret < 0) {
> > > -		if (locked_page)
> > > +		btrfs_cleanup_ordered_extents(inode, locked_page, start, end - start + 1);
> > > +		if (locked_page) {
> > > +			u64 page_start = page_offset(locked_page);
> > > +			u64 page_end = page_start + PAGE_SIZE - 1;
> > > +
> > > +			btrfs_page_set_error(inode->root->fs_info, locked_page,
> > > +					     page_start, PAGE_SIZE);
> > > +			set_page_writeback(locked_page);
> > > +			end_page_writeback(locked_page);
> > > +			end_extent_writepage(locked_page, ret, page_start, page_end);
> > >  			unlock_page(locked_page);
> > > +		}
> > >  		goto out;
> > >  	}
> > >  
> > > @@ -1383,9 +1393,12 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
> > >  	 * However, in case of unlock == 0, we still need to unlock the pages
> > >  	 * (except @locked_page) to ensure all the pages are unlocked.
> > >  	 */
> > > -	if (!unlock && orig_start < start)
> > > +	if (!unlock && orig_start < start) {
> > > +		if (!locked_page)
> > > +			mapping_set_error(inode->vfs_inode.i_mapping, ret);
> > 
> > Instead of this we can pass PAGE_SET_ERROR in page_ops, which will result in
> > setting the error in the inode's mapping.
> 
> PAGE_SET_ERROR always set the error as EIO, so it cannot propagate other
> errors returned by cow_file_range() to the userland. Thus, I choose
> mapping_set_error() here.

Ok, actually only EIO and ENOSPC are used as mapping errors. mapping_set_error()
converts any error other than ENOSPC to AS_EIO. And it's been like for many years
as far as I remember.

> 
> > 
> > In fact we currently only mark the locked page with error (at writepage_delalloc()).
> 
> Yes and at submit_uncompressed_range() with this series applied.
> 
> > However all pages before and after it are still locked and we don't set the error on
> > them, I think we should - I don't see why not.
> 
> No, we unlock all pages except locked_pages in the error case, and yes, we

Yes, but by passing PAGE_SET_ERROR, we will end up setting the error bit on the
pages before unlocking them.

> set the error only on the locked_page. So, that will make the other pages
> to be writebacked later again (and make tons of the
> btrfs_writepage_fixup_work). That is common among unlock = 0 case and
> unlock = 1 case. Should we change that?

I don't see why not. But that can be done later in a separate patch, no worries.
Just something I think I didn't notice before.

Ok, the whole patchset looks good to me, thanks.

> 
> Setting all the pages as error would be good to avoid the tons of fixup in
> this case.
> 
> > Did I miss something (again)?
> > 
> > Sorry I only noticed this now.
> > 
> > Thanks.
> > 
> > >  		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
> > >  					     locked_page, 0, page_ops);
> > > +	}
> > >  
> > >  	/*
> > >  	 * For the range (2). If we reserved an extent for our delalloc range
> > > -- 
> > > 2.35.1
> > > 
