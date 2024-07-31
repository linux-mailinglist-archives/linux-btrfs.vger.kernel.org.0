Return-Path: <linux-btrfs+bounces-6922-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324FA943743
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 22:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02532826E0
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 20:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79377167296;
	Wed, 31 Jul 2024 20:43:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E0FD512;
	Wed, 31 Jul 2024 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722458607; cv=none; b=Sx7vJDdIoQhNKoL93/i6bkzGBjLcCCUEOmJbDjPnXfQR/ad6AbmCvIR+PGoQtlDnJH/zvwLn5fsvxEqrKeYhHEhYhcgMAoAKaRsila/VlGg4UTfTxqDsB+0OwFex/jQCN6UcijGoamqtO7SdNM4zhGUAw9Z1OcO6e9cAKcDS/eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722458607; c=relaxed/simple;
	bh=XwoMm5/T+XVDXoHxo4PpcBf7NA0bt9kqObHe378nvK0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mqhPGPaf3JJlIY5h0ZxoswHOPLPpHqzOYjMmacov2hkiiD3/oxFxE/aC+xCWwuqB5cUVABH/V3m8y+LyhSbNt+TbQ3N9X2wFed/TPjTwkOjhsUFDjQaiW9VqmVTvoeOGdW6JTNFpPWO4aWjfDeY5WMg2TW28351IX2HbmvpD/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a9e25008aso825869266b.0;
        Wed, 31 Jul 2024 13:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722458604; x=1723063404;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OpaLVy9cGDD/4a3pTebZNXdqhtawtxouZpwolMeqF/U=;
        b=fpcPltFLOLOsb1V8qzVbPYQlLnddMEBuszjBwQbQ0rmHrUqiya2q3jNThLCAQ1grmS
         Z5iC/jzhvYPJX5tTcVG+EwOwK0vSv/yAT/3tGq6aCcO/XMny0M41e1lrE9/rvpMxl5uS
         wejR2VKFhd0esfNz41TE2co/cp5NiwnYkskrrNVu/DPDzGsG90bWgJK29cwksQPdV5ET
         CSW4fJvBC+ua2SO+dYXnFdiz5zuKXNAGOEGr98p3525aQqPhHSfHeyKFZPNK9cE8Hpvk
         z2LYkszGCoopiXQA8Rh1gUkzbDpyzttl+3QUNDBIe4Ilcl2vEyyfrLOjosadZIlDLue5
         FNdw==
X-Forwarded-Encrypted: i=1; AJvYcCXdZqszyLHI5kBiiHZYHrLCeeQbZDc9UnKkUFhjMiJd+up5RMRK3Cacv8isKWQB7vRbyz264sNf9ddbQik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfwytULTXG5nLbJNAJUEbd64yLzPQPdJotnU77mO7EXm217MEl
	BndLZPSjlizzzxAMXjixMtuMjDgfmS6O2Ja3jLSjoPZBXIZrRqF2
X-Google-Smtp-Source: AGHT+IFP6EXNPQVMEuPDDEIg+Hft7xijxVY4K8EGnpJs1qXsRK9TQ1sL8HwU6bdJeFSwecbN3wCKbg==
X-Received: by 2002:a17:907:e9f:b0:a77:c824:b4c5 with SMTP id a640c23a62f3a-a7daf9b165fmr18011166b.18.1722458603371;
        Wed, 31 Jul 2024 13:43:23 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4dec6sm807454366b.61.2024.07.31.13.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 13:43:22 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v3 0/5] btrfs: fix relocation on RAID stripe-tree
 filesystems
Date: Wed, 31 Jul 2024 22:43:02 +0200
Message-Id: <20240731-debug-v3-0-f9b7ed479b10@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANahqmYC/1WMwQ6CMBAFf4Xs2ZqlxbZ48j+MB0q30GjAtNpoC
 P9uIZLocV7ezASRgqcIx2KCQMlHPw4ZxK6Atm+Gjpi3mYEjr1BxySyZZ8dc6UjjgRqhDOTvPZD
 zr7VzvmTufXyM4b1mU7msW6H+FlLJkDk0wipt60ro05XCQLf9GDpYEon/aAI3jWdNaJISFbWmk
 X/aPM8f3cRahtIAAAA=
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>, 
 Johannes Thumshirn <jthumshirn@wdc.com>, Filipe Manana <fdmanana@suse.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=jth@kernel.org;
 h=from:subject:message-id; bh=XwoMm5/T+XVDXoHxo4PpcBf7NA0bt9kqObHe378nvK0=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaStWvhSuEqkq9dDyj3GRMa7ed+BhpxF9rMuHw7ifizhE
 Nu207u1o5SFQYyLQVZMkeV4qO1+CdMj7FMOvTaDmcPKBDKEgYtTACbC9Zbhn1KwiHVsPN+STemp
 X3xZWrKr3+eYSepwBEluz1q2dn9pPyNDx0rOB56u8bvSZZcVCjlULwyI80gMn3+1kqMzjOGm73R
 mAA==
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

When doing relocation on RST backed filesystems, there is a possibility of
a scatter-gather list corruption.

See patch 4 for details.

CI Link: https://github.com/btrfs/linux/actions/runs/10143804038

---
Changes in v3:
- Re-base onto for-next with folio->page conversion applied.
- Collected reviews.
- Link to v2: https://lore.kernel.org/r/20240730-debug-v2-0-38e6607ecba6@kernel.org

Changes in v2:
- Change RST lookup error message to debug
- Link to v1: https://lore.kernel.org/r/20240729-debug-v1-0-f0b3d78d9438@kernel.org

---
Johannes Thumshirn (5):
      btrfs: don't dump stripe-tree on lookup error
      btrfs: rename btrfs_io_stripe::is_scrub to rst_search_commit_root
      btrfs: set rst_search_commit_root in case of relocation
      btrfs: don't readahead the relocation inode on RST
      btrfs: change RST lookup error message to debug

 fs/btrfs/bio.c              |  3 ++-
 fs/btrfs/raid-stripe-tree.c |  8 +++-----
 fs/btrfs/relocation.c       | 14 ++++++++++----
 fs/btrfs/scrub.c            |  2 +-
 fs/btrfs/volumes.h          |  2 +-
 5 files changed, 17 insertions(+), 12 deletions(-)
---
base-commit: 27d58e7d992b58ae7091270dc179e1dcbd6561f8
change-id: 20240726-debug-f1fe805ea37b

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


