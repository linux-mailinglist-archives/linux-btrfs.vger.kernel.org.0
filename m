Return-Path: <linux-btrfs+bounces-20048-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0045FCEBD7F
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 12:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E90673013540
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 11:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C492798F8;
	Wed, 31 Dec 2025 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWcZ8hgn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5701DE3A4
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767179801; cv=none; b=tSxyjPv4mcrGuW0VAXAI9dhCMOydDfgqfTDRgk/pI2k4MVthSnL6fvVa3KG9k84Y5xyrd04mSIY53Nrb/kQ1GfICqtw7VkklyMvKvFcimpq9xTSw0lLLv28cJv4qPjdjMJJ3CWm2hpSeco03dcp41wVnabTntSlZfyei5jgx/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767179801; c=relaxed/simple;
	bh=w1e5qUa1U9NxYOifm/T7RyhoLzQDYJ2PNzs+lNhlaaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XnArq3Ff11cq8Jbj054y8yJNFsJfVcX53FxnwYEtn+DAD7zH/OjTquwfDscg0uJyYhTVaNMrgi3MHlJfaNtnT15JaSA5VF3s0m6XOghKYEMl+J67FICCEZ+wExRW958LDJBb76ax6Onl3o+6iI319TqrukH7oByEaRdbGqvYtik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWcZ8hgn; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-29f2d829667so19523515ad.0
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 03:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767179799; x=1767784599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uEicixaNtYWUD3LbHX9EKMwWRHTGsWGJytx0PZ5T+5c=;
        b=KWcZ8hgnpnl6CmY5QXU2jGz0NA2ydUR9+bXcPLFQ+NCd+BN/ZH/7LzdgpWtFEH+Fux
         tBXYtRITIUxRFc3B0+0o9AGroptXlLxp5coUx5ZkJBrJ12m9v5nwzVSIE63O34jTZRUh
         kpmUkXr0rT1N0aZ/eKZ03AgYV4fNidcBKF5Q+hSFJ7aXwNoexWHfrwh1GBHnAexXlSCD
         NS/WnTYbmp0GEFBAztmtKjw4FFVeAlUQYjrautgtETWVG5bRASTupDdRp2+woNR7yLLX
         zSEVkG2gyAUF3W2QPmAxIryVylhJzmQYt0f8OOWKzsJQCQY1YWOqlGqzGT/mvaYQXsc/
         DiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767179799; x=1767784599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEicixaNtYWUD3LbHX9EKMwWRHTGsWGJytx0PZ5T+5c=;
        b=OoN9Ywm5r+OFNs2wdoRB3fzweVAIPBncr8E9+zixsDKIRygt0BRevOv0puxoa8kEa9
         WxLL8lUC3CpeUxIm42lslByOU1Z0Uhok5lUon7PIwhL2FQ2+1gwSsJObmuo5TlRAm3+A
         rMHSlDlBbxoOpgvKqoovHP5phFXl35u6ZxhCNCGVMjAYafiEwZlVcSIFw6fmVgBZCm9w
         SksONCpoET36S74V16feQqYfvUkIPS/Gc8AP2+vUK2ihIhruIjhGLDDe4gjT9XR/1QGC
         SplPybQMcrg0VKyN8tUrdGdX4oOupVgUlCZUrlHF4IWGUFXSVtGXDy4P5EahMGwd300+
         E4zQ==
X-Gm-Message-State: AOJu0YyBUnGDUhZj6WoHiO9QiV8urg9xTIqbovhpq6WBaYYhSPywUkHF
	E4TCpB3kX14D6d3cMFjcyMvHrqB4iSj4htxGrtEkhtG9XvCaWalgXMdyQ4ATSs2v+0Gd/knH
X-Gm-Gg: AY/fxX7spY1JDISNNY+0hfQ1b6pdtK7K7V6MtMH7GFGLb54Msrcq0sNPqKxCFzN3+DG
	bzV2blxALBGi3kOHYWeRs2UkPoKsD/dv2Cwn3kkJJIw0jPy3lzYLShzI8odwJ/46PXT6YGwt1EM
	INsVjBQqH+JnZoG1PoPrSdM/okm9gUjZZjIbLz16npK47Wl4OyTeQHNpEeHhHQ84dVYGE07vGOv
	83U/53GahgUQAuT3+dj0UILfJsAfjxXQwBA9hCCNx+/uPs5amGlrc59108gi8z013sz7FB0G0I4
	hy6nrlpp9G+Bknpa4+OPYGHVyyUP29Y/WyV0NcbrhZTQRIQyWu64CG/8sysHRF4th2XER2YtfpC
	+PV0uCqwLhCPFD8S4DQv9C5sG8inCtB4m2L59D95e61FoILQZ12f/5SNst8MfNXMg1C0HpY+qYE
	BFf8g1jl1NUZcuQwSdatZVEtA=
X-Google-Smtp-Source: AGHT+IHy08kwDBmpYW2rp2z3ap8iMP3ufvAj8Q9H+HSzi0hoGfui1e8f6HeqVKb4p0zhiE3Sxm0ykg==
X-Received: by 2002:a17:902:e810:b0:2a0:f0c7:9998 with SMTP id d9443c01a7336-2a2f2a3bc06mr259896445ad.6.1767179798970;
        Wed, 31 Dec 2025 03:16:38 -0800 (PST)
Received: from SaltyKitkat ([175.145.176.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c74490sm321394385ad.5.2025.12.31.03.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 03:16:38 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH 0/7] btrfs: fix periodic reclaim condition with some cleanup
Date: Wed, 31 Dec 2025 18:39:33 +0800
Message-ID: <20251231111623.30136-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series eliminates wasteful periodic reclaim operations that were occurring
when already failed to reclaim any new space, and includes several preparatory
cleanups.

Patch 1-6 are non-functional changes.

Patch 7 fixes the core issue, details are in the commit message.

Thanks.

CC: Boris Burkov <boris@bur.io>

Sun YangKai (7):
  btrfs: change block group reclaim_mark to bool
  btrfs: reorder btrfs_block_group members to reduce struct size
  btrfs: use proper types for btrfs_block_group fields
  btrfs: consolidate reclaim readiness checks in btrfs_should_reclaim()
  btrfs: use u8 for reclaim threshold type
  btrfs: clarify reclaim sweep control flow
  btrfs: fix periodic reclaim condition

 fs/btrfs/block-group.c | 29 ++++++++++-----------
 fs/btrfs/block-group.h | 22 ++++++++++------
 fs/btrfs/space-info.c  | 58 ++++++++++++++++++++----------------------
 fs/btrfs/space-info.h  | 38 +++++++++++++++++----------
 fs/btrfs/sysfs.c       |  3 ++-
 5 files changed, 81 insertions(+), 69 deletions(-)

-- 
2.51.2


