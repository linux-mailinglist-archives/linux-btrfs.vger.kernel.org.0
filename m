Return-Path: <linux-btrfs+bounces-10296-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD8D9EE0AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 08:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA7918894D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF0C20C01D;
	Thu, 12 Dec 2024 07:56:02 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997D720B81C
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 07:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990162; cv=none; b=js7MPmQB2HIY552oxgRFcX1gcsEEx0e5FfLNfDkgNfyaWt2Z3fxgWf4CGcCWfXxHTzC7ko6rqZ8tiC61hpgFezZCXlJK+qn5hftcWUZVqRx7j7uhdTs6actSoYLQ/mSwTeypEuPIgAFQR1npoEBT4DsnYYl0v58PbHCs4ceFpxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990162; c=relaxed/simple;
	bh=T80pbk3+9U6Eq7QYEC1OcK4IsfabXu2sE6gFAiEIB8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/t8W5wRUJEyDXtggFlynbncU99QLwC74lmcGWiE1RyeFwjYkRws6LaA8tRYlYonEru/quKcqnS1GJVwMgod7O7O9tiQTBQIe3/aHOv2cgA7/VbAHHovWpgg7cwQvGORIxuUvi4+GD+uPzqjWMjU81nff+9CZoiLvIT4+CjiAz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso44747966b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 23:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990159; x=1734594959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=696dQ0ZhIy+mpCg8XFG1c2cuF3ANJg5C50ThsK/CYrk=;
        b=l/RopM+WGbsJawLl/swA9Jazx/I8zEwpesj0rq4zB1R9xorCO+XIM3XMRCCVyfyT02
         7XQSFjgbgOgSCYAeyGtV+xEoE5WD0Q6EoIlQEel+kfTg+az+HZiAw/EiNB5fjJWasHfB
         4xhHtuINr1qXbfCtijQcu0dqRW1ZxSfkzNGDwG27/kqjR1QZA8TVy44pcIOsnHcS69jn
         hrNSqQG4ziAaoKq1IZbTzuU7szaNFqv0A+opKwvKlFdgjw9FrglwlDDLb9k5C5QSIC14
         nUuCscQKWbC41sB8wJuSvDHVAdyXZUe6dA8x4Yc0dtRcFXgjw0g9J70neGq4rxkulJMG
         3KRQ==
X-Gm-Message-State: AOJu0YyYjXIKum486JdVpuWIigyJfsxmEeMPQUjK0ctV8l8EOKM4oodK
	8mWAdu3cBzF8VVRBFM3KRHFo1PswvGmq6FYleu61JLwTA2gcQugJPBm1fP9m
X-Gm-Gg: ASbGncsg/cT51X5uxUkPSoYi1oHbXwGeMvvT1fmSE8BXoy5P8gfGmL3qOVa8AcT1FBw
	uFxASnPoFNahPtFBJyBUS0r0pODgE4D+meEOVmwgYP9aN1m+IjD+BEgwj8IAVuqcIW7Drrufvy8
	NiizIYId8gd5HE0+zih/FXek09zmztiErkLdmHVSgarME8O6f4DQ4ame3AGJ6D06TwzyU7573AY
	wcHeyiVpW8wu9JmHCnhkCcCUn1dEOuZ8KffbPMEILgQ0cu+wCsFvLHK1O0zybHvGFWY9nPMBZlM
	rDh5Qv4SH14xi8yROGwMYvkoCuuJkJkA815SCus=
X-Google-Smtp-Source: AGHT+IHxk7GXihis0SQ6VM4ZL/j+Z36QseofYW+ktrc/2oL6h/AvuDsJUhn8xe3LALgD7/ei1MOUeg==
X-Received: by 2002:a17:906:3111:b0:aa6:9b02:7fd0 with SMTP id a640c23a62f3a-aa6b0f4fa0fmr525362266b.0.1733990158726;
        Wed, 11 Dec 2024 23:55:58 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a3a80d6csm350730766b.8.2024.12.11.23.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:55:58 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 04/14] btrfs: fix front delete range calculation for RAID stripe extents
Date: Thu, 12 Dec 2024 08:55:23 +0100
Message-ID: <e996ff4c30ef83f271f2495d700635287d5587d9.1733989299.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733989299.git.jth@kernel.org>
References: <cover.1733989299.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When deleting the front of a RAID stripe-extent the delete code
miscalculates the size on how much to pad the remaining extent part in the
front.

Fix the calculation so we're always having the sizes we expect.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index d6f7d7d60e76..092e24e1de32 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -138,10 +138,13 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		 * length to the new size and then re-insert the item.
 		 */
 		if (found_end > end) {
-			u64 diff = found_end - end;
+			u64 diff_end = found_end - end;
 
 			btrfs_partially_delete_raid_extent(trans, path, &key,
-							   diff, diff);
+							   key.offset - length,
+							   length);
+			ASSERT(key.offset - diff_end == length);
+			length = 0;
 			break;
 		}
 
-- 
2.43.0


