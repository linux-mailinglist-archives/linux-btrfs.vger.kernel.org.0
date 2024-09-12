Return-Path: <linux-btrfs+bounces-7968-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECEE976649
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 12:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9391F22AD4
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 10:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BBF19E96F;
	Thu, 12 Sep 2024 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="TJNCNrf7";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="zMVjUjPp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849BA136328
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135462; cv=none; b=QcDzlImFHrGaMOqPcVgvBmtozY3GCjZwx0x5tzZLrVpCc+CyPEl18vR6nPCz4sSDPlh9kl6Vi97skFhWvCTIDyms12WkJrj1SJdh2THvMd2ae8chGV+2fuV06EqAH+DvYtvr6BletML8hfRDeq/Q8kpOdcF8lA6MVnPVRrMJ/Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135462; c=relaxed/simple;
	bh=WmZoRA+UKUm04fKaPeVLgATO3MGF/OJjHOmL0nO/Pk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UAC4krd1oq1NXll7Vn5NtiukR8GSX4SwZX8Pruq6FkWzlU3CxLuOr8eB9Ygs5sKRjgGJy7PnLlDr4DBOtHXadjdig41KiCRXLpW5I59W+hk2fGwQfkhquJshdX+0Q7Zo2NQRspU8nJAYrnaXXEaL9gQk5mOzMmSkxllDnsk6y3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=TJNCNrf7; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=zMVjUjPp; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Message-ID: <e1dc1add-0bb7-4d13-8929-a1bfdb8181bf@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1726135458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZM8+CxT9p0UhmzgABCvnbOPVWAnVyn9Qt9HGJNbGvOg=;
	b=TJNCNrf7nChz+BiiKgud+NGlIjDjB3156xsu687yL10niwGUt2l3zRRw+KesiYH7oEi+wq
	Esef8dg4ZzGkS+TVR6zfzF/3W1c+gfKIkzam5FBKoGXbclBgqwRB8Ub6H8IrgPWKi8lcVZ
	8V5gEXRMtLlndG/mlS3wXhEmUt5btFdQTjYxImXGoriiENhmsvbiJhIt5f9meXd8+vECan
	I5YejledT0aQs0wLFWbSdVBFcaaT5jVtsZoICQJMOyFHMdrH9sivIzBaL/RFCAuoarwkh0
	z06P0EWdQByK3fqzFHEkVzRqoYsq8JbX8KWvTZjEpODoN8KNR80geLyHkEd+YQCNDuSHk9
	Cbc+bq8pmmtTJ/MwvZhPLAF7hQ0MWeAmnrCscPx7JDs0tWjmZkqYjwkrtOXnlZPB10BK3n
	vyB3W08bj8V4Y0ZUQIJM2wdTJZiS/+XRu8Bqbwto4nFze82JPbsd++HmaOvDhbo55rOiAv
	Bfm45itUMfUDv3FLO9jjwAewp03lbp/CrorPEoJhFjcSu1TcUlss5vEaH9tcH2gQPIcpgA
	OURnnzum5BwVmP7WxAkLkrK97bzM9beAiQacWWq0lscj4dbZ7pkClE9TdufV4nySg/FjV9
	aPE2WSGP42PmAmrrWFwt4xv9+QNJSL5cKitbuEye0J3I4es0f8gPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1726135458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZM8+CxT9p0UhmzgABCvnbOPVWAnVyn9Qt9HGJNbGvOg=;
	b=zMVjUjPpsp0mFQVBKZpkjJ3zOg+760lyNDBf/cH60U3m3R9j8fwgYBxLBjAqQM58O54VRx
	0FcuV0q9VrtjFlAQ==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=archange smtp.mailfrom=archange@archlinux.org
Date: Thu, 12 Sep 2024 14:04:15 +0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Critical error from Tree-checker
To: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org
References: <9541deea-9056-406e-be16-a996b549614d@archlinux.org>
 <244f1d2b-f412-4860-af34-65f630e7f231@gmx.com>
 <3fa8f466-7da9-4333-9af7-36dabc2a2047@gmx.com>
 <4803f696-2dc5-4987-a353-fce1272e93e7@archlinux.org>
 <914ea24d-aa0d-4f01-8c5e-96cf5544f931@gmx.com>
 <2cec94bd-fc5e-4e9c-acc9-fb8d58ca3ee1@archlinux.org>
 <e81fe89a-52bc-4629-a27b-c69d64c9fbec@gmx.com>
 <b44f33ba-3230-476c-ba3e-cb47e1b9233a@archlinux.org>
 <57614727-8097-4b43-93f5-d08a078cbde9@gmx.com>
 <66e28d81-7162-4ab4-b321-088ee733678e@archlinux.org>
 <523adab7-9a88-4c27-93bf-a85fd87162d8@gmx.com>
 <3bfdf0ee-9efa-44b8-b9fd-cabcf90875ec@archlinux.org>
 <ca541404-4bfd-41b8-9afd-735bce6db663@suse.com>
Content-Language: fr-FR, en-GB-large
From: Archange <archange@archlinux.org>
In-Reply-To: <ca541404-4bfd-41b8-9afd-735bce6db663@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 12/09/2024 à 14:01, Qu Wenruo a écrit :
> 在 2024/9/12 19:27, Archange 写道:
>> […]
>>
>> [3/7] checking free space tree
>> there is no free space entry for 0-65536
>> cache appears valid but isn't 0
>
> Then it's totally fine.
>
> For the 0-65536 problem, mind to provide the following dump?
>
> # btrfs ins dump-tree -t fst <device>
>
> I'm afraid since the fs is somewhat old, there may be some corner case 
> btrfs-check is not handling properly.

ERROR: unexpected tree id suffix of 'fst': t

Archange


