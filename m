Return-Path: <linux-btrfs+bounces-6826-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD2993F4B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 14:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83850282CE3
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 12:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D985C146A8B;
	Mon, 29 Jul 2024 12:00:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5CD144312;
	Mon, 29 Jul 2024 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254414; cv=none; b=ftC7lojBTxpeZDct6pQV9qdNa3T9P0XG9cF3LRUgCpmn5LPqynSykQ4+51YdzgJIigEAS3yC3j4hqx5hFuBm9TQimrPb5DFhjlP/9Fcc651ki5/PLO6wJYJh7dtgK2q30fMFmolqwYHknXaKJ82zEVAC5g8nWHa2aMVysD8mArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254414; c=relaxed/simple;
	bh=8CFsOu8QNh2Xg5Y8ovUasnJJDbq2kvN6PxyxIYRH7Ww=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pFrtRNrhX1vt5Oi10UkfYBFC/7TGzTF+L6jK6nfTVAM2z7n0MCzOei7QYV+V5qnhgcOYTpwh/LBHJnIP3+PcN5qQHcMZvUqb4JE54QaVx/lp7eJO+a3h7t0uEDoLgMYsFTRHXJFTZtPIehRzK9FSzYh5pw6v/xACJHAAIjFWz6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so393080466b.1;
        Mon, 29 Jul 2024 05:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722254411; x=1722859211;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbxaKLryfE2i+373xfwENUclfK7l3RZksGn5hiri11g=;
        b=T2bM4nNuNsrlnNVHDrft0rnVzejfS/HNSrvuAJmb47Nxrr7fzgHqqAYsltR3yppTG8
         H38z3z0zVmqyxfS+TbLF1VCEvUTUVfYCYJQ3dbPyNZumClT2iire8GhI3vQysSKUzLP6
         hAC6hwV0o9lRoCvuoiHKkHX8rXr+N4sh/rlNXQhQh4gru2lREcY3ROHKakZQQvO44cXZ
         qMhYaJZ16iexx5PUS0+xQjWbbBaWsBOzE8OR9uNf/gHJe5BCDRUps21t2NiXU4Hkc2Rk
         PIfYQ26GA6FBMPFjos3QsGZghJ27UvEeMJ5ekLXag6kCGPNocYw+0yHFPp2MN8zGhiaX
         80Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWyEsdCF+ySNOM8nrpx0DZ1sXQD77DpdJO/loSgGM1zm4+PPWJvHCYbQco2N6OkDA32AwIkq5F7sYsn4lq8cIOs7h1J2lNrF6ySH48+
X-Gm-Message-State: AOJu0YwCWVjsiROzrW6HFvgS2M4ggYfw6f8d0+Ka6XDGL3aYSknxPaTJ
	1q7JCddHcbZWaJ+zoc8WIBqFHdyy/4oIydF/xm/U7P07SHRJXJaIiCv2aA==
X-Google-Smtp-Source: AGHT+IEjtwO27iOqJNyZwqQYPtuxlWvdjTsPwoCjQQVv9ptPGw60MIoEPLOF73l68lARNJV0Hz1V3w==
X-Received: by 2002:a17:907:7244:b0:a77:b3c4:cd28 with SMTP id a640c23a62f3a-a7d3ff57766mr522801266b.9.1722254410571;
        Mon, 29 Jul 2024 05:00:10 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2311asm508136266b.18.2024.07.29.05.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:00:10 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 0/4] btrfs: fix relocation on RAID stripe-tree filesystems
Date: Mon, 29 Jul 2024 14:00:01 +0200
Message-Id: <20240729-debug-v1-0-f0b3d78d9438@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEGEp2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyMz3ZTUpNJ03TTDtFQLA9PURGPzJCWg2oKi1LTMCrA50bG1tQCDl9D
 EVwAAAA==
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Johannes Thumshirn <jthumshirn@wdc.com>, Filipe Manana <fdmanana@suse.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; i=jth@kernel.org;
 h=from:subject:message-id; bh=8CFsOu8QNh2Xg5Y8ovUasnJJDbq2kvN6PxyxIYRH7Ww=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQtb/Ewsr6idW65u3+eGlP3x7vt/6zZJC5vEQ7pu9cbG
 Ta712VVRykLgxgXg6yYIsvxUNv9EqZH2Kccem0GM4eVCWQIAxenAEzE2oPhf0KB+Ne+6LzVTQKG
 90Luf4+fUtR1bFqBAtPHPQve2qebGTD8UxLTlouYeX7KHMG6T5XeW0yWz7Hp/hFpbPhifuFfVbN
 8RgA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

When doing relocation on RST backed filesystems, there is a possibility of
a scatter-gather list corruption.

See patch 4 for details.

CI Link: https://github.com/btrfs/linux/actions/runs/10143804038

---
Johannes Thumshirn (4):
      btrfs: don't dump stripe-tree on lookup error
      btrfs: rename btrfs_io_stripe::is_scrub to rst_search_commit_root
      btrfs: set rst_search_commit_root in case of relocation
      btrfs: don't readahead the relocation inode on RST

 fs/btrfs/bio.c              |  3 ++-
 fs/btrfs/raid-stripe-tree.c |  6 ++----
 fs/btrfs/relocation.c       | 14 ++++++++++----
 fs/btrfs/scrub.c            |  2 +-
 fs/btrfs/volumes.h          |  2 +-
 5 files changed, 16 insertions(+), 11 deletions(-)
---
base-commit: 543cb1b052748dc53ff06b23273fcb78f11b8254
change-id: 20240726-debug-f1fe805ea37b

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


