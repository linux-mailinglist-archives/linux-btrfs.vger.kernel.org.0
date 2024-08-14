Return-Path: <linux-btrfs+bounces-7198-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C919524A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 23:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC311F2276E
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 21:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C911A1C8232;
	Wed, 14 Aug 2024 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZpZM0FG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEC91BE241;
	Wed, 14 Aug 2024 21:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670670; cv=none; b=JffrfLE44GJcUrwX0hNfZWcatBTwJaDjSOZjE8dd9gh6pKsn0Mye9sbdEq5HGQJmJq8ZaY1DtMNKba7GhAi6Fg2fTzpssoKS7gRn4NDbiLZ7QVYVPDinJvxvGPitqYvG7a2Z4XifwZ7Liq4ytRMZR9oBsvaHtE2VpX2fARsvYpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670670; c=relaxed/simple;
	bh=70ZVhRIeQZZoEcfgxUeSKJYGOEmRh5NTAji1BZ8/rMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkrOynn6bnskbozUf+p9IXd9yrRhgkqTRBHt1BOjFJCZp+DdkaURDhaennUZgGdQv9BXOU/P5xG1NQv3b/0c2ypYChCxTmGu0Q/OHHfez9bxMko/jrJHpShyaKh+6ABLIA0Iv4F9acM7mn7hqJX5XcKKkYUqASGk0v9w0Menmok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZpZM0FG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-368440b073bso164619f8f.0;
        Wed, 14 Aug 2024 14:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723670667; x=1724275467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJ8c8qOAB5Bc3n9KNWTAAiBx1ZDIQSVvg8ywZE8CxyA=;
        b=PZpZM0FG/RHKAtDz3VqF3GpisUFx+vPihnp1fogV9HHvU32h9mJxzn5GbBeC3g2mQN
         /n1gZYInLNzVYlbSrdfqZfSqFaMv7mZaTIAHyE2qSO+l2GVyJEZMu7yBd+F9oYSCV7Jc
         F2g6EOROijX/YPWpsJY9siZF8oi3MjAY6heSXtjeA6fL/k8EZqgTm7M1f7/NWdkaS8fZ
         YqkIVqfNvBUNwNsDGM/3lFdtl479L34bQ/t65EMYgmMCGaxeH4tERtYFxBjOsjrjtZ0Q
         c24GnBqFNCgtqhvNtuktG5qkFamUHcRL7CD37gkyLSrz/CjPWHVv9cPKiEehKA3l9rL6
         Agrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723670667; x=1724275467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ8c8qOAB5Bc3n9KNWTAAiBx1ZDIQSVvg8ywZE8CxyA=;
        b=J6FrddERSKI/du8T1rBdDpCdPYlJvQWnWXX9RcpSwdMWZ6QIFyxbqzfLHVeg1lGJFC
         TYXFWxdn9CT0PO0hkA5UVlHD6Kzrbmd3jIR2OJdqKF5VmzYburd1FkN7SsTuo/p1S8xC
         eifZHs4Z152yb8h+7Cg0ctNcCyvVEJc1h88XXxy9yNfO8nd80n/Wbo7U6VKcJJqgNNOX
         lHwG7o0G5iFA4lWu7iCcD/9t2PLZCFXNPkKmstHBOz9hGjym7y1YWem1K5UhjbJucj5l
         aOid2lffSJxnG9vb38sNy95BwmSKxUHDMrHO4s/AlGo2CloX5CCtIWbESh3s76tKLpFr
         gZFw==
X-Forwarded-Encrypted: i=1; AJvYcCUqrHbZtYv0lDci9leLy76wMaA1z83/cH80YWVTeyhdTOOfrHc4o6hGVToZVlZ61FAgVbDoYzmJi9ouy3UaigmFueYWn0hE4Xm+Vy4AZBKdEZ6V56nNfUzZHn2OwPRnaVeOrgVr3bApIHM=
X-Gm-Message-State: AOJu0YwsUhLMIz6ySsjNCEFg4pqWt3nH1SL7oz8+EjDxEasldWkw0YXw
	E3lJV+AnZHf+jV1Fu9+030ZA6xgEsxdB6FdPHQZF0CiWJFzAJwH0RKmjrSqBB/g=
X-Google-Smtp-Source: AGHT+IE0tdjKd7Izw/570py8NiZmTH5iwdogIHFsUVNtPvq7imLC1cuCKjotWItEmXe2EeaQooQnTg==
X-Received: by 2002:adf:fd8e:0:b0:371:8319:98de with SMTP id ffacd0b85a97d-37186c121e2mr541370f8f.14.1723670666380;
        Wed, 14 Aug 2024 14:24:26 -0700 (PDT)
Received: from ?IPV6:2003:cf:3f1a:a602:9067:1658:40a2:feec? (p200300cf3f1aa6029067165840a2feec.dip0.t-ipconnect.de. [2003:cf:3f1a:a602:9067:1658:40a2:feec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898ab469sm45884f8f.100.2024.08.14.14.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 14:24:26 -0700 (PDT)
Message-ID: <c30fd6b3-ca7a-4759-8a53-d42878bf84f7@gmail.com>
Date: Wed, 14 Aug 2024 23:24:39 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough
 memory
To: Filipe Manana <fdmanana@kernel.org>
Cc: andrea.gelmini@gmail.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 mikhail.v.gavrilov@gmail.com, regressions@lists.linux.dev
References: <CAL3q7H5zfQNS1qy=jAAZa-7w088Q1K-R7+asj-f++6=N8skWzg@mail.gmail.com>
 <277314c9-c4aa-4966-9fbe-c5c42feed7ef@gmail.com>
 <CAL3q7H4iYRsjG9BvRYh_aB6UN-QFuTCqJdiq6hV_Xh7+U7qJ5A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Jannik_Gl=C3=BCckert?= <jannik.glueckert@gmail.com>
In-Reply-To: <CAL3q7H4iYRsjG9BvRYh_aB6UN-QFuTCqJdiq6hV_Xh7+U7qJ5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/24 17:33, Filipe Manana wrote:
> There's a fix there in the bugzilla, and I've just sent it to the mailing list.
> In case you want to try it:
> 
> https://lore.kernel.org/linux-btrfs/d85d72b968a1f7b8538c581eeb8f5baa973dfc95.1723377230.git.fdmanana@suse.com/
> 
> Thanks

Hi Filipe,

this patch mostly fixes the issue, but I still get a 1-2 second window 
of freezing every now and then. I also still see long periods of 100% 
kswapd0 usage, but without the periodic freezing.

Thanks
Jannik

