Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605BA618D61
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Nov 2022 02:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKDBCz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 21:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKDBCy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 21:02:54 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2612112760
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 18:02:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id EC90532002B6;
        Thu,  3 Nov 2022 21:02:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 03 Nov 2022 21:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1667523766; x=1667610166; bh=O78lvsvfsrcqIrWT946gbaW3G
        onWC1ThIwX8RWfb89A=; b=K5F+EqyyTTQYPjUwisvTuYgpTVgtV2DhoC2BVSIrL
        NbC4H9+RvozM7MyxOyLx2FH7PCZMImXyy3BxM1XUXzDgcnChVLYFaSgooSKGq509
        p2XuUjifIXn0DcEHD2mSdn82Ef58DYMVIuMqfrqBqq93cy6WhFabEIRAN6Hqff5h
        xcmw73wOVFgwGk8BsIU8kcScCJdLeRNVvPaXxUAMTWy9vK7MzUJly+dvdcngXzpF
        OdAnSv+mU9o4wF7gjd0LSOTxFKaqIWHPMt6BFpYbVTBVBWYEEBusaUXFJuH0h4/X
        k7A1mRFJeeLt6rUN0+f5D2xTlziIXeyGDdHkRo2dQWzvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1667523766; x=1667610166; bh=O78lvsvfsrcqIrWT946gbaW3GonWC1ThIwX
        8RWfb89A=; b=tsoPXWr/xmgy4OAQzGW2bbz3rbZhUf/9i4mdAFU0AKogvsR5knt
        cB4eHItiWtJigca6DbsAFLj8AbCqSBaJ2ssAVnWFfqh3cv/XgBGcFav9ynQd/Rm1
        GVJ6Cu9BNfRvoW421DKD4Nc+BYghC6jgG5x3Ql2lmvpfmI/QwWeyLZjrb2SP09r/
        UkyyfcY2twrV1spirAe6qdGXbI0wYmpWdM8nF0AAXrHuX5TyZPqMI6QS7pl9lZVL
        406BgvTrtPgkx3P8w9+UpfGJobt6bqlNgRZsTNY3In+Kig97k+K5C+M578vG1jq2
        o58N/6P9bboxaN0if25kMJbK8dA217sllog==
X-ME-Sender: <xms:tmRkY46YuCYE6e12rTnR8Daag3k3g2jjVQ59dpmRywHY2vRgL2Tstw>
    <xme:tmRkY56khmQ-tyLBnfJthYUpYBke8daxSWVjhi5zg6ga9fG2S8VzJ3Fb2aQ2_MS5Y
    xKK6oxuoRkxp67WA8g>
X-ME-Received: <xmr:tmRkY3djQoLQ_L1yRbCX3Lmorpqwk9IIKf-HI_pzPZgbMf3afsvZRCGCVznJgmiISKgZ1K275neFG2d72n_dlSeWdJ6-0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddtgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepleeigfehveeigfdugeejhfeuvedvtddvfeevjeevkeevhe
    fggfeijeetheffvdeknecuffhomhgrihhnpehqvghmuhdrohhrghenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:tmRkY9KvOEQ1gdxV4fqCWVVl8RjXrHLphXI48TRK2w7wPwhAPSetlQ>
    <xmx:tmRkY8JM9WczemlCnYv-K5CrrmTUgorFUfb5GfvNPEWYfu62ILf0lA>
    <xmx:tmRkY-yWJia7_0pYN9GTCNgtMQhXPufMYIK73KHb5Mm_5MSgcnctpA>
    <xmx:tmRkY2zY1XdS72-amzdMnoms4aRDlGZ9sG0lmhryp73BlSrcC9hVUg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Nov 2022 21:02:45 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: fix improper error handling in btrfs_unlink
Date:   Thu,  3 Nov 2022 18:02:44 -0700
Message-Id: <d1213451ff43c39304d949881a2fa4e8a8b561b3.1667523745.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While running fstests, I am periodically seeing the following Oops:
[  438.850463] BUG: kernel NULL pointer dereference, address: 000000000000001c
[  438.851144] BO: 5492: __btrfs_end_transaction NULLPTR. 000000003eed7ad7 000000009255e073 000000009255e073 00000000a86f0e30 000000007a988369
[  438.851168] BO: 5396: __btrfs_end_transaction NULLPTR. 0000000005d194fe 00000000f17a0060 00000000f17a0060 00000000a86f0e30 000000007a988369
[  438.851180] BO: 5437: __btrfs_end_transaction NULLPTR. 00000000c1da60f0 00000000d9fb95f0 00000000d9fb95f0 00000000a86f0e30 000000007a988369
[  438.852034] #PF: supervisor read access in kernel mode
[  438.859239] #PF: error_code(0x0000) - not-present page
[  438.859455] PGD 0 P4D 0
[  438.859566] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  438.859753] CPU: 0 PID: 5370 Comm: fsstress Not tainted 6.1.0-rc3+ #1109
[  438.860030] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  438.860507] RIP: 0010:__btrfs_end_transaction+0x1d/0x1c1 [btrfs]
[  438.860884] Code: bc 5f c0 e8 a6 66 00 00 e9 99 90 f4 ff 0f 1f 44 00 00 41 56 4c 8d 77 40 41 55 41 89 f5 4d 89 f0 4c 89 f1 41 54 55 48 89 fd 53 <4c> 8b 67 20 48 8b 5f 50 49 8d 44 24 0c 4d 89 e1 65 48 8b 14 25 80
[  438.862026] RSP: 0018:ffffb2d84876fdd8 EFLAGS: 00010246
[  438.862346] RAX: fffffffffffffffc RBX: ffff89e50a094af8 RCX: 000000000000003c
[  438.862797] RDX: 0000000000000001 RSI: 0000000000000000 RDI: fffffffffffffffc
[  438.863237] RBP: fffffffffffffffc R08: 000000000000003c R09: 0000000000018000
[  438.863679] R10: 0000000000000000 R11: 000000000000000b R12: 00000000fffffffc
[  438.864122] R13: 0000000000000000 R14: 000000000000003c R15: ffff89e552473ba0
[  438.864551] FS:  00007efe9802f740(0000) GS:ffff89e637c00000(0000) knlGS:0000000000000000
[  438.865054] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  438.865409] CR2: 000000000000001c CR3: 000000010ae3c000 CR4: 00000000000006f0
[  438.865863] Call Trace:
[  438.866022]  <TASK>
[  438.866158]  btrfs_unlink+0xea/0x170 [btrfs]
[  438.866447]  vfs_unlink+0x117/0x290
[  438.866673]  do_unlinkat+0x1a3/0x2d0
[  438.866900]  __x64_sys_unlink+0x3e/0x60
[  438.867144]  ? __ia32_sys_unlink+0x60/0x60
[  438.867406]  do_syscall_64+0x3b/0x90
[  438.867637]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  438.867955] RIP: 0033:0x7efe98122ee7
[  438.868184] Code: f0 ff ff 73 01 c3 48 8b 0d 86 df 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 59 df 0c 00 f7 d8 64 89 01 48
[  438.869321] RSP: 002b:00007fff183427f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
[  438.869788] RAX: ffffffffffffffda RBX: 00007fff18342970 RCX: 00007efe98122ee7
[  438.870206] RDX: 0000558a1a125a0d RSI: 0000000000000000 RDI: 0000558a1a125a00
[  438.870636] RBP: 0000558a18aed560 R08: fefefefefefefeff R09: 00007fff1834295c
[  438.871071] R10: 0000000000000036 R11: 0000000000000246 R12: 00000000000001c1
[  438.871511] R13: 00007fff18342970 R14: 0000558a18ae4000 R15: 00000000000001c1
[  438.871964]  </TASK>
[  438.872104] Modules linked in: virtio_net btrfs xor raid6_pq zstd_compress null_blk
[  438.872581] CR2: 000000000000001c
[  438.872820] ---[ end trace 0000000000000000 ]---

On my system, I can reliably reproduce this by running generic/269 ~10
times on the current misc-next.

The bug is btrfs_unlink jumping to 'out' from failing to start the
transaction. In one particular case I caught with kdump, the pointer's
value was EINTR.

Fix it by re-ordering releasing resources in the exit path to match the
acquisition order (free fscrypt name after ending transaction) and
jumping to the right place, based on where the error happened.

Fixes: 6a1d44efb9d0 ("btrfs: setup qstr from dentrys using fscrypt helper")
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/inode.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 255959574724..1422f072a7b8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4453,7 +4453,7 @@ static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
 	trans = __unlink_start_trans(dir);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
-		goto out;
+		goto fscrypt_free;
 	}
 
 	btrfs_record_unlink_dir(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
@@ -4462,18 +4462,19 @@ static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
 	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
 				 &fname.disk_name);
 	if (ret)
-		goto out;
+		goto end_trans;
 
 	if (inode->i_nlink == 0) {
 		ret = btrfs_orphan_add(trans, BTRFS_I(inode));
 		if (ret)
-			goto out;
+			goto end_trans;
 	}
 
-out:
-	fscrypt_free_filename(&fname);
+end_trans:
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(BTRFS_I(dir)->root->fs_info);
+fscrypt_free:
+	fscrypt_free_filename(&fname);
 	return ret;
 }
 
-- 
2.38.1

