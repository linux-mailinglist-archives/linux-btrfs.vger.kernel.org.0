Return-Path: <linux-btrfs+bounces-16037-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C064B23C44
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 01:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62FF87A3890
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 23:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBA32DF3F9;
	Tue, 12 Aug 2025 23:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7t0Yc3E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414612F0683
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 23:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755041316; cv=none; b=lJlvNgttlj9V2PElzJtdT1aGqWb0smcK5BiGtcWhYJyhbbeKMcMvLmBGiTNbeVVXkpKdGdOaSFaS7YBXsgsBxh69JESwejZo9q4gY+VKKH0SVYmx396K6EbDY4DcuAxhU9lrwjv4XPh2dfaPI49vXY4gVw2l9Fa40jXzjhtlT7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755041316; c=relaxed/simple;
	bh=M65LYm8pZ3CkLcgjHrFsqU/xIL/fdctA2axc2907Zcc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OitJYXp+8KTtC5DzWAu0HIik8BimIYd0xJISQNJeOW06jr5QCYVyn4dux6mit3kBAKqbHrQ4z8buHtWXTnpuwu8aWbumfR4yk2WCVs/ALLx8W8w3QeFE3Y/zE9wbaqL0a2LvMZRtluG45mn30uvUkibNoSK1iKaVf9YNRersQLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7t0Yc3E; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-71a38e35674so42125717b3.3
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 16:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755041314; x=1755646114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+yVb6wMMApr1aqcMgxZY2UjeTLnB05SgxouOwNcatMs=;
        b=S7t0Yc3EhgtLAYJQUjQn9WL56DNR3WvrEzsDGlTJIBwOTMZhgCEiIqT6617U+xW1Hs
         CNs7BMNqU8slon/n4Wjtyw4HIypqMktnRYvB+IBCp9/LWsK6nKGkKOlbf3ba8W3UjMb7
         u6Fo8ttBCyhHqYcH76sdTNP6GffhvhWDC5UiWK2F8VS/uue8gBS7z/0uDfwH9uQi7Rjl
         iwifmtxZHaDezaGeirJtYb3uzrLm7JcB719A+GWdmA64WSYQgyEv6gNumBgbQjmoLD4o
         s2Los4KDcwSA2eRIO2SuCOpv1miDSdKsph5nCn203vGrue/897LFDFRP4QQIvCHDSy7I
         ZiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755041314; x=1755646114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yVb6wMMApr1aqcMgxZY2UjeTLnB05SgxouOwNcatMs=;
        b=Cyb2BWSm5ZcONuM3i6i4+VO4OWf3h0LwvQD1PMBUOQVYW4imvKv6MGtSoxLoOtDUrw
         UUaDQcrBCP41FSHcs3SYN4XTJUuVSQ4PYY5KPBE/kOF1/rDVngS6/SAwqVRaqwRmLROM
         17EprqZfPdsOUaVD0SbmGI6QZQl+gt+Xp10SwtEqd+rAS6iT6ZfW30IevS8HgLH+Isf8
         xvSLgnk7PlYPW9Z9Pz9gtgqUR6Qg1TEEtHJiABfoT8BSaVlGndTq4DtkK7gmH9N/OHW8
         YzhWEUvOBFxaAgEUDAxmlamTWAGJ5ZJEMjcpzUIJiXKoLv+Mcv/QRgzbAws4jwmy7m3t
         u8GA==
X-Gm-Message-State: AOJu0YyZW4/VLf9DbHk0SYggH078eSrH/rRqt4u6ohTXS8gM5Hjz1G2t
	d6ZX+Ev076Kb1gYTldfwbLomAWBU84ryN1go015y1BTYdSaL0uEJOunYBkP73l88
X-Gm-Gg: ASbGncsBWJ3s8f5wLOGKXSmkezh3mf8w+eKrTGVy98O4BDtBG3uGw810U9MgUHvhiHz
	0s/YCHxQ0obAUaVqGQ40Bn4QonsV17gCs9VLll/yOdbl2RtG8lOn88tDjuJTPRXvAXgsMnJGcyo
	TPzmy6n3jFZtQy8uXFg9h9snQvOH86mK+POS+A9POI5EvJGZzbtzpRno0hQpuEGBxCQIjIM1MQL
	elvsTJP0unk7BPxfqv9nHONJAW7W9EO+YxVc8wTXWoXMUIEm37bxuSIlnvQV2SmcmH4aN29gm6P
	mUZwn0JvFhdU0OyUAeplMP3CKf5xa6RcItU3ZZ4XTq1ncHxETHvnUerHj3hjTT50MoFvgxrdBnT
	jwWYfUl+CgfHujrPddQ==
X-Google-Smtp-Source: AGHT+IGOFofuEJ+dLiBUmLIUdSrSNnpbheFkD4EjO78sR+y3vRHTHG8CBVaprKzKiKMBI0rjH5/lNw==
X-Received: by 2002:a05:690c:4b8c:b0:70e:2d17:84b5 with SMTP id 00721157ae682-71d4e2491dfmr14406317b3.0.1755041314032;
        Tue, 12 Aug 2025 16:28:34 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71bf0db4c2bsm32128657b3.34.2025.08.12.16.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 16:28:33 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/1] btrfs: remove ref-verify kconfig
Date: Tue, 12 Aug 2025 16:28:26 -0700
Message-ID: <cover.1755040815.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Requested by David Sterba to unify debug things under
CONFIG_BTRFS_DEBUG Kconfig. This touches similar code to my
ref_tracker patch linked below, if it's easier I can send out a
new patch set with this patch on top of my ref_tracker patches to
resolve any merge conflicts.

Link: https://lore.kernel.org/linux-btrfs/cover.1755035080.git.loemra.dev@gmail.com/T/#t

Leo Martins (1):
  btrfs: remove ref-verify kconfig

 fs/btrfs/Kconfig       | 11 -----------
 fs/btrfs/Makefile      |  2 +-
 fs/btrfs/delayed-ref.c |  2 +-
 fs/btrfs/delayed-ref.h |  2 +-
 fs/btrfs/fs.h          |  4 +---
 fs/btrfs/ref-verify.h  |  4 ++--
 fs/btrfs/super.c       | 10 +---------
 7 files changed, 7 insertions(+), 28 deletions(-)

-- 
2.47.3


