Return-Path: <linux-btrfs+bounces-11466-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52082A3618A
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 16:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EB316B897
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F92526659E;
	Fri, 14 Feb 2025 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chVQOsxA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2F7264A61
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546619; cv=none; b=WxnEGSg7ZUgmgqmOYKDujSVUko5iTJ1MDUVxNMD3rJcW2SVTTghB51zUS6FWQRFxSKT4xTdfE+e4fBDiOqw7zhT5vb2ho6aSLfeCetOIVAVDcYcF36RlbhRRKHOm9uAKybZ/4TV2n4rpMtYnONZH508TipHjcKtdJtGCv5Ts8n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546619; c=relaxed/simple;
	bh=T8L4gxAuIsLt2SxqxvmSYumtmFNn9ksp/CHPuXUi2f0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iN8rIYOYy92lK77PmNaovtiTy+o3J576tG8Zrp+A/SxvmNvY0X1ehBmkj/1gy8hhH2D4I0LES9J7tthGRY0oHj1knBaerg+SFVS2roW/NIzkYSjL3h+XQ4lOIl2hR0XTT6uNW9q34P8sjYEPnhft47IcBIRfeuHgZZpyajCrdHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chVQOsxA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38de17a5fc9so1180455f8f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 07:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739546616; x=1740151416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iXzBbR2h0B+PF3D3ckq0SRrx4fBdzEJjvWCU18w4dWA=;
        b=chVQOsxAPOEMN9dFFU0Jmk5dswGhERPQo1lO49lan5Qc0uyfdBv27SmcDPDXj61GA9
         xoTio/dcV24/dCGBCf8j6BSJhzZ/DcYOD4so+xzvo6G2GjhXHi1bIymaRxP2S927HTRq
         F8at9OtFs61b2rQ5KttkHIQyzxnohsc3cRD2pYSM4nC1hBbmJ71lrZJynj4tMWOOtlpB
         qDz8D14L5v3dWmMHyZXKvhauPaszvkwcli288pslJ0FRFDvCQyHUF9XuzUgyGpJTly96
         q2upH6YCmREp1JIA13vLMkVZeOErBZYCpog8JUYCCAtgTzM+CfmyJLSefinDHL662b7c
         BvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546616; x=1740151416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXzBbR2h0B+PF3D3ckq0SRrx4fBdzEJjvWCU18w4dWA=;
        b=n6CzKdbXEdUZk57SXrZP51NLb0YA5XlaSJ9YKHOnVfCdz81YkjFNvyhcwDQU8Fp4+q
         MotsKU4AjNcvvL4hYGM2BMF714WMhtOmizAd+AC2GMJKtxsSC0JPjNxyoIRc3n4w37I5
         nhO2Hhx6UDCbZKOGLmvTLcDEipDtDItW2lS+2YzwBgDIsbs+Kk7ZUzSpXEG1K0cKoPeV
         7ByOl9lt/+8UChTaoI4HqbpzQD6PXMVCu6UeA90gUs62B2ONRlCaXOGk/9AGetgC2lA2
         scigE0+5KsEB/AZmLMsy+XOrWT8MDpMQ4GK1rDPP4XkprFDDbnajjQ5MhtAqBS5i/nhA
         +J0w==
X-Gm-Message-State: AOJu0Ywxew9x1QblAWURxl08RuuB4L8xmJGb2nMxYd9X2J2IYVUGML9K
	OGAffKSbQIcMyw8DPuQJ/fw9lYFdL2P6twgLNcL5HIQcGoFDLLA5LAY/Rw==
X-Gm-Gg: ASbGncvNMHbmoVZMQUTwhRZfn74rB/lfOg/ryjaY31HOFDACqQwu6DEzdxYCMOeQNnM
	7kOcQnJrT2ot9vlJBIVfyFcW9mol/XV8mPloGugOJFO/xVcWdG4icyQUdNLl6kiIugQcquhq3m0
	kSvuezhKIL+QCMjHeKdkPazvcGzDKiy154oMDHnNFXGZEsfVOuF15w/+d4mBc2nusLAYYQbP8uR
	VIUmL+gw5kYdsHhOjPDOgK1KdTN2zIgNcOY0MvqAASnqxmMg0vYf9c/NkXQTLJHWc8uEM9SbRpU
	Yfe3hy0mGCoA
X-Google-Smtp-Source: AGHT+IE5/dO91XgiL0lf5GA9E8o8cw5EerEGrGGcJOArS1JuKuSqTscpSH385GpjxZeTBWA796PWoA==
X-Received: by 2002:a5d:670b:0:b0:38b:d824:df3 with SMTP id ffacd0b85a97d-38f244e9333mr7810408f8f.24.1739546615941;
        Fri, 14 Feb 2025 07:23:35 -0800 (PST)
Received: from 192.168.1.3 ([82.78.85.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dcc50sm4984504f8f.34.2025.02.14.07.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:23:35 -0800 (PST)
From: Racz Zoltan <racz.zoli@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
	Racz Zoltan <racz.zoli@gmail.com>
Subject: [PATCH] btrfs-progs: Simplified unit_mode check in print_scrub_summary
Date: Fri, 14 Feb 2025 17:23:32 +0200
Message-ID: <20250214152332.20057-1-racz.zoli@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extracting the unit_mode == UNITS_RAW check from the current if/else
statement reduces redundancy in printing the rate and limit values. This
also will make it easier to implement JSON output formatting with less
redundancy in the print_scrub_summary function.

--
 cmds/scrub.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index 508eafb7..f769188a 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -209,30 +209,18 @@ static void print_scrub_summary(struct btrfs_scrub_progress *p, struct scrub_sta
 	 * Rate and size units are disproportionate so they are affected only
 	 * by --raw, otherwise it's human readable (respecting the SI or IEC mode).
 	 */
-	if (unit_mode == UNITS_RAW) {
-		pr_verbose(LOG_DEFAULT, "Rate:             %s/s",
-			pretty_size_mode(bytes_per_sec, UNITS_RAW));
-		if (limit > 1)
-			pr_verbose(LOG_DEFAULT, " (limit %s/s)",
-				   pretty_size_mode(limit, UNITS_RAW));
-		else if (limit == 1)
-			pr_verbose(LOG_DEFAULT, " (some device limits set)");
-		pr_verbose(LOG_DEFAULT, "\n");
-	} else {
-		unsigned int mode = UNITS_HUMAN_DECIMAL;
-
-		if (unit_mode & UNITS_BINARY)
-			mode = UNITS_HUMAN_BINARY;
-
-		pr_verbose(LOG_DEFAULT, "Rate:             %s/s",
-			pretty_size_mode(bytes_per_sec, mode));
-		if (limit > 1)
-			pr_verbose(LOG_DEFAULT, " (limit %s/s)",
-				   pretty_size_mode(limit, mode));
-		else if (limit == 1)
-			pr_verbose(LOG_DEFAULT, " (some device limits set)");
-		pr_verbose(LOG_DEFAULT, "\n");
-	}
+	unsigned int mode = UNITS_RAW;
+	if (unit_mode != UNITS_RAW) 
+		mode = unit_mode & UNITS_BINARY ? UNITS_HUMAN_BINARY : UNITS_HUMAN_DECIMAL;
+
+	pr_verbose(LOG_DEFAULT, "Rate:             %s/s",
+		pretty_size_mode(bytes_per_sec, mode));
+	if (limit > 1)
+		pr_verbose(LOG_DEFAULT, " (limit %s/s)",
+				pretty_size_mode(limit, mode));
+	else if (limit == 1)
+		pr_verbose(LOG_DEFAULT, " (some device limits set)");
+	pr_verbose(LOG_DEFAULT, "\n");
 
 	pr_verbose(LOG_DEFAULT, "Error summary:   ");
 	if (err_cnt || err_cnt2) {
-- 
2.48.1


