Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD5A4EB438
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 21:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241016AbiC2TrN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 15:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbiC2TrN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 15:47:13 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221AF6B0B1
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 12:45:27 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id F1FAE3202161;
        Tue, 29 Mar 2022 15:45:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 29 Mar 2022 15:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=Xlzrc0MccFtiSLscXEkUG+CjjX/AEmJIVwd53L
        Yt2Ak=; b=azG+cok/w7/9xtnt9zE+loc7PeI9wfBBiMgfkOKe2mLY9PvV8EF52W
        T+yMjignGs2sReZjGYuIwo4Rr7UUlLUHgvugc+gvnzrM6FAPVERimwexnz+0FJFg
        CvD5Zx2EWskBi3ywoBFJy+CwPkat8QgrFrJaxF6ksNUUAKIgsG7EkOsbB6NXyrdC
        HdGApXpxNgib6GWqV33/dol2NHgnIRZZwgKARfkR7GG2J9pvuD6yELnqQoKSA0yU
        Tktn52LC4+dV5Ym6/PILca1AZWIw/jhWFi2OzH8LE+ARAV4vJ7p97ShDV5jSgRD5
        1RCcvA/a16/z8urdtSKeQJWGDwFN5jgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Xlzrc0MccFtiSLscX
        EkUG+CjjX/AEmJIVwd53LYt2Ak=; b=NFXVyYcSxQc/pmlXOVy+yzasLu/NkjZD3
        fzIy0WJTqC0ytdhzPfBhh7gvQBqkjzmPd26A2iluWb5rkfrn8VlNBQ5uDkbvJPHB
        QoqaTf8/Zx+Z+9IoXoWKUNPtsxGEgdx2k/KApYdphOJwMuTb47jdiJsY1nziP1ja
        eoB1VH+j/9/eNUj/jE2ogQr6DPfU+LatspeSg8Vi80cpb35hPpQTVhsoQbYgW+9L
        cZb1Ja677m7O5ypMOIkKuwhOLNv6ezb6NUq8+xb7tA+SLDV0iEiHvmczmqzvlLbn
        z/BdQGAKcfPcNbCBEN2+ZHW9jFPYdNUvkyvGOWYa9ZbLnp/tsiiHw==
X-ME-Sender: <xms:0mFDYoWwLvAgNJgrwtJUp4FPFArkk0-SohHEptcqfKiHWujfFvz4QQ>
    <xme:0mFDYsnCCo_CcKfnzWjxa1I3wR1txYCuRT4BiRYdKYz7lxFCh1dWlUEHnk8-n0wFv
    U3_rtpq6URMKUs4wkw>
X-ME-Received: <xmr:0mFDYsbdQWmCBgEhrwBDraMXJ9bYr46v-s7kgzljpUDpZ9vnwG321OxMMegz1U9kdfo1WK0C4WM3pVrWnzcTxKXO-QT6eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeitddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    eikeeuhffgtdegudfffffhtdfhtdeutefhhfetledvfedtvefhtdfhhefgjeejieenucff
    ohhmrghinhepghhithhhuhgsuhhsvghrtghonhhtvghnthdrtghomhdpmhhkshgvvggurd
    hshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegs
    ohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:0mFDYnW9tmmUbB82Hbm_LRbuqZT_an83ThfAnpaW0zcPdoqq9NVbcg>
    <xmx:0mFDYimNJYssXBfhLZNHr-zLUShw7jrl9F0WRv0OSA0Og_t67jgMGw>
    <xmx:0mFDYseMgiwinuq9SnRlyyeelDi1tKupcAeoBDXQtYhiquqGfq3j-g>
    <xmx:02FDYny2O92yfyfQ1Xix5zHUmWaKIStBPJ63__Mw2K2F0UbZIiPK_Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Mar 2022 15:45:22 -0400 (EDT)
Date:   Tue, 29 Mar 2022 12:45:21 -0700
From:   Boris Burkov <boris@bur.io>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
Message-ID: <YkNh0X7wx8uk5aat@zen>
References: <16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io>
 <20220323005215.22qkdgherdyrocuq@naota-xeon>
 <YjtkE6DkhV0V0gXq@zen>
 <9770fbd0-e122-6892-4149-45bb6f988961@oracle.com>
 <20220329043320.bak6zyigz2g5facj@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329043320.bak6zyigz2g5facj@naota-xeon>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 29, 2022 at 04:33:21AM +0000, Naohiro Aota wrote:
> On Mon, Mar 28, 2022 at 07:11:39PM +0800, Anand Jain wrote:
> > On 24/03/2022 02:16, Boris Burkov wrote:
> > > On Wed, Mar 23, 2022 at 12:52:15AM +0000, Naohiro Aota wrote:
> > > > On Mon, Mar 21, 2022 at 04:56:17PM -0700, Boris Burkov wrote:
> > > > > If you follow the seed/sprout wiki, it suggests the following workflow:
> > > > > 
> > > > > btrfstune -S 1 seed_dev > > mount seed_dev mnt
> > > > > btrfs device add sprout_dev
> > > > > mount -o remount,rw mnt
> > > > > 
> > > > > The first mount mounts the FS readonly, which results in not setting
> > > > > BTRFS_FS_OPEN, and setting the readonly bit on the sb. The device add
> > > > > somewhat surprisingly clears the readonly bit on the sb (though the
> > > > > mount is still practically readonly, from the users perspective...).
> > > > > Finally, the remount checks the readonly bit on the sb against the flag
> > > > > and sees no change, so it does not run the code intended to run on
> > > > > ro->rw transitions, leaving BTRFS_FS_OPEN unset.
> > > > > 
> > > > > As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN and
> > > > > does no work. This results in leaking deleted snapshots until we run out
> > > > > of space.
> > > > > 
> > > > > I propose fixing it at the first departure from what feels reasonable:
> > > > > when we clear the readonly bit on the sb during device add. I have a
> > > > > reproducer of the issue here:
> > > > > https://raw.githubusercontent.com/boryas/scripts/main/sh/seed/mkseed.sh
> > > > > and confirm that this patch fixes it, and seems to work OK, otherwise. I
> > > > > will admit that I couldn't dig up the original rationale for clearing
> > > > > the bit here (it dates back to the original seed/sprout commit without
> > > > > explicit explanation) so it's hard to imagine all the ramifications of
> > > > > the change.
> > > > > 
> > > > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > > > ---
> > > > >   fs/btrfs/volumes.c | 4 ----
> > > > >   1 file changed, 4 deletions(-)
> > > > > 
> > > > > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > > > > index 3fd17e87815a..75d7eeb26fe6 100644
> > > > > --- a/fs/btrfs/volumes.c
> > > > > +++ b/fs/btrfs/volumes.c
> > > > > @@ -2675,8 +2675,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
> > > > >   	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
> > > > >   	if (seeding_dev) {
> > > > > -		btrfs_clear_sb_rdonly(sb);
> > > > > -
> > > > 
> > > > After this line, it updates the metadata e.g, with
> > > > init_first_rw_device() and writes them out with
> > > > btrfs_commit_transaction(). Is that OK to do so with the SB_RDONLY
> > > > flag set?
> > > 
> > 
> > It is ok as the device-add step creates a _new_ sprout filesystem which is
> > RW-able. btrfs_setup_sprout() resets the seeding flag.
> > 
> >  super_flags = btrfs_super_flags(disk_super) &
> >  ~BTRFS_SUPER_FLAG_SEEDING;
> >  btrfs_set_super_flags(disk_super, super_flags);
> > 
> > Thanks, Anand
> 
> Yeah, I see that point. I'm concerned about an interaction with the
> VFS code. With this patch applied, it is going to do file-system
> internal writes (updating the trees and transaction commit) with the
> SB_RDONLY flag set. Doesn't it break the current and future assumptions
> of the VFS side?
> 
> But, it's just a concern. It might not be a bid deal.

I discussed this with Chris and he pointed out an existing case:
log-replay. Log replay runs in mount before the sb_rdonly check and
checks rw_devices, but not the fs readonly bit. It uses transactions and
such to replay the log. This seems similar enough here: the device is rw,
but the fs is ro.

> 
> > > Good question. As far as I can tell, the functions don't explicitly
> > > check sb_rdonly, though that could be because they expect that to be
> > > checked before you ever try to commit a transaction, for example..
> > > 
> > > If there is an issue, it's probably somewhat subtle, because the basic
> > > behavior does work.
> > > 
> > > > 
> > > > >   		/* GFP_KERNEL allocation must not be under device_list_mutex */
> > > > >   		seed_devices = btrfs_init_sprout(fs_info);
> > > > >   		if (IS_ERR(seed_devices)) {
> > > > > @@ -2819,8 +2817,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
> > > > >   	mutex_unlock(&fs_info->chunk_mutex);
> > > > >   	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
> > > > >   error_trans:
> > > > > -	if (seeding_dev)
> > > > > -		btrfs_set_sb_rdonly(sb);
> > > > >   	if (trans)
> > > > >   		btrfs_end_transaction(trans);
> > > > >   error_free_zone:
> > > > > -- 
> > > > > 2.30.2
> > > > > 
> > 
