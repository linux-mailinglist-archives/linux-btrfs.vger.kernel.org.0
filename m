Return-Path: <linux-btrfs+bounces-20000-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBEBCDDB0C
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 11:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF60C3046ECE
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 10:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28BF31C58E;
	Thu, 25 Dec 2025 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mtkap2yW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7631A7F8
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Dec 2025 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766658984; cv=none; b=hrNzfqou/d5GPnOt/tUnuuiqQrSyotsRPDEvkWaqsRCAa7VLqvbROHmS1sufbZ5ZteO3n21wwRnHkFFZgkNwJ5pamNFGcaLXv1l3+sg1ORq3eMhm0H2lgIl08OiWQvyaZiiTUfb1gbcVSNpx5zeZ1U2o/wZLAiJ0zLFJ6gfnWiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766658984; c=relaxed/simple;
	bh=lNSbt0u/gZghOeU/fe5iiQaSinBfTtPshvxOYvB+iuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tMUIWC5rhhKIzU8RCCjcq0v1cnhIIqFOcJSsUgCyPrgyveI9pzzRhL2AlH/wwLNooFrqU3cMs8YdrU0SJC3tczVspTiBZ12crd5zXmqjyMt4N37tZ2h+mjZ2EYYs39issu8uZRApVv0qIlBOiu1N54zaVj7RFPGRXlItaCtHhI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mtkap2yW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0c09bb78cso47418965ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Dec 2025 02:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766658977; x=1767263777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4TbfVgNyXB/XUtAQGmdqnGShqOTHGFrEbiVxzdYz4RU=;
        b=Mtkap2yWkyJiZPuMgA0iTAcRsA/SV7XLapG0fSF8tDmMzK+3GNEYAhkLSiVu9hEvyZ
         JIlTz7aFKn0ul+Kuk7kTu1bbLyoH+6ubjoCbJ+NAt2YGA4aA682vZNqkx2AfJJaseHC+
         cr3BsMUa+Rc/q+Z7/5Mxjx7Eexr5HoRlrczaQCz5mobUg42kOaWjSNVIL2taK7gRDeaL
         febqxVtmom6HyOLv2SKy2CblfMrhmuCr2UbSf622TYmdam0YI8/dHeB15nQzhK95BPY8
         y5Y3CYuU5gfJdOTpQNdQiS1f8wCSHiBdsNSuWgJXs3r+d2USWWDxGSvcI8ggoT5FbtCI
         6DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766658977; x=1767263777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TbfVgNyXB/XUtAQGmdqnGShqOTHGFrEbiVxzdYz4RU=;
        b=ViKFflyEb+ZBN2z9c7BPIyRiMvH1h5CrSHnjyxf0Rv55/AToa5ZI0rC4Bfvz1btQlx
         E8EcGpNG+PNHFxX/HJ8/fCsRlJoTVumNspmbGSir8pBzJTvtzB9psZaHkSHwfHoDzZFm
         Ze1ylbjgCrnuvSER1uyMk5iI6QzE6TNT+YLh8lmTnoKHH86kUQcjX1rNMy4JHf7UCUUh
         OIlSIAICn9LaivMwlRuMMeBoE/+hgI7frqvFtT4anFlWeGxnGmHSnSCobFS1Za48qRb7
         Sy8ryQMt59/okEguFYueY9+Bb2URbxjHg8HMSyH2zzlHLH/1KwoePDA+MAF6kWCMyNfi
         IQdg==
X-Forwarded-Encrypted: i=1; AJvYcCWsYh3PcVZ2jVi/MdDXFDQIoe+9epnxiOHZrUqybAZVC4GO95Z1etbb1K9V09lqziLq0pHIjXW4Ci/dfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFoHwNZxDgJCBTvaC8PoQaiwI9ewSIxiv/QTDPHR2NOW5PMzs
	/X91q35R3V5vppgzd9HGIMs3lxB6EkV465PY1Xkd7dUfOm1jpPtLIXX8Kxjaw0E4
X-Gm-Gg: AY/fxX7As/CkKmxvzOgAMJKvuZ3vQ9khY6qwKYBSJDk3N0xINF3gIAmVMQPPPA+NNeT
	cD13pmJYcu4HGrjPxSFcV8dCwQDDR0s0XaeFbPshQxmybKpa49z1cqL0B+rzh2PX/yDERjQS0v4
	6xyN/CjqZ/hRKS8YO/O4pKjhO2wc7ONlf918t/WEg/thaU13mU1Qum17mjWcZpEvM8WLvUSct8y
	4LO8O4MxHI9bsY3TG6jt5dwjaR2V5MS9/+3GzJwj9Z8VGtRF1CPUedkpPU9Ai32lUQv4qdiJ8Vg
	PVcJgg3IBFW9gehmVC/Z7D8vPrc+XVS53GpPNDNuBBMiGyJJ/P2dz0eRLhupdYgCXWW9V97imNG
	zr9GoQ9Se7/EyoKlJUF3J+ipGmFoQie+9oIasQvkqJPFsnZy1LsVvO1765OGfs4XJ9BXhEz/Inr
	0CLrs2GR/DZ9hSit8=
X-Google-Smtp-Source: AGHT+IHexr0TBG3Lf12i3N35SIWIo/7NMxI9To9FUzahjKgxaPyd5wE6QKKQgioQ845NnpHiYRsm2w==
X-Received: by 2002:a17:903:94c:b0:2a2:b620:12d9 with SMTP id d9443c01a7336-2a2f0caa70amr256856685ad.5.1766658977253;
        Thu, 25 Dec 2025 02:36:17 -0800 (PST)
Received: from [192.168.50.70] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66473sm155403335ad.13.2025.12.25.02.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 02:36:16 -0800 (PST)
Message-ID: <5a733a1e-dbc4-4761-bc85-bc811e8fa195@gmail.com>
Date: Thu, 25 Dec 2025 18:36:14 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/131: remove deprecated v1 space cache
 tests
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org
References: <20251223073939.128157-1-wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251223073939.128157-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23/12/25 15:39, Qu Wenruo wrote:
> Since upstream kernel commit 1e7bec1f7d65 ("btrfs: emit a warning about
> space cache v1 being deprecated"), v1 space cache is deprecated and
> we're considering to remove the support soon.
> 
> This means soon v1 space cache mount option will no longer be accepted,
> and the test case will fail due to such change.
> 
> Update the test case to remove all v1 cache usage, so we only support
> two cache modes, either nospace_cache or space_cache=v2.
> 
> This also allows bs < ps btrfs to be tested for this test case which has
> no v1 space cache from day 1.

We need testing space_cache=v1 for LTS kernels for its maintenance.

So why not duplicate this test case: one for kernels that support
both space_cache=v1 and FST, and another for kernels with FST
support only? Kernels would then either run or _notrun each test
case accordingly.

> -mkfs_v1
> -echo "Disabling free space cache and enabling free space tree"
> +mkfs_nocache

> +echo "Clearing free space cache and enabling free space tree"

The message should be “Clearing no space cache..”. ?

-Anand


