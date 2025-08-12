Return-Path: <linux-btrfs+bounces-16030-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF58B23151
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 20:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7C31AA47B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 18:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9FE2FFDCC;
	Tue, 12 Aug 2025 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak351IB/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69262FF16E
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021628; cv=none; b=gXp1uaGFEliQdpPspYCGgcQXXNIxgs4Kq2Q21chuAPugbrNIw0Suj23are54oHYkLT7o/FEyzCpDTBUQFzHjG2JXPt3U5CkRXevcOEF8PawqhiIM/YZmnMCQy2tY9Y6agHeIQ0FTlQaKAgfwtg0ABa+IUdiDySJdlqOxvECZW2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021628; c=relaxed/simple;
	bh=IvaUBSovVScBHDDlH7wIRjXTDuhQ4cvDQdSRueoDF4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWv41WJ5L7ODMNn3+Wse88ZUmHLK9rAl481pQJXpJFCxQ1kbOqdHExaMW69Lfqh2EA66dDfSjDh+oKWLiWrd6rf14hX9BVEq/5vdlkRiQo/tmy88CL4BpuhoPpiwPrRGQXcUEaiJJinP5+RbPhmI0udZAEeH7W4N+k/RfenvtZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ak351IB/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bddb92dc1so7265515b3a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 11:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755021626; x=1755626426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kd5C2a1ehjY0NR9Ukf0iSIaw3wR1Rrga9sr+cG8tW9U=;
        b=ak351IB/y1xgu+EDcEHn0hr1dNpiSYDag/pr28la9IZAs/9ltdSs32h0eCf/bhFKAp
         aesbLvoTfOFfV7unbnJwqjUJLvo2O6ALmAmqD/YMAA4emsPZ7EuQw6jk5X5mN0i0owlt
         bE6WUjVxm+wH+bgnnw5m2HpafzyRhFVoAM6Ka7ssZVzTAuKvkkxYjtSnU4oNDq/q6AJQ
         5ACtRu39SA/FJkqZL1qO+nqYkF2sUq4I+BO6p0AMVdzxNAUTlYSO+0ImkTG80U+BzU58
         G125HDlbhJrhGCBQU5LGJLAv0Y0/iZYYPQgiJ2QezXJIDH+GSgtomZ5Yu6nMvbP71N4c
         nKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021626; x=1755626426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kd5C2a1ehjY0NR9Ukf0iSIaw3wR1Rrga9sr+cG8tW9U=;
        b=Y1uI/lpnCGYiBQCtIjRcTTMR8FKQ+9PNzL9fagpuGgrT8zB64YmjfoGynf1NuwkSsm
         wH12koLfWQTEt3mSv9s9z+V9FSsNXyy35kAqONCyuzRq2uSg15VrCguvCRVtO+ryIMAc
         B8vMN7XDgpZmFx/CjD6reM/rZi/iOd0s42eLMAvYPe6+b05xSA15lFTTve1xAR0Mu3hs
         fRO23Ed18PsQX45Gfc0jRnMFUr2iEV+ZF/rynPAvAwfFouBjwJbyFzX5pcIPhoVdTm1u
         JhwMmiduGGNdmMN87SAS4rzAuODtYqqB80H3poKiF9f1InjGsGZihJcvXQPbDH7OjVuK
         WDPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5EPcJMJ3WSfa5vlRFhTg3REO4AhOrPUpeuO2PwsaWNG4UARQXmXxuYAyc4HB6kUWb/j2/arWMnUnmOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yypr7SChbBVVoBr+QcYKK6LIQ2zci1ay27yWFNxUtNcBqq6Gr6e
	p7CEk7vfEcVyBI+AaJVhedik1bVzUb1mbYO2xsJ+nEqeZHpWL3sCorB2
X-Gm-Gg: ASbGncuZTade3ve7UwkGwMFWljFekaXGQ5+Yi6SVHdUGCRzadvEDbCE/5Z1O1gTfadC
	sWXSGWbSEYE9YmydGUovqudczDavUdN/k3wIqwYBAF3VpYed3vuLk6ujcrmnk0hJexUJYix5Xet
	DcTVqCR2ua6QUyOSB8pVcHY86oUZmJSTnB2E00qnpqdl46ABxY0vu2/BETmb1BmtNh1ZBPGpUmJ
	ApGmCYDFtdrOu0E1TIeRZ4xrDwTEM1EqUSiqTr2ikbrKQwFmjoKYLqQHl6SRr7HobKn48YYAnJO
	CWzpojxuopC/AbcD/I8wF9m/Bk47KK2KEUqQ/Q1K6Rh/QsAOn3JbqRc7bnflRrckgRZWNe9hPO8
	kKq3LSmm5hbJZDhY/srX9yf9vIqi6G/Bnj4WvlWz8Lit9NYTAVoA=
X-Google-Smtp-Source: AGHT+IFCakl9ULWaZGlkl2xi0UhhRs4WK52rlR9sFlcp5057uxA4oQhgggeYtPIfZv77yM0qtlsL8w==
X-Received: by 2002:a05:6a00:3a17:b0:76b:ca98:faae with SMTP id d2e1a72fcca58-76e20cd5d18mr191878b3a.8.1755021623898;
        Tue, 12 Aug 2025 11:00:23 -0700 (PDT)
Received: from fedora (120-51-71-230.tokyo.ap.gmo-isp.jp. [120.51.71.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c2ea6893csm15793073b3a.104.2025.08.12.11.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 11:00:23 -0700 (PDT)
From: sawara04.o@gmail.com
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	johannes.thumshirn@wdc.com,
	brauner@kernel.org
Cc: Kyoji Ogasawara <sawara04.o@gmail.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: Align log messages and fix duplicates for NODATACOW/NODATASUM
Date: Wed, 13 Aug 2025 03:00:07 +0900
Message-ID: <20250812180009.1412-3-sawara04.o@gmail.com>
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

Fix duplicate log messages and make them the same as the log output
messages related to NODATACOW and NODATASUM, which are output with the
same logic.

Fixes: eddb1a433f26 ("btrfs: add reconfigure callback for fs_context")
Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
---
 fs/btrfs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2677754ec8f7..76c2618b427c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1430,7 +1430,7 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
 {
 	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
 	btrfs_info_if_set(info, old, DEGRADED, "allowing degraded mounts");
-	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
+	btrfs_info_if_set(info, old, NODATACOW, "setting nodatacow");
 	btrfs_info_if_set(info, old, SSD, "enabling ssd optimizations");
 	btrfs_info_if_set(info, old, SSD_SPREAD, "using spread ssd allocation scheme");
 	btrfs_info_if_set(info, old, NOBARRIER, "turning off barriers");
@@ -1452,6 +1452,7 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
 	btrfs_info_if_set(info, old, IGNOREMETACSUMS, "ignoring meta csums");
 	btrfs_info_if_set(info, old, IGNORESUPERFLAGS, "ignoring unknown super block flags");
 
+	btrfs_info_if_unset(info, old, NODATASUM, "setting datasum");
 	btrfs_info_if_unset(info, old, NODATACOW, "setting datacow");
 	btrfs_info_if_unset(info, old, SSD, "not using ssd optimizations");
 	btrfs_info_if_unset(info, old, SSD_SPREAD, "not using spread ssd allocation scheme");
-- 
2.50.1


