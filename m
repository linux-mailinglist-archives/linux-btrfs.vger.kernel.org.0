Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27916264A3A
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgIJQsU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 12:48:20 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35909 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726780AbgIJQsB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 12:48:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C555C5C00AF;
        Thu, 10 Sep 2020 12:47:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 10 Sep 2020 12:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ZK7ry3iul1EQk6J3xX5sZDgJHXW
        EaLoTzrX4Bl2mhGY=; b=G8NgGzgSh18ZfPh+Gm/aH39iJDG8pyrfXglPWfgPzaU
        v3sBv6r1NU112/Y7WpNU25javPaVl6sPkqI+3sWFyk9A+74t6s501u0sOr+oj6NI
        UQcZoJAApkRNSZwcgRCL3ek4HJfK2f1anBgiDLWk6eCJbu+w2cvgjejO5Q9hoYtf
        2FwTfFD2an64fwO6u1EPmZ2bVF8tCKzTraS12QCIipkaqsiiSxGoULjGypuNq4LU
        BZJJpxLQklymJI7M78ac/IHNZfe3UwHsm++QfoE2Wztmm2snmFwoZIfq9Q1k68rx
        Cl/PVneYmGS6UPA00ceZ3yWpNAEKKm0YPZH7CwybZ4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ZK7ry3
        iul1EQk6J3xX5sZDgJHXWEaLoTzrX4Bl2mhGY=; b=GjH6v9w2cmFNtmvQi8WlnD
        RmrGW0McJVVGYNsQMC2HBTT69K5h/h2ZahDrp+MNzk9QniieKQkFq269h1tMxupM
        a3o3fdHvPF+SdR5xV5sYEYju97QPorUADzXKmeWGcEAVYmpcUHMydRK9UrLaPy8a
        Pv77MwbojVuPoBWM9NsJm72V7GnqD6LXB+c+9WQotKQZf1vU1HG0cIKfju/XVeHC
        sYzi5p7MLsc8yX5oG38JGTDsZNpcdvKU9m55VyDJHR/Y0IODadDbCXRQNMFSV78m
        +1KuEtGzzgy17CdiYJ48j+TcuuqmZDuR4LwgT9E6R/d7uOvcdC/kr+QZ836c7z/Q
        ==
X-ME-Sender: <xms:s1haXzxXyTWlcZYBbusNMgdMSqxqC51MwDYIxQzGZ-y_da8dxsO74g>
    <xme:s1haX7QoYIZRa4IYPKiMtZa0X8CHulJh6tGUtBMBao8bq4e8_ziI0kpAVxcW-C_zq
    erPifgMxbN74jGkRpY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    eugefhvdffgedvuefgffeufeegkedtuefhtddtveevgfekleelkeeiueekleelteenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeduieefrdduudegrddufedvrdefne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhi
    shessghurhdrihho
X-ME-Proxy: <xmx:s1haX9Vk0zBoJ95dogFtj1nJefZY4NTj8Bx-eCQJhuWJekeuAaFRlg>
    <xmx:s1haX9i42KUbul2kMiBdTnTbKrn25Q43PLoNGH5CPlX7opO9zzeX9A>
    <xmx:s1haX1CIvEYHlSixyKYBueFEY4qh1EiEfi1YvDr_BgIry9l59yJQkw>
    <xmx:s1haX4NPUldDd1IE8xy4hdKuwSQNH6kF18W8ko7eMXQGJIiRGhb-lQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9830B3280060;
        Thu, 10 Sep 2020 12:47:46 -0400 (EDT)
Date:   Thu, 10 Sep 2020 09:47:43 -0700
From:   Boris Burkov <boris@bur.io>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Dave Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/3] btrfs: support remount of ro fs with free space
 tree
Message-ID: <20200910164743.GA2455655@devvm842.ftw2.facebook.com>
References: <cover.1599686801.git.boris@bur.io>
 <9bca6fcf34bffc73c42323c9f79f5c1a9e6ef131.1599686801.git.boris@bur.io>
 <812d62a6-3afc-b30b-e15e-f9cc58ba2aa8@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <812d62a6-3afc-b30b-e15e-f9cc58ba2aa8@toxicpanda.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 10, 2020 at 10:05:40AM -0400, Josef Bacik wrote:
> On 9/9/20 5:45 PM, Boris Burkov wrote:
> >When a user attempts to remount a btrfs filesystem with
> >'mount -o remount,space_cache=v2', that operation succeeds.
> >Unfortunately, this is misleading, because the remount does not create
> >the free space tree. /proc/mounts will incorrectly show space_cache=v2,
> >but on the next mount, the file system will revert to the old
> >space_cache.
> >
> >For now, we handle only the easier case, where the existing mount is
> >read only. In that case, we can create the free space tree without
> >contending with the block groups changing as we go. If it is not read
> >only, we fail more explicitly so the user knows that the remount was not
> >successful, and we don't end up in a state where /proc/mounts is giving
> >misleading information. We also fail if the remount is read-only, since
> >we would not be able to create the free space tree in that case.
> >
> >References: https://github.com/btrfs/btrfs-todo/issues/5
> >Signed-off-by: Boris Burkov <boris@bur.io>
> >---
> >v2:
> >- move creation down to ro->rw case
> >- error on all other remount cases
> >- add a comment to help future remount modifiers
> >
> >  fs/btrfs/super.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> >diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> >index 3ebe7240c63d..0a1b5f554c27 100644
> >--- a/fs/btrfs/super.c
> >+++ b/fs/btrfs/super.c
> >@@ -47,6 +47,7 @@
> >  #include "tests/btrfs-tests.h"
> >  #include "block-group.h"
> >  #include "discard.h"
> >+#include "free-space-tree.h"
> >  #include "qgroup.h"
> >  #define CREATE_TRACE_POINTS
> >@@ -1838,6 +1839,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
> >  	u64 old_max_inline = fs_info->max_inline;
> >  	u32 old_thread_pool_size = fs_info->thread_pool_size;
> >  	u32 old_metadata_ratio = fs_info->metadata_ratio;
> >+	bool create_fst = false;
> >  	int ret;
> >  	sync_filesystem(sb);
> >@@ -1862,6 +1864,17 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
> >  	btrfs_resize_thread_pool(fs_info,
> >  		fs_info->thread_pool_size, old_thread_pool_size);
> >+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) &&
> >+	    !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
> >+		create_fst = true;
> >+		if(!sb_rdonly(sb) || *flags & SB_RDONLY) {
> >+			btrfs_warn(fs_info,
> >+				   "Remounting with free space tree only allowed from read-only to read-write");
> >+			ret = -EINVAL;
> >+			goto restore;
> >+		}
> >+	}
> 
> This will bite us if we remount -o ro,noatime but had previous
> mounted with -o ro,space_cache=v2.  These checks need to be under
> 

I wanted this case to fail because I was thinking of this patch as
creating the invariant: "if remount -o space_cache=v2 succeeds, we
actually created the free space tree". However, that behavior is
inconsistent with the fact that 'mount -o ro,space_cache=v2' does
succeed while failing to create the tree.

I guess my question is would we rather have a ro mount that tries to
create the free space tree fail silently or noisily in both cases?

If we want to allow them to silently fail, I will also send a patch to
change the mount option reporting logic.

Thanks for the review!

> >+
> >  	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
> >  		goto out;
> 
> This part right here.  Put the check for remounting RO with
> space_cache=v2 in that part, and the check if we need to create the
> fst at all down where you create it.  Thanks,
> 
> Josef
