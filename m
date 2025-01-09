Return-Path: <linux-btrfs+bounces-10851-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EBEA07B89
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3BE165116
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B33921D5AC;
	Thu,  9 Jan 2025 15:15:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8411219A97;
	Thu,  9 Jan 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435723; cv=none; b=Gf6j4Q6KBRd4Kjr7iMPK21F0Zbod6YO3h/WwDr9E8fAgw+otCAy/Q5viYV4sRXnpxoGRhFOAkHYSMUAos7rPgr/R/78RFZhtjQvTpNxofv0LMDuMbGwLYoB02hWOj5fiEUGe+JiVscU80euYwHgBzcrm6j54B8F4A4KzFvPR/K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435723; c=relaxed/simple;
	bh=e6GfzSROLjyWvcTLkIdNJvA+Nq9FgkEo7S8U1eketOk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fNB2vjWX1uS9ZrlYf+ObpUIjbWeRGEOwPLOeLAJzgYpy3P9BgOHvh/WexNw6NDz0EdB3mvVTsp35ELVGhGo9Vie9isCFE8ml/AGOKxaM20I/qQqQlv9u7poihDHJAolOP/H3Ke+YDFDodtFvnsK9JWQWeexo0vtbM//g6Qn73Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso1573222a12.0;
        Thu, 09 Jan 2025 07:15:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435719; x=1737040519;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQOMb5SpUPzIFLBeweyY4qyUbeztk51Aq+rnSu+yKJ0=;
        b=kGp6xWA9VBV3YvrgI/Yl7yUA//NFBFsNJBttuPMrjlYUkhbgrlla20LzQLI3/dLHLd
         SB9IQx7OjyD3fiK9jRj75g2Z/l8tXRROwtwL84t4UBNUU5M47tLCK9PjhLjzOryPLRYL
         vG3z4TRoEl7vNtaVrrYD1H6t96zjZeLZbTATElOo5lME7s9yTHM4iuXPL52i0BZNdT4F
         i1+vLXpEXEh2xfQ2cwEAZTJ9FFN5lrne+pSJdzDgVWrz9amf5UTtxsuGmgqZvuhJwNJJ
         Gj3WDY2H+7HdD/WKim63MvU2E8ZIYqzHEWG6mHemOiK1vxQuRNFLucfrFjurSoifMO+m
         yAQw==
X-Forwarded-Encrypted: i=1; AJvYcCU3yKENMZ056X/KDc8O2DF7qYr/wOedEiGgTc9AYE4CCOnJOrtq4cwZGuar03xC1ppANuK7bLXekapeSCpu@vger.kernel.org, AJvYcCXzR/SWqoHcEq0IfsSx79kcSSd+KHuckDVNJiok6YhU70Rj9OySo+fCqynKZ2ciilHZu1tfTWGNJTCj+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywof2zYxX2T4j1oMeUcZo3vB879xtMxCggRPpkt/uoYUu68ublM
	EKlqqmcNrtqWl9bS5vubU7YgZnwU5XphZ8p3e6bXRpl1XO9BIyfs
X-Gm-Gg: ASbGncukohQNe9o/n8DMvjRZSc7vkX1wCic8BG/o0sgeD2XX15Ve98EVsJXQlkGbYla
	gRiqsmeJFOte7JAKvwhO37d5rNnhUg+MATsNQZdHYF56dNtUiODjGpiDf1h0EKUCiZo7sT82sy1
	w1iKimAWcWI5E1EioajWAl6lu60cSV6HajeM44EDEoXFoBq1rcmMLf1MiKvHnV79JV1Bjl2PCqF
	K0HyvzpDpR6/9yS37wMYWd31MaJ8Use5UOoTOsmX3lYoheMS2EfRhOWSpGOdzaUeu5zgJfmV51E
	xdyHFpbQmsyG3UtOSXNFLx1BozzOXjhoeShs
X-Google-Smtp-Source: AGHT+IHgeyrPdl3Nd0oyPZNmsjdqM73x4nem7dOP2CCZUiI3RgKR19b6x3Qf2Z9XD6aTI251n7UV7w==
X-Received: by 2002:a17:907:d87:b0:aa6:7ec4:8bac with SMTP id a640c23a62f3a-ab2ab709c68mr737263466b.17.1736435718657;
        Thu, 09 Jan 2025 07:15:18 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95615a6sm81539366b.94.2025.01.09.07.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:15:18 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v3 00/14] btrfs: more RST delete fixes
Date: Thu, 09 Jan 2025 16:15:01 +0100
Message-Id: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPXnf2cC/2WOyw6CMBBFf4V0bUk7PEpd+R+GBZYBqkjNtGk0h
 H+3sDJxeXJzT87KPJJFz87Zygij9dYtCYpTxszULSNy2ydmIKCUIBtOPvAeZwzIB/tGzweoKy1
 KNdSgWLq9CI8hva5t4oHck4eJsDtExkWkXKqi0I0GrfPRhvwepssDacE5dzTulsn64OhzdEXYX
 XtCJaRQ/wkRuODCqJssjeg6A7+ydtu2L586q2znAAAA
X-Change-ID: 20241218-rst-delete-fixes-f2659047f627
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3248; i=jth@kernel.org;
 h=from:subject:message-id; bh=e6GfzSROLjyWvcTLkIdNJvA+Nq9FgkEo7S8U1eketOk=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXv2BO9P0sI172QMf1ot2R04LfZ4szdor+eud0wfim8
 XFFy8jijlIWBjEuBlkxRZbjobb7JUyPsE859NoMZg4rE8gQBi5OAZiI81NGht2BOzf79X72MxLe
 3Xgo++P5Z1IzX7FxzN6zO8Lm1sn5xywY/tclTvvtp5/u/DNitTpj9ZNoFq8LC6LjHA6FnmcK6Es
 y5wUA
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
 fs/btrfs/raid-stripe-tree.c             | 138 ++++++-
 fs/btrfs/tests/raid-stripe-tree-tests.c | 660 +++++++++++++++++++++++++++++++-
 3 files changed, 770 insertions(+), 29 deletions(-)
---
base-commit: 1f79f5757e9e4944b1c8490b495e8619974d788b
change-id: 20241218-rst-delete-fixes-f2659047f627

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


