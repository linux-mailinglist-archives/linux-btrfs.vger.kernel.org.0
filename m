Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790E44E5858
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 19:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245636AbiCWS1X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 14:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiCWS1X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 14:27:23 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AEA7892F
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 11:25:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7F8073201F56;
        Wed, 23 Mar 2022 14:25:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 23 Mar 2022 14:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=YCbOodtatNmMjlPmrl5AiZneuiTfDJH7BW44jd
        ppaYM=; b=qAs9SWmJSWpnP0eLyPivMrE28g9lCRnpqkawmzfKjRKmFMoEa923PY
        YGpXPi9QkK5G1ALLCECBEbME072xLK0LwsBl7g3g6vaMlmi8me6i/q21V7YoDZj3
        4kjWKUx5WX9QcnynkEzSK4PzLI2Yf4eWBdfxi1UxhW7BKubRd9QSOloohCSWTk1/
        rE4cCUX93ueG0ZVtbWeC4pEulbJeu9cgjRLkd0Y3tu/lXEdO2z8nFa1haX33gR7C
        pqWX+Ld9pPXHXawOUzlz+2E0lwLbmnUS1IO04HR16NCYgtTfuI2TRWkQ8orX0uVV
        u9bu0UeCVwMQTY9f6mU3IEopjrsfqonA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=YCbOodtatNmMjlPmr
        l5AiZneuiTfDJH7BW44jdppaYM=; b=YYfDlddGDBIvCP+t3iEFo1/ixAdB3s0bB
        eIb/uDwVaxMkHWISd0aWATP6FI/PeSacuflZcIUrb+XPMZxOzaue8Q2uQjUYVKqo
        6KWzsgRPR03QpuGsmhrngPm3w3dMHDohwPw1KeST6hlvLY0/fivOx6BNWMN7Jwhd
        W/hntd70mPptS8sL/smVdyPNltsA3QwYKbTPtrbzaGbUm5QYCro3heFX0CdDKmxw
        FAKW1K5bgBkY1/KyBFzAEy9MeJx5oQwPNTQ94LELYZJi6te6U5jcypU8z8sry16c
        /4d4RHcxPJq1/dt7am+5yZn3mjMtalafp1k3dyqZbM8zWnnitD7tw==
X-ME-Sender: <xms:L2Y7YuMlh3ULCdO92Y2NP7trcpPgf5ZUKx2MqJVfT7zp5oN8mHTGQw>
    <xme:L2Y7Ys8vz4Wd9GXrtzHGsUKk99An9c-X5xnunjj0Vgc4Z4wFkzpsCNSV1jctXkv4p
    9H_VIUo6_GIXGZTP_A>
X-ME-Received: <xmr:L2Y7YlStX6oADIcjP6eqVWAt1uW0muprOVGcOyI6alY1wPt985qLBBSOJWjF-gzCHNFCZdBLmA76MKj-1LDZPunsNQPrVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegjedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    eikeeuhffgtdegudfffffhtdfhtdeutefhhfetledvfedtvefhtdfhhefgjeejieenucff
    ohhmrghinhepghhithhhuhgsuhhsvghrtghonhhtvghnthdrtghomhdpmhhkshgvvggurd
    hshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegs
    ohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:MGY7YuuwyWYVPtcFw374GgYVYl8O7cDLnA5999DGxu_AkTfwpiauJw>
    <xmx:MGY7Ymc6uxdjmfw93EU_LMOP_yYUCY7lzjpr2Q9W99KFFGA_LD9U-g>
    <xmx:MGY7Yi0EC_s0tQBBuovGinIEibQFkSuBWJcpwu0np0CiX_dFyHYdKg>
    <xmx:MGY7YqHOLye96LUWhBdlVGfoKBsqvbCGpVp76Iv1HjyZE82azAs6ww>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Mar 2022 14:25:51 -0400 (EDT)
Date:   Wed, 23 Mar 2022 11:25:50 -0700
From:   Boris Burkov <boris@bur.io>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
Message-ID: <YjtmLqBGlqaQXf2u@zen>
References: <16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io>
 <b4ff2316-fca8-2f04-bf0a-d7747118b768@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4ff2316-fca8-2f04-bf0a-d7747118b768@oracle.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 23, 2022 at 06:44:42PM +0800, Anand Jain wrote:
> On 22/03/2022 07:56, Boris Burkov wrote:
> > If you follow the seed/sprout wiki, it suggests the following workflow:
> > 
> > btrfstune -S 1 seed_dev
> > mount seed_dev mnt
> > btrfs device add sprout_dev
> 
> > mount -o remount,rw mnt
> or
>  umount mnt
>  mount sprout mnt

Agreed. FWIW, I tested that umount/mount is not vulnerable to the bug.
However, a user might be using one of the documented workflows anyway,
and would need it for an fs they add a sprout to while it is in use.

> 
> > The first mount mounts the FS readonly, which results in not setting
> > BTRFS_FS_OPEN, and setting the readonly bit on the sb.
> 
>  Why not set the BTRFS_FS_OPEN?
> 

One reason is that there is other logic that runs when transitioning
from ro->rw in remount besides just setting BTRFS_FS_OPEN. By not
improperly clearing ro, we let that logic do its thing naturally.

> @@ -3904,8 +3904,11 @@ int __cold open_ctree(struct super_block *sb, struct
> btrfs_fs_devices *fs_device
>                 goto fail_qgroup;
>         }
> 
> -       if (sb_rdonly(sb))
> +       if (sb_rdonly(sb)) {
> +               btrfs_set_sb_rdonly(sb);
> +               set_bit(BTRFS_FS_OPEN, &fs_info->flags);
>                 goto clear_oneshot;
> +       }
> 
>         ret = btrfs_start_pre_rw_mount(fs_info);
>         if (ret) {
> 
> > The device add
> > somewhat surprisingly clears the readonly bit on the sb (though the
> > mount is still practically readonly, from the users perspective...).
> > Finally, the remount checks the readonly bit on the sb against the flag
> > and sees no change, so it does not run the code intended to run on
> > ro->rw transitions, leaving BTRFS_FS_OPEN unset.
> 
>  Originally, the step 'btrfs device add sprout_dev' provided seed
>  fs writeable without a remount.

That is very interesting. Do you remember why we changed this behavior
to the current behavior of leaving the seed readonly until the
remount/mount cycle?

> 
>  I think the btrfs_clear_sb_rdonly(sb) in btrfs_init_new_device()
>  was part of it.
> 
>  Removing it doesn't seem to affect the seed-sprout functionality
>  (did I miss anything?) either the -o remount,rw
>  or mount recycle will get it writeable.

My current understanding (probably flawed..):
before this patch: we clear the rdonly bit, but the fs is still readonly
until remount (should figure out exactly how)
after this patch: behavior is the same, except the rdonly bit gets
cleared along with the mounting, not the device add.

> 
> > As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN and
> > does no work. This results in leaking deleted snapshots until we run out
> > of space.
> 
> 
> > I propose fixing it at the first departure from what feels reasonable:
> > when we clear the readonly bit on the sb during device add. I have a
> > reproducer of the issue here:
> > https://raw.githubusercontent.com/boryas/scripts/main/sh/seed/mkseed.sh
> > and confirm that this patch fixes it, and seems to work OK, otherwise. I
> > will admit that I couldn't dig up the original rationale for clearing
> > the bit here (it dates back to the original seed/sprout commit without
> > explicit explanation) so it's hard to imagine all the ramifications of
> > the change.
> 
>  We got fstests -g seed to test the seed-sprout stuff. Your test case
>  here fits in it. IMO.

Thanks for the tip, I'll add it there, regardless of how we fix it.

> 
> Thanks, Anand
> 
> 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >   fs/btrfs/volumes.c | 4 ----
> >   1 file changed, 4 deletions(-)
> > 
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 3fd17e87815a..75d7eeb26fe6 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -2675,8 +2675,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
> >   	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
> >   	if (seeding_dev) {
> > -		btrfs_clear_sb_rdonly(sb);
> > -
> >   		/* GFP_KERNEL allocation must not be under device_list_mutex */
> >   		seed_devices = btrfs_init_sprout(fs_info);
> >   		if (IS_ERR(seed_devices)) {
> > @@ -2819,8 +2817,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
> >   	mutex_unlock(&fs_info->chunk_mutex);
> >   	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
> >   error_trans:
> > -	if (seeding_dev)
> > -		btrfs_set_sb_rdonly(sb);
> >   	if (trans)
> >   		btrfs_end_transaction(trans);
> >   error_free_zone:
> 
