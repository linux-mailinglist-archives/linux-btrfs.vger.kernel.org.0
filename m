Return-Path: <linux-btrfs+bounces-16813-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6021AB5720C
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 09:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA3A3A3B12
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 07:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7812D5436;
	Mon, 15 Sep 2025 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQlaSjDb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588771C84B2
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922856; cv=none; b=cLFQt+6ptCfJIZKcyVW8xP6o+Bh2Z1l5DZyw8GqiI7pMvUSqm2RnFGKvfrXHw+Y1+u1ptdKmFaLX/2WZikuhMxjcFmtC85m0o65Kt5dZWCigU6sBwz4iGhK3+OUIlYP7viNCMvwe1caJeInvEvQAWuJxSkeHR6N3l7YNicb738Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922856; c=relaxed/simple;
	bh=XDEOZerUioYf9dGN9Tc6C1/e/J/6MIfsgac9F0rfm4U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HeCAtRpsTqdiBP0TmvkFAmTq0aC4RFMvTFo4tJpjkj2mTmeGbr51NDEa22QHZhxX5gTdmKQKN+xZ/JCP2NDZvktaK1irYTq0b3VCc51eDVjpT0kKMYjPNf54b2kmBSXuY5APZToZhFnEuRyS204rUoA+Uo95i4Yrw5TgmHv7L6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQlaSjDb; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b5229007f31so2518097a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 00:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757922854; x=1758527654; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XDEOZerUioYf9dGN9Tc6C1/e/J/6MIfsgac9F0rfm4U=;
        b=cQlaSjDbdBs3xcGv5DGQc3kjHY5bmxBuiURWT+RkXeK8Bc9+JncZOhyMG3Tqn23kHR
         749NT4CEBShXlvE5w2+c7rKkd9lkV+UPjq/16bV7079327Nwn7BWxyJQi5sWzX88lsYl
         4jp+Q37G9phrkB2AV7AReAHp3d3SO4oyE5tOo0zV/6UOCvd5A1k2rPfPjx/aBs2cdnVW
         bdmlQNndUfSgJZyjWFEnA89Y3FZwpipSq8fG3ooPdJl8rwp63INGVl4tyh5i/pqlcJcf
         mPTUZ8DWxYdszTjW5y9n79irgPHzr4vsWvb6C/+ggvNXiiNGrM7PLIuVhYSu/5nAiaIz
         ekqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757922854; x=1758527654;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XDEOZerUioYf9dGN9Tc6C1/e/J/6MIfsgac9F0rfm4U=;
        b=t4r1GTEjX4JQFWLcSJehqukBXENCuHK7ixpVXgNuKookDKkBhkU23DqfAT2X8Qk+kg
         qrVUCGK7TroXACrqdRXhcuz8ciPV9161ZfhGvzDp+NdC1g3EDQ8PUlp45e241tNjRE7G
         HWc2x0r4aNpPwVvZIG4FLqNodt4xgeGZtqrUefizuUqiiasDtb2M3/7jiRPKwWjm8tn5
         69miS2sr5UhBJaZgGP3R22j7CoKMwWA+3H/69uBlPcy0pAwrVyLlw4lIElcFfMXqsksC
         +txBssnoSU1Xs/OKqLzHjpfQRKmCA2tBRSkCQLEeSN2CDLv/8ytwcl9cQlFS87jplPdM
         RViA==
X-Gm-Message-State: AOJu0YyX5roPuXTzlSTajkesOEdW7iyLB+DloAuFZ4qhLgXiJESwTQYI
	mjEjKyDq6a3Qt4+EB63H0r1BcBy8B7HkcVEXkkX8szVY8TOuqM/Ju0eUE95a9GV1Kv4e/cubEQT
	wMfRvyzeKEJHZ0byWHYPmFWzm8mFI+KiOTg==
X-Gm-Gg: ASbGnct7XMeHnqJu5NvAgeFfOIHrkLasYZPVfxwW1HC/V0HGsuwwp0IngalQy2FP2sR
	Ad2ul8BiaE1I400ywgn3W2efOGS4LR7LEWvNch8LBByu8VZy4AaFn5adsgLq6cPiGuUu3S3v4oO
	DxVwuGpUyiffuh5NR3xdRRRvKsTnBiONxol0kqYenA9CtPI9Y/vKCsDrL1QLOC8kmh+C5Swiw31
	sIwj44=
X-Google-Smtp-Source: AGHT+IGG6QvMHlRF3UN7KMIKwiHEf9KuGv3AtpzCXDJN8ghjSiTu2mtXaFWrxhpLNBN3VX+oRAU8fK/lTicvfnubHIA=
X-Received: by 2002:a17:90b:4c4b:b0:32e:749d:fcb7 with SMTP id
 98e67ed59e1d1-32e749e0819mr1389107a91.13.1757922854129; Mon, 15 Sep 2025
 00:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Mon, 15 Sep 2025 10:54:03 +0300
X-Gm-Features: Ac12FXyv_Zb5C0uuuRJ2K4vi9_BqidDVNJqPpE-qxCTgcVUeqkVzGFLMLp3qDbw
Message-ID: <CAA91j0UzyMWB8htCjuBvXoWeUxKwDS-W1HkaVS54p=aTjqBv1w@mail.gmail.com>
Subject: Does balance always allocate new chunk or attempts to utilize
 existing chunks?
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

It is not about usage=0 filter.

Let's say the filesystem is near 100% allocated (no space for new
chunks) but has 50% free space, meaning, chunks are just 50% full on
average. Is it still possible to start "btrfs balance" in the
expectation that it will move data from some partially filled chunks
into another partially filled chunks or balance will always fail under
these conditions?

Oh, and is usage=0 filter still necessary today? I thought btrfs frees
empty chunks automatically now?

