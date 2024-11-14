Return-Path: <linux-btrfs+bounces-9667-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C2F9C92B6
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 20:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29079283CCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 19:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77E71AB503;
	Thu, 14 Nov 2024 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="EubRp9F/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F3198A0E
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614276; cv=none; b=Nl3hcq/B+0u3kZAXCujIQYyX1zl9OPYM1aJeQ/cJ6bOvO/MhOs3gQ+u09CfAUDa/kg1iEDB/pm9f+w1+6BVCEYo8lkDX4Z0N8DrRKIIszzB6fBmfp2E3CJjK/2WB+TxvxAS7fndQ3Q1q2y8ziPTShDm834dz/XTHBkl+p0vnbg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614276; c=relaxed/simple;
	bh=1ICUBDBgwH5BvD7dgjQOoTGseq2MbfNqk0z/h5Bq3cA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EGLh6AhL7F1EhQv7zyaKjm1RbkR/e0Esr27/NWDRxqGegkMbOMQH6q4p5D3ySGK//MQG0nPlu8Da8DImGAMzSMsWW2EKg7eu8d/crFdPz2pMvE0comhPg44Q0BEv/ssIyIRq+pBsgVJerzv1rIcLFkIvd6jKCKz4cVXgZH0LADU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=EubRp9F/; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e3cdbc25a0so12064727b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 11:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731614273; x=1732219073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GL34zqImUfyx1xvZ2J4V+3kx5MF/oSRzJy1TCw8hRuw=;
        b=EubRp9F/IsLIfzozokzxmw+SKM7xgQo/SfA8/v+yHrG+Tj6cHWx5Tib92Vo48HEGUv
         Zvb/01UhSCnbWvwZI7JTu39EPOupSunvh3kyf+9gwYqbgKBoGlkjWkA/udw7A/UWB5k4
         gGVbpZKmsWooxBNaMbmHMVlUj0017C0/uIZLxilS9Gbivp26V2sCq3uPBB44HozDSZEE
         48kZuwltTE9UGgxh+7qlCPrDGS+YLn07EvlL7MEzg5gj9KVuXHaIeVlSSzBx9ioyFeeL
         GDCoe5JgPhtNflahyzjLPr29J5uckl7M78DZOezMujRGM6T5V1jeQh28Tbt+cMfxlelh
         WqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731614273; x=1732219073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GL34zqImUfyx1xvZ2J4V+3kx5MF/oSRzJy1TCw8hRuw=;
        b=hPEOmDcOYck+rwTrzZJliwBeZGeLRDlX+kthBIjA+nr43P+72LGbtCPkBCBtI1C5K0
         27W3xJmRgEpBWqn/PSRXjmT/zLWSmVtOP90Znv5sNxjGJPlWHs0we2Br/WjlKLGqhwVt
         Ps7cb/PqVoKH3svf/LVm+HY+xC3qRCPcwvgiC68YZpEsSeSrlhW09sJz5+Yu5vngQmK3
         QB5e6tHMUkvbnn8sYsMtYxlEHeLZdPhx9I4I7VHbcOUbOU7ZOa0thSIhMrTeXb09gRPS
         us+exd2rb35HM9fAXjDAgd5+hg8hE8pJ2jUjW5eAPeVb6gqrNGjGZoGCqbpwzfp6+pCn
         W5DQ==
X-Gm-Message-State: AOJu0YwlWL78EwAiGjX4PlrqFC7pflVpnUZHM0JWEhx+FlVm3/eIvySL
	O4sxoMlwvwTRyt8xvcrBA0o9+K1Wr/prKKUHQyb1njkiZhcLOA4ppSHsznyGgl2Vpp1DlMKXBGd
	0
X-Google-Smtp-Source: AGHT+IEm7qWUck4UhtNMZSFe4E8IMp70ym0YHmhMXFIm3KvAaVtGkDrZs7PChhqE6mp++nj/QXUBEg==
X-Received: by 2002:a05:690c:6e8b:b0:6e7:e3b1:8cc7 with SMTP id 00721157ae682-6ee55c26388mr2168077b3.22.1731614273475;
        Thu, 14 Nov 2024 11:57:53 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee43f25132sm4134347b3.0.2024.11.14.11.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:57:52 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/2] btrfs: add a delayed ref self test
Date: Thu, 14 Nov 2024 14:57:47 -0500
Message-ID: <cover.1731614132.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I made a silly mistake when refactoring the delayed ref code to make it easier
to understand, and that resulted in a whole lot of not fun trying to find what
went wrong with boxes started falling over when we were deploying 6.11.  This
style of bug is easy to catch with basic unit testing, so add a variety of unit
tests for delayed refs to make sure I don't break things again.  One patch moves
an important helper and exports it so that we can do the testing, the other
patch is a giant patch of all the tests with a few changes that are necessary to
make everything work.  I validated these work properly and catch a variety of
bugs that I hand introduced to the delayed ref code.  Thanks,

Josef Bacik (2):
  btrfs: move select_delayed_ref and export it
  btrfs: add delayed ref self tests

 fs/btrfs/Makefile                   |    2 +-
 fs/btrfs/delayed-ref.c              |   41 +-
 fs/btrfs/delayed-ref.h              |    2 +
 fs/btrfs/extent-tree.c              |   26 +-
 fs/btrfs/tests/btrfs-tests.c        |   18 +
 fs/btrfs/tests/btrfs-tests.h        |    6 +
 fs/btrfs/tests/delayed-refs-tests.c | 1012 +++++++++++++++++++++++++++
 7 files changed, 1078 insertions(+), 29 deletions(-)
 create mode 100644 fs/btrfs/tests/delayed-refs-tests.c

-- 
2.43.0


