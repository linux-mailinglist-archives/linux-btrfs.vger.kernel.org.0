Return-Path: <linux-btrfs+bounces-18798-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6AEC404AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 07 Nov 2025 15:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD693A8219
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Nov 2025 14:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AF531A808;
	Fri,  7 Nov 2025 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIwMtlhg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C9C3164BA
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Nov 2025 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525320; cv=none; b=XxlQTBE2lypDsr1mlWTG4ghZefedWfL85+JUuQE3/8l2mYG8YNjANt+aRDnT70EES53cZDJOLJDV9LmJTK5gNXeaY0y/2TRkqDZsGoI5p74FkoQsEkw8+zYPD/rWBySo20W55cyEFnqyq9+BEO5NkNkeKWi+7TAIF6dnkaZgciI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525320; c=relaxed/simple;
	bh=4YA7rnYANBJbSIxSqVtePmwnGUnHrdSlVUABR4BCN1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BrvBsk+A2Q4jXpIhuCtpacn9AzxPma60CPFD9sAUbVJeX4BB+cAEYY7csp01zcIbWrZAxEbdiSc2RO3KHzljKAo/KkAD/6eUiIuEOTKWKThCiIn5P/xd+R+AlyAE6vtEMbgJXwcIOMyTEWmLMIMTTUYmJJDI5/NdyTZAIRQCHkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIwMtlhg; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso1282524a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Nov 2025 06:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762525317; x=1763130117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ScNFRclv7Ib95LOsyE3eeWyv7nmH8lB+sNT5DkF52E=;
        b=FIwMtlhgRRHb42jG4xF2+KwRKd9EoY9Z+Msfsc2XiHljGQTjDUIsxCQF2UenqsShcx
         LGAYWAyEGxww6NpDxPAHJBBPo9eR5ZBY4k7cbZKxQ4hYUq36li+6WOstaQDzOCyC5wM5
         5e1g7VbZFByt8Rf4foW6My9ceu1aGjl26F66DvHzvuK2RAiUp/AOixJEeMnZpOZfMQIa
         41qwPZxNdZBnx4992oSL8Wzrr/DtpoybWKfd2j+8h4V6Wy5hUmWUOg/hz5m1qtkIt7HW
         hBETLgadW/3mHmuDEYxqJxw4by+qa2eCIR/HA99GA77bMuDKI5SvuijmOt5GPsjiAmAs
         iGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525317; x=1763130117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ScNFRclv7Ib95LOsyE3eeWyv7nmH8lB+sNT5DkF52E=;
        b=S3Z+GhgKjii9xPuPtfcjSORNLxjp5egCXcdiOjRxLQDfEAC0daGhbRi9SDRWds0ZxQ
         ZM2uzyzausert4WmGA9PI8S+8nVg2EV9/XkT/V8BvUE69ydygU/BG6yAfun4jgEceg/a
         6rdfqqgnYyKbdd+vye2F/6YyogDxFyQimNAI/oo3/yI7SEqBr/gofxCFp3q9kvI8WfaG
         aIvFvFhIJ6QFaGUrf8PcKyze1dKa4NYg0OGjkCVhFtEpAAwmCltgaUvnTJTKgj07r2vc
         Va6Fsj6Ba/gjd2UGjYE3IhURgIEBX5HEMJVg2cUnnjyvfGa43DzH9ZC2uskLUzEbZ8/n
         b3iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQHcpHpYnmEWINvQ5ChGy63AD5/pHF7yi73CAbbWfZxoNJw/VXTePkRA8I6MeqoUlYmJq8KMWLEhubEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz3sgs7ihWguk72P5Tj3GpSflfJdhOh8LyQBcthIRZS7t1qy0E
	TNgMkfc7SCIPhNyvjGRNlBGcCBr888gNgTaLaQ2pNGjBqPgHY5/S66Ai
X-Gm-Gg: ASbGnctDecIq5O8gTnamL+F1uP8UkWcLa+W1g4tULv5KFavTcRwy00jil1al/HyJY9b
	OUoVUgCbicJvBVeKMWH8scC74/HcqRxWUBK3Bvz+J6Xkj+joTVj23X6S2kX+YYF2u6JiFn6z05N
	EuRGgcqi6Hygn7/meLZbMXfuJuvKtSNrKhNFX/1KxWkOCo/E7RCyIAWVReWl3hcNp5tp4N+Aq5m
	63CIT1u0ZVaNu1w6PyHy/XG6wlpHTWpLX6kr14DZ6xdz6R7TKGznJPS/NkBhN7PrLK4hSxWymhu
	V16axtyiT5C8ZMpH4hWdsf2mnwSDpzynZBBSLSnF58E3EK2kpZ2vMi8eIIrG7B2DBpd1YjDu+WW
	I+K9TheyGfxaAURYTY6HA4GKCk6roD1h2p9/o9BOt0q+5XakmdB3ECkFVRlws4Ny0J4PHiT2PKx
	Pi3exxnoD7c8eKcDVHcUqHXztRBZ8qMQHZ/8Z0EddWJjpsyJ63
X-Google-Smtp-Source: AGHT+IGGYwqyyUENw1V0QXHKNHeOJ8/rc+O+s/OC/PAhV+9kOen2ldV0JAlre4vOLRyVBu782YEqbw==
X-Received: by 2002:a17:907:c1d:b0:b49:2021:793f with SMTP id a640c23a62f3a-b72c0d9fae1mr392049066b.53.1762525316591;
        Fri, 07 Nov 2025 06:21:56 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e563sm253322766b.41.2025.11.07.06.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:21:56 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 0/3] cheaper MAY_EXEC handling for path lookup
Date: Fri,  7 Nov 2025 15:21:46 +0100
Message-ID: <20251107142149.989998-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit message in patch 1 says it all.

In short, MAY_WRITE checks are elided.

This obsoletes the idea of pre-computing if perm checks are necessary as
that turned out to be too hairy. The new code has 2 more branches per
path component compared to that idea, but the perf difference for
typical paths (< 6 components) was basically within noise. To be
revisited if someone(tm) removes other slowdowns.

Instead of the pre-computing thing I added IOP_FASTPERM_MAY_EXEC so that
filesystems like btrfs can still avoid the hard work.

v3:
- drop the pre-computation idea and inline the perm check
- add IOP_FASTPERM_MAY_EXEC for filesystems with ->permission hooks so
  that they can also take advantage of it

Mateusz Guzik (3):
  fs: speed up path lookup with cheaper handling of MAY_EXEC
  btrfs: utilize IOP_FASTPERM_MAY_EXEC
  fs: retire now stale MAY_WRITE predicts in inode_permission()

 fs/btrfs/inode.c   | 12 +++++++++++-
 fs/namei.c         | 47 ++++++++++++++++++++++++++++++++++++++++++----
 include/linux/fs.h | 13 +++++++------
 3 files changed, 61 insertions(+), 11 deletions(-)

-- 
2.48.1


