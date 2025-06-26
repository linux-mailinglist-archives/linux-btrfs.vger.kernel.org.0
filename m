Return-Path: <linux-btrfs+bounces-14996-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5E7AE9E72
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 15:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009EF3AE6B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 13:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EB52E427A;
	Thu, 26 Jun 2025 13:18:47 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA13B2F1FD0;
	Thu, 26 Jun 2025 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943927; cv=none; b=gnabgIjd2FvlfoglzN/nOome2vZ7yXU0EsXOj/DwMx2HH44G8Vlb2A3i4+/rxXtH9DafOF6zfJtF4+dt1uwdwtkyqpOAYcRdwGbDTuFtb/J/FokhCAM4PGV6NB/Kdskqj0tc88vGhh+OZKhh6AtmgneHYHcuG6DEii6kJPe5yOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943927; c=relaxed/simple;
	bh=5e+z3nQwhdKesp6kvRgbTCAJEAEqUIxWeMEc45YVyxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hLuSVvz0J/uBhTv4wkAmGsoZEJCauLv2EjoDxwIs6OJKIcOA0wbbUAVJbI109uyh4sMQli+YyKXgj3lOXrh4yHQ/1I3pw9NUYcsjnvHTYnJOAvs/20WzhL10nQt23MY/NZM7NZ5dqhCSSHoyGppRT5cGEwxTZUYmQR0XuiE7Y5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so5354615e9.2;
        Thu, 26 Jun 2025 06:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750943924; x=1751548724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRP+AtZ05E5N1EHcHOmnv8rLRag9PNRb2YBAEj83QdQ=;
        b=fyz+xxrErgxHuwIQB+o4NR8QwnvDKqtr86lxXx1JIsmR2/jrvRh+8u+mWpDSZ1tblR
         fNRWoziyMd1E9lPqPpEPaLWJIaKykDw08j1RaUBENH/5o3pdf3zPr7tVYALMtDnlPR46
         lMl8aL00xaLkAHJylowAaao3+zOWfN0mUW1dF8cSV1XlkJSvpx0Ftb9B1rsHTtY3aSqk
         i15K2+DDc5XBx9rp4U8mNaABu4nEz1Ni5WV7BaRWbcdaxzMJ+9dU/D6TBEuTb9XX8Hn7
         CHfyrplbQ+dv8YRdLbF4p1PAtnW7IHiKU1GfBoBcTwhquKswy781Qtyrj0nzcrfjupFX
         ZrAg==
X-Forwarded-Encrypted: i=1; AJvYcCUb/ogHVjRb9cBcVZb3Wtm0KDRMgOcB5ELYNnQzDgvsEt5igOVEqxf3RRYHasKLQVDTVTM8LueA@vger.kernel.org, AJvYcCXNMxqDm/hD49AfpnFooASQSO9bcNMFP9zAhMRuCw8V+vXHToizFMN9I47ecbcfyTcMD2GBcJdOFMHxOw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdtpLvWKPftuI5AzHCGrCjlk4rej3zz29oygkad9wJUYMWgnEO
	kb+Ivzkz9IXiHdoRmScm7quIftdo/adRgyDUb63U2nRg4P6ABqeQBNH/
X-Gm-Gg: ASbGnctC4iH5n4zPu4seAmgBOLcMvUTma2lcjMTIro4iADDUdPd+Nz4Qx3jvWOMyLK8
	c9te/lWbiFwPSea4RHjkYTSJ5tJrephEn5NBSlfepCM4cIaMMFv2lPKALESWUbGGgyAHVS4UeA1
	hwX8EZIbe33rGTrKXD2oOEphttPQCCgVBorWPjeQLubmKsYfvjaq6dSFPTb1iAL29e44FcXo9fb
	++6nU2QaJvrwRKG9W/q0GeBMbLWUMVKclk8ptjwR8wHSvy8WCy0sBytB7vABgNJM+6BOykaUOtn
	w0mIL5n6qTT9qthFFxSU09QwKo5rOmn2Jc9YEt2MeVyPESIVjQgY+/yCsN64p8uL+/Oa7pSO9z1
	yaGXjEtxVj9h9SaQOlr0VwJ/hd7YoINr8+Y47nSn9xQN61KXAMw==
X-Google-Smtp-Source: AGHT+IHKjmNTilM0196y4cdwV7AIbxhI0rz9cdzfmJ87lZcx0VMfaOmiPKZyWTKYnJWNbQcEoXc6jw==
X-Received: by 2002:a05:600c:64cf:b0:43d:fa58:700e with SMTP id 5b1f17b1804b1-45381af6af8mr58865555e9.33.1750943923847;
        Thu, 26 Jun 2025 06:18:43 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f7004d001e8ad8565e004601.dip0.t-ipconnect.de. [2003:f6:f700:4d00:1e8a:d856:5e00:4601])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f22c7sm7449449f8f.53.2025.06.26.06.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 06:18:42 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>,
	fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] tests: btrfs/237: skip test on devices with conventional zones
Date: Thu, 26 Jun 2025 15:18:33 +0200
Message-ID: <20250626131833.79638-1-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Skip btrfs/237 on devices with conventional zones, as we cannot force data
allocation on a sequential zone at the moment and conventional zones
cannot be reset, making the test invalid.

Furthermore limit the output of get_data_bg() and get_data_bg_physical()
to the first address.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/237 | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/237 b/tests/btrfs/237
index 2839f6e4..25ed7bcf 100755
--- a/tests/btrfs/237
+++ b/tests/btrfs/237
@@ -28,7 +28,8 @@ get_data_bg()
 {
 	$BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK $SCRATCH_DEV |\
 		grep -A 1 "CHUNK_ITEM" | grep -B 1 "type DATA" |\
-		grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2
+		grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2 |\
+		head -n 1
 }
 
 get_data_bg_physical()
@@ -36,9 +37,13 @@ get_data_bg_physical()
 	# Assumes SINGLE data profile
 	$BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK $SCRATCH_DEV |\
 		grep -A 4 CHUNK_ITEM | grep -A 3 'type DATA\|SINGLE' |\
-	        grep -Eo 'offset [[:digit:]]+'| cut -d ' ' -f 2
+	        grep -Eo 'offset [[:digit:]]+'| cut -d ' ' -f 2 |\
+		head -n 1
 }
 
+$BLKZONE_PROG report $SCRATCH_DEV | grep -q -e "nw" && \
+	_notrun "test is unreliable on devices with conventional zones"
+
 sdev="$(_short_dev $SCRATCH_DEV)"
 zone_size=$(($(cat /sys/block/${sdev}/queue/chunk_sectors) << 9))
 fssize=$((zone_size * 16))
-- 
2.49.0


