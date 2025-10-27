Return-Path: <linux-btrfs+bounces-18371-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A192FC11DD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 23:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83AEF1891019
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 22:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAFB32D7D5;
	Mon, 27 Oct 2025 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stanfordalumni.org header.i=@stanfordalumni.org header.b="pQzdThjr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E1D32D7C7
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604874; cv=none; b=Xh9H1KjJJcs+XO3rURrCskC33xBs+17GzJOom9uZhDa330han2y96fhDRIrZGlZrVsmomWB3OXZ2jCp6PKrhb4UeEzZNBtuiKJTgbwu/bWO+JugxnF9G5RrbS5jLM/THJ/JIxnC+hWF+TUA+vX3EM7+19cRYB4yOJ/W3ss/RjOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604874; c=relaxed/simple;
	bh=yn4loR/CnQFGP7qiJqxRcy8aaptaF+lEU2UtGDV0d04=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PjDp4q2QlcZO8ty5/4Ql217bCN/tVVYxXsugTnH9+fhrCipgxUOoHc9vWDbBp7eQXk3tOv+A9wjOMRu5SLk/jFEcPrH66bGoL8x1xgIx7vqxZoogdjgVhiltGE1uJMsdOTVISN6M3F/Z8stz4UGZFjbsaDVwemzxuICmnaHraRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stanfordalumni.org; spf=pass smtp.mailfrom=alumni.stanford.edu; dkim=pass (1024-bit key) header.d=stanfordalumni.org header.i=@stanfordalumni.org header.b=pQzdThjr; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stanfordalumni.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alumni.stanford.edu
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8a2b2b3b813so31680285a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 15:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stanfordalumni.org; s=google; t=1761604871; x=1762209671; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nKxsbULL+syPxxbXu0aO7f5sRiZm83zPHQ6BWD1Cs3o=;
        b=pQzdThjr/+pLd/Lzr77MRZGvtAMho0v2bM74+EkuA8B27mfkprK4bYIk7sGAJ9bx9R
         Q/0oIKKluv3/ai0krX8lpO0ECNVZSBLN88rpdIL2YOUDikY6E5FwUUdm+iZX093qUbHy
         7STSaO/OsIWNc8ncvyftTfpQ1TjnSbVa6HzPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761604871; x=1762209671;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKxsbULL+syPxxbXu0aO7f5sRiZm83zPHQ6BWD1Cs3o=;
        b=OUeQ1E8yL4SOA/23uXaOASRl1kglaQkkxkVmWbHiRXuE7U7FN7+D1BrnHXAKs0r5Rt
         gg6200KcS14OOMeCU1QAiWDtOa/qwa7dUo8tZfBkZKRAV+u91TY0nU7tgFBNGkK4pKvs
         AURxsoLOLWf3oMM8rwaI04RRxAfKxi0318T9TPgIrPPErlRYFM1enBUlKBCmcK/l3fD0
         SAcYNCi2cDmgjalTxHMpdRFGMj+5nHdtiLuJlICtHE/ZPhelxHeFAt8n/DdB592SbaaA
         N0Vq88j81TcO3ppZpg0WoCiJKPUteor2vbVu9vRM1+YtJ0JX76N0RVGZLxWAD0kSNCJz
         +uGw==
X-Gm-Message-State: AOJu0Ywe2C2zHNPOozbCiVjFKEGxBZol/DWd2WowXXDZGicJBcZEF3Ko
	CO7i55nKHqlEmJe9YonKQC9KspEbFUqvNJkKKOWqf/MAIshs35hMRZ/NplI+qRtwXBTWUOgpySx
	IQFHs/ZDuCqckiycdak6XXORu3G/d1t41MXdiRvcBOMC9yd0iNNifcw==
X-Gm-Gg: ASbGnctBpKtxQgwLortqYebJLA7B4JGOrE0dherl0R7UTBv+kopolCMEiqthYabRwYA
	/VDx14H0qNerp6C5jhhSGRYpT12+fYazQXzaxPML3VQeZdddXK1mndtNN9Qa543OnDG7Fk731zr
	mz9vcpV9MoDvRWseBnm8YcRIE/uu7CTFcMalwLN9yTqG2x5dTmX7c7PBosO46fmdV0FYid2lVRr
	lRn+EnXoRyYPWUk4UuegptO084ZEHzu8m3JicjWyz/P4lDzmdvxIbzzhmk=
X-Google-Smtp-Source: AGHT+IEmk8cH0kmhQNPm5lONkVX00S8ZVFcbuufeH4FdwQvZVT18QgRrM4xh3IO1hadMZ6C8Z4T8gHb283wYp+PaWR0=
X-Received: by 2002:ac8:5acf:0:b0:4eb:a6fe:993b with SMTP id
 d75a77b69052e-4ed074820f4mr16936131cf.1.1761604870676; Mon, 27 Oct 2025
 15:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ross Boylan <rossboylan@stanfordalumni.org>
Date: Mon, 27 Oct 2025 15:40:59 -0700
X-Gm-Features: AWmQ_bkafL7IUjSbHbkE5-J22qUdU73d0JwQDXSesB_iui7giLLbkb6P8SfV4vk
Message-ID: <CAK3NTRCBV0jTPrHb_tmWzdrLqx9xnvKpcqA7-_Cxm9TfJAGGSQ@mail.gmail.com>
Subject: btrfs fragmentation
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When recording over-the-air television the results are typically very
fragmented when saved to btrfs, e.g., several thousand segments for
6GB.
This occurred even on a large, nearly empty, filesystem of 5.5TB.
Automatic defragmentation doesn't seem to make much difference,
although manual defragmentation does.

I first noticed the fragmentation when I started getting messages that
the writes were taking a long time, although I have not seen those
recently.

It seems this application (the one recording the TV) may not be a good
fit for btrfs.  The developers recommend xfs, but it would be nice to
have the
more flexible volume management of btrfs.

I'm curious if anyone here has any thoughts or advice on this.
I'd appreciate cc on replies.

DETAILS
New partition on Seagate Exos x18 (spinning disk).
btrfs --version -> 5.10
uname -a -> Linux barley 5.10.0-36-amd64 #1 SMP Debian 5.10.244-1
(2025-09-29) x86_64 GNU/Linux
under Debian 11/bullseye, (current stable release is 13.1, so a bit old)
The entire btrfs filesystem is based on a single partition: no RAID,
no compression, no snapshots, no subvolumes.
The recordings are done by mythtv 31.0, which I believe basically
takes the video stream and dumps it to disk.  The developers say it
writes "continuously".

I speculate that what is going on is that it is writing small chunks
to disk and each chunk causes the entire underlying segment to be
rewritten.
However, I've noticed that even when I cp a complete file to btrfs it
ends up pretty fragmented, albeit the target filesystem in that case
was very full.

Thanks.
Ross Boylan

