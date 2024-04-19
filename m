Return-Path: <linux-btrfs+bounces-4450-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D448AB4F9
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 20:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770AC1C222CA
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8658213CFBD;
	Fri, 19 Apr 2024 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ne0+DCzJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6860213C9B7
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550651; cv=none; b=cC6o8B79Vej3QzJmjUJWMNyVSd/m2sBGQPJf3qMZqPTYKyyYsoeMqwofx43i7YIii1voWgAiluCCRDwda7lmI3UEZUYhMsvaIVueBW5PcXhtmX8sUvhNpxC07j3Owjs9+MH+JIv2eiSqpL4Y+OdpKJnSfzioyP4j0Pn+vhdW+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550651; c=relaxed/simple;
	bh=w9YYDmwT2t1cyTuhVadO3n+9GvwlS68P2kzxVirEPqA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jnn75xD2LzrZFDkjDNEioHCCWmL/NQKdsZYr7otybLO319JUWhAJvpmuvVWdoVwbNcwr2fQGq8BOW8ciVNYh/+Ob6kA15Enm2NybwXMCaRaWCT6aSGTGCOSm1XtKFmkJCgdP+dQzlGxGFtx/JePckTyjwsmAAW7apz6ZtF71jlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ne0+DCzJ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-437a660c94fso12500161cf.1
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713550649; x=1714155449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kml1FXGdCYQacK4u/UcOEpFthQUNLf77Zonk3NRyEhQ=;
        b=ne0+DCzJs9MjF6Z2AtGP3yX2mGZOaCPolQ6pk3qJuHH+R6ql4VvCeg75snCnd2JUnE
         6npNKobmm09peP+vsAtkD+v7e8QddCTVcevRHKM1r0HrhTcawnq3dodjgZI058xJbEPZ
         MdM1QSU/W6zC3zADRLoAJX5ZEQCTXvGJo5J+7NxkQbFxQTBhJQNRViwY3q2Z3T4+saoo
         p8KOaCh0GFNB5C5BextfnNG8QQLayUHX1shEfP7eQSX7FsVz9A41zQtLQDYdY+rEPcnO
         NlgybsaiVmAweV7Jc/n6Mv37esrQDCY/EJ7+DjAcAKvRhvkutp+cxwfFQ9OMFC36raJF
         THFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550649; x=1714155449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kml1FXGdCYQacK4u/UcOEpFthQUNLf77Zonk3NRyEhQ=;
        b=GKhQ3vvna+LrZ7psKsg6Gd+RDvmIxCiorG4H0QWqdtkA5KVV0Niyvoep+Zb1pHuiVk
         t9hczFk89GzGtj+zhD95PNPRmSHC6pAhnaCgstBjxmW0xRlDszYm/YusRCna1nhNs5YB
         DjiEq9jDsyk/Y6SVtAWA1EeBGfqPMSteDHZk/1wHO/H6dyy1X6Dp49b6K5/uXctxqbLY
         sd98RqCh4ztUIdq88aaGhFrsNXz/HDye1ayxO+jYIRHGBDR8nAaykdfcFPkn3jeCxUO3
         VM/s6jMJsYBHia+dAHXjxY3WbsB/5xa0dIeswMYD9D34g8fZg8Aq4FK71vrRm5E/GNg3
         XJCA==
X-Gm-Message-State: AOJu0YxuLk8POtpvRVi1ihegJu4dknDQj31ebTYUrtR8gl+aJDAqRQ9z
	jsjI44pBu4YqfclpcItoCt8YRX8BPBLd7kz1857emrT44eAVb8YQ8JAHKHbz7OEZVKPCUGgeOEj
	U
X-Google-Smtp-Source: AGHT+IE83m+9sxqzAWF8rkbdtGG8CpbafXpr7WxP1hsNfS5TDhev/1ePYav4OijhwEDybNMy/wm5DA==
X-Received: by 2002:a05:622a:118a:b0:437:acca:c682 with SMTP id m10-20020a05622a118a00b00437accac682mr3214938qtk.30.1713550649276;
        Fri, 19 Apr 2024 11:17:29 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o10-20020ac8554a000000b00434a352e239sm1798708qtr.43.2024.04.19.11.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:17:28 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 12/15] btrfs: clean up our handling of refs == 0 in snapshot delete
Date: Fri, 19 Apr 2024 14:17:07 -0400
Message-ID: <ef416b593a77b2b4c4b8faed51390bb3cc36ae1c.1713550368.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713550368.git.josef@toxicpanda.com>
References: <cover.1713550368.git.josef@toxicpanda.com>
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
that to proper error handling.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 43fe12b073c3..5eb39f405fd5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5352,7 +5352,15 @@ static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
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
@@ -5401,7 +5409,10 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 					       NULL);
 		if (ret)
 			return ret;
-		BUG_ON(wc->refs[level] == 0);
+		if (unlikely(wc->refs[level] == 0)) {
+			btrfs_err(fs_info, "Missing references.");
+			return -EUCLEAN;
+		}
 	}
 
 	if (wc->stage == DROP_REFERENCE) {
@@ -5665,7 +5676,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 
 	if (unlikely(wc->refs[level - 1] == 0)) {
 		btrfs_err(fs_info, "Missing references.");
-		ret = -EIO;
+		ret = -EUCLEAN;
 		goto out_unlock;
 	}
 	wc->lookup_info = 0;
@@ -5776,7 +5787,10 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 				path->locks[level] = 0;
 				return ret;
 			}
-			BUG_ON(wc->refs[level] == 0);
+			if (unlikely(wc->refs[level] == 0)) {
+				btrfs_err(fs_info, "Missing refs.");
+				return -EUCLEAN;
+			}
 			if (wc->refs[level] == 1) {
 				btrfs_tree_unlock_rw(eb, path->locks[level]);
 				path->locks[level] = 0;
-- 
2.43.0


