Return-Path: <linux-btrfs+bounces-2081-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043EA847D0D
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Feb 2024 00:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917D11F24A90
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 23:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5325012F369;
	Fri,  2 Feb 2024 23:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="VS35667T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CfDEEt80"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1C12D779
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706915473; cv=none; b=idxpWKp+bfdKNb8s+gle9oastoQJDwF65oyIJguyyRhC9Tjr7o+MzvO1iaegL2kQoEL9i6WnjxgrSqQv2APdee9wVV8vpvpX0GRKo4LNINSiHGQx/yUd5T5KR5SBHZMw1ZUZFe5ngfNoXlPOzc+5yG+5fhZ7PfX7Ps58hSCSJG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706915473; c=relaxed/simple;
	bh=RRFp1wdAzsV8MwFV+pHvrHQ1qzhaSBepTrROcOJ2iB8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7A/HlG/EgCFbhndZCGnOX685vrjZ1mDe27zTqtTUCTBQa/34ehflcLQ4VgkY1Trie1Yei58Jh5ykYce1mOqyfXbMIhOuxjrInsifD/aC9i3ucVMmmbfgdJdi/SFWiuHHTMEc52PMO+F/VMmCuk9SwxQG8WknasA5kw64xCHYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=VS35667T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CfDEEt80; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 633EE32004AE;
	Fri,  2 Feb 2024 18:11:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 02 Feb 2024 18:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1706915469; x=
	1707001869; bh=OKjvy2r1eZ/rVlfeeKzqtmCoxVKBsPtDopcT9hC1t6w=; b=V
	S35667Td6x7L/yKAWqRGAqveAFiSVdoQHy6zX6zJHVVJYZ20mIGRy8nguf4aS/7x
	6PmYDEqBcfTcL5U91fL2GqbHd1blXZMXK0hSDoLxW3eOiwghTpB0Quljcm3JtcGT
	6ikciloD/5HvpTTzaIAaFc0gngcGddaNNqPv2ZrfOpdD7NHTlTatDHUDd7IjmK7s
	yRBNINiSRiu/5ku2NyzHgtMowF17TAI9y79NA7SKlfSLKLY6toDIL5gjH+ByV63c
	aMGjOjI0nS20tZ/4ie2KVkUV+fUfWvXvQf6+PoZHbWlzCiWIg149CMtn3OLTdlOr
	nsAoO8rhn0Yy2FY08DHig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1706915469; x=1707001869; bh=OKjvy2r1eZ/rV
	lfeeKzqtmCoxVKBsPtDopcT9hC1t6w=; b=CfDEEt80JId3/s3v07sD0o62R4oYD
	jqCiuFd1E/cQgfxxQgCm8Il5fX3WBOZ9qr7W80VuMW9Kq0gaDqIynf1miUwmuh3U
	eEetKfvVLzSYE8MJzpHR52ckC6kmciv0yrzbzrpIBxVOvmYED67Uoe2FRWzWejIk
	6S28uUW6c2Nr2MGEVnMbMlo6+2FYicJgrAfHAJyXweMcy7j9taUVmJ8kHobGbVn/
	LHQhJRzLoU3ST7Lu40cgTAWq3WnAvBbs8Sa0QFHQ5XDbq+xHlm6eCUXci69AyDdx
	SJJ/Cs1fD59PIzyUjGDmBZaJJbUqMUdCZ52/DH4ypXwnmQk3BQSJVhSCw==
X-ME-Sender: <xms:jXa9ZVUYs-V5j11RMtBjkWRCy-9E3kY7AMbpERPdB3G8I9OdhS4VUA>
    <xme:jXa9ZVnWbyGqPEi_Xuup60ZSSamGHIe8HD2Dk5CYTHEeIPd3lkEiJyTURwFwhlV7a
    Q7sYDEbjiKoqGvHeZc>
X-ME-Received: <xmr:jXa9ZRaSnnYoI7HkAA7aXEMzX8oA5FCLG6J_2ZX9RSrjbv3U8fG1-2QVuJXKf8VvNRCWdf2IBOMBbARTA-A04mjrqOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:jXa9ZYVj7_2zOeCy7C5H6qSXDB4qlUBRTy04kKs-86CfWDxwKCUWUg>
    <xmx:jXa9ZfmhNoP8vfJ1MyOUhV0qDFdumDdIhFfHaEDMIvmNon-3QPerDw>
    <xmx:jXa9ZVdJO7Sxp131jhMSyMKC9x5H20yJUAykWahYyX9v_rT4MAv_9A>
    <xmx:jXa9Zeubp7Zz74TPjCBzDm0rR4CvPPFEFN9aozng_yM54BM1pLYxIw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 18:11:09 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/6] btrfs: store fs_info on space_info
Date: Fri,  2 Feb 2024 15:12:44 -0800
Message-ID: <766679bb8556bdc9aec4e3e2557965348cfab833.1706914865.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706914865.git.boris@bur.io>
References: <cover.1706914865.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is handy when computing space_info dynamic reclaim thresholds where
we do not have access to a block group. We could add it to the various
functions as a parameter, but it seems reasonable for space_info to have
an fs_info pointer.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/space-info.c | 1 +
 fs/btrfs/space-info.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 571bb13587d5..f4a1e6341ca6 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -233,6 +233,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 	if (!space_info)
 		return -ENOMEM;
 
+	space_info->fs_info = info;
 	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
 		INIT_LIST_HEAD(&space_info->block_groups[i]);
 	init_rwsem(&space_info->groups_sem);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index da3e68612d5c..1cc4ef8dca38 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -85,6 +85,7 @@ enum btrfs_flush_state {
 };
 
 struct btrfs_space_info {
+	struct btrfs_fs_info *fs_info;
 	spinlock_t lock;
 
 	u64 total_bytes;	/* total bytes in the space,
-- 
2.43.0


