Return-Path: <linux-btrfs+bounces-14265-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E9BAC5DF5
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 02:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A274A4754
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 00:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C815B8F77;
	Wed, 28 May 2025 00:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwLWYoBG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08AD1FAA
	for <linux-btrfs@vger.kernel.org>; Wed, 28 May 2025 00:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748390670; cv=none; b=haEJhZJJamG5SZx/MdKxeg/4M26V0UgIZPMUUEfrz1rgZQBvO29/RfyI2US2x0MaD1TDQmvgU0Uy9tVLz5ZgwrGL78P+42NMjdMyX/2ERtvFM2ThS60ks2pMjCMdtOiIS+lMkIEWHn/TTS4sCnSkicAzlKki5CbjcYLYL/3Emfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748390670; c=relaxed/simple;
	bh=G91thx3zGM72ZGpZui/phD13Y5henKzqt5A/HnXxPyY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eJVa3y0jLHDfO9zwHD1+e0S7o6Lqxr9pxI1Nyg3BPGTrWGHwF1Q13uRvTvOavBjfJlQ8fbhlx2YbNlClucG2KaxbtnTmHIo5a5V9O7vqAH/Mf3AJ40eMSIF5QcnyKtg4lSvWNs+U7VIbjR/fuRGmW2bAkjFP+/FX9pah0mu6bGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwLWYoBG; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-603f54a6cb5so1536860eaf.0
        for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 17:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748390667; x=1748995467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uc8dn1cPAkUaje8IQG49j5snS6r43HwfmlEI2xWgeOQ=;
        b=NwLWYoBGKynDYvRSzGGuo9js1aHBDs/suE3t47rEmDd3xcuv9ylTr6xXkTm2GGsU7G
         rKslIlY0p+ZpmLQHmSPdEJUh+2YxswvtGFLgzKLkFIdROkrZ/iIK2rTkRKNb9yRuDyYv
         qNldpdVbNJw5GoJSAHkLVKk4G+3y/e7D2668fC+KMxC+u5r3YgZM79iW1cz3W+6V38GC
         FXKQhr0IEHTXuMZRxWWXmyEPkvvpKWP975iBDuiV56O8m6GPwNh9gMVTWVtdeCJ0YU0L
         ak0HSrxKM0z6+zp9PvUJ8iSCO9l4LTrSXlv8Wvbiy4RaXpOljVtSuUi6ddpL/Hu45XQx
         t1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748390667; x=1748995467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uc8dn1cPAkUaje8IQG49j5snS6r43HwfmlEI2xWgeOQ=;
        b=w7TtcI+pZ+7Hp4fAlhWat7a4gdvwR/q4psyrfUCt3DrVbEBR15ruNB0XfaB617kk31
         ezrCGFKCG6EGEOwSJLPnRg+KcgS96pJINAIk7NiW1TguYYEoe5SfKr1wcyM7t6FFVnKX
         /3tmOHZSGc8GDQ4iy/GCfNE/Sp/LX17ItLmDzN33+a/PPCbaudqkezEs9Ft6cJrtvUky
         4PY4cOSx3QW2fQy4Gh46G9EW2cNJDx1zVJWLlBq4vvI8XEpvaE6CejTaHLeyD9z25ijm
         y94+aWFPjf22xbjy5u1JMCeL6P8tI4f8E44Iq+6qW/MlE/RZFpz6Low0R4r6MZSWt+1A
         nOzw==
X-Gm-Message-State: AOJu0YxSPh1CoWJDl8eKaciE9L1aXyKcsJBX/E5AohGVVtMrtJOS94iD
	FJTRYPshzjXYIpZy6kp5UUHe17/67okLqEenwR0JJmD9bRDuM+7RFfUKe+aZ57RU
X-Gm-Gg: ASbGnctMUEtGTOCCbkVgI453Qn4I+ZtCan8i7YgqTPs3dnF6OtW/wYRCaSGjq0naiN7
	xiRC8VFCMQtEzMR32i7n8beZ5Fkzm7MWOCQLMr+IGf9fJ3WCzw8EUKyNF+nqHH8iDHgPgIoRxlj
	9wc9uMgZtitCed7ww7jOJLilEtas+hIJovzlEgrmQvwHPUajdGtrmdtEmlqi+WUtO1bPTrTQmP4
	wjtXLo0jvfFWGb6VTDZDiK13VdGY7/0ff988Y4pD1mahAm7xHfIjqP2mBIzH1Pxo0Hg5kQ9nSAa
	LR+gpax9FrnGZKo8K+FCCA85DybiVi1sCEpmO0xIZughWQ==
X-Google-Smtp-Source: AGHT+IFxyVydEdCpcMrfOtSV86rVZIo2cm+yf9tJf4iSQO6AJ2GvAYajwQX0ngeyEInNNN5Amnwcuw==
X-Received: by 2002:a05:6820:179b:b0:60b:9d5b:e94c with SMTP id 006d021491bc7-60bd9b5ddc0mr154582eaf.6.1748390667289;
        Tue, 27 May 2025 17:04:27 -0700 (PDT)
Received: from localhost ([2a03:2880:11ff:7::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60bd9d1135fsm17076eaf.26.2025.05.27.17.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 17:04:26 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 0/2] delayed_node leak bug
Date: Tue, 27 May 2025 17:04:20 -0700
Message-ID: <cover.1748390110.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently investigating a bug I believe is caused by leaked
delayed_nodes. The following patches fix a potential delayed_node leak
in an assert function (I don't believe this is the cause of the bug) and
add a warning if a root still contains delayed_nodes when it is freed.

A little more on the bug I'm investigating in case anyone has seen
something similar...

Started seeing soft lockups in btrfs_kill_all_delayed_nodes due to an
infinte loop. Further investigation showed that there was a
delayed_node that was not being erased from the root->delayed_nodes xarray.
The delayed_node had a reference count of one meaning that it is failing
to be released somewhere.

V2 CHANGES:
- combine warn and if statement

Leo Martins (2):
  btrfs: fix refcount leak in debug assertion
  btrfs: warn if leaking delayed_nodes

 fs/btrfs/delayed-inode.c | 5 ++++-
 fs/btrfs/disk-io.c       | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.47.1


