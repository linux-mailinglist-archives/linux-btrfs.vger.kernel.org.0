Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFB625CE67
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 01:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgICXe0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 19:34:26 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:53223 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729306AbgICXeY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Sep 2020 19:34:24 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1A9C6872;
        Thu,  3 Sep 2020 19:34:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 19:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ATPi494MZGRrHWITOJQ9+HkH4nx
        4DpMkTFwxzTGVf6E=; b=MMc5kvrx4WZPsv6Cb2HwG2PtRTE9g4EaJOFloo7ZVRg
        zzpIi9cOQybDHaQHR96DJDVi8aucHc4PoWCRmy3YK3Oc07fWQM1pd39aQU+5ujJT
        lLKQtVTq7S4QQamy0NgGDjidq7j4lAeQGTlLtIV+BIr/xRDp4BXrYXTW0/jjr1NQ
        3o1cq9QRTwXE+x20U6PF+dnLOTzRiHSa0uAKHSKHyh+9Ersm/dKXBLqIv9UuEKfd
        ObJasJ33VXBJv0w+AmfmF5HWBypu1BvCd+b/qrPMbA1Ae67P89kKGvx3E33+cG92
        rV73GkYsVr45ipvFSuZcwVJN2dhxf/rUFI2GalllFsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ATPi49
        4MZGRrHWITOJQ9+HkH4nx4DpMkTFwxzTGVf6E=; b=NQxhi8tF8PP1Qk/hav7DL0
        Lv53J4h1DkZtVpweIbd7hwmbS702UE+XDz4L4I+fEiQfyGkI8lKcJxPJ49mCujH/
        lkaKSVSfWd5TYLPRWtO6k8N0omqC/EgXTrqSJf4GPqHYqBGdegPCQ+iqpKDYD2l+
        cKjZS4MetBl5qMDlqjO+Nfl6hPjtBOz9PbHWl8XYhMLOypyZZgOUfNH7FkLQZTgv
        JegMux8xompfxLv79SIjF8Ei74KiHl6sFcceeOqP8mmLML8A0pgbQO5Vmb0k+uAo
        qyaRTmyXduWfwNI8Z2+dDYwz6TDDeJkswwFFO4hcuwXfA0xzoDILWNjFCes7JvSQ
        ==
X-ME-Sender: <xms:fn1RX7fij7SQwrimW6oaza3e8ljlhghbQz5Fc-ANjX5nwijIGhWRKg>
    <xme:fn1RXxMOniHvdn1tSAxJ7bcB67zAkMpvzbDKDz9nMiyBxlBPkVVTLVi-S0WPrGRCm
    G1PDvjZBW60zX5BD3I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegvddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    eugefhvdffgedvuefgffeufeegkedtuefhtddtveevgfekleelkeeiueekleelteenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeduieefrdduudegrddufedvrdefne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhi
    shessghurhdrihho
X-ME-Proxy: <xmx:fn1RX0ho1bvI91nhZ1-OKlRCbmzJJr8OyGoDWiZ0UfYRbbt74GGsuA>
    <xmx:fn1RX8-C0YwxVfs7sukzEjS7Wi24yAgqZedppIHCR78TmTPTiKpKeA>
    <xmx:fn1RX3tw0oU9Mui5my9NBPAFJX5pP4JjgQ_Wvk94nlr7qn2R_rJy0w>
    <xmx:fn1RXw7yjldtTs5d76agL6fJzIRYx1f3dvZPqYiN2zPzgMEcuBU2ag>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 01E393060060;
        Thu,  3 Sep 2020 19:34:22 -0400 (EDT)
Date:   Thu, 3 Sep 2020 16:34:18 -0700
From:   Boris Burkov <boris@bur.io>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Dave Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: support remount of ro fs with free space tree
Message-ID: <20200903233418.GB486887@devvm842.ftw2.facebook.com>
References: <cover.1599164377.git.boris@bur.io>
 <dea5fb2c9131b0b1c274f011596e5798fdc1971d.1599164377.git.boris@bur.io>
 <d21b0694-2ff6-dba0-2c93-ceaef0c0bed8@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d21b0694-2ff6-dba0-2c93-ceaef0c0bed8@toxicpanda.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 03, 2020 at 05:40:39PM -0400, Josef Bacik wrote:
> On 9/3/20 4:33 PM, Boris Burkov wrote:
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
> >misleading information.
> >
> >References: https://github.com/btrfs/btrfs-todo/issues/5
> >Signed-off-by: Boris Burkov <boris@bur.io>
> >---
> >  fs/btrfs/super.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> >diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> >index 3ebe7240c63d..cbb2cdb0b488 100644
> >--- a/fs/btrfs/super.c
> >+++ b/fs/btrfs/super.c
> >@@ -47,6 +47,7 @@
> >  #include "tests/btrfs-tests.h"
> >  #include "block-group.h"
> >  #include "discard.h"
> >+#include "free-space-tree.h"
> >  #include "qgroup.h"
> >  #define CREATE_TRACE_POINTS
> >@@ -1862,6 +1863,22 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
> >  	btrfs_resize_thread_pool(fs_info,
> >  		fs_info->thread_pool_size, old_thread_pool_size);
> >+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) &&
> >+	    !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
> >+		if (!sb_rdonly(sb)) {
> >+			btrfs_warn(fs_info, "cannot create free space tree on writeable mount");
> >+			ret = -EINVAL;
> >+			goto restore;
> >+		}
> >+		btrfs_info(fs_info, "creating free space tree");
> >+		ret = btrfs_create_free_space_tree(fs_info);
> >+		if (ret) {
> >+			btrfs_warn(fs_info,
> >+				   "failed to create free space tree: %d", ret);
> >+			goto restore;
> >+		}
> >+	}
> >+
> 
> This whole chunk actually needs to be moved down into the
> 
> } else {
> 	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
> 
> bit, and after all the checks to make sure it's ok to flip RW, but
> _before_ we do btrfs_cleanup_roots.
> 
> Also put a comment there saying something like
> 
> /*
>  * Don't do anything that writes above this, otherwise bad things will happen.
>  */
> 
> So that nobody accidentally messes this up in the future.  Thanks,
> 
> Josef

This makes sense, since we need to be able to write to create the tree.
My mistake. With that said, do you think I should keep the logic that
makes remount explicitly fail when -o space_cache=v2 won't actually be
honored?

e.g.:
- fs is rw
- fs is ro, remount is ro

I think that loudly failing in these cases makes the user experience
quite a bit better, but it's not as simple as just throwing the create
code in the appropriate block for the ro->rw transition case.

Thanks for the review,
Boris
