Return-Path: <linux-btrfs+bounces-4615-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF83A8B59F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1C91F21025
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 13:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83581768EA;
	Mon, 29 Apr 2024 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="LrHoUBCz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615B5757F7
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397413; cv=none; b=Q0s1ptXSjg//+6DBPQAdJFUFX0OBrwawJMoE3v9jPi9qakW6S/ftHgHG8aCAmTLdyQypaqUf0xGFBzQecn0nAT2j5eGY0dyfGONNrTmKyf3VLTnIc8loimd1WD/sfdAoUXzq4PCUWZgF6mOcUxnY/XhtQy40qtT+6jdM4gXTVhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397413; c=relaxed/simple;
	bh=EaB+RUTdgSiqs5x+5ne+kMGtxbi7ZStAqoIE9SmIM4g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVNoEzoZvd/MVd0/PqMocTE0l7x1n9yFKy57AuHiumFnPM5DgZaNgbazCoC0zyEWKyYF3gRDdkpr+gpQJPhRZKeoB5tV6aE01X9hdcVDwfxjofi6befZ9i9F6okoLFWMEHvQ0IFMzXnjttdcSgYVb82iV9o5+9mHUX+DFI+Xtys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=LrHoUBCz; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-434b7ab085fso43154531cf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 06:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1714397411; x=1715002211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFLER60IxPaUEqjPDPDJO+7MMXBMEQv9Z+urIwL64kA=;
        b=LrHoUBCzWSZg3cQTEPBgZEVFpZxcCJuxSDSoufX2i9Zzv1VCjwaPzylFCXn0PXzpgv
         4EzTc3WL6J5EtnBX3NQ6IpyDBuFeN/yyi/fYX7JCYJx54jlb8Sw7H3SGvlmzFpgzWcrm
         lJv/7C9i1lGeQTCgkwCqneYRnV9kYmasCouapH91hDMoayCUL88Vr7ia508TchYrz8QL
         4pZiwP1Ib/EIasKDnyjjilvdOIEG2fwtYt2l/+ck9vCIFIWmI7Q+OiCSAe97xnkXhOzC
         wU/aOghyvR/6iTiQQgFxwkCH0yBx7Pa6sQ7z4KcikNhyUntBJDZ/hLddQEtpXGLvR+uw
         J9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397411; x=1715002211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFLER60IxPaUEqjPDPDJO+7MMXBMEQv9Z+urIwL64kA=;
        b=aAxNebL+1SGbK5h0GPHavW7UNIvTAhhp8YyrW4ahPYH++1GTggXxAnAvVBV6aEByq1
         Z1sJuCtpAWoQoIP1VN79XreIpxi52vnK4zIlk6xlZcIaPDl/+7VgyI/LhdmzeC1w/wqc
         AOOe6kBXOoC1Mo9k2hKE7MMpXpkqIeyycBDd1XMzjyJpRn2//Wd5QXCLqRkazbNjjXPH
         OQspX3zoi9+lsXD0SkGxceu2Aur+BDUts96t0HpfNa0E4JzDOOMko29FqBVmOMQlrZHS
         shw3ccMnXyVQ8YllCMytBPadZEmm5lILCr2Bl9505btDylo7BTm0UAjFih3tC/ypx0V0
         uoXw==
X-Gm-Message-State: AOJu0YxFzT9jkyKs8WAjlnls0FsVqyVsnIjE6MA+Q/svnbCLgcA8cN80
	ZUfCXLgkuKMj7CU5F7RBDsM/dKrE/HDy9gof1DRRgMSdsObW/N/70ZXVwEo+myHcwgp95LXNLun
	Y
X-Google-Smtp-Source: AGHT+IFb9blO9hCgOKqMt3FY5512LLSQ5nTYoI9N4n1njO29r10jaCKztdAxFx9WlPKC6VF6JtR1ag==
X-Received: by 2002:a05:622a:5b06:b0:43b:16d1:a6ee with SMTP id ea6-20020a05622a5b0600b0043b16d1a6eemr583799qtb.17.1714397411195;
        Mon, 29 Apr 2024 06:30:11 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id l23-20020ac848d7000000b004372459413fsm10322184qtr.93.2024.04.29.06.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:30:10 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 12/15] btrfs: clean up our handling of refs == 0 in snapshot delete
Date: Mon, 29 Apr 2024 09:29:47 -0400
Message-ID: <3a191c918331eab2e7c47a3453f1ec0b8f5b5afe.1714397223.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714397222.git.josef@toxicpanda.com>
References: <cover.1714397222.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In reada we BUG_ON(refs == 0), which could be unkind since we aren't
holding a lock on the extent leaf and thus could get a transient
incorrect answer.  In walk_down_proc we also BUG_ON(refs == 0), which
could happen if we have extent tree corruption.  Change that to return
-EUCLEAN.  In do_walk_down() we catch this case and handle it correctly,
however we return -EIO, which -EUCLEAN is a more appropriate error code.
Finally in walk_up_proc we have the same BUG_ON(refs == 0), so convert
that to proper error handling.  Also adjust the error message so we can
actually do something with the information.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c75a5b3ddb8f..cbb99454a194 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5351,7 +5351,15 @@ static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
 		/* We don't care about errors in readahead. */
 		if (ret < 0)
 			continue;
-		BUG_ON(refs == 0);
+
+		/*
+		 * This could be racey, it's conceivable that we raced and end
+		 * up with a bogus refs count, if that's the case just skip, if
+		 * we are actually corrupt we will notice when we look up
+		 * everything again with our locks.
+		 */
+		if (refs == 0)
+			continue;
 
 		/* If we don't need to visit this node don't reada. */
 		if (!visit_node_for_delete(root, wc, eb, refs, flags, slot))
@@ -5400,7 +5408,12 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 					       NULL);
 		if (ret)
 			return ret;
-		BUG_ON(wc->refs[level] == 0);
+		if (unlikely(wc->refs[level] == 0)) {
+			btrfs_err(fs_info,
+				  "bytenr %llu has 0 references, expect > 0",
+				  eb->start);
+			return -EUCLEAN;
+		}
 	}
 
 	if (wc->stage == DROP_REFERENCE) {
@@ -5663,8 +5676,9 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		goto out_unlock;
 
 	if (unlikely(wc->refs[level - 1] == 0)) {
-		btrfs_err(fs_info, "Missing references.");
-		ret = -EIO;
+		btrfs_err(fs_info, "bytenr %llu has 0 references, expect > 0",
+			  bytenr);
+		ret = -EUCLEAN;
 		goto out_unlock;
 	}
 	wc->lookup_info = 0;
@@ -5775,7 +5789,12 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 				path->locks[level] = 0;
 				return ret;
 			}
-			BUG_ON(wc->refs[level] == 0);
+			if (unlikely(wc->refs[level] == 0)) {
+				btrfs_err(fs_info,
+					  "bytenr %llu has 0 references, expect > 0",
+					  eb->start);
+				return -EUCLEAN;
+			}
 			if (wc->refs[level] == 1) {
 				btrfs_tree_unlock_rw(eb, path->locks[level]);
 				path->locks[level] = 0;
-- 
2.43.0


