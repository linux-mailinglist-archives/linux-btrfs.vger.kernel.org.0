Return-Path: <linux-btrfs+bounces-10318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD3E9EE725
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 13:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DACD188725D
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 12:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9F3214803;
	Thu, 12 Dec 2024 12:54:54 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB08B1714D7;
	Thu, 12 Dec 2024 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734008094; cv=none; b=lO/88AnsdHf3zYqdt1bb+9JM20WElmZuzvppRLxS8YKUUDYB/2eMkRYUQdqjOzv9SoLEIUGlCe1pQ3mtygENbqu+1u4FKtec34Ms8DNTztZFYjUhpZA+BFM0jpFqNwuYY7i5tr9hmLqLzCfOfxcFIVZg0l4B9mWgRzrknYt6eu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734008094; c=relaxed/simple;
	bh=fYru4kQCo1LnZUgA+Z/Qi8fmBO0/O0GnNlXRuFhad+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mv+EnPqp2jIB6AHgBvJJ5nLzTJnnODHABaGgf6xOoCaE3lQCGN0X8QHTiXbZr4rRPJnTxsKLT1YlV1LwgKeHZmkDrnntNxDkMc9cGs4Ib80xlknPP6BdBsZz+dhP9hHSPAyUv97uArFR7QbtaaEjOFaPCLQzwJKp6FpFRvDT0iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so1043012a12.2;
        Thu, 12 Dec 2024 04:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734008091; x=1734612891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2eGl5AD9w7fNTmt8bsmGpbrk4SqbqqcrbLsYkMD9Sc=;
        b=HMbELSy5MHZ1CC2HHnjAbso1Tf1mxK8/OZnEQ4V9nQMJlffvRNdwhwHEd4qam+g4a8
         J2MHY4ewRuT+4BX5VD7aPvEJod+52Dxi72eaUCCnuTEn8cHc8pXlYowwRqEu7ymSo8m8
         NcFRW1c/RU5gPPEgqK2IZ4C4x3IDq7yXD5WTvkBcxILI41JLEIKlXmM/4OmXO3A+izuo
         3GUhxUqeGN72GmCqjeyqca+Vu0MB7Qu9KUYDQ3iUvsXJFZx/IZAHsDxTc+y7MW33NL37
         RX2EW3Hq17yyLNB8vk/TtOSj9gWwTr7tAq6P3imlIF2csBCatWA16FGPtSY9/6vRZh4f
         sJjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXslDb0Ff8m8Lh1N/aNKLNzwTluoQrnlZgk2NXoreeCI4+VjQm4pr0//LL4tl7ZfgyLiEdOhl2BnCjYA==@vger.kernel.org, AJvYcCWdiGUpvL/EnKqqIJDJXXxQiQxyKVb8xGYXR1Z60ieeI0xQ6OlrM+sSGUZXhZfciOIgAfOuqaGMt6roNaf/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7h8TJFgeQ8BQZBJ3a8PJ89GzWxjWaCYWP+UawCPt4FKiNBgPJ
	U2GjOZL/tiXajxnacYmBHdZ/Suge1S5fTkj3FpTF+k9TUOmFT5Us
X-Gm-Gg: ASbGnctrRPzsfj9SnoJUefVljMvJpm68GdRLsKdZOK5nu9FUtlPMHB57XHb85QJ1Gxa
	Uur03FZgZuPqQX+eLSAnAxGV2oL3piTr1noVjnMqOP6dniFFoxJyMfUYvqV06SaUeqFGWCHX7Q2
	1LSfvqHXHwcHhqBfdnimEO6tQwLb+SSv1H0H3HNlKonkg0oNhYVX9vF60/O9h2u2pl+ZkXVNghF
	CS/Q5d1j+xIGiCNX2N0QuemexsQ/sgmr5NLjAGOXVsudYdkFM9E9q+yXCgmUpu28U9+Yo69B7Uh
	qO3bPyAhb/l3pvqIRBnRwLOb+i6RYk5ZZeR21TQ=
X-Google-Smtp-Source: AGHT+IFVL3iP9pgwWiJmoT/OXiZ9hnZsoXoepLZ6qsQv3FWWCMriW8iUZMqPnBXlcarItn7xCB1OxQ==
X-Received: by 2002:a05:6402:5289:b0:5d3:d8b9:674d with SMTP id 4fb4d7f45d1cf-5d6305d624fmr218478a12.0.1734008090955;
        Thu, 12 Dec 2024 04:54:50 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c74c3d5sm10309638a12.52.2024.12.12.04.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 04:54:50 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Johannes Thumshirn <jth@kernel.org>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thjumshirn@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/3] btrfs: cache RAID stripe tree decission in btrfs_io_context
Date: Thu, 12 Dec 2024 13:54:27 +0100
Message-ID: <20241212-btrfs_need_stripe_tree_update-cleanups-v1-2-d842b6d8d02b@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212-btrfs_need_stripe_tree_update-cleanups-v1-0-d842b6d8d02b@kernel.org>
References: <20241212-btrfs_need_stripe_tree_update-cleanups-v1-0-d842b6d8d02b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1904; i=jth@kernel.org; h=from:subject:message-id; bh=iFdRhfjdP0hGjbCjfsjG8TkQfoY4tauw2S9BRH3uMU0=; b=owGbwMvMwCV2ad4npfVdsu8YT6slMaRH3Xm+MbHYLLo98MW3znlNR/9fnyTaOOlLxmzmXXP/5 zOlZ+gId5SyMIhxMciKKbIcD7XdL2F6hH3KoddmMHNYmUCGMHBxCsBEErsZ/mcnr847aloadnir Ss4SZv7G48F50Y8vT36YKVT30joqp5Phr9ypRx+PTt91ufhUo6PLsmOtHD7fg7aempTXm7JyRYD hG0YA
X-Developer-Key: i=jth@kernel.org; a=openpgp; fpr=EC389CABC2C4F25D8600D0D00393969D2D760850
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Cache the decission if a particular I/O needs to update RAID stripe tree
entries in struct btrfs_io_context.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c     | 3 +--
 fs/btrfs/volumes.c | 1 +
 fs/btrfs/volumes.h | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 7ea6f0b43b95072b380172dc16e3c0de208a952b..bc80ee4f95a5a8de05f2664f68ac4fcb62864d7b 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -725,8 +725,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 			bio->bi_opf |= REQ_OP_ZONE_APPEND;
 		}
 
-		if (is_data_bbio(bbio) && bioc &&
-		    btrfs_need_stripe_tree_update(bioc->fs_info, bioc->map_type)) {
+		if (is_data_bbio(bbio) && bioc && bioc->use_rst) {
 			/*
 			 * No locking for the list update, as we only add to
 			 * the list in the I/O submission path, and list
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fa190f7108545eacf82ef2b5f1f3838d56ca683e..088ba0499e184c93a402a3f92167cccfa33eec58 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6663,6 +6663,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		goto out;
 	}
 	bioc->map_type = map->type;
+	bioc->use_rst = io_geom.use_rst;
 
 	/*
 	 * For RAID56 full map, we need to make sure the stripes[] follows the
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3a416b1bc24cb0735c783de90fb7490d795d7d96..0a00ee36f66b6d6831c43abda4a791684c11ea02 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -490,6 +490,8 @@ struct btrfs_io_context {
 	u64 size;
 	/* Raid stripe tree ordered entry. */
 	struct list_head rst_ordered_entry;
+	/* This I/O operation uses the RAID stripe tree */
+	bool use_rst;
 
 	/*
 	 * The total number of stripes, including the extra duplicated

-- 
2.43.0


