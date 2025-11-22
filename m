Return-Path: <linux-btrfs+bounces-19272-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAFAC7D9AF
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 23:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13CC44E273B
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 22:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9667F220F2D;
	Sat, 22 Nov 2025 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4EYqLjM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C5F20C001
	for <linux-btrfs@vger.kernel.org>; Sat, 22 Nov 2025 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763851677; cv=none; b=Iyi+bSbwvlIRLmPm1GgC5FHfcLHME3HOBevCrGnWzmXzvoQSMnnxL3HtCsJx4mMPyI/hk02lxa6A8JiTOhrGcwaj9EphhCPLr3CfuWSrOxLTsLi/5Gu+recusUHZ2U3QUZUBDXcbpWZFVfx7ejcXBtj7MMAZaCKwXeJh9EACtH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763851677; c=relaxed/simple;
	bh=mDmOqDRRV1GxRTkt03uYnfvm5YBI/u/mWZasnkUTwrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqMx0ATyO9eAgm8yyaWYKa316lAasp9AImXBB5EGKXCeeSXxQf6MQd/UumainAb4Iu9UX76JRovqr0gqQVba13R4uIIw+3Hpi1Qx56uV44yywl+C0spky1Iaggv5yfjMP3t5pmFvqMa16qo6nz4qgTSrgsj0vkqH1KKrL2gyd4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4EYqLjM; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-595819064cdso4439226e87.0
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Nov 2025 14:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763851674; x=1764456474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mm9cJVhutkedd51ycbYwKmMqp19QwPFiX/ffFg8rVcg=;
        b=m4EYqLjMnZAClasW5oW/RKRiG7pn1i/2sd87a2+bGT5arzuzX2s9OWunw3ssNpcdIL
         Rt3hNDSuFUBrtfbXvhjdipl2gBlBuevvx/2V/Sci3GW099P+W5/rd7vFyuWpyVXP1yQP
         MK62n9rzpZxAKODtmj7axGjtZm2iPhssZ7V5ietC61jcOyFvK9Nmes+GYZJ0bfVVY9W3
         HhsNbNtfDCgWUxgyoFMe3TEbEmFHKPlLJzBCay6GBLVkLziLLWupjzRTYCBTQvVTCNtC
         PCE0gN7ui5o9znFYb9NWADBrbgacrALeEnX1YBs7J3e4rCG9ErcZLONAjVpKnh7gKzq8
         xDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763851674; x=1764456474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mm9cJVhutkedd51ycbYwKmMqp19QwPFiX/ffFg8rVcg=;
        b=nyLOu5W/++QKkKatOnm6GOtiEBPCnEwUa96TGmpdvsUO9X72BSYSvsZHG9HMMfsRNS
         iH/AdiOsddeVMJHT5DSBWeIKJ678v9KWZcgxo0SRvWAi/zd8DnXgpACcNXfp27CC5/Qr
         LNQAG5jPyQv09rfBtuacFhXvS9skRHCwo0B558VbNmhxNxLHs6NTi1lXQxiTIqN/qBSU
         R+efcgrBo7bnxJI3uCOOk+/Af8KzgrNt+oTyrwGT/4TuHAxdx3a60XbINn1K4V/5jrjm
         lXDrRvfD4I+Df8SqzfHpZCwJ6NKGDGUYb/kBf91uSN9Ag0ehiNAXStX6lY9i1BSvH950
         lx/g==
X-Forwarded-Encrypted: i=1; AJvYcCWzN6srU2to4G/EiIVSbaavUUkJTnq/u0LE2lHSw+jfPJokI3LKu8d/Iq9zar/tdB7KirHEAvySIwGI3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYLl+JhpDOFd6PwjZWyoHZzRWHLMAWUyLVtlP9p/iMhbWKDZJb
	s74Hh5F1Hmv2IWTOBJiVmM6Z3bgKCcQD4dch8wsJJPht3NWnTIGB7MTJ
X-Gm-Gg: ASbGncvcFQDT8SHSLwAmysFOZRqFHppsteudBO9J5hSx3pP+yI1BzJUjv9PdL7yH0Lp
	1rReIWJuz5uQN9ln4tGFknbVMGvxsExRMuYNK4IKfkExHk73XDfF7vbQhp9MDbRPtAW5IP50ESW
	yyNmssWsBEacZseLHVjAVGMSA/gldxgLoxob9edYIiI1bxq/1x33oQaKQ1VvUxamPpvaOAbQOdp
	LxaSkTno2JKBddtGXNGj7ZwwhX40RaN6yuroLwgw+m0OAVgsFmrzxE4CPbtNfdSRmt3+HnMy1jc
	QsI5IaKXURPS3sDN2TO2WJCWv+75VsWaWb0Ovg2fhQKekGVCullp5av6xqasGITadspg/G6Ehus
	D+QPcdgjDRnB/o/hA0WyvDZeh6LQNS4XcXaShsJ4GN+p68xb2bMTCDNr7Nm6ls76RTUBfguzuZm
	rtNczTM+2ZIg==
X-Google-Smtp-Source: AGHT+IG25dEQnHwaBToxpvBjTeZ/3RB3yCymIb0k9rzfOt31nS8ruDCrSu8IePguUMWt0EMXA9m5xw==
X-Received: by 2002:a05:6512:308c:b0:596:a000:596 with SMTP id 2adb3069b0e04-596a0000a2bmr3428587e87.10.1763851673743;
        Sat, 22 Nov 2025 14:47:53 -0800 (PST)
Received: from localhost ([109.167.240.218])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5969dbc5988sm2742367e87.78.2025.11.22.14.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 14:47:52 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: mpatocka@redhat.com
Cc: Dell.Client.Kernel@dell.com,
	agk@redhat.com,
	brauner@kernel.org,
	dm-devel@lists.linux.dev,
	ebiggers@kernel.org,
	kix@kix.es,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	milan@mazyland.cz,
	msnitzer@redhat.com,
	mzxreary@0pointer.de,
	nphamcs@gmail.com,
	pavel@ucw.cz,
	rafael@kernel.org,
	ryncsn@gmail.com,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 1/2] pm-hibernate: flush disk cache when suspending
Date: Sun, 23 Nov 2025 01:47:48 +0300
Message-ID: <20251122224748.3724202-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c44942f2-cf4d-04c2-908f-d16e2e60aae2@redhat.com>
References: <c44942f2-cf4d-04c2-908f-d16e2e60aae2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mikulas Patocka <mpatocka@redhat.com>:
> [PATCH 1/2] pm-hibernate: flush disk cache when suspending
> 
> There was reported failure that suspend doesn't work with dm-integrity.
> The reason for the failure is that the suspend code doesn't issue the
> FLUSH bio - the data still sits in the dm-integrity cache and they are
> lost when poweroff happens.

I tested this patchset (in Qemu). It works.

Here is script I used for testing:

https://zerobin.net/?66669be7d2404586#xWufhCq7zCoOk3LJcJCj7W4k3vYT3U4vhGutTN3p8m0=

Here are logs:

https://zerobin.net/?5d4a2abbad751890#WMcQl4FAZC9KqcAuJU3TSVr7wuVnPFwI7dlinA9QHOo=

Tested-By: Askar Safin <safinaskar@gmail.com>

There was no any reason to wait for me. You could easily test using script above.

Also: Linux shows this scary message when booting in Qemu:

[    0.512581] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

So, FUA is not supported? Does it mean that this patch is wrong, and works purely
by chance?

-- 
Askar Safin

