Return-Path: <linux-btrfs+bounces-533-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6DA801AF6
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Dec 2023 07:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D76C281F5D
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Dec 2023 06:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D0CBE58;
	Sat,  2 Dec 2023 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZ8jf5IQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4491A6
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 22:13:06 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d7fa93afe9so887742a34.2
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Dec 2023 22:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701497586; x=1702102386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hfc42TsC9WL+rTg3FMz8YdSwg0JL9tHq6g4Th1omdrk=;
        b=ZZ8jf5IQj5fHta/LG1uqSTofSvSWslnad6T06+iEFT63MCp5/OQqlrCHFoF4QxukWT
         qujWfKZ/nEh3n/ZSYlLm/lVX+5ppYDDGXzYnmMbCC/GCqNg4mfWHQgGo1rlgwPbuRab/
         pYYt0MRQvgY6OOEkyei4hLV0+0gIk5Ej2ut1R22B9e1irzawCyOEhPon8gzIFfzuSc7i
         g717WWu+nY1Z4ClX2XSb9bmkXiP/AUvvJ2ubUV2hatJR8yOJTeBOf2F8vBUt+3PlLW7M
         IEkOhM5K7IdTfX7SNpZ+4LirZTPce+DlmbRifng8R6Y41RLxoP9INIhWAUfDLC9s81Av
         gmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701497586; x=1702102386;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hfc42TsC9WL+rTg3FMz8YdSwg0JL9tHq6g4Th1omdrk=;
        b=KfmJzy1d4U2OJRxCcLOPYIVq9pNzszuDd22Ny7gpZSaLbidL17tLIt3xKfhXN/zyLO
         DC+HeJD3XYu/hEvWN/WJbkdSJRcYCEGeiIVbXLXU37GiPx8pid3ItoowKMiVNdk6yK43
         fVlbnNoD1KoPhXDeiUPVAT6lMZCLAyn7Z/r9Pqtg1gxoDDMOj5Lt0NWwfNo50fca3fXk
         o0bxmW3b0PBIWbCDUDf1JJ/IZRoJ9ExGdbegiwwraBilb2kZXfSAihag8KN7P4MDjSLO
         8cfZHeFgxjRqbBNw6HDb7uzNbAQTAzuUa/KrlSJ+3EF7yLIUJhKHctBE7dMaelqk5XWN
         vN9g==
X-Gm-Message-State: AOJu0Yxj7xklUtZ9uipB3jIo5mPwZ72ErDCeAwphtr2rpG+b3NbKZrgp
	Jx/5vHfuHZ6BvPEhbkPKgX6kUKZnGNA=
X-Google-Smtp-Source: AGHT+IGNb7mAEo17ERMIdp47Qpxm4RDhWrf/MulwOdhU+HgCbxDRtZ0+xDZR1RoVFcf2K8u8lC1lMw==
X-Received: by 2002:a05:6870:970f:b0:1fa:e05b:3255 with SMTP id n15-20020a056870970f00b001fae05b3255mr852275oaq.38.1701497585568;
        Fri, 01 Dec 2023 22:13:05 -0800 (PST)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id na10-20020a0568706c0a00b001fa54ae35e0sm1182945oab.12.2023.12.01.22.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 22:13:05 -0800 (PST)
Message-ID: <8dac2b61-0a42-4416-9477-4cecc1b0eb06@gmail.com>
Date: Sat, 2 Dec 2023 00:13:03 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS corruption after conversion to block group tree
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <eca4d15e-3ac7-4403-ba5b-a3148eb6b443@gmail.com>
 <e20c7d59-c460-4236-9771-9cb4a3f9dfb2@gmx.com>
 <1b32a750-d464-49f1-a288-577ee2fd473e@gmail.com>
 <bf4ee7ec-ab90-496c-9117-b13a096994a6@gmx.com>
 <3b55e499-791b-4f98-9ca3-0ff0a218c0bf@gmx.com>
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <3b55e499-791b-4f98-9ca3-0ff0a218c0bf@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

To be clear, there is no reason to be suspicious of the other disk that
was converted to block group tree and has passed a scrub after
rebooting? It should be safe to mount that one read-write again?

On 12/1/23 22:25, Qu Wenruo wrote:> Just one more question, is there any
hibernation/suspension involved in
> this particular corruption?
> 
> I have seen exactly such unexplainable writes-from-future cases, which a
> lot of them have hibernation/suspension involved.
> (Thus personally speaking, I never go hibernation/suspension on my own
> devices)

Neither of those, but the affected disk *is* set hdparm -B 128 -S 240,
which is Advanced Power Management set to the lowest-power value that
"doesn't permit spin-down", AND a 20 minute spin-down timeout. It's
possible that this contradictory combination causes firmware
misbehavior, but this configuration has been in place since late
December 2021 and there were no problems for almost 2 years.

Unfortunately my notes don't say exactly I combined no-spindown APM with
a spindown timeout, but it does for sure result in the drives spinning
down after the configured duration of complete idle. Judging by the data
I gathered before making that decision, the reason was probably that
APM<128 gave different spindown timeouts for my 4 assorted hard drives,
and there was no way to discover the mapping of APM levels to timeout
durations.

Needless to say, I have reverted that configuration and will just live
with the extra noise and $20/year.

Thanks,

 Russell Haley

