Return-Path: <linux-btrfs+bounces-20371-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D75A0D0DD30
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jan 2026 21:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4431C30390FB
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jan 2026 20:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E8E2BE047;
	Sat, 10 Jan 2026 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpQzpSVj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2AB18AE3
	for <linux-btrfs@vger.kernel.org>; Sat, 10 Jan 2026 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768075655; cv=none; b=ZXfenLbFSlVYjLPT220Zn4tJYhKngTU2s9peMxINHE9jHXwnC00z+E1RySyNEHKcbEyXnJIO0mkEeNtD0ixVkRasiDJfyUlmkpQnhi/qRWadugXUu3aQu6mfdVrAeSdSOw7Bttqw5Fo7HJ8LVmc49k2nNHLgjZjPGoxQm4Uvr9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768075655; c=relaxed/simple;
	bh=bOETZVm0qxEk8btX6K6osNkaGtR9dzjl/K7U6RSO5dU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RAXc6bO8RnAZT7qBkbKYO2gkVg78Ta/PjqgO5i0sI6uMGMhZTAiAgvx/E8e9ehH5Fs0ZLDAkscWqh40140nVnaBypN5m0GsqLCze+ysVQEdrwoFFZGgeFpPAahtSixZKiEUKwZJE0vJr++7fO9P/kTnAOcu6sFilAuUFX4ZuFUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpQzpSVj; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7927b1620ddso3995867b3.0
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Jan 2026 12:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768075653; x=1768680453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WSMGOWW2GLR17oKn19X2kPxIW0U1HAEdW/YRy7tX55M=;
        b=LpQzpSVjm9SYDi/8HnpHFwAeONfy9zJCVOZO83vWyIZi6LGThFyYU7U4fQosmLg+/U
         yQyQcfVIiV8c4EtdV2GLLun+4K4qSjBjGz5DrrTY4l8tJNuS/OzPxceqbI+ObNvRCbHy
         2IsgOwXOcUMUJhFyA1XyuZPA0S/uXTi8fYAUNgG5AUaKSB8QbaN3tacXO6MwCTPwAMqA
         D0fcsdS13Nlh2oYCdiC/EZBOYuzs+hk/hiFTNXHre6QV4mKtw7ElhycCgmE5GH+zjX9T
         iBsVKdwoxJPijJHntdooTHQN7xd8OgyCOrMealapYISsTf2BTjtzsH8gwmbi0rsoAdfH
         QJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768075653; x=1768680453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSMGOWW2GLR17oKn19X2kPxIW0U1HAEdW/YRy7tX55M=;
        b=X5bcEgBL4oxoCvKaDy6+A8qr7jESvQofnLV99MbP0Gz8j6vdsW9HQYKAZ6YorOP1RQ
         GCiDhdohBJsjlM+HoDCOlQyUUj0ee73mVBmYry+8RhWrK5Xa3XTLwceX1HoJciYlhuUa
         yyvinvb1U5nCeH5TVe/6ZzIYZB1Ml+a+DJRIbSjbSERKCG0DTBZwDXBgQrMTtYoRS9ZH
         /S9VUSGybc6Qktm3aKlR9hNa8ETOGB6ua4sPdyy77tdAIxntFfa3ltaZPsKgBFT1ZhpU
         dxSKRHX01HOHP+byiOGdVR6YAViWavwoo6nBu4IAWWNLHVfo+ZruLQSBAPj8ZomN1aHZ
         vuLw==
X-Gm-Message-State: AOJu0YxcD267HLyzCTcPmbLC03zKbNZCxqEg00vC8O47mQXg3hl3Oqe7
	mAuvOybCP9nlDqwrsgu4ha53qpkUe7H7Xh6Cf4jqcBsPFmdvBjsZVOMy
X-Gm-Gg: AY/fxX7ljWLvwQs2Zd2eL/ArAZ/GnY7YIMxgV7ERe172+j4oeOhFxU6KdpxDqYksmgs
	Ur9tv43tuudtwwdFNZpLv2Ro7qfYWnidHZvTH3GT+czKo/nmwrEFNd9JQS/9hZ9PWhFpHgZV3VH
	ge9KJMpNvjVu+8OObq7n3ZDBz0D/2gDawMuT714HRoEL3YFg+VzlDXZuZHsD9eZ3k091D5i+lD8
	rHSHgyHT01MjJzW6MX+IKcZFyrDJ0k2iC7VqeMP1N728OEcXElTBDxP2acc42YC2ub6x0bzc8s7
	Ia6uCZ7DcLL4S0XdCtk4vkOJlh8o+yUsNH6NZ3/vPa8+2xGVQFx4OkTpNAjwMgN9aFFUFPpKFq9
	e2gpSu4ZEEUmAp55dDn5pUFzNNC8QqjKetMi78IPOL1Rl4CUeBvgdgfDFcKqguX45DfzIe27gG7
	ElQ6kMWF2Tk5w4A9aNvocF0IokSJlpUefh
X-Google-Smtp-Source: AGHT+IFGGvQ4ckLtQoov18lbVm0nDz4ry6J1waR7yoyqcAefIEE9RdOZObQEjVcYzrhxdbkNJq783g==
X-Received: by 2002:a05:690e:dcc:b0:646:c662:5fc4 with SMTP id 956f58d0204a3-647167b8da7mr10823399d50.45.1768075652801;
        Sat, 10 Jan 2026 12:07:32 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d71cad9sm6137960d50.0.2026.01.10.12.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 12:07:32 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] btrfs: fail metadata async reclaim early if filesystem is aborted
Date: Sat, 10 Jan 2026 20:07:29 +0000
Message-Id: <20260110200729.9590-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, do_async_reclaim_metadata_space cycles through all flush
states even if the filesystem has been aborted. In contrast, the data
reclaim path (do_async_reclaim_data_space) explicitly checks for
BTRFS_FS_ERROR and fails all pending tickets immediately.

This inconsistency causes the metadata reclaimer to waste CPU cycles
performing useless flush operations (like attempting to commit a
transaction or allocate chunks) on a broken filesystem.

Fix this by adding a BTRFS_FS_ERROR check inside the metadata reclaim
loop, ensuring that we fail all tickets and exit as soon as a
filesystem error is detected, matching the behavior of data reclaim.

Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 fs/btrfs/space-info.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 6babbe333741..b3aae44a1436 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1189,6 +1189,14 @@ static void do_async_reclaim_metadata_space(struct btrfs_space_info *space_info)
 			spin_unlock(&space_info->lock);
 			return;
 		}
+
+		if (unlikely(BTRFS_FS_ERROR(fs_info))) {
+			maybe_fail_all_tickets(space_info);
+			space_info->flush = false;
+			spin_unlock(&space_info->lock);
+			return;
+		}
+
 		to_reclaim = btrfs_calc_reclaim_metadata_size(space_info);
 		if (last_tickets_id == space_info->tickets_id) {
 			flush_state++;
-- 
2.25.1


