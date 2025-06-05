Return-Path: <linux-btrfs+bounces-14490-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E6CACF439
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 18:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE023AF09C
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 16:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A5123E33A;
	Thu,  5 Jun 2025 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dNu4moM2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC091274FE5
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140644; cv=none; b=L/sePDGnZiW1c7pow9AGQxXTiaBIgXjmE/+hYFYqffz50T538keepP0vO/WzRoXi1rZnNkzLhAdW9SBb+fjX0tPCm3mRyiLX2xv7ldWtE8gCGIZGZHOtLRS80CZhfJIJH38BA8OcvVQEfrnorIQatqyNVqvsDt+9igWcSHBDJUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140644; c=relaxed/simple;
	bh=iZekbCBIoZm0/U/0LdTDy0Emrk1cv+V4x+AThp4JKgQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEQ60SY/JlkSdJBS7TmLJxTA5G/dQ6osWdzmAj+sf7XYLN9uqFYV7ghuaKxO305hSseUqo4Ou+kK6AAQEs0w71cYYtp1GxAnFdmWUVTWVza+lZibol06OsqBbEiyXZhKAMI/PMrJvPMfwWRn79VSV5KKSXO11NI55K2iMkzZk/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=dNu4moM2; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555DwHQd004144
	for <linux-btrfs@vger.kernel.org>; Thu, 5 Jun 2025 09:24:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=s
	e65dXZaTQUWO1fDub7tYETkx4tbDREUsm8POj4mjAI=; b=dNu4moM2MH5PMlyW9
	iqtI4QXn+dhnc+NtyFc2w8E29h5kfpVpmEpCMAqGIMyjAIBO80Z2HfBhf2/TqTyY
	7l9i2+8QRlg5XDTw5f1JVuG6fLRoCjZ6PVZMEmXihTv/5E/gY5IE4MjG3/t98X+5
	otdoxzjFVOd99s4wq3CogFz4hQ=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4730cpw1g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 09:24:01 -0700 (PDT)
Received: from twshared9216.15.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 5 Jun 2025 16:24:00 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 7C5CEFEC2E74; Thu,  5 Jun 2025 17:23:48 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 11/12] btrfs: move existing remaps before relocating block group
Date: Thu, 5 Jun 2025 17:23:41 +0100
Message-ID: <20250605162345.2561026-12-maharmstone@fb.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250605162345.2561026-1-maharmstone@fb.com>
References: <20250605162345.2561026-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE0NCBTYWx0ZWRfX7Ho4hVghvZ7m j0BRyrHKYLHRuY8UqpeC4AG07FqTnkZ9BHZfS+cKN8legNvz8BJegMeXcvN2JBd29TMgdBZS94X iMOCDzqJoLPaxzEVtwEK3c69ORkrKEtdaTyDv8T7ak9aQuBrXQfDSAsXStYwBRGzd7iO/c5d/EW
 k2GpAlHhIodg/Oogu8TM3KuxR20lQ8AMTJ0boyaiOfTEhmlBD3JCQ9WVuZb262vlgLqitzgheeQ r7mSN6BbJ8uBOYYPLqRBJHqanNk1BCcvUNZ0taZUR1iud5jf38JOgG7ID8LD8HSTgW/ALBL05I4 DsmD1Dde/c+gIBpebyz9fkyKfvLuAZK5/8n7Es7Q6i9iD+AoZGtlA8bD6qssM/nH7nrkW3puBj5
 sV8WmkDz7wHq5b4o/DJW4jQ2hjVFRnI7CZN8hys1sT3XqMVH5rtyNgG3jiUFemxVBwecwVBN
X-Proofpoint-GUID: 7dGn5stOWrov2N8_w8UhADNAimJ56T5T
X-Proofpoint-ORIG-GUID: 7dGn5stOWrov2N8_w8UhADNAimJ56T5T
X-Authority-Analysis: v=2.4 cv=K9wiHzWI c=1 sm=1 tr=0 ts=6841c4a1 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=FOH2dFAWAAAA:8 a=OVu6f6mAla1ufJqcYWYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01

If when relocating a block group we find that `remap_bytes` > 0 in its
block group item, that means that it has been the destination block
group for another that has been remapped.

We need to seach the remap tree for any remap backrefs within this
range, and move the data to a third block group. This is because
otherwise btrfs_translate_remap() could end up following an unbounded
chain of remaps, which would only get worse over time.

We only relocate one block group at a time, so `remap_bytes` will only
ever go down while we are doing this. Once we're finished we set the
REMAPPED flag on the block group, which will permanently prevent any
other data from being moved to within it.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/extent-tree.c |   6 +-
 fs/btrfs/relocation.c  | 482 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 486 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 995784cdca9d..e469261f6c8d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4490,7 +4490,8 @@ static noinline int find_free_extent(struct btrfs_r=
oot *root,
 		    block_group->cached !=3D BTRFS_CACHE_NO) {
 			down_read(&space_info->groups_sem);
 			if (list_empty(&block_group->list) ||
-			    block_group->ro) {
+			    block_group->ro ||
+			    block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED) {
 				/*
 				 * someone is removing this block group,
 				 * we can't jump into the have_block_group
@@ -4524,7 +4525,8 @@ static noinline int find_free_extent(struct btrfs_r=
oot *root,
=20
 		ffe_ctl->hinted =3D false;
 		/* If the block group is read-only, we can skip it entirely. */
-		if (unlikely(block_group->ro)) {
+		if (unlikely(block_group->ro) ||
+		    block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED) {
 			if (ffe_ctl->for_treelog)
 				btrfs_clear_treelog_bg(block_group);
 			if (ffe_ctl->for_data_reloc)
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index acf2fefedc96..d7aad3f92224 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4015,6 +4015,480 @@ static void adjust_block_group_remap_bytes(struct=
 btrfs_trans_handle *trans,
 		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
 }
=20
+struct reloc_io_private {
+	struct completion done;
+	refcount_t pending_refs;
+	blk_status_t status;
+};
+
+static void reloc_endio(struct btrfs_bio *bbio)
+{
+	struct reloc_io_private *priv =3D bbio->private;
+
+	if (bbio->bio.bi_status)
+		WRITE_ONCE(priv->status, bbio->bio.bi_status);
+
+	if (refcount_dec_and_test(&priv->pending_refs))
+		complete(&priv->done);
+
+	bio_put(&bbio->bio);
+}
+
+static int copy_remapped_data_io(struct btrfs_fs_info *fs_info,
+				 struct reloc_io_private *priv,
+				 struct page **pages, u64 addr, u64 length,
+				 bool do_write)
+{
+	struct btrfs_bio *bbio;
+	unsigned long i =3D 0;
+	int op =3D do_write ? REQ_OP_WRITE : REQ_OP_READ;
+
+	init_completion(&priv->done);
+	refcount_set(&priv->pending_refs, 1);
+	priv->status =3D 0;
+
+	bbio =3D btrfs_bio_alloc(BIO_MAX_VECS, op, fs_info, reloc_endio,
+			       priv);
+	bbio->bio.bi_iter.bi_sector =3D addr >> SECTOR_SHIFT;
+
+	do {
+		size_t bytes =3D min_t(u64, length, PAGE_SIZE);
+
+		if (bio_add_page(&bbio->bio, pages[i], bytes, 0) < bytes) {
+			refcount_inc(&priv->pending_refs);
+			btrfs_submit_bbio(bbio, 0);
+
+			bbio =3D btrfs_bio_alloc(BIO_MAX_VECS, op, fs_info,
+					       reloc_endio, priv);
+			bbio->bio.bi_iter.bi_sector =3D addr >> SECTOR_SHIFT;
+			continue;
+		}
+
+		i++;
+		addr +=3D bytes;
+		length -=3D bytes;
+	} while (length);
+
+	refcount_inc(&priv->pending_refs);
+	btrfs_submit_bbio(bbio, 0);
+
+	if (!refcount_dec_and_test(&priv->pending_refs))
+		wait_for_completion_io(&priv->done);
+
+	return blk_status_to_errno(READ_ONCE(priv->status));
+}
+
+static int copy_remapped_data(struct btrfs_fs_info *fs_info, u64 old_add=
r,
+			      u64 new_addr, u64 length)
+{
+	int ret;
+	struct page **pages;
+	unsigned int nr_pages;
+	struct reloc_io_private priv;
+
+	nr_pages =3D DIV_ROUND_UP(length, PAGE_SIZE);
+	pages =3D kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
+	if (!pages)
+		return -ENOMEM;
+	ret =3D btrfs_alloc_page_array(nr_pages, pages, 0);
+	if (ret) {
+		ret =3D -ENOMEM;
+		goto end;
+	}
+
+	ret =3D copy_remapped_data_io(fs_info, &priv, pages, old_addr, length,
+				    false);
+	if (ret)
+		goto end;
+
+	ret =3D copy_remapped_data_io(fs_info, &priv, pages, new_addr, length,
+				    true);
+
+end:
+	for (unsigned int i =3D 0; i < nr_pages; i++) {
+		if (pages[i])
+			__free_page(pages[i]);
+	}
+	kfree(pages);
+
+	return ret;
+}
+
+static int do_copy(struct btrfs_fs_info *fs_info, u64 old_addr, u64 new_=
addr,
+		   u64 length)
+{
+	int ret;
+
+	/* Copy 1MB at a time, to avoid using too much memory. */
+
+	do {
+		u64 to_copy =3D min_t(u64, length, SZ_1M);
+
+		ret =3D copy_remapped_data(fs_info, old_addr, new_addr,
+					 to_copy);
+		if (ret)
+			return ret;
+
+		if (to_copy =3D=3D length)
+			break;
+
+		old_addr +=3D to_copy;
+		new_addr +=3D to_copy;
+		length -=3D to_copy;
+	} while (true);
+
+	return 0;
+}
+
+static int add_remap_item(struct btrfs_trans_handle *trans,
+			  struct btrfs_path *path, u64 new_addr, u64 length,
+			  u64 old_addr)
+{
+	struct btrfs_fs_info *fs_info =3D trans->fs_info;
+	struct btrfs_remap remap;
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	int ret;
+
+	key.objectid =3D old_addr;
+	key.type =3D BTRFS_REMAP_KEY;
+	key.offset =3D length;
+
+	ret =3D btrfs_insert_empty_item(trans, fs_info->remap_root, path,
+				      &key, sizeof(struct btrfs_remap));
+	if (ret)
+		return ret;
+
+	leaf =3D path->nodes[0];
+
+	btrfs_set_stack_remap_address(&remap, new_addr);
+
+	write_extent_buffer(leaf, &remap,
+			    btrfs_item_ptr_offset(leaf, path->slots[0]),
+			    sizeof(struct btrfs_remap));
+
+	btrfs_release_path(path);
+
+	return 0;
+}
+
+static int add_remap_backref_item(struct btrfs_trans_handle *trans,
+				  struct btrfs_path *path, u64 new_addr,
+				  u64 length, u64 old_addr)
+{
+	struct btrfs_fs_info *fs_info =3D trans->fs_info;
+	struct btrfs_remap remap;
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	int ret;
+
+	key.objectid =3D new_addr;
+	key.type =3D BTRFS_REMAP_BACKREF_KEY;
+	key.offset =3D length;
+
+	ret =3D btrfs_insert_empty_item(trans, fs_info->remap_root,
+				      path, &key, sizeof(struct btrfs_remap));
+	if (ret)
+		return ret;
+
+	leaf =3D path->nodes[0];
+
+	btrfs_set_stack_remap_address(&remap, old_addr);
+
+	write_extent_buffer(leaf, &remap,
+			    btrfs_item_ptr_offset(leaf, path->slots[0]),
+			    sizeof(struct btrfs_remap));
+
+	btrfs_release_path(path);
+
+	return 0;
+}
+
+static int move_existing_remap(struct btrfs_fs_info *fs_info,
+			       struct btrfs_path *path,
+			       struct btrfs_block_group *bg, u64 new_addr,
+			       u64 length, u64 old_addr)
+{
+	struct btrfs_trans_handle *trans;
+	struct extent_buffer *leaf;
+	struct btrfs_remap *remap_ptr, remap;
+	struct btrfs_key key, ins;
+	u64 dest_addr, dest_length, min_size;
+	struct btrfs_block_group *dest_bg;
+	int ret;
+	bool is_data =3D bg->flags & BTRFS_BLOCK_GROUP_DATA;
+	struct btrfs_space_info *sinfo =3D bg->space_info;
+	bool mutex_taken =3D false, bg_needs_free_space;
+
+	spin_lock(&sinfo->lock);
+	btrfs_space_info_update_bytes_may_use(sinfo, length);
+	spin_unlock(&sinfo->lock);
+
+	if (is_data)
+		min_size =3D fs_info->sectorsize;
+	else
+		min_size =3D fs_info->nodesize;
+
+	ret =3D btrfs_reserve_extent(fs_info->fs_root, length, length, min_size=
,
+				   0, 0, &ins, is_data, false);
+	if (ret) {
+		spin_lock(&sinfo->lock);
+		btrfs_space_info_update_bytes_may_use(sinfo, -length);
+		spin_unlock(&sinfo->lock);
+		return ret;
+	}
+
+	dest_addr =3D ins.objectid;
+	dest_length =3D ins.offset;
+
+	if (!is_data && !IS_ALIGNED(dest_length, fs_info->nodesize)) {
+		u64 new_length =3D ALIGN_DOWN(dest_length, fs_info->nodesize);
+
+		btrfs_free_reserved_extent(fs_info, dest_addr + new_length,
+					   dest_length - new_length, 0);
+
+		dest_length =3D new_length;
+	}
+
+	trans =3D btrfs_join_transaction(fs_info->remap_root);
+	if (IS_ERR(trans)) {
+		ret =3D PTR_ERR(trans);
+		trans =3D NULL;
+		goto end;
+	}
+
+	mutex_lock(&fs_info->remap_mutex);
+	mutex_taken =3D true;
+
+	/* Find old remap entry. */
+
+	key.objectid =3D old_addr;
+	key.type =3D BTRFS_REMAP_KEY;
+	key.offset =3D length;
+
+	ret =3D btrfs_search_slot(trans, fs_info->remap_root, &key,
+				path, 0, 1);
+	if (ret =3D=3D 1) {
+		/*
+		 * Not a problem if the remap entry wasn't found: that means
+		 * that another transaction has deallocated the data.
+		 * move_existing_remaps() loops until the BG contains no
+		 * remaps, so we can just return 0 in this case.
+		 */
+		btrfs_release_path(path);
+		ret =3D 0;
+		goto end;
+	} else if (ret) {
+		goto end;
+	}
+
+	ret =3D do_copy(fs_info, new_addr, dest_addr, dest_length);
+	if (ret)
+		goto end;
+
+	/* Change data of old remap entry. */
+
+	leaf =3D path->nodes[0];
+
+	remap_ptr =3D btrfs_item_ptr(leaf, path->slots[0], struct btrfs_remap);
+	btrfs_set_remap_address(leaf, remap_ptr, dest_addr);
+
+	btrfs_mark_buffer_dirty(trans, leaf);
+
+	if (dest_length !=3D length) {
+		key.offset =3D dest_length;
+		btrfs_set_item_key_safe(trans, path, &key);
+	}
+
+	btrfs_release_path(path);
+
+	if (dest_length !=3D length) {
+		/* Add remap item for remainder. */
+
+		ret =3D add_remap_item(trans, path, new_addr + dest_length,
+				     length - dest_length,
+				     old_addr + dest_length);
+		if (ret)
+			goto end;
+	}
+
+	/* Change or remove old backref. */
+
+	key.objectid =3D new_addr;
+	key.type =3D BTRFS_REMAP_BACKREF_KEY;
+	key.offset =3D length;
+
+	ret =3D btrfs_search_slot(trans, fs_info->remap_root, &key,
+				path, -1, 1);
+	if (ret) {
+		if (ret =3D=3D 1) {
+			btrfs_release_path(path);
+			ret =3D -ENOENT;
+		}
+		goto end;
+	}
+
+	leaf =3D path->nodes[0];
+
+	if (dest_length =3D=3D length) {
+		ret =3D btrfs_del_item(trans, fs_info->remap_root, path);
+		if (ret) {
+			btrfs_release_path(path);
+			goto end;
+		}
+	} else {
+		key.objectid +=3D dest_length;
+		key.offset -=3D dest_length;
+		btrfs_set_item_key_safe(trans, path, &key);
+
+		btrfs_set_stack_remap_address(&remap, old_addr + dest_length);
+
+		write_extent_buffer(leaf, &remap,
+				    btrfs_item_ptr_offset(leaf, path->slots[0]),
+				    sizeof(struct btrfs_remap));
+	}
+
+	btrfs_release_path(path);
+
+	/* Add new backref. */
+
+	ret =3D add_remap_backref_item(trans, path, dest_addr, dest_length,
+				     old_addr);
+	if (ret)
+		goto end;
+
+	adjust_block_group_remap_bytes(trans, bg, -dest_length);
+
+	ret =3D add_to_free_space_tree(trans, new_addr, dest_length);
+	if (ret)
+		goto end;
+
+	dest_bg =3D btrfs_lookup_block_group(fs_info, dest_addr);
+
+	adjust_block_group_remap_bytes(trans, dest_bg, dest_length);
+
+	mutex_lock(&dest_bg->free_space_lock);
+	bg_needs_free_space =3D test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
+				       &dest_bg->runtime_flags);
+	mutex_unlock(&dest_bg->free_space_lock);
+	btrfs_put_block_group(dest_bg);
+
+	if (bg_needs_free_space) {
+		ret =3D add_block_group_free_space(trans, dest_bg);
+		if (ret)
+			goto end;
+	}
+
+	ret =3D remove_from_free_space_tree(trans, dest_addr, dest_length);
+	if (ret) {
+		remove_from_free_space_tree(trans, new_addr, dest_length);
+		goto end;
+	}
+
+	ret =3D 0;
+
+end:
+	if (mutex_taken)
+		mutex_unlock(&fs_info->remap_mutex);
+
+	btrfs_dec_block_group_reservations(fs_info, dest_addr);
+
+	if (ret) {
+		btrfs_free_reserved_extent(fs_info, dest_addr, dest_length, 0);
+
+		if (trans) {
+			btrfs_abort_transaction(trans, ret);
+			btrfs_end_transaction(trans);
+		}
+	} else {
+		dest_bg =3D btrfs_lookup_block_group(fs_info, dest_addr);
+		btrfs_free_reserved_bytes(dest_bg, dest_length, 0);
+		btrfs_put_block_group(dest_bg);
+
+		ret =3D btrfs_commit_transaction(trans);
+	}
+
+	return ret;
+}
+
+static int move_existing_remaps(struct btrfs_fs_info *fs_info,
+				struct btrfs_block_group *bg,
+				struct btrfs_path *path)
+{
+	int ret;
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	struct btrfs_remap *remap;
+	u64 old_addr;
+
+	/* Look for backrefs in remap tree. */
+
+	while (bg->remap_bytes > 0) {
+		key.objectid =3D bg->start;
+		key.type =3D BTRFS_REMAP_BACKREF_KEY;
+		key.offset =3D 0;
+
+		ret =3D btrfs_search_slot(NULL, fs_info->remap_root, &key, path,
+					0, 0);
+		if (ret < 0)
+			return ret;
+
+		leaf =3D path->nodes[0];
+
+		if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
+			ret =3D btrfs_next_leaf(fs_info->remap_root, path);
+			if (ret < 0) {
+				btrfs_release_path(path);
+				return ret;
+			}
+
+			if (ret) {
+				btrfs_release_path(path);
+				break;
+			}
+
+			leaf =3D path->nodes[0];
+		}
+
+		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+
+		if (key.type !=3D BTRFS_REMAP_BACKREF_KEY) {
+			path->slots[0]++;
+
+			if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
+				ret =3D btrfs_next_leaf(fs_info->remap_root, path);
+				if (ret < 0) {
+					btrfs_release_path(path);
+					return ret;
+				}
+
+				if (ret) {
+					btrfs_release_path(path);
+					break;
+				}
+
+				leaf =3D path->nodes[0];
+			}
+		}
+
+		remap =3D btrfs_item_ptr(leaf, path->slots[0],
+				       struct btrfs_remap);
+
+		old_addr =3D btrfs_remap_address(leaf, remap);
+
+		btrfs_release_path(path);
+
+		ret =3D move_existing_remap(fs_info, path, bg, key.objectid,
+					  key.offset, old_addr);
+		if (ret)
+			return ret;
+	}
+
+	BUG_ON(bg->remap_bytes > 0);
+
+	return 0;
+}
+
 static int create_remap_tree_entries(struct btrfs_trans_handle *trans,
 				     struct btrfs_path *path,
 				     struct btrfs_block_group *bg)
@@ -4636,6 +5110,14 @@ int btrfs_relocate_block_group(struct btrfs_fs_inf=
o *fs_info, u64 group_start,
 	WARN_ON(ret && ret !=3D -EAGAIN);
=20
 	if (*using_remap_tree) {
+		if (bg->remap_bytes !=3D 0) {
+			ret =3D move_existing_remaps(fs_info, bg, path);
+			if (ret) {
+				err =3D ret;
+				goto out;
+			}
+		}
+
 		err =3D start_block_group_remapping(fs_info, path, bg);
=20
 		goto out;
--=20
2.49.0


