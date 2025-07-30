Return-Path: <linux-btrfs+bounces-15744-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 231D7B15823
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 06:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435434E0B7A
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 04:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0601D5ACE;
	Wed, 30 Jul 2025 04:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbyTLKHI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243664A32;
	Wed, 30 Jul 2025 04:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753850636; cv=none; b=PmkCr3Zn78/FJJbKChyanusCwMMIUDD9j2A5gqYd54JXRqHSlGas0rSHk0WoZi6y5ssx39a24obArlXwEGjhxSJ2sDcZ/UcWJNXI2kgu0VlFXBR3TOe9/S2oSewKtsynZfn/8XcEUASHMfm6DIZpumhjKhJi3gTYTEvU0Oi5BDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753850636; c=relaxed/simple;
	bh=/2/V//9TcM8n37ZKi0naC7ewOQzSYwOo7elh/RXKbGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Un39OXw7dxMjIEx8/XIpKZpoUBSI+K6XPWAxW1AS1SCIyRiLPIWlIqbi2gbGPW17v/LRTJcpiZocJ3w6WlYqCMuWmKGyLoLbcYA/KWhXuF5t9G+PmDRJSaIttAXW53NhyTqX0dpPaYvRw2v3OCRN5ChGavVyoB8Uf8B9oKVASLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbyTLKHI; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b3aa2a0022cso6643227a12.1;
        Tue, 29 Jul 2025 21:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753850634; x=1754455434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I5nkMxoQrllcrB2LXAW9NScvifFO/bApn1I1MurFZrA=;
        b=RbyTLKHIJgDnLabWsvqGyxdVfG9O92/yuazwJoPAgYisaDTk14Uqf62IHNasRTGEKx
         Rae9iSub7Fsi0xVLPKFVzXf3h6R3c10BenlWxKkdlegNoGHzVyRnuc4u0hS1U6mKIVmK
         LupLIf2Src3aOziBzT+nw65HS1jCtpGbEwFGAD5kEpOfYixhoQwp72YiA8X3RNgJSz+p
         X5ExhzCiE4jyiGALmVdd07avcIK3Jpr2/XIzoifmPT+CqiQ/LIDEglVEoCkcwyLUKZnw
         rgWCQpIzjx9T37zBbWwFCg7JZp48amXmHfLpsOxuGY2uSxZ8nIY0fR/8sa3AQTA2c6no
         xRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753850634; x=1754455434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5nkMxoQrllcrB2LXAW9NScvifFO/bApn1I1MurFZrA=;
        b=kJrl1zjvRRC4kpOi3Nefxf5COzQhLf5awma3SdHHCG0ph7CO/rPxP+mJi3yGLzEH8U
         kKXw7jr3gsVdLfAAFjvfua/H7j/gMv5OhkO4q5OBiBzBnMMA+X/11+paaCZczUltlgW+
         I2HvGpzHDTEoaDPM81DdDQPUUCvjovPFL0Buz0fG3g9YoczJVbVkDuvNnJCAA2seDpIM
         UtW18oNiOogrVfxSj5aSqMnAcakAM8eqIw9Jmfi26tAdjURaNf81wUfapuKdRTLexXqY
         J4H8JdTwyZ0/9gsDuKpvz85J3oaibmJwazKtBFAQB+CGq1g3F0WPXLKp1VM6VrIF4D3Z
         5udA==
X-Forwarded-Encrypted: i=1; AJvYcCW83VO3NBpsCHgtru+1Y6+2bi6kbl0GuupFl2ZD6dKXr7JdvgLZJXp2FxQ9FR5nhuIiSoNwdmYULVVAl+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxHWQOQMs4YjhpOWyCUNELTUm5qOu1dkaTBHVTuA+0D5mPM6wG
	3s5hoIDjY5eRLE+OSU0kexj3jPPdGvUZ7bQpvwH0j9alF+3OKzbk+MucqyOthg==
X-Gm-Gg: ASbGncueBcvxGZMzvNCrvpoilJKgDXM0a848H32wM0bGNC3U+1PcxYQH3py6STMsBCk
	3oGnRH3nnYWzF6nA71aNM8UmylqPZj3WQsAvvc62aL+ZcpVekfMjEUCbEkOhbJHga00+SwxpKR/
	VSLwrT3ZL109ISjcJAPfCb0kamJ1t4Z2cGeL+O9ZM54zPSombTGBEBq3rHHo6UI7mkx8HCe28lL
	p2ZFMOBB/tBPxnn1Ck39+vyfwBbdj8A7DK7vS2qifM8PVqR+XLpQ8hmIi7CrpZLM1vdBRAOjis8
	hDApywuis2Q8EpsGrrhexnoJNFaexXIqOmCqKevtA0SXaFbjYICegD3GLo95A33tporY5qjYQF5
	UcqepdXFdE8hWBD6mu42DLBFCIGlZjLiSB0IpQDf3U33ljCnqV8OKvsuu68Po1AVvEk5Gx2I=
X-Google-Smtp-Source: AGHT+IEWyn6eGxLkqj8DrGjaKHhNTwvBT4+ExTAGD2TcWtRfRypkRtXATulNqEKVHp7/JmLsFLpSkg==
X-Received: by 2002:a17:90a:8f03:b0:31e:7410:a4d7 with SMTP id 98e67ed59e1d1-31f5de95125mr2475966a91.33.1753850634288;
        Tue, 29 Jul 2025 21:43:54 -0700 (PDT)
Received: from mail.free-proletariat.dpdns.org ([182.215.2.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0cb39sm706453a91.30.2025.07.29.21.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 21:43:53 -0700 (PDT)
From: kmpfqgdwxucqz9@gmail.com
X-Google-Original-From: admin@mail.free-proletariat.dpdns.org
Received: from kernelkraze-550XDA.. (_gateway [192.168.219.1])
	by mail.free-proletariat.dpdns.org (Postfix) with ESMTPSA id 448154C025C;
	Wed, 30 Jul 2025 13:43:49 +0900 (KST)
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	KernelKraze <admin@mail.free-proletariat.dpdns.org>
Subject: [PATCH 0/1] btrfs: strengthen integer overflow protection in batch allocation
Date: Wed, 30 Jul 2025 13:43:47 +0900
Message-ID: <20250730044348.133387-1-admin@mail.free-proletariat.dpdns.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: KernelKraze <admin@mail.free-proletariat.dpdns.org>

Hi,

This patch improves robustness in the btrfs filesystem by adding integer
overflow protection during batch allocation in flush_dir_items_batch().

The improvement was identified during a systematic code review of kernel
subsystems. Without proper bounds checking, theoretical integer overflow
could occur with extremely large directory item counts.

The fix implements proper overflow checking using the kernel's overflow
detection helpers and adds a reasonable upper limit consistent with other
btrfs batch operations.

This has been compile-tested and the fix aligns with existing patterns
in the btrfs codebase (log_delayed_insertion_items uses the same 195 limit).
The patch passes checkpatch.pl with no errors or warnings.

I've CC'd the btrfs maintainers for review.

Thanks,
KernelKraze

KernelKraze (1):
  btrfs: add integer overflow protection to flush_dir_items_batch allocation

 fs/btrfs/tree-log.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

--=20
2.48.1


