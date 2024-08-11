Return-Path: <linux-btrfs+bounces-7098-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E949494E0B6
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 11:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D651F21527
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 09:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE9B381BA;
	Sun, 11 Aug 2024 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="R4OZWQBp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752AD7F6
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.36.37.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723369563; cv=none; b=uRdyxwOWIyFYXUSfw1t6xDPlz+AuIuG7RrohT18YEhAtLSKjZ+BLofQftUbDlD6Fg2jQZhhCi7a7IKggf3sc6R+jCTPEDYDz5hKpPqUsSMyiRVQM1+f5Nk2mHKDYhk4fJEec9RDtVvwDEhLF3thuuIhzijITeS2rKD3TXA3lffI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723369563; c=relaxed/simple;
	bh=JvO4YDFd6jmlqX2n2I4oryFS/VpMGS5wMBWDc90lxx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y9K+WbbdfYGGASwPHu+Zi6eU0fGRluwPckcAtiMPHeVLB/yoef1FsKZsfuHAH63pzlzvhoMueEb4q/0jk1t/n2vjMpq8Gg8efMYsdp/D8oBok3ZVGjnWZz/1bwqSMB4/ApvX5pAdvFM7Gl90sNYni0X09CCLKSfnrmweiEnDQxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com; spf=pass smtp.mailfrom=wiesinger.com; dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b=R4OZWQBp; arc=none smtp.client-ip=46.36.37.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiesinger.com
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id D2FA39F21C;
	Sun, 11 Aug 2024 11:39:35 +0200 (CEST)
Received: from [192.168.33.7] (wireguard7.intern [192.168.33.7] (may be forged))
	(authenticated bits=0)
	by wiesinger.com (8.18.1/8.18.1) with ESMTPSA id 47B9dA3Q1353501
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 11 Aug 2024 11:39:34 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 47B9dA3Q1353501
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1723369175;
	bh=jpXJVQ+ihy+4IDPOEydFEc3GlpL/fp7nRmw7oe3zROM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=R4OZWQBpDvy1JzSLfCJ6hdPcHVYx0q0Qp+UeZyBjc6cNT97ztIi2sL27rBvf4IpzB
	 9rJWBgpLYKTekvZV6z84eiZW9R958gLsWLhCmejYWyU1JUko6MUdsKa6DB9xduE+d2
	 dBlgubk/51LYpU+MVOqF0Pcp2Po/+l+Um985I0P6mrpNDnSjWtkxRb4dwuvM7TOYWJ
	 3vM1Zdp7uo17xAZffvKyti4sgblMQqJpN8htTqSodncsQOSbmxpFvPMZWb+j9aRzOi
	 gzdL1n6JrjBQ+UN1yGEAoIl9z75nNERTBWJpnB9m0snLN89BzwacJlelEdDK3AxnbN
	 qG0NuzSC6tMynvBX5Ll/ySG0CbWFfJkShtBqAh+qqwFDtfAlElxIa+/+Lf/2z7pHIG
	 OpzwysrsgzrS7jIkDnYHHYS1iavLKC2j6LXmYebapIjm6cOQWmetk5oWam67BwN9ka
	 rcYsqjbMltw00IK2ZRiCFvkHH56nv5ZEOg4ixmrM9bAhMasuEc2H4kfxuSE+EnTOYg
	 JUqvxUn4PVojt985J0LI5w+pekUJhtI/qRSMfcmwKjLxFehB2gLyJYtQPt1pqdQ7Zm
	 Q2nxwlaBEaIVNtGQ5ACFIvIQGOP7kvC5r2DGnYfO94N4Mbs3UMObcVKKN4UCDSFuud
	 czJ88QlaJ/+AAkYXAqC673Zg=
Message-ID: <2eb00476-d956-4b02-85e1-2ceea77034e9@wiesinger.com>
Date: Sun, 11 Aug 2024 11:39:10 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS doesn't compress on the fly
Content-Language: en-US
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
 <0c644c25-7ec4-43da-a70b-1632e87490b3@wiesinger.com>
 <ef780348-5570-4f5d-8c92-bf7bc4868752@gmx.com>
From: Gerhard Wiesinger <lists@wiesinger.com>
In-Reply-To: <ef780348-5570-4f5d-8c92-bf7bc4868752@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.12.2023 07:13, Qu Wenruo wrote:
>
>
> On 2023/12/22 16:28, Gerhard Wiesinger wrote:
>> On 03.12.2023 11:19, Qu Wenruo wrote:
>>>
>>>
>>>> BTW:
>>>>
>>>> if compression is forced, should be then just any "block" be 
>>>> compressed?
>>>
>>> There is a long existing problem with compression with preallocation.
>>>
>>> One easy example is, if we go compression for the preallocated range,
>>> what we do with the gap (compressed size is always smaller than the 
>>> real
>>> size).
>>>
>>> If we leave the gap, then the read performance can be even worse, as 
>>> now
>>> we have to read several small extents with gaps between them, vs a 
>>> large
>>> contig read.
>>>
>>> IIRC years ago when I was a btrfs newbie, that's the direction I tried
>>> to go, but never reached upstream.
>>>
>>> Thus you can see some of the reason why we do not go compression for
>>> preallocated range.
>>>
>>> But I still don't believe we should go as the current behavior.
>>> We should still try to go compression as long as we know the write 
>>> still
>>> needs COW, thus we should fix it.
>>
>>
>> Any progress with the fix?
>
> Tried several solution, the best one would still lead to reserved space
> underflow.
>
> The proper fix would introduce some larger changes to the whole delalloc
> mechanism.
>
> Thus it's not something can be easily fixed yet.
>
> Thanks,
> Qu

Any update on the issue or plans to fix it?

Thanks.

Ciao,

Gerhard



