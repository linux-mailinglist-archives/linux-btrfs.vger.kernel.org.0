Return-Path: <linux-btrfs+bounces-6227-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C38C928B5A
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 17:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB95F1F22943
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 15:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A133D16C686;
	Fri,  5 Jul 2024 15:13:59 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCC714AA0;
	Fri,  5 Jul 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192439; cv=none; b=ErJVxQZRTkj47ejmxfM6h18ej7wCj5Tn0pfu7+Rql3XMGNo1O5KXAclrZZJPAR+y05BCRgVAN7Jh/qGbAna3/DzIo53p+FMkAS3cx9TgXkIArJZYWecGr2Vw1WhqTcpAkyh2jcxt75yEcRf+sccSQHfqF6GP/IMVFhvkrNvNmps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192439; c=relaxed/simple;
	bh=SV97Xb/fqEQbH1/9bAAwNoml0naexLZ53bLuyHb1Azs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s19xPVQrwilOzQYt7U/hFo8E6ZqF6zNjG54gd+984Ub4VD7JACQcZNKC7YzzFR/BhnpVgzw3OUcf5povYH47PJbLv9xHBTDYoH4tagZF73ErKu6z+iqOSnDNhk/UCWHJQDB7dmmKyCU2cklZ9j23WBX9hZniPkcE7FgcBdYAJOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a728f74c23dso211721366b.1;
        Fri, 05 Jul 2024 08:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720192436; x=1720797236;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWGx7JeHTlRm/yHP532z9XZzsP28w+KU7c+2I/8iNZM=;
        b=MXlk9zCLVzZWux4h3SX2Mhh648RjRGcxU/0BXqA2cqbviW9mqfhJswbT869L9bFNYy
         8VAUvnMYMV3JVUtjBY4CfX94BPIZtqrqkpn3zF5JwfJVbIm+w7Ntmi4BF7LVI4pAO7w4
         ZvC4fnqqCx+tvCSleOW3xN/bQykfmOcaNzRZvBNxiwA9vpkHFIJPDxTvWP+ewbNSf6ea
         uv1JDJK+4nOPsM1qxi2pZUhcE8Fdz0SmzJE1Vab5iIoH3AIqq25JkW7jQJTYpfxVD5y9
         G7Nyc2M9d9DSumq4uP9flA+Fg0qVkqgwA3d5YQZEuCQ7PgAi61okcP5kRJ1BSpnh7GQn
         guRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqo637t/UQLCU4ssHiHLa+Y1VuTlaDUTGPOsHjrvdJ2VVaWpPQxRv1H8v134miUzrpoQK/JkijAHhFn3rlMCuPnnL5/ROcPpS00Asj
X-Gm-Message-State: AOJu0YxXP0AhgjVquf1PEo1K6fFy4nJ+IBD4Js4UQt7saUCwR84A5zen
	w23Y5FWvLsmxr0Zz0gSoixDP0mbrHpjSHJQbmp4V/zgh1GKForkTbSWXig==
X-Google-Smtp-Source: AGHT+IFsJJ4hEYlTxobv9M3JSvcOv7dx9gY6HAu5pIhFB4f2CkS6Pi69pCPYJ29Y/iNztJzKdC6+Jg==
X-Received: by 2002:a17:906:43d0:b0:a77:c26c:a56f with SMTP id a640c23a62f3a-a77c26cb3c8mr296141266b.3.1720192435704;
        Fri, 05 Jul 2024 08:13:55 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f72f3200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72f:3200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf6336csm686226566b.70.2024.07.05.08.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 08:13:55 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v4 0/7] btrfs: rst: updates for RAID stripe tree
Date: Fri, 05 Jul 2024 17:13:46 +0200
Message-Id: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKoNiGYC/3XMyw6CMBCF4VchXVszvXCpK9/DuCjtAI0GSIuNh
 vDuFjZqiKvJmeT7ZxLQOwzklM3EY3TBDX0a8pAR0+m+Reps2oQDl1AwoLWkPkz0MVo9YaAWtC5
 UUSuba5LQ6LFxzy14uabduTAN/rX1I1u/f1ORUaCsVIYhGqgafr6h7/F+HHxL1lbk317tPE++U
 kZICzbnqtp58fElsJ0XySNIUSJLRxc/flmWN3ATw2stAQAA
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2436; i=jth@kernel.org;
 h=from:subject:message-id; bh=SV97Xb/fqEQbH1/9bAAwNoml0naexLZ53bLuyHb1Azs=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaR18G7sV/t8YCurvhdHPPOMrY2Zs1du/Bojff2MzIm1j
 i8+VIW0dZSyMIhxMciKKbIcD7XdL2F6hH3KoddmMHNYmUCGMHBxCsBErEMZGV7eutYk77JizQ07
 y1SWc10boqrfn/p1ZunRk1Nm/n4js7aJ4SfjrfLpmlYvmz5Ui8mZzeE9s09gctrv42x1Eo1rWfR
 XdvAAAA==
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

Patch 1 replaces stripe extents in case we hit a EEXIST when inserting a
stripe extent on a write. This can happen i.e. on device-replace.

Patch 2 splits a stripe extent on partial delete of a stripe.

Patch 3 adds selftests for the stripe-tree delete code, these selftests
can and will be extended to cover insert and get as well.

Patch 4 fixes a deadlock between scrub and device replace when RST is
used.

Patch 5 get's rid of the pointless tree dump in case we're not finding an
RST entry.

Patch 6 is a prep-patch form #7 and renames btrfs_io_stripe::is_scrub to
commit_root.

Patch 7 changes the read code so we're looking at the commit_root for
relocation as well.

---
Changes in v4:
- Addressed Josef's comments
- Added patches 6 & 7
- Link to v3: https://lore.kernel.org/r/20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org

Changes in v3:
- Drop on-disk format change as it's in for-next
- Add patches 4 & 5
- Link to v2: https://lore.kernel.org/r/20240619-b4-rst-updates-v2-0-89c34d0d5298@kernel.org

Changes in v2:
- Added selftests for delete code
- Link to v1: https://lore.kernel.org/r/20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org

---
Johannes Thumshirn (7):
      btrfs: replace stripe extents
      btrfs: rst: don't print tree dump in case lookup fails
      btrfs: split RAID stripes on deletion
      btrfs: stripe-tree: add selftests
      btrfs: don't hold dev_replace rwsem over whole of btrfs_map_block
      btrfs: rename brtfs_io_stripe::is_scrub to commit_root
      btrfs: stripe-tree: also look at commit root on relocation

 fs/btrfs/Makefile                       |   3 +-
 fs/btrfs/bio.c                          |   3 +-
 fs/btrfs/ctree.c                        |   1 +
 fs/btrfs/raid-stripe-tree.c             | 145 +++++++++++---
 fs/btrfs/raid-stripe-tree.h             |   5 +
 fs/btrfs/scrub.c                        |   2 +-
 fs/btrfs/tests/btrfs-tests.c            |   3 +
 fs/btrfs/tests/btrfs-tests.h            |   1 +
 fs/btrfs/tests/raid-stripe-tree-tests.c | 322 ++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c                      |  28 +--
 fs/btrfs/volumes.h                      |   2 +-
 11 files changed, 470 insertions(+), 45 deletions(-)
---
base-commit: 3caaac6559396d9e668deb10345b7f3bb45f6ba9
change-id: 20240610-b4-rst-updates-d0aa696b9d5a

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


