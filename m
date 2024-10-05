Return-Path: <linux-btrfs+bounces-8570-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08356991544
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Oct 2024 10:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8056EB22BA7
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Oct 2024 08:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703BA13C836;
	Sat,  5 Oct 2024 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tqegv7QL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589082F5B
	for <linux-btrfs@vger.kernel.org>; Sat,  5 Oct 2024 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728116723; cv=none; b=Wj42ve1fnWg7E0mCzo8GwU8TGBrBphmgOB0jA5oc4xzcV/nLqd3qN4zPVm/gxIzFb8fQ+0/xurhTa4qE/nwUjoGM72h+ZO7eYbVE4GjF421KYJlXJ3+y6f1cgWDjyaCSYssYFJ9MpxI7mvrCbag7xySE+sQOfKMe7clTZZpbSpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728116723; c=relaxed/simple;
	bh=h2PP44NgiJEpvjTszue9C1vUTl3elR4Z37wWvC7p3fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N/pe7MnLBv22QehI0bQDRn4o0PeRcls51ZB0g8sp1LSLil6aEK3OD4GCKxxhjq/lIywDblkn60s+0jBqwP6OWPCK1ZCaAJQrIi5+4I48BSnK6rn/GStYm2f82gnGxuDa75WF/Mml9fuzPkhBgwTL+NhY7FFH4lDSiGDui192dVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tqegv7QL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b1335e4e4so28879445ad.0
        for <linux-btrfs@vger.kernel.org>; Sat, 05 Oct 2024 01:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728116721; x=1728721521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=++8Nucak/0DpCMzCrYuCzMm+8xfBZn20G3v75/wbVhI=;
        b=Tqegv7QLL6P51EWMH3af9QaFzioRmsjQh04ilO7Mx9S14Kqd48Iaqw6RmF55nqxBbY
         KYgjoTgJzzj5jjU2VBGgKI7oed1icfcoWzl8MrhJJqFu/8XSRq8LspRzryY6jKPOUw8O
         neudlgFinKbsErx1L/h4NckdeQmp9sCbdThHaCsQPwxosT+zbSyq781g0v+XlAWSVTZO
         e7mRktiXswb2Nh5aXwlbm5ZSnHiQ64GPWiKRii4xaleHiXDgr1oQCda0xbVd+UB4tyy7
         76KnAujAool3TIBJTccgIyVwzJ9n8yvPWQuipX9lsYisaMN2XwbK+3C/qhqEWIepUP1C
         5+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728116721; x=1728721521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++8Nucak/0DpCMzCrYuCzMm+8xfBZn20G3v75/wbVhI=;
        b=OBxY5nnrrSaDw8cdLgdOzQvmZrEAzNOY6MLqX2ZYrUiZw8j49NDV/cyKUkMUOy9OFP
         fZibiJZ8n6lvcYnsGFLZI5X4vb4/hC7B5FRPUSlSHqN+6XCKo85SXseXOrTAVFuX57hJ
         /h9Exn1yOEQqZ6J+7NiecDdK4nMQWsLZHVAiIVVdJxWpEJ8abWwWzteynOV4JEu4zNTO
         C+NGh0JIkDFMuhKfHNRnIVuyOAAyTAGO40OFb+jwsIR9edJWtzxmybGoWt8UTKoLOh4Z
         664XFKRHqCG/7S1Ge2prRgcCq6iLT5hJDbM0Cu13F7VTIvBKIxc6QKCE7hG3bQMAHogP
         wNpQ==
X-Gm-Message-State: AOJu0Ywx8USdntIiQiYHnoOVhT/07eb42SiQJb3AyJSwQXTC5He/39Th
	fh4wBx6U8a86k3FQ9Q2to3ywMXjy9LExMsndq3LHiumk9ZizAEbbog9ANA==
X-Google-Smtp-Source: AGHT+IH6Ine8t69lemozSjI3hjNJ0JhEowpD5yqkdMqD3w6pwjTNHVhmdOwCA194HYJQDXCE+VKFCw==
X-Received: by 2002:a17:903:1c2:b0:20b:fd3f:b44e with SMTP id d9443c01a7336-20bfdf6aeedmr78924325ad.10.1728116721294;
        Sat, 05 Oct 2024 01:25:21 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138b2364sm9291885ad.60.2024.10.05.01.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 01:25:20 -0700 (PDT)
From: Sidong Yang <realwakka@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: help: recognize '--help' option option regardless of its position in arguments
Date: Sat,  5 Oct 2024 06:31:21 +0000
Message-ID: <20241005063123.257903-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the handle_help_options_next_level() function only checks for
the '--help' option at first. This means that if user provides the
option at no first, the help message is not displayed. This patch
modifies the function to check all arguments for the command.

Issue: #889
Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 btrfs.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/btrfs.c b/btrfs.c
index d6f441e8..e34a34ab 100644
--- a/btrfs.c
+++ b/btrfs.c
@@ -140,19 +140,23 @@ static void check_command_flags(const struct cmd_struct *cmd)
 static void handle_help_options_next_level(const struct cmd_struct *cmd,
 		int argc, char **argv)
 {
+	int i;
 	if (argc < 2)
 		return;
 
-	if (!strcmp(argv[1], "--help")) {
-		if (cmd->next) {
-			argc--;
-			argv++;
-			help_command_group(cmd->next, argc, argv);
-		} else {
-			usage_command(cmd, true, false);
+	for (i=0; i<argc; ++i) {
+		if (!strcmp(argv[i], "--help")) {
+			if (cmd->next) {
+				argc -= i+1;
+				argv += i+1;
+				help_command_group(cmd->next, argc, argv);
+			} else {
+				usage_command(cmd, true, false);
+			}
+
+			exit(0);
 		}
 
-		exit(0);
 	}
 }
 
-- 
2.43.0


