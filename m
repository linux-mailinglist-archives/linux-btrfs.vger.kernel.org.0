Return-Path: <linux-btrfs+bounces-20092-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C262CEFF54
	for <lists+linux-btrfs@lfdr.de>; Sat, 03 Jan 2026 14:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8560F30239EA
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Jan 2026 13:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B942F656E;
	Sat,  3 Jan 2026 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXXDFPKj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94752F6173
	for <linux-btrfs@vger.kernel.org>; Sat,  3 Jan 2026 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445614; cv=none; b=f9CiNDRiVm+L9Vge4it0fkw0kG5hDOwLoQLG58wVdMpwPxWY8R1aFqo1p3AT37ZTmysgrh10sL0lHozm3/sXFQsMwG9qhYAoq/HEUxNdeKAWzAkmveslvKYedQP31NrUoAuk391La9CMWOMQDaBdY+N/hhpSumgXbm5uVpeHVOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445614; c=relaxed/simple;
	bh=o8AUPCgcGwWQrDOUabU+OOGM3G5KrulGyBCkxpIaWDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdEC/5bqjx9SM5O2AWOM6CZ8lZ2hrTz0qkdVFfblwPXXfnmv+WHJZHYOiGDM0gZHHbKT93b7C6LDMysiD37T/95mM8EmYPbVOSBuCsX34Ge1GPHpQeHVRlWujndRDduASf0HQmGwxfTSeEYdLE2iAhYyFg/nR3RqQ1T0tQLTUHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXXDFPKj; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-644722d0b23so1606823d50.0
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Jan 2026 05:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767445612; x=1768050412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXwUzQK9M2k1UHqddqsDBQ6JTOq4eoECkvmv2IlttiY=;
        b=FXXDFPKjXIxqnNXEyETp4Mv4LpqSYXV1ZvfmmnUhXTwzRSaSUtIMJdPfSdJE/mMDIK
         IKAI00CxEWLjXPQT3+GJk0agAarBCqON1KL62JjWH2njBTr3b8WLE9ywawTRVogQcbZ+
         K7o9knFL8PQzFfyUBYfppzHuC7Nrj1J+xFD0xtC87JMrBDsbXpceNSBamwQuDU5c7R5T
         HSGOrJUOf3SsaArzBoheDNOCp+ueOQYsjJk1+zC2aJCSi1tlTRh2WsnSaHrhUBP0NJHp
         hcPDZC1JMi5vUuCfK0fVmUjPNOKmutbdurbqkWK7ijOqJwpNtLHqEN6gRzaLN0CGDwOZ
         5/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767445612; x=1768050412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lXwUzQK9M2k1UHqddqsDBQ6JTOq4eoECkvmv2IlttiY=;
        b=rdtO0oIAkFcLEX/92pTs6pxPCwIZ8D9jT68CGDW2zMTgs173zsYQriUXvvz+Bv9eIJ
         sIIrVNi+3cfNFj9VkWo9VhHuMo8DejSHaP2H19YxWiaRnx0k9D83yQqIN8cDNCGNxr6A
         LWnxznLj8dMUhguKxTWVZrf7O87adOIvRKKhLFwH+7poY3SnRjgCrpcrL62ibXlpIWEt
         7yRVdf9OvsMJIyCslaUXBe/rAJxqHyGv/iP9fxSPzjYhVLs8Pc+u1iRPCIYnqfafSyCC
         EgCSEEyWSQxhxPyCqI+dJZSuGmNe1OqAghGKAH6XKHer1/BGKoZi8wsvas7GWCc4hPWK
         UieQ==
X-Gm-Message-State: AOJu0YwSXUevY424WW88kgEUXP+P3u4w+Tqi1jxF0tCQylksp0GYXORZ
	9zjMUU4CK5U0/CEYsjmYg107H02Ktjmvc/Ar1sVvRilSRTIrIEiB8B/8KYU0+o8E9AUc8Q==
X-Gm-Gg: AY/fxX4lR8Iml1yRJpoPpfZ0ABkyuusbDuPbUX0KlsF9DjN0RupmHw2joatbxtz9XR9
	EgPw32FtO0+shEaSnl/4I1O1gQdPjzJVE3l5ihKTSg5esWINS/aSwzMzLNf7ojJiqrWLAcwiKoq
	HTLB+hoMGv3ctuIUPzSNEn/t9Wn7uRzjopjJSrzxZJIKMVhLKGkv2hlUzVv7fCCXA/sgBzMlImN
	LqyyvEvv7MT9p6FUw7AqCsuIYFDeCGJ5pDj1bxTY9cqSgulVgK1kRFrsAwaKQ8rvgityWB+ExH2
	KhUNk6aRYPG+37coswpd0izMY8MP3NfCXPSj2oQIl24NBbOND1BSLm6pqSQo50fPTg2y/Sa5m27
	SWEITfiw2SCTbQjyoZs34GnZC1UFJM9rBMZUga+kgoQTotLuPB7ja3YdbJJZJMTDdlTU32829qc
	OiZZEhpJjzY/5bAIhNqGc=
X-Google-Smtp-Source: AGHT+IG/7Hpsd7ShaPG/xOIStZTCq9OMprQXC/7Ngoi8CTjhsjKv2kdCnDL40S6pDImKgOopfH127w==
X-Received: by 2002:a05:690c:39b:b0:78f:9d17:aff2 with SMTP id 00721157ae682-78fb4143031mr336297017b3.5.1767445612008;
        Sat, 03 Jan 2026 05:06:52 -0800 (PST)
Received: from SaltyKitkat ([193.123.86.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ffebd2690sm112554957b3.15.2026.01.03.05.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 05:06:51 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2 7/7] btrfs: consolidate reclaim readiness checks in btrfs_should_reclaim()
Date: Sat,  3 Jan 2026 20:19:54 +0800
Message-ID: <20260103122504.10924-9-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260103122504.10924-2-sunk67188@gmail.com>
References: <20260103122504.10924-2-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the filesystem state validation from btrfs_reclaim_bgs_work() into
btrfs_should_reclaim() to centralize the reclaim eligibility logic.
Since it is the only caller of btrfs_should_reclaim(), there's no
functional change.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/block-group.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index f29553fa204a..39e6f1bf3506 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1804,6 +1804,12 @@ static int reclaim_bgs_cmp(void *unused, const struct list_head *a,
 
 static inline bool btrfs_should_reclaim(const struct btrfs_fs_info *fs_info)
 {
+	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+		return false;
+
+	if (btrfs_fs_closing(fs_info))
+		return false;
+
 	if (btrfs_is_zoned(fs_info))
 		return btrfs_zoned_should_reclaim(fs_info);
 	return true;
@@ -1838,12 +1844,6 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	struct btrfs_space_info *space_info;
 	LIST_HEAD(retry_list);
 
-	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
-		return;
-
-	if (btrfs_fs_closing(fs_info))
-		return;
-
 	if (!btrfs_should_reclaim(fs_info))
 		return;
 
-- 
2.51.2


