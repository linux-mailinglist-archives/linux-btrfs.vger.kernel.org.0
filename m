Return-Path: <linux-btrfs+bounces-19269-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F53EC7D251
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 15:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54A3B4E6A33
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3F826CE37;
	Sat, 22 Nov 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mazyland.cz header.i=@mazyland.cz header.b="PDSvH6BR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpx020.webglobe.com (smtpx020.webglobe.com [62.109.154.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830C6257859;
	Sat, 22 Nov 2025 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.109.154.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763820676; cv=none; b=k6E+A6zcucCxHmohnWgTVdJkVhwM4KciI0TU7T4Wh0wZr6bqqPC61tmR+8OTG4DtEDKM3OtDUjJhOcEkazqYLwwwmrYbXSQ+ETvQxHH0r3RvbMPYJvHS1M54kjFt4iFY4cYEP6uGOKxcvD0+0L1hiPhh33fDkbtOWKJSCa++dUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763820676; c=relaxed/simple;
	bh=5TrXtSA0/pYdIyPAN4d16C3W2BnqeSt5EoS6fDSdu+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hnqwa1nOFWQKSxcr7CGx7gAshWBEBfNop4MoIYMPFOHEqICKYTOeAO0YKOn4JjXy4JJReJ+wrTnHD772snr3eO1JHIL5f6HyHvhKXFKdVrsWPWY6bvh3MLndCv9AcMx6o7oDfi5Wuz5QuuGK0taIC80ItINsO5KezS2J1E89ZAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mazyland.cz; spf=none smtp.mailfrom=mazyland.cz; dkim=pass (1024-bit key) header.d=mazyland.cz header.i=@mazyland.cz header.b=PDSvH6BR; arc=none smtp.client-ip=62.109.154.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mazyland.cz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mazyland.cz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mazyland.cz
	; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bkpfSprlu8mGib1c1nujr3uybcLVrrvCT0grlaS+iiU=; b=PDSvH6BRtX/qkR4mGWWMFMJ7Qr
	RUcdAyXi00bDVuk74RuOjsK9cTjuuZ8+5bn2SxUaSJymq/gBTEgXgWlX3Q5gmMe4aDtygV82SZAfq
	WXglxuheiEIXcoZyhVfDgrBS9eLX6TK9Cw0N1CDDb80mxwTBAHq6sgO1g3ayAJlllGA0=;
Received: from [62.109.151.60] (helo=mailproxy10.webglobe.com)
	by smtpx020.webglobe.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <milan@mazyland.cz>)
	id 1vMo1o-0059ua-25; Sat, 22 Nov 2025 14:51:52 +0100
Received: from 85-70-151-113.rcd.o2.cz ([85.70.151.113] helo=[192.168.2.14])
	by mailproxy10.webglobe.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <milan@mazyland.cz>)
	id 1vMo1o-00CJls-6Z; Sat, 22 Nov 2025 14:51:52 +0100
Message-ID: <aa2ea539-368d-409e-afd6-f1e547497ed2@mazyland.cz>
Date: Sat, 22 Nov 2025 14:51:50 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pm-hibernate: flush disk cache when suspending
To: Askar Safin <safinaskar@gmail.com>, mpatocka@redhat.com
Cc: Dell.Client.Kernel@dell.com, agk@redhat.com, brauner@kernel.org,
 dm-devel@lists.linux.dev, ebiggers@kernel.org, kix@kix.es,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-lvm@lists.linux.dev, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, linux-raid@vger.kernel.org,
 lvm-devel@lists.linux.dev, msnitzer@redhat.com, mzxreary@0pointer.de,
 nphamcs@gmail.com, pavel@ucw.cz, rafael@kernel.org, ryncsn@gmail.com,
 torvalds@linux-foundation.org
References: <c44942f2-cf4d-04c2-908f-d16e2e60aae2@redhat.com>
 <20251103155345.1153213-1-safinaskar@gmail.com>
Content-Language: en-US
From: Milan Broz <milan@mazyland.cz>
In-Reply-To: <20251103155345.1153213-1-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: milan@mazyland.cz
X-Mailuser-Id: 923906

On 11/3/25 4:53 PM, Askar Safin wrote:
> Mikulas Patocka <mpatocka@redhat.com>:
>> [PATCH 1/2] pm-hibernate: flush disk cache when suspending
>>
>> There was reported failure that suspend doesn't work with dm-integrity.
>> The reason for the failure is that the suspend code doesn't issue the
>> FLUSH bio - the data still sits in the dm-integrity cache and they are
>> lost when poweroff happens.
> 
> Thank you! I hope I will test this within 2 weeks.

Hello,

Did you manage to test the patches?

This issue should not be forgotten, as dm-integrity corrupts data during suspend.

Thanks,
Milan

