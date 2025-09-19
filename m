Return-Path: <linux-btrfs+bounces-16993-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D36B8A257
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 17:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78541C80D37
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280EB31690F;
	Fri, 19 Sep 2025 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="0r9HiCyY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9AB3168E9;
	Fri, 19 Sep 2025 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293983; cv=none; b=h+sqqr0ayEDAKgz0cgZIvYXy3hXELLSvCnJRb30lLicThh4MOadtP4gXxWpOf4TAT9GyJa1oxjBdBCDjxQ/WBgHj2plsuzeDauqpbx0jo5DCx8B6zZ1MQQvl57xBEoOHu+Y7VeIb+D+5a7TB6mtchqO1/2C9oSwwZjKQ4VomIXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293983; c=relaxed/simple;
	bh=6OA1E7tvDw0cZPnwkESiR2GIN+VMn0Q9ITXgUoE2FqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ULJVBv6BpoOinaktaebIg75Kf6+iYvzLdm73Qn9Z+YQzWW7oJqGDdTBvewZlLrvt99FJUrM+pbpOvZ+m1wbhSXBEg+VkwupXCVcYUHcG7RadapR2yUm+c6bTHusSLohM2QEZUbXetxLD9NLGJPzONR28FB+XOht8kt7hTKdt6n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=0r9HiCyY; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4cSwdY1cVWzB0xQ;
	Fri, 19 Sep 2025 16:59:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1758293969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZeWE+8h83Y2X9V3rA2k3/8opmAJ7tyfSeYEmz5dwrRk=;
	b=0r9HiCyYdPWi/c3VtCJGQ5/26rvO4+UPJP6A6ObjddhFlcOQj72unOkYGZLgReSBm/IPy0
	smKChA0wV1HLJ26HBuNyWuRtoZ1AWxgTXvhOl2JeAjvbFT4Fe9CBkx2M4kNPo0UJyiFwIK
	c00O3ad0yPMJO9c+zim+Ix2eflxncAn8ZtnBeEOJZfVgXPZEAO1Ba+zEq1w5ORzrpfQCvQ
	NbTXVS+j8/xVsPIkNP7q/9cE+XvRdqudapl4JxH5pETG52gp7YOh61sH7MsCby5ttepeBM
	xdmv41Yaegjcj3KnSg9RPdIaH7XZEQLotkG3J4j/TRRV5HVf9gWFKDDlCFZO4Q==
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH 0/2] btrfs: Prevent open-coded arithmetic on kmalloc
Date: Fri, 19 Sep 2025 16:58:14 +0200
Message-ID: <20250919145816.959845-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

There were a couple of instances in btrfs code in which kmalloc was being
used with open-coded arithmetic. This can lead into unfortunate overflow
situations as describbed here [1]. The solution is to use kmalloc_array in
these cases, which is what it's being done in my first patch.

The second patch is a small cleanup after fixing up my first patch, in
which I realized that the __free(kfree) attribute would come in handy in a
couple of particularly large functions with multiple exit points. This
second patch is probably more of a cosmetic thing, and it's not an
exhaustive exercise by any means. All of this to say that even if I feel
like it should be included, I don't mind if it has to be dropped.

Cheers,
Miquel

[1] Documentation/process/deprecated.rst

Miquel Sabaté Solà (2):
  btrfs: Prevent open-coded arithmetic in kmalloc
  btrfs: Prefer using the __free cleanup attribute

 fs/btrfs/delayed-inode.c | 18 ++++++++----------
 fs/btrfs/tree-log.c      | 30 +++++++++++-------------------
 2 files changed, 19 insertions(+), 29 deletions(-)

--
2.51.0

