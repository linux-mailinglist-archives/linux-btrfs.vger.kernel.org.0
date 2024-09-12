Return-Path: <linux-btrfs+bounces-7966-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A9A97662D
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 11:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896561F27D53
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 09:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804A119F12C;
	Thu, 12 Sep 2024 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="RhQ7PkFz";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="B2v00zLB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BEC1917CD
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135071; cv=none; b=gX+p/omSXKhDNHsQzvlrP308CpVMCvy/qqmCrkP7Vka8V+OE63GU09q/v4+sBrDGpEGhohgl9WadOFdKoJWoP8fj3T9545/aE/+D3/XYsw7oMC843er84oVWatFDWf4p9WQJae9YS7hPY5ukC8iX54T9Fb3v3kwWkq4WQan4KjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135071; c=relaxed/simple;
	bh=yWmwkLXAMj5n8DtsRgecGPNJ5uvxAFtDHv4ifuiQ/f4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mJlyyaspypXnigyPpt+NwwlbQMY7WJJ/P/wtsX2c5fxD/BTAYFd0dr47OdI6TF90n4xj/FhtPa/pEjXb1cRKAQnFMpf+VChB2/A/VV9wQ5PQaXu8D5YjlW/FW+4Y/zIWj7dJ0alp7V+Em8FeJwl7I9m2TWkoWS3sguZqL5A7AS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=RhQ7PkFz; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=B2v00zLB; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Message-ID: <3bfdf0ee-9efa-44b8-b9fd-cabcf90875ec@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1726135065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWmwkLXAMj5n8DtsRgecGPNJ5uvxAFtDHv4ifuiQ/f4=;
	b=RhQ7PkFzFw54+Dm8zMA0G1CqBocLMpcFenxVGD+7HsLTAV4yH9NYH6xlsdYZf6UJiPNkoP
	mQQGy/EqRDu0PWQY74WUquEs3YLwmnrLWeqlys57l7UQz1fBjavjWio65GSzAADBn/a5MJ
	8xIZi9EYQksDhycszd+cOLblil/R0pNNfrKRfxu9NSdw3uOb0Xo8i+HyMoqyApteudwFeO
	6KYdn9nEuWP4s2X7w/JNgMM2ppYHSsiy7znFBSDriuM01BlY9pz460S7UQ2A+52b24k3jH
	ij99DR4BbAlfCtXiWMmgb8OrvmAs1oNJNJCq6XsJwv8XuLbGuju3FitJNn1PkQca2SXga4
	FEaj6id3ba8o/K+5MyeEw5ejhjByBRaMt5PsaFzbatW/P9LVkQokkwkI98GLFGEI2Uwm/C
	RLeIXj7A85WuZW7zG5Mwf0WE2KvbucgjEJ3Z+BCXp3qXN9oURpQOQfgpTbPKwKjyP+BaYW
	aRDbZfaVFvhpJM6Gi/xPq/4ehmR6WGd/5aWOEIp9tT70/KeJdcdExtg3cpNEurFfa0CAa/
	kG9fGhHNvH+/4DUPVGIfrUh0wv16rBy+ka60eKjNxG8LqTfMWPzcOtTpl9gewuqB49+8XA
	AtRIBls7GYi8MhB2thEDEl1xMrcZbwk8TCY7LXlLtURXnVOC7V2wQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1726135065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWmwkLXAMj5n8DtsRgecGPNJ5uvxAFtDHv4ifuiQ/f4=;
	b=B2v00zLBkGnUwtizUNbq3G696U1kOe/DGRcvngEJucbEoH9N4grb7AlZSBvSqDyWmr7JlJ
	r3Jg5TIs7INxBMAA==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=archange smtp.mailfrom=archange@archlinux.org
Date: Thu, 12 Sep 2024 13:57:39 +0400
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
 <66e28d81-7162-4ab4-b321-088ee733678e@archlinux.org>
 <523adab7-9a88-4c27-93bf-a85fd87162d8@gmx.com>
Content-Language: fr-FR, en-GB-large
From: Archange <archange@archlinux.org>
In-Reply-To: <523adab7-9a88-4c27-93bf-a85fd87162d8@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 12/09/2024 à 12:25, Qu Wenruo a écrit :
> 在 2024/9/12 17:51, Archange 写道:
>> Le 12/09/2024 à 02:34, Qu Wenruo a écrit :
>>> 在 2024/9/12 07:35, Archange 写道:
>>>>
>>>> Le 12/09/2024 à 01:23, Qu Wenruo a écrit :
>>> [...]
>>>>
>>>> While the previous one (see my second message in this thread) had no
>>>> error, there is now one:
>>>>
>>>> # btrfs check /dev/mapper/rootext
>>>> Opening filesystem to check...
>>>> Checking filesystem on /dev/mapper/rootext
>>>> UUID: e6614f01-6f56-4776-8b0a-c260089c35e7
>>>> [1/7] checking root items
>>>> [2/7] checking extents
>>>> [3/7] checking free space cache
>>>> wanted bytes 688128, found 720896 for off 676326604800
>>>> cache appears valid but isn't 676326604800
>>>
>>> Minor problem, still I'd recommend to run
>>>  `btrfs rescue clear-space-cache v1 <dev>` to clear the v1 cache first.
>>
>> I indeed did that as explained in the second part of my message.
>>
>>> Then you can mount with v2 space cache or keep going with the v1 cache
>>> (not recommended, will be deprecated soon)
>>
>> Done too.
>>
>>> And if your fs only have subvolumes 5 (the top level one), 257 and 258,
>>> then you're totally fine to continue.
>>> I guess that's the case?
>>
>> Indeed!
>
> Just in case, you can run "btrfs check --mode=lowmem" to check if there
> is no more inode cache left.
>
> If there is any left, lowmem mode can detect it with errors like:
>
> ERROR: root 5 INODE[18446744073709551604] nlink(1) not equal to
> inode_refs(0)
> ERROR: invalid imode mode bits: 00
> ERROR: invalid inode generation 18446744073709551604 or transid 1 for
> ino 18446744073709551605, expect [0, 72)
> ERROR: root 5 INODE[18446744073709551605] is orphan item
>
> And I'm already adding the ability to the original mode check to detect
> such problem.

No such thing appeared during the lowmem check. Only the

[3/7] checking free space tree
there is no free space entry for 0-65536
cache appears valid but isn't 0

is still there.

Archange


