Return-Path: <linux-btrfs+bounces-19246-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAC6C7A6DD
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 16:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4A20386AEB
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 15:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0F42BE7AC;
	Fri, 21 Nov 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="sw7m+pud"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DAD310774
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763737175; cv=none; b=LdTJIit+AifUzvaX+OCnYtyKLU23nr4EiOILnmHzgKO6SbGu+qvodxgSMfQex+J41CyGff0BsGdfisDDoTUx4eJfQs/9bAOdrZic6f2/9Y0kkYtHk16Q0qR1DoN0WFvcfMUdHd1FMR1RkYscQwyQpIo9gNuTFIbP9Kvtow6P9AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763737175; c=relaxed/simple;
	bh=3OXNV7NfxfKqVWvBNN8tcmjy+WffcbJQUmeayYNkUEU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EfLaBxiGovnYG7vFRYKB7mG8SRGpTJf1xItqto9siF5ZaqJXL9CpgA0KwK3fHSg12w0/QnTb5zggGpMY193JHCD2JzQrVx8xNtg1pOgapHGd20x3XB/KFFS8XFtOWcLgw2IkPbSE6FVK9/iY1vSwyCjPMkHAO6dYmJtvP9Iiiu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=sw7m+pud; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8b2ed01ba15so181603385a.1
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 06:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1763737171; x=1764341971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EasbVm/hkSBp0ZKvotE83HbTcRl7jSYtnls2x8BJqaE=;
        b=sw7m+pudXGnlunVhQz6hS30+RKZjkFTdCmnfXHMQV8uToEsV3KhLBWBPINjNziRAqP
         dVMhTp8x3Qz3LNIyH2/7fYA1cP0yx9eekuBYaCBQRTrdItHhxlSdnlUZZB+gw42B/4aV
         +y1iHJCCaFDFSvgeh1mWHDCseSuiIHiHjQzWRHsnkC1/cmkI2+rYwj/Z23zC23R1yaYx
         37IQT4Lq0hvhb0ZlBwd2HXwGotAfTA3mjW47BwfzKG7KByUHmFISrXdo74Xowi1tMVy4
         Af1iz3JqdLfR29b4marauV3RjmS1E9/PsAz8+lWPBI7y5qsEmujJtNZLbMxlrL7GizEs
         89TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763737171; x=1764341971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EasbVm/hkSBp0ZKvotE83HbTcRl7jSYtnls2x8BJqaE=;
        b=WlB2n+kU7i1XhqODLboYYPYx1ofECcs3Uw5h1ZudcYS7eN7XLiy1qY9f1DDRGufbtM
         h0IdrD/41s2u+C2U/gp6T64pp9b1Y1IPZDLl1fDozUwdKG5rNCgG0ydij7FE7aGW5Js5
         T6PX7lOZflU/DtytxsIhELOBuMHhtDeCN/13au//iflZ1++j8VoR4e1hBsEa71xR91E3
         i6AOwZojk2Zs3c65X4ERSsigDcMJB94Lhb3Jsy/1PBh0wGWvC7LjfE6WtV/7DEmVUdKr
         iYupGdt89V9/n6VRATs+l9fLSrFbE7cda/u09xjV89UjjEuacuM2KUfP9KkMXBXyO1A0
         QJOQ==
X-Gm-Message-State: AOJu0Ywu0oqmboFHWColRdYhVQFR9txRpiJXPuW4utLiNdr0tJ26jiRM
	bqQu2ZrVj6HXpHh8Xv8vdjuu8vX1e+kBvy+vayKTsBURBCJ4Fkxc76gGiXd5LV7603NOtb+Vkod
	/MUKv0SVeT+Y5
X-Gm-Gg: ASbGnctiTcr4+CUB3UQkzViyLGoF3+KaOwVy3RWQOWkG4Yz0G/IoTkMQndoN6YUut3h
	GB6ZU8/W6Co6RUsTG/+lJKljEuyWQcaYf5IpChTXsduhkyBVoCYqR0pP778yJhP3vUY34ZX1OlD
	3r0t7hRYUoiR3QFdRDnZhAauH84F/9+LqrVg/BOAqvpdGUFcJHLO7xo+pvgGA0ENEA1Od0SSLzT
	MSAs4V87HZtcgaJO05tdjCNg+nsXKnZbmFFFFHIFo81wParNeVWLSfCVlzBSj/2/2uxWiT7Js4g
	sBtQzBaVXU0atn5SOGIp6fFE3RznRUAh1LrVFUsaakfC6rKQqb2y/rPZUDUu1Br1RFRzj8YgeEY
	U2MFzBSsSk2QszSlakw0KwWaMyCXFzPkunlBwn1SBV76OeuBMN2GUjNFinjUTP13qTOozU7wACR
	U2mEb8aNUfKXr09yHYeQ6COkE=
X-Google-Smtp-Source: AGHT+IEHIxzHYdHrhI6H2sfGd8A+TzbHD2739MpDekTkBk/liaPakynzRFB0xnlDnyEyjxilyhfAXg==
X-Received: by 2002:a05:620a:1aa2:b0:892:9838:b16a with SMTP id af79cd13be357-8b33d481692mr266367885a.59.1763737170701;
        Fri, 21 Nov 2025 06:59:30 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:f528:9f2f:44c:2c84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295c13c1sm384174285a.28.2025.11.21.06.59.29
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:59:30 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] Fix data race with transaction->state
Date: Fri, 21 Nov 2025 09:59:20 -0500
Message-ID: <cover.1763736921.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-btrfs/cover.1763481355.git.josef@toxicpanda.com/

v1->v2:
- I'm rusty and forgot READ_ONCE/WRITE_ONCE doesn't mean smp consistency, fixed
  the race with a proper locked check.
- Updated the smp_mb usage in start_transaction to use the proper helper.

I want to note that this isn't actually an observed hang, there was a problem
with MMIO based block IO in my version of QEMU that was making IO just stop. I
happened to notice this because the hung tasks looked very much like a deadlock.
This fixes a real data race, and we would for sure miss wakeups without these
fixes, but I don't actually have a reproducer for any sort of deadlock in this
area.

=== Original email ===

I've been setting up Claude to setup fstests and run vms automatically and I
kept hitting hangs. This turned out to be a bug with qemu's microvm, but at some
point I was convinced there was a deadlock with running out of block tags and
ordered extent completion and transaction commit. This actually wasn't the case,
however this data race is in fact real. We can easily miss wakeups if we have to
wait on transaction state to change because we do it outside of a lock and we do
not have proper barriers around transaction->state. I suspect this explains the
random hangs that I would see in production while at Meta that would clear up
eventually (we do call wakeup on the transaction wait thing a lot). In any case
this is a data race, even if it wasn't my particular bug, we should fix it.
I've run it through fstests a few times, but obviously spot check it since I'm a
little rusty with this stuff at the moment. Thanks,

Josef

Josef Bacik (2):
  btrfs: fix data race on transaction->state
  btrfs: remove useless smp_mb in start_transaction

 fs/btrfs/transaction.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

-- 
2.51.1


