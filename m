Return-Path: <linux-btrfs+bounces-13405-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0188A9BA34
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 23:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA711B64E20
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 21:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09F028136E;
	Thu, 24 Apr 2025 21:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="XjQBXjG9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mnd5vz1Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3932F1B040B
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531676; cv=none; b=jElF298chI85ZbL8QGvUZVMPydmMyTFSNQTX1EpsyflkGAN+dcEilhk7PkCiT70x47cRtqvJJAiKMM67mH1gul7bImfx7Pxh9gU0nLtDo5GOK6/X91XfE/07zd/QuEluN0sKzlE5x87eV5RUkDjS566Zm8PtAuXKfEddhCJ3Eb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531676; c=relaxed/simple;
	bh=zSi3sXGG1LghAEb9F1tGCz+i4y70rcMA/2wvkRcW7Vc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=c+Efo1rjUHIgxYVxKnKVhLNHxlg+B5NRgOhOMmppycMEKT6Nc0L7meAfXc60k7OZE3MQjzh8EXv7q8IEmN3M8M56y7K1tn5YkimLqk+kWMR57HBDJzwb3HirqEzzvs82kJmhde6W4fJBpZZyXO1LGe3FGU8dTga8rZ3VqwFVeuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=XjQBXjG9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mnd5vz1Y; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 1739913801BC;
	Thu, 24 Apr 2025 17:54:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 24 Apr 2025 17:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1745531673; x=1745618073; bh=7HroRxyrtVY47XyYcvAjX
	uqUQdCk6DjYKB1PEFtHeGg=; b=XjQBXjG97Zlqg1/66u5pKQZ4vmD4ZLtyskUus
	KZg1yHGt64NktCfd7OECklOt6UaHM7a1hF9MpeHafsVorx+KG3mbCBqkzR1kWD4c
	mp0AvkCUs2hhKvF2qawgcXr7HGHIRIJzjjpqoSSHIUrYDZkm6wvtgXy5Z3gL48Qc
	VpySy+KrkYfLjjiwRIcHMZzqiunvo2QsVArMdB4E8nSgeo/6zTppb10eTQgmCIHy
	LfQFCgfkdsRdKy08NR3a49PxeDFI1ds688YuGbnqX1KqVztO6FKTE0FbtmgY7NF8
	mLU3Wjafm12DdDh1M3C54N9nqQIKh7d9gfJj3PB7aPkdaKZlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745531673; x=1745618073; bh=7HroRxyrtVY47XyYcvAjXuqUQdCk6DjYKB1
	PEFtHeGg=; b=mnd5vz1YyRzYGoz+Ede1fs9Pg/gIVDOVT8Go0MFw0Wia1HAC0Bw
	g9D1mIA0H3e2X6FJDVQRdQjv4zHAGjRye03HvWnVZ+3fCbM1d0bX2mrqjwZJ7CKZ
	QPOu/b02FcvWZxwaa3r5rGapJD28ECYYeoHQGml2R1gm041wpXEOQZJZx6ZC4Fd1
	Wtg8Byw2YmGu6aOyNzvI8kgAn5WSG1cFu2lMZDlCFU96HE6xyhKCSXn8USY2jv+9
	dw8MFizqXyuhFLs+udK6HVI3jTsJL6cQpP+2TiXXlU9zvGQ4weY8TyXxVPW89pQH
	P3ytoP1usAiV3VvddJ6xaKbCb3xsPw1SqNg==
X-ME-Sender: <xms:GLMKaMEorGM1qLg78kmmYcuorOL5179-WJpMG_1TUnxzmskb0Nu_gQ>
    <xme:GLMKaFXczFS_IAlYj3nj1alTrMIRwyyWtYvOmO9AH4che6qEtoUHQpw3dJiMvtE80
    rKYKrLOxHJ9fgsbr3E>
X-ME-Received: <xmr:GLMKaGKG6vQIY4Zng8r9KGXOUSeUAWLDKn_and8BAIBYkm1qJ5K2TpCxiDPTM86RCinsPjDszHFDDsK4bhBWV3rart4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedtiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceo
    sghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelff
    evleeifefgjeejieegkeduudetfeekffeftefhvdejveenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidq
    sghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlh
    dqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:GLMKaOGv0h9vVWSgjFgX1xApa4v_yO8dkLScQK0e2pK2U7VbGG6paQ>
    <xmx:GLMKaCXNaFTIWTqrgH__A0ehBmLBF0oJN8a4VsaE6niNTVx0b6OdHA>
    <xmx:GLMKaBMz8c1s_xE9lF8XXAj2O3cnn_vY6oJSDrw-Rm67gnF8En-boQ>
    <xmx:GLMKaJ1it2Wg7Z21MUTdSDAhSRti2mYVWdkndyh4oh43wrX0Q-7iyA>
    <xmx:GbMKaFll4bdvetBS-beppun7-Pb-8q8c-BLrjwfct4vMbfCal9MBesHs>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 17:54:32 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: fix folio leak in btrfs_clone_extent_buffer()
Date: Thu, 24 Apr 2025 14:55:29 -0700
Message-ID: <3a03310eda52461869be5711dc712f295c190b83.1745531701.git.boris@bur.io>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If btrfs_clone_extent_buffer() hits an error halfway through attaching
the folios, it will not call folio_put() on its folios.

Unify its error handling behavior with alloc_dummy_extent_buffer() under
a new function 'cleanup_extent_buffer_folios()'

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent_io.c | 55 ++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 152bf042eb0f..99f03cad997f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2829,6 +2829,22 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
 	return eb;
 }
 
+/*
+ * Detach folios and folio_put() them.
+ *
+ * For use in eb allocation error cleanup paths, as btrfs_release_extent_buffer()
+ * does not call folio_put().
+ */
+static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
+{
+	for (int i = 0; i < num_extent_folios(eb); i++) {
+		ASSERT(eb->folios[i]);
+		detach_extent_buffer_folio(eb, eb->folios[i]);
+		folio_put(eb->folios[i]);
+		eb->folios[i] = NULL;
+	}
+}
+
 struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 {
 	struct extent_buffer *new;
@@ -2846,26 +2862,30 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
 
 	ret = alloc_eb_folio_array(new, false);
-	if (ret) {
-		btrfs_release_extent_buffer(new);
-		return NULL;
-	}
+	if (ret)
+		goto release_eb;
 
 	for (int i = 0; i < num_extent_folios(src); i++) {
 		struct folio *folio = new->folios[i];
 
 		ret = attach_extent_buffer_folio(new, folio, NULL);
-		if (ret < 0) {
-			btrfs_release_extent_buffer(new);
-			return NULL;
-		}
+		if (ret < 0)
+			goto cleanup_folios;
 		WARN_ON(folio_test_dirty(folio));
-		folio_put(folio);
 	}
+	for (int i = 0; i < num_extent_folios(src); i++)
+		folio_put(new->folios[i]);
+
 	copy_extent_buffer_full(new, src);
 	set_extent_buffer_uptodate(new);
 
 	return new;
+
+cleanup_folios:
+	cleanup_extent_buffer_folios(new);
+release_eb:
+	btrfs_release_extent_buffer(new);
+	return NULL;
 }
 
 struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
@@ -2880,12 +2900,12 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 
 	ret = alloc_eb_folio_array(eb, false);
 	if (ret)
-		goto out;
+		goto release_eb;
 
 	for (int i = 0; i < num_extent_folios(eb); i++) {
 		ret = attach_extent_buffer_folio(eb, eb->folios[i], NULL);
 		if (ret < 0)
-			goto out_detach;
+			goto cleanup_folios;
 	}
 	for (int i = 0; i < num_extent_folios(eb); i++)
 		folio_put(eb->folios[i]);
@@ -2896,15 +2916,10 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 
 	return eb;
 
-out_detach:
-	for (int i = 0; i < num_extent_folios(eb); i++) {
-		if (eb->folios[i]) {
-			detach_extent_buffer_folio(eb, eb->folios[i]);
-			folio_put(eb->folios[i]);
-		}
-	}
-out:
-	kmem_cache_free(extent_buffer_cache, eb);
+cleanup_folios:
+	cleanup_extent_buffer_folios(eb);
+release_eb:
+	btrfs_release_extent_buffer(eb);
 	return NULL;
 }
 
-- 
2.49.0


