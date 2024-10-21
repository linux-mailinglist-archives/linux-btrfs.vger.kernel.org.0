Return-Path: <linux-btrfs+bounces-9038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8306C9A72F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 21:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB74EB224BB
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 19:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846AE1FBCBA;
	Mon, 21 Oct 2024 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="jgc+iFFq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kk10WHSq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6922209B
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537811; cv=none; b=ZAZtXS40XVQ+tPtcelzR0Jz7WDMU5mXIWyv4OIYBeTj6HSg8MK3k+8G0I/IFQ7fhPlBW6AM1S5sPnYG2qT9yz5zfDMfKIR6ci9/MiuI0mATt07f7lxUHVVoQXakmHUOfpJL7BmXb0SesxcLnCBhKMBEP8Ismz5ul8CXCqrFHXwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537811; c=relaxed/simple;
	bh=Zy/TWGeAVE+u/GAOaQ0qA99oVh1g7wB5l6hXYqBHTww=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GlhtIwVieJUidkcbX17UdZWGlVYWXfFgyTQzfxF6p+SaG94pI/yJvKNbs2nQHyp7CKkgSb7yHxxqoKxSHqxJuMTkRyBttYds7uA6ePFXDESIG4l5ioIHR2gXQiJQTmW6/6SyOlnCs8gyLGjWnHCpfr+Rvzv8tvl09t94qhyJULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=jgc+iFFq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kk10WHSq; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E000511402AC;
	Mon, 21 Oct 2024 15:10:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 21 Oct 2024 15:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1729537807; x=1729624207; bh=aHp5lsCnjOIlZ25hNlg9a
	mYcQ235Plq85UMiL+7PS6Y=; b=jgc+iFFquBpS1Tvrjsw0jTJeyXXSvO0Luvl3G
	KCLryH3g+YVxi0Nd1S/xeMDGeDYtfKYCBpVSCZlT35ojfcs+yXx4BgxL4f9HRt+o
	Ul6ViPMzuzek9n9fXcViVoJrEx7XB2Ch9Mnn1coDwN74kvFIRICZFN5xlMqd1/8T
	2IjGd8rgpmL3qJ8WAqHDerQYlSQc3JT6LQv2GznWWA67J9SQVcOMUP5hPLC89JrT
	oAuOz5EKmNGIhwBBtpOqYaG3kH8eYLrxIaM1oGuilo1wco7CC9Vrupp/9w5fSx3Z
	5Q8PSK905MSM3TCB/3JvD762yv8ZthcpO1PiXuVlAvdgrzkow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729537807; x=1729624207; bh=aHp5lsCnjOIlZ25hNlg9amYcQ235
	Plq85UMiL+7PS6Y=; b=Kk10WHSq3X4PHC0TrC+5pTQCWFtYOlEgq8Fc1q3g327t
	/zhLg73hgWXGWh6Jbuup19AKWM4/0SBNLm8HeTTFHvu+/THgA4XogfbRUeVHTprp
	tS+8eL+LXq8bcTBZCvtlynhbeAoSOD1O37OSCFIJwfs2H5CGfMKlbuFQ4nEUlBdh
	b8CGrzQDlylskrP6lVWJ3dvsP/vOQ/sjwPy/7HOYXd0QoNfn9MhDjW81fSJnrNlZ
	Bm5FO72JSAc+vd7xo17rV/eDhcrSatb4wEMciXKpw9QmcbdUmixKQUVoXYP7bSpO
	ZJ4EncXZWAWs2/VUUb5R3e2eLPW/6IJn9dG9hih/LQ==
X-ME-Sender: <xms:D6cWZ1QrkLShMB0lrOo8h68dR6PmiVJwt_aoSXVIUoXt_YGdd6fbPw>
    <xme:D6cWZ-wGtnnVrDOGaXlebJZFysIg7MNe-KiOZkiPDwp8CvpvWkvHEsnn97rW87H-u
    arGUU56iwUEjg6yzRg>
X-ME-Received: <xmr:D6cWZ61SqV2A_tUkaFbl3NY2qqAlLJR6fiCSAMVzvAeZ4-C1IwOFBYnFMGYtCKEsgf1xhaZGkRDgELqFjgCEV2H7MaY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegs
    ohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffve
    elieefgfejjeeigeekudduteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprh
    gtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgs
    thhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqd
    htvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:D6cWZ9ANv4MHsOy_DuKSHA8EwDJKd411IbdOkcCvos_hZ9glp5MrDg>
    <xmx:D6cWZ-iFxRazAO4NEAGUZJ-RFPJlqBVIclhLuPAvDw21xd83I_WPPA>
    <xmx:D6cWZxoQL0scvyJEMZiZV_U1w_sXryXExmDPd92govsGszQRvVbINQ>
    <xmx:D6cWZ5jIFiI2wFmOxnVJwMa1Pn87N1KsaQxXQiBjtI-rqPWwkFe_Xg>
    <xmx:D6cWZxto9My2M0ZEe9xzlE5JFHj93X9ljaEUXFJ_XEwTjIaTjoEIwFIo>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 15:10:07 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4] btrfs: fix read corruption due to race with extent map merging
Date: Mon, 21 Oct 2024 12:09:30 -0700
Message-ID: <9b98ba80e2cf32f6fb3b15dae9ee92507a9d59c7.1729537596.git.boris@bur.io>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In debugging some corrupt squashfs files, we observed symptoms of
corrupt page cache pages but correct on-disk contents. Further
investigation revealed that the exact symptom was a correct page
followed by an incorrect, duplicate, page. This got us thinking about
extent maps.

commit ac05ca913e9f ("Btrfs: fix race between using extent maps and merging them")
enforces a reference count on the primary `em` extent_map being merged,
as that one gets modified.

However, since,
commit 3d2ac9922465 ("btrfs: introduce new members for extent_map")
both 'em' and 'merge' get modified, which started modifying 'merge'
and thus introduced the same race.

We were able to reproduce this by looping the affected squashfs workload
in parallel on a bunch of separate btrfs-es while also dropping caches.
We are still working on a simple enough reproducer to make into an fstest.

The simplest fix is to stop modifying 'merge', which is not essential,
as it is dropped immediately after the merge. This behavior is simply
a consequence of the order of the two extent maps being important in
computing the new values. Modify merge_ondisk_extents to take prev and
next by const* and also take a third merged parameter that it puts the
results in. Note that this introduces the rather odd behavior of passing
'em' to merge_ondisk_extents as a const * and as a regular ptr.

Fixes: 3d2ac9922465 ("btrfs: introduce new members for extent_map")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
v4:
- make the subject clearer
v3:
- use correct const pointer
- update comment
v2:
- make 'merge' immutable instead of refcounting it
---
 fs/btrfs/extent_map.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index d58d6fc40da1..26101fb577f3 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -246,13 +246,19 @@ static bool mergeable_maps(const struct extent_map *prev, const struct extent_ma
 /*
  * Handle the on-disk data extents merge for @prev and @next.
  *
+ * @prev: left extent to merge
+ * @next: right extent to merge
+ * @merged: the extent we will not discard after the merge; updated with new values
+ *
+ * After this, one of the two extents is the new merged extent and the other is
+ * removed from the tree and likely freed. Note that @merged is one of @prev/@next
+ * so there is const/non-const aliasing occurring here.
+ *
  * Only touches disk_bytenr/disk_num_bytes/offset/ram_bytes.
  * For now only uncompressed regular extent can be merged.
- *
- * @prev and @next will be both updated to point to the new merged range.
- * Thus one of them should be removed by the caller.
  */
-static void merge_ondisk_extents(struct extent_map *prev, struct extent_map *next)
+static void merge_ondisk_extents(const struct extent_map *prev, const struct extent_map *next,
+				 struct extent_map *merged)
 {
 	u64 new_disk_bytenr;
 	u64 new_disk_num_bytes;
@@ -287,15 +293,10 @@ static void merge_ondisk_extents(struct extent_map *prev, struct extent_map *nex
 			     new_disk_bytenr;
 	new_offset = prev->disk_bytenr + prev->offset - new_disk_bytenr;
 
-	prev->disk_bytenr = new_disk_bytenr;
-	prev->disk_num_bytes = new_disk_num_bytes;
-	prev->ram_bytes = new_disk_num_bytes;
-	prev->offset = new_offset;
-
-	next->disk_bytenr = new_disk_bytenr;
-	next->disk_num_bytes = new_disk_num_bytes;
-	next->ram_bytes = new_disk_num_bytes;
-	next->offset = new_offset;
+	merged->disk_bytenr = new_disk_bytenr;
+	merged->disk_num_bytes = new_disk_num_bytes;
+	merged->ram_bytes = new_disk_num_bytes;
+	merged->offset = new_offset;
 }
 
 static void dump_extent_map(struct btrfs_fs_info *fs_info, const char *prefix,
@@ -363,7 +364,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 			em->generation = max(em->generation, merge->generation);
 
 			if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
-				merge_ondisk_extents(merge, em);
+				merge_ondisk_extents(merge, em, em);
 			em->flags |= EXTENT_FLAG_MERGED;
 
 			validate_extent_map(fs_info, em);
@@ -378,7 +379,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 	if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge)) {
 		em->len += merge->len;
 		if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
-			merge_ondisk_extents(em, merge);
+			merge_ondisk_extents(em, merge, em);
 		validate_extent_map(fs_info, em);
 		em->generation = max(em->generation, merge->generation);
 		em->flags |= EXTENT_FLAG_MERGED;
-- 
2.47.0


