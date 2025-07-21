Return-Path: <linux-btrfs+bounces-15581-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D412B0BD26
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 09:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36072189C734
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 07:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CF3280017;
	Mon, 21 Jul 2025 07:02:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5EF218ADC
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 07:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753081349; cv=none; b=bsqMQ8Z82srAV1JMpi5VxeVKBSGTDrkcj5lK8pNCPCCbOVFRcfXQmOTlTX9tfPmK7VFE2yMwN2WUU5K/krafeSrA4MIZ/r+tEU8r8cHSFhxIIsE1meAAq2c21AegirptveIG8teUFqPv1V7QoP4cKuVrfEUepkLzMzrC69e7QEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753081349; c=relaxed/simple;
	bh=+hYbxDxQ8S2a5rBvseHrJmanYCjxponaE2X4VqGHozk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AvNhr/MWnyDJeAttiflPnj/zOZcpz8QIPpTKme+u1LlwkF7kTozFJN+5Ca6UOaqC6N1+2Cc3tjRyj2IEIdgboKE7qrDs/rf/4femRFvBA8rOSDino8eKyOUnPj3+kaH9aj7HP8i7WmNpDxFrocNbcjE6j/Eu0SzzXRNUGszLjK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso2278708f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 00:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753081346; x=1753686146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hh8koKResCAXedMAJmWLlZbi6qGM+dmDWstt6uVVwGY=;
        b=AgpO/RgGNBGps/JG2Mn+ulT1KoFfDIPvJLljb1QmXCjQ+0cKyfhNehYqptKvmPVAO5
         QXX2LNd5GOV1x10pGR2zYsvdxYEGkZjnJev6EDJdhz/6Lk5/NON5dRW1/tslktanmSJN
         OCpseXoHq8wyeH298sKjZedBM518+EJUPm+rwlXq+MqLEgGFIfdK2fxQpVz0OX9/qwDZ
         4VO5fYSw8Z2YqirtLohFWQNMUIyTqoefD96Qx9kFdhRhm4KQyCRvfEQpd2MW2/MhE50y
         GFFEo8tgkX6fm5jEIhfiDAqzlVbkmIV+yPUtk3XlxQ4iPwJapwA82IGzPO+MBMWhcd+6
         s4mw==
X-Gm-Message-State: AOJu0Ywq/fbPDg3b2wgrBNC5mUTYg0UuoyjbVGZtTv7fxRfkTjNdE/Vj
	xP1JVu9iFJ3HGsv07PmAbP4pkbVVnbl2wSljmRSCMRO9dadbBsF9sTxvpJ8n/Td/
X-Gm-Gg: ASbGnctDeXQzwTIgVGXHFc2LPQUISjG3vLEW57oY99+ymDyUPnZySfmUcrM3m4eisgo
	LMUnvyIOXcOWTRjKPUQveygzHcm0Bv4TR4y/ZaRy0T9qiqBtLyRXo0kqDrNT61C4lFTMt6rRxUp
	Uw5uEBkJwxzO6ykpjbxaR9hkiY+0Q8Ey1jR8YPhFAzvi78iuWrX/ls317JBkrx8EqnCUcfjNnhf
	dAettvshlfiNtDXo5PkrWDUt1XlXZ06tepozz+cPNY1X7aQhiIhwQ+qXFUiC0bnykN4/K07YQX7
	cS5Hx0sULDZuXxIZ6pBfYNP38l60NrzETTpAhlLFJ+CSCUnpxPBe+023SyWmbZtI5r1a5PY3RA4
	/sALYlfY26L02EsknbIjddg7BsGwsIRqqh8wMDeOPn6m+cRxxJVNTci/5hXWzohfuGXdnY+U8VR
	QiK2QsPNd0rw==
X-Google-Smtp-Source: AGHT+IHa+eZCMOOZ5i5YsADZLGDMQrLr0Tm/R+LJnqG2ukgUr/p7/jtDWZiTxHja6AHlaskmNysc0A==
X-Received: by 2002:a5d:64e8:0:b0:3a0:7d27:f076 with SMTP id ffacd0b85a97d-3b60dd651d2mr14571401f8f.2.1753081346219;
        Mon, 21 Jul 2025 00:02:26 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f71c45003fa4d1e815666221.dip0.t-ipconnect.de. [2003:f6:f71c:4500:3fa4:d1e8:1566:6221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d73esm9327128f8f.66.2025.07.21.00.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 00:02:25 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/2] btrfs: zoned: two small style improvements for zone finishing
Date: Mon, 21 Jul 2025 09:02:14 +0200
Message-ID: <20250721070216.701986-1-jth@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Two small improvements for zone finish calls. The frist one changes
btrfs_zone_finish_endio_workfn() to directly call do_zone_finish(), as most of
the work done in btrfs_zone_finish_endio() is not needed in this context.

The second one adds error propagation to btrfs_zone_finish_endio() so it's
caller btrfs_finish_one_ordered() can do error handling (in case the chunk map
block group lookup failes for some reason).

Johannes Thumshirn (2):
  btrfs: directly call do_zone_finish() from
    btrfs_zone_finish_endio_workfn()
  btrfs: zoned: return error from btrfs_zone_finish_endio()

 fs/btrfs/inode.c |  8 +++++---
 fs/btrfs/zoned.c | 13 +++++++++----
 fs/btrfs/zoned.h |  9 ++++++---
 3 files changed, 20 insertions(+), 10 deletions(-)

-- 
2.50.0


