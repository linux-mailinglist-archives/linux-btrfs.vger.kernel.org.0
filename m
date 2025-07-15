Return-Path: <linux-btrfs+bounces-15506-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31836B06507
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jul 2025 19:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BFB1AA6892
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jul 2025 17:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7D2281355;
	Tue, 15 Jul 2025 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="fwXESaV6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535D22857E4
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Jul 2025 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600025; cv=none; b=UE4CTpy2JOOFPK3qei8RVmyZJ32z9CFMudsNWbsC/1ixXdYL7QFttdb9C3tAVUXookVE3Ln+ReIVPmfmRC1PIjQdEo+aKf/r4Bd7lfAKJ9hcFgRU6X9Gw3OXflyjI4sKwyHOujDhUh/V/248o1Ful4yJEtUcZWOEotoQsHtjmwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600025; c=relaxed/simple;
	bh=3OfpQyQsWfpxYA8enAjfCvt9BlVWe3Od6X+AO7sMces=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m4P/y9EQ3ccCgv2h+xHq/qrv9qUH4Ap/uNIredOCVrf3eXxULlnAygXpG+esyBCxNbalp7ar5Dm+nD9t9QIhL0il1Ljrz2f9GV1S3eBoqDWFmGWzbpUlTpgnxkT4CVshbPNVMg7gpF8ubnnTIAK4xBODk/8TYghd8XVLtPfS8mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=fwXESaV6; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-73cddf31d10so2614697a34.0
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Jul 2025 10:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1752600023; x=1753204823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCx7jyloADwVkTK/IrgCQXMmqy31BE4J8IB/VEK5Mhc=;
        b=fwXESaV6tz6nsLEjAi0mORDIpQ1wYI7pvdBvAw9FH0QxCZNkXKasCJb4cMOzwSoRKx
         MAbG5mPmIkdswyxjV6L7R3ZcSAet/GxXuMhHzPOlwAhNEIoTwKzs9qjGBoPjA4DIRTMY
         gZj/YIbOEOC+HW8goDl+bQ7TGXHx4D1872TfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752600023; x=1753204823;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCx7jyloADwVkTK/IrgCQXMmqy31BE4J8IB/VEK5Mhc=;
        b=xOF9dxiGufQmg93HyYxImg1SgtQa/qqO3Bzf0F0D8wA4DtvgNBpUeE1vtAreqMcFjI
         uRzSvzgl1lWBSYSTwPm9AzIVvZqsp3b8o58VfFoWBU+DNy1QimHYJhAAV+EqWV7riGzc
         Zbm9D5ufVWqzAyEx0Ggxp4L4S+hUTWj7zg/rVqTk7ARdGQQ+vw8tFBVy18x2Nzwg3qHW
         QQQ/fJu6LPT2NYphgc5VbpTf9gat4PLmSA/xc9VM4zqbyGojVQodpQAeAYytijCS3rnr
         fshZa04Qe8ynC5ukIee5A0Th+LLY+I3klIsr22ZKBx8pGTxMBLAWdADe5IEOMD3Ijlh8
         FfSA==
X-Gm-Message-State: AOJu0Yy64f9hrDg6uC2KnknQsmIU+5CfpkhXpHM9EgEoKN4vu9Lo4/Cn
	xd8G1K12S8Xb64yoXPFwAllvO6z9jouVhNj4yXzXK7ANfk2JrXGNXnqn56V3FrHFw9o=
X-Gm-Gg: ASbGncuvTJntMXpDCbS/BT/SszuYwLSb9R63gPJElxzp5Hxb7YHYXKt1/Ic28XZuZF8
	vFoad0z/ObcpOD8ervjPdnL4wB4mH0PasfueHh3LTzCsOzqM7A6Gs0z/TB94rTCKWFb8nkHwoS4
	MhqJ8yCgDbipjydaAGo8C7ARxpfu7W96FJYuY5ZIm9cBxpS2SGQn4TnacpYfcyVn272MMFs2ZxN
	QcvfyjNpmKfEbhQqo6gUMSMQ/8IeLhBKBGf3YYpF5adRMAHZ/C8RyBCb1AZNR858NNfrlbJv60i
	Q68lbRkyB5A3kENt4SOgOVpZZmFEExaV/ogKezJBGnboi8rN4eRcNWNm1UYFPxYtjeCfq8HfcDz
	4fRrm47JQ2wSEMzC0nKk2hL0DgQI6FDzRmdrI58591hKSf/eOgZPgKeM=
X-Google-Smtp-Source: AGHT+IHbWezEF71HyPAl+LlhtKpaOQaNMVoR4HlJjU1lZ8XlGWsGWkaH+x5YYO90TiKLGygri7EWhA==
X-Received: by 2002:a05:6830:3901:b0:73c:976b:6c93 with SMTP id 46e09a7af769-73e64acc272mr289014a34.21.1752600023367;
        Tue, 15 Jul 2025 10:20:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6142b0961fbsm988894eaf.35.2025.07.15.10.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 10:20:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Qu Wenruo <wqu@suse.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
In-Reply-To: <20250708-btrfs_fix-v1-1-bd6dce729ddd@linaro.org>
References: <20250708-btrfs_fix-v1-1-bd6dce729ddd@linaro.org>
Subject: Re: [PATCH] fs: btrfs: Do not free multi when guaranteed to be
 NULL
Message-Id: <175260002232.441891.16749455238616845799.b4-ty@konsulko.com>
Date: Tue, 15 Jul 2025 11:20:22 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 08 Jul 2025 12:34:49 +0100, Andrew Goodbody wrote:

> multi is guaranteed to be NULL in the first two error exit paths so the
> attempt to free it is not needed. Remove those calls.
> 
> This issue found by Smatch.
> 
> 

Applied to u-boot/master, thanks!

[1/1] fs: btrfs: Do not free multi when guaranteed to be NULL
      commit: 9204cae0937c0e26fcff1ee08e51ef37f59844fe
-- 
Tom



