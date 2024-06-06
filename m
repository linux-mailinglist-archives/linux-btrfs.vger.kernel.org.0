Return-Path: <linux-btrfs+bounces-5497-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C218FE113
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 10:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AC228697A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 08:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE09F13E40D;
	Thu,  6 Jun 2024 08:35:19 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A5C13D888;
	Thu,  6 Jun 2024 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662919; cv=none; b=TgNXOceuKN6Q89Jm/njKAnCkXiubiKjWS1WmAwkXarI7jmsVpwKZyAItVx/vmeQd+8gmroDCOg0Nn8Y/eN5e67RkMK3dQx/zEHSh0imXWZMkfBVHq+R8+En3lmmcePrUJkGyWeKcVSmv681jRDfn9Ilsk/hlB8VF5c54XroeZsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662919; c=relaxed/simple;
	bh=4EgHnCnCZBWyU8y4mAAudkfLZu9Xg18u3Qjnrsf39+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=thBLXazjqjKKU3FKrah6Cg+XoGFZLagtqj7a7grRZFg+6MT/IP5m4XxCzKVS7AQ2Uczku/AC4UwQ7Z5WM0EVk7IBPhQ4M1vyLIiOG7OJjZMb5FjXzUdKOMJaIAnFHqsYr4b0kFyQpamvhxns3TzW6WPma/Acph61CN2aZtoGnfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a4ce82f30so825349a12.0;
        Thu, 06 Jun 2024 01:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662916; x=1718267716;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiqL69v9uVtNAEuAaU0jUGyaKWnPKhWYpM5RlEKZEUc=;
        b=Jv6Um6LnvQZdP7B9N0zanqXHnMHYgzE1x2OPSblkWMTTHznC0H7jcbyXNipq/Ji67W
         8Jvou7tuvHDuLXPiD6Xz2qFiTNynOBB/eLFCf9auFxjRix0dI75XxgDTTq862eDl63Hb
         rRZJQpQMy9KNHKENN3rKTMu6iHAQuT8LE2CtNMSxrhmFkc2M3ujfXJio3u7hJZNNkfcF
         jPzC//78jl3bP7nDX1ReN5oONiKnm9WFogr7tV7UE8tD0qud485VFtAs4XQhA7U5jitT
         GOC9byUv48ODwShWrA+I1BLHe/l1vN8q/m8+pJosm8xK560QQBuuGcpkKl7MZ4gK3oUJ
         5OVg==
X-Forwarded-Encrypted: i=1; AJvYcCUoRRPEBAcOO5Y8nPDO5ZYj6a6PRbB1jGGTejRY/Ark+2DAbo7Vf/DnhLIo+fWpRfVH6/Xx3TolFW4eSED7goCRiZVBmHsg5h7FHBzG
X-Gm-Message-State: AOJu0YwYKovxGM0tNK62g0NSh9qM75xXakIYsxHC2MKyORuIInTno7XX
	ioE5dc/eSdh3HT2JWsT7s6onSf1/TDS7wkbuXZyVoh7pCd2JYnzS
X-Google-Smtp-Source: AGHT+IE+dWyIw170U4msbpz+yh6wjuWlYVjD4QfdjAQZDZ20Wu1wnFBP1QSyW4mIAUmScL7+7X+hHg==
X-Received: by 2002:a50:d754:0:b0:57a:2475:6a16 with SMTP id 4fb4d7f45d1cf-57a8b6aa19emr4316627a12.11.1717662915975;
        Thu, 06 Jun 2024 01:35:15 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9e99asm701338a12.17.2024.06.06.01.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:35:15 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 06 Jun 2024 10:35:03 +0200
Subject: [PATCH v2 5/6] btrfs: pass a struct reloc_control to
 prealloc_file_extent_cluster
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-reloc-cleanups-v2-5-5172a6926f62@kernel.org>
References: <20240606-reloc-cleanups-v2-0-5172a6926f62@kernel.org>
In-Reply-To: <20240606-reloc-cleanups-v2-0-5172a6926f62@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239; i=jth@kernel.org;
 h=from:subject:message-id; bh=oSzfDVy/RzBr71CWX+7fbNO0PgrhkhfGwxnrxQxIe24=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQlluxzO7S4wtG1ftqPhJrcq1d3XQhslqr5fvLa77za+
 RtMLVg2dJSyMIhxMciKKbIcD7XdL2F6hH3KoddmMHNYmUCGMHBxCsBEslUZGb5bW3y2ZTQquLgt
 Z56LRGHNVt0I5vc7BNWyHlyaJtq6fwkjw8sLq5dJCnvHri0qCj4+r42b6/MXxgvFDfJKzHtNrq/
 4wgwA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Pass a 'struct reloc_control' to prealloc_file_extent_cluster()
instead of passing its members 'data_inode' and 'cluster' on their own.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/relocation.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index df3f7c11cfce..c138d08cce76 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2790,10 +2790,10 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static noinline_for_stack int prealloc_file_extent_cluster(
-				struct btrfs_inode *inode,
-				const struct file_extent_cluster *cluster)
+static noinline_for_stack int prealloc_file_extent_cluster(struct reloc_control *rc)
 {
+	const struct file_extent_cluster *cluster = &rc->cluster;
+	struct btrfs_inode *inode = BTRFS_I(rc->data_inode);
 	u64 alloc_hint = 0;
 	u64 start;
 	u64 end;
@@ -3104,7 +3104,7 @@ static int relocate_file_extent_cluster(struct reloc_control *rc)
 	if (!ra)
 		return -ENOMEM;
 
-	ret = prealloc_file_extent_cluster(BTRFS_I(inode), cluster);
+	ret = prealloc_file_extent_cluster(rc);
 	if (ret)
 		goto out;
 

-- 
2.43.0


