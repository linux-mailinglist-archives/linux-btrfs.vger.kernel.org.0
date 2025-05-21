Return-Path: <linux-btrfs+bounces-14147-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD945ABEA71
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 05:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFAF7A71A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 03:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80E022DFA3;
	Wed, 21 May 2025 03:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaA6nMuQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D801322DA1E
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 03:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747798077; cv=none; b=uEHNDTDiJ0JQgoloDjCpKITv3wfQk8HjcEcdTA0eVwWiNeHcNRhVlunXE/vwxIA5wEBgRKhhIko3A/Yg0FGju1uiS071mGfm/IGxw1WaS3m/hU7scpIioB+U85p6NJrRXRTT17KbxSRJGg0dgoXchxhLepnC9zfXyosNLLVJkvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747798077; c=relaxed/simple;
	bh=3LECIgm8GyRWTEtsT+yvM/xxkLHpTkv86MWLBJ5kVm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4vP5jw+Y6EnRLUOjGzpPKAQnfmFykBjeYFXAPHtHRsM481oOc5Cb9Rba8Nqd2JlDuTyqUSEX6lWYUCHbsEweYhLNR0peG7qJK99vpjnknFjmlm0f2iD8PVKzHJWyzNqEP3FpZ6qYgVt22maHguSaZrHAYzoYX9qQngfSZ6m78A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaA6nMuQ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742c035f2afso2396831b3a.2
        for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 20:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747798075; x=1748402875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdLw+K3zBsTtV08vuLHB9cRbzerloBQaloG2hU1OluE=;
        b=CaA6nMuQV/TV9CfunWmLKylikpZ2bHPedwHGTRsXj3qeU9+zgkYExhbWEHsVN2PGYk
         diSx+eMdXTIpIAtgewGI8cINxn6IarnAoaSMY7mheQib71RI8SBTtC/VSdvkeaJA4XZE
         zK8+actuPS97+FRxaZwVaCGiZtwOj8Xac+TvoMvhJV2JnpPYkD9uH80SaInRPa5Kjpfx
         wr3VnYQjLrsPPZL/j0NtTKRoStEO8yn/NAA4Q+wr8yKVbzD0gzNeqk50VWpOiw/HcEaQ
         y44gTSs5iZOzCu0TagTZ+4+zsLdfesC/TLjyx4GuMfwavcRU/Z7fD+1SNAqKoFNdKB/t
         nXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747798075; x=1748402875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdLw+K3zBsTtV08vuLHB9cRbzerloBQaloG2hU1OluE=;
        b=Wp4hXbFtyd8K/LVlv0EvJv21HR9CLGccdtgo745z25OPbbVWvsyUbAhB0R6/XTKHHC
         ZJN7RtAMpHHxthPILA8XfFLa3+pYgf6uspk4I4c3r+DPq9DmD2XVkWyOjTCu0RB8WIYU
         kDDUs80VjJHcbDiaB4hDvwWDTYQksyl0RlICvjgBfJvVaUS6uSaYuQePcPQdZDyFzWmq
         bKnQU/bjvhNPelErko+96/zFvbgyvgToulEAF1D2hI6oxh6h9wD1c9FsDHf7sDd1oyEq
         r4IQZBStiy2bfgiJ2Iyf8Pwcpqr242Ayp6OARjH8sasDce5gwJoGVi8dgUZhFtKdV6fR
         nP+g==
X-Forwarded-Encrypted: i=1; AJvYcCVC+t1ypx6bG3zF8I02HOosMQt59k49epFCcnRDbZrddAgl72dySerd9D2/MFAosBy4eUfph4mxaqn+4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpc7RCs4cAhzrhvvJdCAyWbr7vsgDcN2408Rkq8fT1i0d3djW/
	IrESU1yqVzhySO3D7/DuDJlbTfaMx7AxoswPud5MVJPaCsU8GNR8UN6D
X-Gm-Gg: ASbGncuIXRCbX8oI1weOt36MV3S1sJvz+VKskREHrAJt16C6/qHMGhnIFuothwZAOie
	FMi6I56+bvKznC+JvaaOkj2/JE+/hZFEyobbeMe9Nnm09xA34FJU8Nk4ut02Eny7NC+p0lvI5vB
	93fujKAsF8rWoInyDuqSE2U/rJPLlUotFpTCuaeD3fBE0dpoK5/afEm3EOJoYgS5XQmMsivemjD
	lq4vg8/2kL24u2YXX2KYiS+3HrUuX9bYAzjXD/2g0+SdKUI6Zs8b3/syGZotfO65Ujc8brV6bRV
	8WxT+ex7nCQNm5R61MSVvl9myxN3PPXwzXOs2WZgR/RXrGsVcw6Iz7vyOnPrg/d+Nof/wcBRepC
	g7hs8aAlp
X-Google-Smtp-Source: AGHT+IEoj6yutjp328X7oBLhygIHPN388q+pKah8RR3AG2vgFAzZzDKdJ5ag7lWWpAkU0z1f54P42w==
X-Received: by 2002:a05:6a20:7f8a:b0:215:d14d:6626 with SMTP id adf61e73a8af0-2162189e1a1mr24378625637.12.1747798075025;
        Tue, 20 May 2025 20:27:55 -0700 (PDT)
Received: from koga-vm2.kern.oss.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98770c2sm8677379b3a.150.2025.05.20.20.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 20:27:54 -0700 (PDT)
From: sawara04.o@gmail.com
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: Kyoji Ogasawara <sawara04.o@gmail.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: Fix incorrect log message related barrier
Date: Wed, 21 May 2025 12:27:11 +0900
Message-ID: <20250521032713.7552-3-sawara04.o@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521032713.7552-1-sawara04.o@gmail.com>
References: <20250521032713.7552-1-sawara04.o@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyoji Ogasawara <sawara04.o@gmail.com>

Fix a wrong log message that appears when the "nobarrier" mount
option is unset.
When "nobarrier" is unset, barrier is actually enabled. However,
the log incorrectly stated "turning off barriers".

Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
---
 fs/btrfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 012b63a07ab1..0e8e978519d8 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1462,7 +1462,7 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
 	btrfs_info_if_unset(info, old, NODATACOW, "setting datacow");
 	btrfs_info_if_unset(info, old, SSD, "not using ssd optimizations");
 	btrfs_info_if_unset(info, old, SSD_SPREAD, "not using spread ssd allocation scheme");
-	btrfs_info_if_unset(info, old, NOBARRIER, "turning off barriers");
+	btrfs_info_if_unset(info, old, NOBARRIER, "turning on barriers");
 	btrfs_info_if_unset(info, old, NOTREELOG, "enabling tree log");
 	btrfs_info_if_unset(info, old, SPACE_CACHE, "disabling disk space caching");
 	btrfs_info_if_unset(info, old, FREE_SPACE_TREE, "disabling free space tree");
-- 
2.49.0


