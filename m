Return-Path: <linux-btrfs+bounces-7951-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE76C975CDD
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 00:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0CA285C84
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 22:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA30D15098F;
	Wed, 11 Sep 2024 22:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="qweQAQOA";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="dH//RFuD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42D613AA45
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726092334; cv=none; b=kU/m+7K6o3XH59+4+72YnU36iNF7NuWkNs+dW3v4mrfvxZxpsP0QVclbJAl3YRuyxo4O/5gudmXi9EyWINYj6nmNbiqRD60ni/D6V4EJGTCkKvf48TWA9s+xtCyGBHwckeItFEEEck+HMnCeNr1FaV2BZIKuTCVXWeHTma4CdMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726092334; c=relaxed/simple;
	bh=J3Jf0ppFXfPctUv2c21s7GEk8mgbt7L6TyFjUBl+Ts0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gA1+WbgmyBQ7IZfyo/EKb3hNUV2UTN03Ion1y5Q5OAVHc7/W5QPRwBmZKRRqqbc5D/oquqT+A0b+LzKx7Qqt7q5IizN8jkUEBp216nv8abZMqKv/SoKPSugaRDUM+4yXEmtUhE7++tSTe04y/XBky08RIDUfyqq4xW1jefmWR9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=qweQAQOA; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=dH//RFuD; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Message-ID: <b44f33ba-3230-476c-ba3e-cb47e1b9233a@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1726092328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gejaycbc2GLcMbUrtvJoLWh92HOYODYoEFiVZan3ctk=;
	b=qweQAQOApKy9MiE3kEI8YZVHNhjp6HwGJJnqC5wTkTLNMsOUcKfjS6E4ms3KhpTuSXiFhg
	snzw4uyCwu6Qughpd2aMBHhCFdnd4nLY1oocU4RXN6lNqF+6VS4JVJcrBNSDGnyNe7B5TU
	DYZ1BOagAocEFx6DoyCGekImrw1FrrVLv68prHk7TXTd0KYAuu2iYVJ5G61jWsJv5r/p4k
	KhMQT2omVLhb2duyB+XXb7ck3mHbQIsqgyESwmhMsa+lJAhsHGsZFGcZPZ/ZW90edTwJ6e
	GwaUZCtqlJj8ifLOYs63mo3aNGkz1cKb/eQwG4DRn81xluSL7LFBMTrrZL4UXdbPzpyoVE
	5CMuYSTIX6k6q5kyKyFE097UG04s2hp0XGej3YCfobUJfs6E0YcS9Zx81PW9S2fBxiN9Rz
	rPLJWC7swmA0XGj2ZDlQAc8huyneVDE3tk3x+0LwWqhBQ0W0eUrX2rlM6IAydr0vco/Gev
	9Uk77a8L3XR42PkG/0NXmOi7sP0AxOfBYx3/scLu0dDc5Vn1IQS5s6w5hWfKHj9mbgK+E9
	sNTxyWjOifxl7tt8eVKmgjsw0pAaKyxWB1oL0UY0XOhsh7ctNvCgBnUX63/caO40Uy23Gy
	Jq5cqia/iDS0krG3MUA/d9g1e1AmRsm9r++/bfCBZ/VwmCtDsF/D0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1726092328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gejaycbc2GLcMbUrtvJoLWh92HOYODYoEFiVZan3ctk=;
	b=dH//RFuDbFTqj27OkqWbxWIeuCzAfaz6oWU/1ehP4wzZ3jsmGKxpysjYllIAGPG5Q/dIpN
	9mod0QMYR/fQhJCg==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=archange smtp.mailfrom=archange@archlinux.org
Date: Thu, 12 Sep 2024 02:05:17 +0400
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
Content-Language: fr-FR, en-GB-large
From: Archange <archange@archlinux.org>
In-Reply-To: <e81fe89a-52bc-4629-a27b-c69d64c9fbec@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 12/09/2024 à 01:23, Qu Wenruo a écrit :
>
>
> 在 2024/9/12 06:50, Archange 写道:
>> Le 12/09/2024 à 00:54, Qu Wenruo a écrit :
>>> 在 2024/9/12 05:25, Archange 写道:
>>>> Le 11/09/2024 à 01:37, Qu Wenruo a écrit :
>>>>> 在 2024/9/11 06:58, Qu Wenruo 写道:
>>>>>> 在 2024/9/11 06:35, Archange 写道:
>>>>>> […]
>>> […]
>>>
>>> That being said no critical error has been encountered since I’ve 
>>> had to
>>> repair my boot, but I’ve not tried to scrub from the running system
>>> again, should I do that (as it used to trigger the error before)?
>
> Please do a `btrfs check` to make sure everything is fine.

While the previous one (see my second message in this thread) had no 
error, there is now one:

# btrfs check /dev/mapper/rootext
Opening filesystem to check...
Checking filesystem on /dev/mapper/rootext
UUID: e6614f01-6f56-4776-8b0a-c260089c35e7
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
wanted bytes 688128, found 720896 for off 676326604800
cache appears valid but isn't 676326604800
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 478434086912 bytes used, error(s) found
total csum bytes: 465136176
total tree bytes: 1590493184
total fs tree bytes: 870760448
total extent tree bytes: 138231808
btree space waste bytes: 326062620
file data blocks allocated: 516090466304
  referenced 492383629312

> For the bad free space cache, I'd recommend to go v2 space cache instead.

Since the above error seems related to space cache, and that I had 
switching to v2 on my todo list for a long time, I’ve just did so.

dmesg mount messages right after (nothing unexpected I guess, outside 
the warning and “corrupt 4” still present):

[  812.242212] BTRFS: device label root devid 1 transid 6065207 
/dev/mapper/rootext (254:1) scanned by mount (2145)
[  812.243727] BTRFS info (device dm-1): first mount of filesystem 
e6614f01-6f56-4776-8b0a-c260089c35e7
[  812.243770] BTRFS info (device dm-1): using crc32c (crc32c-intel) 
checksum algorithm
[  812.243788] BTRFS info (device dm-1): using free-space-tree
[  812.256356] BTRFS warning (device dm-1): devid 1 physical 0 len 
4194304 inside the reserved space
[  812.258504] BTRFS info (device dm-1): bdev /dev/mapper/rootext errs: 
wr 0, rd 0, flush 0, corrupt 4, gen 0
[  812.810623] BTRFS info (device dm-1): creating free space tree
[  819.778945] BTRFS info (device dm-1): setting compat-ro feature flag 
for FREE_SPACE_TREE (0x1)
[  819.778949] BTRFS info (device dm-1): setting compat-ro feature flag 
for FREE_SPACE_TREE_VALID (0x2)
[  819.877973] BTRFS info (device dm-1): cleaning free space cache v1
[  819.885829] BTRFS info (device dm-1): checking UUID tree
[  866.299565] BTRFS info (device dm-1): last unmount of filesystem 
e6614f01-6f56-4776-8b0a-c260089c35e7

I’ve run check again after that:

# btrfs check /dev/mapper/rootext
Opening filesystem to check...
Checking filesystem on /dev/mapper/rootext
UUID: e6614f01-6f56-4776-8b0a-c260089c35e7
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
there is no free space entry for 0-65536
cache appears valid but isn't 0
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 478312665088 bytes used, error(s) found
total csum bytes: 465136176
total tree bytes: 1593524224
total fs tree bytes: 870760448
total extent tree bytes: 138231808
btree space waste bytes: 326060271
file data blocks allocated: 515966013440
  referenced 492259176448

So there is still an error, but different this time.


