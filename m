Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D623E4289
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 11:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhHIJW3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 05:22:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43224 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbhHIJW2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Aug 2021 05:22:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 199B91FFF2;
        Mon,  9 Aug 2021 09:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628500928;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f7UrMD0BUYQKSzsWJR2vZBnLPd9JUCcm/vCen5qN4Oo=;
        b=tXZWa758mxEwx1Czm6SA+xtH6jKeBW9vECdWFUyBKoakkxGAFu5HWM72R9nrdz+A0Ib/fm
        +oWItiPSizO6iGLMhf7vrcslAcWDEFGb9Hux6IZRwqHJTMnAnO/Kzkqz4pQgE8te248wL1
        /QI9KTJQq15pDqm02/ZNWIsS1OGL+FM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628500928;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f7UrMD0BUYQKSzsWJR2vZBnLPd9JUCcm/vCen5qN4Oo=;
        b=J9Z6q0lrO8ZikVUmXz9s05hHu45ruAxy+ISkg1PcJtqyONuEgZqzXE7aCj/JlZutPySrl9
        pZysdSg0KZ6Rs/DA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DBF09A3B8B;
        Mon,  9 Aug 2021 09:22:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 54881DA880; Mon,  9 Aug 2021 11:19:16 +0200 (CEST)
Date:   Mon, 9 Aug 2021 11:19:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, johannes.thumshirn@wdc.com,
        damien.lemoal@wdc.com, naohiro.aota@wdc.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: advertise zoned support among features
Message-ID: <20210809091916.GJ5047@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, johannes.thumshirn@wdc.com,
        damien.lemoal@wdc.com, naohiro.aota@wdc.com,
        linux-btrfs@vger.kernel.org
References: <20210728165632.11813-1-dsterba@suse.com>
 <5d40cac5-2048-6a9b-292b-52046a1793cd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d40cac5-2048-6a9b-292b-52046a1793cd@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 05, 2021 at 08:13:03AM +0800, Anand Jain wrote:
> On 29/07/2021 00:56, David Sterba wrote:
> > We've hidden the zoned support in sysfs under debug config for the first
> > releases but now the stability is reasonable, though not all features
> > have been implemented.
> > 
> > As this depends on a config option, the per-filesystem feature won't
> > exist as such filesystem can't be mounted. The static feature will print
> > 1 when the support is built-in, 0 otherwise.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> > 
> > The merge target is not set, depends if everybody thinks it's the time
> > even though there are still known bugs. We're also waiting for
> > util-linux support (blkid, wipefs), so that needs to be synced too.
> > 
> >   fs/btrfs/sysfs.c | 12 +++++++++---
> >   1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> > index bfe5e27617b0..7ad8f802ab88 100644
> > --- a/fs/btrfs/sysfs.c
> > +++ b/fs/btrfs/sysfs.c
> > @@ -263,8 +263,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
> >   BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
> >   BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
> >   BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
> > -/* Remove once support for zoned allocation is feature complete */
> > -#ifdef CONFIG_BTRFS_DEBUG
> > +#ifdef CONFIG_BLK_DEV_ZONED
> >   BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
> >   #endif
> >   #ifdef CONFIG_FS_VERITY
> > @@ -285,7 +284,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
> >   	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
> >   	BTRFS_FEAT_ATTR_PTR(free_space_tree),
> >   	BTRFS_FEAT_ATTR_PTR(raid1c34),
> > -#ifdef CONFIG_BTRFS_DEBUG
> > +#ifdef CONFIG_BLK_DEV_ZONED
> >   	BTRFS_FEAT_ATTR_PTR(zoned),
> >   #endif
> >   #ifdef CONFIG_FS_VERITY
> 
> 
>   Looks good until here.
> 
> 
> > @@ -384,12 +383,19 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
> >   BTRFS_ATTR(static_feature, supported_sectorsizes,
> >   	   supported_sectorsizes_show);
> >   
> > +static ssize_t zoned_show(struct kobject *kobj, struct kobj_attribute *a, char *buf)
> > +{
> > +	return scnprintf(buf, PAGE_SIZE, "%d\n", IS_ENABLED(CONFIG_BLK_DEV_ZONED));
> > +}
> > +BTRFS_ATTR(static_feature, zoned, zoned_show);
> > +
> >   static struct attribute *btrfs_supported_static_feature_attrs[] = {
> >   	BTRFS_ATTR_PTR(static_feature, rmdir_subvol),
> >   	BTRFS_ATTR_PTR(static_feature, supported_checksums),
> >   	BTRFS_ATTR_PTR(static_feature, send_stream_version),
> >   	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),
> >   	BTRFS_ATTR_PTR(static_feature, supported_sectorsizes),
> > +	BTRFS_ATTR_PTR(static_feature, zoned),
> >   	NULL
> >   };
> 
>   We don't need this part. btrfs_supported_feature_attrs will
>   take care of showing zoned if when enabled on the mounted btrfs.

The idea is to put zoned also to the static features so the zoned
support can be determined before mount.

> 
>   As of now, this patch fails with
>      [ 44.464597] sysfs: cannot create duplicate filename 
> '/fs/btrfs/features/zoned'

I'll have a look.
