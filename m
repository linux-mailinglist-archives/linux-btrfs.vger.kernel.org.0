Return-Path: <linux-btrfs+bounces-8499-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5BE98F2F2
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 17:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239C6281B3A
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 15:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA2E1AAE20;
	Thu,  3 Oct 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="YnpDI7rm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A83F1A76C0
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970201; cv=none; b=Rw+Uf4KJjcJNtffiidHdbScUtRJg3Urk3PBDg3cKtxXCVMA3kTkptMb9W8MXhtESyH8qmAqJFUw+fkBDbM21YzXww4/C945WoSClcb7g6COU5eEUh7DVZ23nFm5xLkFBQW5uvzpIyTOV2LlR6ldX8pOdPQ6c1v6DbecYnGyekTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970201; c=relaxed/simple;
	bh=c2ttZgb0lIme/b0MEd/1IX8sw/TYxf2QuM5kz16AifI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NfvcbhTb5J+5trUeyvL641nm12+7ZSBYlg/zecLNtfnOZoTkaktKDP6gvsurqBSYs5/0kMJfuF6Tna1kN4awE841OeFtnAIb4ThVExOHH/hGTzA++pEULX2KSknYNIRmrZ5bFL3zu2/CqjY5FRXCfFec8eORX5VD4GiLooLjL9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=YnpDI7rm; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a9ae8fc076so114151385a.2
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 08:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727970197; x=1728574997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8vkMmE/TDp04RZX3Uzm+8DImhGQkJbN5B55C8YK50aI=;
        b=YnpDI7rmW26b+s3pnqPrHWX6EMYBZmxr3cqnpimteWU8vFnWND7s9PM8e2NeqEBCf6
         oO0FJ6KaP6FPS6SJ2pgjUBJVLlGaHRhKJOhtcKoMAzCGLE8gwkyrGQR7CkWcWqDryXpj
         9FBAP9Qu5L0Fzfp+Pa1o249Wi+WHCayTg49u+qm2LXKb4CUuSd2J9CALCJADU5WG4AcV
         /HQKHLZEtduSLYHwyDDUNi243O5995ebEtz1j8EpQKkhgX6C8aLDrTBj3ABi9tqkp4CP
         BEFw5skIdS0KCGfMjny21j49PoPBy/kSu48Q6qDqPQgCWq2al/ndf/+mMxGEgFDyupua
         jTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970197; x=1728574997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vkMmE/TDp04RZX3Uzm+8DImhGQkJbN5B55C8YK50aI=;
        b=n99LYNhxAvdbL3Y60Bb7O5jVUEURlVIqjtkGV1DuxUNDd4qThI/iwAwF2CVVT3sUPn
         QjlkEjR4OQqJGO9MuQxdUZVGIZkR75t0MF+dIvH5KOBnz70rIIF+iXCqkV6ER8Q7sWK4
         JF8TGzpfG/K2sGes96cyp2+WXIBb9kQIeOp0YNOP+SrZkpurqVxEspXH6JqeyUD9CJEZ
         DGD3Cc2ZFLKcvfQ9EOMyQPmT5tZIfEkchuegpPgUUKY6Db8aEjW/0WHj7OmzwlVEmPBU
         qjWTTYhRDhdoEpZlGTnwHQDmyQT8ax82dgT8o31YEd20xn5lfV/seyEbDfvq7Q+eh1iQ
         9F3A==
X-Gm-Message-State: AOJu0Yx5UhLj3NF03L9nN1Wr8CyLVzW4+61MUd0K3IF7m6dS5gY9kBzk
	n1D/mm/icrXYtXIAXvJ0s0c78Ff7TcoXKxxl+bhI+41gEIU5Sb0QOHJNCmen4rOnHAfNa+5VUyy
	W
X-Google-Smtp-Source: AGHT+IF1zUI2dLQ+xdTdf4t526hS2YRFjibZvR/pZFzuzcZhYLx+Rr+CNtSB5iCj8E/zR7F7znRn4A==
X-Received: by 2002:a05:6214:488d:b0:6cb:600f:568b with SMTP id 6a1803df08f44-6cb819caf53mr93125426d6.8.1727970197551;
        Thu, 03 Oct 2024 08:43:17 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb9359ba51sm7599086d6.1.2024.10.03.08.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:43:16 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 00/10] btrfs: backref cache cleanups
Date: Thu,  3 Oct 2024 11:43:02 -0400
Message-ID: <cover.1727970062.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is the followup to the relocation fix that I sent out earlier.  This series
cleans up a lot of the complicated things that exist in backref cache because we
were keeping track of changes to the file system during relocation.  Now that we
do not do this we can simplify a lot of the code and make it easier to
understand.  I've tested this with the horror show of a relocation test I was
using to trigger the original problem.  I'm running fstests now via the CI, but
this seems solid.  Hopefully this makes the relocation code a bit easier to
understand.  Thanks,

Josef

Josef Bacik (10):
  btrfs: convert BUG_ON in btrfs_reloc_cow_block to proper error
    handling
  btrfs: remove the changed list for backref cache
  btrfs: add a comment for new_bytenr in bacref_cache_node
  btrfs: cleanup select_reloc_root
  btrfs: remove clone_backref_node
  btrfs: don't build backref tree for cowonly blocks
  btrfs: do not handle non-shareable roots in backref cache
  btrfs: simplify btrfs_backref_release_cache
  btrfs: remove the ->lowest and ->leaves members from backref cache
  btrfs: remove detached list from btrfs_backref_cache

 fs/btrfs/backref.c    | 105 +++++-------
 fs/btrfs/backref.h    |  16 +-
 fs/btrfs/relocation.c | 362 +++++++++++++++++-------------------------
 3 files changed, 192 insertions(+), 291 deletions(-)

-- 
2.43.0


