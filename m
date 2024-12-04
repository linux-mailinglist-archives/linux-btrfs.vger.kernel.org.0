Return-Path: <linux-btrfs+bounces-10055-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E444E9E32C4
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 05:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9AE7282749
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 04:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2000617B50B;
	Wed,  4 Dec 2024 04:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b="vhFQIa+E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.scoopta.email (mx.scoopta.email [66.228.58.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B7155747
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Dec 2024 04:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.228.58.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733287765; cv=none; b=mOGTYYLMxkXES7nkbCKio9Fuct87+o6oU8xpoO6W+DWTntAVrkn4E3DH8PI/c0gv5tHNgWD3jgL4e6b6W1lOpT/qLRqCwwFIkpri66jcgxgBSnkXznJTptVRok4CozyYM0AF8jdYpAxIVTt8eBD2zCZy9dc65XCG2PPolgaNBgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733287765; c=relaxed/simple;
	bh=wjUHCSrXMrO15nla+tRrAASpqwnnAD06YXBQolbsbck=;
	h=MIME-Version:Message-ID:Date:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rXPMWHe07w7o2/DLeVPdxAHDdBja9zFf3YkT99Eb3IRSNtPJZm6ndqpO6n3QEsU2MGtKwW8bQmVzAqShmMmAYR1trPLgUxkd0zSTUjXimvE5YqCZMP03iNNTkON++YxRn1OZuqWbmc55al42J8R91yYDSigihn9lG8iXnvSL8wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scoopta.email; spf=pass smtp.mailfrom=scoopta.email; dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b=vhFQIa+E; arc=none smtp.client-ip=66.228.58.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scoopta.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scoopta.email
DKIM-Signature: a=rsa-sha256; b=vhFQIa+EsHm9hJ1nMmcwU2b6tZub3j5Ol6r8phKpD92sNRRReB/YfFW8oLFVyS3InHzIcZFPhDtKWxjIX56FGS3J0jnSl11OJDEBl311cpKOfwVX7pbexbKcxJ9mnkbq/GQJpjFLkIJcTM0HMTn1j+wMacbx1u8rlmJqTNY9bJjcKBwTwCnFz53YTQolZ/uYYSumnS5jeQqXfmRvHBueTJwFYHwJKOFgt+qgrygF4R1XhTxjZNWHaKzNGIyKE1e4zgz0wIWO8PMCyEKQhYuN8dP1yxhxJN3nYfx9WTs3U3KAtO0Q7aaQJOXLJy0mS3mRteUluDFZwHq4KIpL2Zeu5Y4WFQxgG9ECWF966MqAXQQc69Ln1MPqVCnPxGPilJUMXip629GUay5zYtKx1WofD7xesWsTYgO4Opl8dc/IXCeHkfmymHUylnQ+oDwBlZmS/1SEaSNgHC5uG8FPoJ7UPqo44lrl6I1S+8HUUJeepZKHNhcnwLAtwEu7iq0jkQprJHFMR62ypoazmaRWYPsiMU9r9noZ6vlCGlOMYhUrUXqYHn9gmMi5TfWggUpkFQ4lr+wiK6qQoZg+VCHCPMY1hk4QheuA2o087+0bh1+wkBxbJCeuS3TsM/dfL0cPA7aUduD2Bf7Aqzq6btENelhZr8igjqi3L4qHRfVA7ac9P097mfX9eD7a3JV6hdd1j6+yvO1XDKRsN/MezK7MR343YpBOax/D2cSE7BcyFIqnWtVinqqajq5WF5RTpmILd2YOCxzkf7Zn3z/VtduJAExrPvhxlq5FlVVra7aTVMBu0K3qFN8Te0JA0rkKLhi9jsFRPd3XhwnXdPnvskcE+qvjGOXk90r+rvq6fDwjxvq8Jm8NPYB84ZXQH9cLCtr4H8N4bI3aai7IkX6cKHBC++tobD/WgBm0laR0DUnx0n50fJ0zimbUO1MZs0mX6T/fo6DhcsArYC
 2uxVSp4jT/JlN2uJiABbCpuZfynUWvCVAUjWieLqFgvLclK2rFCa3tM9G4K2zXkYXlE+Jtpv90MUjM1gVBh+Xqrvj1lLS9G91Hh1YGqTFxEX2aUqE5ZZuU4/qpWp5tbxSS/4jPAHVzfg1V3fjxBLr3Ga7qUsxJVfmDWQv2FxFVj105kMWLMdTL/AsBg0NUkqqui9l/0xF22f2gYzhDfzCKU2W+iIGW6DGUCcn2lgVQjXykkcjcsQJyAMAqNElFwWRquOHN98Yia8sEgIrMtAvXX9Xr/RVcoxB+JGRHkXVUnx0heAqqEtoJ3tYwJE9iMpu1sGZPHOute4/qMRvsobalbMN2vZEUVmt+YNuvo6PjVVTVB68eGz7VC8pJOxK4poU5okHfMzF33XyJvQ==; s=20190906; c=relaxed/relaxed; d=scoopta.email; v=1; bh=pE89bBeeJAzcmH4fOfBagdxYFCmkuhEmvemi8eT3dck=; h=Message-ID:Date:Subject:From:To:MIME-Version:Content-Type;
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-UserIsAuth: true
Received: from me.scoopta.ninja (EHLO [IPV6:2602:2e1:80:111::f0c5:cafe]) ([2602:2e1:80:111:0:0:f0c5:cafe])
          by scoopta.email (JAMES SMTP Server ) with ESMTPA ID 1411313729;
          Tue, 03 Dec 2024 20:49:22 -0800 (PST)
Message-ID: <e2215c24-62c5-405a-87f5-3b68b92524c1@scoopta.email>
Date: Tue, 3 Dec 2024 20:49:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: Using btrfs raid5/6
To: Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
 <a98fb4d0-1d80-4ae0-a79b-2acadb7b9722@gmail.com>
Content-Language: en-US
From: Scoopta <mlist@scoopta.email>
In-Reply-To: <a98fb4d0-1d80-4ae0-a79b-2acadb7b9722@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Huh, for some reason I was under the impression it had a write hole too? 
Not sure where I read that

On 12/3/24 8:29 PM, Andrei Borzenkov wrote:
> 04.12.2024 06:34, Scoopta wrote:
>> I'm looking to deploy btfs raid5/6 and have read some of the previous
>> posts here about doing so "successfully." I want to make sure I
>> understand the limitations correctly. I'm looking to replace an md+ext4
>> setup. The data on these drives is replaceable but obviously ideally I
>> don't want to have to replace it.
>>
>> 1) use space_cache=v2
>>
>> 2) don't use raid5/6 for metadata
>>
>> 3) run scrubs 1 drive at a time
>>
>> 4) don't expect to use the system in degraded mode
>>
>> 5) there are times where raid5 will make corruption permanent instead of
>> fixing it - does this matter? As I understand it md+ext4 can't detect or
>> fix corruption either so it's not a loss
>>
>> 6) the write hole exists - As I understand it md has that same problem
>> anyway
>>
>
> Linux MD can use either write cache or partial parity log to protect 
> against write hole.
>
> https://docs.kernel.org/driver-api/md/index.html
>
>> Are there any other ways I could lose my data? Again the data IS
>> replaceable, I'm just trying to understand if there are any major
>> advantages to using md+btrfs or md+ext4 over btrfs raid5 if I don't care
>> about downtime during degraded mode. Additionally the posts I'm looking
>> at are from 2020, has any of the above changed since then?
>>
>> Thanks!
>>
>>
>

