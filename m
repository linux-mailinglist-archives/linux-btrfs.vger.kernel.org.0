Return-Path: <linux-btrfs+bounces-1568-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A8B832A8F
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 14:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807681F23C41
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 13:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE24C537EE;
	Fri, 19 Jan 2024 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF7YHfGK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCEC524DC;
	Fri, 19 Jan 2024 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671249; cv=none; b=R7furtsdhqZFjZUYd66ax52ZQy5IS5ihCFMQcTA6FegEz//8LD0cAC+4KGHLHr9iz0WKWZrVM82ayuWJseoAyqqEicQjRwUeuHDhqAlZkX/Ko5MFdFs/nsofTI2MzYUG5pkcBl/BcOHHYqJhmHA+QJvG5Wqz4oqmXvSX6pgM52A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671249; c=relaxed/simple;
	bh=UBsHDqO8tKLqiQ+CTMYG+UCcxV5ppDhinAhgrXTQroQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVzmIN2k+E6phiyyzflazYUGmvc5ddRI3YoLBlLlF15XMEr1z5y57PaRxZGK1yXw8mE0GPgOrA+jyFZpl02Tlvenzo5Y2t6XGYILFLgEMIqTqYZ44Ppcizi3iZSw7blTGuzCWJxIbaySK1lSsvfht+x+SzOsp+V8OF94lbKq+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF7YHfGK; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-290483f8c7bso653343a91.3;
        Fri, 19 Jan 2024 05:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705671247; x=1706276047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IEtuowdYcENMHjoePZzsx4gwz942S9hCHH4g6ErNp7g=;
        b=WF7YHfGKUFTlVFIms46n5qlXlOsgA99j9fp8ifH2nTy2ZbkOADciQ8Oo612iFm2u7N
         Blz52+vRY1mvJQJZK6Wf2/cNDz96ioCbgY2e/k52xUUWNJC5J7bOwdn0YPfXP/+zlbdy
         KyhBC77VxYZCZysGBwfFSrFoZnVzv9VfRqea5cED1PCsvaZHYlBz7tEjUvG35GYnxDvm
         x4sqXBVyrTC9FP01EUlQwbe2ojzoe+VMQCw9p0W/0YbQSa2aokQow2E0hm0eQ+qG1dmu
         gMJBmg0BI7Mg4Hr4T7kBY+Ge4yvwgZlhi134kyS39XJIhotHtncratoJoIh3Qjuzi/X+
         MMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705671247; x=1706276047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEtuowdYcENMHjoePZzsx4gwz942S9hCHH4g6ErNp7g=;
        b=Ggv5rZVbBTKlOHxrKZH4edXip2Yj6IXB5ChhvFi7Tp/gOeCctXQaX2x9btE3RaBXsa
         WAWnjZJs06ZmyN4so2Lm9XEAaNfCIKu0dGijLO5rfvSH63h5Qx79+5EKwEbcycb/Hy+z
         EZNlpiHIjI6dRjQWL7MhJ58ke6mLIO5N5rI6y4VEz8MD40X6jculVpluAp/whPjbEyKI
         pdSYJl+OPzaDQ9rczi7byfuPbC95IXh+3hRfwTxuMNeZ3tD+szv74tupJS1XZthIQSKz
         W8i6aH1rLcuSQcKORfuwASJWywTgmJHJscxfQaJYzEFm6SKWRT+Fm+Sd11dfbiF7A5xf
         a4pQ==
X-Gm-Message-State: AOJu0YwoThhzz9WuB/FVmR1qH1dXA0EACsg9WohAgN5NJY4deIGV2PVY
	9iaAc5eljqvuQT6WEIsZEYWwU+1cyJKNvBK/7lpNvJlu59hEBWd8
X-Google-Smtp-Source: AGHT+IGAFLo9KRH9q9uNiFVsZuGA+bSjfWZPxWv+9VoYLrjeP72T0YBjj29Ii48OuvZrH22M0zGI1Q==
X-Received: by 2002:a17:90a:6d43:b0:290:4e69:6a2 with SMTP id z61-20020a17090a6d4300b002904e6906a2mr606173pjj.82.1705671247143;
        Fri, 19 Jan 2024 05:34:07 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id v20-20020a170902d09400b001d70602f561sm2867025plv.1.2024.01.19.05.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 05:34:06 -0800 (PST)
Message-ID: <48691b8d-1710-431d-ae8d-398ba1482de1@gmail.com>
Date: Fri, 19 Jan 2024 20:34:01 +0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Disk write deterioration in 5.x kernel
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Gowtham <trgowtham123@gmail.com>, Linux btrfs <linux-btrfs@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
References: <CA+XNQ=j6re4bhRDUebzPLDvMtZecqtx+GRRPgpd9apss+vOaBg@mail.gmail.com>
 <CA+XNQ=hGxYsMAo6Gc+Up5QctbWjkER17uK97YXWc9uyx_7+3uw@mail.gmail.com>
 <ZaodrO8QjCqSXPHe@archie.me>
 <02c0a0c9-91b7-4766-9c15-8059b8e7c09d@leemhuis.info>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <02c0a0c9-91b7-4766-9c15-8059b8e7c09d@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 15:55, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 19.01.24 07:58, Bagas Sanjaya wrote:
>> [also Cc: btrfs maintainers]
>>
>> On Fri, Jan 19, 2024 at 09:37:50AM +0530, Gowtham wrote:
>>>
>>> Is there anything I can collect to debug what is the problem in the new kernel?
> 
> From the version numbers you provided it seems you are using vendor
> kernels containing patches. You thus might want to ask the vendor for
> support. Most upstream developers are unlikely to help and some even
> complete ignore reports using such kernels.
> 
> You also need to try latest mainline and bisect, as Bagas already
> pointed out, as that problem might be solved already and might have
> nothing to do with Btrfs at all.
> 
>> Please don't top-post, reply inline with appropriate context instead.
> 
> Bagas, FWIW, I think telling users this is not helpful at all and maybe
> counter productive; please consider to stop doing this.
> 

I was writing the reminder like broonie did.

> Yes, kernel development uses inline replies -- hence it's a good idea to
> point that out *to developers* that submit patches et. al.
> 
> But most people in the world uses top-posting; you and I might not like
> that, but that's how it is. Telling non-developers to adjust their
> behavior to our habits will often just come over as rude. It might
> nevertheless be worth it. But it's best to leave that decision to the
> developers that handle the report, as they have to interact way more
> with the reporter that you or I will have to.
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara


