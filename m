Return-Path: <linux-btrfs+bounces-9608-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65D39C79C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 18:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2391F25126
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 17:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2D1201020;
	Wed, 13 Nov 2024 17:17:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21F13049E
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731518229; cv=none; b=c3RblQdZmOHhYaV3WVyf7pgKnu6iWhxEbwOxtslcWLjNx907EQSsBsiOKAYzJhKdO8ookZZpUduUCr3I9f+9mWt05Tsqb7m15ipXJVBPiPJHfA4VRhxj9xErkWTBvPH0lcMwRTGokVJ7OBCX5/FQYJiKm/BxVA5BVPKipMv0+K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731518229; c=relaxed/simple;
	bh=IazVcStP5bobA11f9ug085ypOv/hZoBLiSfWpqeWnq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JlD9wJNf1yrbQ8ZJfY7to4hPo1fDwB3JyoTDGYAkh6QGcY6IDthXTcOa6bojCtNrxRzwzSTxB+rnuiqPer+HO9/s2PgW41qRUC3brrs7IOq9fD271nX2+JEonohKIZWv6q/voaTG4gkTpPKkcvp+4RgtkAK8tOQWKyJXjpkG/X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so62111855e9.3
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 09:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731518225; x=1732123025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qaq/tcAJFJZMYQ1iGqxkweyrMZ5E8CEYx0WIaKQz24Q=;
        b=Kr+UxMDfZVJ46NpKWrPKCbxhxAFr3oJARBhxUeqqawtjnRcLvldsVdsM6nUCiAhuXI
         M90EmdhlIQrwnpVDZqYxU8GQHhKfKcdysHhSFWAUfQGQGO/ArS7OVAhE4tZ/TamoN1he
         slC5z2JjiUxnRGWoWn7/nhSjck772Rgwh1kS6gmprhddY7vLCDQh6u892OEJs67usR7X
         eIoJTadbaVRQeS0KnVpb9Amodk2LN8RGo0OkI6YI+nUxJy9+Ii74Vohe2jl2jQ7PqVcD
         GPxq6INuCa4pJBf5YO6UomKhB9FlT/Szsc28xSONHABLwx6MHPP++KMP9D7cMpygRSHg
         BaUA==
X-Gm-Message-State: AOJu0Yz3QZzLKuXyWI1CCbDHADL+JnX7X5R3wvrYcPCSM4tZ5QqlF1+d
	Llt9LuwjokyGsfbULeWwKimLQYLgNQ4MwTOqOBmeLy4YWLffELZbFaUqhA==
X-Google-Smtp-Source: AGHT+IFC4nORdsi/KOgTorea5ThBp9ENIaaS3CBPOc8ggOEsWOcR8KyyKpUYUclGzU7yf4C1uMTWgA==
X-Received: by 2002:a5d:5f55:0:b0:37d:54de:1609 with SMTP id ffacd0b85a97d-381f1867045mr18170972f8f.10.1731518224933;
        Wed, 13 Nov 2024 09:17:04 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f71fdb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71f:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea6b5sm19157660f8f.84.2024.11.13.09.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:17:04 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Mark Harmstone <maharmstone@fb.com>,
	Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v3 0/2] btrfs: fix use-after-free in btrfs_encoded_read_endio
Date: Wed, 13 Nov 2024 18:16:47 +0100
Message-ID: <cover.1731517699.git.jth@kernel.org>
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

Changes to v2:
- Make patch 1/2 only do the atomic_dec_and_test() as a minimal viable fix
- Make patch 2/2 only do completion and refcount_t 

Link to v2:
https://lore.kernel.org/linux-btrfs/cover.1731407982.git.jth@kernel.org

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

 fs/btrfs/inode.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

-- 
2.43.0


