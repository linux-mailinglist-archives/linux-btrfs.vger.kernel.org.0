Return-Path: <linux-btrfs+bounces-7959-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC3F97645F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 10:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671B72876AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 08:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C472219258E;
	Thu, 12 Sep 2024 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="qCNrk93J";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="hYzSU5bi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1421922D3
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726129313; cv=none; b=FUOPp0GPohri60wWtp4pyZ32PLW5d4r2vdOCw8e+QsuEPkmoWGPVYWwawuboDemJ7GwR3n030yIxmo9ug4DEzMxKOIRNkT1QkBTFApc8a3K88ojR+Nl0ShrBqwnCMKOq/k+GRL5NJgxFvHYvYHRW1YLdkGBTGdvUagoJXVXllPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726129313; c=relaxed/simple;
	bh=W+YY/H55fSBJw+d8x/D/hsb8H3W0eUcN//F+VSu9VpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tRjixQLAaCUJNMt8Dfb6cCrXQXHnGHENNQ1xCxK1/Xs7W+9w4eWD2/+SsYxPcxoWMMjaDDzFGDLQ9+7kC3sHcs/N4I67o9wLL2q26LCo/N298nFgN3v2/Cb/ZNAs3jBOAOQhhJCPZxghnpFpd3x9BOdpIB68SfSI2NzXHS/t5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=qCNrk93J; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=hYzSU5bi; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Message-ID: <66e28d81-7162-4ab4-b321-088ee733678e@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1726129308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+YY/H55fSBJw+d8x/D/hsb8H3W0eUcN//F+VSu9VpE=;
	b=qCNrk93JIDtAV2TnieavF4anQp1Ap6kFHAyETIcF6FEBNYdkG+Ood1CUNktu49dxzNw9PI
	FD95J5xo0iSaWe42FIOVwyzEGw31OX1lFPv8HW6RPjUCqmELIaD9ZnERK8yPrn+pj594il
	nvpoQuQOSIaP2tiESObL1tt7pD+uXNIVta9GozNChgoAIQz9QsSwetf8lRXPfvgmvMpsg8
	KfIBfXqKv9F6ohXGyWFY54XFGtQDwZpQJ0tJOgCyAjI3BbjBggSHGzyqYt1UsGltDzK/4t
	5ls+1R+tAAkLgSvSE/tc7hJVdI/HOcZCxTXNlBsW9Pc5Jb4DEzJR9jq+HA/GovoSEiupqQ
	RP8t8Wz0FDazqqq2ar3gZPr2pGAPmzx3SAp5BWXxRV2JYHsRTTbhXOr+KCcE941HYE0787
	0NmFpsC5cIdcHs9SAtW9G6o7OiZBydmcAPxHaY46Hn7pikukDoNUuA7eJ5PgQscLtT/JxG
	kkWF4wdGTfgw//5SooweievX17pFPWdZbQoJGoFBYXYxUduA4fw+uiMoIvSKaYIon74AY2
	DBiCj2UXyeT/kjnveZVLwUlQQ+GPerqKoFJD+FqMQVgQBXf2bbuUHyl1zWcs6Nio0VB/rB
	AZ+kitrL4TbRtQffu+g1vdOEKagg/OJK9cbbFeeuDIHKnVIPNk0Bc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1726129308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+YY/H55fSBJw+d8x/D/hsb8H3W0eUcN//F+VSu9VpE=;
	b=hYzSU5biC4AbGa0mhyE9y8Oe3Uuny7bzPQeO8HNaNYD+l0hPa85TYgELWrNwa+HoOZu3E2
	W+6ESxR5wjkXymAw==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=archange smtp.mailfrom=archange@archlinux.org
Date: Thu, 12 Sep 2024 12:21:38 +0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Critical error from Tree-checker
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <9541deea-9056-406e-be16-a996b549614d@archlinux.org>
 <244f1d2b-f412-4860-af34-65f630e7f231@gmx.com>
 <3fa8f466-7da9-4333-9af7-36dabc2a2047@gmx.com>
 <4803f696-2dc5-4987-a353-fce1272e93e7@archlinux.org>
 <914ea24d-aa0d-4f01-8c5e-96cf5544f931@gmx.com>
 <2cec94bd-fc5e-4e9c-acc9-fb8d58ca3ee1@archlinux.org>
 <e81fe89a-52bc-4629-a27b-c69d64c9fbec@gmx.com>
 <b44f33ba-3230-476c-ba3e-cb47e1b9233a@archlinux.org>
 <57614727-8097-4b43-93f5-d08a078cbde9@gmx.com>
Content-Language: fr-FR, en-GB-large
From: Archange <archange@archlinux.org>
In-Reply-To: <57614727-8097-4b43-93f5-d08a078cbde9@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 12/09/2024 à 02:34, Qu Wenruo a écrit :
> 在 2024/9/12 07:35, Archange 写道:
>>
>> Le 12/09/2024 à 01:23, Qu Wenruo a écrit :
> [...]
>>
>> While the previous one (see my second message in this thread) had no
>> error, there is now one:
>>
>> # btrfs check /dev/mapper/rootext
>> Opening filesystem to check...
>> Checking filesystem on /dev/mapper/rootext
>> UUID: e6614f01-6f56-4776-8b0a-c260089c35e7
>> [1/7] checking root items
>> [2/7] checking extents
>> [3/7] checking free space cache
>> wanted bytes 688128, found 720896 for off 676326604800
>> cache appears valid but isn't 676326604800
>
> Minor problem, still I'd recommend to run
>  `btrfs rescue clear-space-cache v1 <dev>` to clear the v1 cache first.

I indeed did that as explained in the second part of my message.

> Then you can mount with v2 space cache or keep going with the v1 cache
> (not recommended, will be deprecated soon)

Done too.

> And if your fs only have subvolumes 5 (the top level one), 257 and 258,
> then you're totally fine to continue.
> I guess that's the case?

Indeed!

Thanks a lot for your help,
Archange


