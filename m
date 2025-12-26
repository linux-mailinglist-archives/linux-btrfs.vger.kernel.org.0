Return-Path: <linux-btrfs+bounces-20009-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCC9CDE450
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 04:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 998DE3000E8F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 03:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93CA313534;
	Fri, 26 Dec 2025 03:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAuRqGH5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CEE3A1E7A
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766718456; cv=none; b=fQM5wYbuowrB0bFHuv07F+5KW6YTnCFfeg95fHAq5217KSnepYAKoVBHoPdPWcoviOdDZOmLGUDpcDvIBiLhUs5YxszBcnuLEyBe5eDoNRwPO6QD+NSbUeFukQTZ7kRYgcEBDoFoTy4SuYDEUQ01742S0JeG0G0U3aj0rvFJrbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766718456; c=relaxed/simple;
	bh=rTkaWe1VFQripI4YZw5Fk3FIQLuNlL6grC/qAmzhpyM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=PXAsLTZhgpS2NPVtDrR13Tb+d2/rrwy7SPnpewmI2WXv0rHQD7J2vkmsnsv3KMrRuWE+sAndgfyzrzuQ/sMzGekVTKxo/aPyCyAWp4bi+0dlqLdtKzBFkLs96uKvUeQXZDgGkRPemeR4UagR9vSjmpeVCKjZizFXEqrWlDfhfE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAuRqGH5; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7ba92341f07so276246b3a.1
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Dec 2025 19:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766718453; x=1767323253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwEt+pqrKr3qRMOKPZSIX7gd8Fmb8MXuSdXQbe815aA=;
        b=RAuRqGH5TP0q1Au+2pU8SbCu5U4Ozoru++ltoX4rMBHh1aHQKKL4bCtJdPxdMG8E/N
         WMnkVIemnuJzhdXBLRx4+UCDz2i8hhQQGlX17cbNxuQCbwg0yUmapB6Be/l/u8viKM7k
         XxRLm8YuPD12oiFwZtFqw0ZIqv6FCKlmlHqRh/7/y5rpspSpI7bsChjZTeDrgsZfEdtI
         djuD5HG049igv42LwL2iybYN+v83U1wkzDX6Db3lyV9k566SwdNo/XB+JZKDLprQTh4v
         EuMWIpA+q1SyJmvIYndWaoOIDbZesOKEeyOWPyag67QDsXwgx49xW4hBcOO1VCpXS3/3
         PLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766718453; x=1767323253;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwEt+pqrKr3qRMOKPZSIX7gd8Fmb8MXuSdXQbe815aA=;
        b=DYP/owKTvEUDpRK+g1gOYYaBYneaWAfosHuJ2K7s5foLqwm+EX5FESKradvx6gMlv0
         1xn28PVOO1qbSL3Ya17iABZSgo9twWiSm73/NgN0ilM+xZye58fBXiO8ElztMNGOjeUq
         KWBptgHzwsDJo4gWFfRrGxK8Qy1gr1jTsvgqwSO1cBv97X7Vy4VRgWxw6JFRWs+pKlhF
         ndcwX7jrQT06vf3Br/dWhVqosanf2yK8PKsWynvCmEOQCXYDKqXelB1n/565VKmzHNPq
         NeajljjgQf/aEP+xtoHOTIhFYXGioYW8xjaBo0fn0zU5lca+/I2XmufajeivdShKYKSM
         fylQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCvYeIKW5nI8icd2pmfLVLSKtMvjVyM+idKYs9iHlnIXLWNkmdbYdRXNt3WhCR2Jfu/G1voPFEzK4btw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEKIrPK2/dDOzqZ1T2VsuJiMCiad7ZkBSSt/fCDiuO9B5k1mh/
	2sjUCR2htYGEct3Xq2z1OBF8NagWspaLT2k7vdwuRUfFStWRb/6L12y7
X-Gm-Gg: AY/fxX5hvcVAXeIH03L90DD6HrubqMjBJO1V0H0ppCJD6x/QyINzy3TjHFeU2kcS51t
	X8yWndruckItZKPJetXvxxW7n3XfEx9sFLdw1mFnJsBDabK/MRKxn9gI3zdPX3OubD3OnyYCkQl
	yVxws4yyGCT6nW5z2RQ5vNY6rnEYwdRLJhlqRBZR346yfECA28XY1fm+Z5JQhutivj1OHhL0nz0
	0Y9fH0p3qSPuoC5aLMqnL959JRxTBrzr4He7ws6UV91g6FOJgEgB4TB3kodRTtShCROnMS/Qeo9
	g1ylnMVU9H/VafdXx9tDntaB0VeY7r9ubq7TSeGfuh6EOePsZJOxFariTXRrE3TGT5r5DEuU6mI
	cU1DypCDThWqzL+jmqLgyDO5FY6AFk8G9jOUI0iUTJIevVbUE17C4wSKk5tO3FsPpdxH9k/bNI3
	qxIumEMc0wTuhqZgvUle22lEqH
X-Google-Smtp-Source: AGHT+IHZl9Skp7mtHYnwOXK/hm5t1amevQ82yibT90leT5edjH8lXHPecA9ldMPoQi0xfqE3nMwXZA==
X-Received: by 2002:a05:6a00:3cc7:b0:7a2:861d:bfb with SMTP id d2e1a72fcca58-7ff6725d1bcmr15788122b3a.7.1766718453384;
        Thu, 25 Dec 2025 19:07:33 -0800 (PST)
Received: from [192.168.1.13] ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e0a2e3esm20179360b3a.37.2025.12.25.19.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 19:07:32 -0800 (PST)
Message-ID: <18e6a584-b6fb-47f9-b526-4e97798052a2@gmail.com>
Date: Fri, 26 Dec 2025 11:07:28 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: boris@bur.io
Cc: kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <52b863849f0dd63b3d25a29c8a830a09c748d86b.1752605888.git.boris@bur.io>
Subject: Re: [PATCH] btrfs: make periodic dynamic reclaim the default for data
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <52b863849f0dd63b3d25a29c8a830a09c748d86b.1752605888.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Boris,

Thank you for bring such a feature for btrfs. I love it a lot and try to enable
it on my machine.

But I've get into some unexpected behavior when periodic dynamic reclaim is
enabled and the filesystem is nearly full.

[12月26 10:41] [T20373] BTRFS info (device sda): relocating block group
5214541578240 flags data
[  +0.012446] [T20373] BTRFS error (device sda): error relocating chunk
5214541578240
[  +0.000033] [T20373] BTRFS info (device sda): relocating block group
4540021997568 flags data
[  +0.008927] [T20373] BTRFS error (device sda): error relocating chunk
4540021997568
[  +0.000025] [T20373] BTRFS info (device sda): relocating block group
5606746750976 flags data
[12月26 10:42] [T20373] BTRFS error (device sda): error relocating chunk
5606746750976
[12月26 10:47] [T12072] BTRFS info (device sda): relocating block group
5606746750976 flags data
[  +3.960400] [T12072] BTRFS error (device sda): error relocating chunk
5606746750976
[12月26 10:52] [ T7643] BTRFS info (device sda): relocating block group
5606746750976 flags data
[  +3.960314] [ T7643] BTRFS error (device sda): error relocating chunk
5606746750976
[12月26 10:57] [T20373] BTRFS info (device sda): relocating block group
5606746750976 flags data
[  +3.954485] [T20373] BTRFS error (device sda): error relocating chunk
5606746750976
[12月26 11:02] [ T7701] BTRFS info (device sda): relocating block group
5606746750976 flags data
[  +4.561796] [ T7701] BTRFS error (device sda): error relocating chunk
5606746750976

I guess the condition of when the periodic reclaim should happen is unpolished.

I'm still digging further into it.

Thanks,
Sun YangKai

