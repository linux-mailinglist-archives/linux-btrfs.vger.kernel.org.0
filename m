Return-Path: <linux-btrfs+bounces-10940-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8558A0C174
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 20:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5DB3A5E13
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 19:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3A71C9DE5;
	Mon, 13 Jan 2025 19:31:55 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C521C5F0A;
	Mon, 13 Jan 2025 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796715; cv=none; b=ZC3eEfGA8VrE1Xc7PypZsZJzH58A6rBDRH+oWeYK95td92INJAar3aXQ8YJV5xhos7LO7J0flZ82c2sKFjjuJ/sEw6a5pFB5ckgmWPs2AKGl8aM71OTeYNwCQbud6R0iTfYwnLawomXeVuNxIMTYF0y07QjnsE6dAQEcRGe4sA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796715; c=relaxed/simple;
	bh=3Af61QyYAmlEM3Meqd9UTq0EG2Al59MB9Sm2ldv2f2w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nlWLPuTLe6HgSaoAaj6V3/J4V43sbrffqdO+N/oCSrorENcoaX1kv22rZe4LP4Tg6IMaZsYRAyv3nZtnzoyuEPH+CyLuqrsO5RQWM/8KOaXGbpxFbU6Flr34m22mXa6hzIvAJVVVSDnS+F4Q8yLigx/mJTrhOn9lQSIoBJ63BsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43623f0c574so33908505e9.2;
        Mon, 13 Jan 2025 11:31:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796712; x=1737401512;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLlq0D+pZgrro3Loq9FdiMqOuit+4iCczYIXD4C/tx4=;
        b=ONGoa0occ5w1OiDHFYS0ItsjVfIc+jFqzsJxFCEtIyHq9qHAN6BHTK4KvhIh33yYg2
         W8EmTkg7JrbEjxkZ/BLRES9NSOhcLSjAbkeeH++SjpYrnWDQP52Gb4Dq87BCx7QkzBZ1
         OxlAVkJUvDoiGgfSYztvGxkiOmhEPBDXC1Dhmj1TlIKqte2Nh3XlZCupJNjETjHIrqIJ
         0AJUQUVrB5+Q8BNFw9W+FQERamEJPv1pEjGXGL/QiFSJ0StEtvGmj6lSrhjOZQ2YIbIM
         epJWT8awd77PMA7vZJCvPtB1hj5MVPpjNd4Fimb0aJhKu4k5lhvmGrqmSVwjiYeOHBGW
         3BSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU19l0baf89Rkz64asdOJsYR12iBfBpDiVzYGn7rx7bEmoVM+0pycrn0gfCsLB4+lkb+KZLPA3HwJkFeBiB@vger.kernel.org, AJvYcCVaQF+Fznfimen6o/9OIN+5ZRhE52jC8wPlQYcTqDt5r9zGuxFWX/irA8D9jFAhLIIai4HCSbqY6WcbhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbUfeebtKS++5febnu7CVX9InZdLPmV7SZBBtEuj9Ffmz+tfsE
	ubuxkto0/QQcQrEXgHu3xszEg8gXpWEGmW+L73/gqOvEADVMY4KX
X-Gm-Gg: ASbGncvL44hQEjG7UMmT1jjxWr0yY9CgmmBIBk1Mk/Q2a0fh+DOSUg2Hj18CVcekhK8
	E1a3iUMwJfBy/gyQWKBLpNCcZHOOtpjC4hqqxWNLXY2B1ZEkUDSkB4BNX2xbWrS4BGPv1cgjm5z
	MNaLb77Q2sRQwABAEWQWX9ZuuvhJp893D2Zcf3lgXr+v4tMD6RE8Fms3gpkFHnk3/AMxQOo+hxE
	zB+uR3yPl32jkdvja9z5zqjgSHvwEVPk2+yo7Qr9+iOiIiCZ2IU9CPRG9YVTIAQf6V60mVmNQ1v
	1FhW1dtvoKE8KZX/rQC4CabLNmtAFXLt/pOW
X-Google-Smtp-Source: AGHT+IHmV6ewN8ERzYFzN9B0y78IyVZolWe2UZq2Lat6bRXYsYH8Zkb32Tkxpyh0awHrr66b/Cs8ig==
X-Received: by 2002:a5d:59af:0:b0:38a:4184:151d with SMTP id ffacd0b85a97d-38a872f6c84mr19048512f8f.7.1736796711461;
        Mon, 13 Jan 2025 11:31:51 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm186221475e9.9.2025.01.13.11.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:31:50 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v4 00/14] btrfs: more RST delete fixes
Date: Mon, 13 Jan 2025 20:31:41 +0100
Message-Id: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB1qhWcC/23OQW7DIBCF4atErIsFAw6mq9wjygKTsU2amGpAK
 JXluxd7lapZPo3m07+whBQwsc/DwghLSCHOdeiPA/OTm0fk4Vo3AwFaguw4pcyveMeMfAhPTHy
 AY2uFNsMRDKtv34T7oX6dL3UPFB88T4Ruh3wsSI00StnOgrXNGHJzy9PpC2nGexNp3JQppBzpZ
 +8qsFlbQiukMP8TCnDBhTe91F445+EV2xqKehXsG0FVoW+9UU734DrxR1jX9RevYkrOKQEAAA=
 =
X-Change-ID: 20241218-rst-delete-fixes-f2659047f627
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3492; i=jth@kernel.org;
 h=from:subject:message-id; bh=3Af61QyYAmlEM3Meqd9UTq0EG2Al59MB9Sm2ldv2f2w=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaS3ZqmE/Y7xSX/w3/KCy37FQz6K3yZ/nPixnO/N95kRV
 6+/4/nJ3lHKwiDGxSArpshyPNR2v4TpEfYph16bwcxhZQIZwsDFKQATOS3J8Jt1vsat2q8X/u7j
 mq5Qbv3z59QVjxa67TL4uHnPx9niW40KGP5ZHOGRyRE+1cQ6RdRDuetFT4x3b8mepb9Lnq6yCN9
 8iIsTAA==
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

Here's another set of fixes for the delete path on RAID stripe-tree backed
filesystems.

Josef's CI system started tripping over a bad key order due to the usage
of btrfs_set_item_key_safe() in btrfs_partially_delete_raid_extent() and
while investigating what is happening there I found more bugs and not
handled corner cases, which resulted in more fixes and test-cases.

Unfortunately I couldn't fix the bad key order problem and had to resort
to re-creating the item in btrfs_partially_delete_raid_extent() and insert
the new one after deleting the old.

Fstests btrfs/06* are extremely good in exhibiting these failures and
btrfs/060 has been extensively run while developing this series.

A full CI run of v1 can be found here:
https://github.com/btrfs/linux/actions/runs/12291668397

Changes to v1:
- Handle extent_map lookup failure in 1/14
- Don't use key.offset = -1 for initial search in 3/14
- Don't break before calling btrfs_previous_item if we're on slot 0 in
  6/14
- Remove btrfs_mark_buffer_dirty calls
- Remove line breaks at 80 chars if we're just a bit over
- Fix multiple issues on comment styling

Link to v1:
https://lore.kernel.org/linux-btrfs/cover.1733989299.git.jth@kernel.org

Note:
I did not copy the implementation of btrfs_drop_extents() as I'd like to
have feedback on this variant first, before putting the time and energy in
a "completely new" implementation.

---
Changes in v4:
- Handle case when btrfs_previous_item returns 1
- Explicitly document that the root cause of the tree corruption is
  unclear
- Link to v3: https://lore.kernel.org/r/20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org

Changes in v3:
- Drop patch "btrfs: fix search when deleting a RAID stripe-extent"
- Split out setting the incompat flag in the seftests code from patch 1
- Rework changelog of 2/13
- Rename the new stripe_extent item to newitem instead of just 'new' in
  8/13
- Link to v2: https://lore.kernel.org/r/20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org

---
Johannes Thumshirn (14):
      btrfs: selftests: correct RAID stripe-tree feature flag setting
      btrfs: don't try to delete RAID stripe-extents if we don't need to
      btrfs: assert RAID stripe-extent length is always greater than 0
      btrfs: fix front delete range calculation for RAID stripe extents
      btrfs: fix tail delete of RAID stripe-extents
      btrfs: fix deletion of a range spanning parts two RAID stripe extents
      btrfs: implement hole punching for RAID stripe extents
      btrfs: don't use btrfs_set_item_key_safe on RAID stripe-extents
      btrfs: selftests: check for correct return value of failed lookup
      btrfs: selftests: don't split RAID extents in half
      btrfs: selftests: test RAID stripe-tree deletion spanning two items
      btrfs: selftests: add selftest for punching holes into the RAID stripe extents
      btrfs: selftests: add test for punching a hole into 3 RAID stripe-extents
      btrfs: selftests: add a selftest for deleting two out of three extents

 fs/btrfs/ctree.c                        |   1 +
 fs/btrfs/raid-stripe-tree.c             | 144 ++++++-
 fs/btrfs/tests/raid-stripe-tree-tests.c | 661 +++++++++++++++++++++++++++++++-
 3 files changed, 776 insertions(+), 30 deletions(-)
---
base-commit: e6a77e22aa3760314b67b96c8f3d79658a5746e3
change-id: 20241218-rst-delete-fixes-f2659047f627

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


