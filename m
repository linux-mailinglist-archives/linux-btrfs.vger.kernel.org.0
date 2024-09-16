Return-Path: <linux-btrfs+bounces-8064-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 909A697A2A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 14:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E541F23EDE
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 12:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8BD156F3B;
	Mon, 16 Sep 2024 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T31ZFWSc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8BC14D439;
	Mon, 16 Sep 2024 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726491435; cv=none; b=F3hPBQpEmtci3WV301Rf328bmbIOuBr0reNnh9FhJlElh0hqnanEJ12hOQxtgRDEAoIB2wYfR95MNu+h5Xxneaor9k9yy1if1tisiqyc+GWnQJ4k2/NTuoA9S7vMwKAgT8UJi8d1BtLk2zAvomQWgJXTd8a5Vy0MRrt39Bu+VU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726491435; c=relaxed/simple;
	bh=BIcnYwMDs2dY2drk8F2v3KpjtKtj8m6NLOirkf4mDF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVBXN0Wfag1rVyu3PHWloYW2ffWpj1C7e1e+HYuwQwqs+j29RrD4LgCJpOtV67SOWezloLLN59OeRpv6GHPRU0c1dtypvhHS8Tg4f65w189AP9arTynV815bTyNYq6eys4UIjzyipAv15OXbP6sMqQVGOTgx32D3wyQp9I/+EYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T31ZFWSc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so25963335e9.2;
        Mon, 16 Sep 2024 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726491432; x=1727096232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26uP1fl+enfCssDsTFAvyc+N4DqStofePJ8NkWqMYoQ=;
        b=T31ZFWScpmpBUP1lzR3igqi0Kt0DD3dnakMkItjpfP86xMhY63hW9yZD8Z1fC3gaEc
         drI5ZCKTxnJHsa7pnLPqNlbZEeJykpBSe2qLCbZ63gLuIJasteEVg+GQXCgfa7H3pwSH
         zaiwNaMOWynyl0ffEQgcfIzFFz7LJinanvOA4hWEvsyWLtQheOGUD+lG+ZWoVLGjNodK
         UN6I4dQhFnf4fXX/M3N4NWlyHPLiehcHGehZPFMGQrlaylEC2uY1KCz7pXf+v4+GKKNP
         NAhfldA15cZjKctyiOMwkWQvS3iWcrMo4sK7XznTcbpC/7ao8Mu4b6QkDJWaIv4xQqAN
         B5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726491432; x=1727096232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26uP1fl+enfCssDsTFAvyc+N4DqStofePJ8NkWqMYoQ=;
        b=BDi2lq2X23ZQE94zoaxDwzF0aUoVFZ/VP/LpvpmxDxzXoEAPm9QdD1hHcuLC6+GtdG
         a6+g6dt9nSrpjpjd6KfhxoOqX2t7i5i5Z9Z5sUvX4FFlmg1E/VgfyMyxpA6WEnvWtL7d
         on/HXWFtBrl1+foUfaMj9SJmxqlsGaFUlwGHPUiNMakrYeodUuHNwVw+HdL19qRlRDiQ
         z0RGDhmUn1EzA1DxsYOugezU11KMBoqt47IEfxjH6BmOF+UssZB0E267VWL9tAebv+jL
         /J9SstAHWhabjBq76QyiJ3sgHfs9zamRTNgUhxIu2FKPY1o+Qo3lwq0dz/wTH1T9hKf7
         JjSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFDkLLFpFUwsywZWJNBdQxeEiChblgqU55CvjL6o9NmIqa1oMGr0yXKVRIIEW04BqaZU6ZW9sSYWh+Ag==@vger.kernel.org, AJvYcCXKaWLPc45DIW0jkdq6Q7KbqFtqf9qfjv3DXKNFKhDDH07454YecY6hTGB5q7heozQEdO2U6u8Vwa7UjU4q@vger.kernel.org
X-Gm-Message-State: AOJu0YxBSrxNPl87q31QKkWRiwgRSnQHBvxQVgw4SKFWSO62UEsgMYtT
	iPFEk0aQoqYmT2RtqwCUfOTuuKMrqKBN7/9RHfG0ALf7P4BIeFoG
X-Google-Smtp-Source: AGHT+IHDxq7x/0f+AkQXgKdrTQmLx+q7stD5KyPmM8BiHUioCXNdBl2s9dsGN2DP/pBInM7HcXJGQA==
X-Received: by 2002:a7b:cc88:0:b0:42c:bb75:4f86 with SMTP id 5b1f17b1804b1-42d9a91052fmr75782705e9.32.1726491432082;
        Mon, 16 Sep 2024 05:57:12 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42da242741csm77129615e9.47.2024.09.16.05.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 05:57:11 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] btrfs: Split remaining space to discard in chunks
Date: Mon, 16 Sep 2024 14:56:14 +0200
Message-ID: <20240916125707.127118-2-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916125707.127118-1-luca.stefani.ge1@gmail.com>
References: <20240916125707.127118-1-luca.stefani.ge1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per Qu Wenruo in case we have a very large disk, e.g. 8TiB device,
mostly empty although we will do the split according to our super block
locations, the last super block ends at 256G, we can submit a huge
discard for the range [256G, 8T), causing a super large delay.

We now split the space left to discard based on BTRFS_MAX_DATA_CHUNK_SIZE
in preparation of introduction of cancellation signals handling.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
 fs/btrfs/extent-tree.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a5966324607d..79b9243c9cd6 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1300,13 +1300,24 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 		bytes_left = end - start;
 	}
 
-	if (bytes_left) {
+	while (bytes_left) {
+		u64 bytes_to_discard = min(SZ_1G, bytes_left);
+
 		ret = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
-					   bytes_left >> SECTOR_SHIFT,
+					   bytes_to_discard >> SECTOR_SHIFT,
 					   GFP_NOFS);
-		if (!ret)
-			*discarded_bytes += bytes_left;
+
+		if (ret) {
+			if (ret != -EOPNOTSUPP)
+				break;
+			continue;
+		}
+
+		start += bytes_to_discard;
+		bytes_left -= bytes_to_discard;
+		*discarded_bytes += bytes_to_discard;
 	}
+
 	return ret;
 }
 
-- 
2.46.0


