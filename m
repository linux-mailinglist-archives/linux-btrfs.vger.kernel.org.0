Return-Path: <linux-btrfs+bounces-12518-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FDBA6E39B
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 20:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4783B16F867
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 19:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B03199FAB;
	Mon, 24 Mar 2025 19:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="wePPd4HU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3475B191F91
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.36.37.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844751; cv=none; b=gC5beMh3YSkYN8JjaOscgpb9SpSltUGPLD4J/nfrUB7PEFkJBDS6Wo/unmMwvUTvDngc+jWDUUPLESA0gLFPKNT4NfmbJmHs8hbn76wtIrSOjB+kNQYqvrv/CzXNDtKNhrk+REr7HnJ6jit/XIIiiEawsAyn46hljaUnt72VbQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844751; c=relaxed/simple;
	bh=KjjpkYcRc2omSeV7VNv6pueMIrtAOGyV900NvUnPtrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3asnqNPWCn0ddsIUeWRX7wsJhO53RV66yoo/nBVchAJ2AmPXimRj4wueA/CdXord5grwqLszdehn2NoAU0nFtlHR94dlqGqEA05n8bJ2Zp7Xq+nkrxxkFQ9zjfOGeGSOsqOc1ghimiHj7esEMkHDjsGL6BRKeMGpOUIyvCXm7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com; spf=pass smtp.mailfrom=wiesinger.com; dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b=wePPd4HU; arc=none smtp.client-ip=46.36.37.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiesinger.com
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id C881F9F22F;
	Mon, 24 Mar 2025 20:32:26 +0100 (CET)
Received: from [192.168.0.63] ([192.168.0.63])
	(authenticated bits=0)
	by wiesinger.com (8.18.1/8.18.1) with ESMTPSA id 52OJWPoq006685
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 24 Mar 2025 20:32:26 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 52OJWPoq006685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1742844746;
	bh=sJBlF5mkuh/a2nHg3Fha4b7b7ca6vs21TFw/wXAh9z0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wePPd4HU+VnsHYsFKVsysUK2K65spUUPNgAgt+cvsqYmrrmhstseYH9slIOvGtgo3
	 wWUu4ipneRFT3fyqApLaENbly0kVxeMlRrKfhyypYn/cj+dlwlt03+khDemMEq4wez
	 fXJtSuydW2tNIQmIlQ4mYGTK2U8LMDNYdKDXhDl9VUMGzMeyHSy0ZH1VxQtEuDkrFF
	 +y/DdTuXubCBY1hPd7+hukEDGexKBxX4ZlS9KRcZIrAj1BYDUEpK39UT56C2Vb98Bm
	 0Qn8vxEyfgg2WxnX+JLxBATomj2oYLHZJBNO3F1mBa61zLzFS9pwmIhpvWvWjip0QR
	 0k6HLb5l/hefLPX6P/T2O72XQ3T3vLoGtcWu8gtWdmufP38SqbfDm2TFyFdoDFzlAD
	 camMEQKqIxHg6g4/QarEs/paj1gMh71VmA+I0B/s9pSKL7e3Smb6Juvh0wcw0gTI5R
	 qKFoZSv1OW1b45iodXizllRzx4n2T4o/2oeg7wRDxzpOBGdOand3EFcjMB9/599v80
	 USA6+M3AfMcb9t6t7hqIlIHVrjYQYPdwETafF6DMTrbvbS0kakU82k7X1udAaxklNZ
	 GQV0+AB9hBxC7HEutzySRAKxwO3h/5FubmNgJza/wDszxyRqcj9l3LXBgMZgaA1eIp
	 7jTDp2dGJHPKKgqv8een7z3M=
Message-ID: <50f0a049-22a9-4732-8286-4443e92ae18c@wiesinger.com>
Date: Mon, 24 Mar 2025 20:32:25 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: mount compress=zstd leaves files uncompressed, that used to
 compress well with before
Content-Language: en-US
To: Dimitrios Apostolou <jimis@gmx.net>
Cc: linux-btrfs@vger.kernel.org
References: <2f70d8f3-2a68-1498-a6ce-63a11f3520e3@gmx.net>
 <d1c2f041-f4f5-9dad-511c-117ed8704565@gmx.net>
 <8aaba46c-f6d5-4f3a-a029-f564b8a6a9ff@wiesinger.com>
 <3ecd06ed-a1f1-595d-a7ce-c1018bc15baf@gmx.net>
From: Gerhard Wiesinger <lists@wiesinger.com>
In-Reply-To: <3ecd06ed-a1f1-595d-a7ce-c1018bc15baf@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.03.2025 20:11, Dimitrios Apostolou wrote:
> On Mon, 24 Mar 2025, Gerhard Wiesinger wrote:
>
>> Hello Dimitris,
>>
>> It's a known bug I also ran into, see the disucssion here:
>> https://lore.kernel.org/all/b7995589-35a4-4595-baea-1dcdf1011d68@wiesinger.com/T/ 
>>
>> (It can't be easily fixed)
>
> Thank you Gerhard, it seems we are facing the same issue.
> It's a pity I read that force-compress does not fix the issue.
>
> This "preallocation" mentioned in the thread, how is it achieved in the
> application level? Is it with posix_fallocate()? If so, I definitely see
> it happening in PostgreSQL:
>
> https://github.com/postgres/postgres/blob/0e3e0ec06b995f6809f315752cbf5ff67902e095/src/backend/storage/smgr/md.c#L575 
>
>
> Relevant commit:
>
> https://github.com/postgres/postgres/commit/4d330a61bb1969df31f2cebfe1ba9d1d004346d8 
>
>
> I can see this code was introduced in PostgreSQL 16.
>
> Maybe a workaround is to recompile with -UHAVE_POSIX_FALLOCATE.
>
>> I guess you always had the issue but you didn't notice it.
>
> I definitely didn't have it with PostgreSQL 15 on Linux 5.15 (Ubuntu
> 22.04), I don't know for sure if I see it after upgraded to PostgreSQL 
> 16,
> but I see the issue with PostgreSQL 17 on Linux 6.11 (HWE kernel in 
> Ubuntu
> 24.04).

Yes, it occours when FALLOCATE (in any form) is used. So it looks like 
it was then introduced with PostgreSQL >= 16 and is NOT kernel dependend.

Are there compile options to disable usage of FALLOCATE at all?

>
> I see in your message that you are on Linux 6.5, but what is your
> PostgreSQL version?

Didn't document exactly used version but I was using version PostgreSQL 
16 (see directory /var/lib/pgsql/16 on the mailing list posting).

I was using the PGDG rpms from postgresql.org to get latest version. For 
support reasons with less upgrades I can recommend them anyway because 
distribution versions are often (far) behind.

>
>> There is also another issue with BTRFS:
>> https://lore.kernel.org/linux-bcachefs/kgdutihyy6durmrtqi5dfk7lhl2duzm4wnf6mlyneiuphf3cck@fxulfyg2ugjf/T/ 
>>
>
> And then there is the issue of abysmal performance for buffered read(8KB)
> from compressed files:
>
> https://www.spinics.net/lists/linux-btrfs/msg137200.html
>
>
Ah, didn't know that. Did you also try ZFS and test also regarding 
performance issues?

Ciao,

Gerhard


