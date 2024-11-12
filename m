Return-Path: <linux-btrfs+bounces-9511-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24889C5996
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 14:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693FB1F2220E
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 13:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BE41FBF64;
	Tue, 12 Nov 2024 13:53:49 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739481FBF4B
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419629; cv=none; b=pk+VioA8hBx+FOXIcFhjME5bnOaSujwG8QVRdcG49Fc9X/ckjSV34hpg5fHrl1mj5jQ43wQXdXho2hc/4o//sAs+F0bowOCdbNfalLLuzKHcU72jRWl4jH3bYjgzery6BQTWXY5T2emC0Yja9WvjnT2CBDo+Kr2zgJIX7VlrhUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419629; c=relaxed/simple;
	bh=GLyk8fokkwPkHdkvpzoFP8c9Kbn4Wxldzs6fm3wU49U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f0BagfllyvMn/RjL2GtGcuadaEcLM6qSyDD89ztTE5zkwdV1jhVp/HXbmj7nVmzH7EQyuWFLqxs8172bIPM2g/8Mzvg4+UoGe9dypkFGX/KjQzlhvEvGbkW7D/sBwZS0rJLKC1c7v0zwjZID84FfXcox9fV2TBm3AywINFwi20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431ac30d379so49516405e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 05:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731419626; x=1732024426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MBk2UqHU6MljeUjmB7rvbepSRPUx6cvcS1EdI13oK8=;
        b=FnZIH2UabFK5cwqYxM/k1q4tP7650zDQKtj12PoR8OnsaMLAMicnqfXJh2zNAioYHV
         qT7s77ncHqNLmjZ5ZSgYFqqIGn5/Xli/YyE7fP6LxZxfXMuaatJkAP0S5cQL5ZB0F8bS
         eKT20YB4hEiFa4VYMO/u2ZWTAoctlAXmVYvpiPjMlMml9M1SgF3bb96ycoJcUKZZ59mK
         Aewjc4WlCH2l/nRv5DJ6fTMmXv+aKrvwUSvVrhhZUgIuz92EJXhX6nP5YvW6n/gKoJUX
         y3XJGvt1Z6XvVs9n/L0cMUogDVpkbppxlJxk93LLiWXFH9voJ40HMxVXsJa54mqJ0T45
         qIsg==
X-Gm-Message-State: AOJu0YzmTpGYv45YtRboMCDqVlhUvcdQdL1zJkSAOhps4hnNLU+RmsXM
	gG8aDWYM6xt0EH3ADeT606gUXu8nPDixsB/M3Pg4hVHeYdiXaAAgF5fxdw==
X-Google-Smtp-Source: AGHT+IGhxwZ//ilmdzFRrI1VTRq76nHZ0LSxxpeF6CYkGxQXZU1Q+E8kYaiTs96dpIZAsX1MklbsMw==
X-Received: by 2002:a05:600c:4ed1:b0:42c:de34:34be with SMTP id 5b1f17b1804b1-432bcafcda5mr114466955e9.3.1731419625489;
        Tue, 12 Nov 2024 05:53:45 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f71fdb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71f:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa70a1f8sm253520825e9.30.2024.11.12.05.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 05:53:44 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Mark Harmstone <maharmstone@fb.com>,
	Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v2 0/2] btrfs: fix use-after-free in btrfs_encoded_read_endio
Date: Tue, 12 Nov 2024 14:53:24 +0100
Message-ID: <cover.1731407982.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shinichiro reported a occassional memory corruption in our CI system with
btrfs/248 that lead to panics. He also managed to reproduce this
corruption reliably on one host. See patch 1/2 for details on the
corruption and the fix, patch 2/2 is a cleanup Damien suggested on top of
the fix to make the code more obvious.

Changes to v1:
- Update commit message of patch 1/1
- Prevent double-free of 'priv' in case of io_uring in 2/2
- Use wait_for_completion_io() in 2/2
- Convert priv->pending from atomic_t to refcount_t calling it refs in 2/2

Link to v1:
https://lore.kernel.org/linux-btrfs/cover.1731316882.git.jth@kernel.org

Johannes Thumshirn (2):
  btrfs: fix use-after-free in btrfs_encoded_read_endio
  btrfs: simplify waiting for encoded read endios

 fs/btrfs/inode.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

-- 
2.43.0


