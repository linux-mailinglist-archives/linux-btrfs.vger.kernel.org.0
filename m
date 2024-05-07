Return-Path: <linux-btrfs+bounces-4807-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42528BEB44
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 20:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE7F28214E
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 18:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3379316D9A7;
	Tue,  7 May 2024 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xbabJnv6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139B516D320
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105553; cv=none; b=jRqw0G2R91cVADclbMBaAyscv0Wn/gE0SebEiMR5Zzu0Uhrgcee7CebO4OgCUUOKPX8NuuCcscx/mwp+2juYv7ALGHxAOkSVgEBprDnJ73V+ox7CxZlHK/3M41TUPOT/MqvDoDhEH8SqtzpFsPCm7Wc7CizNGgutl5JQzYXa3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105553; c=relaxed/simple;
	bh=Xkik9oyzjLOjQjX8zLJDqz5ahPdSsEF6qd/+9+fLnlc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyAjdI1Yj/hyo7vx+UK4fjknsTG7UsPtQcHH1lwjztFjiESrQnFISf7zSqNQryHD/F6NteAnb7EpoqVQvwbMqemkFkfR2bx47CJy3uSbdzPZjH69/6tRNjb8gnoNrt9wxladWs43sIcrDFpTql9FfxDcXUNc/pojBkghfOGqnFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xbabJnv6; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-deb654482bcso3527542276.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 11:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715105551; x=1715710351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Anif3BubDGLs9ZXWD9H+TR+TBYRn+hGnqSRX6TXZ7U=;
        b=xbabJnv66WIYNWP6eYqNH8Y88flRfzpIg0g3mXLy8q+bnu6R43paebxHNVbr5WxaJF
         1myULBdstcH+Vt5f0vZHR/ZipQu+lZ54Izw/D0NA4aiMIfSWrLTOXNIuG3ZLAlpLA2t8
         4vx5Mn1f/EPnitlaLfnRCt3yHhak4TiSaG4U4t6LAnxtP9l0WA//d+TcyhMxBBrewY6P
         Q59p/QDNN3pQc2Cxe6hwjoLMU941bV5AM/wTaCmwlFEvNaoA4aqj0xCJMfeT0XMV0KnH
         aaRmFty5g84wSBvLgwuskiqPPTUMhC9ifp7hlJ3HrSBJKy2f0QVrzYH3YG06rdaT5bEU
         CjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105551; x=1715710351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Anif3BubDGLs9ZXWD9H+TR+TBYRn+hGnqSRX6TXZ7U=;
        b=tG4wk7ryiTAnffsZDDrv4QuD8iJSJ4lot+ErRKhLZ8Z9qqhLHl4B404I/1Mrvgw2Rz
         1NeAW9lqJVnalxxyl6EWPFohPiYUuilMYBhvmY70wgpAoCRFC+GB98iw3ZCuQ61vQSfu
         UxJoonleusg3I8S8i6EEKoN0/xgJ+FR+r+i3kcb58pcleJju5JAMwjWWc0pZotEvko0U
         AjS84mhi03LsBf9x5tMawgllkpOI39h+SKCnL+vU1hZ2kAg/3+lh4kznCVAIITnYfmLQ
         FGIClPFZq08XQYViEmX1HFgErdL9JfaecpQg3RWLdn8CcnbcxQ/2jgJdOnXhkvbKpDZo
         blsg==
X-Gm-Message-State: AOJu0Yxkozw/5DmuTn3DxceuZluNs7D/eGZEn1IBDpskDDCqeInRH2Ff
	TcFJnfGNRoSEcdnTn/xWuDwNjX2W3BfzRGEueEB6geQmLlTE3h/rl8NO0fxCkk+q2dok3wHQg1d
	o
X-Google-Smtp-Source: AGHT+IF/GqdSUwVfXWPMazS00+eT8IzQlHU2U6Vjf5O4Qp6BAeTLuenOfDZSuIDeSJJm8dkFbe3Jbg==
X-Received: by 2002:a25:be91:0:b0:deb:3c11:8eb9 with SMTP id 3f1490d57ef6-debb9cfa78emr468221276.8.1715105550816;
        Tue, 07 May 2024 11:12:30 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u16-20020a5b04d0000000b00de598c93b96sm2615654ybp.48.2024.05.07.11.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:12:30 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 06/15] btrfs: remove need_account in do_walk_down
Date: Tue,  7 May 2024 14:12:07 -0400
Message-ID: <99f75d941bf2e92e29d532eb6535f66aa74fa8e6.1715105406.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715105406.git.josef@toxicpanda.com>
References: <cover.1715105406.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only set this if wc->refs[level - 1] > 1, and we check this way up
above where we need it because the first thing we do before dropping our
refs is reset wc->refs[level - 1] to 0.  Re-order re-setting of wc->refs
to after our drop logic, and then remove the need_account variable and
simply check wc->refs[level - 1] directly instead of using a variable.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8f5cf889e24d..ae11a2bd417e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5479,7 +5479,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	struct extent_buffer *next;
 	int level = wc->level;
 	int ret = 0;
-	bool need_account = false;
 
 	generation = btrfs_node_ptr_generation(path->nodes[level],
 					       path->slots[level]);
@@ -5519,7 +5518,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 
 	if (wc->stage == DROP_REFERENCE) {
 		if (wc->refs[level - 1] > 1) {
-			need_account = true;
 			if (level == 1 &&
 			    (wc->flags[0] & BTRFS_BLOCK_FLAG_FULL_BACKREF))
 				goto skip;
@@ -5562,8 +5560,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		wc->reada_slot = 0;
 	return 0;
 skip:
-	wc->refs[level - 1] = 0;
-	wc->flags[level - 1] = 0;
 	if (wc->stage == DROP_REFERENCE) {
 		struct btrfs_ref ref = {
 			.action = BTRFS_DROP_DELAYED_REF,
@@ -5608,7 +5604,8 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		 * already accounted them at merge time (replace_path),
 		 * thus we could skip expensive subtree trace here.
 		 */
-		if (btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID && need_account) {
+		if (btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID &&
+		    wc->refs[level - 1] > 1) {
 			ret = btrfs_qgroup_trace_subtree(trans, next,
 							 generation, level - 1);
 			if (ret) {
@@ -5633,6 +5630,8 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 			goto out_unlock;
 	}
 no_delete:
+	wc->refs[level - 1] = 0;
+	wc->flags[level - 1] = 0;
 	wc->lookup_info = 1;
 	ret = 1;
 
-- 
2.43.0


