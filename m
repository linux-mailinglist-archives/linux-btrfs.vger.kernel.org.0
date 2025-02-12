Return-Path: <linux-btrfs+bounces-11385-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D82A31AE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 01:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A411889B81
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 00:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE7617996;
	Wed, 12 Feb 2025 00:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHbK0pI7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42B7F9E6
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739321814; cv=none; b=O84jb7PkY2eHvYIyNBKpDM/qEv/HLmWzC+t/R2MpilPcF4iM6zzGqZv4zVhIhp8uZIh0u3C1CskRlOGdjqT04NP9sbM+71XpugWnECMzaDQUNHKIVaQ7wMx47GXVfZCtgcpguzJZEfYE5l9UL1pgWr30AuCi78MQAGLuVnv3tNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739321814; c=relaxed/simple;
	bh=5U9Og8UFsFggvjvcbj9jc3G47DBJNRL3idsJBbN+eds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KiE7D4CjmIYWsxEOCqq3qVAFc4i4FDBtbKQO1eR1kPFQ2MEwLrGe7/fOSqBgR0PCj3LeriMjCBvrb6PZDynlFJznUlwpnQlxTxMrNIrMA+ZxCMi0yy4su8Xth42Yjb6kMU3hUqShONvbI47ILP4DsZF24NxMdKwc9s3KdXuc1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHbK0pI7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7d3bcf1ceso364397266b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2025 16:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739321811; x=1739926611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=waUrL+CrEt6jzNoNjVYrINAddgAj2aBlif7AlsGhR/Y=;
        b=BHbK0pI7YbNSpuWv+1xPSPc6RW8MNggSq7C6FuELI615DLJPdWAkE1QUBBpdm+mQaJ
         8yZ+JXP+FSBcxooL5VownTXtonQfrmBmkcal+KNX1bmB31QurfjGO4ohN1PGp3yWFCWD
         wQPKQ6llLCY6y38FL8yEEJQADMVDM1KFrhFPB9I4buIzPMkSmHxsT0Ww0enGI16Hmt3W
         gb5GEl2ukMRMYaTg829a4W6iFoJszt6hctEUCSl686HcT4iCAmDZ/xdwVFzpLTZtbPJS
         SQqYMtxVTiK9gL74dg5LjthH2rdrI32TKAc/zqnuEEqt9DHuPsjePkLuis13NFR/EJeQ
         HiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739321811; x=1739926611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=waUrL+CrEt6jzNoNjVYrINAddgAj2aBlif7AlsGhR/Y=;
        b=o2afQbi2JGbL+IyslJPGRML36vk1FvZkZljBuNgjBpzNoLVfV1oVuNP9+9ZCKQ/IUc
         RkUwxJ1TWvUsqtFm274dftl8Gi08kKhA27Knvoxd99oHrncRHLmumuGWwbaCMZGeZ77X
         lFeAVUPNXqrR03fz/wp8ccmyJ92T3Vai5j3oYJtXEoeNwMb1rHAbENlpRbTK+IQjRFhS
         r5Je8FkexFeh2I6KzUr+XqAXqr4X7bVsUixuCIGUzeGg/0HkCInQR5+silWWB8nF44AT
         tC0gKeboHWWqhJZDptkJx4rKVs8701kRGdlezV6rYNKX5/nlX/XoZwle8hoCFOx3ruNe
         ac5w==
X-Gm-Message-State: AOJu0YwpfbN3JUXCFiDhgZ0sefEzT6PTioHx9iEOFgSa2X3FUk0WQr+b
	6tuhHS/i57WWFWCh5gmgoSnH6zvsBL9uAwbavQI6olNIqXxre75P2TgQCg==
X-Gm-Gg: ASbGncuQsUZDUqBbWHGElKSv59eBgpKKTZ3lOg3z/GiAveX6c8CIqLFz/EflwhWUvrK
	H+7ux60IoGDQZiLm0GfXxeBpQwRpp5G3/Gs/jilSBNkxJbAw9OLYTO4dk+dVXAk5FXRZufyuAes
	4hUX+/Xrr1xqmJC+BpZVOaSgmcXFibEseNg/bBubz60p6imnWMoOYQ6QiN+IZToaEQKPZ6I1Qw+
	Lwvhzp5PxLZm+zXig2eZOBQWF4Q25ghm+Es7cbNTzKvDEgr7uXJTULNmpI9NUR3WGneupf9lbFx
	UEKi9jF3sqiR
X-Google-Smtp-Source: AGHT+IGfIkbejP6cmtmpFLRSEB0aQgT8laldDxkgLFhGvpp+5NplOskY0P9f6oIobpan0DnS5RS1XA==
X-Received: by 2002:a17:907:7b86:b0:ab7:b424:dd14 with SMTP id a640c23a62f3a-ab7f3765a39mr89747266b.19.1739321810933;
        Tue, 11 Feb 2025 16:56:50 -0800 (PST)
Received: from 192.168.1.3 ([82.78.85.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b7f98188sm590617566b.76.2025.02.11.16.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:56:50 -0800 (PST)
From: Racz Zoltan <racz.zoli@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
	Racz Zoltan <racz.zoli@gmail.com>
Subject: [PATCH] btrfs-progs: change print format for btrfs_scrub_progress struct keys in print_scrub_full()
Date: Wed, 12 Feb 2025 02:56:40 +0200
Message-ID: <20250212005640.182760-1-racz.zoli@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since all members of struct btrfs_scrub_progress are u64, the correct
format option for pr_verbose calls in print_scrub_full should be %llu (as
dsterba suggested) not %lld.

---
 cmds/scrub.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index b1d2f731..508eafb7 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -126,21 +126,21 @@ struct scrub_fs_stat {
 
 static void print_scrub_full(struct btrfs_scrub_progress *sp)
 {
-	pr_verbose(LOG_DEFAULT, "\tdata_extents_scrubbed: %lld\n", sp->data_extents_scrubbed);
-	pr_verbose(LOG_DEFAULT, "\ttree_extents_scrubbed: %lld\n", sp->tree_extents_scrubbed);
-	pr_verbose(LOG_DEFAULT, "\tdata_bytes_scrubbed: %lld\n", sp->data_bytes_scrubbed);
-	pr_verbose(LOG_DEFAULT, "\ttree_bytes_scrubbed: %lld\n", sp->tree_bytes_scrubbed);
-	pr_verbose(LOG_DEFAULT, "\tread_errors: %lld\n", sp->read_errors);
-	pr_verbose(LOG_DEFAULT, "\tcsum_errors: %lld\n", sp->csum_errors);
-	pr_verbose(LOG_DEFAULT, "\tverify_errors: %lld\n", sp->verify_errors);
-	pr_verbose(LOG_DEFAULT, "\tno_csum: %lld\n", sp->no_csum);
-	pr_verbose(LOG_DEFAULT, "\tcsum_discards: %lld\n", sp->csum_discards);
-	pr_verbose(LOG_DEFAULT, "\tsuper_errors: %lld\n", sp->super_errors);
-	pr_verbose(LOG_DEFAULT, "\tmalloc_errors: %lld\n", sp->malloc_errors);
-	pr_verbose(LOG_DEFAULT, "\tuncorrectable_errors: %lld\n", sp->uncorrectable_errors);
-	pr_verbose(LOG_DEFAULT, "\tunverified_errors: %lld\n", sp->unverified_errors);
-	pr_verbose(LOG_DEFAULT, "\tcorrected_errors: %lld\n", sp->corrected_errors);
-	pr_verbose(LOG_DEFAULT, "\tlast_physical: %lld\n", sp->last_physical);
+	pr_verbose(LOG_DEFAULT, "\tdata_extents_scrubbed: %llu\n", sp->data_extents_scrubbed);
+	pr_verbose(LOG_DEFAULT, "\ttree_extents_scrubbed: %llu\n", sp->tree_extents_scrubbed);
+	pr_verbose(LOG_DEFAULT, "\tdata_bytes_scrubbed: %llu\n", sp->data_bytes_scrubbed);
+	pr_verbose(LOG_DEFAULT, "\ttree_bytes_scrubbed: %llu\n", sp->tree_bytes_scrubbed);
+	pr_verbose(LOG_DEFAULT, "\tread_errors: %llu\n", sp->read_errors);
+	pr_verbose(LOG_DEFAULT, "\tcsum_errors: %llu\n", sp->csum_errors);
+	pr_verbose(LOG_DEFAULT, "\tverify_errors: %llu\n", sp->verify_errors);
+	pr_verbose(LOG_DEFAULT, "\tno_csum: %llu\n", sp->no_csum);
+	pr_verbose(LOG_DEFAULT, "\tcsum_discards: %llu\n", sp->csum_discards);
+	pr_verbose(LOG_DEFAULT, "\tsuper_errors: %llu\n", sp->super_errors);
+	pr_verbose(LOG_DEFAULT, "\tmalloc_errors: %llu\n", sp->malloc_errors);
+	pr_verbose(LOG_DEFAULT, "\tuncorrectable_errors: %llu\n", sp->uncorrectable_errors);
+	pr_verbose(LOG_DEFAULT, "\tunverified_errors: %llu\n", sp->unverified_errors);
+	pr_verbose(LOG_DEFAULT, "\tcorrected_errors: %llu\n", sp->corrected_errors);
+	pr_verbose(LOG_DEFAULT, "\tlast_physical: %llu\n", sp->last_physical);
 }
 
 #define PRINT_SCRUB_ERROR(test, desc) do {	\
-- 
2.48.1


