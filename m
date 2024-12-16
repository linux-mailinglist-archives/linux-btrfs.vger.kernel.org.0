Return-Path: <linux-btrfs+bounces-10397-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EFB9F2B91
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 09:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A031882C46
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 08:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E141FFC46;
	Mon, 16 Dec 2024 08:10:51 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8703F1B5EB5;
	Mon, 16 Dec 2024 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336651; cv=none; b=dbvD/LIK/TmIse/YRqkHXgeRlv1XETf7txYz07+Z2qxLprq3UIMIwfi4JfWb0IsSyD34NxbqEUu/AP3PALsSmY0dHvRrfg87UQKDxteRhCHPJcrHcT/iaTuANCfqfqK2R6EtfH6TVJlCfjRAVtHg3yTb3nU7XI+qjuW6/PAwgXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336651; c=relaxed/simple;
	bh=/emqZqfbQ65nMrGTAYU0MnfHjtKYGqaTGMt5J2ol3dE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ojvw1Eg+cntIhtHJqavqp7nNeozkE0jncdhe2h4Qmm0bFiPt3vk+Y4LRmD1Nhpv5p2nTRtvx0/fJj4ndGCH0Pt1GbiQ0iTD3itG8LiBVYyQy0TQcVrjTFPM5Dv2NFtQOC68jZYllIBOVNxi2ZXN68VETgJRa5a2+WgerFkfShno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa69107179cso717495166b.0;
        Mon, 16 Dec 2024 00:10:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734336648; x=1734941448;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qsaZIhrCZYpmQkmeAq3rJ2jvMNztmu3MzjxK25fqaw=;
        b=BoeGJ5Ysc4IK8FD+KF30E1N3y2m7qd0vkFtgIYvPkRPUtsuq7hBnKyY8sMqMx6qThW
         plQS7zQdsaP0hrjRpGywN12JGFQ+oRzMuo9hR29y2d+s+nXGXx2nOK8FiPc8iVks3bG2
         X6BVmzl8cJMjQYefCNcOWeVbSAMMTX83sOtuzL84KVluwnNafYDLJps8HrOwlC5UdlG2
         gdzdXnu2Bvnf9BBc07kAMleoZUyuxexBGX29o9B9Gtk7HWv4UGNASVtx46lQeEMwucI/
         H7dS6wA39tQbPks7XwMrfpoafXwtjapoYdGBm7a65Ae7qsms3gKi78KDMYnUtHqJQCpt
         oorQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdSqxAD65hApROQL/7ienPJGmlt7YGNxu8pPBCNKCHyeXPdjGCRYFo4NjsyE6TmbPwQvCSr+sGOSnCUI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeYMb+5SD3w3J5frqP2cLrEm4YeauuebnfBiRWRoT9oylmPVPq
	jVJYd3NqWOh3YqzlQ2IkjLBBY2LgsFRAZVs/vZWfztBKF6e7s8mQ
X-Gm-Gg: ASbGnctXlo5D+5q5vNsVIExVfcx1fDfHeDdXRJonxe4Yjkn72HccoKW0MSNmkCLhjA5
	B7rP5jLUlm+G5Zs7Qq9PJhcufQAROHAL8aFulCF0KQBfHy4HBV8GwKsaQjJNIGSpoRQRVAXZIlI
	vwLQAZkgKt6N6+YSXVelZfK/kAZebfw3M1KogKvSnGoIxrZoCLDFN1aP4lvc+PeQY0HUdXhXP02
	A9raZliSAdxvad7M5XjQwkGg0pY37WS5L0MmUD40txczV2g0QHldOdUoPg/FVMZ3l8WYa3lm70D
	q2Xm9WRmFR7Wgme5ONsJFN1jsmcgpxD2E4io
X-Google-Smtp-Source: AGHT+IH+q8WFVJO+t8bNDZrj5g192HkdRZWmpkWI2ZCISRP40w+b+G6RX87sLNKElyjrFOBdNYigiA==
X-Received: by 2002:a17:906:32c2:b0:aa6:5eae:7ed6 with SMTP id a640c23a62f3a-aab779585ddmr948994366b.13.1734336647516;
        Mon, 16 Dec 2024 00:10:47 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9635a000sm299013566b.113.2024.12.16.00.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:10:47 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v2 0/3] btrfs: reduce repeated calls to
 btrfs_need_stripe_tree_update()
Date: Mon, 16 Dec 2024 09:10:38 +0100
Message-Id: <20241216-btrfs_need_stripe_tree_update-cleanups-v2-0-42b6d0274da7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH7gX2cC/5XNQQ6CMBSE4auQrq2hL4joynsY0gAdoJGU5rUQD
 eHuVm7g8p/FfJsIYIsg7tkmGKsNdnYp6JSJbmzcAGlNakE5FYoUyTZyH7QDjA6RrYeODOjFmyZ
 CdhMat/ggVVn2F1xR3YpOpDPP6O37gJ516tGGOPPncFf1W/8mViVzaaqC2tJUJqf28QI7TOeZB
 1Hv+/4FHblDi90AAAA=
X-Change-ID: 20241212-btrfs_need_stripe_tree_update-cleanups-166f5e7e894c
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thjumshirn@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237; i=jth@kernel.org;
 h=from:subject:message-id; bh=/emqZqfbQ65nMrGTAYU0MnfHjtKYGqaTGMt5J2ol3dE=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTHP2gTVrQLrSzROHC55bXW3LAoNbPpPA3XvX5Nn8OQu
 quR969oRykLgxgXg6yYIsvxUNv9EqZH2Kccem0GM4eVCWQIAxenAEykcz8jw3P1tVlpC2wc7CNd
 P24wWHElQnLRpR0F+Wv7u7m9LG+fL2b47/xjf75n2/3rxpK+jTnGU6rsGc4qt61Zo+FzpZ3HQsq
 KBwA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

When working on RST backed RAID56 I was looking for a way to plumb the "use
RST or not" decision into the bio submission code and this way found that
we can cache the return of btrfs_need_raid_stripe_tree_update() in the
btrfs_io_context (and btrfs_io_stripe) so there's no need to do multiple
lookups for the same I/O.

Signed-off-by: Johannes Thumshirn <johannes.thjumshirn@wdc.com>
---
Changes in v2:
- remove pointless comments
- place 'use_rst' after 'max_errors' in struct btrfs_io_context
- fix typo
- don't break lines if they're < 85 chars
- Link to v1: https://lore.kernel.org/r/20241212-btrfs_need_stripe_tree_update-cleanups-v1-0-d842b6d8d02b@kernel.org

---
Johannes Thumshirn (3):
      btrfs: cache stripe tree usage in io_geometry
      btrfs: cache RAID stripe tree decision in btrfs_io_context
      btrfs: pass btrfs_io_geometry to is_single_device_io

 fs/btrfs/bio.c     |  3 +--
 fs/btrfs/volumes.c | 15 ++++++++-------
 fs/btrfs/volumes.h |  1 +
 3 files changed, 10 insertions(+), 9 deletions(-)
---
base-commit: 043ad78b53f999f39fbc0044fd8f69d25d300f4e
change-id: 20241212-btrfs_need_stripe_tree_update-cleanups-166f5e7e894c

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


