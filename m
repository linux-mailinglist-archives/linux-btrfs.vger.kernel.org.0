Return-Path: <linux-btrfs+bounces-7971-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 573AF9768D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 14:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5764B21E93
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 12:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8DA19F414;
	Thu, 12 Sep 2024 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="egCoRTEH";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="uGClwg16"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4FF1A262F
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726143237; cv=none; b=JOqolPxEQqeKAjPQkrc6aam/HZmsRbVIUP2diQIbsNszI3XDZD+ucRK6Yx73fBQA7u7eTIRCRM26cxEOeLTc6Va47uvn3foWFoQbU/rTTDEYW9/8I9Wa7bn9+voqz5P86Q44NsY2fJ11ry3dp0huuf26MSaLxIDkpzGTtLZbHzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726143237; c=relaxed/simple;
	bh=5O5g2/Qs3/5enJiNVYSp63HC2naBZIb3AgwHBNsF3pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D8E0zCnkwRqFAQrHFzEnPnB8BiI9/KLxFNnkpZ97m5yuuNFPfstIrBcEQ/dDso7sdJYwY5JIuaVLra4uP4n3wyd7Z7nLJeJUkal0JOg5mhh2CD064a5OK19EFzCDXdC0edMJdxOWYDt3RJxHsA+RVfqF6xzS8+SUyD5d5k0xhIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=egCoRTEH; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=uGClwg16; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Message-ID: <ccf78d58-a050-4ba7-853b-37b6a1386a69@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1726143232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1kYDXq6cKWm74KrRsZcBmgL+5UXoa8RnRzAVkTXFTU=;
	b=egCoRTEHNw0qKbyT3/A/bk0DaXGVQV6Ky64w8RuBBLqjTE79V3ZCyrtf2gr/I8F8/Ej3Re
	MG/eiCxqlSn7ULVyQqIod9NvdUNtvGA5z1LAimPRgE1MUuHHWJzW0VSKsZ7BT5S9rI2hCJ
	HuUNsxpYknG8qJd94tJK9IxyNfaQ/aA+5RGJAyYQbXoQKxjPAnVs8fFGi0aesLNBNY5X3W
	P/3C7+xUw3NtLTXwt+sONfeCCeqnpFHKi9vDL1WbUpHCqdwEY6uoDpNpJWmydPeQZDvSbS
	YQe90Y6aAsnsND5lp7xTLSdueG4aCgq6NMIDHMfYkWXBp6O4RYl0ekZrLfMtVdrFgskzbq
	9fv2Qf7nHeWrN7kYN9fffj5O62/fWRqazjv4nSl7IdAC6pKfET2EXG4+r9ERyArqQazUqI
	j25481r+/Iyj6ZXRkU+/FIU7KBrOYkOOdzhQZ5e64KV8WKcKTbFdt9S03kNvSEvmtAHUFF
	Ek5KSgCCwOba9sZfiSa1DKrsvW0v4u+jZobhBxCk7/5CZmvVyfrPMe/c6XcZVPgk/1p8Tr
	1G5SI2MQylVkJ4oE7yRsgwSbJgvjUtnROopn1niuFSSpRempDFMMttqrD26YocbcAI61ZG
	lnv+oWOIPCiGwD1ftbOQGSL2FIg81TqcieatoD/CFiB9OCkO+6+20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1726143232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1kYDXq6cKWm74KrRsZcBmgL+5UXoa8RnRzAVkTXFTU=;
	b=uGClwg162wTw10PYYOa6c+xvGdX+AkhIYXwHQHX7gLUJXI12fJPuFYkLU9wEtoTjs28HKl
	XWKN8sSHNL+5npAg==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=archange smtp.mailfrom=archange@archlinux.org
Date: Thu, 12 Sep 2024 16:13:45 +0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Critical error from Tree-checker
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
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
 <e1dc1add-0bb7-4d13-8929-a1bfdb8181bf@archlinux.org>
 <650f2de0-c5e5-4e3c-aa0e-ff79d931a263@gmx.com>
Content-Language: fr-FR, en-GB-large
From: Archange <archange@archlinux.org>
In-Reply-To: <650f2de0-c5e5-4e3c-aa0e-ff79d931a263@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 12/09/2024 à 14:23, Qu Wenruo a écrit :
> 在 2024/9/12 19:34, Archange 写道:
>> Le 12/09/2024 à 14:01, Qu Wenruo a écrit :
>>> 在 2024/9/12 19:27, Archange 写道:
>>>> […]
>>>>
>>>> [3/7] checking free space tree
>>>> there is no free space entry for 0-65536
>>>> cache appears valid but isn't 0
>>>
>>> Then it's totally fine.
>>>
>>> For the 0-65536 problem, mind to provide the following dump?
>>>
>>> # btrfs ins dump-tree -t fst <device>
>>>
>>> I'm afraid since the fs is somewhat old, there may be some corner case
>>> btrfs-check is not handling properly.
>>
>> ERROR: unexpected tree id suffix of 'fst': t
>
> My bad, it should be "btrfs ins dump-tree -t free-space <device>".

The output is too big for an email, so uploaded here:

https://paste.xinu.at/XtR8/

> And if possible, also "btrfs ins dump-tree -t extent <device>" just in 
> case.

Same thing (even bigger), also output on the terminal and while 
redirecting to a file was quite different (but maybe that’s more because 
something changed between the two calls), so here are:

– the cli run : https://paste.xinu.at/9vs/

– the file run: https://paste.xinu.at/XpzhbZ/

Regards,
Archange


