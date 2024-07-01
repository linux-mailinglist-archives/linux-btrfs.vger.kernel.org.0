Return-Path: <linux-btrfs+bounces-6119-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265C091EB3E
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 01:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1271C214DA
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 23:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E7717108D;
	Mon,  1 Jul 2024 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ZqdfOgV4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CehcoH0o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3504779E
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719875099; cv=none; b=cvoaaUhBjLiCrKTEtBy2XFIfGz68ZiCCKNZtoq7anGqGJKFVgMAI3d9yIyJdq384RWJHiHUm5+ElOXyWAR87JJqmBM5idga9pRBNNfFpMAoObiO+mA+H7SvEzBQb1XabsC2y7nqx4Wovgur1FplVI3ynFapn3megRXElTETon30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719875099; c=relaxed/simple;
	bh=prxxvTTeqA6O0NSZwVvaVlRZlQZLQAz+YBQfrX9VhMg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=r3olFHrgK3tBn0FZQkqfcv+guZqo4+xhxQwa+KiF0zDRAlOhIyZUSxDIlFl+I8sXklSBsBbWUiFstkmfUR28n2Wbpi1HIrw0G27ch8KpJUx0bzvgFWM8i3aXcWb63SVGJSNLShz2nSpkqe7MTDYyeGuLToF+S75Dn2YuEDpEVlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ZqdfOgV4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CehcoH0o; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id E0C231380309;
	Mon,  1 Jul 2024 19:04:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 01 Jul 2024 19:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1719875095; x=1719961495; bh=SamxQWlMWWTcxalVdWPQB
	MBvTLIBj/SeU5jA/hbZXBk=; b=ZqdfOgV42LBSYlR9cSj55wrJdW+LSW9Am92Kz
	MZ25eKz28LKUWrmCdc/jfbUPQyEHgAr3Rg0sKWNx24qFPDiPym2V2clnMQanL53o
	YHSeve/DF6kEjzdWA0Gq6PtmQeCQi4kGt9CbZ6Xj7SS2Xg+G+gYdkTkYzu1wgbrb
	H1IvhPZEFgARtgcRDtORa3vT2Hnss9CKj7hrPGy9JeIQRb2E0VLHG6uAydCoFJ2x
	dmHJu8zicGFH1ABNqEiU+PoUf0XmlSEoEsaRk8OdcKolUNZGCnhytt5dtw1EVYhO
	Jl/cG3r9rFzBf0VkbD6NTseu86ehVcVL1HAfo5kbNR1PMGUJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719875095; x=1719961495; bh=SamxQWlMWWTcxalVdWPQBMBvTLIB
	j/SeU5jA/hbZXBk=; b=CehcoH0o/KKjGNgTAlTJYX7gOltEd0U4m70g4j0UUlOD
	DVgnPfsrkmBvJrfoq1eS23pJSrTDtw2gSTGK1GeDHUTVK/evYunMqYpUXdVgFeQ7
	AhHkkjvr9SnmeMazIJmtytrmeET+KSEXQtEdcZswBGXD0E9BFNOkK+AShbXlFgY3
	NcMrBHBUBJNDYXJZyje70hWTsdVaHxYJTq3mWzzX9mrf+VIAS7XiBEaF3Ng/eYhy
	Qi4q5D942XnwdckDLtxYYiEhTcq8ePRgOJt6xzFktHfifsn2gvbN6R1gPVD2d2Nu
	XY6LwWJevRoQs+5SF+8C658zTy26E0gMf37zQWhm1w==
X-ME-Sender: <xms:FzaDZnibTIwkR2ypAvxUTuawTKHdqjQls8gJdliJTYSVllWECrrhqA>
    <xme:FzaDZkAe4joJWYF3ZFVOONR0eR2Rj23RsygGbes3_C7-ngjcT9BE5j5Yx9QzCIxj6
    mpEwnFUgUjCkHriSvs>
X-ME-Received: <xmr:FzaDZnG51JMhhAIx_nBIxqMN3mEJuGTpZqOBcuS3ftq7Nw6f6p1KgKcxWpL8JhtweXmeeurCd4AqFGu-3AWbHHFGNyY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeggddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:FzaDZkTnPUdQMfE4d4ajtDVQdCKIJkSo7cw_ZeOK6sNNXeyaphZS0Q>
    <xmx:FzaDZkxUFlqbvQw3F_oFzX_9mx1k4e65XFwbty-5ZSiU1-PWIwcsJg>
    <xmx:FzaDZq7INIqw7u7VdD-h3250wXLQ4gjduJufUNhGNdtu3G5-CxzDAQ>
    <xmx:FzaDZpxXy5spHS4YwVVEtWsOQB83nlk21Hg19RXvaFPK7VQsIUiQyw>
    <xmx:FzaDZv8eA5spOyclEQpN1TOdrok39u8mjvMH4-zZUYnCGf0y0hdXoSo1>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jul 2024 19:04:55 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2] btrfs: fix __folio_put with folio refcount held
Date: Mon,  1 Jul 2024 16:04:02 -0700
Message-ID: <511fdb3b7fc4293159d4af8e62775c2c1eb95250.1719874991.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The conversion to folios switched __free_page to __folio_put in the
error path in btrfs_do_encoded_write and __alloc_dummy_extent_buffer.

However, this gets the page refcounting wrong. If we do hit that error
path (I reproduced by modifying btrfs_do_encoded_write to pretend to
always fail in a way that jumps to out_folios and running the xfstest
btrfs/281), then we always hit the following BUG freeing the folio:

BUG: Bad page state in process btrfs  pfn:40ab0b
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x61be5 pfn:0x40ab0b
 flags: 0x5ffff0000000000(node=0|zone=2|lastcpupid=0x1ffff)
raw: 05ffff0000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000061be5 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: nonzero _refcount
Call Trace:
<TASK>
dump_stack_lvl+0x3d/0xe0
bad_page+0xea/0xf0
free_unref_page+0x8e1/0x900
? __mem_cgroup_uncharge+0x69/0x90
__folio_put+0xe6/0x190
btrfs_do_encoded_write+0x445/0x780
? current_time+0x25/0xd0
btrfs_do_write_iter+0x2cc/0x4b0
btrfs_ioctl_encoded_write+0x2b6/0x340

It turns out __free_page dereferenced the page while __folio_put does
not. Switch __folio_put to folio_put which does dereference the folio
first.

Fixes: 400b172b8cdc ("btrfs: compression: migrate compression/decompression paths to folios")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog
v2:
- Fixed __folio_put in __alloc_dummy_extent_buffer as well

 fs/btrfs/extent_io.c | 2 +-
 fs/btrfs/inode.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d3ce07ab9692..cb315779af30 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2775,7 +2775,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 	for (int i = 0; i < num_folios; i++) {
 		if (eb->folios[i]) {
 			detach_extent_buffer_folio(eb, eb->folios[i]);
-			__folio_put(eb->folios[i]);
+			folio_put(eb->folios[i]);
 		}
 	}
 	__free_extent_buffer(eb);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0a11d309ee89..12fb7e8056a1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9558,7 +9558,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 out_folios:
 	for (i = 0; i < nr_folios; i++) {
 		if (folios[i])
-			__folio_put(folios[i]);
+			folio_put(folios[i]);
 	}
 	kvfree(folios);
 out:
-- 
2.45.2


