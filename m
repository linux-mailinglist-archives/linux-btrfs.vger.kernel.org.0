Return-Path: <linux-btrfs+bounces-6978-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E0694752B
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 08:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6782A281487
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 06:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC46913DDB9;
	Mon,  5 Aug 2024 06:21:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962C13A271
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2024 06:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722838867; cv=none; b=h+xBN7R8vyaH/mMTdt/90CS/b7Xp7ClTSMhscdq0CVAeV3vn0HcuKUAJrVPB21Q2iDpKYpAk1v5wUqWYEJKmziaUzQgrD2R38yFQkmejFrVRN0mBTzESgqqMtgFU1hbgmph+ygVmyJbZ7EDZWZn10aeMHu1Rb0fdtl4Z2oo+CYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722838867; c=relaxed/simple;
	bh=1n6uqOWGnTT4C+cDBtqMMxm9ZO5shIv7ayMj3Sdm3sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WqY5ke0sw94MXgqUxJEOv8KXLqh0tJEZeIELFTwPztp/sSEfzfa5oReqcnqa+8mWxCNGhnrijeUshuGL48JWLPlg1usrbA6waqSm/FdeOw5IZ5snxBfwi370NhEr4gfDNh8PNQh3OUS9XVcOgrlSMv2eWLk0m/rPIMHcsE3tRG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=mail.ekdawn.com; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ekdawn.com
Received: from [IPV6:2a02:3038:606:b736:758d:8ef7:b6fa:a299] (unknown [IPv6:2a02:3038:606:b736:758d:8ef7:b6fa:a299])
	by mail.ekdawn.com (Postfix) with ESMTPSA id 6FE13180689;
	Mon,  5 Aug 2024 06:21:01 +0000 (UTC)
Message-ID: <7d692229-d3d5-4b82-a70a-b7371c8724f0@horse64.org>
Date: Mon, 5 Aug 2024 08:20:55 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs corruption issue on Pine64 PinePhone
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <9b4f0e79-6e77-48a4-b87d-b27454ffb399@horse64.org>
 <b9103729-c51a-487f-8360-e49d3e9fc5e4@horse64.org>
 <e53fdb4e-bbb2-4777-b822-f1173dfed3db@gmx.com>
Content-Language: en-US
From: ellie <el@horse64.org>
In-Reply-To: <e53fdb4e-bbb2-4777-b822-f1173dfed3db@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/5/24 08:10, Qu Wenruo wrote:
> 
> 
> 在 2024/8/5 15:25, ellie 写道:
>> On 8/5/24 07:39, ellie wrote:
>>> Dear kernel list,
>>>
>>> I'm hoping this is the right place to sent this. But there seems to be
>>> a btrfs corruption issue on the Pine64 PinePhone:
>>>
>>> https://gitlab.com/postmarketOS/pmaports/-/issues/3058
>>>
>>> The kernel is 6.9.10, I wouldn't know what exact additional patches
>>> may be used by postmarketOS (which is based on Alpine). The device is
>>> the PinePhone revision 1.2a or newer https://wiki.pine64.org/wiki/
>>> PinePhone#Hardware_revisions sadly there doesn't seem to be a way to
>>> check in software if it's 1.2a or 1.2b, and I don't remember which it 
>>> is.
>>>
>>> This is on an SD Card, so an inherently rather unreliable storage
>>> medium. However, I tried two cards from what I believe to be two
>>> different vendors, Lexar and SanDisk, and I'm seeing this with both.
>>>
>>> The PinePhone had various chipset instability issues before, like
>>> https://gitlab.com/postmarketOS/pmaports/-/issues/805 which I believe
>>> has however been fixed since. I have no idea if that's relevant, I'm
>>> just pointing it out. I also don't know if other filesystems, like
>>> ext4 that I used before, might have also had corruption and just
>>> didn't detect it. Not that I ever noticed anything, but I'm not sure I
>>> necessarily ever would have.
> 
> In the detailed report in pmOS issue, you mentioned it's a video file.
> 
> I'm wondering if all the corruptions you see are from video files,
> especially if the video files are all recorded on the file.
> 
> If that's the case, it may be related to the IO pattern, especially if
> the recording tool is using direct IO and didn't have proper writeback
> wait for those direct IO.
> 
> Thanks,
> Qu
> 

Thanks so much for the quick input!

All the files I mentioned in bug reports were written by syncthing, so 
there wasn't any on-device video recording involved. I once saw Nheko's 
database file corrupt however, so it's apparently not limited to 
syncthing. I'm guessing video files are affected so often simply due to 
their large size.

Regards,

Ellie

