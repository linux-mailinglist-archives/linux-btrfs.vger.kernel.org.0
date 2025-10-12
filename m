Return-Path: <linux-btrfs+bounces-17640-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE666BD0091
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Oct 2025 10:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E8A189402B
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Oct 2025 08:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B14258EFF;
	Sun, 12 Oct 2025 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9sCTBmD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD323AE93
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760259198; cv=none; b=Ia+xPvKQUDfYDC+KwPmwJSYsPwpTGqtg8l0+NrnkQl6q6lvaFLt7R0r79umSMMcN0nNSMFS/9Xf3XSmaoaf8zdWFoE1FAwoN+kuOfMgk8izQn7xintq82VX+xQbdv1hILE70Vi7StTu0Gp95W+q+D0UnAjSseyiMAFdD2nloyFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760259198; c=relaxed/simple;
	bh=tJcqxXmf2ZRGBs/ueoYm+qxucmWxsaMptOeZizXlmFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQc+u/PmYTkUSQwOp+wyIrRMlAfEhvdJIaiEsP1PFy+JM46maLmQ4vJWyB4wGvNztTcgaYzAK0xRxp9N0A65yHoiKyNKZGShLaxAiPGEl9oI5qBoAUX8Uq5Tu3fKgkCRMwdaIXtZfyrFoLMZ17e4cmVcPbsIitMLiqc1bV1dcEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9sCTBmD; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso6397675a12.0
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 01:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760259194; x=1760863994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zH9VXZNUll2F6GhihCpF9/maubEdscpHX7RWYO25Us=;
        b=U9sCTBmDtR1qi8kys2Si287vE+kb3od+9/ONn/fjCdpfXdFMIcxZd7Vb0J89FSXNTR
         PXe9qRwmJ4dYAJuvgnBVxPx09cWynq4ozWp9OMhvAYgh2xFxzf9+y8s5vtRP3JP0vf80
         MGjxOrLRHQwPzqmWXTf8xUnwgeA89Lglg+eVVms1pN0BZk717O5QFvYBjaZgiFZ/Fq8h
         mzrU9lGdrzTHZHM1wo8P8QE1IBTZjW5n/ZLN5WP1iDMhAO1nzsDm02DWsy09lt0kZNmN
         2ljglWyAlPYMNUte5+BG48xgGzvcrWBR5HXx75IGdk1hqIQxtIA/tOnUBQUMheZ/ss8t
         Rovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760259194; x=1760863994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zH9VXZNUll2F6GhihCpF9/maubEdscpHX7RWYO25Us=;
        b=kEMqEeRDl5qtWUE73q6WuevMwO4wU+wU3eufgWtzN0QjF0cYCyXlWv/h4YUouUHegN
         +tOyHdsedtqnWKlaippE7FGjOJyo661ZSlcsq00UM53O4Qa0GWKegjC143Lq7uxNc0Ea
         6wG742+55z2b1OO3Um6ooskDHHGbikt3zsd6UJvnHU0U6FAJXy5bddanYmt6Iic0YSa/
         xkE+9OyNLAMWKPCtA73HN3xJQM+9SPMi/sfefH73lPs3pyQTjxiAbG2ct4peMuI7ONB6
         op75wzY05CfxE/QyNGhDGaOl/h3aXIbxGwwXwtbnwdYPYY4aMAXFgo10lVxIWiJiqtZk
         JcVg==
X-Gm-Message-State: AOJu0Yz3VcRA02XZzekpzOVq60rv9krOlzv2thFAFhDtJFRdD1RU4BJM
	MToI+B0XRXOcC2uozYp/eDLywQF8colgb/7IFapTCdxqGUmIkRC1gYimV6Kr7Q==
X-Gm-Gg: ASbGnctxtJHGpU6Q0MjMmQS7C0OvIXmX4wwCcrgqJLu8ibb49RCFSaIapAkipVh+/EG
	E+m+4f7ahYPeXSbp1CygzFsC9opNWlGcTrtOI+67QXV4gN1uCaXf40JL8sQctaXU+Dsy+cqh0Ej
	nb+hEUrTyDtGe43wpjkjS49r2N6oEEIxwASRcuE5i/R0MFmiG6d3OSAQhvgS7xij+qFul9q6Gqx
	HoyfCwScsqeQsLQFlcRJpN71LsirohRAwinBPu44zzItKq6yukbSa/x8dwgTPX7pq1G4HJxtEW6
	iS6ITYqZOCqA6e9imJvJIBenPmnFl8mLLvca0IQZ6zU6SsY9Z1kERA0g5pohnHOZAxWqPxIBaAo
	lfJhRuUoz+zyAQGXOj52ExS3vwOmIghExjwPWuvg=
X-Google-Smtp-Source: AGHT+IHMq+iByIyxl+0KQzrt8cac734lVtH2EfgTQWgHkPcOOWOJ9HU6nCGEWUKdDWiEhs4l3ID8ag==
X-Received: by 2002:a17:906:c150:b0:b3e:6091:2c7d with SMTP id a640c23a62f3a-b50aa89b304mr1958461066b.27.1760259191386;
        Sun, 12 Oct 2025 01:53:11 -0700 (PDT)
Received: from localhost ([87.241.144.20])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b55d931d806sm700656766b.71.2025.10.12.01.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 01:53:11 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: lists@colorremedies.com
Cc: linux-btrfs@vger.kernel.org
Subject: Re: 6.17rc5: btrfs scrub, Freezing user space processes failed
Date: Sun, 12 Oct 2025 11:52:56 +0300
Message-ID: <20251012085256.8628-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <d93b2a2d-6ad9-4c49-809f-11d769a6f30a@app.fastmail.com>
References: <d93b2a2d-6ad9-4c49-809f-11d769a6f30a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Chris Murphy" <lists@colorremedies.com>:
> Scrub initiated, walked away,  and when I come back it appears hung with a black screen unresponsive

I suspect here is interplay between two issues.
First is btrfs kernel bug Qu Wenruo is talking about.
Second is systemd issue, which amplifies this kernel bug.

Systemd bug turns simple "suspend doesn't work, but system continues to
operate normally" to "reboot is needed".

I wrote about this here: https://github.com/systemd/systemd/issues/38337 .

The bug is fixed in mainline and stable versions of systemd.

So you should just upgrade your systemd. The fix is backported to stable
systemd versions, so it should come to all stable Linux distros on its own.
Suspend still will not work if
scrub is running, but at least your system will be operational after
failed suspend attempt.

If this still doesn't help, then, please, tell me your full systemd version
and distro version.

-- 
Askar Safin

