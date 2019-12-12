Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38C111CBBA
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 12:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfLLLCM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 06:02:12 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:40332 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfLLLCM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 06:02:12 -0500
Received: by mail-pf1-f176.google.com with SMTP id q8so574402pfh.7
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 03:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y1l7gZ2+CFEglNzRMZgqcNX0k5E4KLSH19WF38cU55w=;
        b=Hn492WbHeeFVSAASGpuU5WgF234rt3ocApuPiDgyugRmTuyJqKqSuy4BSCTEjn7tjT
         Wp3jQ3XDOzx4puIHEzM2peXvWxAQoDUWcYn5Ksdo46Qusmte1+du4uvstAQk9k1WDQ1u
         L4FPtM7OhBzr/1ATTns5pM4/2LM7DMZkBs4ekj9npWHHwNlYmRaX2bF7ug+zTRC/qJgA
         SgOHfQyIDkp6Y9Cc6yZ678iccJ8d2eUo0rVwv2SeJQWH94K6k9VRHGx6xBUu1tRoQQeM
         DNioSwVxjMzvaXL4TsDwxGWPwtbn/r5+Ovek198PxYBi8roRw3r3hZOuL9e4HIvqRgPF
         7peA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y1l7gZ2+CFEglNzRMZgqcNX0k5E4KLSH19WF38cU55w=;
        b=pZwmfQ4IlQ8qa45TqaRIOC1RDmIxtNY4GplprbTZscH7FJZlAH5kaF7Pej5/mUO4LK
         KCP2n//SYSMbxnRJSZ1Sv/Jvm97ZJb/og8J+xpbhULl7RjQvCI4CKczI8oNGMt+mUc4f
         +cDQXn7OmQa1PezE1lypaWLxA2Pw75G7ebBkI73eX8vIRgsHdJdeMnAbu7pK2m2InWa8
         +l3efSD3oX2CS4I7kvKtjyfI1nGvbYKbNWFqHpCPe7Vk3+k0h+PJLuKmO7QiSR8Jcr1W
         FOYYktkwLKK7RndcbHZgrYAq65hApP4wnPN/qQEa5y30B1pz3s5tnvZHDMtEOsNtjak2
         4zoQ==
X-Gm-Message-State: APjAAAXo+sGv0FyoTFuNXjt0+UplwmycTRf2va8EMA2tFgU/wWqCiTdJ
        iJZUgj7KO585GQR+HalIqfFkrNzbJ4A=
X-Google-Smtp-Source: APXvYqyxQ/DvB3tvf+S0ld8wDZaQieJBSmDBMXkkzb7H4vwW/1EYdVbX4LrbbGg84fpVJGHJxicoJA==
X-Received: by 2002:a63:941:: with SMTP id 62mr10110918pgj.203.1576148530940;
        Thu, 12 Dec 2019 03:02:10 -0800 (PST)
Received: from p.lan ([45.58.38.246])
        by smtp.gmail.com with ESMTPSA id e20sm6587857pff.96.2019.12.12.03.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:02:10 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 00/11] btrfs-progs: metadata_uuid feature fixes and portation
Date:   Thu, 12 Dec 2019 19:01:53 +0800
Message-Id: <20191212110204.11128-1-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

The series are inspired by easy failing misc-tests/034.
Those patches fix misc-tests/034 and add new test images.

After portation of kernel find fs_devices code, progs is able to
work on devices with FSID_CHANGING_V2 flag, not sure whether the
functionality is necessary. If not, I will remove it in next version.

Patch[1] adds a trivial module reload operation.
Patch[2] fixes failed mount by mounting another device.
Patch[2-10] port code for finding fs_devices. 
Patch[11] adds test images. 

Su Yue (11):
  btrfs-progs: misc-tests/034: reload btrfs module before running
    failure_recovery
  btrfs-progs: misc-tests/034: mount the second device if first device
    mount failed
  btrfs-progs: metadata_uuid: add new member
    btrfs_fs_devices::fsid_change
  btrfs-progs: handle split-brain scenario for scanned changing device
    without INCOMPAT_METADATA_UUID
  btrfs-progs: handle split-brain scenario for scanned changing device
    with INCOMPAT_METADATA_UUID
  btrfs-progs: handle split-brain scenario for scanned changed/unchanged
    device with INCOMPAT_METADATA_UUID
  btrfs-progs: handle split-brain scenario for scanned changed/unchanged
    device without INCOMPAT_METADATA_UUID
  btrfs-progs: metadata_uuid: remove old logic to find fs_devices
  btrfs-progs: metadata_uuid: rewrite fs_devices fsid and metadata_uuid
    if it's changing
  btrfs-progs: metadata_uuid: clear FSID_CHANGING_V2 while open_ctree()
  btrfs-progs: misc-tests/034: add new test images and modify the script

 disk-io.c                                     |  10 +-
 .../misc-tests/034-metadata-uuid/disk7.raw.xz | Bin 0 -> 48388 bytes
 .../misc-tests/034-metadata-uuid/disk8.raw.xz | Bin 0 -> 47084 bytes
 tests/misc-tests/034-metadata-uuid/test.sh    |  46 ++++-
 volumes.c                                     | 187 +++++++++++++++++-
 volumes.h                                     |   1 +
 6 files changed, 227 insertions(+), 17 deletions(-)
 create mode 100644 tests/misc-tests/034-metadata-uuid/disk7.raw.xz
 create mode 100644 tests/misc-tests/034-metadata-uuid/disk8.raw.xz

-- 
2.21.0 (Apple Git-122.2)

