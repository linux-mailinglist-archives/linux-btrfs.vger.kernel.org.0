Return-Path: <linux-btrfs+bounces-19026-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC99C5F193
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 20:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3ADD74E2656
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 19:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D7133B947;
	Fri, 14 Nov 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="ds1fdMAs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356FB2E091E;
	Fri, 14 Nov 2025 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763149827; cv=none; b=U0qso12TMbkwL4BVKD1LVAGIH+Dba2zSuZ5fyn1Mvn02iGquZq/E/tMLMj3CgqYzIE4RBaje9aF3VMcVA3WncQsG4DOMz+2aeuYSVAUeNhw1D5HL1u6sbaE4UD4CrKBxB0cVkwURESUb6A2LXohooZJAUDuBZzY2kurEHAJJTG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763149827; c=relaxed/simple;
	bh=RxXE6T0/eTEBStT4519m3XD/5fx6LR1+h05WTFCdQYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gFfvNstr5sU7U6vTXuLG/LSirN41omQ1B24uzJc/YIM5qnGaoAuzromo6jXRPLMdZwPRKzTI+AS7FoYPnou1fWOeAs0MZWdPY6+O+pHdpclLW2HNqk5blZM/Xqmp+TBPS0Jubr3m2bGD1XVRvQdxazGVAPVUdpEVfCVkPHTl25E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=ds1fdMAs; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Andrey Kalachev <kalachev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1763149478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9T11li1hq6NqfUIBRM5Blv2Eh6Wtuj7FkfiPyb0yGAA=;
	b=ds1fdMAsJCbQCVaOWA8WF62Tz5LAb/2PQ8luIp7udrpSx2Zxq1wtB1V836VVDqhBfqku3S
	IKTqPdVF8VTShb4AASJfNb4sHAfZugol2SdrkdI2bq/Cu2S7q2jaBvENRnzDw2DrERejHr
	2qdksmp6JRsdTYxuZtCYBm17Ji2xEV8=
To: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fdmanana@suse.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	stable@vger.kernel.org
Cc: kalachev@swemel.ru,
	lvc-project@linuxtesting.org
Subject: btrfs task hung in `lock_extent` syzbot report and CVE-2024-35784, patch series v2
Date: Fri, 14 Nov 2025 22:44:32 +0300
Message-Id: <20251114194438.5694-1-kalachev@swemel.ru>
In-Reply-To: <20251030131254.9225-1-kalachev@swemel.ru>
References: <20251030131254.9225-1-kalachev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Hi.

> I've check c-repro [1] on 6.1.y branch and found that repro still produce
> the crash on 6.1.y. I notice that syzbot bisection result [2]
> is incorrect: indeed, the hung was fixed by upstream commit b0ad381fa769
> ("btrfs: fix deadlock with fiemap and extent locking"). Also,
> I saw CVE-2024-35784 [3][4] vulnerability, that have direct relation with that syzbot
> report. Therefore, syzbot reproducer provided additional way to check for CVE-2024-35784.
> 
> I attempted to fix CVE-2024-35784 in stable 6.1.y (over v6.1.157), and
> found that the initial fix commit b0ad381fa769 ("btrfs: fix deadlock with
> fiemap and extent locking") introduced regressions [5][6].
> IMHO here is the minimum patch series to eliminate CVE-2024-35784 from 6.1.y:
>
> b0ad381fa769 ("btrfs: fix deadlock with fiemap and extent locking") (Initial fix of the CVE-2024-35784)
> a1a4a9ca77f1 ("btrfs: fix race between ordered extent completion and fiemap") (Fixes: b0ad381fa769)
> 978b63f7464a ("btrfs: fix race when detecting delalloc ranges during fiemap") (Fixes: b0ad381fa769)
> 1cab1375ba6d ("btrfs: reuse cloned extent buffer during fiemap to avoid re-allocations") (Optimization: 978b63f7464a)
> 53e24158684b ("btrfs: set start on clone before calling copy_extent_buffer_full") (Fixes: 1cab1375ba6d)

UPD:
Fedor Pchelkin reported that the 1st patch series version cause fail in generic/561 fstest.
Backporting the patch
  418b09027743 ("btrfs: ensure fiemap doesn't race with writes when FIEMAP_FLAG_SYNC is given")
fixes that.

Updated patch series looks like this:

b0ad381fa769 ("btrfs: fix deadlock with fiemap and extent locking") (Initial fix of the CVE-2024-35784)
a1a4a9ca77f1 ("btrfs: fix race between ordered extent completion and fiemap") (Fixes: b0ad381fa769)
418b09027743 ("btrfs: ensure fiemap doesn't race with writes when FIEMAP_FLAG_SYNC is given") (Fixes fail of generic/561 fstest)
978b63f7464a ("btrfs: fix race when detecting delalloc ranges during fiemap") (Fixes: b0ad381fa769)
1cab1375ba6d ("btrfs: reuse cloned extent buffer during fiemap to avoid re-allocations") (Optimization: 978b63f7464a)
53e24158684b ("btrfs: set start on clone before calling copy_extent_buffer_full") (Fixes: 1cab1375ba6d)

Also, in previouse cover letter I've included the wrong C-reproducer link,
the right one is:
  https://syzkaller.appspot.com/text?tag=ReproC&x=1262428c580000

Best regards,
AK

Reported-by: syzbot+f8217aae382555004877@syzkaller.appspotmail.com
Reported-by: Fedor Pchelkin <pchelkin@ispras.ru>

