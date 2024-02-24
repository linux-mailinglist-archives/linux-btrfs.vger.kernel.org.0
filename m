Return-Path: <linux-btrfs+bounces-2707-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0C68624F2
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 13:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DDE5B21A1E
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 12:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7153D393;
	Sat, 24 Feb 2024 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UC8WvNZV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com [209.85.222.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2BF3CF73
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Feb 2024 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708777020; cv=none; b=P5cidW+hEN+ISLdch3NjsvseQdaacztd6aQ04R4V3mygBf3DWytsdgf0wd+MNfVdoXmo5ueWL5Tyn1zOgWOVXoyWzUuCpuQMCUK2ug4hyIbr/DETM8pPHc8/P0NUqxEFltC+IUPNVbkHLPaZ7aTUjc5zHZVTC8yOwpSx9KRCvMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708777020; c=relaxed/simple;
	bh=yLTwkhOWN6qTv38rUz1HNChAxWor11c0o3uS3Hk0b5w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lWjCln/+7b6Hsf+QZiLYolyAyK/324zPZmL/mK/RBzUJHzC4xg7diJ+D4U61ppPjx4oKceYZ5vobjIScgB/rdG/aaD7U2Xd1r2cNzFm1WxrJwPpRq9sEyLrbSXb6F9eKLivS4UU9YQpc+RCC5qd0HW0TYVZ9RLLzrcusgNco9vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UC8WvNZV; arc=none smtp.client-ip=209.85.222.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f67.google.com with SMTP id a1e0cc1a2514c-7d698a8d93cso899089241.3
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Feb 2024 04:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708777017; x=1709381817; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VTu9CpzYjIxfl4YEFxNm93JtJ6nzjvU1mbQ8W7Yqb1E=;
        b=UC8WvNZVWGbveS+xfheD1fyl6cio7d8nXAV+gvIsoZMsMBSpSNtFmiHQjA+bYax7jo
         32KbPbxuuKxl9ca8WP6MwQ2usB2nXsXdd3DXm0Ft9/oTs6PEg4JoV3hhB8ibuUY1LPmG
         tljokZNZURLLvR4+ysgdq/Y/bz/HQB12K4um/sYH/Y1jwQN4CAqByiG/WY29HwauJZrP
         PzW+k2jUyzhL4xJ/hFzg/2cqTZRo7X42iuAn0eF9AKDS8dzd23tn+PFcENUH6zXKWXzy
         VuMudNLmHGqooaEiFz1++pAVoIn6Wcjqb4GBiY8TQGZwg/RUjEXAA80PMNSOlgLSqTUF
         wIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708777017; x=1709381817;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VTu9CpzYjIxfl4YEFxNm93JtJ6nzjvU1mbQ8W7Yqb1E=;
        b=FtMrH5MzMJLj/Kj0khKnAesvMF1b0q8rCfWsR+FATT+KFzwcZJwqK2bF0J4vgC5jWx
         TResHNXVsjfC4WQ6w3t50dQ9B5ILn3wfd/ekYmSLDP7Y7W2k9sm/xXaALylcZin85KdL
         mCG5kdS5uRD9g95EH/q6t5AqPiizyN852jUV6x0scH41ViFjs4O1wc2tK8oDsXkN8Mpt
         VF7puAVE2GVvcztKEoI1cYCv0Y0O2VzOJJa/dN8HjlZpsrI2C8KQGryaCbAcpRIkuc5m
         LnC88n17JoD+OrT639Cok0aO9yUPAj8aDxtXlHAFvpZQsmESH3ibdiL7eOMSOoxyFDZH
         TW8w==
X-Gm-Message-State: AOJu0YxqVIOkzo0N9wWcemwhfVglQkKWrOF3AD3r0PUSfhlzuUxC2z69
	VJP2AAigp4vw/DgjKRpO4S1/ZLWKrbz6msUmim+5H+ZzxDuS0MZzt5m3dBXWY7yA95+0iH0r/+r
	l7xUxKFoTbH56CiF4LtBd594j6qXqAo+xlOpCfN/J
X-Google-Smtp-Source: AGHT+IGDFScjOfFJAQNl1gmhFFAsydyhZjq6y78ZU0CT2P6E87TDufkppILmFIs9N9fNtlR/u/dCu8my4srdBfmDArQ=
X-Received: by 2002:a1f:c4c2:0:b0:4c0:1c1a:7f85 with SMTP id
 u185-20020a1fc4c2000000b004c01c1a7f85mr1546684vkf.1.1708777017394; Sat, 24
 Feb 2024 04:16:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: WA AM <waautomata@gmail.com>
Date: Sat, 24 Feb 2024 20:16:47 +0800
Message-ID: <CANU2Z0EvUzfYxczLgGUiREoMndE9WdQnbaawV5Fv5gNXptPUKw@mail.gmail.com>
Subject: Super blocks checksum error on HM-SMR device
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greetings,

I have a Western Digital Ultrastar DC HC620 (Hs14), a HM-SMR device.
It is formatted to zoned BTRFS by `mkfs.btrfs`
`btrfs scrub` reports the following errors:

Scrub started:    Sat Feb 24 15:42:38 2024
Status:           finished
Duration:         0:09:34
Total to scrub:   76.64GiB
Rate:             136.72MiB/s
Error summary:    super=2
 Corrected:      0
 Uncorrectable:  0
 Unverified:     0

[Sat Feb 24 15:42:38 2024] BTRFS info (device sdb): scrub: started on devid 1
[Sat Feb 24 15:42:38 2024] BTRFS error (device sdb): super block at
physical 65536 devid 1 has bad csum
[Sat Feb 24 15:42:38 2024] BTRFS error (device sdb): super block at
physical 67108864 devid 1 has bad csum
[Sat Feb 24 15:52:12 2024] BTRFS info (device sdb): scrub: finished on
devid 1 with status: 0


What went wrong with the super blocks?
Thanks.

My environment:
$ uname -r
6.6.18-1-lts
$ btrfs --version
btrfs-progs v6.7.1

