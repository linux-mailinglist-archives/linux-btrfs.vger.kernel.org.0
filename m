Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAB964D2FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Dec 2022 00:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiLNXFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Dec 2022 18:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLNXFP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Dec 2022 18:05:15 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D2A26555
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Dec 2022 15:05:13 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id BDB825C004F;
        Wed, 14 Dec 2022 18:05:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 14 Dec 2022 18:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1671059110; x=1671145510; bh=l5+xFxqkk3jFeWnrlV6ynBu22
        mPh0IIPwRn/ARF6RFU=; b=yF/hal96fYW5Zj+VU8VJmwux7+pqF54pP09FnrTtz
        EUzB8mXaI9fbZMS5pb0OLzSdEE2EMLjxWTT0pLUJo6cKtCeHfgN1RnNTyGfDJsRF
        kTE8OslpuF6zI0KYhQK+akbOr+CgovNEbBMER+1Y2XV6PyprtEdVKcxVIb8xgrkH
        XkU39Spvh6/+1mukULu/t+9LrzJGz+Ph4ivXxIOm6PFRHtkerEi5SmR+nYN/wXEA
        WmNKR8ew9KlxglEtNDZ2//kUJs1dcvZNB0yqwSY2h1pYWQRAuENY6dfxlmIkgjY0
        lhI5EeIxvZFHvxYiJXC+eDtPEDmsqAUekuGNPoetQNong==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1671059110; x=1671145510; bh=l5+xFxqkk3jFeWnrlV6ynBu22mPh0IIPwRn
        /ARF6RFU=; b=eYCUWDXfqBScpdQi6fxcxCtzhhqdNuwrAzNsg9cQ0IuH2u5h/2Q
        41ZbjIZW6vUQ39pbbfZJZyD79el1xqSqLt/wHqKGuqaDdCNzdyNNogG2Ifj2PLwG
        x8PQ9qlAYelltqwvMB609FA7QWtEZmNBHJREjBZFvd8HRpOpipY3V7PKhVEgM7ad
        n0ZIr/8/ubik+NC2fr/pZ5nje/mZ0V4bUGbzAb3nUqeM5mY6SuWks0tiUTsnYe7v
        udKvF+1SD0YKcDCV6+1kmFXXPxBVNKvp1ghJZmPKe+wlMwXePwRE7YqdIlRvFNgO
        o0eIF2NGyIBk0waO4h5NR4ti9Yzc0zeu/lg==
X-ME-Sender: <xms:plaaY43DsaBJUoxqdB1ay82b58CoJ8o-RtJUwDJolKrCcxJduubXmw>
    <xme:plaaYzENU_WP7W5SEsSF2SN8a7uBkijd6fqqEOluWgn3bKNdVn0wD__Woyj_lx-u4
    DrmBGM9gUA4VJqnnx0>
X-ME-Received: <xmr:plaaYw78wrA83b--G20OhRaLjJwIIkBA5NpmSmG5mF-Hu6Ir9_1v6SgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeggddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepleeigfehveeigfdugeejhfeuvedvtddvfeevjeevkeevhe
    fggfeijeetheffvdeknecuffhomhgrihhnpehqvghmuhdrohhrghenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:plaaYx1SRTfgOR07V2J2YAbfgLQb-iPb3jiFvAEcYiLdEle3pK_Qog>
    <xmx:plaaY7HISeVnNY93aPS42p9HIwcH4lrTz4YtPl79DgpY0SA8J5FCNg>
    <xmx:plaaY68VzOyVhMwdmZlbqEjlQHOMrY019YcAyplJxHdHlpeCnJsz8Q>
    <xmx:plaaY-NMAiy_3RMiOj0_H-zCwzq8Ag3l7loaJKf9QJipsQal76GSXg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Dec 2022 18:05:10 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: fix logical_ino ioctl panic
Date:   Wed, 14 Dec 2022 15:05:08 -0800
Message-Id: <80f01f297721481fd0d4cbf03fd2550e25b578fb.1671058852.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If a file consists of an inline extent followed by a regular or prealloc
extent, then a legitimate attempt to resolve a logical address in the
non-inline region will result in add_all_parents reading the invalid
offset field of the inline extent. If the inline extent item is placed
in the leaf eb s.t. it is the first item, attempting to access the
offset field will not only be meaningless, it will go past the end of
the eb and cause this panic:

[   17.626048] BTRFS warning (device dm-2): bad eb member end: ptr
0x3fd4 start 30834688 member offset 16377 size 8
[   17.631693] general protection fault, probably for non-canonical
address 0x5088000000000: 0000 [#1] SMP PTI
[   17.635041] CPU: 2 PID: 1267 Comm: btrfs Not tainted
5.12.0-07246-g75175d5adc74-dirty #199
[   17.637969] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   17.641995] RIP: 0010:btrfs_get_64+0xe7/0x110
[   17.643544] Code: 78 bf 08 00 00 00 48 b8 00 00 00 00 80 88 ff ff 4a
8d 34 04 48 c1 fa 06 48 c1 e2 0c 48 01 c2 29 cf 74 14 31 c0 89 c1 83 c0
01 <44> 0f b6 04 0a 39 f8 44 88 04 0e 72 ee 48 8b 04 24 e9 7a ff ff ff
[   17.649890] RSP: 0018:ffffc90001f73a08 EFLAGS: 00010202
[   17.651652] RAX: 0000000000000001 RBX: ffff88810c42d000 RCX:
0000000000000000
[   17.653921] RDX: 0005088000000000 RSI: ffffc90001f73a0f RDI:
0000000000000001
[   17.656174] RBP: 0000000000000ff9 R08: 0000000000000007 R09:
c0000000fffeffff
[   17.658441] R10: ffffc90001f73790 R11: ffffc90001f73788 R12:
ffff888106afe918
[   17.661070] R13: 0000000000003fd4 R14: 0000000000003f6f R15:
cdcdcdcdcdcdcdcd
[   17.663617] FS:  00007f64e7627d80(0000) GS:ffff888237c80000(0000)
knlGS:0000000000000000
[   17.666525] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.668664] CR2: 000055d4a39152e8 CR3: 000000010c596002 CR4:
0000000000770ee0
[   17.671253] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   17.673634] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   17.676034] PKRU: 55555554
[   17.677004] Call Trace:
[   17.677877]  add_all_parents+0x276/0x480
[   17.679325]  find_parent_nodes+0xfae/0x1590
[   17.680771]  btrfs_find_all_leafs+0x5e/0xa0
[   17.682217]  iterate_extent_inodes+0xce/0x260
[   17.683809]  ? btrfs_inode_flags_to_xflags+0x50/0x50
[   17.685597]  ? iterate_inodes_from_logical+0xa1/0xd0
[   17.687404]  iterate_inodes_from_logical+0xa1/0xd0
[   17.689121]  ? btrfs_inode_flags_to_xflags+0x50/0x50
[   17.691010]  btrfs_ioctl_logical_to_ino+0x131/0x190
[   17.692946]  btrfs_ioctl+0x104a/0x2f60
[   17.694384]  ? selinux_file_ioctl+0x182/0x220
[   17.695995]  ? __x64_sys_ioctl+0x84/0xc0
[   17.697394]  __x64_sys_ioctl+0x84/0xc0
[   17.698697]  do_syscall_64+0x33/0x40
[   17.700017]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   17.701753] RIP: 0033:0x7f64e72761b7
[   17.703011] Code: 3c 1c 48 f7 d8 49 39 c4 72 b9 e8 24 ff ff ff 85 c0
78 be 4c 89 e0 5b 5d 41 5c c3 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 89 9c 0c 00 f7 d8 64 89 01 48
[   17.709355] RSP: 002b:00007ffefb067f58 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   17.712088] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
00007f64e72761b7
[   17.714667] RDX: 00007ffefb067fb0 RSI: 00000000c0389424 RDI:
0000000000000003
[   17.717386] RBP: 00007ffefb06d188 R08: 000055d4a390d2b0 R09:
00007f64e7340a60
[   17.719938] R10: 0000000000000231 R11: 0000000000000246 R12:
0000000000000001
[   17.722383] R13: 0000000000000000 R14: 00000000c0389424 R15:
000055d4a38fd2a0
[   17.724839] Modules linked in:
[   17.726094] ---[ end trace e97f925b39774256 ]---

Fix the bug by detecting the inline extent item in add_all_parents and
skipping to the next extent item.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/backref.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 21c92c74bf71..46851511b661 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -484,6 +484,7 @@ static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
 	u64 wanted_disk_byte = ref->wanted_disk_byte;
 	u64 count = 0;
 	u64 data_offset;
+	u8 type;
 
 	if (level != 0) {
 		eb = path->nodes[level];
@@ -538,6 +539,9 @@ static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
 			continue;
 		}
 		fi = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
+		type = btrfs_file_extent_type(eb, fi);
+		if (type == BTRFS_FILE_EXTENT_INLINE)
+			goto next;
 		disk_byte = btrfs_file_extent_disk_bytenr(eb, fi);
 		data_offset = btrfs_file_extent_offset(eb, fi);
 
-- 
2.38.1

