Return-Path: <linux-btrfs+bounces-5892-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDD1912D95
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 20:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285B1285E11
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 18:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063CD17B505;
	Fri, 21 Jun 2024 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="AKd4w12j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DEA17BB1F
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996036; cv=none; b=djYwuZ/cMZKoXWx/tHAMDJkrnjOG2L6zR9vDprePPZdc/tZBhcZo3T8TyVM56ZFgGVivp1OCK29iN3BFGVNp5Sp9CABtDw0Nk/XjqtEqF/4Csr9aZt33DjPcx2JX2WDXJUEyFzdiLCTzzBWfts9rDQ0bF3xs1XQumGXe/QWwMrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996036; c=relaxed/simple;
	bh=h9oCshAaUFIQ+LeKcdSoolNe2tYY2WCngN6Fqu0mkn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgsZtOArpFzotpJf51Wln1UC2jRkF7djwsiq8CiJTtBqnf2LCeAOiMbsN6BSXu6FJEkcDaEoyUSomNxaH8g5sgAUao3cPYZJXoDkI1IveTOzLPmIZvAeQ3WP4vWIrL325oh+eBI33PJ5g10cXJ/CRZWERgE6ztDLazRmJwXJt/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=AKd4w12j; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70661cd46d2so388942b3a.3
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 11:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1718996034; x=1719600834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEXJaoHpp7C49FCtNBRt9FgcLqzzesAJ646B21mnVNg=;
        b=AKd4w12j/uUhXx6ayo5isQ6OOhG7olYV5KAfXt0g1IVw3lEdGLmFxWh/o2yiBswUg6
         vOaXqEXZcVLzTaqEU8JBpoM/KV/VTxk4tvk3t3npjHqEmpzgI9X1HKHNMIkgWk6oEJY+
         XwccwxTimT8ghtzzTfpSgdAybZRrmolLCxKPuS6kIYLW030sBLfLEt+mQJsFfCBhbnsi
         6frBPEvVqJo+1Y/XUwfLKPYgC3ArAWgtyvTFUzMaarhte/NhvkpAJYOG7La2Jaw3yY1w
         WqIvrjB8BGWs5aRaba1Cgpxrqy6tmyh6iL3gEOkvozFa3NQmirpCDqwHIbnLAam8a/ay
         gNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718996034; x=1719600834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEXJaoHpp7C49FCtNBRt9FgcLqzzesAJ646B21mnVNg=;
        b=btco0mpGgkdrrBD5UzA1/8VLLxDU6mcHMrO8qQH0/ZN70eELOuvcowBu5ZAS5yc0pL
         wJVX6wvfSg9WC8izdU7jlj8VySslKtwmaEmvRs0KwfWgpGe2V4vIDqM5WgdjMc/1Hdie
         KwZ7ro0muEzxARDD8aA7vMH1miafU/Pd1U1WKXvqHvuwTnoWEYxzjbs8uXyupdwtukKc
         i3zS6PbfMZ0D5ZcFiTsrKGWMksmHa9hwtwE7GHuz4JOCuJ0e4kkxnlpw3bqXemllJRIw
         phhK9HlMsBchbDTtO6XF5MsEKLO1srNMLLQDwtsSQFIpmxvbYlSQjmXdv+IjZgprxJIa
         FNxA==
X-Gm-Message-State: AOJu0YzdLBPn1W1pImmxIm0/0nNMfQ5doCzz28bYoTlRwrft1nrJVEpM
	hctGj1brz9lRFus2Af1GlMf3veUdcikpqBiadrgfIpoDcXHShBvXx3Q/kYo2T7b2e2UTGv2MWy0
	W
X-Google-Smtp-Source: AGHT+IGVM+PJ/WMwVcLLEgN+Xisfbjp8qkLwBr+ffkOQyhnmJJfYJltES3UiRdXhj7jlLRK55SY5Pw==
X-Received: by 2002:a17:90a:9ce:b0:2c4:a32b:c193 with SMTP id 98e67ed59e1d1-2c7b5d7c6ffmr8579840a91.33.1718996033865;
        Fri, 21 Jun 2024 11:53:53 -0700 (PDT)
Received: from telecaster.thefacebook.com ([2620:10d:c090:500::6:1ec7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e53e06e7sm3957366a91.21.2024.06.21.11.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:53:53 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 4/8] btrfs-progs: subvol list: remove unused raw layout code
Date: Fri, 21 Jun 2024 11:53:33 -0700
Message-ID: <804f462d296d7a4385b1e1a7b923f69d0c45f9e2.1718995160.git.osandov@fb.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718995160.git.osandov@fb.com>
References: <cover.1718995160.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

It hasn't been used since commit 9005b603d723 ("btrfs-progs: use
libbtrfsutil for subvol show").

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 cmds/subvolume-list.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index 52a30aa0..060f4f31 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -98,7 +98,6 @@ static const char * const cmd_subvolume_list_usage[] = {
 enum btrfs_list_layout {
 	BTRFS_LIST_LAYOUT_DEFAULT = 0,
 	BTRFS_LIST_LAYOUT_TABLE,
-	BTRFS_LIST_LAYOUT_RAW,
 	BTRFS_LIST_LAYOUT_JSON
 };
 
@@ -1202,23 +1201,6 @@ static void print_subvolume_column(struct root_info *subv,
 	}
 }
 
-static void print_one_subvol_info_raw(struct root_info *subv,
-		const char *raw_prefix)
-{
-	int i;
-
-	for (i = 0; i < BTRFS_LIST_ALL; i++) {
-		if (!btrfs_list_columns[i].need_print)
-			continue;
-
-		if (raw_prefix)
-			pr_verbose(LOG_DEFAULT, "%s",raw_prefix);
-
-		print_subvolume_column(subv, i);
-	}
-	pr_verbose(LOG_DEFAULT, "\n");
-}
-
 static void print_one_subvol_info_table(struct root_info *subv)
 {
 	int i;
@@ -1349,7 +1331,7 @@ static void print_one_subvol_info_json(struct format_ctx *fctx,
 
 
 static void print_all_subvol_info(struct rb_root *sorted_tree,
-		  enum btrfs_list_layout layout, const char *raw_prefix)
+		  enum btrfs_list_layout layout)
 {
 	struct rb_node *n;
 	struct root_info *entry;
@@ -1377,9 +1359,6 @@ static void print_all_subvol_info(struct rb_root *sorted_tree,
 		case BTRFS_LIST_LAYOUT_TABLE:
 			print_one_subvol_info_table(entry);
 			break;
-		case BTRFS_LIST_LAYOUT_RAW:
-			print_one_subvol_info_raw(entry, raw_prefix);
-			break;
 		case BTRFS_LIST_LAYOUT_JSON:
 			print_one_subvol_info_json(&fctx, entry);
 			break;
@@ -1425,8 +1404,7 @@ static int btrfs_list_subvols(int fd, struct rb_root *root_lookup)
 
 static int btrfs_list_subvols_print(int fd, struct btrfs_list_filter_set *filter_set,
 		       struct btrfs_list_comparer_set *comp_set,
-		       enum btrfs_list_layout layout, int full_path,
-		       const char *raw_prefix)
+		       enum btrfs_list_layout layout, int full_path)
 {
 	struct rb_root root_lookup;
 	struct rb_root root_sort;
@@ -1448,7 +1426,7 @@ static int btrfs_list_subvols_print(int fd, struct btrfs_list_filter_set *filter
 	filter_and_sort_subvol(&root_lookup, &root_sort, filter_set,
 				 comp_set, top_id);
 
-	print_all_subvol_info(&root_sort, layout, raw_prefix);
+	print_all_subvol_info(&root_sort, layout);
 	rb_free_nodes(&root_lookup, free_root_info);
 
 	return 0;
@@ -1726,7 +1704,7 @@ static int cmd_subvolume_list(const struct cmd_struct *cmd, int argc, char **arg
 		layout = BTRFS_LIST_LAYOUT_JSON;
 
 	ret = btrfs_list_subvols_print(fd, filter_set, comparer_set,
-			layout, !is_list_all && !is_only_in_path, NULL);
+			layout, !is_list_all && !is_only_in_path);
 
 out:
 	close(fd);
-- 
2.45.2


