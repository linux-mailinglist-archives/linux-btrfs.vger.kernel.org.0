Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721084E583F
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 19:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243889AbiCWSS1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 14:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238448AbiCWSS1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 14:18:27 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE0488B3D
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 11:16:56 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0F6973202041;
        Wed, 23 Mar 2022 14:16:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 23 Mar 2022 14:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=HPuu9QDvLvdOkC2D8cQXXIzqCm/6Z/sHc8addR
        eSPrU=; b=ecaOwNfz5B9bxqYlhuqj64UXVJk2A9+FMUWU8DIWakiOIs2XL02X7A
        MaXPaJmfAkm6tD0e7bKRdcHwrDzlDGUvR8hzRoyXiXks7uSI1V0NRmOVH1XYJuSR
        jhQ0OO2V8WkAV7wM9QrB6r4+xamZ6+huKeP7Y/JtqxXB1bb5osVaJEJKs0y0+KMG
        l6Y8TUe1Dd5aoI96ryYfaswz7XWZuopxvTo/NzhacCOeHBRo665y8V0ocfbyp0T3
        ufvriIt5S7raTF+ZxstkHCQPq7kdxNVvootnWvMotVMEJxsazMN6r3jeuKs4Bih9
        NDnqVYyoMpJOXOs83DXMyUoJiRxdKnVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=HPuu9QDvLvdOkC2D8
        cQXXIzqCm/6Z/sHc8addReSPrU=; b=LZYOVQZ33JzOM+gZ5hiXN4nrgHxSLQ7xy
        EEMz+xjc/+FMKpBYbOu9Oa9KZGj10qzMu5GHVz6OkhWVXL5aSi3a++aQMOqMw1vP
        AKWzT0XgSgBX8FecHXhBeYXjeWo2v048GnBE3zUMYDYTVgkXhho19z6+LxqNlQcc
        Ont1uKK61wcIqIVrrdlLVe+dYAL5MHDDsN6jlrDMnAeTMG++Ygh4nbWyZqzky7xs
        FbS+Oom5I2WnvNQEC8P5/Z9KHkJRkW4gxkkyFZ8zU0NWxNu3jXzP92IaDVtpZjOT
        NR12rCFrX8QLEiph2WRnf6t1kAbqrCggxYcpguzzfMLhyu3IsnuXw==
X-ME-Sender: <xms:FWQ7YnN351PRJAzWJ_pLTVFh4FbpOuu0syHKBkxej6I3AYs77HREfg>
    <xme:FWQ7Yh9K2c50DiCa-wpr_WW5qMSREdfI0Fmwr-lZ_tKqo-pBJa8mTSr25kXxFOyB7
    2RzHIVplaygm36gh_M>
X-ME-Received: <xmr:FWQ7YmTBEHl4b_9AV6RCafxTDG5FDJWnFdwfGrIwY9ypVevu4DE8AXpIP_t5DGEZEHuRBwZKzEAjfMoPgVRRias5GZCEzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegjedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    eikeeuhffgtdegudfffffhtdfhtdeutefhhfetledvfedtvefhtdfhhefgjeejieenucff
    ohhmrghinhepghhithhhuhgsuhhsvghrtghonhhtvghnthdrtghomhdpmhhkshgvvggurd
    hshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegs
    ohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:FWQ7Yrub9d6PzYuLMCMFOj3F8dBsGEsbtWgDel0gYx6doqDifsxlCA>
    <xmx:FWQ7YvcUJY8TGmXsZvTf0Jdpf2Nu1JZ41e2Cm6JJwcI4vlWp9nyIuw>
    <xmx:FWQ7Yn1zOkpNRTCBs_zeMVqwv68ieJqOtz89f3D4u8gY0k26DFk2BQ>
    <xmx:FWQ7YnFDwAsxDIj061oekEQqcVLg4lctP4cVybnlcHnGPsj2FuAiEg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Mar 2022 14:16:53 -0400 (EDT)
Date:   Wed, 23 Mar 2022 11:16:51 -0700
From:   Boris Burkov <boris@bur.io>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
Message-ID: <YjtkE6DkhV0V0gXq@zen>
References: <16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io>
 <20220323005215.22qkdgherdyrocuq@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323005215.22qkdgherdyrocuq@naota-xeon>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 23, 2022 at 12:52:15AM +0000, Naohiro Aota wrote:
> On Mon, Mar 21, 2022 at 04:56:17PM -0700, Boris Burkov wrote:
> > If you follow the seed/sprout wiki, it suggests the following workflow:
> > 
> > btrfstune -S 1 seed_dev > > mount seed_dev mnt
> > btrfs device add sprout_dev
> > mount -o remount,rw mnt
> > 
> > The first mount mounts the FS readonly, which results in not setting
> > BTRFS_FS_OPEN, and setting the readonly bit on the sb. The device add
> > somewhat surprisingly clears the readonly bit on the sb (though the
> > mount is still practically readonly, from the users perspective...).
> > Finally, the remount checks the readonly bit on the sb against the flag
> > and sees no change, so it does not run the code intended to run on
> > ro->rw transitions, leaving BTRFS_FS_OPEN unset.
> > 
> > As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN and
> > does no work. This results in leaking deleted snapshots until we run out
> > of space.
> > 
> > I propose fixing it at the first departure from what feels reasonable:
> > when we clear the readonly bit on the sb during device add. I have a
> > reproducer of the issue here:
> > https://raw.githubusercontent.com/boryas/scripts/main/sh/seed/mkseed.sh
> > and confirm that this patch fixes it, and seems to work OK, otherwise. I
> > will admit that I couldn't dig up the original rationale for clearing
> > the bit here (it dates back to the original seed/sprout commit without
> > explicit explanation) so it's hard to imagine all the ramifications of
> > the change.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/volumes.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 3fd17e87815a..75d7eeb26fe6 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -2675,8 +2675,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
> >  	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
> >  
> >  	if (seeding_dev) {
> > -		btrfs_clear_sb_rdonly(sb);
> > -
> 
> After this line, it updates the metadata e.g, with
> init_first_rw_device() and writes them out with
> btrfs_commit_transaction(). Is that OK to do so with the SB_RDONLY
> flag set?

Good question. As far as I can tell, the functions don't explicitly
check sb_rdonly, though that could be because they expect that to be
checked before you ever try to commit a transaction, for example..

If there is an issue, it's probably somewhat subtle, because the basic
behavior does work.

> 
> >  		/* GFP_KERNEL allocation must not be under device_list_mutex */
> >  		seed_devices = btrfs_init_sprout(fs_info);
> >  		if (IS_ERR(seed_devices)) {
> > @@ -2819,8 +2817,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
> >  	mutex_unlock(&fs_info->chunk_mutex);
> >  	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
> >  error_trans:
> > -	if (seeding_dev)
> > -		btrfs_set_sb_rdonly(sb);
> >  	if (trans)
> >  		btrfs_end_transaction(trans);
> >  error_free_zone:
> > -- 
> > 2.30.2
> > 
