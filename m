Return-Path: <linux-btrfs+bounces-14256-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B092DAC5AAC
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 21:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4918F3A9471
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 19:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAE72882DC;
	Tue, 27 May 2025 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6P50A9y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4870F1E1C1A
	for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374129; cv=none; b=N/wCnf6b0Beftw/CEQ3WfVZUAlg9INhMt0mCfLYmhCrBl4COwYQNXuSiCuh+bIttkAdt8Ka8IUnShb4PGfcsIPPFVbPwZ9UBD9FymLArQexANSE2iFqnCfxA3fwdp8MVTod34W7KbhP1oUVIDPKFs3MccMC1AFLahLiClmPHau8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374129; c=relaxed/simple;
	bh=oSqFc4gAInFNL5tVodLOcyEh1qxhEUPH8ljRZ3szuTo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qq/oLG0MKB+nli/CTPtjrv0jS+nPVxZnn6qECrvuGf5UylzfRa7EkDniR4MCUzmkMJwIMIQy2Gj4C1dLk6oSrZHtocb4XzFRmJTVU9plSUOj9+ie0OaShZqOpPxjdqEMgKnYpFnh68q0e5ak8HFypu7dwCXyecd2VXlSkEqYHR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6P50A9y; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-400fa6eafa9so2199395b6e.1
        for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 12:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748374127; x=1748978927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BRd3UzX9m7YwvdMxGIE1G5F1dotPkfwW74b6a4iL2gE=;
        b=F6P50A9y6XohvhicJqFazpSCWFPL2I40VQ1sgN5j5CF7958AQlgEzvSNRLS7VKcuC3
         HgSEIqhFJdzbjou1a7ar2U9ojM4PoD+eTpz9erSpkSZ6jmDSD5crLCINnhIsKM9r8MBo
         ziAok5lpX9JefC1IGyiua+/ibD5kM5D6hxJVaWV5u9mDP0sAqbPc6U3PY/YX7NG6qcZV
         EcqylnS5aKMDE4OPUNKySr8d1RHpH9RqJ0ehY1lqTUjBm1YCJ9T8XgCgQvywMk4DPOui
         kQa1vBwPR8qaY5iwVtnCstA3Ot+n8r3YlwHiy6wpOxhBlt3QF6ktCcH6/H5MypDPwAmn
         W43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748374127; x=1748978927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRd3UzX9m7YwvdMxGIE1G5F1dotPkfwW74b6a4iL2gE=;
        b=WQa33jSBHZNJ24PtFii982jjnRiUJ4rfbvbD2DcAYJh5veU4qOfS5SkUNwxWzwd5+8
         AMjKIYpmdjRH+0NQ0Bh/PuriLExgDd8wCLjacKy90cEveMLJD63EamFWXhJKDb/Fyhpo
         FUyOXzijpAvlwFRdy+jfhagttwwBun9Q02DSNsBaWs3/IsLBT0zxx0gTQBLE4FIyETFR
         8OcIBvAebdYn89l/1/FQHX4fLAOBNpLad/qDyG5KA7E99I7d2lC1l9vQg/RDGyE5+ymz
         KkFtQ3CjC84whKN0dtm8jVNKq/oPdxYa8y68JWVIvQ/InsQMFVz7kbUxa7fOmc2ocx4D
         XlFw==
X-Gm-Message-State: AOJu0YxLmPhS/CpxuHLr2H7fnCahiSmLlIBdwp32xiX8FwwXGl1Baboy
	rT7PvzPGdd60A143S/KSwRGMg5D2YJ8YX431QXRBLrzgRVr+EYW7Sc+pMBZxA3/Y
X-Gm-Gg: ASbGncsLOJO4l/Auzz3ic7R2P95nwSwmK+J4qC83nOw/dCeqqzFbWsYmm8qcFXVvvhM
	OYjHCeBZLJVqj+OuLxwHXA2vZE1Q3GYHWp5atYkqruEbfL0SShLi/Ti3DLc0zbe8aUyVFgsd70J
	ykk3hAgaZQSPc8olE9jlb2poRb4s+AaYt2aEsz4PJ0jvc3AR9Gc351TXCa4THm6V4frFz/oPTea
	8b20VFfg0DV3JyJT/o0QXOxPumNj18EXgt0OtAGpn9ltZRKAh4h5IAou9ASjjgbX99atngFl24g
	mngAUfzrbH77aXXMaahdzMwnX2x9DF7GHB+WMoxNFXdvINxCrtBhJSUS
X-Google-Smtp-Source: AGHT+IGmEldJDOW2q4mWPkIkoYs3wglVC4OHHYMI1eYl0tjn/RNlZVC0afpTvmCj/bRHFtT99JCWMg==
X-Received: by 2002:a05:6808:6b97:b0:401:188e:caa2 with SMTP id 5614622812f47-40646872337mr10013331b6e.35.1748374126795;
        Tue, 27 May 2025 12:28:46 -0700 (PDT)
Received: from localhost ([2a03:2880:11ff:6::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-404d98b2762sm4791069b6e.32.2025.05.27.12.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 12:28:45 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/2] delayed_node leak bug
Date: Tue, 27 May 2025 12:28:34 -0700
Message-ID: <cover.1748373059.git.loemra.dev@gmail.com>
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

Leo Martins (2):
  btrfs: fix refcount leak in debug assertion
  btrfs: warn if leaking delayed_nodes

 fs/btrfs/delayed-inode.c | 7 ++++++-
 fs/btrfs/disk-io.c       | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.47.1


