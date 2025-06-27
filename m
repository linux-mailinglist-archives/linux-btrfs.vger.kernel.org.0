Return-Path: <linux-btrfs+bounces-15021-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2024DAEB2A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 11:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1721161891
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 09:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C72298996;
	Fri, 27 Jun 2025 09:19:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3934A0C
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015966; cv=none; b=ASJusg2pueTdYLqxh9WSKMDSgMarPu1ab65EGIDux3IpyR4eQjTLUDEYi5sN22yRdKtIiG6ljprrt5IWFzNkhqiEu2HkG6b+BKR27MDafAYYLGFpdHPry3VPP3av10ljLgCKINAHw7X9IwRiS1lTP9rXeQrCKWX1fRFSSW/Ag58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015966; c=relaxed/simple;
	bh=JKrIzlWzOLfUJzeKM9CR5wd8oAhYfBYGdXNUxfpm8e0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oRVC5+7N9M7XtBArHi/nLdDuZjiTzpBqzp/0TbXpxE2obajMryAovpaoDgd5vF8l8YoXOnnj42KlfxkFD6LcqeDDsBwipwuAgmi7W8Q1VZ2TDdZLCwgCxknP0d1Auce/dECF2naYdEFj3rg8AGmF9fRmsjLRoxLSw+AZD/emlcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-453608ed113so18495205e9.0
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 02:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751015963; x=1751620763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxRoFr38YOkbzU7kpIxy8ZfG9e6Qq17p55bGL/TNS/o=;
        b=LX9wPRFsRYCqNPsqkzZqkUvOVjYOXZ17Rd7vaxrcHuxlJACzNL6zjaTrUEZzbvp3V/
         E+dP0uBww5n/fU6ngI4wbvI59yRF8rmg75eKT3ae5sZP3CqwMCAqRQE208SDyzeY6kW0
         8RIg+yc9I2VI3+WOvCterF6vPoXYW7SyVQLFOPW1c23gsbEwa+D0w1YFbrP9bZa9Gq5D
         /y26j4STFvwTj1krjCVDlxrc/Rmuu1qZd/tzCI9C+ew5j4QH5cpCMXFBcdGn4JlTTRZZ
         t3lTNN8loHV4u8Qml7+pVu9YYB+UNNdh6PU43cuLnf0Qe68pxb5i2xrFdOK4b96fXrFW
         3ZlA==
X-Gm-Message-State: AOJu0YwjHhtJDLzP/vyrmH81t7EekDhSQsiNGGy4xRoEsIXq83vXaMWo
	4Gyc4/z0tRlyyK8qj9aqe8P+TBDvzolWTsJxrJ9dGpYQt89gZsfSuZy0ud2QbA==
X-Gm-Gg: ASbGnctH0d1Odog8pD/6SfPCzR7cxelg5SrOFiodsvJSHDROxuBb7HZYEyX5YPt6Gop
	/efSASNvC6sDMIrbPvnzjux+6a/JyNAdSjFoOAf7PQsDNEjLi6OEfqRh4KlAj/0cEl1HVpwM5s4
	8TXiZqOp7MeKe4yrUc/sBGCuZ1VTlDdEymhjq8TRC5I2T7WP600dRJmy1uyX9VJ1cyxzxbxZbEi
	F0nGNvVQAIgKZOuftyHrmWZ6gr1hKzVwnbm65g2ZRF0rC2tbHAwCGW9pC/NN6jzRLUWpJvehLMT
	CG0MoPxR6mLZ9ZK8mg70jPcv7xHnEKByWTDk+c5aEkBoLOSadtzPS4N9qOXuHxDxqNk/MYkiiQi
	+RzcLYrLhvTHf5lyljt1G6MgLLzGpmBme3CJmCBsua8vqSLxn
X-Google-Smtp-Source: AGHT+IHmfkaHbP3fGU8mpJSW1wFFxTmWDI5yB//50uHud2/Ybq8OYX2Ix5pN8nuNJ+UxFB2643YRqA==
X-Received: by 2002:adf:9cc7:0:b0:3a4:ed62:c7e1 with SMTP id ffacd0b85a97d-3a8f4549318mr1818636f8f.12.1751015962450;
        Fri, 27 Jun 2025 02:19:22 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f719b2005a9e6e27159b0eb3.dip0.t-ipconnect.de. [2003:f6:f719:b200:5a9e:6e27:159b:eb3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5966csm2152556f8f.72.2025.06.27.02.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 02:19:21 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH RFC 0/9] btrfs: zoned: fixes for garbage collection under preassure
Date: Fri, 27 Jun 2025 11:19:05 +0200
Message-ID: <20250627091914.100715-1-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

A few weeks ago Damien started benchmarking zoned BTRFS and zoned XFS
garbage collection on SMR and ZNS drives. 

One of these benchmarks was filling the FS to 75% and then subsequientially
overwriting the files again.

One thing that came out of these trials, is that BTRFS on ZNS devices did
not finish the overwrite phase because it prematurely ran out of space.

Once I tried reclaiming earlier (patch 9/9) I've seen haning task because
of extremely high lock contention on serveral locks. The patches 2 to 6
either remove these locks, or in case of the space-info lock remove
unneeded lock contentiom.

Patches 7 and 8 lower the log level of reclaim messages, because with the
automatic reclaim BTRFS has these days there is a lot of log spamming.

Pathch 8 triggers removal of unused block groups on allocation failure, I
opted for making it non zoned specific as I think even regular filesystems
can benefit from this.. The first patch from Naohiro is also needed so we
don't prematurely finish metadata block groups on zoned devices.

Reasons for RFC, there are a lot of locking changes involved in this
series. As much as I'm comfortable with running fio workloads and fstests,
I really prefere more eyes. Especially Filipe always is a good reviewer of
locking related changes and Boris for reclaiming. The series is probably
not the final solution either but only forward progress, but I don't want
to be running into the wrong direction.

This series also includes a previously sent series of me titled "btrfs:
zoned: reduce lock contention in zoned extent allocator" and can be found
here:
https://lore.kernel.org/linux-btrfs/20250624093710.18685-1-jth@kernel.org/

Johannes Thumshirn (8):
  btrfs: zoned: get rid of relocation_bg_lock
  btrfs: zoned: get rid of treelog_bg_lock
  btrfs: zoned: don't hold space_info lock on zoned allocation
  btrfs: remove delalloc_root_mutex
  btrfs: remove btrfs_root's delalloc_mutex
  btrfs: lower auto-reclaim message log level
  btrfs: lower log level of relocation messages
  btrfs: remove unused bgs on allocation failure

Naohiro Aota (1):
  btrfs: zoned: do not select metadata BG as finish target

 fs/btrfs/block-group.c |  2 +-
 fs/btrfs/block-group.h | 11 ++++++
 fs/btrfs/ctree.h       |  1 -
 fs/btrfs/disk-io.c     |  4 ---
 fs/btrfs/extent-tree.c | 81 ++++++++++++++----------------------------
 fs/btrfs/fs.h          |  8 +----
 fs/btrfs/inode.c       |  4 ---
 fs/btrfs/relocation.c  |  4 +--
 fs/btrfs/zoned.c       | 19 +++++-----
 fs/btrfs/zoned.h       |  7 ++--
 10 files changed, 55 insertions(+), 86 deletions(-)

-- 
2.49.0


