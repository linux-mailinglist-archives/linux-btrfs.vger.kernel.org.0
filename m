Return-Path: <linux-btrfs+bounces-15229-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD91AF8211
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 22:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1BFF7AE612
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 20:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3D0298CB6;
	Thu,  3 Jul 2025 20:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unitednix-corp-co.20230601.gappssmtp.com header.i=@unitednix-corp-co.20230601.gappssmtp.com header.b="IaGxPOiY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F73A1A2630
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Jul 2025 20:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751575638; cv=none; b=l8R0hiAs3MnKJHyP75mzNnaAbnTKFdWVS7pIUICl4i2mmWnfRikGC2+SpU2BwV2m/bCfBtknxOJVQ3tTj2IG8jxHu8IhNQ8+tm7FbvKAHWkRZluIoQL7ghYCY9no3zioN5aA4fHCT+aBvgp3HZcayUwwn8J7WCp/dLm7gOgmbCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751575638; c=relaxed/simple;
	bh=vTw/FJaYvZ0ZMgOlggJ0okD0/q941eCpDJB6Ve04svA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WjoLqeWzgmGGFewwtYpOzhQ9LJJtCviPKA9ui6fXwJzur2LPQPapJz3x+GMiJ+s0Ji7KY8br3P1W8vmH9sRnLNES5i3xZUPMOj3qtE4iZetBAPmQQUf5WmjTVyMxga5fGTRRhuQTkSDl7kqa7MspZCpnx4Nnanq1HlSMo8qG6uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaillen.tech; spf=pass smtp.mailfrom=unitednix-corp.co; dkim=pass (2048-bit key) header.d=unitednix-corp-co.20230601.gappssmtp.com header.i=@unitednix-corp-co.20230601.gappssmtp.com header.b=IaGxPOiY; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaillen.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unitednix-corp.co
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2fd091f826so302431a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Jul 2025 13:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unitednix-corp-co.20230601.gappssmtp.com; s=20230601; t=1751575634; x=1752180434; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vTw/FJaYvZ0ZMgOlggJ0okD0/q941eCpDJB6Ve04svA=;
        b=IaGxPOiYoBjmJ6a4XPm/oawPRf+dYjRXsfyMPOMk/EjtCGbSkMLV3IslXBS7TH1+F2
         EfoXUIuPfFVqxEUd/wmg4v5Gfu+pSfig4uppUKW8/iAP0o+GCM8V8o3ehIbxjMNsDfCW
         7q9byl5xIGtAS58Gm/XZdovzf2oKZe1OLznX4XUbDbsbHB8Xx+JrQDX62NZsnAQ8LHtu
         zPQS5ucaJAmY1XjcI2ADHVl2XWZqdUOMSBNK3fsUobii5HG7Rcx58qRcjkLz9IwGTR5V
         Z7XGAhEpOJd8Y9TffES2Br0tOqoUBIVvBey+6vDEE/rAA5Y75xIHIZZzfg8zzAVpo2Qv
         tW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751575634; x=1752180434;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTw/FJaYvZ0ZMgOlggJ0okD0/q941eCpDJB6Ve04svA=;
        b=vcLT6B0spB7mkhzNMpH/6ukuZPxNxGKPJXOHUn1IDy7/O0B4+t1FnudfPcVRJkKbb8
         6s9oT4qev+9J4b2mmQjsl6mg6kW9+WGRBJRZYcwRVMG3uZdynCIvdwO18YkclsgY7LbK
         i5VJSjDrqIXxxF3NiV3nACJp5Y9PWRLW60j7D2wEY1nvEgdJgUGdpf90bTPrnIMNcJFn
         KS/4aBLU6d3JFjLgmjBFw1lwFPxVWybVqLh/1D3iCvFGQ8jOipZyDnVc3lgXh38mcsA6
         qxFHaHztPnOfTk8Svq1CEvv9a1dh207/bC/bChWXEncuB24K0JhS+uxUuUbFB2epr6UE
         Uu3w==
X-Gm-Message-State: AOJu0Yxprbrv9rzw/320YsaAiCveWGdXAViSP0xBKHKOwUIr+MhwyUmd
	TeSc2LJzmn6hBCalf8pmcrs6kgZtn6tLJlk8p7a6KKCV+ZkbQ28jh+Lnr5030z6k/gJCEJ7/FKH
	Z71ox62W29byGd1HlyvIuKxVYLC3Q4rWOKuS3aq0eVJ+5Mp743Hi6XP7x1YSAmz8=
X-Gm-Gg: ASbGncsivjRqJxF82jvPq5njdvePn9OURsEQelAgiKCVfVb20IVxeskQPEoo7uM+HlY
	Qi6OClAXV1bd6+GgCs/qvqlzW569mireRp6GsrKJkpLyef5ez1ao7lalCO9JRIP2t1zwx9n80Gd
	oM/61ytvI9NYs6AyP8pExlkyB52OYaZFp6sc1DCwLHUa+REavu+CuaGlvH
X-Google-Smtp-Source: AGHT+IFChaDp7Pf1wL14P4F7rWqoSGXfciP7F8RnGyMHOSa+WOSqk1rm64caepnfKTD3vF5h42IED9BLtvBVhxij8wU=
X-Received: by 2002:a17:90b:35c8:b0:2ff:4a8d:74f9 with SMTP id
 98e67ed59e1d1-31aab8cc9bdmr490068a91.10.1751575634233; Thu, 03 Jul 2025
 13:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yevhenii Lysak <arch-knowledge@vaillen.tech>
Date: Thu, 3 Jul 2025 23:47:03 +0300
X-Gm-Features: Ac12FXzFeX__P93wAhx3C7FOK_znnYW6Yr-uzpEW3RiL0C9wMAk3NlpcpM-9JvI
Message-ID: <CALYdzHZdK+Ki8dsBonpJ+2-eW1xW1xhxDMEYkEQR=TntJ+40hQ@mail.gmail.com>
Subject: [HELP] BTRFS error: Failed to recover log tree after unclean shutdown
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

After an unexpected system shutdown and system update, I'm facing
issues mounting my BTRFS partition. I'm getting the following error:

BTRFS: error (device dm-1) in btrfs_replay_log:104: errno=-5 IO
failure (Failed to recover log tree)
BTRFS error (device dm-1 state E): open_ctree failed
mount: /mnt/new_top: can't read superblock on /dev/mapper/tmpluks.

System information:
- Arch Linux
- System locked up and I was forced to shut it off (unclean shutdown)
- After reboot, I ran a full system update
- I performed the manual intervention regarding linux-firmware as per
Arch news instructions
- After rebooting, I encountered error messages related to NVIDIA drivers
- I booted into a live environment and ran cryptsetup open on my NVME device
- When trying to mount it, I encounter the error shown above
- I tried mounting with options: ro,noatime,space_cache=v2

The btrfs check command doesn't show any errors, but mounting still fails.

I would appreciate any help or guidance on how to recover access to my data.

Thank you,
Yevhenii.

