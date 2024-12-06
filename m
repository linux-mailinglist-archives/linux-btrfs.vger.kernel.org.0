Return-Path: <linux-btrfs+bounces-10089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D609E654F
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 05:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C8E1885A1C
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 04:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE7A194A5A;
	Fri,  6 Dec 2024 04:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P+xqFfYO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4DA183098
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 04:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458243; cv=none; b=AVPvT+MoccTOgzj80ylSXJAK149WFScU8O4nN+1hGIUSC0sgkegYfNKqu3RukS7Y2lvvOWYTtNk2hqiCtacLHi/bbxRhHa7WgknoufB86wCpKRUnte7911p/ms4qp974mojtK52fY+F5xTa3Imm2mK2reEwcn5dycNgAyUw35xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458243; c=relaxed/simple;
	bh=V7/lKkhMDAzPFuNdlkfXeN81gLMB4rzzuf0y3yjA3E0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A06Tll8eQlCcZt2eC18oBEtDi5TkqWxUvo1zoK2Igyao8+YtSu7ovN5MjhZ4eYfKUNQC0VZ9vKp/cvMGNIX86mKLgcseMvCMxi+RzDVgZYxBUZTIwF6lON8cq0hTR0n7Q+5SJchLFwC6KNx8+lViWwXuFytvdWPrN2RnAIHn5Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P+xqFfYO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2155c24a499so2140435ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2024 20:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733458241; x=1734063041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0IU9gPKZ0cYpxiTpLI8JVzoAjrjZPxFqYWDg1qG91HQ=;
        b=P+xqFfYOAjcuvi3EQvMz2SobiqR9F3csyExT7dpA4KKoSzC5wZxvmDlY8qtEbuH2Fa
         sAm0alTQbEHpz72FEIzR9hG/3tAO04xGpHk7mKPvPN5tiJltgVWmhleOgIUiy+F/7V06
         tCitc8SaxKVbSnXmMffCae3Fe1edy5TmAvyV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458241; x=1734063041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IU9gPKZ0cYpxiTpLI8JVzoAjrjZPxFqYWDg1qG91HQ=;
        b=PaxjIB4oXXP8+2F9uJiY14nezfW2rcdePzFIEx+fSnYQjpjTFCdWh1FRcTb8oj9btf
         vjsQJPvmgRqu+7vIo9aq9tNsycm7+rXk+DzSMW6eUxyBQ5Dfs/F11yqfhXfJTdxv/c66
         r9LM626Yn1sBIQl5eqcziCMXLFED5RTGib2dc0Oyln8hS2Lk8dMnZzVXrFMQNALGcBxr
         cMY0x5+c2uU2mhNRHxYBN0Fd/1Xr2/YZrXEtA6e2pyvVtq1DKL35p2tZ0Qsly/XZkIkw
         F50ZY8PAG4ylWV+UyJqDiLnhZWJM9cpZKyanqPCsxYFsECTHEEP3mV0YRM1q/6bEf2ZO
         eeeg==
X-Forwarded-Encrypted: i=1; AJvYcCUuHGjwsMCzIqB2UNGE66GOdRrwEIRVYuZcnXKGDvhcLzCXX4TvCCSyoHRURoi9cSXOkTwFf0EZAGP7MA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYljaKFYdsZaKvY749wM1AeUKv22/EXs47BsoaIS66iCxNTiQg
	8H7WcOdZfp6sAja18na4i24CUD5Vy5x5mOaXtYJyFnc6tD7aSwTc3f65X5EJ0w==
X-Gm-Gg: ASbGncvKGnPXsJWivunSCUyem1NHUYOiWMrh16np0RFv9Izq34aUIXICY/A1ZHdjg3p
	LSWZvG+pxcBuJybQeY1H3+omxYD2/aA0Waa6qnjJ4vikPXrGXt0QJT+tE2+A7ysWwiXTGSPQs3o
	8ykOJZAxboVTDb/ea3eY1iAcQE9fsU4sWl0CKeW0nj+dck4pImT15/VSqpe/cVGu2VXBg1J3G9e
	veyWwdyAuobxuzT80hOpe55FQwH1JAaAOr6Oo4eqxkwXpBLP2Yg6tqK58SD6sqXNe9UAKzeGq7C
	NgqVB5IpvjurisDPXQ==
X-Google-Smtp-Source: AGHT+IHIPKNeut07aOTI89zxMd3Vl+EMqCNUz246+xUnyar4QNLZ+a1aZ5TrSWJS1HODt0F85bhzoA==
X-Received: by 2002:a17:902:da8c:b0:215:7ced:9d59 with SMTP id d9443c01a7336-21614de3df3mr8726785ad.12.1733458241448;
        Thu, 05 Dec 2024 20:10:41 -0800 (PST)
Received: from kk-ph5.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3e807sm20053675ad.57.2024.12.05.20.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 20:10:41 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10-v6.1] drm/amd/display: Check BIOS images before it is used
Date: Fri,  6 Dec 2024 04:10:37 +0000
Message-Id: <20241206041037.4013334-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 8b0ddf19cca2a352b2a7e01d99d3ba949a99c84c ]

BIOS images may fail to load and null checks are added before they are
used.

This fixes 6 NULL_RETURNS issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 9b8ea6e9a..0f686e363 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -664,6 +664,9 @@ static enum bp_result get_ss_info_v3_1(
 
 	ss_table_header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V3,
 		DATA_TABLES(ASIC_InternalSS_Info));
+	if (!ss_table_header_include)
+		return BP_RESULT_UNSUPPORTED;
+
 	table_size =
 		(le16_to_cpu(ss_table_header_include->sHeader.usStructureSize)
 				- sizeof(ATOM_COMMON_TABLE_HEADER))
@@ -1031,6 +1034,8 @@ static enum bp_result get_ss_info_from_internal_ss_info_tbl_V2_1(
 
 	header = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V2,
 		DATA_TABLES(ASIC_InternalSS_Info));
+	if (!header)
+		return result;
 
 	memset(info, 0, sizeof(struct spread_spectrum_info));
 
@@ -1104,6 +1109,8 @@ static enum bp_result get_ss_info_from_ss_info_table(
 	get_atom_data_table_revision(header, &revision);
 
 	tbl = GET_IMAGE(ATOM_SPREAD_SPECTRUM_INFO, DATA_TABLES(SS_Info));
+	if (!tbl)
+		return result;
 
 	if (1 != revision.major || 2 > revision.minor)
 		return result;
@@ -1631,6 +1638,8 @@ static uint32_t get_ss_entry_number_from_ss_info_tbl(
 
 	tbl = GET_IMAGE(ATOM_SPREAD_SPECTRUM_INFO,
 			DATA_TABLES(SS_Info));
+	if (!tbl)
+		return number;
 
 	if (1 != revision.major || 2 > revision.minor)
 		return number;
@@ -1711,6 +1720,8 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_v2_1(
 
 	header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V2,
 			DATA_TABLES(ASIC_InternalSS_Info));
+	if (!header_include)
+		return 0;
 
 	size = (le16_to_cpu(header_include->sHeader.usStructureSize)
 			- sizeof(ATOM_COMMON_TABLE_HEADER))
@@ -1748,6 +1759,9 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_V3_1(
 
 	header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V3,
 			DATA_TABLES(ASIC_InternalSS_Info));
+	if (!header_include)
+		return number;
+
 	size = (le16_to_cpu(header_include->sHeader.usStructureSize) -
 			sizeof(ATOM_COMMON_TABLE_HEADER)) /
 					sizeof(ATOM_ASIC_SS_ASSIGNMENT_V3);
-- 
2.39.4


