Return-Path: <linux-btrfs+bounces-5252-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18A68CD6F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 17:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B48E283743
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 15:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A181865B;
	Thu, 23 May 2024 15:22:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C10E134C4;
	Thu, 23 May 2024 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477728; cv=none; b=oZJeMYa7h2DCLJebweb/TZyM4UQRKfoKmUXdOa5YHCZKxoBdAVg0X0SnGSDjoqFpoyw1ixa9/5zUl6VK36MfIFraTo9vuVk2VrsrcFvEzZ3NYihJe3lJwLty6NtL8GsNpZfJNeGvYoD8USRNbx3WelKs9FSt5tKs+QVPXFmY0t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477728; c=relaxed/simple;
	bh=JyigNFVJ1Z2Uv6bWcTKNRt+/4I8C6jRbTULCjqg4pZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RA4Fc1az2qzl3qGr8TyhYbOiKfge1Wx0odGDhS2Jpfk3w/ymCp0/9lz6FVDAhwAHGqntBoG4xi3UbMe9nRJ0bDGc2rheErtqIi38VZ6xs3jOVYVfLwqKD4MEpyWWGViVFYDUT+SbWSwNVLzaqntUMHypBFV4/nPXRHqTQuxIqZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4202ca70287so13683195e9.3;
        Thu, 23 May 2024 08:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716477725; x=1717082525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sbVNyBGrLL5I1xzmXd72Li5wRaOIDR8ovXE/SSKIQ8=;
        b=vWZM17/j98Xb2hEPIeAuTDL0C1r/w7bY4V2z2lt4su1bdvocLfc8lqzEWvtP44JxiX
         hW36vKc76r7mHu7u3bT8be8MtgIA3QWefqtuDBSsjG1PFstBwwfbajjkT21DgG6SrMhK
         aB4j2n7qEdscV2BWWzHJ9gXNbWrleO70fQVMGDjggYZbSWx2H6iXBE/Sh8w8K9Wtyy2I
         rVgGdVysr1YDTXL8cgHvSJwySZWqlyKP4pQDLw7YhvP+RzwEwibwd++u/gUosULHfkCX
         iC67dhs23BvZS8M/5HNQ6q6JL9YuAw57BURN4ix1yNHsu5CIYTS7scPVrE3O5YupN4tu
         MLpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuIQOdlYsFxWBZ4RhTqit/HBS+w8v9SThicrolrpWWybJZTwmt187cHwNz+9yjxd6WBeP/4f2vTVPGJyW+Q3JJ3w2X/Y4SN8B9snzqFstaHsFYOxvbDwJ7xzJNUOIOrTf+rd7oXggwEHc=
X-Gm-Message-State: AOJu0YyaZM+Mj1zNVXOJ5sj+Fux+dXfS5w12ET3QOhF8JX2s4/kOi80C
	y0htXab339EOL+Hf38FQbe/ole9CcUBIR3sLJavmJkxQ1q1rAqDs
X-Google-Smtp-Source: AGHT+IHMDe6wOMWFM4OWrEz8yLOgVKewO4Uu/KS6s25WkCq0rsZQJUcYdCnZKJQ/kLAwVbjKbhueIA==
X-Received: by 2002:a05:600c:2901:b0:420:34a0:bb51 with SMTP id 5b1f17b1804b1-420fd30f858mr52563415e9.18.1716477725479;
        Thu, 23 May 2024 08:22:05 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f709b700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f709:b700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421010ba0f6sm27536015e9.47.2024.05.23.08.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:22:05 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 23 May 2024 17:21:59 +0200
Subject: [PATCH v4 2/2] btrfs: reserve new relocation block-group after
 successful relocation
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-zoned-gc-v4-2-23ed9f61afa0@kernel.org>
References: <20240523-zoned-gc-v4-0-23ed9f61afa0@kernel.org>
In-Reply-To: <20240523-zoned-gc-v4-0-23ed9f61afa0@kernel.org>
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
---
 fs/btrfs/relocation.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5f1a909a1d91..02a9ebf96a95 100644
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


