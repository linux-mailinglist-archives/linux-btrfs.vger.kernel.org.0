Return-Path: <linux-btrfs+bounces-1124-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 087F681C4E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 07:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AECAC1F24DDC
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 06:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EBE6FC2;
	Fri, 22 Dec 2023 06:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="o9iJY5HQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C9863A7
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Dec 2023 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiesinger.com
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id 56EDD9F1F9;
	Fri, 22 Dec 2023 06:58:58 +0100 (CET)
Received: from [192.168.32.192] (bgld-ip-192.intern [192.168.32.192])
	(authenticated bits=0)
	by wiesinger.com (8.15.2/8.15.2) with ESMTPSA id 3BM5wmaE289949
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 22 Dec 2023 06:58:57 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 3BM5wmaE289949
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1703224737;
	bh=P+TtwHg9+KWbQNRHrc+MQgzaCBEyi9RJqZTUTJwOAgM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=o9iJY5HQa84y6xVTA8xvHggBT4QqI+ZTqy3HA8aMUP/6MsQ0ZFrqEoUwStgjJ58Kc
	 q5/1achg01yICqqH3xJhxndRL/PJ4WVZPaG5R8pugh6jD7DdNWAkk/2ZbdkcAlExZB
	 n+tTvMxnocCV8YHj7yxNsMe6ib12NXbS6SHFmYepDCnXM54r3GV2hrteOtSKjUgye4
	 jxptgjxwD5ryHCLWoTtcLQ5IyVw5DRfHnXTsYQj44j/CKXwCMWgxCtd5EDHQ+HYpmu
	 +Sc5SteTaQRnWu5eq6xpKZ2r80LRNJMMKc4k2pcr0w7IyA4fLamgHF6xIVpoj7GFyF
	 8dtt67R+6DEpttjr73WafAFdDNFdHjg8Fuw0KL7JFX2WQbNg03+u0P+LTXJg089NQa
	 dAuZjDjWMJEuUYy0a/CnULhIy8QhW014v3il+z3wPCllzGe5hzYb03uqey9/Zy6Soz
	 7zWyktJQCXIkFipiwK+RiEbQEEAuURdMKC3XyPy97ERj85q/6esB9H7qMiJ89BCC/I
	 cEpkH86Px7DKtqCvnpDaZg3G8G/U0Skr3OPhhT3/7zk2xb+Bgj1GRjt3HtULVNxxOZ
	 stza77CuIblBPXC+ur4YMXAl3mD2SIdgO5wKs+nK50NpevcOarYKgEHMtJju0J1MZz
	 BaMqrlFh2tvuEc+gY4/Qt2Q0=
Message-ID: <0c644c25-7ec4-43da-a70b-1632e87490b3@wiesinger.com>
Date: Fri, 22 Dec 2023 06:58:47 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS doesn't compress on the fly
Content-Language: en-GB
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <ac521d3f-6575-4a72-a911-1991a2ca5f67@wiesinger.com>
 <ccec2d73-98a7-4e73-a9ee-9be0fc2e1c92@gmx.com>
 <b7995589-35a4-4595-baea-1dcdf1011d68@wiesinger.com>
 <d30abb90-4ab2-4f66-88b0-7d0992b41527@gmx.com>
 <6ae85272-3967-417e-bc9a-e2141a4c688a@gmx.com>
 <a9fafe9c-27c8-4465-aafa-a4af6987c031@wiesinger.com>
 <6c2424bb-9c91-4ac0-970b-613ca97b3e01@gmx.com>
 <771df9a9-c7c3-40a7-a426-0126118d3af0@wiesinger.com>
 <9f4ad251-7af7-4f02-b388-64dd6c8257ac@gmx.com>
From: Gerhard Wiesinger <lists@wiesinger.com>
In-Reply-To: <9f4ad251-7af7-4f02-b388-64dd6c8257ac@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.12.2023 11:19, Qu Wenruo wrote:
>
>
>> BTW:
>>
>> if compression is forced, should be then just any "block" be compressed?
>
> There is a long existing problem with compression with preallocation.
>
> One easy example is, if we go compression for the preallocated range,
> what we do with the gap (compressed size is always smaller than the real
> size).
>
> If we leave the gap, then the read performance can be even worse, as now
> we have to read several small extents with gaps between them, vs a large
> contig read.
>
> IIRC years ago when I was a btrfs newbie, that's the direction I tried
> to go, but never reached upstream.
>
> Thus you can see some of the reason why we do not go compression for
> preallocated range.
>
> But I still don't believe we should go as the current behavior.
> We should still try to go compression as long as we know the write still
> needs COW, thus we should fix it.


Any progress with the fix?

Thnx.

Ciao,

Gerhard


