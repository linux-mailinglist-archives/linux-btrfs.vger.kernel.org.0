Return-Path: <linux-btrfs+bounces-7952-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F396975CE5
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 00:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7E61C209E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 22:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57DB181334;
	Wed, 11 Sep 2024 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="FF65FBXh";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="MMC7R97s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DD6273FC
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726092376; cv=none; b=LqBn4w9jDRu9i7RudFExKaxWxLYOSJbt8E2FVaMFjKk2/3dSMKXtJPtEyw5Xsut+9Ybhyg+QBU5wIYCd2f86xSX6hFOYs1hFo7Vw09d7ChkRyZoHytj1Kg4uuAXNF5qugKqajq/xkRHeq/YAdO3WkNizCM1mKToM0fjcDkT4vdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726092376; c=relaxed/simple;
	bh=/YgO20s/0P4OH0Rlhmdc/rLQx3mrqRCsvAcS5jaLMgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CYFiOHTCIH/CsoS7Ro02BViJFiF00i4m69/bWrHIb+RhRjF1bcSHA4QL+E9djn5K6aebwDyZUTiyTUYO5QVByl5LwN48aUeq9tY0F8tp2OUftTqUCDWOQ4/yqJQ8ol5HRklqKNcs3RTHzdrtKCAyTTN/udIxl6LUVavHMslDQ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=FF65FBXh; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=MMC7R97s; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Message-ID: <38982480-217f-41c4-b6b7-fd627f6fa61d@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1726092372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyHSEtcCXx91i91ErN64sB1uqdkSRiF81YaPWihWDOw=;
	b=FF65FBXhmnXfEyKuE07BovJ4ITkRqadV8vD3JNXZmwOZv763iiz+lEoFAsnvFXU/sD38B1
	VJEWzeLzNJDZDpK5kvbN5u+f+evifu+o4TWlvQe6GX9fv+Dn3w8xGakZ7AcLtG4bI5JIZV
	d7SWtdtLFTRWlSryN4Yduohsq73Lw0dHVseSobNCITaAE7qSMDWd7OujWUG/2ayzYigjJy
	DdFQ8dVxkdqF0xoLs+hCFINnNjC5dz5mfu8DsIXMl0wmj0Lc/NZSph/QyJfaTqPkAUQpcG
	u5RMirhCAzZJCy+IcNwt0Ytcac2MJVxuYA4O09a4NOA7xirUmeOM1+PP4CV5oPZ6YNbftT
	u2rIFNQMC/eESWZeVUMsmpMPxc1lqKGJTeDSo2JRXwbJMfKbODXlFhbjVacvLzY1shBpwX
	qOKeTWvWXJnQ43WAqkpYkItgJe30fJGBA2ZUjBOPhsCC9zKIztfaFOgm0Nek5I9tzVMgnn
	BLuuO09ZDU/ndzsK5kAJfFhTymNeh5k9Jlx+XKBwvbK6Wvb9Pbv3qZoSTexa2Qiw52ECTd
	JZDeSh+F4QsPES7t4Rrf0qV4UDsDM1johD1OiY+mjZq6bzPeijjGsB29e8OrTvFK3gTZWO
	T9bDAmwyEDcHXHdmVHhB/6QbrkE/Ik7vgENyYeot0B6kVLTJftTkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1726092372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyHSEtcCXx91i91ErN64sB1uqdkSRiF81YaPWihWDOw=;
	b=MMC7R97s3cDMVjjUMOV/1fRS96Nwk3wTk7d0UtgYSfSoe9YvrHzvq0VVQGZ1u9VpD/peH0
	QDWVdjriKSz8weCQ==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=archange smtp.mailfrom=archange@archlinux.org
Date: Thu, 12 Sep 2024 02:06:10 +0400
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
 <ceb08d0d-2117-4d8a-aa94-8703c06198d5@gmx.com>
Content-Language: fr-FR, en-GB-large
From: Archange <archange@archlinux.org>
In-Reply-To: <ceb08d0d-2117-4d8a-aa94-8703c06198d5@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 12/09/2024 à 01:42, Qu Wenruo a écrit :
> 在 2024/9/12 06:53, Qu Wenruo 写道:
>> 在 2024/9/12 06:50, Archange 写道:
>>> Le 12/09/2024 à 00:54, Qu Wenruo a écrit :
>>>> 在 2024/9/12 05:25, Archange 写道:
>>>>> Le 11/09/2024 à 01:37, Qu Wenruo a écrit :
>>>>>> 在 2024/9/11 06:58, Qu Wenruo 写道:
>>>>>>> 在 2024/9/11 06:35, Archange 写道:
>>>>>>> […]
>>>>
>>>> This looks exactly like another report that is caused by inode cache.
>>>>
>>>> So in that case, mind to try the following commands?
>>>>
>>>> # btrfs rescue zero-log <device>
>>>> # btrfs rescue clear-inode-cache <device>
>>>
>>> I supposed the second command was meant to be `clear-ino-cache` (I
>>> remember having to remove `inode_cache` from mount options some time 
>>> ago
>>> as it prevented booting, I had then discovered the related feature had
>>> been deprecated and removed).
>>>
>>> Here are the command outputs:
>>>
>>> # btrfs rescue zero-log /dev/mapper/rootext
>>> Clearing log on /dev/mapper/rootext, previous log_root 0, level 0
>>>
>>> # btrfs rescue clear-ino-cache /dev/mapper/rootext
>>> Successfully cleaned up ino cache for root id: 5
>>> Successfully cleaned up ino cache for root id: 257
>>> Successfully cleaned up ino cache for root id: 258
>>> corrupt node: root=7 block=647369064448 slot=0, invalid level for leaf,
>>> have 1 expect 0
>>
>> This is not expected, I guess I have to double check the inode clearing
>> code to be sure.
>
> It turns out to be a bug in the inode cache clearing code, that it holds
> a path meanwhile the fs can be modified halfway.
>
> I'll fix it soon, and keep you updated, as you may have some inode cache
> left.

OK, thanks.


