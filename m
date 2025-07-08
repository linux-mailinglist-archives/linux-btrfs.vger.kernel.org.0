Return-Path: <linux-btrfs+bounces-15342-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC000AFD849
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 22:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA335846DA
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 20:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346D92417F0;
	Tue,  8 Jul 2025 20:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ej9tjHnw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28F123B633
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006144; cv=none; b=S9zh4PGWq00gqDl+VUOV3YxGG7laxKIZFAl415gj8ERUI0pzD9N003NSJcambRZ/evfJg97c4E1SpCYcr57S5Za4Q+/sQdBQsxF/+gkUhk1jsZ0IndDx6ojuv9jkz+aythO7ehl3rzdCHutsKcmTsbcZR2mS7bJ7Bdl/KICebkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006144; c=relaxed/simple;
	bh=K4VZVi3xDLWT0DEl3LNGUBjrD17+mi5NFECXhkIiWrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RllNDZUS7L48Obsb5dRfx3qRviOswsXW/0gOd57U4IcWEAoy3UUTpXWvKWyabZraqr8IvKcnFhxiPXGBiet6nbJs58iwl48T/eEQwShPBjqTFLkKuS/6klOrBrUUcROWEBzZ4j2kMYXF0UERSeV3v5ZExbywcg8e0H717CkyS0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ej9tjHnw; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-86f0b9937ddso19082039f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Jul 2025 13:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752006142; x=1752610942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pd50J9nYsG0TeiIeJPqTSZq8OKqwb6u/EH2G1EHnbLs=;
        b=ej9tjHnwPQOvu2AwCbPDthCD2tzHNrSkl0T+E2Onn88MUdrXwzHOOSjIyBg6fliKPF
         sf9ZqSzcP9h7gMmdiJldzni8+95nnAh6K/V2t+VRnJQWAj2UBybfQvPGd4AFMhPfUZAV
         kVOhkfMrO3sXnh9mmxgrzOmfmpMN1A7ODrCR3BwLLZ/N1HmFmQKfvE8g1Ci6baKUw9xt
         whe1OJ2tA8CUjBb5Zjkp5oogYjA8p8LljYlOqyFY9hizuvg4yLBdYcsDJLOG/PMbWNOt
         NWFWQr/8gdRnfQLjFX8a3XQGtACUfCSg6vPhjZEwvjy10fsUK91g96hqCmqC0jn96Ut2
         1gcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752006142; x=1752610942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pd50J9nYsG0TeiIeJPqTSZq8OKqwb6u/EH2G1EHnbLs=;
        b=cLAeEq3yi7JAU1nVCc975OL7spOpaKX6lNV3YMJxPHh+KALtu35cOiPSIQTfPfC1rH
         51tFyHLCYShKkUhxdbz0XFJ4jh3439RTfU6xWBKc+Wz34DwE9HJFUoSLUOecgNiusfZL
         1je+kSJJB7KXF0RBvnxR9xfmT8C9TmZ3wdD0zR9Dn40JoblO2YcEogoNXG5GMxd8NcXo
         x8fp8le3LWVmKTzNkfnpDOvdw99b85TRtAfBrA8DFjjaUUKyO0T1bAtkQL8ApReYHKzJ
         89opEemawsJ71asw1XqvmfwxCvo93HE7TG2ZhQhnI0ubISfHKHU48dS4lHdkNFjnsRUI
         +npw==
X-Forwarded-Encrypted: i=1; AJvYcCVRvnHtNklz+hOrqVnbEMDAqYHNGa2/eqU5LaBf+LVlLaSaPS8yOHraoZCVpm+WTnZ86hlER+Efssfa9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDGWNl9eWPsil4CE9Ojb7GJhQoCUo2ZIZzTP2sUear7M66jYsG
	+JJrxcmfqYiW2+84H7BiW3rllchAzwf/XgoGpSTRl/kBOZeG2SFhZkV2nJZG3rywH+P+DS/d+vr
	EtKxjvwwYxsvaCcHaR/T7GJjPerVjPlSI62BF
X-Gm-Gg: ASbGncuDbjlF/eorh/U8pcUGvZYpxwPwGrfS5wd13+40vjlv/vpqRJ+8XpJkVFpAn9Y
	WTdt/rYRqYIL2ihm4qUfMPJEFaL/069JlewM1xekoii1VTQHlkdCIAPv1YO38QcRQP3UZAY2fhF
	uC2rD1oi4Yb5va6NX15uVhFtRlfoX11BSVtufB/XzGyzrywTC4W1t16PKehN4pFpqWJkFIXMx/D
	+sqv5CNBN5hfBGolPSkDmiXk48nrGps2bwO7FN7Q7tkVHyDeQqcCGDR0BYxFGFWgD9ZBMYPgE44
	cx5xeM0Zs8kIh2SWmq5HWGZzDENhJ6dQFj14nYciN0PNw8Ulha0SrXo=
X-Google-Smtp-Source: AGHT+IG+alU718jhrtLgwSBCn0Hg1VyWjiAmiqngDIW05UDrmRiP8JyfLGPlu3WX7iH1exrAX1XOBeOJ74cm
X-Received: by 2002:a05:6602:2cc9:b0:876:a91a:9076 with SMTP id ca18e2360f4ac-8795b08bfcamr2487939f.1.1752006141957;
        Tue, 08 Jul 2025 13:22:21 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-503b5a14ca4sm385101173.26.2025.07.08.13.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 13:22:21 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 20B8F34050C;
	Tue,  8 Jul 2025 14:22:21 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 1E893E41CDE; Tue,  8 Jul 2025 14:22:21 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Mark Harmstone <maharmstone@fb.com>,
	linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 1/4] btrfs/ioctl: don't skip accounting in early ENOTTY return
Date: Tue,  8 Jul 2025 14:22:09 -0600
Message-ID: <20250708202212.2851548-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250708202212.2851548-1-csander@purestorage.com>
References: <20250708202212.2851548-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs_uring_encoded_read() returns early with -ENOTTY if the uring_cmd
is issued with IO_URING_F_COMPAT but the kernel doesn't support compat
syscalls. However, this early return bypasses the syscall accounting.
goto out_acct instead to ensure the syscall is counted.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 34310c442e17 ("btrfs: add io_uring command for encoded reads (ENCODED_READ ioctl)")
---
 fs/btrfs/ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 913acef3f0a9..ff15160e2581 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4827,11 +4827,12 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 
 	if (issue_flags & IO_URING_F_COMPAT) {
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
 		copy_end = offsetofend(struct btrfs_ioctl_encoded_io_args_32, flags);
 #else
-		return -ENOTTY;
+		ret = -ENOTTY;
+		goto out_acct;
 #endif
 	} else {
 		copy_end = copy_end_kernel;
 	}
 
-- 
2.45.2


