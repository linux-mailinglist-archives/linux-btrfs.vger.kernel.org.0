Return-Path: <linux-btrfs+bounces-6996-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5587D9489EF
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 09:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E0B1C223B2
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 07:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1F01BD516;
	Tue,  6 Aug 2024 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RalcTiT9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A1B1BD4F6
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722928755; cv=none; b=OgIMPFe6QxhMaYJrdU8y1+kjKAECHt0CWz73FLH+tvQC+Q2ApNGpqLmdy2IbpRxzF3NEaHzpO/HDniLQQjBM+5MyAN4he7xyFX1M4vEkhC0Mt3DUCbNkDiMa/MWW4SC1wRPpACqVhqvbOtKCybvxTApZovzQQeeqhaYHWCRAgmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722928755; c=relaxed/simple;
	bh=LRArygLbftRd3xkg2FV/e439XhqDfMc10wqBgBPwTA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OD9SHLRIDY27uPIdYOjcQpy/ZERpIloteiX1vTIK/1H4n7QSBL1Rk1qYliahuADlj9flQAC27B0kv/5WlHpR8cINXB64QUgQ0JpuMi6DjzRuTxS6VCw6hn02QHTnUI5B50kmA57NilJshIiILuLdyhwaScNN5GuPEcn94fU5uDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RalcTiT9; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef23d04541so3775931fa.2
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2024 00:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722928751; x=1723533551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:mime-version:date:message-id:sender:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LRArygLbftRd3xkg2FV/e439XhqDfMc10wqBgBPwTA4=;
        b=RalcTiT9YUGLcfJnVYRhtfW81JMbRCt9MI7U59MBhSb+wJlAv7kNrJ0hzt1Cb18S9K
         jnAUFQ1CQICw0p2XTFNz28NG3yHRI4zQNxKFObhi4EuL1csVm6L4qjc91Cl3YMpIDfKm
         F6M0cAhwrmBunjYpoedUavSbF3GM90+PRBttOVTbFT8VKaIkf0eOhQ0fgfimJBbwFfBy
         nrOjVdzhvBcm7Tvj4Lr/qy+UkcmUI9ZH608pPce6bOmab6f7v7iVqIRboo6TSZmqcZ+4
         7xjlirnjm5y7wcqwfFY+OWS93c4rf3+qtdeH3bspQ6JTLd2p/p3KWsVE2WWKGxBySir0
         Ajtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722928751; x=1723533551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRArygLbftRd3xkg2FV/e439XhqDfMc10wqBgBPwTA4=;
        b=AxyP07zQnfnb1OahfTSg8aH/H0W0z4IrVHTMIQka4bRlNYkf4ieje9qFy76TvSuQ6P
         jTFkltJWZzzqN3unbsgsXfGxSddR+8TcgUdDmquYR4q80N+NWZWmGYmnRMt0gEhshFfv
         Of0HWrs+FdvM8xX5j9AkSa9SS2YVecKQYoML8rCmNl/WAHcrciYYRVgI+EvrmMFjazJn
         cAt2y+mTSOBdVjqFJ/N3b6zD8SSdejUsWF9/G6RluGGtBnK/yi7/Ix759NzL5BRi1f+2
         Tk5KkjiyPmrYNccuoZvyjRfKXndyaBo71ur2ekvZpowwrnwp0bJ3RXCQZfJicvhpzFS1
         AfEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuewOggwIxmM4bp395IiWDIb8qSiox6tVpZbnjwrTndoiFl/ucXgwBs7lgSHyGeSKBMGQF5G/iH3oGqy9+vxnbptElZy7g95buEP0=
X-Gm-Message-State: AOJu0YzqW9ey130GvDbLC45HfuhOD5bwedLCn65aStaRf5/Sk5UWIT+w
	FwjwfdrbnXy7a0iZGQ0jr/L0J9qd8aZOUXRX9bIR5eIMV8VZFLeH87elxQ==
X-Google-Smtp-Source: AGHT+IHpFOIZbFa4wGTlfp5JGre+V7UPLok7d9gcZ3TilKKZSbys9KTZe0yKn9+3l07r+3DXuIxhoQ==
X-Received: by 2002:ac2:4e14:0:b0:52f:cd03:a847 with SMTP id 2adb3069b0e04-530bb3a4f47mr8098458e87.61.1722928750891;
        Tue, 06 Aug 2024 00:19:10 -0700 (PDT)
Received: from 127.0.0.1 ([94.41.86.134])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba4a4c9sm1391920e87.298.2024.08.06.00.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 00:19:10 -0700 (PDT)
Sender: <irecca.kun@gmail.com>
Message-ID: <837fb96f-989c-4b56-8bd4-6f8fb5e60e7d@gmail.com>
Date: Tue, 6 Aug 2024 07:19:09 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 'btrfs filesystem defragment' makes files explode in size,
 especially fallocated ones
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <d190ad2e-26d5-4113-ab43-f39010b3896e@gmail.com>
 <7a85ea4e-814f-4940-bd3e-13299197530f@gmx.com>
 <90dab7d5-0ab8-48fe-8993-f821aa8a0db8@gmail.com>
 <0f6cc8e0-ab32-4792-863e-0ef795258051@gmx.com>
Content-Language: en-US
From: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
In-Reply-To: <0f6cc8e0-ab32-4792-863e-0ef795258051@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/24 22:47, Qu Wenruo wrote:

> It's recommended to go the default values anyway.

It's for testing purposes. As you can see in original message, it happens regardless.
I simply noticed that increasing the threshold makes the problem worse.

> Mind to provide the kernel version?

Originally reported at 6.10-rc7. Current tests with 6.11-rc1 and 6.11-rc2. Still the same results.

> Is there any memory pressure or the fs itself is fragmented?

No. I tested it on multiple machines with lots of free RAM, also tested with like 99% empty disks.

Could you please try it yourself? It is fairly easy to follow the steps.
I use 'rsync --preallocate' to copy the files over (and maybe call 'sync' after to be sure).
Then run defragment on them and see if the problem reproduces.


