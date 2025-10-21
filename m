Return-Path: <linux-btrfs+bounces-18112-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF67DBF6628
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 14:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CEA5545A3E
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 12:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C15331A43;
	Tue, 21 Oct 2025 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVLv8JII"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60C12877C3
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048444; cv=none; b=KHUdcxn7mPD/iGRXktokThqxjsqe17rLv1v6xuDT90NK3rDmJ1ddKWjikmuETptQg9SRtIJfwyNvGMpEE+sDoJBt2Ut+/97XR9N2PuFm/YhQJrjk/NmKK2lyno4bI3zAapByHhFZAj6PcSQXMkPD+r2v3mTSC3LZw20ZZZrh22U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048444; c=relaxed/simple;
	bh=Bm/W+StXUFT+ttWFbQJl7Ln7OHRm+FOEm6nVju8/ttk=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=iGBUSk51e3iGtHNnYTQI80gkCUC5b2bguR8kCv6Zdd/Oge36VazaT6vFF6SRwcpVsbnG/DySoVAqVlCaMZ477VYuCjT20BLxTULiELbhGEWxvFKAi/hqU46n1RTkCbOS+wM80r1SZyVmbcOYKifZFTtDn8Xajbe4CRTyTu2BEuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVLv8JII; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-883902b96c3so549913185a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 05:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761048442; x=1761653242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UHJ36uQM4BVye2n0rKMF97O2VvnA9DN8xWFlKrecs64=;
        b=jVLv8JIIXDq7QhcX3AIMFwx2OteLfNFik8jgdFnAmIm5iKbSBAapv9b0tm/I7CF1+N
         7GSO5yV8j6k0GpWo3KTNRu1sJ0Qsr2cFYy5j3YFH5293rc4tvKNhsGOjmJ6MADCH5pWj
         p/S8h9n2M40fV76RnPbrFCg+L+fijcbYLSanyJZtEaBFbGZWKIf0trFgwuc42dj5mDr4
         kfhkHBC6gtwh/R7ST9HZyTpLaL6ODsPs8b2dlQSsNktCjM+BKROFgtn/tUxLSuM99yA5
         CNQdLkFeaeHTOCofASPuMyDsDnDOklRHx7HduOZfoixiNo2lj0ZEw+NokgRArVb0JerH
         sF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761048442; x=1761653242;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UHJ36uQM4BVye2n0rKMF97O2VvnA9DN8xWFlKrecs64=;
        b=O3WzAM8/ylzgIDMB7Yqu3InZyfp18LGm0OTdZROl64L0HI3LyoWZdHV91guK6DVikN
         MZ3rg9KOPTiJZhThu3JjZ0jKTuZVfngfkWTchIHnX/2XKg2t5X5BmN4n/ixDQepAFtkL
         Tf3U+YNYeSnGfTZk3I5vEU/xT7pKVcpDxNdklzLKN5Na19r9eAX1mcYJHsxuyHVt8piK
         kd9nyREBmPO4YiJ3J9pK7qkFQYlkd+XshCRPwalR0Xy/xjHc6QISUpvOZgFafoIe6IaC
         oSZFG4vnluvGXkt+vkJlcL/8bAXxOk3z7x7mgKQnWk107qCAxtSawQVBmaN6wEchHzN0
         aSFw==
X-Gm-Message-State: AOJu0Yyv6yjAJC4LHMLo8r+OTJnN4PyqJWqmOiYakBrPVhE0+RX0Dx2K
	X0OyKFuZ++6+qo5y7OACeUg4maoCoMVZEYgSZga0JIsWsG8+MHni8ZDKpreij/D+BWXCAXCpO8X
	Bb7WU2A8ShFYQTpunhDTTywxXrcptfIA=
X-Gm-Gg: ASbGnctR2Fxps11FpdZhRGBWsYGpdQP0iUJFtiEywYhr799ImQyMTy0H/KdeoTV5C3Y
	XoEmNndU6pcrmm4dXhMAHvYtBO31cADGDTtpRdIXw6Kg8yg49yx1MNIv25sdbNDCEv2iHBYqFIC
	PBQEPFSc+hixFAqk/Bj51UiX6ZUWJTjPfm6+8NDk3JTHxZyTt0f6OEo5F71u4T66q1IrhhD9r0L
	ZJfCscpHg/9srJ72fvfM3r2/2S9uiGDZdHLkXqhF8qwBSCElUExKrDiLA==
X-Google-Smtp-Source: AGHT+IFniqagYl059GJ4F0LH327CzdGmdoBLR8BN97FTS2ik4AEeLGWNALLr5XlbvFVagLt6oYzuHdBfT2zvGKtG+9M=
X-Received: by 2002:a05:620a:17a1:b0:892:7dd2:9f0f with SMTP id
 af79cd13be357-8927dd2a495mr1146935485a.19.1761048441705; Tue, 21 Oct 2025
 05:07:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Oct 2025 07:07:20 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Oct 2025 07:07:20 -0500
From: Amit Dhingra <mechanicalamit@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 Oct 2025 07:07:20 -0500
X-Gm-Features: AS18NWCwACwLpluCYEij6JfBz929toQrYWwcMAuq_j2Cw1No2YmWqnAa0KXuJQ8
Message-ID: <CAO=gReGBaUiodShe-Dmir=XVkjOoP0rdvx=BGP79URrZOOmNyA@mail.gmail.com>
Subject: [PATCH] fix IS_ERR() vs NULL Check in btrfs_build_ref_tree()
To: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

btrfs_extent_root()/btrfs_global_root() does not return error pointers,
it returns NULL on error.

Fixes : ed4e6b5d644c ("btrfs: ref-verify: handle damaged extent root tree")
Signed-off-by: Amit Dhingra <mechanicalamit@gmail.com>
---
Compile tested only
---
 fs/btrfs/ref-verify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index de4cb0f3fbd0..e9224145d754 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -982,7 +982,7 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)

 	extent_root = btrfs_extent_root(fs_info, 0);
 	/* If the extent tree is damaged we cannot ignore it (IGNOREBADROOTS). */
-	if (IS_ERR(extent_root)) {
+	if (!extent_root) {
 		btrfs_warn(fs_info, "ref-verify: extent tree not available, disabling");
 		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
 		return 0;
-- 
2.51.1

