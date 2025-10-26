Return-Path: <linux-btrfs+bounces-18347-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB19C0B7BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 00:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A46CD4E48DB
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Oct 2025 23:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA161EA7CB;
	Sun, 26 Oct 2025 23:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="uAo9HCuj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sonic310-22.consmr.mail.gq1.yahoo.com (sonic310-22.consmr.mail.gq1.yahoo.com [98.137.69.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715330146F
	for <linux-btrfs@vger.kernel.org>; Sun, 26 Oct 2025 23:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761522368; cv=none; b=Bt8TSZMT2ndzMuoAaUmJUhF73soLBX9a+fO/kCvclTO3c8fSl1fJ/jm/02/LRGxU6vKGkauUqinDcMPu3d8rqmiXaezCOROwQRVMt1AtaJ3WbGHSWQkeKS83wAQ09zOpHNoowGI3veaTOqNwbMgGO3cAwzJ5Z8VIbsTTw//9nEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761522368; c=relaxed/simple;
	bh=ISvk7d0+1cvZJK22GHYwdZWnPgl4yZ33dEnmpBMp/yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PAkGqlx4KkBAXyNkiFBwrb+f/epToRbh9eYseZtdVk9+y6MjKNjgKUvMPMXdZAylZ2MmRZBMsE0/+joqnt9QDS4nP+y/qLdeKn2fcJQhtNW1Bd7MOlo+beVfozP7tkN+bnkd8sLftfhSXXE4kCn9iJOkT3cc9emYMHQ7boO3PWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=uAo9HCuj; arc=none smtp.client-ip=98.137.69.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1761522361; bh=/ImI5s2JAuKfhDTU5/zpFGCUAiqL+gSAFz+PIrG3x0I=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=uAo9HCuj56j2SglbQE/kUuODcVrIoEOu4A4H/iCYN/hRWk6oAH0uaP7G6CcQ+zWHCXFObZGlhveF23x7mAFsJUNuqwOQJ2Tmiep0VoTfmjqx6xOHvF6I9zmW7wgWGi0kUkMqYtpnfRog3UzsfsJTPVRW3zL7mJW6FEEWq5/jOIQ/AYRwqJCdiHOGd72nDioYJyV2O0T/TOY0VlSEUkNnS7V3PCBD5RCdpJngAvlz7PM43N+HTDHFUOpYaVabMmSzBH3Pc3QA5RmClG8sV5V/UNMpT3YmK1UCcq4m8nndqUP/C/W2rDgAp3gtIokveE/hjOxIa2TJLBl+ivganpLFRw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761522361; bh=3Z3z1QVY4zr+XLM6pT0eVUogzZLvpqcQqw/CH1UEwqH=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=NyaDNVGGg8ZN07FvW0ZpeH1XCgIstkATzBSBJiIPmlCKOhJqgJN1023IsrvzHo3viGu3TkVaTvOEq07roVZzF0j+ldBioB40QMqWQkrD6JxJjsmbzlX31WHd2qP2QOuRH3+YWtH3RG2XXYzX7Eq84QeDoBWbPtOQz12N5RiYjb0uW73uABeW45hIGfz1bH2zJE81nq6cDIFiGu7GZaf9b/OMn0tP9gfgqywJjB26AHxM7DjLhkxGAk2xHd+HXR0yDM4BIVhCXVYEWTZdzN9NzJA673/mwbnjl3wIcjh12xSdoWF3qL0lv9B+s9uVcLopvpyJh5qkVnb8aN0CCVqZGg==
X-YMail-OSG: fs7pa3wVM1lKS7RlV27vB8iVR39F0UkzqQbZsye9Wn6kJ54NW.RegW9A9uyYWfb
 BROYYPeo4t4V01PQJOPU6uiSBqsNOcSw_9ZuviMXbLH_Kngezifq.jJriIBFYcatOZmFNxwaGRbu
 vKyX.N2z0WhdgRn63qkckecLFbo8V2cyAuSSz78ExG3BwbzucfOHqYsCltliRgZW_Sf9mRJRC7Yk
 3qzSwmQfYGO6V5guU90MJLld6iOyh7QWGpwjrqP5sFwFZXzmQqRDgqVS8BTxG6gDr2XxSqnMpYeN
 IBQ4UjZp6FEaL_voQCpHAoKGaHBAPZ3pTP2pulg5mmebHNYcE6K9_5MF3AMV_xmrvlewU11Wmw3e
 2IzcVXsN1AojHO0nHuiQgtowrkovLzFXNtn4IoB8GTO13pyJrEfdv9BCT3SM1CEFOCAVpoYNvRVE
 F78Fap.xqzbPWehNGkACFJL3C6ZmhgM7E6QHsxgp0u0y.y03Fl2mNn6ARODev9Hr5yM1KYm6C5t2
 .ZeDPu89Ucp17CazO9a2d0.3XrLk2H2UCPPXnbZKlK1IY9W13ME1kJX1yMxD6CELHfyV00cKN5QA
 fnf3lbdK4y.U35O4fIHGxvmCEKB_Uu7G4UFUEENTjunVfVIItZ0jET4IzZ4vn8xnK2w_AdHG4qgw
 7iid2rtERfrev0cZV0Xl6UAVjRsoOVZJOoSTTB_M2rLGEf8ZTypUxHTDQlyiv7JRc66Xl0Ceo_c.
 sD16QWStCdy70DqKu3w7KoUYayGzVmewIubZOsEdF3Nlzg2CekQJfiGplxWxCuu0ZUzC0q6kLbYi
 sOxy3By2g07LQFuxlzwa.7s3jOLHKDgAmxUFhzFGd3_fmRxVuQEa82msqynE3ScnWBpxsd.7apG2
 Ox3k3izds092BItE8rgyV6Sfmar3YBODpWIbFd8i01mdSF.mZs.v2J4zydGqbOtHh5yBmjdq._Yw
 XjloCfFOom4xdgLdCNXrl5DxD5ohEClWDKV_gkC9jacvRJIwXhNpK.6d.SN0Szw5_ZMaS9cp_3GM
 IWLz8ugnmMVLn3hQvCW7Dn4QKB0wU6WN0oQd5kFk8AqoY7Q3OR_OgNmNHrOx9_TRwxoO44eud9my
 c5Z1z9_2fxHkuHiNxqtWdydT979Zi5Kz2DA8BET_PQJHC6I5.tz3Dvy3EKN_OcFaHSE8xs4nYM9v
 G7SfeGGE1I.aJUdyFpXPstH0PJ1Hceb48UNI9q3Wc7LZTQWzLbK2x4XwBfKdF3PkLT7x4rD7UGgR
 yq68QnGzyNaqLrCvWtnK.K0cMD77HVZqOkVoWWJA0ve79tfhwSgbTWM6jxsOCvg.hLFpKDgeMeoj
 M3ImRfpiT15zJUJJW5Y6ZiKd2NEt6GCOPPYERxBYXuy7vwD0rkAD0SER8p0laAwkSQAV49E680Qi
 qbkf4u_X7h3wLeXIMm4hzL4nzqNuLPDhJCXHR7Xh.GwGG.7QgFziQO7y8Tjhof7MGps9nEb7U_h3
 aKq1jOoLUWxXejSeikGb0RdFUCuYBV3RKsJR0wKVEmM.NS0qw2NJrNKNa2gBpexTA_Zf5N1jdptD
 AQ11Jpd95GQb2T_FAaFuQcFAKkyo0w6HXIFMbwUQSwwWK9E4JaDIOyllkugcnlLf48dwP3yYszLz
 rvolZmi24Kr.XGOzqUYukORBlSgOaY_1Y2liWaab.CNJNoyoLkZsSncmFxQRXK55igZ33zlsrlH5
 odxBPcRu1gp7EFZjYgOJp.G77TqKme3hgWxDzrRDts.FYdcga.pJKzsdqyxt6GYMFvVrtIH3W.E.
 xBlyCl..SBMbQMuCtH4DQGDKc7YSKUOHswzY_Z3B3Mye0e_U1w8P.vj7TyN_yi4lJLG_vy.AcQzj
 S50uVrLPNkkrMenwtc68NuL4rhjyGu8neJvB4m28OPi6N7e5lGfZB03gfk4tjkDfyLI3AKbwRBqL
 veFMTJDUBUypGPR6EyjA_hsHHbqLv4AvR4s5bitcYcnFwj8n5ZNZTcY8K6xTsGPs3azRlhwUlkLr
 kBFYZ9m4sEzxH.rJ4JjKfHobbyhBULHKCrC3peNHJsU67P9sPCQXHUlubVVFBUxgEcO.ihL2Vgxt
 0M4cTt845.UuHDJhcfUk8uDgLSy_1qVbgiuTrw6bSohbHTR8viUnFUPDuSNP7Wg77AcAnmnmws1B
 cUTa8SoeLWQCojIAA2fTsCFBECZmUX.w97mJNMD69TXD49NqHOgvrnTebshiR8xFd7HQjRCtY.6O
 LYePJrskDtXmdKdDICEEFaquireUd9yRPbOboGdXvBjJeQa5pve.De4KzolDOVNJFLtY-
X-Sonic-MF: <brent.belisle@verizon.net>
X-Sonic-ID: 5772356f-2332-46d8-a6a1-7bc5172b55db
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Sun, 26 Oct 2025 23:46:01 +0000
Received: by hermes--production-ne1-56478d9679-fzvtf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID abbfe5818a2d1651acc82b8b5412913e;
          Sun, 26 Oct 2025 23:05:32 +0000 (UTC)
Message-ID: <b02f8d58-8c31-40c3-81f2-5b4cb4e9d253@verizon.net>
Date: Sun, 26 Oct 2025 18:05:30 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: Strange btrfs error
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <c01bd806-9490-454b-b29d-61e5911b2483.ref@verizon.net>
 <c01bd806-9490-454b-b29d-61e5911b2483@verizon.net>
 <0725451c-7354-4ac2-9bd5-e0487feb77c7@suse.com>
 <da6943fe-5f4a-40e1-81cc-35bdacfb3683@suse.com>
Content-Language: en-US
From: Brent Belisle <brent.belisle@verizon.net>
In-Reply-To: <da6943fe-5f4a-40e1-81cc-35bdacfb3683@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

Thank you for the update.  Since it is no issue I'll just wait for the 
kernel to be updated.

Brent


On 10/26/25 04:21PM, Qu Wenruo wrote:
>
>
> 在 2025/10/27 07:46, Qu Wenruo 写道:
>>
>>
>> 在 2025/10/27 00:59, Brent Belisle 写道:
>>> when I run a btrfs check on my file system using btrfs-progs 6.17-1 
>>> I receive the following error "we have a spare info key for a block 
>>> group that doesn't exist" , however when I do the same btrfs check 
>>> using btrfs-progs 6.16-2 the operation completes and says "no 
>>> errors".  Is this just a bug or has btrfs-progs 6.17-1 really found 
>>> an error in my filesystem?
>>
>> It's a known minor (aka doesn't really affect end users) bug in older 
>> mkfs, and the ability to detect is added in commit e2cf6a03796b 
>> ("btrfs- progs: use btrfs_lookup_block_group() in 
>> check_free_space_tree()"), introduced in v6.16.1.
>>
>> You don't need to repair (no repair support in btrfs-check yet) nor 
>> bother too much.
>> There will be a kernel fix that will automatically repair this on 
>> mount soon.
>>
>> If you really want that minor problem to be gone as soon as possible, 
>> you can rebuild your free space tree by mounting with "-o 
>> free_space_tree,clear_cache",
>
> My bad, the free_space_tree mount option is no longer there (but still 
> in the man page).
>
> The correct one should be "-o space_cache=v2,clear_cache".
>
> Will update the docs soon.
>
> Thanks,
> Qu
>
>> which will rebuild the free space tree at the first RW mount, which 
>> may take some time depending on the fs size.
>>
>> Thanks,
>> Qu
>>>
>>> Thanks for looking into this
>>>
>>>
>>
>>
>

