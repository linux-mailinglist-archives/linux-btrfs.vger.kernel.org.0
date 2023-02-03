Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0170688C30
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Feb 2023 01:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjBCA6y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Feb 2023 19:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBCA6w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Feb 2023 19:58:52 -0500
Received: from w1.tutanota.de (w1.tutanota.de [81.3.6.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E1A69B3C
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Feb 2023 16:58:50 -0800 (PST)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
        by w1.tutanota.de (Postfix) with ESMTP id 71FD3FBF98A
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Feb 2023 00:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1675385929;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
        bh=tkjaf2/lnaETU8r9GRFQ9B5RfTCWgomedbBJc+TXph0=;
        b=wKS2TEOrgxc/Uup9cOeEeN8+A3wIt1T24n6dEQ9No0hy6rdDPnWhzb/bRREh8Pqa
        QwcDXGTK22l9TKyM6r/kasJEnHtZ1OISVrnIUEMXPoykASLhrUyAgFNs4W8O4A+Lb+e
        Y3M1PhTq2mBRdh4VG1T+jYQFkqLLLXMxcy+xZuJS4grKy58oDF9cSaiBg3jhcy+zRrb
        lB3R/V6drYC5DkNiPUWd+zbIoB6vD7AZj5geh0apotehXhrGhfHCAcwEgmp7AMcJzUM
        UTjX3y9qNbFL3U5cOuhN5w+APaEJ7Y6eNZVoc4q98Oiyqcb38VAcuvJMFB9jo/worY4
        W85RyyKP6Q==
Date:   Fri, 3 Feb 2023 01:58:49 +0100 (CET)
From:   liuwf@tutanota.com
To:     Linux Btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <NNJm6i---3-9@tutanota.com>
Subject: [RFC PATCH 1/1] btrfs:Try to reduce the operating frequency of free
 space cache trees when allocating unclustered
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As far as I understand, each time when we allocate a free space in uncluste=
red
way (on a heavy-fragmented disk or maybe other cases), a struct btrfs_free_=
space
entry will be removed from two free space cache trees, then the entry's off=
set
and size are altered, after done we insert the entry into the two trees aga=
in.
These operatings are densy computing, this patch try to reduce tree operati=
ng
frequency based on two logic (fix me):

1 There is only one case that need to remove and reinsert an entry from/int=
o
the tree when allocating is made from the offset-indexed tree:

An entry is overlapping with a bitmap AND that entry's start is ahead of
the bitmap's start. When the entry shrinked it's start position walks
towards higher address and may overcome the bitmap's start, in this case
the entry need removed and reinserted from/into the tree to get a right
order.
(Exhanging the two nodes may be better, but it seems more troublesome?)

A bitmap may be overlapped with many entries, but they are not be able to
change their start position to overcome the bitmap EXCEPT the one above
mentioned

All other conditions are not supposed to change the relative position of tw=
o
neighbour entries.


2 As for allocating from the bytes-indexed tree.
Because we always begin to pick the entry that has the biggest size
(rb_first_cached()) to tear free space from it, it has the most potentialit=
y
for the biggest to keep it's top weight, imaging a Mibs-sized entry cutted =
away
several KBs, that may or may not changd it's size below the second entry, t=
he
later case may be the one with more probability.

This patch try to check an entry's offset and size when changed, and compar=
e
the result with the next entry's, In theory,=C2=A0 1/3 ~ 1/2 of operatings =
probably
could be saved.

This patch has been passed through xfstests. Any comments are appreciated.

Signed-off-by: Liu Weifeng 4019c26b5c0d5f6b <Liuwf@tutanota.com>
---

fs/btrfs/free-space-cache.c | 51 ++++++++++++++++++++++++++++++++++---
1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f4023651dd68..1713f36a01cd 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -39,6 +39,8 @@ static int link_free_space(struct btrfs_free_space_ctl *c=
tl,
=C2=A0=C2=A0 struct btrfs_free_space *info);
static void unlink_free_space(struct btrfs_free_space_ctl *ctl,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_free_space *info, bool update_s=
tat);
+static void relink_free_space_entry(struct btrfs_free_space_ctl *ctl,
+=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_free_space *space_info);
static int search_bitmap(struct btrfs_free_space_ctl *ctl,
struct btrfs_free_space *bitmap_info, u64 *offset,
u64 *bytes, bool for_alloc);
@@ -1840,6 +1842,47 @@ static int link_free_space(struct btrfs_free_space_c=
tl *ctl,
return ret;
}

+static void relink_free_space_entry(struct btrfs_free_space_ctl *ctl,
+=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_free_space *info)
+{
+ struct rb_node *next_node =3D NULL;
+ struct btrfs_free_space *next_info_offset =3D NULL;
+ struct btrfs_free_space *next_info_bytes =3D NULL;
+
+ next_node =3D rb_next(&info->offset_index);
+ if (next_node)
+ next_info_offset =3D rb_entry(next_node, struct btrfs_free_space,
+=C2=A0=C2=A0=C2=A0=C2=A0 offset_index);
+ next_node =3D rb_next(&info->bytes_index);
+ if (next_node)
+ next_info_bytes =3D rb_entry(next_node, struct btrfs_free_space,
+=C2=A0=C2=A0=C2=A0 bytes_index);
+ ASSERT(info->bytes || info->bitmap);
+
+ if (next_info_offset && next_info_bytes &&
+=C2=A0=C2=A0=C2=A0=C2=A0 unlikely(info->offset > next_info_offset->offset)=
 &&
+=C2=A0=C2=A0=C2=A0=C2=A0 (info->bytes < next_info_bytes->bytes)) {
+ rb_erase(&info->offset_index, &ctl->free_space_offset);
+ tree_insert_offset(&ctl->free_space_offset, info->offset,
+=C2=A0=C2=A0=C2=A0 &info->offset_index, (info->bitmap !=3D NULL));
+
+ rb_erase_cached(&info->bytes_index, &ctl->free_space_bytes);
+ rb_add_cached(&info->bytes_index, &ctl->free_space_bytes,
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry_less);
+
+ } else if (next_info_offset &&
+=C2=A0=C2=A0=C2=A0 unlikely(info->offset > next_info_offset->offset)) {
+ rb_erase(&info->offset_index, &ctl->free_space_offset);
+ tree_insert_offset(&ctl->free_space_offset, info->offset,
+=C2=A0=C2=A0=C2=A0 &info->offset_index, (info->bitmap !=3D NULL));
+
+ } else if (next_info_bytes && info->bytes < next_info_bytes->bytes) {
+ rb_erase_cached(&info->bytes_index, &ctl->free_space_bytes);
+ rb_add_cached(&info->bytes_index, &ctl->free_space_bytes,
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry_less);
+ }
+}
+
static void relink_bitmap_entry(struct btrfs_free_space_ctl *ctl,
struct btrfs_free_space *info)
{
@@ -3093,7 +3136,6 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_gro=
up *block_group,
if (!entry->bytes)
free_bitmap(ctl, entry);
} else {
- unlink_free_space(ctl, entry, true);
align_gap_len =3D offset - entry->offset;
align_gap =3D entry->offset;
align_gap_trim_state =3D entry->trim_state;
@@ -3105,10 +3147,11 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_g=
roup *block_group,
WARN_ON(entry->bytes < bytes + align_gap_len);

entry->bytes -=3D bytes + align_gap_len;
- if (!entry->bytes)
+ if (!entry->bytes) {
+ unlink_free_space(ctl, entry, true);
kmem_cache_free(btrfs_free_space_cachep, entry);
- else
- link_free_space(ctl, entry);
+ } else
+ relink_free_space_entry(ctl, entry);
}
out:
btrfs_discard_update_discardable(block_group);
--
2.30.2
