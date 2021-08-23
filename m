Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B103F4E13
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 18:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhHWQOh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 12:14:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42172 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHWQOh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 12:14:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DA0301FFCE;
        Mon, 23 Aug 2021 16:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629735233;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPHsXOwW/dztGkfBvxT23L3MDIME5WeJBaqCXakrjn8=;
        b=lBxxb/GMTrSxDaqWs6Knv82OzNUCGqV2cmDvr9jL1r55x5BB/Rytgxn3Ib21fKmJ5k2dxS
        8yEpbMvl1UXf1LDSV7qU6vabD4ttVppvIlD+/2a0qX0tlOJBCC7RWo8vyzEivlUDtd2iP7
        EalCtOGJe6wbyxcRtUbgy1rVbBmJZQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629735233;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPHsXOwW/dztGkfBvxT23L3MDIME5WeJBaqCXakrjn8=;
        b=cLpoBdcdeEO81cIg9lBAzjoDOiFLw/7z/cMI0k5h1h2C6DPO+3nBan2TigqZjVdVD80Iaf
        yYqJ8TTRQv4c3FAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D249CA3BC5;
        Mon, 23 Aug 2021 16:13:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2C0EBDA725; Mon, 23 Aug 2021 18:10:53 +0200 (CEST)
Date:   Mon, 23 Aug 2021 18:10:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/9] btrfs-progs: use an associative array for init mkfs
 blocks
Message-ID: <20210823161053.GE5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629486429.git.josef@toxicpanda.com>
 <9e4cd53b74631be7c4bf78653de2d931d53dce3c.1629486429.git.josef@toxicpanda.com>
 <ffdac968-e865-2435-484d-9ebd763603e5@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffdac968-e865-2435-484d-9ebd763603e5@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 23, 2021 at 04:42:24PM +0800, Qu Wenruo wrote:
> On 2021/8/21 上午3:11, Josef Bacik wrote:
> > Extent tree v2 will not create an extent tree or csum tree initially,
> > and it will create a block group tree.  To handle this we want to rework
> > the initial mkfs step to take an array of the blocks we want to create
> > and use the array to keep track of which blocks we need to create.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >   mkfs/common.c | 56 ++++++++++++++++++++++++++++++++-------------------
> >   mkfs/common.h | 10 +++++++++
> >   2 files changed, 45 insertions(+), 21 deletions(-)
> >
> > diff --git a/mkfs/common.c b/mkfs/common.c
> > index 2c041224..e9ff529a 100644
> > --- a/mkfs/common.c
> > +++ b/mkfs/common.c
> > @@ -31,16 +31,18 @@
> >   #include "mkfs/common.h"
> >
> >   static u64 reference_root_table[] = {
> > -	[1] =	BTRFS_ROOT_TREE_OBJECTID,
> > -	[2] =	BTRFS_EXTENT_TREE_OBJECTID,
> > -	[3] =	BTRFS_CHUNK_TREE_OBJECTID,
> > -	[4] =	BTRFS_DEV_TREE_OBJECTID,
> > -	[5] =	BTRFS_FS_TREE_OBJECTID,
> > -	[6] =	BTRFS_CSUM_TREE_OBJECTID,
> > +	[MKFS_ROOT_TREE]	=	BTRFS_ROOT_TREE_OBJECTID,
> > +	[MKFS_EXTENT_TREE]	=	BTRFS_EXTENT_TREE_OBJECTID,
> > +	[MKFS_CHUNK_TREE]	=	BTRFS_CHUNK_TREE_OBJECTID,
> > +	[MKFS_DEV_TREE]		=	BTRFS_DEV_TREE_OBJECTID,
> > +	[MKFS_FS_TREE]		=	BTRFS_FS_TREE_OBJECTID,
> > +	[MKFS_CSUM_TREE]	=	BTRFS_CSUM_TREE_OBJECTID,
> >   };
> 
> Can we use a bitmap for these combinations?
> 
> So that we just need one parameter to indicate what trees we want.

The array can also define order, in followup patches there the free
space tree added to the end.
