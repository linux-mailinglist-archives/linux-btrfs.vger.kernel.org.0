Return-Path: <linux-btrfs+bounces-5284-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 407E28CE8AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 18:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7113C1C20DC9
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F057F1304B5;
	Fri, 24 May 2024 16:29:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B9912F379;
	Fri, 24 May 2024 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568164; cv=none; b=Sbt6Xz16eQREO2Lu86LGQeECHWOVetT0wKiUEon6Nn0JoPVZ/jyGqOCgcE+JqGN4RkLWyGkL3cTDNarS0TGgomkknPBVaj1RMu0WBnDwJvu9vNLu267mEMwHX4ZAnK1X108TvL7VNPCNK2H9eaHYptaA0ik66YG2Cgtdp39QbIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568164; c=relaxed/simple;
	bh=5G5uWfklwXWEcJqX7Pw0n5uZ1WJNb40W2UmgyAm29JQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QiAAaqFdTX2tR1Xr+a7uAvigIXMnn7jBCl4R9iILYvLzyNRCLrnIXO6u4xIc29BBIzg7TZnatpAc1r8YPgpzSkTvEbL7W7YRhC9x2DkT2XrnkLrxPPTsAZ5h9ZpgTR80QRq7Y0eyN4yqFFz5QIrF6A0HtdX4VwKIJG7q6NskIqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6265d3c488so151220766b.0;
        Fri, 24 May 2024 09:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716568161; x=1717172961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9xclb9ceXdQq7EaQnlGqtUKMBYODgOmJE/I2l+5E94=;
        b=dFd9iHkx5GJ9JNcTiudX8GieQM/7ZIaYfBwZPJy0xHU9pqv8mJHm0eLcIM2FMgymUA
         7ppPGdmIKEMjo7RoCNLXUL+RcbMpLb7IL151icB+m7KdeHIC/9Epg/AJcpXB7S9SYR/g
         2pr8Tlp3uYLoBqUQeIY6WTOMc6iki9AcvSKKOdhvZWj0YjJFwpnmJRw4qlos5X44IHy8
         vYV+AJ75y/kJn8d5A+Xthy8cvZTiY/bAOkBeM1BNr5IGsAQHMFZ0lLpcha/w+371taNO
         bYVS90Ws7e2/HR/nnCi2kR8IG/QPzoPW2KEIxrLXvg+iKRKgbqXDxaIqUdwDggepRiZk
         PU9A==
X-Forwarded-Encrypted: i=1; AJvYcCXfPT57iSsIo/1trUFqopoisntCs+5EKm3DwSwEaiYEQYrVSWSgEpBxs2j1xboYY8RVSqmx0mzXjAcTPJVOwirFI+EZE1UbwmpiRNr3snVzGC3BX0A01wO8Dl+j3nlKvSGamZbJ7BSrIPA=
X-Gm-Message-State: AOJu0Yy91K/XNMN8IF6mYUNWakI/W2Kb4bOe6qzrKsGQSExSn6IOawxh
	3L1nogZ1n6Iz+N53t0JrA1glJM4CKAfUr97TgMlIJhNOZAVUjNKm0tvfW0LG
X-Google-Smtp-Source: AGHT+IGavU2VZlVAgY5m2d0Rtm3xhjLhJdy09I/YWACUhDdCBVkLAg67zh0gMHQbokYbZtwwphA1wg==
X-Received: by 2002:a17:906:e09a:b0:a59:a2f0:ee51 with SMTP id a640c23a62f3a-a62651199f1mr277688566b.54.1716568161036;
        Fri, 24 May 2024 09:29:21 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8dcb2sm154137066b.173.2024.05.24.09.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 09:29:20 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Fri, 24 May 2024 18:29:11 +0200
Subject: [PATCH v5 3/3] btrfs: reserve new relocation block-group after
 successful relocation
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-zoned-gc-v5-3-872907c7cff4@kernel.org>
References: <20240524-zoned-gc-v5-0-872907c7cff4@kernel.org>
In-Reply-To: <20240524-zoned-gc-v5-0-872907c7cff4@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Hans Holmberg <Hans.Holmberg@wdc.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

After we've committed a relocation transaction, we know we have just freed
up space. Set it as hint for the next relocation.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/relocation.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 39e2db9af64f..29d235003ff1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3811,6 +3811,13 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	ret = btrfs_commit_transaction(trans);
 	if (ret && !err)
 		err = ret;
+
+	/*
+	 * We know we have just freed space, set it as hint for the
+	 * next relocation.
+	 */
+	if (!err)
+		btrfs_reserve_relocation_bg(fs_info);
 out_free:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)

-- 
2.43.0


