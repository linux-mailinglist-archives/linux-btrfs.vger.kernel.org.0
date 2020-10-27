Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C324229A043
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 01:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442736AbgJ0A3D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 20:29:03 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:59781 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409851AbgJ0A3A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 20:29:00 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 41A0AF87;
        Mon, 26 Oct 2020 20:28:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 26 Oct 2020 20:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=ag8fx6fXuMSFgtUlzUz6zx5Mmh
        caLpCPmMJGqKrcDV0=; b=V6ExEjwPq/5n83loGFSqjugWISZ/SQhDhA2ZwCXJeP
        iqOSXlHGTV7DfhsdRCdTNyka4rFseHF2eCmPfElrYOiPFkZ+oDUZJxc5tP9AYCY4
        oQ6rEu7fPq8RyeNSImsr/qozzO4AJcf+cj7S1BljNdSNyfZC3HEri9dDHQGrV74d
        29SINTYAP6qHw3i7GQEEyzkKLesjyCcKnzwkxPWe5xJGoW23OEVW5SKIzuuuElTQ
        rSxdE4fhHkLUOIeoJChneBoBX+HOsb0U5UxXPClGWgj9IezPSNqlNb4eOYTlzN86
        30PR2Tjcfr09amtgDWmPhQ0uM3cAPfnzRPzOfV40PzSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ag8fx6fXuMSFgtUlz
        Uz6zx5MmhcaLpCPmMJGqKrcDV0=; b=nmfSxgSbuVWp+Q5yFHrY90R3xfN6YkvDV
        30YhAa6rspGVtN5hJDqndkuUOiahTzvKiT27qmMqdyfVuTi18F0f5kPtDPTl4uCE
        DI7pnvnVRR4yGpOelxnSSFUCbMwH9PGY0/56PGwz2k1C7UnUWC/ZnQKDojibl35M
        ViPN4yRP0A/x+LzNCdYzwjcAo+wCay0FTl7+dKIi4nlVI5QKQYwLUV4sraSq1ZMH
        WHzPxrhWhuszu+J8pL1WqU+65VC71PGXJ41+EbOUcOat85Jq0yBxyU68xh74hn8h
        wjuaTDkCWtlmNJPinf467DavhsXMo6gmdRe+xrQMhSZcbhdsK1qfg==
X-ME-Sender: <xms:ymmXX-uIDRuIewCvNNYjiG98b5rYVFgvtDVu4mLFowYFZXnAWIFNEg>
    <xme:ymmXXzeKYPiqm-LIV_1z7RJajHdMgVrDq-y2xsZdha5POnewP8SBS9Rnih8aparZt
    Usdg4PekwgnCkowww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeekgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhes
    ugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepffffgeejudehlefgtddukeeije
    fggeehheejgfeijeevveetieevueekgfehkeejnecuffhomhgrihhnpehgihhthhhusgdr
    tghomhenucfkphepudeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:ymmXX5ybXJFYidMTPiWeknXm8cZrqMcJC0g32L8XuI1i7DbR96O7mw>
    <xmx:ymmXX5PV7xiHjtTuBsZOyfPbTPCvPWFJbHsQ_KiTddm6F9ivC5QPUA>
    <xmx:ymmXX-_Fx7Ex_6yWIPgd9AX_5-yiEMEVgx3nc48xVO-6lpSHJwNi4Q>
    <xmx:ymmXX0ngJnMwi_sFxWqX_YwPiKnOz-9KzGtQMWnmdjfbZlQW1mNwlQ>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id B132E3064682;
        Mon, 26 Oct 2020 20:28:55 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: restore: Have -l display subvolume name
Date:   Mon, 26 Oct 2020 17:28:41 -0700
Message-Id: <547cf7d97e32b542f4a552c7319b167dd6b94403.1603758365.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This commit has `btrfs restore -l ...` display subvolume names if
applicable. Before, it only listed subvolume IDs which are not very
helpful for the user. A subvolume name is much more descriptive.

Before:
	$ btrfs restore ~/scratch/btrfs/fs -l
	 tree key (EXTENT_TREE ROOT_ITEM 0) 30425088 level 0
	 tree key (DEV_TREE ROOT_ITEM 0) 30441472 level 0
	 tree key (FS_TREE ROOT_ITEM 0) 30736384 level 0
	 tree key (CSUM_TREE ROOT_ITEM 0) 30474240 level 0
	 tree key (UUID_TREE ROOT_ITEM 0) 30785536 level 0
	 tree key (256 ROOT_ITEM 0) 30818304 level 0
	 tree key (257 ROOT_ITEM 0) 30883840 level 0
	 tree key (DATA_RELOC_TREE ROOT_ITEM 0) 30490624 level 0

After:
	$ ./btrfs restore ~/scratch/btrfs/fs -l
	 tree key (EXTENT_TREE ROOT_ITEM 0) 30425088 level 0
	 tree key (DEV_TREE ROOT_ITEM 0) 30441472 level 0
	 tree key (FS_TREE ROOT_ITEM 0) 30736384 level 0
	 tree key (CSUM_TREE ROOT_ITEM 0) 30474240 level 0
	 tree key (UUID_TREE ROOT_ITEM 0) 30785536 level 0
	 tree key (256 ROOT_ITEM 0) 30818304 level 0 subvol1
	 tree key (257 ROOT_ITEM 0) 30883840 level 0 subvol2
	 tree key (DATA_RELOC_TREE ROOT_ITEM 0) 30490624 level 0

Link: https://github.com/kdave/btrfs-progs/issues/289
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 cmds/restore.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/cmds/restore.c b/cmds/restore.c
index 025e99e9..218c6ec1 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -1197,6 +1197,41 @@ out:
 	return ret;
 }
 
+static char *get_subvol_name(struct btrfs_root *tree_root, u64 subvol_id)
+{
+	struct btrfs_root_ref *ref;
+	struct btrfs_path path;
+	struct btrfs_key key;
+	int namelen;
+	int ret;
+	char *name = NULL;
+
+	key.objectid = BTRFS_FS_TREE_OBJECTID;
+	key.type = BTRFS_ROOT_REF_KEY;
+	key.offset = subvol_id;
+
+	btrfs_init_path(&path);
+	ret = btrfs_search_slot(NULL, tree_root, &key, &path, 0, 0);
+	if (ret != 0)
+		goto out;
+
+	ref = btrfs_item_ptr(path.nodes[0], path.slots[0], struct btrfs_root_ref);
+
+	namelen = btrfs_root_ref_name_len(path.nodes[0], ref);
+	name = malloc(sizeof(char) * namelen + 1);
+	if (!name) {
+		name = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	read_extent_buffer(path.nodes[0], name, (unsigned long)(ref + 1), namelen);
+	name[namelen] = 0;
+
+out:
+	btrfs_release_path(&path);
+	return name;
+}
+
 static int do_list_roots(struct btrfs_root *root)
 {
 	struct btrfs_key key;
@@ -1206,6 +1241,7 @@ static int do_list_roots(struct btrfs_root *root)
 	struct extent_buffer *leaf;
 	struct btrfs_root_item ri;
 	unsigned long offset;
+	char *name;
 	int slot;
 	int ret;
 
@@ -1244,8 +1280,16 @@ static int do_list_roots(struct btrfs_root *root)
 		read_extent_buffer(leaf, &ri, offset, sizeof(ri));
 		printf(" tree ");
 		btrfs_print_key(&disk_key);
-		printf(" %Lu level %d\n", btrfs_root_bytenr(&ri),
+		printf(" %Lu level %d", btrfs_root_bytenr(&ri),
 		       btrfs_root_level(&ri));
+
+		name = get_subvol_name(root, found_key.objectid);
+		if (name) {
+			printf(" %s", name);
+			free(name);
+		}
+
+		printf("\n");
 		path.slots[0]++;
 	}
 	btrfs_release_path(&path);
-- 
2.26.2

