Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D9974B7D5
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 22:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjGGU2C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 16:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjGGU1y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 16:27:54 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA284128
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 13:27:52 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 311FA5C0003;
        Fri,  7 Jul 2023 16:27:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 Jul 2023 16:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1688761672; x=1688848072; bh=2N
        jvoshZ7w5zJpLmm50AAQ1YCgtyq9ENC6STAP7RvsA=; b=GoU4Z+HuJTcoYFiUZu
        Cj2ZXXDFTyKt4mmG6GIub0+8jY65C/l6BtC3JKIK5aRvE95S4y2ctL0oB9JlKO3x
        u2rKpf148nIVj9JOSIkDMZ8fX6lZClBfgLGbDq2MWENdDwFaIZxwFpTTqyhm+GUX
        Ax2CyfAns+w50Ik8cWW+Umu7zCj5gXdjEHD1iaCwq2xIVCGkPxLcAHPAGTHacAw0
        7aKGID5Znpc2po+8mTr8vanMR+2b1tmyz/g5OGptoiDmpcY+Wzgp2mqzEVU8mP4W
        wF6B5lA7wUyvxMdxILezP99zR3zZSamQqp8tDfFUBZ47FRhwCESg8Vm9R0km34O4
        14Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688761672; x=1688848072; bh=2NjvoshZ7w5zJ
        pLmm50AAQ1YCgtyq9ENC6STAP7RvsA=; b=NF/tie8gwnzmI8yDFuBUVwq8GJSVi
        BSHh6rBCA+EOboty5Di3k6BeRhc95QCUsBEn3joS4TVrbWuiOeg6WQRcnQgrFOvo
        B792PcMiaM3pLzc9TVYk1M2U+jkpKOBnlQATIh7029uINszAVJlJbhKIcBDlz95h
        D6jXqngeceI0/27gv0PXBgq3WffjwqoYUd5XEAceYorq4DtcwMbBD2PYqFYtnpPs
        UPNjrXhDADucmZBjWppxE+7GmPtxFKO5kMuxLvSWW546BvrKFF9YvBJPcCSbhll1
        D8JvWlwabaiGXIp4Qdw3VL6xqIDN/wikpVylo50qIEBb+a1YWgXubLcFQ==
X-ME-Sender: <xms:R3WoZIP1PDgRuMpZBHI2weDIzWW9VLosN15vkRFkDfUX3lBgbZrFkQ>
    <xme:R3WoZO9WQu2ShUL0Fh5TyNeOXW40_mWrnqMv2BMyUzvKcNx_YWUV4qIiLqtDDFhmO
    wm3MyGfZCC274EQ2vI>
X-ME-Received: <xmr:R3WoZPQVDv32KG2NlLhjhpoOG5CJoYc9A3YlKRCQ64P9Mij06c5QAPEHJ1ONHSlaxzPzHYMSfLHwaKeeMRg2VzJfk_M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddugddugeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepuefgfeetffefgfduvedvvedtfffgudefgfeuff
    ejffehheduueeiudetkeegffehnecuffhomhgrihhnpehqvghmuhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:SHWoZAv9i4BuklfkRXIMVBkQNDGfer6ggPUEY66Qb9AppdIrr1KCKg>
    <xmx:SHWoZAdkWo3p6CHNlobOcEkhS6RgCtqPqLn3G7x1UyIQH1SOKfi_lg>
    <xmx:SHWoZE19tS5G55a7jqfQzs4UvUSDKQyAiDCwdlSP2no_QcouPWJhiQ>
    <xmx:SHWoZIl9BD8ts8cVUoK4QbAcoVa6lBOatAoelGSeUXEz3dREyt1b1A>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jul 2023 16:27:51 -0400 (EDT)
Date:   Fri, 7 Jul 2023 13:26:43 -0700
From:   Boris Burkov <boris@bur.io>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: fix iput() on error pointer after error
 during orphan cleanup
Message-ID: <20230707202643.GB2547493@zen>
References: <cover.1688403622.git.fdmanana@suse.com>
 <0acc9d8cea160460e4bf049d761d285697b925bf.1688403622.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0acc9d8cea160460e4bf049d761d285697b925bf.1688403622.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 03, 2023 at 06:15:31PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At btrfs_orphan_cleanup(), if we can't find an inode (btrfs_iget() returns
> an -ENOENT error pointer), we proceed with 'ret' set to -ENOENT and the
> inode pointer set to ERR_PTR(-ENOENT). Later when we proceed to the body
> of the following if statement:
> 
>     if (ret == -ENOENT || inode->i_nlink) {
>         (...)
>         trans = btrfs_start_transaction(root, 1);
>         if (IS_ERR(trans)) {
>             ret = PTR_ERR(trans);
>             iput(inode);
>             goto out;
>         }
>         (...)
>         ret = btrfs_del_orphan_item(trans, root,
>                                     found_key.objectid);
>         btrfs_end_transaction(trans);
>         if (ret) {
>             iput(inode);
>             goto out;
>         }
>         continue;
>     }
> 
> If we get an error from btrfs_start_transaction() or from the call to
> btrfs_del_orphan_item() we end calling iput() against an inode pointer
> that has a value of ERR_PTR(-ENOENT), resulting in a crash with the
> following trace:
> 
>     [438876.667234] BUG: kernel NULL pointer dereference, address: 0000000000000096
>     [438876.667456] #PF: supervisor read access in kernel mode
>     [438876.667683] #PF: error_code(0x0000) - not-present page
>     [438876.667868] PGD 0 P4D 0
>     [438876.668050] Oops: 0000 [#1] PREEMPT SMP PTI
>     [438876.668231] CPU: 0 PID: 2356187 Comm: mount Tainted: G        W          6.4.0-rc6-btrfs-next-134+ #1
>     [438876.668420] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
>     [438876.668617] RIP: 0010:iput+0xa/0x20
>     [438876.668818] Code: ff ff ff 66 (...)
>     [438876.669274] RSP: 0018:ffffafa9c0c9f9d0 EFLAGS: 00010282
>     [438876.669512] RAX: ffffffffffffffe4 RBX: 000000000009453b RCX: 0000000000000000
>     [438876.669746] RDX: 0000000000000001 RSI: ffffafa9c0c9f930 RDI: fffffffffffffffe
>     [438876.669989] RBP: ffff95c612f3b800 R08: 0000000000000001 R09: ffffffffffffffe4
>     [438876.670231] R10: 00018f2a71010000 R11: 000000000ead96e3 R12: ffff95cb7d6909a0
>     [438876.670476] R13: fffffffffffffffe R14: ffff95c60f477000 R15: 00000000ffffffe4
>     [438876.670730] FS:  00007f5fbe30a840(0000) GS:ffff95ccdfa00000(0000) knlGS:0000000000000000
>     [438876.670999] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [438876.671296] CR2: 0000000000000096 CR3: 000000055e9f6004 CR4: 0000000000370ef0
>     [438876.671648] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     [438876.671984] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     [438876.672264] Call Trace:
>     [438876.744284]  <TASK>
>     [438876.744589]  ? __die_body+0x1b/0x60
>     [438876.744872]  ? page_fault_oops+0x15d/0x450
>     [438876.745170]  ? __kmem_cache_alloc_node+0x47/0x410
>     [438876.745459]  ? do_user_addr_fault+0x65/0x8a0
>     [438876.745740]  ? exc_page_fault+0x74/0x170
>     [438876.746021]  ? asm_exc_page_fault+0x22/0x30
>     [438876.746305]  ? iput+0xa/0x20
>     [438876.746586]  btrfs_orphan_cleanup+0x221/0x330 [btrfs]
>     [438876.746917]  btrfs_lookup_dentry+0x58f/0x5f0 [btrfs]
>     [438876.747251]  btrfs_lookup+0xe/0x30 [btrfs]
>     [438876.747564]  __lookup_slow+0x82/0x130
>     [438876.785817]  walk_component+0xe5/0x160
>     [438876.786129]  path_lookupat.isra.0+0x6e/0x150
>     [438876.786411]  filename_lookup+0xcf/0x1a0
>     [438876.786687]  ? mod_objcg_state+0xd2/0x360
>     [438876.786954]  ? obj_cgroup_charge+0xf5/0x110
>     [438876.787255]  ? should_failslab+0xa/0x20
>     [438876.787519]  ? kmem_cache_alloc+0x47/0x450
>     [438876.787772]  vfs_path_lookup+0x51/0x90
>     [438876.788023]  mount_subtree+0x8d/0x130
>     [438876.788306]  btrfs_mount+0x149/0x410 [btrfs]
>     [438876.788624]  ? __kmem_cache_alloc_node+0x47/0x410
>     [438876.788899]  ? vfs_parse_fs_param+0xc0/0x110
>     [438876.789175]  legacy_get_tree+0x24/0x50
>     [438876.834144]  vfs_get_tree+0x22/0xd0
>     [438876.852406]  path_mount+0x2d8/0x9c0
>     [438876.852684]  do_mount+0x79/0x90
>     [438876.852914]  __x64_sys_mount+0x8e/0xd0
>     [438876.853135]  do_syscall_64+0x38/0x90
>     [438876.899182]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>     [438876.958854] RIP: 0033:0x7f5fbe50b76a
>     [438876.959113] Code: 48 8b 0d a9 (...)
>     [438876.959578] RSP: 002b:00007fff01925798 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
>     [438876.959808] RAX: ffffffffffffffda RBX: 00007f5fbe694264 RCX: 00007f5fbe50b76a
>     [438876.960026] RDX: 0000561bde6c8720 RSI: 0000561bde6bdec0 RDI: 0000561bde6c31a0
>     [438876.960238] RBP: 0000561bde6bdc70 R08: 0000000000000000 R09: 0000000000000001
>     [438876.960448] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>     [438876.960657] R13: 0000561bde6c31a0 R14: 0000561bde6c8720 R15: 0000561bde6bdc70
>     [438876.960868]  </TASK>
> 
> So fix this by setting 'inode' to NULL whenever we get an error from
> btrfs_iget(), and to make the code simpler, stop testing for 'ret' being
> -ENOENT to check if we have an inode - instead test for 'inode' being NULL
> or not. Having a NULL 'inode' prevents any iput() call from crashing, as
> iput() ignores NULL inode pointers. Also, stop testing for a NULL return
> value from btrfs_iget() with PTR_ERR_OR_ZERO(), because btrfs_iget() never
> returns NULL - in case an inode is not found, it returns ERR_PTR(-ENOENT),
> and in case of memory allocation failure, it returns ERR_PTR(-ENOMEM).
> We also don't need the extra iput() calls on the error branches for the
> btrfs_start_transaction() and btrfs_del_orphan_item() calls, as we have
> already called iput() before, so remove them.
> 
> Fixes: a13bb2c03848 ("btrfs: add missing iputs on orphan cleanup failure")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/inode.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d919318d2498..c8921589e2f3 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3659,11 +3659,14 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
>  		found_key.type = BTRFS_INODE_ITEM_KEY;
>  		found_key.offset = 0;
>  		inode = btrfs_iget(fs_info->sb, last_objectid, root);
> -		ret = PTR_ERR_OR_ZERO(inode);
> -		if (ret && ret != -ENOENT)
> -			goto out;
> +		if (IS_ERR(inode)) {
> +			ret = PTR_ERR(inode);
> +			inode = NULL;
> +			if (ret != -ENOENT)
> +				goto out;
> +		}
>  
> -		if (ret == -ENOENT && root == fs_info->tree_root) {
> +		if (!inode && root == fs_info->tree_root) {
>  			struct btrfs_root *dead_root;
>  			int is_dead_root = 0;
>  
> @@ -3724,8 +3727,8 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
>  		 * deleted but wasn't. The inode number may have been reused,
>  		 * but either way, we can delete the orphan item.
>  		 */
> -		if (ret == -ENOENT || inode->i_nlink) {
> -			if (!ret) {
> +		if (!inode || inode->i_nlink) {
> +			if (inode) {
>  				ret = btrfs_drop_verity_items(BTRFS_I(inode));
>  				iput(inode);
>  				inode = NULL;
> @@ -3735,7 +3738,6 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
>  			trans = btrfs_start_transaction(root, 1);
>  			if (IS_ERR(trans)) {
>  				ret = PTR_ERR(trans);
> -				iput(inode);
>  				goto out;
>  			}
>  			btrfs_debug(fs_info, "auto deleting %Lu",
> @@ -3743,10 +3745,8 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
>  			ret = btrfs_del_orphan_item(trans, root,
>  						    found_key.objectid);
>  			btrfs_end_transaction(trans);
> -			if (ret) {
> -				iput(inode);
> +			if (ret)
>  				goto out;
> -			}
>  			continue;
>  		}
>  
> -- 
> 2.34.1
> 
