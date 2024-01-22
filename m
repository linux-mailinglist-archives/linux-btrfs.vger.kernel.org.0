Return-Path: <linux-btrfs+bounces-1601-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A350E8363DC
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 14:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464171F24423
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 13:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9CB3CF45;
	Mon, 22 Jan 2024 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YY3V4cLS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E0E3BB4D;
	Mon, 22 Jan 2024 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705928468; cv=none; b=LDDDIIVmwQ14BiiKPiZ7IsRYFHicFXM3uE6duZ0rqIZet1AH8IKNL4qVCQUYoUsP/JqSZGoks81V6cUQeIFSJshOXqn4sf3lMT32P0xHlVLSGwcYAtTneK9JV85FeMXDIO+/wkZQMsgUMQTH5pHjq/oO3OcTdd+wN+9u3yf+9Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705928468; c=relaxed/simple;
	bh=fl2xXnQa6YlOMJIZJL+fO94USkChOHRh2EKFrznETKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iM1xfvKrvCJlIXA9o7sSovM9AC2VLcx9lV+J0ROeUThw2nAKTac7jI6iaprh/5xgaNJH2GxgqlAcOILqRCi/j9E2i8k3rEzhInxsTX91mQpzzO69lch/5S+tVloS1VZBhZ87M/nM3sImKCutJfxch258ElTWdmrB5ZclyC7ZJGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YY3V4cLS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40eb28271f8so726625e9.2;
        Mon, 22 Jan 2024 05:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705928465; x=1706533265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XAJ8FE6Irq3MVRNXBwtWFtBDH+famfj4zjNOlv+xyw=;
        b=YY3V4cLSBgXL4uNcadaHK0VfPqm6SdEA8XbEfEgp7gRAbH//x+y5tEvY30cu17ks4f
         h3CD4X3h9Eu13KDGHO4/RVrXu9G/7wmCBZ4IbCB+jFfWJwTdt/U1nIfc5naj89CpISDL
         WyDTt9+16auea8k7kBiAnTb4nb00sSZ6VGDIfSv48U9sjG1VNsZfTB6F0D9JHkPiAara
         o1u7zgyuLB8CFE53RAGoySQy0hf0v0jeDIXu2xrzCVlNuVgbtUC42OwTeUVuVyF4TzA3
         NJ9HCHMKGWTyfvyW4elAtv2IfhCvJvhmZUDr8pphIaN6VzsZ1crXXpkoFMLkC5SMlWMo
         senw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705928465; x=1706533265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XAJ8FE6Irq3MVRNXBwtWFtBDH+famfj4zjNOlv+xyw=;
        b=dIsj0WBpz25rBr+O5au4OxS1O2N64uicnor5PHlAr/vhgGiQCAYlQ5FGNuX3diiEUH
         cPf0lsmiBhGQUfFwAQ+kGo0GzS4Gn2naTsen09wi2w1j7GI+5Gss3W4ep6HooHGiEo09
         4JdYKtaQRV1q0zAShMUCZoFsfgP/VfULy2DLh9PA+vAgys1uIhIVljkqY77Nspdo+JGT
         sCoNjFTWO0vkCYz5HQzImSrwMahddYqXK3l2EdZCzbpo4iYC4IIpgTuI4I+RTWRR/Oji
         L7I/vLe+Krw6vTQg/7p/us3fTPVM4YS0rL4W970AR7Nhy3P6DyIMqbvRR02GqZX9a6hR
         s63g==
X-Gm-Message-State: AOJu0Yz5qUXkn/ByrpPPla7Kuudmx3B2vxcL1y+npha98Z35plFjrylH
	MPKOYc/u3P0mNbRwiT8oIBqm+L6Npv9Vk9Of9B3lj1JEjWTJFqwoVGKWg50H
X-Google-Smtp-Source: AGHT+IEJ4+Q+omfxhqNsxVHiZYnrsPNaBXBGnfICi2tvMPXcdUzvpTUuR5fLNAguJndAJGcQB4hc2A==
X-Received: by 2002:a05:600c:1e85:b0:40e:8a59:c3f7 with SMTP id be5-20020a05600c1e8500b0040e8a59c3f7mr1166331wmb.194.1705928464880;
        Mon, 22 Jan 2024 05:01:04 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c4ece00b0040e8bf3c9a9sm18369814wmq.21.2024.01.22.05.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:01:04 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] btrfs: zlib: Fix spelling mistake "infalte" -> "inflate"
Date: Mon, 22 Jan 2024 13:01:02 +0000
Message-Id: <20240122130102.3157773-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a warning message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/btrfs/zlib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 8da66ea699e8..e5b3f2003896 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -398,7 +398,7 @@ int zlib_decompress(struct list_head *ws, const u8 *data_in,
 
 out:
 	if (unlikely(to_copy != destlen)) {
-		pr_warn_ratelimited("BTRFS: infalte failed, decompressed=%lu expected=%zu\n",
+		pr_warn_ratelimited("BTRFS: inflate failed, decompressed=%lu expected=%zu\n",
 					to_copy, destlen);
 		ret = -EIO;
 	} else {
-- 
2.39.2


