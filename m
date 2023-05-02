Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A554E6F3C6D
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 05:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjEBDen (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 May 2023 23:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjEBDek (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 May 2023 23:34:40 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A9540E8
        for <linux-btrfs@vger.kernel.org>; Mon,  1 May 2023 20:34:37 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7A7F232009C1;
        Mon,  1 May 2023 23:34:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 01 May 2023 23:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682998475; x=1683084875; bh=A8
        YuZZcY/cWCXTrjXNqAkRf76Stccsht4YqvO46A8Rg=; b=p6dBn3bjAZXz1ZMYOb
        dOHnkMNCTv0B/3XxFwS3SYqoNlfqZYjuYECYtGiR1KLecI5KI7W00WXamfUGGhzB
        6tMIukIb4KpVAv6m6XzaCPk29joeUucto/Zj9kZnLZcCDAtqKXF6HspgI9QlzaNG
        dcNUfeoRsTqvaGuFWIeY36gVDjRZSjf41ZibArq8PU5oAgbY3w403tetCxCB5bcS
        UF5V/FlzsRMT9a/G5jsiUIQtWEOK+njFF8sfYht31GT//R3jewePm8ZJSRaV2wVs
        Bt9HvwVmXKKWoBdQCFpeac/UfX7H21Kbbk2m+2xWTpJn/7lg2FlcSOrBWkXa61zp
        lFxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682998475; x=1683084875; bh=A8YuZZcY/cWCX
        TrjXNqAkRf76Stccsht4YqvO46A8Rg=; b=S9b4tWlpF38nPHvcdSQkCLED83rEQ
        etYpwEomE+cySCXXzb5qLJT1762mG+nhzBarNlFq2DQsEyUMVw6OHpBt9M0K7XLW
        xSv2uQnNSbi0gdgRnysRSLHK79eYY9Jw6szur3IMsnRUXd+LVf88nDW5+O3CmuYY
        dK30rRkv770Iaop2O5nWISBAJZ6ukAi7/kJwoX3gmFvuZTWuBnkm8/pyGnr+bXMg
        mVfZ10b9A1yJr10CqPXzfUsMj26wEjryWBsGZVL58XMJDuVRu7bAvR9/44h3VlYY
        TNY5M70HyMAlOXHr9cd31HrZTpH/+TjajbkzAmC1JzRId421C/3vo5Lng==
X-ME-Sender: <xms:yoRQZFWjaYkftOsQB_61YN21-49HKDKOyggcFdU8KhoGN_WM7ERCmA>
    <xme:yoRQZFkFC_vI4EoGl8cl61jkHhInTvSnr9Bpi9Ctq29xHC8WaftzbXvYfN3FbFvQH
    Tn4zm8nC_AcZAitgZc>
X-ME-Received: <xmr:yoRQZBaV693mn5UJzxJbzWD2ke3afGpg9zDTmXR7zPa63Yr68ImHCo8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvhedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    elgefftdeiveduveeffeeklefguddujeeihfetiedukeeghffggedvledulefftdenucff
    ohhmrghinhepthhogihitghprghnuggrrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:yoRQZIWqa-4XI1cZiz-u4eZ1ERooU8dIwnVWGKv27Ik8VoBQWvlffQ>
    <xmx:yoRQZPnc6gMG-Qv7BUN22hI6RKBcuiW1q4IeW5gKMFWqNQQW-dT9Yg>
    <xmx:yoRQZFdo-tHrV4XVq2ubNiSiQZ8w59q5rj6IjLsqoytDeuGZZPzxrg>
    <xmx:y4RQZEwwTbSEJT8xT5mo4UuSK2bOUVp7zlqcKIw8ZXIGocUjJJqGVA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 May 2023 23:34:34 -0400 (EDT)
Date:   Mon, 1 May 2023 20:34:21 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH RFC] btrfs: fix qgroup rsv leak in subvol create
Message-ID: <20230502033421.GA3175929@zen>
References: <c98e812cb4e190828dd3cdcbd8814c251233e5ca.1682723191.git.boris@bur.io>
 <23f9b436-223c-918c-a3fd-290c3ac3bd7e@gmx.com>
 <20230501165016.GA3094799@zen>
 <d6111cfa-1315-2c45-67b3-3946a7229896@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6111cfa-1315-2c45-67b3-3946a7229896@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 02, 2023 at 06:58:33AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/5/2 00:50, Boris Burkov wrote:
> > On Sat, Apr 29, 2023 at 03:18:26PM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2023/4/29 07:08, Boris Burkov wrote:
> > > > While working on testing my quota work, I tried running all fstests
> > > > while passing mkfs -R quota. That shook out a failure in btrfs/042.
> > > > 
> > > > The failure is a reservation leak detected at umount, and the cause is a
> > > > subtle difficulty with the qgroup rsv release accounting for inode
> > > > creation.
> > > 
> > > Mind to give an example of the leakage kernel error message?
> > > As such message would include the type of the rsv.
> > > 
> > > > 
> > > > The issue stems from a recent change to subvol creation:
> > > > btrfs: don't commit transaction for every subvol create
> > > > 
> > > > Specifically, that test creates 10 subvols, and in the mode where we
> > > > commit each time, the logic for dir index item reservation never decides
> > > > that it can undo the reservation. However, if we keep joining the
> > > > previous transaction, this logic kicks in and calls
> > > > btrfs_block_rsv_release without specifying any of the qgroup release
> > > > return counter stuff. As a result, adding the new subvol inode blows
> > > > away the state needed for the later explicit call to
> > > > btrfs_subvolume_release_metadata.
> > > 
> > > Is there any reproducer for it?
> > 
> > I believe that all you need is to run btrfs/042 with MKFS_OPTIONS set to
> > include "-R quota".
> 
> Indeed, now it fails consistently.
> 
> Although you don't need the extra mkfs options, as the test itself is
> utilizing qgroups already.

Good point. I assumed I needed the flag because the test passes in
Josef's CI thing, and I was doing the weird thing of testing with quotas
enabled via mkfs. http://toxicpanda.com/btrfs/042.html

But looking at it, it should just be totally broken as the subvols are
created after quota is enabled. I guess Josef must not have rebased past
that patch yet.

> 
> Thanks,
> Qu
> > 
> > > 
> > > By the description it should be pretty simple as long as we create multiple
> > > subvolumes in one transaction.
> > > 
> > > I'd like to have some qgroup related trace enabled to show the problem more
> > > explicitly, as I'm not that familiar with the delayed inode code.
> > > 
> > > Thanks,
> > > Qu
> > > > 
> > > > I suspect this fix is incorrect and will break something to do with
> > > > normal inode creation, but it's an interesting starting point and I
> > > > would appreciate any suggestions or help with how to really fix it,
> > > > without reverting the subvol commit patch. Worst case, I suppose we can
> > > > commit every time if quotas are enabled.
> > > > 
> > > > The issue should reproduce on misc-next on btrfs/042 with
> > > > MKFS_OPTIONS="-K -R quota"
> > > > in the config file.
> > > > 
> > > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > > ---
> > > >    fs/btrfs/delayed-inode.c | 4 +++-
> > > >    1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > > > index 6b457b010cbc..82b2e86f9bd9 100644
> > > > --- a/fs/btrfs/delayed-inode.c
> > > > +++ b/fs/btrfs/delayed-inode.c
> > > > @@ -1480,6 +1480,7 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
> > > >    		delayed_node->index_item_leaves++;
> > > >    	} else if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) {
> > > >    		const u64 bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
> > > > +		u64 qgroup_to_release;
> > > >    		/*
> > > >    		 * Adding the new dir index item does not require touching another
> > > > @@ -1490,7 +1491,8 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
> > > >    		 */
> > > >    		trace_btrfs_space_reservation(fs_info, "transaction",
> > > >    					      trans->transid, bytes, 0);
> > > > -		btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, NULL);
> > > > +		btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, &qgroup_to_release);
> > > > +		btrfs_qgroup_convert_reserved_meta(delayed_node->root, qgroup_to_release);
> > > >    		ASSERT(trans->bytes_reserved >= bytes);
> > > >    		trans->bytes_reserved -= bytes;
> > > >    	}
