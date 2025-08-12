Return-Path: <linux-btrfs+bounces-16029-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C672B2314F
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 20:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F413188D108
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 18:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D452FF176;
	Tue, 12 Aug 2025 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J19FDwsq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B962FDC24
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021624; cv=none; b=V1yrKtaxLyHymplP6AmwVFZdUHRnRsREtGrV9dV7ABulq7a0nnaaZdM1uXlBsOGK0CQMgcpNOVXwKL37STVjlTNFuSfi0gdAptVKXQEt1PbB8Wj8RDLTblZZiNvqcuE4Bd6HhgVK2ZLxOEYPB/OBBZkONy6nbjCIVHhxS427teY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021624; c=relaxed/simple;
	bh=RKKpAm+KiLWWgFRBCAHqlPefDI7M2d7P2LG3N+Fju1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hp8MiDwxX79cRHiB3W7f4Mya29jXZ49Ju5NyiZA7jHqLYXbUJLuFITRWh3psr3bApbc+lugewybGDykvDNL6oKYlZmc6wBbEJLaH8hTRKwVyCssPVASizvDBxY9Inj1Bji4r9eqFkHxOy8fqrxwhSH6XmWozzJ1VlVBQ4QnPRJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J19FDwsq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76bd050184bso7421508b3a.2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 11:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755021622; x=1755626422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiiOLTUpB1elCDPzu7nKaeH2MYhUatwyvRaME6ZWrjg=;
        b=J19FDwsq+Lk/l7dI9CEOA12Cdd+1HNYXEJpgzmkLCOjISF/4zX+kCVw60QfGeCQp+Y
         YH+nTQDvhZd7HvfG66MMqyfYQNKsex0z5vL9gfGEhzh6oNX0U1CiJNQe9R8iPkZAP5M/
         iCuc5GwDTHIZoz6D8aR8dw/YXoCDjN/cfGl/U5Vdjv00oOv7CmGP3x43Dg7CrA63t+Xw
         DZnheGT67A1zCv0sM1x38TmtU4AeeW+jxpuo8lIidWweypI22nE4jNC/anUeMe1WjYFa
         vq9TqtYonpAlBe/GeaQnmDXGlAUdPm1yTkChky+LnhaivaSsP1w77v5C3GP77THQEG6G
         Biwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021622; x=1755626422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiiOLTUpB1elCDPzu7nKaeH2MYhUatwyvRaME6ZWrjg=;
        b=EgwYjE+YAfEhTndLz9qKQODYaBmC8z7H4QVUhjtSRBvKid8BYo/aXfkuXg0q+oxG12
         6vgW1b9tsO7spShRfZHF4xx9l8PjMui0tQKN7NVFdOgmzp6Z0+jbcTGuzIQcINItPq76
         UuvgzbZhIzxUJ+x/PBJ0tzVla2pEqTaZwloZwaIpN3HlXCZJs4H+Du5zQWl4qREsjVBO
         ungNV4bQdiVHRRgXy1mkfrrFeYTG95IpJiPJSrJ072fETC4GIFW2nUEef9oiswX34UaA
         1d5NMN9dkX9WrrGkxhOOKw9jcb1CNI92B3YUGRQO26LImqisCKiVGyKyAMIzdUQ+BAxO
         699w==
X-Forwarded-Encrypted: i=1; AJvYcCVQnyHaLnzCrg4poUYTOWVzGdIjrKbvoIrwCeE/AFUufFc+NV8ZtF3MmZDrM26gEJxQHg3DPzdfkB7Zow==@vger.kernel.org
X-Gm-Message-State: AOJu0YybNI0haMyMKFdrlz/CpwNzRTXFxcOXuYqLV9WM+E7hzqdQ/s0U
	rRXvcbirMbEebmx7MNTFePJ3fKQ9gXMqcEU6t/amfvpuEmQswcTcKFOn
X-Gm-Gg: ASbGncsnF1dKN1YMyN7jjad1UZnRc+dt5+25Edd1o0ZdHFBQp3ah+V2YV9sWM4prWt2
	bnuHtESZAuDlxAO06dNkXUDx4R5xAdIQWgbp5neHokN6zLNoQv03EINIHnvgHDrPA235Yd+Gl8I
	B+67g4skP1ClBibaLq9brA1Tui7Knzs4vWjrRCaFzqrHMDOSjmPr3+ohZ5D7XDtVmX+tFCvCGXE
	j6JI7VScolhFCIYDaEuM7uKzwIjfu98OFoiZyAjZR7TVccTiWzQMW08Yiylg5h13Uz3G4WAHJp5
	elclb22M87/lqcNybHrUcC7KTM7J/PLKkVql2lGK/GVzYraMfPDtOdoYvfWOvjdNHYnaHKXGeJz
	eGE5p1du0dtgFjDrLJy41Xg587m0Zk/QDutz5neK6+YBUgD7gADg=
X-Google-Smtp-Source: AGHT+IFXmdgGEXrT0eo+kcHh/b0Csq8T2Vzkh0eGlqQylkQdcYdF3Lgduqhh/FW9oxTsEXRlagHU2A==
X-Received: by 2002:a05:6a00:2ea0:b0:76b:d746:733a with SMTP id d2e1a72fcca58-76e20fb9a47mr135244b3a.21.1755021621649;
        Tue, 12 Aug 2025 11:00:21 -0700 (PDT)
Received: from fedora (120-51-71-230.tokyo.ap.gmo-isp.jp. [120.51.71.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c2ea6893csm15793073b3a.104.2025.08.12.11.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 11:00:21 -0700 (PDT)
From: sawara04.o@gmail.com
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	johannes.thumshirn@wdc.com,
	brauner@kernel.org
Cc: Kyoji Ogasawara <sawara04.o@gmail.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: restore mount option info messages during mount
Date: Wed, 13 Aug 2025 03:00:06 +0900
Message-ID: <20250812180009.1412-2-sawara04.o@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812180009.1412-1-sawara04.o@gmail.com>
References: <20250812180009.1412-1-sawara04.o@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyoji Ogasawara <sawara04.o@gmail.com>

After the fsconfig migration, mount option info messages are no longer
displayed during mount operations because btrfs_emit_options() is only
called during remount, not during initial mount.

Fix this by calling btrfs_emit_options() in btrfs_fill_super() after
open_ctree() succeeds. Additionally, prevent log duplication by ensuring
btrfs_check_options() handles validation with warn-level and err-level
messages, while btrfs_emit_options() provides info-level messages.

Fixes: eddb1a433f26 ("btrfs: add reconfigure callback for fs_context")
Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
---
 fs/btrfs/super.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a0c65adce1ab..2677754ec8f7 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -88,6 +88,9 @@ struct btrfs_fs_context {
 	refcount_t refs;
 };
 
+static void btrfs_emit_options(struct btrfs_fs_info *info,
+			       struct btrfs_fs_context *old);
+
 enum {
 	Opt_acl,
 	Opt_clear_cache,
@@ -689,12 +692,9 @@ bool btrfs_check_options(const struct btrfs_fs_info *info,
 
 	if (!test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state)) {
 		if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE)) {
-			btrfs_info(info, "disk space caching is enabled");
 			btrfs_warn(info,
 "space cache v1 is being deprecated and will be removed in a future release, please use -o space_cache=v2");
 		}
-		if (btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE))
-			btrfs_info(info, "using free-space-tree");
 	}
 
 	return ret;
@@ -971,6 +971,8 @@ static int btrfs_fill_super(struct super_block *sb,
 		return err;
 	}
 
+	btrfs_emit_options(fs_info, NULL);
+
 	inode = btrfs_iget(BTRFS_FIRST_FREE_OBJECTID, fs_info->fs_root);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-- 
2.50.1


