Return-Path: <linux-btrfs+bounces-10762-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7656CA03FA6
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 13:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56497165ED7
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 12:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C671EF0B7;
	Tue,  7 Jan 2025 12:47:52 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8528F28E37;
	Tue,  7 Jan 2025 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254071; cv=none; b=MeR0qfJT+6cXpIcS6LN/ZeXbugTCXg6XhTQHGirZh61nkrixty4vnSfoi2B5oxtF5LcjalR06pPXbJRFqAd0bUcK8rdK+rUYrFW+fDOAYXQwULijO0MFDq7gblZ0j8N0BJz7vUQVFWRPySmjJZJPdxSg7dDJ6hFcCJ6hHddDypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254071; c=relaxed/simple;
	bh=83Wg5Gj+51lGeT9oK05tK0Zt5yPAtikvh6XcimiDyJ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aTxjIknX6epauT66GhixrObgNtF2+DuxSNDhN/+GgMmtHKmKo63z61oLiwjbKC7BEs+DgfEOPfsaN9BbRVSrNs1m8xTDQwWQn6P+8Y1F0Ec9BGS75jl0HkYA5fYWaPJm7h/5NqMSgZKjgSi3zH1nYwf/E7wr32MmO8jwbZIKS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385de9f789cso11537280f8f.2;
        Tue, 07 Jan 2025 04:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254068; x=1736858868;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipFTM9rmKG/xzZX38KpvyVXjfFk8dlE4j0tt/SzLg28=;
        b=kTpWw1bjPqZKYW4q5zlI44ADCO0oMpKp/QDbegOd6Vzgax5Amy3DRHUeGEpB+5R+FD
         y2kO3tLfWA5cBSBWWhayzifrnpbuQikRynyBDh6jpxqSKA0f5l+ZQvXQZb3YP9AAu9Aj
         i6haiVffYvSDb9Qh63N2h2vl5ZjaKYB/zhfx2UrpDJKKDdkfzrcs9JS2odo7OYi3xWaf
         bNiuku+EGONNHBS0/ZuFKtBFoaDxQQ0VKT3TofIxUnUQlTKq9Yg7uT24wvACD4gBJZjJ
         dO9wUQYhZY0vKXDUcUvmET2QXUfHeubA21QztauhORVOSMLFqbrga5v9IgyOQ1n3j3PN
         Cv/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwhFDWzJ41EyaigNnKKbAanlc+PC7YsAd57fCV+2EVnc8KW5vA//F0ciLKjAGGbxxli6S1eLppCyRd3Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRJfChC6dN4ekI6L9s76QV4HjZ05h/DqwM6fTrV1Db7Uh9LHpR
	mEQci6beTSMfJ7WmKLccUanI6vDMgZb2u90jWIFiM86MJTJQBZ16ir3O1g==
X-Gm-Gg: ASbGncvBZZpN7w6dPCHQDxAOqOTcs236XH7NjU0HYS0kdsRLrSoSFIe5b1BcbDlp/f1
	5gLaQv1lgZCieQknlO56FXxj3+kQz0spu+rWfSDT4iQsCWCMVyO8QMDGJZ3imJSOcmiqM9qhumj
	2Qqhl2D+i40qdnMISiYnDqEb6O42d1fpkOiGArkHPIOK5/+oDl3LuTFbnJ3eMl/fTA+z/BFq6RT
	eng1l0TGiqXu3BWCD6Zrw9sYen5barM/edSvjbCKzOCFqPAEazg1YJt0aFHXkWy5K6GMOFLDFs0
	pUytgD1x6W+5AQudjRkfQmgut216CcbygM3k
X-Google-Smtp-Source: AGHT+IHmC5RgSKdpjL3VzwFGVl4Q+RhA1Inal2ZCZnludx8DUXnvaZIiaP20PexE9+XC3xpf9m0/AQ==
X-Received: by 2002:a5d:6da8:0:b0:385:edd1:2249 with SMTP id ffacd0b85a97d-38a224088d3mr50845633f8f.50.1736254067540;
        Tue, 07 Jan 2025 04:47:47 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c508sm596884845e9.33.2025.01.07.04.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:47:47 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v2 00/14] btrfs: more RST delete fixes
Date: Tue, 07 Jan 2025 13:47:30 +0100
Message-Id: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGMifWcC/x3MwQqDMBCE4VeRPTdBV6ump75H6UF0omltUjZBC
 uK7N3j8GP7ZKUIcIt2KnQSbiy74DL4UNC6Dn6HclE1cclNx1SuJSU1YkaCs+yEqy+3VlE1nW+4
 oZ1/BOeTq8cy2Ej4qLYLhPBrDBtFVV9emN2yMnl3Sr7Tc3xCPVQeZ6Tj+pF5GAJgAAAA=
X-Change-ID: 20241218-rst-delete-fixes-f2659047f627
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2867; i=jth@kernel.org;
 h=from:subject:message-id; bh=83Wg5Gj+51lGeT9oK05tK0Zt5yPAtikvh6XcimiDyJ0=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXKhUclf1zdLPVqSa/Ko2d1S/+r1qb+mbn4lyLC2vz5
 1tN87UP6ShlYRDjYpAVU2Q5Hmq7X8L0CPuUQ6/NYOawMoEMYeDiFICJMAcy/A+UNlm7+PD+eRJC
 qgGtzP2nn1bWbF4kIiB++9IkY4nf584zMkxjLXO9KX3j6o4EpZVWJxe7c2qbL9OztZ7epzjXL2+
 xLA8A
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
Johannes Thumshirn (14):
      btrfs: don't try to delete RAID stripe-extents if we don't need to
      btrfs: assert RAID stripe-extent length is always greater than 0
      btrfs: fix search when deleting a RAID stripe-extent
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
 fs/btrfs/raid-stripe-tree.c             | 146 ++++++-
 fs/btrfs/tests/raid-stripe-tree-tests.c | 660 +++++++++++++++++++++++++++++++-
 3 files changed, 776 insertions(+), 31 deletions(-)
---
base-commit: 86e936bc54aa920fa4249f3fe96b4420964901f4
change-id: 20241218-rst-delete-fixes-f2659047f627

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


