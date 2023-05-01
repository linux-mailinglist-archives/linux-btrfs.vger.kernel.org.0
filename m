Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BA36F33A1
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 May 2023 18:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjEAQuc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 May 2023 12:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjEAQub (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 May 2023 12:50:31 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B9AE73
        for <linux-btrfs@vger.kernel.org>; Mon,  1 May 2023 09:50:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6E9CC5C004F;
        Mon,  1 May 2023 12:50:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 01 May 2023 12:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682959829; x=1683046229; bh=Lx
        Nk3kL4Dal30hOGQ3ODhaO2Bl/RMrlIEIQmSRjG+pU=; b=ruFp8R5CFCrocaqcAd
        OJX5KMH5Pa5ffdFo2bRCeC/P+ERh8J0AZ3st9qY4DKePtf37IyhnNtAPsMzyD7lT
        kHbNCFut3fwzNa02d+TnsSMQt8JT8fOc6lhIMRs/nkPERyNHBKRU1brmF82kUyPE
        7iU7brgptiqjKlV7a1yuI+7TJX2coaUF+9aizrgwbS8/mzOtXwPRTgdDdZcohfB/
        LtdG+lhgDDRWq2Nn0hnuMa8mRET1pefVSivqN3mgBSWcPJe/q8RV0+gFJTh0uJD+
        K1bxn7H0Hgawst7nRMWiO2Y+OmUmDCzufjBfWdpUnvxLvOY0Ayv9IZPUVb7Nqndy
        Xr/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682959829; x=1683046229; bh=LxNk3kL4Dal30
        hOGQ3ODhaO2Bl/RMrlIEIQmSRjG+pU=; b=dOk110NEaPDWEsboUdN4u4d+gtbNZ
        VL52v3fmitBMCJRjzCo+49ejid/1GsnnFlrLcTI2tidhaNsoO6pWVchT1Eo/cFFC
        ELvpiXO6vPTxeOlDn80m/kIZeP0iWjt9YdR8JgWtFS3Cv0iWkXbfvWdMGA6WA3ax
        cd6443HIfLjLNpvXvU8eAUJrH5mGyEQFQFigCnu7ROZJbjyqaFTzk4wjoGQnYEiF
        ydVKV/w9tJ0XZYmPaHX1Swtf34x5Vjs65jaCFW2wubDSgLtrrArtpLLauntSpOeQ
        OtWBOcdeC0qpn0A0yj81c7TvVQm96WbTxGGGRI61OfkeFnTPeLgreAzfA==
X-ME-Sender: <xms:1e1PZKH5iXR242FzjZk9KONIusSQikcOKeOTL0x_8guw4tp4eY92jQ>
    <xme:1e1PZLULaJtbS9itg0Bw8ccHWbwC51dI4iG5mNUVk6GCye_4wbbpckaMHbQAye0XU
    UM0xgNE5S7W5LKygTM>
X-ME-Received: <xmr:1e1PZELyDV5GXxAHF3NINmlPCwD_FLzJQtXld4qv5AFR3t7QtVq1oRP_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvgedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:1e1PZEHeUmkXhMCKrifPb255X087_duHcUs12v23dGOR313YSqGC3A>
    <xmx:1e1PZAXMJsow3QRmJ_jGVja6M_lA7SQzO0JA6ZBhH1cbctO7jWtZ8A>
    <xmx:1e1PZHP4U9kmBbmALnyYXL436EBq238kPNCES0aD5FKn4jdf1vpGSA>
    <xmx:1e1PZNh0O3wsYbodVnHYlo56L96luNWpbgcERNUa0Ce58SHHZV-NWg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 May 2023 12:50:28 -0400 (EDT)
Date:   Mon, 1 May 2023 09:50:16 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        'Qu Wenruo ' <wqu@suse.com>
Subject: Re: [PATCH RFC] btrfs: fix qgroup rsv leak in subvol create
Message-ID: <20230501165016.GA3094799@zen>
References: <c98e812cb4e190828dd3cdcbd8814c251233e5ca.1682723191.git.boris@bur.io>
 <23f9b436-223c-918c-a3fd-290c3ac3bd7e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23f9b436-223c-918c-a3fd-290c3ac3bd7e@gmx.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 29, 2023 at 03:18:26PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/4/29 07:08, Boris Burkov wrote:
> > While working on testing my quota work, I tried running all fstests
> > while passing mkfs -R quota. That shook out a failure in btrfs/042.
> > 
> > The failure is a reservation leak detected at umount, and the cause is a
> > subtle difficulty with the qgroup rsv release accounting for inode
> > creation.
> 
> Mind to give an example of the leakage kernel error message?
> As such message would include the type of the rsv.
> 
> > 
> > The issue stems from a recent change to subvol creation:
> > btrfs: don't commit transaction for every subvol create
> > 
> > Specifically, that test creates 10 subvols, and in the mode where we
> > commit each time, the logic for dir index item reservation never decides
> > that it can undo the reservation. However, if we keep joining the
> > previous transaction, this logic kicks in and calls
> > btrfs_block_rsv_release without specifying any of the qgroup release
> > return counter stuff. As a result, adding the new subvol inode blows
> > away the state needed for the later explicit call to
> > btrfs_subvolume_release_metadata.
> 
> Is there any reproducer for it?

I believe that all you need is to run btrfs/042 with MKFS_OPTIONS set to
include "-R quota".

> 
> By the description it should be pretty simple as long as we create multiple
> subvolumes in one transaction.
> 
> I'd like to have some qgroup related trace enabled to show the problem more
> explicitly, as I'm not that familiar with the delayed inode code.
> 
> Thanks,
> Qu
> > 
> > I suspect this fix is incorrect and will break something to do with
> > normal inode creation, but it's an interesting starting point and I
> > would appreciate any suggestions or help with how to really fix it,
> > without reverting the subvol commit patch. Worst case, I suppose we can
> > commit every time if quotas are enabled.
> > 
> > The issue should reproduce on misc-next on btrfs/042 with
> > MKFS_OPTIONS="-K -R quota"
> > in the config file.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >   fs/btrfs/delayed-inode.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index 6b457b010cbc..82b2e86f9bd9 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
> > @@ -1480,6 +1480,7 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
> >   		delayed_node->index_item_leaves++;
> >   	} else if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) {
> >   		const u64 bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
> > +		u64 qgroup_to_release;
> >   		/*
> >   		 * Adding the new dir index item does not require touching another
> > @@ -1490,7 +1491,8 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
> >   		 */
> >   		trace_btrfs_space_reservation(fs_info, "transaction",
> >   					      trans->transid, bytes, 0);
> > -		btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, NULL);
> > +		btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, &qgroup_to_release);
> > +		btrfs_qgroup_convert_reserved_meta(delayed_node->root, qgroup_to_release);
> >   		ASSERT(trans->bytes_reserved >= bytes);
> >   		trans->bytes_reserved -= bytes;
> >   	}
