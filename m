Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741FA29F921
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 00:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgJ2XeH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 19:34:07 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34203 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725379AbgJ2XeH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 19:34:07 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 204F95C00EC;
        Thu, 29 Oct 2020 19:34:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 29 Oct 2020 19:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=ckMfmZ794/qPm18fpheDSTGl7M
        CcTEQwXpD2nvmOm1M=; b=EEXSI3LJqH3IwfZ0KICMn4r/59IpzBys4rPcDCZQ2Y
        4fnMTSLLPxBNKHtPgzx+7TOdqSRLpM7/lNEmTVEnc79dcAa9JbCShfz2Rz76iZ/A
        foOPSdwrY5yNEOVnZZYq+eGO2JqGpHLxeU77Vu/meQs9e+WbAO5uDlyhk3sfmh4J
        cTE3FHtDYsV5vyC/Ul2DI9z+Y5aCmNZGcAYWUymv0xtO0Sa7C4y4fTqORHM+WwLm
        L2CJ6ZOLs3qrEvJ5pKyYhZ35c1dAjxFNwtYarDx8bmEyxcZbXeIm8tTmxlEOjHS2
        ZpS0ahRXSmtMyqN8dphaGLD9F/YqPTPVkZuws26DxXpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ckMfmZ794/qPm18fp
        heDSTGl7MCcTEQwXpD2nvmOm1M=; b=Blijx0VfIZbDDf9qpU2FWJZs+2rcvRZBv
        KYR/IOpLCSN7QHMF4kl37aHh8UengTWHgHYEEd4wGKCyExmDy0K41bHlIFXrlLr2
        VpVOLSGLHrq8OYyCbwBKhLzToyDTXj5MR+zX61vxP4LvtxTAzYe/hJJ5ToXCoy6R
        H72MikAIbBgEpOVoVW4iBpLykN490D6IEgaA2xF1TwRKFFQ7DPWgXYoHGpOg7DJD
        ykTQRFDBsTwpg43rTtckEQNw33GGVGCwZOoJHbmGso4ftW0MtOx5nd5K0H+AvlFP
        GdoSTvPm+29xo3wk10gbJ2ZZC3NpxLPqMap/yv45ip8bz5TRl3Nbw==
X-ME-Sender: <xms:bVGbX9_L-U97RGqJtEQ4je9g6cHPvumGd4kuPhHUinCqsUxJz3xvpw>
    <xme:bVGbXxtEEBbizPeY0Ni7n03QxelN31JYoKVIdCZVQoO0KoTneCftrRg_SXcGVqjqN
    HFleVj5xuU2FUm4bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhes
    ugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepffffgeejudehlefgtddukeeije
    fggeehheejgfeijeevveetieevueekgfehkeejnecuffhomhgrihhnpehgihhthhhusgdr
    tghomhenucfkphepudeifedruddugedrudefvddrudenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:bVGbX7CZYSyfPiBetW3Lg7-hTs-e1P-7USjEek8QMsxTPChK-8Nx1w>
    <xmx:bVGbXxf8xSiAqFEEjtk4MAcXVSjHysf_C1WaL0cKqSfnDuQgzGnzbQ>
    <xmx:bVGbXyPEQNDkipp6HCH5dN900q1rtj6nJr70SoJVWEkqONa9NHK9rA>
    <xmx:blGbX7YSBeUtBaYDurHGB35GLkOqLez7VFRNdE1mJMAI20Ax80tSnA>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id AC7FD3064683;
        Thu, 29 Oct 2020 19:34:04 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz, josef@toxicpanda.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH v2] btrfs-progs: restore: Have -l display subvolume name
Date:   Thu, 29 Oct 2020 16:33:52 -0700
Message-Id: <f4cf625aa2a0e52f722c7e1e92dc04906e1049dc.1604014245.git.dxu@dxuuu.xyz>
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
v1 -> v2:
* moved get_subvol_name() to common/utils.c
* check return from get_subvol_name() for errors

 cmds/restore.c | 14 +++++++++++++-
 common/utils.c | 35 +++++++++++++++++++++++++++++++++++
 common/utils.h |  1 +
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/cmds/restore.c b/cmds/restore.c
index 025e99e9..d3a25952 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -1206,6 +1206,7 @@ static int do_list_roots(struct btrfs_root *root)
 	struct extent_buffer *leaf;
 	struct btrfs_root_item ri;
 	unsigned long offset;
+	char *name;
 	int slot;
 	int ret;

@@ -1244,8 +1245,19 @@ static int do_list_roots(struct btrfs_root *root)
 		read_extent_buffer(leaf, &ri, offset, sizeof(ri));
 		printf(" tree ");
 		btrfs_print_key(&disk_key);
-		printf(" %Lu level %d\n", btrfs_root_bytenr(&ri),
+		printf(" %Lu level %d", btrfs_root_bytenr(&ri),
 		       btrfs_root_level(&ri));
+
+		name = get_subvol_name(root, found_key.objectid);
+		if (IS_ERR(name)) {
+			fprintf(stderr, "Failed to get subvol name: %s",
+					strerror(-PTR_ERR(name)));
+		} else if (name) {
+			printf(" %s", name);
+			free(name);
+		}
+
+		printf("\n");
 		path.slots[0]++;
 	}
 	btrfs_release_path(&path);
diff --git a/common/utils.c b/common/utils.c
index c47ce29b..b6cb578d 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -1590,6 +1590,41 @@ const char *subvol_strip_mountpoint(const char *mnt, const char *full_path)
 	return full_path + len;
 }

+char *get_subvol_name(struct btrfs_root *tree_root, u64 subvol_id)
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
 /* Set the seed manually */
 void init_rand_seed(u64 seed)
 {
diff --git a/common/utils.h b/common/utils.h
index 0413489d..6ca75fbf 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -99,6 +99,7 @@ int get_df(int fd, struct btrfs_ioctl_space_args **sargs_ret);
 int test_uuid_unique(char *fs_uuid);

 const char *subvol_strip_mountpoint(const char *mnt, const char *full_path);
+char *get_subvol_name(struct btrfs_root *tree_root, u64 subvol_id);
 int find_next_key(struct btrfs_path *path, struct btrfs_key *key);
 const char* btrfs_group_type_str(u64 flag);
 const char* btrfs_group_profile_str(u64 flag);
--
2.26.2

