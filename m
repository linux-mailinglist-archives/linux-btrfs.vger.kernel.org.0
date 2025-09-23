Return-Path: <linux-btrfs+bounces-17101-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB275B93CDE
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 03:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E4B2E1911
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 01:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EE31DB54C;
	Tue, 23 Sep 2025 01:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBMkdB5X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B051DDA09
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590004; cv=none; b=dVlQJvxfrJPaTrfRWplOMNhC9+1KIL+e2oo072vHixgTiDQGmdVrw3R4deZIdcNUo6uqCuTpYmKuwJpP4RmDtbFz9wVq0t1iE3VkommtsJcw2ZwAElYpKyg75gBORWZJfVEwgJ28nCMmAx1YbT972b369wevf5b30vdmdcPfbYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590004; c=relaxed/simple;
	bh=At/7Xqs6s16tEkKPJ6g6gPylMqgBKm6pWyU9R/TShVU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uXDjCqwUol5x4fhypg1C4qW//Q+CkysmAJxOwyrVjFJVTYKb0LJYOd9vPKMTXFxrnWQx55UouEz8XDNUHYIyGmSR6zxif5AVdTRR3fNMVsrrvSYC+RSRzaGA5VJnYC0Vx8HemaIKN+XJc68l1Qz+IvsC8VvODvFQCTGXBgRzPEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBMkdB5X; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-ea5bc345eddso4041102276.1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 18:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758589999; x=1759194799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2oGRph3OQIPuazm8NbtJv0rLg0MtPEs31XRN1GKhE/A=;
        b=TBMkdB5XaUh1tsv7gbbyOS0Ka6KQ/hJFyB5F2Bp8Tv7K9DnymwXtky3tT+QCyqNMHa
         DFh6btRxarZFn7M5sSmV0qu9v8/pu0sW93c24EuT7lmfEkxuk0iQVGuOa6mRVOQWfJaM
         6rHDQlVDz5Ssjmxg6gAtlPGWdDzzyZ5/TX1rnr5gGwIrVTHw3XKF0Yo5X8c+ak3GNSze
         EZwJdIhXTVFOGaWdtqbH51ulZ/jVzDJVfIidwtjpApnxkigKDyyFpG/aKTn9i5elYQ4p
         4zCI0HfCRK2QdfzvYqqZtL4pGcjcQs+F12pboyPQp9Zw5OJrv77oj3f01/tC0BtETovA
         rpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758589999; x=1759194799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2oGRph3OQIPuazm8NbtJv0rLg0MtPEs31XRN1GKhE/A=;
        b=RD6LJxJpa/5GcW4eWNv8LFjxp3BGOjYbjZOGPBNtjz1AvC8dIfaWDga3fX+mXsBXmD
         Bt/7K9qoupVa7CZVA+Y/Eiu6hODKyTPe274jH3EWynCX1dZHGKMCZnp5HGzuw/Gqe0cS
         B2QdATqlHClJ2hF9lTfxx58cAGMifsSD+HKrl47OHaw8Npsd02n2WdpAmxx+umsVnr/w
         LvhNAGM947uqH9Yimorq3p8LcorHj13MTOl59p5uZ74K58ow3giLkTSVWzz874o3W++j
         OI2n/gOGoTs+t+DrTJjk6xwx3kCEFrKwBFAXRedQUVSA2qhygS9j9/9b5dUzeOTxQmbH
         40DQ==
X-Gm-Message-State: AOJu0YxNp6136gQWVKfoEb8oQO0Ju9hbF6ClJd29bKmdj0nnZV4DeNJz
	WbUX1LkyK3OIKTF8VSHDvodaWRpACDKIOb2bRbyTbvqeym3Erxu+nbdyQS7k5b5b
X-Gm-Gg: ASbGncvsaMrGsKDG+OShINN6LtWtm9F05NZZt3yYbYy//r1MI+sls5GooO2Uxb74CcF
	Qc6IN/N27l8fHdBK0zuczxZJRHGNgn015lQy4GX/VwBpE0mUaFZwpyz9cEyfiDqpy68JSwhucqc
	1sPcsk7aPj2H/782LqifASPFL7NTPmVbnk5068LcY5qUshDA6ZANQWLYX+Fx4g1NPS35JIlz2Os
	ayr9xHqou7OwCXaZU6rrbeZT5iU0NrcE8wpCCb5QPhGDYoB/63G28q/WIK1wuVhy9qv080me9cp
	N3cwLRdYOIRUiEhO55Cl0kx153KHnrJ3sc77qEuM0BANQH3cUzH2ufMhvWTAkH+64VSmV4Ho2mZ
	pdRaxI/HyRVz8ry0Psg==
X-Google-Smtp-Source: AGHT+IHasiSdFSDiL3nZZnCBBXlUCkCAhiBsVFKWNNYUfjmf0mMcL5f4FR0DfvTWA+Qb8b5YphLKhw==
X-Received: by 2002:a05:690c:8683:20b0:70e:2d17:84b5 with SMTP id 00721157ae682-7587e5f3740mr5484617b3.0.1758589998667;
        Mon, 22 Sep 2025 18:13:18 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739718cc2dcsm38377627b3.67.2025.09.22.18.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 18:13:18 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/2] btrfs: find_free_extent cleanups
Date: Mon, 22 Sep 2025 18:13:13 -0700
Message-ID: <cover.1758587352.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series improves the btrfs extent allocator with both cleanup
and enhanced debugging capabilities.

The first patch removes redundant RAID loop logic that became obsolete
after previous changes ensured allocations only occur from block groups
with matching flags.

The second patch adds comprehensive tracing to find_free_extent() to
improve debugging and performance analysis capabilities.

Testing:
- Ran xfstests btrfs/auto
- Verified trace events output correctly

Leo Martins (2):
  btrfs: remove ffe RAID loop
  btrfs: add tracing for find_free_extent skip conditions

 fs/btrfs/extent-tree.c       | 76 +++++++++++++++++-------------------
 fs/btrfs/extent-tree.h       | 18 +++++++++
 include/trace/events/btrfs.h | 65 ++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+), 41 deletions(-)

-- 
2.47.3


