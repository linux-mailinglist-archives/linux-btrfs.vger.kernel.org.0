Return-Path: <linux-btrfs+bounces-18383-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81273C14768
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 12:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C18468177
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 11:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE467304BDF;
	Tue, 28 Oct 2025 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChnWjv/0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F7230C37C
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Oct 2025 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652210; cv=none; b=hX8tdKdPZvwM+zSJYIjSXisFpA4rwiDFZ8p53yJbdNHHWBaQpEudL543+jOuPZa2qyVbTKyyhw6ZHaQ+1dxRKGaCc6C6JzELsld3xlcAjsf+S3OP2yHbKlwQQFMZs4NFaWxdoRQ2HB60N8cnbE3BY5PClj1WroobzJWFsFarouk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652210; c=relaxed/simple;
	bh=dU4zVFHKW2O4QpCbJtTeOJxYp+cQxgc03lfH59F0Ox8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=raCA5UQh7P3FaVYMQYkz7BmdbmoDmTfVt//2lGTxb+cJGjRUvi9I2W1vY36W12RsloHTlMhLZgTqF0ccJZXa5ULJW1SLT+x4Zj0hVEfl6jahzUmXMwcJGDdvJ2d3l1vyBW10UgKKjgl4BrDdioGaxgmeBK3IdG4HbbY0wkp0am4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChnWjv/0; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b5579235200so4111442a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Oct 2025 04:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761652208; x=1762257008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dU4zVFHKW2O4QpCbJtTeOJxYp+cQxgc03lfH59F0Ox8=;
        b=ChnWjv/0JuqPzHXfJOz//zQvwNYUNA1aZjae518yz5Q4AYhQ8VNHbzWAtFussbWMXa
         RshpvQEwcAkjhtUOKUEv10kTr37jCyPuwZbujqe4MVBjgCcxiI1UNefXN+/ZvkW20gw+
         7I1b4M5ezSeR+SF7vWgaltbQ/+p7hTXUlzr9GrFDi4PZKODcY30rND5Ge236ARc+GRNy
         n2XEpxs8DA7Gbv3rp7At2kD/HtAAaxEuFdZKRT1Wm+s1uNqXRVStLDSbQvHDj8RSQBAc
         KmZG9I/Hp7bW2uqj6MLov7IKhn+7+slEhyfBQQYrHjrIR4gZTI+tkT78NoC5mtnGpvIW
         iePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761652208; x=1762257008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dU4zVFHKW2O4QpCbJtTeOJxYp+cQxgc03lfH59F0Ox8=;
        b=hHrhy2gTVoQ9TQPJv/hJ3L50Xxy0k6YNxo7dBk+CgKgFiSnW8GqdBCxoBvd/z+sJi5
         2M2/087+A4b3OPkqI7cLvbGFQFpcYEHBSfCGYAHQyenYK6EZ7AIQ3aY1RCPCf6EsVbrQ
         NIsxxr6UHT86A/t5N4APLq/iBnuw7OHeCw5b38tn2JGjB+k64opHV9QHpfDbpxDTL90n
         skNrESA5BkrXbzZYu6C3e8HPQn12O4WplDy3j0kbJgoptJ5lJMGurmPcWd7kpAYjEBz9
         oKYZKNbxXdEQwecpRE6MZSvneCZrad4t8WCBFL2BcQkvWc0lE4lZiu3wMroZq4/61RpK
         pDhw==
X-Forwarded-Encrypted: i=1; AJvYcCXY5fRZUuCvUspULRsiGL3EypZR629bfU/xE9RaIPz8f/5Vu+2HiEXT6N3cR2ruHne8SD55JKu4mP6E8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQSZuy0DBzPGOTacgIY1NC1z/xOrBr9Z76GxPq/DCrD6h1Ezc3
	5/45ybFDf8zqPMCNgWhc0jx71Y4Ad0u8XeHdaheuxGBEXnLHBHbIvtyJ
X-Gm-Gg: ASbGnct1OilB0KwH2cmLjSqpemk1Hfjlr+hQH5QmEXOSBm1BNK4+pN/+iJXOvz6ZqjA
	CEzUFvVYazTsmHVCEFwoBy5b4tbCN2G2Ee5/j1dSfaj2IikC+LF/vxnf0QLksPS8EsFx+vH9PEq
	M36LqEG82pLP80DosoPYH3YPLq05WDy6FS8RZNTPsSe/eVrRnvcIYoB/j5gvfmYzWH/ujvuyPMK
	F3CHPrdoQOApsVNfqt52tPt5zccp11KOXh5+/7Wm7fY+Vk4L01Y7E2DCWNSprwwct7t4NAYChse
	2iWGTTrx3bbAVswY6t3eYR7qnvek+atjefm/XVozi7J+ui1O42DIyDAWSJwzxFB8scNbc6MS5tt
	uHRkLchC0MmgidszoNQIfdMquk/V194zdvZUOwHcCYkdw0hDacn/jmJRx9pUguhVMkZhrsCSxyM
	CozHPDfASJ0QFfRn8=
X-Google-Smtp-Source: AGHT+IHP1cVhD8F4dyZ7P8z0EmhNkVZ3pwTL9LbVmVnwsMVkY7U34z4WsYnpeZSVPdy2RXMWC2141w==
X-Received: by 2002:a17:902:f545:b0:292:fe19:8896 with SMTP id d9443c01a7336-294cb674766mr40940405ad.52.1761652207657;
        Tue, 28 Oct 2025 04:50:07 -0700 (PDT)
Received: from [192.168.50.87] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf49easm116300265ad.9.2025.10.28.04.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:50:07 -0700 (PDT)
Message-ID: <ed6bcb1a-e0bb-4211-951f-500a8fd7787b@gmail.com>
Date: Tue, 28 Oct 2025 19:50:03 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] common/zoned: add _require_zloop
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
 Hans Holmberg <Hans.Holmberg@wdc.com>, linux-xfs@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Carlos Maiolino <cmaiolino@redhat.com>
References: <20251022092707.196710-1-johannes.thumshirn@wdc.com>
 <20251022092707.196710-2-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251022092707.196710-2-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Reviewed-by: Anand Jain <asj@kernel.org>


Thanks

