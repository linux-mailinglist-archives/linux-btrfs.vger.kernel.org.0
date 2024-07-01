Return-Path: <linux-btrfs+bounces-6068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB3891DC60
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 12:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879371C214FF
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 10:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725C613C679;
	Mon,  1 Jul 2024 10:25:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0BC381D9;
	Mon,  1 Jul 2024 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829526; cv=none; b=pskZ0tc/Q7v3tj8TdiMD5wGm1Zi8tHIwkOMqDj/SgdhJUdyWDc+ERIcQPNjjoVMXMFCoghUyw5I11lsc2KfiLjIaWWe3htBh7VsMfrU4adrlWb4fuLtjhK4GlYBwsn5BU3v3JpIOwiQo7rk+4wEFNVz2aotW+ey9TVuf8/bUTKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829526; c=relaxed/simple;
	bh=EME1nCS/Md7lYcSmoN4wi9HeeVcxdZSWp7ZsoQPOq7I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=an1+rHqUzJNoz1HfQRgojP5VC+sZJd2PCyiGa8lY0nYo0nHAtAlKEbBy5nvAq4rfqHOnQ3X6oDjdHUkCmHw6GMgji9ku4zq2+LWVOk0Jn3XZP9XiQIWM8caCnLOLMTNJjGQmZiU37bzFWafCZ5oeMf2CCT9UKpD8ZYfD3gg7HwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee83so63967a12.2;
        Mon, 01 Jul 2024 03:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719829524; x=1720434324;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsb+yJZfWamZNZnOAPUKUarYWy1uAoOpsOR2q1dfC6E=;
        b=T340e0gzMp/74J7Z9jfjAv0FfuC8sdwHu+SNhZ1KJY3SF8+kiXo2gTznLI2/A0gjjI
         Rh0dizZ9rfeWrdSKHq6C/z/hTUGg6xBujZGzJmSHW+g+ivmujP5NQrYCjGo5HCCQCXK3
         lsZePH9/E3Urt01Imn0p+pGIklLo991Aw/mo6grpbqDpIX8M+N8BDkm7d2Eo9reDw5tf
         s8fYnClkf6YAyfEzwHigzg0KACyGmSLEeMzqKM80k1P2j11wh6bSH15MrVon/Z6RuDOF
         qDnbM0jDY6zgPYpaplJDlj3ESAEqEXJCPR5wB1I7duNYdFUSYa0pczBaDmyD+Id0lAh4
         8UXA==
X-Forwarded-Encrypted: i=1; AJvYcCUoPAl1hW5OVVUomE/yIPq8R9/o2mbaObtvWPK3NEeapOEM8fPFOj2sUN26q2JiggONLyQ7wJAAQzoBYpoCtdcV8EoppGEayQV5eXr7
X-Gm-Message-State: AOJu0YxSHSgppFf8jWK2VRCkaA6m0FmPPhR6+sKMyF4YUL3XvgsqcF8g
	Svpnq/KUEtOIj3b8C9CZsRrGs2ehXeoChdFf9dhWEzoNqYPimeonC0i/PA==
X-Google-Smtp-Source: AGHT+IHdi3vMPdBI3JW9n8NHumteOVPLzSNivjsZdwhhqL0s5rwzElWV5XrS1QIy/N+fACF4jzdTaA==
X-Received: by 2002:a05:6402:5203:b0:578:60a6:7c69 with SMTP id 4fb4d7f45d1cf-587a0635e4cmr4310424a12.30.1719829523577;
        Mon, 01 Jul 2024 03:25:23 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f72f3200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72f:3200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58612c83583sm4238901a12.5.2024.07.01.03.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 03:25:23 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v3 0/5] btrfs: rst: updates for RAID stripe tree
Date: Mon, 01 Jul 2024 12:25:14 +0200
Message-Id: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAqEgmYC/3XMyw6CMBCF4Vcxs3ZMWy5SV76HcVHaARoNkCk2G
 sK7W1hpjMtzku+fIRB7CnDazcAUffBDn0a234HtTN8Sepc2KKFyUUqBdY4cJnyMzkwU0AljSl3
 W2hUGEhqZGv/cgpdr2p0P08CvrR/l+v5NRYkC5VFbSWRF1ajzjbin+2HgFtZWVJ9e/3iVfKVtl
 jvhCqWrL78syxsacyCO7QAAAA==
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1935; i=jth@kernel.org;
 h=from:subject:message-id; bh=EME1nCS/Md7lYcSmoN4wi9HeeVcxdZSWp7ZsoQPOq7I=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQ1tQiu3K++9lUy+3Sh+NbeD6+W7X3w9HLfi+1PVsp/1
 bv+WZ79UEcpC4MYF4OsmCLL8VDb/RKmR9inHHptBjOHlQlkCAMXpwBMRKCJ4Z+567HL0uUzdIPD
 V5kX/tbOKu3Z0StUFMS7bue/WVx+VXoM/6zn/xeU2lhq9uyoavAE0curlc1z8z5eT+K+/DKvivP
 GMnYA
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

Note: There still is a known bug triggering a crash on btrfs/06[01]. I'm
working on it, but I've not yet root caused it.

---
Changes in v3:
- Drop on-disk format change as it's in for-next
- Add patches 4 & 5
- Link to v2: https://lore.kernel.org/r/20240619-b4-rst-updates-v2-0-89c34d0d5298@kernel.org

Changes in v2:
- Added selftests for delete code
- Link to v1: https://lore.kernel.org/r/20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org

---
Johannes Thumshirn (5):
      btrfs: replace stripe extents
      btrfs: split RAID stripes on deletion
      btrfs: stripe-tree: add selftests
      btrfs: don't hold dev_replace rwsem over whole of btrfs_map_block
      btrfs: rst: don't print tree dump in case lookup fails

 fs/btrfs/Makefile                       |   3 +-
 fs/btrfs/ctree.c                        |   1 +
 fs/btrfs/raid-stripe-tree.c             | 143 ++++++++++++++----
 fs/btrfs/raid-stripe-tree.h             |   5 +
 fs/btrfs/tests/btrfs-tests.c            |   3 +
 fs/btrfs/tests/btrfs-tests.h            |   1 +
 fs/btrfs/tests/raid-stripe-tree-tests.c | 258 ++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c                      |  28 ++--
 8 files changed, 401 insertions(+), 41 deletions(-)
---
base-commit: 9c681cca9c5f8e3bd5891f3944f7b9ce4d14f4ec
change-id: 20240610-b4-rst-updates-d0aa696b9d5a

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


